/**
  ******************************************************************************
  * AD9833.c - STM8 library to control an AD9833 function generator module.
  * 
  * Requirements:
  * 
  * 1. User must set up SPI peripheral before using this library
  *    Example:
  * 	SPI_Init(SPI_FIRSTBIT_MSB,        //datasheet : "MSBFIRST"
  *           SPI_BAUDRATEPRESCALER_2, //datasheet : "Up to 40MHz sck"
  *           SPI_MODE_MASTER,
  *           SPI_CLOCKPOLARITY_HIGH,  //datasheet : "SCK idles high between write operations (CPOL=1)"
  *           SPI_CLOCKPHASE_1EDGE,    //datasheet : "Data is valid on the SCK falling edge (CPHA=0)"
  *           SPI_DATADIRECTION_1LINE_TX,
  *           SPI_NSS_SOFT,            //use software SS pin
  *           (uint8_t) 0x00);
  * 
  * 2. #define SPISS with the pin used as slave select (FSYNC on AD9833)
  * 
  * @author  Brad Roy
  * @version V1.0 All major functions implemented and working.
  * @date    04-Dec-2020
  * @site    https://github.com/prosper00/STM8-AD9833-Function-Generator
  *****************************************************************************/ 
#include "stm8s.h"
#include "AD9833.h"
#include "AD9833_reg.h"

#define SPISS GPIOA, GPIO_PIN_3   //our slave select pin

/************************************************************************
* void AD9833_Init(void);
* Initializes the AD9833 module to default values. Should be done on powerup.
***********************************************************************/
void AD9833_Init(void)
{
    //Set 'reset' bit and B28 bit
	BITS_SET(AD_REG_VAL[AD_REG_CTL],(BIT(AD_CTL_RESET) | BIT(AD_CTL_B28)));
	AD9833_WriteReg(AD_REG_CTL);
}

/************************************************************************
* void AD9833_Reset(bool reset);
* Sets the Reset bit - recommend to run AD9833_Reset(1), then change one 
* (or more) parameters, then call AD9833_Reset(0), so as to prevent odd 
* garbage from being produced while programming your settings
***********************************************************************/
void AD9833_Reset(bool reset)
{
	reset==1?BIT_SET(AD_REG_VAL[AD_REG_CTL],AD_CTL_RESET):\
			 BIT_RST(AD_REG_VAL[AD_REG_CTL],AD_CTL_RESET);
	AD9833_WriteReg(AD_REG_CTL);
}

/************************************************************************
* void AD9833_SetFreq(float frequency);
* Programs the desired output frequency.
***********************************************************************/
void AD9833_SetFreq(float frequency)
{
	uint32_t freqreg = calcFreq(frequency);
	
	/* If the user wants to change the entire contents of a frequency register, 
	 * two consecutive writes to the same address must be performed because the 
	 * frequency registers are 28 bits wide. The first write contains   
	 * the 14 LSBs, and the second write contains the 14 MSBs. For this mode 
	 * of operation, the B28 (D13) control bit should be set to 1.
	 */
	//Set the register with the LSB's
	AD_REG_VAL[AD_REG_FREQ0] = (uint16_t)(freqreg & 0x3FFF);
	AD9833_WriteReg(AD_REG_FREQ0);
	
	//Set the register with the MSB's
	AD_REG_VAL[AD_REG_FREQ0] = (uint16_t)((freqreg>>14)&0x3FFF); 
	AD9833_WriteReg(AD_REG_FREQ0);
}

/************************************************************************
* void AD9833_SetPhase(float phase);
* Programs the desired phase (to 0.1 degrees)
***********************************************************************/
void AD9833_SetPhase(float phase)
{
	AD_REG_VAL[AD_REG_PHASE0] = calcPhase(phase);
	AD9833_WriteReg(AD_REG_PHASE0);
}

