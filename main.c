/**
  ******************************************************************************
  * FuncGen - A function generator based on the AD9833, controlled by an STM8
  *
  * @author  Brad Roy
  * @version V0.11 - Frequency selection working, mode selection working, init and reset working
  * @date    02-Nov-2020
  *****************************************************************************/ 

/* Includes ------------------------------------------------------------------*/
#include "stm8s.h"
#include "AD9833.h"
#include "main.h"
#include "delay.h"
#include "HD44780.h"

void main(void)
{                                                  
    CLK_Config();
    ADC_Config();
//    UART1_Config();
    SPI_Config();
    TIM4_Config();
    AD9833_Init();
    AD9833_SetFreq(30000);
    AD9833_SetPhase(0);
    AD9833_Reset(0);

  while (1)
  {                                                

    AD9833_SetMode(TRIANGLE);
    delay_ms(2000);
    
    AD9833_SetMode(SINE);
    delay_ms(2000);
    
    AD9833_SetMode(SQUARE);
    delay_ms(2000);
    
    LCD_Set_Cursor(1,1);
    LCD_Print_String("Mode: SINE");
    LCD_Set_Cursor(2,1);
    LCD_Print_String("Freq: Something?");

    uint32_t PotVal=ADC1_GetConversionValue();
  }
}

static void CLK_Config(void)
{
  CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1); //Set to 16MHz
  //CLK_SYSCLKConfig(CLK_PRESCALER_HSIDIV1);
  /* Configure the system clock to use HSI clock source and to run at 16Mhz */
  //CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE, CLK_CURRENTCLOCKSTATE_DISABLE);
  #define F_CPU 16000000UL
}

static void ADC_Config(void)
{
  //pin mode D2 - input, floating, no interrupt:
  GPIO_Init(POTPIN, GPIO_MODE_IN_FL_NO_IT);
  
  //load ADC1 default registers
  ADC1_DeInit();
  
  //per the datasheet, PortD2 is AIN3
  ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS, POTCH, ADC1_PRESSEL_FCPU_D2,
		    ADC1_EXTTRIG_TIM, DISABLE, ADC1_ALIGN_RIGHT, ADC1_SCHMITTTRIG_CHANNEL3,
		    DISABLE);

  //Start scanning AIN
  ADC1_StartConversion();
}

static void UART1_Config(void)
{
/*	UART1_DeInit();
	UART1_Init(115200,  UART1_WORDLENGTH_8D,  UART1_STOPBITS_1,  UART1_PARITY_NO,  UART1_SYNCMODE_CLOCK_DISABLE,  UART1_MODE_TXRX_ENABLE);
*/
}

static void SPI_Config(void)
{
	//setup SS pin as an output
	//pin mode PA3 - output, pushpull-high, 2MHz
	GPIO_Init(SPISS, GPIO_MODE_OUT_PP_HIGH_FAST);
   
	SPI_DeInit();
	SPI_Init(SPI_FIRSTBIT_MSB,\      //datasheet : "MSBFIRST"
             SPI_BAUDRATEPRESCALER_2,\//datasheet : "Up to 40MHz sck"
             SPI_MODE_MASTER,\
             SPI_CLOCKPOLARITY_HIGH,\  //datasheet : "SCK idles high between write operations (CPOL=1)"
             SPI_CLOCKPHASE_1EDGE,\    //datasheet : "Data is valid on the SCK falling edge (CPHA=0)"
             SPI_DATADIRECTION_1LINE_TX,\
             SPI_NSS_SOFT,\            //use software SS pin
             (uint8_t) 0x00);
    SPI_Cmd(ENABLE);
}

// Needed for printf();

int putchar(int c)
{
  LCD_Print_Char(c);
  //UART1_SendData8(c);
  //while(UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET);
  return (c);
}

/*int getchar(void)
{
  int c = 0;
  while(UART1_GetFlagStatus(UART1_FLAG_RXNE)==RESET);
    c = UART1_ReceiveData8();
  return (c);
}*/
