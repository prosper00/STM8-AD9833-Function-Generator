/**
  ******************************************************************************
  * FuncGen - A function generator based on the AD9833, controlled by an STM8
  *
  * @author  Brad Roy
  * @version V1.1dev Rotary Encoder support
  * @date    04-Dec-2020
  *****************************************************************************/ 
#define F_CPU 16000000UL

/* Includes ------------------------------------------------------------------*/
#include "stm8s.h"
#include "AD9833.h"
#include "main.h"
#include "delay.h"
#include "HD44780.h"
#include <stdio.h> // ouch. this costs about 2k flash for one printf()

void main(void)
{                                                  
	Setup();  //call our init routines
	
	//Variable setup and initialization
	uint8_t Current_mode = SINE;
	int32_t CurrentFreq=1000, NewFreq=1000;        
	
	while (1)	//Loop forever
	{                                                
		//Poll for recent frequency input from the user
		NewFreq += enc_read();
		if (NewFreq < 0) NewFreq = 0; //bounds check (lower)
		if (NewFreq >10000000) NewFreq = 10000000; //bounds check (upper)
		
		//Update the programmed output frequency and display (if it's changed)
		if (NewFreq!=CurrentFreq){	// if our (requested) frequency value has changed from current
			CurrentFreq=NewFreq;	// increase/decrease current frequency according to input
			LCD_Set_Cursor(2,7);
			printf("%7lu",CurrentFreq); 
			AD9833_SetFreq((float)CurrentFreq);
		}//if (NewFreq!=CurrentFreq){

		//Check for mode button presses, and update programmed output mode & display if needed
		if(encoder_btn_event){		// Check if the mode button was pressed
			encoder_btn_event=0;
			Current_mode++;
			if(Current_mode>=3)	Current_mode=SINE; //bounds check
			LCD_Set_Cursor(1,7);
			printf("%s",modes[Current_mode]); 
			AD9833_SetMode(Current_mode);
		}//if (encoder_btn_event){
	}//while (1)
}//main (void)

/*********************************************************************** 
 * void Setup(void) - arduino-like Setup() routine to declutter main()
 **********************************************************************/
static void Setup(void)
{
	
	//Initialize peripherals and libraries
	CLK_Config();
	TIM4_Config();
	GPIO_Config();
	SPI_Config();
	AD9833_Init();
	LCD_Begin();
	
	enableInterrupts();
	
	//Set output defaults
	AD9833_SetFreq(1000);
	AD9833_SetPhase(0);
	AD9833_SetMode(SINE);
	AD9833_Reset(0);
	LCD_Clear();
	LCD_Set_Cursor(2,1);
	printf("Freq:"); 
	LCD_Set_Cursor(2,7);
	printf("%7u",1000);
	LCD_Set_Cursor(1,1);
	printf("Mode: SINE");
}//static void Setup(void)

/*********************************************************************** 
 * void CLK_Config - Configures the CPU clock to the HSI oscillator, 
 * prescaler DIV1 (16MHz)
 **********************************************************************/
static void CLK_Config(void)
{
	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1); //Set CPU to 16MHz
}//static void CLK_Config(void)

/*********************************************************************** 
 * void ADC_Config - Enables, Configures and starts the ADC1 peripheral
 **********************************************************************
static void ADC_Config(void)
{
	//pin mode D2 - input, floating, no interrupt:
	GPIO_Init(POTPIN, GPIO_MODE_IN_FL_NO_IT);
  
	//load ADC1 default registers
	ADC1_DeInit();
  
	//per the datasheet, PortD2 is AIN3
	ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS,
			  POTCH,
			  ADC1_PRESSEL_FCPU_D6, //2.67MHz ADC CLK (<4MHz is optimal)
			  ADC1_EXTTRIG_TIM,
			  DISABLE,
			  ADC1_ALIGN_RIGHT,
			  ADC1_SCHMITTTRIG_CHANNEL3,
			  DISABLE);

	ADC1_StartConversion();
}//static void ADC_Config(void)*/

/*********************************************************************** 
 * void UART1_Config - Enables, Configures and starts the UART1 peripheral
 **********************************************************************
static void UART1_Config(void)  //SDCC can't prune out dead code, so we'll comment this out
{
	UART1_DeInit();
	UART1_Init(115200,  UART1_WORDLENGTH_8D,  UART1_STOPBITS_1,  UART1_PARITY_NO,  UART1_SYNCMODE_CLOCK_DISABLE,  UART1_MODE_TXRX_ENABLE);
}//static void UART1_Config(void) */

/*********************************************************************** 
 * void SPI_Config - Enables, Configures and starts the SPI peripheral
 **********************************************************************/
static void SPI_Config(void)
{
	SPI_DeInit();
	SPI_Init(SPI_FIRSTBIT_MSB,        //datasheet : "MSBFIRST"
			 SPI_BAUDRATEPRESCALER_16, //datasheet : "Up to 40MHz sck"
			 SPI_MODE_MASTER,
			 SPI_CLOCKPOLARITY_HIGH,  //datasheet : "SCK idles high between write operations (CPOL=1)"
			 SPI_CLOCKPHASE_1EDGE,    //datasheet : "Data is valid on the SCK falling edge (CPHA=0)"
			 SPI_DATADIRECTION_1LINE_TX,
			 SPI_NSS_SOFT,            //use software SS pin
			 0x00);
	SPI_Cmd(ENABLE);
}//static void SPI_Config(void)