/************************************************************************
* void AD9833_SetMode(uint8_t mode);
* Programs the waveshape. Can choose from SINE, TRIANGLE, or SQUARE
***********************************************************************/
void AD9833_SetMode(uint8_t mode)
{
	switch(mode){
		case SINE     : //SIN : OPBITEN=0, MODE=0, DIV2=x
			BITS_RST(AD_REG_VAL[AD_REG_CTL], (BIT(AD_CTL_MODE)|BIT(AD_CTL_OPBITEN)));
			break;
		case TRIANGLE : //TRIANGLE : OPBITEN=0, MODE=1, DIV2=x
			BIT_SET(AD_REG_VAL[AD_REG_CTL],AD_CTL_MODE);
			BIT_RST(AD_REG_VAL[AD_REG_CTL],AD_CTL_OPBITEN);
			break;
		case SQUARE   : //SQUARE : OPBITEN=1, MODE=0, DIV2=1
   			BITS_SET(AD_REG_VAL[AD_REG_CTL],(BIT(AD_CTL_OPBITEN)|BIT(AD_CTL_DIV2)));
			BIT_RST(AD_REG_VAL[AD_REG_CTL],AD_CTL_MODE);
			break;
		case SQUARE2   : //SQUARE2 : OPBITEN=1, MODE=0, DIV2=0
			BIT_SET(AD_REG_VAL[AD_REG_CTL],AD_CTL_OPBITEN);
			BITS_RST(AD_REG_VAL[AD_REG_CTL],(BIT(AD_CTL_MODE)|BIT(AD_CTL_DIV2)));
			break;
	}
	AD9833_WriteReg(AD_REG_CTL);
}

/***********************************************************************
 void AD9833_WriteReg (uint8_t reg) 
 * this function handles the transmission of data to the module. 
 * The function takes a single argument, the name of the register being written. 
 * (The name definitions are found in an enum in the ad9833_reg.h file.)
 * Before calling this function, you must ensure that the data you want 
 * to send has been written into the global register array, AD_REG_VAL. 
 * This array is indexed by the same enum as the WriteReg function. 
 * So, a typical call would be in two parts: 
 * 		set the value of the register: AD_REG_VAL[AD_REG_CTL] = <some data>; 
 * 		AD9833_WriteReg(AD_REG_CTL); 
 * You can use WriteReg in conjunction with the datasheet to send pretty 
 * much any command to the module. 
 * 
 * There is no way to read the current register values from the AD9833, 
 * so it's important to always update the global AD_REG_VAL variable to 
 * have a local version of the data that you can use to lookup the current 
 * settings (should you ever need to).
 *
 * There are 5 registers in total:
 * 
 *	a Control register that's used for device initialization, sleep mode,
 *  	waveshape selection, and other device control functions. See the datasheet.
 * 	two frequency registers, used to program the desired output frequency.
 * 	two phase registers, used to program the phase characteristics of the output signal
 * 
 * Additionally, each of the bits within the Control register has been 
 * mapped out in another enum. The names of each of the bits correspond 
 * to the names used in the datasheet.
 ***********************************************************************/
void AD9833_WriteReg(uint8_t reg)
{
	uint8_t addr=AD_REG_ADDRESS[reg];

	///append the register address, and break the data into bytes:
	uint8_t byte0 = (uint8_t)( (addr|(uint8_t)(AD_REG_VAL[reg] >>8)));
	uint8_t byte1 = (uint8_t)AD_REG_VAL[reg];
	
	//	printf("\n\rRegVal: "BYTE_TO_BINARY_PATTERN" "BYTE_TO_BINARY_PATTERN,BYTE_TO_BINARY(AD_REG_VAL[reg]>>8), BYTE_TO_BINARY(AD_REG_VAL[reg]));

	while(SPI_GetFlagStatus(SPI_FLAG_BSY));  //check to ensure SPI is ready before we begin.
	GPIO_WriteLow(SPISS);
    
	SPI_SendData(byte0);
	while(!SPI_GetFlagStatus(SPI_FLAG_TXE)); //wait until the buffer is empty before we add another byte to it
	SPI_SendData(byte1);

	while(SPI_GetFlagStatus(SPI_FLAG_BSY));  //wait until SPI has finished transmitting before we release CS.
	GPIO_WriteHigh(SPISS);

	/*
    printf("\n\rWriteReg Byte 0:" BYTE_TO_BINARY_PATTERN, BYTE_TO_BINARY(byte0));
    printf(": 0x%x",byte0);    
    printf("\n\rWriteReg Byte 1:" BYTE_TO_BINARY_PATTERN, BYTE_TO_BINARY(byte1));
    printf(": 0x%x\r\n",byte1);
	*/
}
