# STM8-AD9833-Function-Generator
A library and simple project for the STM8 processor, controlling an AD9833 Waveform generator. See the wiki here: https://github.com/prosper00/STM8-AD9833-Function-Generator/wiki

![Prototype](20210122_142009.jpg?raw=true "Prototype")


Schematic diagram is here: https://github.com/prosper00/STM8-AD9833-Function-Generator/blob/main/doc/Function%20Generator/Function%20Generator.pdf
(Kicad source files are in /doc)

### Implemented:
- AD9833 control library
- HD44780 LCD library
- interrupt-based general-purpose interrupt-driven delay functions (millis, micros, delay_ms, delay_us);
- ADC-read from a potentiometer to set the frequency
- external port interrupts to read buttons: select frequency range and waveshape

### To-Do's
- Op-amp to control amplitude (possibly use a peak detector and an ADC to display Vpp?) [in progress]
- PWM mode? (would need another control for duty cycle adjust)
- Finish documentation and wiki pages
- PWM output on PA3

### Requirements:
- sdcc - I used version 4.0.7
- stm8flash - https://github.com/vdudouyt/stm8flash
- stm8 binutils - https://stm8-binutils-gdb.sourceforge.io/
- Edit the Makefile so that it can find SDCC (and its libs) and stm8flash. If you installed them into your system path, no changes should be needed
- I developed this using an STM8S103F3 'bluepill'/'minimum development board'. It should be possible to modify this for use on other STM8 boards fairly easily
- Other than stm8flash and SDCC, everything you need to compile should be included. Do a 'git clone,' and then 'make' to compile and 'make flash' to compile and flash your board

### Hardware:
 - I used an STM8S103F3 breakout board, like these: https://www.ebay.com/sch/i.html?_from=R40&_nkw=stm8s103f3&_sacat=0&_sop=15
 - 5V 16x2 HD44780 character LCD
 - 10k pot * 2 (to set frequency and v(offset))
 - 100k pot (for gain adjustment)
 - 5k trim pot (for LCD contrast)
 - 2 x tactile pushbutton switches
 - CJMCU AD9833 breakout board
 - miscellaneous resistors and capacitors
 - +5V and +/-15V power supplies
 - LT1364 or AD826 operational amplifier
 - see schematic in /doc for details

### Hardware Map:
- see schematic here: https://github.com/prosper00/STM8-AD9833-Function-Generator/blob/main/doc/Function%20Generator/Function%20Generator.pdf

### Note
This is compiled against a modified version of STMicro's SPL library. Library has been modified for compatibility with SDCC, and has been altered to use inlined functions becasue SDCC can't otherwise trim out unused functions. This saves a ton of flash space (see https://github.com/MightyPork/stm8s_inline_spl). This should compile against the 'full' SPL as well, though I haven't tested it, and it's likely that such a version wouldn't fit into 8K of flash.

Currently, this library only supports one 9833 module, although it's feasible to adapt it to support many such modules. This would involve changing from a single global register variable (AD_REG_VAL) to several (or, an array), and enhancing each of the functions to accept an additional argument specifying which module to use.

There are a bunch of possible configurations of the AD9833 that I don't fully understand, or rather, can't imagine a use case for, and as such, aren't supported directly. And example is the FSELECT register: there are two registers which can each hold a frequency value, and a control register bit that specifies which frequency register to use. This could be used to switch back and forth between two different output frequencies - but - I don't understand why I would need to do that, or why that's more desirable than just updating the frequency register that I'm already using. However, this library should be easily extensible to send any concievable combination of commands to the module.


