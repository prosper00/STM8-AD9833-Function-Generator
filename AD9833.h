//file AD9833.h - AD9833 external function declarations

#define DEBUG
#include "stdio.h"

//Initializes to default settings
void AD9833_Init(void);

//Sets the output frequency (in Hz)
void AD9833_SetFreq(float frequency);

//Sets the output phase, to the tenth of a degree
void AD9833_SetPhase(float phase);

//Sets the output wave shape
void AD9833_SetMode(uint8_t mode);

//Sets/unsets the Reset register. 'reset==1' means to reset, reset==0 releases reset
void AD9833_Reset(bool reset);


//Output waveshapes
enum AD_MODES{
	SINE,
	TRIANGLE,
	SQUARE,
	SQUARE2
};

//debug stuff
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