/*********************************************************************** 
 * void GPIO_Config - Enables and Configures the GPIO pins we need, as well
 * as enables interrupts for those inputs
 **********************************************************************/
void GPIO_Config(void)
{
	GPIO_DeInit(GPIOD);
	GPIO_Init(TICK_PIN,GPIO_MODE_OUT_PP_LOW_FAST);//initialize a pin to output a 2kHz systick
	GPIO_Init(SPISS, GPIO_MODE_OUT_PP_HIGH_FAST); //our SPI SS pin as an output

	GPIO_Init(ENCODER_BTN,GPIO_MODE_IN_PU_IT);  //trigger interrupt on button press
	GPIO_Init(ENCODER_1,GPIO_MODE_IN_FL_NO_IT); //no interrupt on rotation - polling only
	GPIO_Init(ENCODER_2,GPIO_MODE_IN_FL_NO_IT);

	disableInterrupts();
	//configure interrupt for our encoder button (which is on port d)
	EXTI_SetExtIntSensitivity(EXTI_PORT_GPIOD, EXTI_SENSITIVITY_FALL_ONLY);
	//EXTI_SetTLISensitivity(EXTI_TLISENSITIVITY_FALL_ONLY);
	enableInterrupts();
	
}//void GPIO_Config(void)

/*********************************************************************** 
 * uint32_t ReadPot - reads the ADC, oversamples and filters the results, and
 * returns a value between 0 and 16.7M on a logarithmic scale
 **********************************************************************
uint32_t ReadPot(void)
{
	uint32_t PotVal = 0;
	//Oversampling, and filtering/averaging ADC readings
	for(int i=1;i<=1024;i++){          //take 1024 readings from the ADC and average them
		PotVal+=(uint32_t)(ADC1_GetConversionValue());
		while(!(ADC1_GetFlagStatus(ADC1_FLAG_EOC))); //wait for the next reading to complete
	}
	PotVal>>=8;  // divide by 256, range~0-4096 (effectively a +2bit oversample)
	PotVal*=PotVal; // Square it: gives an exponential response, range ~0-16.7M
	
	return PotVal;
}//uint32_t ReadPot(void)
*/

/*********************************************************************** 
 * int enc_read(void) - Reads rotation from the encoder
 * 
 * Called as frequently as possible from main loop. Will poll the encoder
 * each call, and then calculate the number of increment registered every
 * POLLRATE ms. Velocity can be determined by the number of increments
 * detected every POLLRATE
 * 
 * Calculates velocity, and returns a delta value scaled according to velocity
 * return value range from -32785 to +32785 where 0 means no movement detected
 **********************************************************************/
int enc_read(void) {
	int Delta = 0;
	
	unsigned int encoder1 = (!GPIO_ReadInputPin(ENCODER_1)) ; 
	unsigned int encoder2 = (!GPIO_ReadInputPin(ENCODER_2)) ; 

//debounce by state analysis - ignore any inputs that are not in a valid sequence
//i.e if there are multiple transitions of encoder1, while encoder2 stays the same
//see doc/ReadingEncoderSwitches.pdf
//this could use some additional optimization. Once a condition is met
//no need to continue evaluating for other conditions.
	if(encoder2_past == encoder2){
		if((encoder2 == 1) && (encoder1_past < encoder1)) direction++; 
		if((encoder2 == 1) && (encoder1_past > encoder1)) direction--;
		if((encoder2 == 0) && (encoder1_past > encoder1)) direction++; 
		if((encoder2 == 0) && (encoder1_past < encoder1)) direction--;
	} 
	if((encoder2_past < encoder2) && ((encoder1_past | encoder1) == 0)) direction++; 
	if((encoder2_past < encoder2) && ((encoder1_past | encoder1) == 1)) direction--;
	if((encoder2_past > encoder2) && ((encoder1_past | encoder1) == 1)) direction++; 
	if((encoder2_past > encoder2) && ((encoder1_past | encoder1) == 0)) direction--;
	
	encoder2_past = encoder2;
	encoder1_past = encoder1;
	 
//acceleration/velocity scaling
	#define POLLRATE 100
	if((millis() - encoder_polled) > POLLRATE){
		encoder_polled = millis();
		Delta=direction/2; 
		direction=0;
	}//if((millis() - encoder_polled) > POLLRATE){
return Delta*Delta*Delta*Delta*Delta; 
}//int enc_read(void) {

/*********************************************************************** 
 * int putchar(int) - Directs printf() output to the LCD. 
 * Depends on stdio.h
 **********************************************************************/
int putchar(int c)
{
	LCD_Print_Char(c);
  //UART1_SendData8(c);
  //while(UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET);
	return (c);
}//int putchar(int c)

/*********************************************************************** 
 * int getchar(int) - Determines where scanf() characters come from
 * Depends on stdio.h
 **********************************************************************/
/*int getchar(void)
{
  int c = 0;
  while(UART1_GetFlagStatus(UART1_FLAG_RXNE)==RESET);
    c = UART1_ReceiveData8();
  return (c);
}*/

/*********************************************************************** 
 * ISR - interrupt handler for port interrupts (GPIO)
 * Determines which pin on the port triggered the interrupt
 * and assignes it to a global variable.
 * 
 * This is probably gonna depend on hardware debouncing
 **********************************************************************/
INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
{
//	if (!GPIO_ReadInputPin(ENCODER_BTN)) //no need to check the pin if it's the only one configured for interrupts
	encoder_btn_event=1;
		
}//INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
