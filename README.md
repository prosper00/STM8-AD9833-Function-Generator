# STM8-AD9833-Function-Generator
A library and simple project for the STM8 processor, controlling an AD9833 Waveform generator

### Requirements:
- sdcc - I used version 4.0
- stm8flash - https://github.com/vdudouyt/stm8flash
- Edit the Makefile so that it can find SDCC (and its libs) and stm8flash. If you installed them into your system path, no changes should be needed
- I developed this using an STM8S103F3 'bluepill'/'minimum development board'. It should be possible to modify this for use on other STM8 boards fairly easily
- I'm using the hardware SPI pins on the STM8: 'C6' is the MOSI, and connects to the AD9833 'DAT' pin. 'C5' is the CLK pin, and connects to the AD9833 'CLK' pin. A3 is the CS pin, and connects to the AD9833 'FNC' pin.
- I'm reading a pot on pin D2 (pot middle pin to D2, and the outer pins to Vcc and GND respectively), which will be used to control the frequency

### Note
This is compiled against a modified version of STMicro's SPL library. Library has been modified for compatibility with SDCC, and has been altered to use inlined functions becasue SDCC can't otherwise trim out unused functions. This saves a ton of flash space (see https://github.com/MightyPork/stm8s_inline_spl). This should compile against the 'full' SPL as well, though I haven't tested it, and it's possible that such a version wouldn't fit into 8K of flash.

### Usage
#include AD9833.h in your project. It's up to you to setup hardware SPI before using this library (see the SPI_Config() in 'main.c'). Functions provided:
#### AD9833_Init(void);
  Initializes the AD9833 module to default values. Should be done on powerup.
#### AD9833_SetFreq(float frequency);
  Programs the desired output frequency. 
#### AD9833_SetPhase(float phase);
  Programs the desired phase (to 0.1 degrees)
#### AD9833_SetMode(mode);
  Programs the waveshape. Can choose from SINE, TRIANGLE, or SQUARE
#### AD9833_Reset(bool reset);
  Sets the Reset bit - recommend to run AD9833_Reset(1), then change one (or more parameters), then call AD9833(0), so as to prevent odd garbage from being produced while programming your settings

### Advanced
the AD9833 is programmed via SPI. Each programming 'frame' is 16 bits long. The first few bits of each frame are the address of the register that you're writing to, and the remaining bits are the 'data' bits that your're sending.
The AD9833_WriteReg function has been provided to handle the transmission of data to the module. The function takes a single argument, the name of the register being written. The name definitions are found in an enum in the ad9833_reg.h file. Before calling this function, you must ensure that the data you want to send has been written into the global register array, AD_REG_VAL. This array is indexed by the same enum as the WriteReg function. So, a typical call would be in two parts:  set the value of the register: AD_REG_VAL[AD_REG_CTL] = <some data>; AD9833_WriteReg(AD_REG_CTL);
You can use WriteReg in conjunction with the datasheet to send pretty much any command to the module. 
  There is no way to read the current register values from the AD9833, so, it's important to always update the global AD_REG_VAL variable so that you have a local version of the data that you can use to lookup the current settings (should you ever need to).
  
There are 5 registers in total: 
- a Control register that's used for device initialization, sleep mode, waveshape selection, and other device control functions. See the datasheet.
- two frequency registers, used to program the desired output frequency.
- two phase registers, used to program the phase characteristics of the output signal

Additionally, each of the bits within the Control register has been mapped out in another enum. The names of each of the bits correspond to the names used in the datasheet.
