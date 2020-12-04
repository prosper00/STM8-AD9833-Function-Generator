/**
  ******************************************************************************
  * AD9833.h - STM8 library to control an AD9833 function generator module.
  * 
  * #include this header in your main project file
  * 
  * @author  Brad Roy
  * @version V1.0 All major functions implemented and working.
  * @date    04-Dec-2020
  * @site    https://github.com/prosper00/STM8-AD9833-Function-Generator
  *****************************************************************************/

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
	SINE,     //==0
	TRIANGLE, //==1
	SQUARE,   //==2
	SQUARE2 //Square at 1/2 of the base frequency
};
