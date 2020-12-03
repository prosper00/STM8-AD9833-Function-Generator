//file AD9833.h - AD9833 external function declarations

//Initializes to default settings
void AD9833_Init(void);

//Sets the output frequency (in Hz)
void AD9833_SetFreq(float frequency);

//Sets the output phase, to the tenth of a degree
void AD9833_SetPhase(float phase);

//Sets the output wave shape
void AD9833_SetMode(uint8_t mode);

//returns the last-set mode
uint8_t AD9833_GetMode(void);

//Sets/unsets the Reset register. 'reset==1' means to reset, reset==0 releases reset
void AD9833_Reset(bool reset);


//Output waveshapes
enum AD_MODES{
	SINE,
	TRIANGLE,
	SQUARE,
	SQUARE2 //Square at 1/2 of the base frequency
};

//debug stuff
//		e.g. a 16-bit printf();
//			printf("\n\rRegVal: "BYTE_TO_BINARY_PATTERN" "BYTE_TO_BINARY_PATTERN,BYTE_TO_BINARY(AD_REG_VAL[reg]>>8), BYTE_TO_BINARY(AD_REG_VAL[reg]));
#define BYTE_TO_BINARY_PATTERN "%c%c%c%c%c%c%c%c"
#define BYTE_TO_BINARY(byte)  \
  (byte & 0x80 ? '1' : '0'), \
  (byte & 0x40 ? '1' : '0'), \
  (byte & 0x20 ? '1' : '0'), \
  (byte & 0x10 ? '1' : '0'), \
  (byte & 0x08 ? '1' : '0'), \
  (byte & 0x04 ? '1' : '0'), \
  (byte & 0x02 ? '1' : '0'), \
  (byte & 0x01 ? '1' : '0') 
