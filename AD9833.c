#include "stm8s.h"
#include "AD9833.h"
#include "AD9833_reg.h"

void AD9833_WriteReg(uint8_t reg)
{
	uint8_t addr=AD_REG_ADDRESS[reg];

	///append the register address, and break the data into bytes:
	uint8_t byte0 = (uint8_t)( (addr|(uint8_t)(AD_REG_VAL[reg] >>8)));
	uint8_t byte1 = (uint8_t)AD_REG_VAL[reg];
	
//	printf("\n\rRegVal: "BYTE_TO_BINARY_PATTERN" "BYTE_TO_BINARY_PATTERN,BYTE_TO_BINARY(AD_REG_VAL[reg]>>8), BYTE_TO_BINARY(AD_REG_VAL[reg]));

	while(SPI_GetFlagStatus(SPI_FLAG_BSY));  //check to ensure SPI is ready before we begin.
	GPIO_WriteLow(GPIOA, GPIO_PIN_3);
    
	SPI_SendData(byte0);
	while(!SPI_GetFlagStatus(SPI_FLAG_TXE)); //wait until the buffer is empty before we add another byte to it
	SPI_SendData(byte1);

	while(SPI_GetFlagStatus(SPI_FLAG_BSY));  //wait until SPI has finished transmitting before we release CS.
	GPIO_WriteHigh(GPIOA, GPIO_PIN_3);

/*
    printf("\n\rWriteReg Byte 0:" BYTE_TO_BINARY_PATTERN, BYTE_TO_BINARY(byte0));
    printf(": 0x%x",byte0);    
    printf("\n\rWriteReg Byte 1:" BYTE_TO_BINARY_PATTERN, BYTE_TO_BINARY(byte1));
    printf(": 0x%x\r\n",byte1);
*/
}

void AD9833_Init(void)
{
//	printf("\n\r\tSTM8 FuncGen Initializing\n\r");
    
    //Set 'reset' bit and B28 bit
	BITS_SET(AD_REG_VAL[AD_REG_CTL],(BIT(AD_CTL_RESET) | BIT(AD_CTL_B28)));
	AD9833_WriteReg(AD_REG_CTL);
}

void AD9833_Reset(bool reset)
{
	reset==1?BIT_SET(AD_REG_VAL[AD_REG_CTL],AD_CTL_RESET):\
			 BIT_RST(AD_REG_VAL[AD_REG_CTL],AD_CTL_RESET);
	AD9833_WriteReg(AD_REG_CTL);
}


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

void AD9833_SetPhase(float phase)
{
	AD_REG_VAL[AD_REG_PHASE0] = calcPhase(phase);
	AD9833_WriteReg(AD_REG_PHASE0);
}

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
		case SQUARE2   : //SQUARE2 : OPBITEN=1, MODE=0, DIV2=0
			BIT_SET(AD_REG_VAL[AD_REG_CTL],AD_CTL_OPBITEN);
			BITS_RST(AD_REG_VAL[AD_REG_CTL],(BIT(AD_CTL_MODE)|BIT(AD_CTL_DIV2)));
			break;
		case SQUARE  : //SQUARE : OPBITEN=1, MODE=0, DIV2=1
   			BITS_SET(AD_REG_VAL[AD_REG_CTL],(BIT(AD_CTL_OPBITEN)|BIT(AD_CTL_DIV2)));
			BIT_RST(AD_REG_VAL[AD_REG_CTL],AD_REG_CTL);
			break;
	}
	AD9833_WriteReg(AD_REG_CTL);
}
uint8_t AD9833_GetMode(void)
{
	if(AD_REG_VAL[AD_REG_CTL]&&(!BIT(AD_CTL_MODE)|!BIT(AD_CTL_OPBITEN)))
		return SINE;
	if(AD_REG_VAL[AD_REG_CTL]&&(BIT(AD_CTL_MODE)|!BIT(AD_CTL_OPBITEN)))
		return TRIANGLE;
	if(AD_REG_VAL[AD_REG_CTL]&&(!BIT(AD_CTL_MODE)|BIT(AD_CTL_OPBITEN)))
		return SQUARE;
	return 0xFF; //this should never happen
}
