# STM8-AD9833-Function-Generator
A library and simple project for the STM8 processor, controlling an AD9833 Waveform generator. See the wiki here: https://github.com/prosper00/STM8-AD9833-Function-Generator/wiki

### Implemented:
- AD9833 control library
- HD44780 LCD library
- interrupt-based millisecond delay function
- ADC-read from a potentiometer to set the frequency
- external port interrupts to read buttons: select frequency range and waveshape

### To-Do's
- Op-amp to control amplitude (possibly use a peak detector and an ADC to display Vpp?)
- Kicad drawings
- PWM mode? (would need another control for duty cycle adjust)
- Finish documentation and wiki pages

### Requirements:
- sdcc - I used version 4.0
- stm8flash - https://github.com/vdudouyt/stm8flash
- stm8 binutils - https://stm8-binutils-gdb.sourceforge.io/
- Edit the Makefile so that it can find SDCC (and its libs) and stm8flash. If you installed them into your system path, no changes should be needed
- I developed this using an STM8S103F3 'bluepill'/'minimum development board'. It should be possible to modify this for use on other STM8 boards fairly easily
- I'm using the hardware SPI pins on the STM8: 'C6' is the MOSI, and connects to the AD9833 'DAT' pin. 'C5' is the CLK pin, and connects to the AD9833 'CLK' pin. A3 is the CS pin, and connects to the AD9833 'FNC' pin.
- I'm reading a pot on pin D2 (pot middle pin to D2, and the outer pins to Vcc and GND respectively), which will be used to control the frequency
- Other than stm8flash and SDCC, everything you need to compile should be included. Do a 'git clone,' and then 'make' to compile and 'make flash' to compile and flash your board

### Hardware Map:
- Connect a potentiometer to pin D2
- Two momentary switches (to ground) to pins D4 and D6
- HD44780 16x2 LCD:
 'D7': C4
 'D6': C3
 'D5': B4 (10k pullup to Vcc)
 'D4': B5 (10k pullup to Vcc)
 'EN': A2
 'RS': A1
- AD9833 module:
 'FNC': A3
 'DAT': C6
 'CLK': C7
- Bridge/Connect STM8 'bluepill' pins '5V' to '3.3V', to run on 5V. (unless you're using a 3v3 LCD)

### Note
This is compiled against a modified version of STMicro's SPL library. Library has been modified for compatibility with SDCC, and has been altered to use inlined functions becasue SDCC can't otherwise trim out unused functions. This saves a ton of flash space (see https://github.com/MightyPork/stm8s_inline_spl). This should compile against the 'full' SPL as well, though I haven't tested it, and it's likely that such a version wouldn't fit into 8K of flash.

Currently, this library only supports one 9833 module, although it's feasible to adapt it to support many such modules. This would involve changing from a single global register variable (AD_REG_VAL) to several (or, an array), and enhancing each of the functions to accept an additional argument specifying which module to use.

There are a bunch of possible configurations of the AD9833 that I don't fully understand, or rather, can't imagine a use case for, and as such, aren't supported directly. And example is the FSELECT register: there are two registers which can each hold a frequency value, and a control register bit that specifies which frequency register to use. This could be used to switch back and forth between two different output frequencies - but - I don't understand why I would need to do that, or why that's more desirable than just updating the frequency register that I'm already using. However, this library should be easily extensible to send any concievable combination of commands to the module.

### Library Usage
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
  Sets the Reset bit - recommend to run AD9833_Reset(1), then change one (or more) parameters, then call AD9833_Reset(0), so as to prevent odd garbage from being produced while programming your settings

### Advanced
the AD9833 is programmed via SPI. Each programming 'frame' is 16 bits long. The first few bits of each frame are the address of the register that you're writing to, and the remaining bits are the 'data' bits that your're sending.
The AD9833_WriteReg function has been provided to handle the transmission of data to the module. The function takes a single argument, the name of the register being written. The name definitions are found in an enum in the ad9833_reg.h file. Before calling this function, you must ensure that the data you want to send has been written into the global register array, AD_REG_VAL. This array is indexed by the same enum as the WriteReg function. So, a typical call would be in two parts:  set the value of the register: AD_REG_VAL[AD_REG_CTL] = \<some data\>; AD9833_WriteReg(AD_REG_CTL);
You can use WriteReg in conjunction with the datasheet to send pretty much any command to the module. 
  There is no way to read the current register values from the AD9833, so, it's important to always update the global AD_REG_VAL variable so that you have a local version of the data that you can use to lookup the current settings (should you ever need to).
  
There are 5 registers in total: 
- a Control register that's used for device initialization, sleep mode, waveshape selection, and other device control functions. See the datasheet.
- two frequency registers, used to program the desired output frequency.
- two phase registers, used to program the phase characteristics of the output signal

Additionally, each of the bits within the Control register has been mapped out in another enum. The names of each of the bits correspond to the names used in the datasheet.

### Other platforms
It should be fairly straightforward to adapt this library to work with other platforms. The only platform specific function in the library itself is the call to the SPI routines in AD9833_WriteReg function. All other platform specific intialization is done in the example 'main.c' and kept out of the library.
