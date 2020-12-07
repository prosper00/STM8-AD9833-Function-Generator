/**
  ******************************************************************************
  * FuncGen - A function generator based on the AD9833, controlled by an STM8
  *
  * @author  Brad Roy
  * @version V1.0 All major functions implemented and working.
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
	//Initialize peripherals and libraries
	CLK_Config();
	ADC_Config();
	SPI_Config();
	TIM4_Config();
	GPIO_Config();
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
	LCD_Set_Cursor(1,1);
	printf("Mode: SQUARE");
	
	//Variable setup and initialization
	uint8_t current_mode = SINE;
	int8_t current_range = 0;
	uint32_t FreqVal=0;        //the range-adjusted frequency setting
	uint32_t PotVal=0;         //our raw ADC reading from the potentiometer

	//Loop forever
	while (1)
	{                                                
		PotVal=ReadPot();            // Poll our frequency potentiometer
		PotVal>>=(16-current_range); // Reduce the range by 2^n
		
		if( (PotVal>(FreqVal)) || (PotVal<(FreqVal)) ){  //if it's changed since last time
			FreqVal=PotVal;                              //then set the new frequency
			LCD_Set_Cursor(2,7);
			printf("%7ld",FreqVal); 
			AD9833_SetFreq((float)FreqVal);
		}
		
		if(range_btn_event){            //Check if our 'range' button has been pressed
			range_btn_event=0;
			current_range+=2;
			if(current_range>=14)
				current_range=0;
			LCD_Set_Cursor(2,15);
			printf("%2d",current_range);
		}
		
		if(mode_btn_event){                   //Check if the mode button was pressed
			mode_btn_event=0;
			current_mode++;
			if(current_mode>=3)
				current_mode=SINE;
			AD9833_SetMode(current_mode);
			LCD_Set_Cursor(1,7);
			printf("%s",modes[current_mode]); 
		}
	}
}

/*********************************************************************** 
 * uint32_t ReadPot - reads the ADC, oversamples and filters the results, and
 * returns a value between 0 and 16.7M on a logarithmic scale
 **********************************************************************/
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
}

/*********************************************************************** 
 * void CLK_Config - Configures the CPU clock to the HSI oscillator, 
 * prescaler DIV1 (16MHz)
 **********************************************************************/
static void CLK_Config(void)
{
	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1); //Set CPU to 16MHz
}

/*********************************************************************** 
 * void ADC_Config - Enables, Configures and starts the ADC1 peripheral
 **********************************************************************/
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
}

/*********************************************************************** 
 * void UART1_Config - Enables, Configures and starts the UART1 peripheral
 **********************************************************************/
static void UART1_Config(void)  //SDCC can't prune out dead code, so we'll comment this out
{
/*	UART1_DeInit();
	UART1_Init(115200,  UART1_WORDLENGTH_8D,  UART1_STOPBITS_1,  UART1_PARITY_NO,  UART1_SYNCMODE_CLOCK_DISABLE,  UART1_MODE_TXRX_ENABLE);*/
}

/*********************************************************************** 
 * void SPI_Config - Enables, Configures and starts the SPI peripheral
 **********************************************************************/
static void SPI_Config(void)
{
	SPI_DeInit();
	SPI_Init(SPI_FIRSTBIT_MSB,        //datasheet : "MSBFIRST"
			 SPI_BAUDRATEPRESCALER_2, //datasheet : "Up to 40MHz sck"
			 SPI_MODE_MASTER,
			 SPI_CLOCKPOLARITY_HIGH,  //datasheet : "SCK idles high between write operations (CPOL=1)"
			 SPI_CLOCKPHASE_1EDGE,    //datasheet : "Data is valid on the SCK falling edge (CPHA=0)"
			 SPI_DATADIRECTION_1LINE_TX,
			 SPI_NSS_SOFT,            //use software SS pin
			 (uint8_t) 0x00);
	SPI_Cmd(ENABLE);
}

/*********************************************************************** 
 * void GPIO_Config - Enables and Configures the GPIO pins we need, as well
 * as enables interrupts for those inputs
 **********************************************************************/
void GPIO_Config(void)
{
	GPIO_Init(MODE_BTN,GPIO_MODE_IN_PU_IT);       //our buttons as inputs
	GPIO_Init(RANGE_BTN,GPIO_MODE_IN_PU_IT);
	GPIO_Init(SPISS, GPIO_MODE_OUT_PP_HIGH_FAST); //our SPI SS pin as an output

	EXTI_SetExtIntSensitivity(EXTI_PORT_GPIOD, EXTI_SENSITIVITY_FALL_ONLY);
	EXTI_SetTLISensitivity(EXTI_TLISENSITIVITY_FALL_ONLY);
}

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
}

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
 **********************************************************************/
INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
{
	if (!GPIO_ReadInputPin(MODE_BTN))
		mode_btn_event=1;
	if (!GPIO_ReadInputPin(RANGE_BTN))
		range_btn_event=1;
}
