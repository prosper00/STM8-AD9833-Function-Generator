# STM8-AD9833-Function-Generator
A library and simple project for the STM8 processor, controlling an AD9833 Waveform generator. See the wiki here: https://github.com/prosper00/STM8-AD9833-Function-Generator/wiki

![Prototype](20210122_142009.jpg?raw=true "Prototype")


Schematic diagram is here: https://github.com/prosper00/STM8-AD9833-Function-Generator/blob/main/doc/Function%20Generator/Function%20Generator.pdf
(Kicad source files are in /doc/Function Generator)

### Implemented:
- AD9833 control library
- HD44780 LCD library
- Created interrupt-driven delay library functions (millis, micros, delay_ms, delay_us);
- ~~ADC - read/filter/oversample/shape input from a potentiometer to set the output frequency~~
- replaced potentiometer/ADC routines with a rotary encoder to set mode and frequency
- external port interrupts to read rotary encoder: select frequency range and waveshape
- Op-amp circuit to control amplitude and offset

### To-Do's
- (Maybe?) implement a peak detector and an ADC to display Vpp/offset on screen
- PWM mode? (would need another control for duty cycle adjust)
- Finish documentation and wiki pages
- PWM output on PA3
- The AD9833 outputs sin and triangle waves at a few hundred mV, but square waves at full Vcc. This makes it difficult to implement a single simple solution for amplification and offset that works well for all modes

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
 - 10k pot (to set v(offset))
 - 100k pot (for gain adjustment)
 - 5-pin rotary encoder w/pushbutton
 - 5k trim pot (for LCD contrast)
 - ~~2 x tactile pushbutton switches~~
 - CJMCU AD9833 breakout board
 - miscellaneous resistors and capacitors
 - +5V and +/-15V power supplies [I used a 5V USB adapter and a +/- dual buck/boost converter]
 - LT1364 or AD826 operational amplifier [These are fast opamps, but, not fast enough to produce full-range amplitude at maximum frequencies. Something with an even greater GBWP and slew rate would be called for, if such a thing could be found for a reasonable price. Alternatively, I could implement gain in multiple stages - this would address bandwidth limitations, but not slew rate limitations. More testing is needed to determine if I'm fighting slew limits or GBW limits, or both]
 - see schematic in /doc/Function Generator for details

### Hardware Map:
- see schematic here: https://github.com/prosper00/STM8-AD9833-Function-Generator/blob/main/doc/Function%20Generator/Function%20Generator.pdf
- see STM8S103F3 pin assignment here: https://github.com/prosper00/STM8-AD9833-Function-Generator/blob/main/doc/STM8-pinouts.ods

|Project Assignment|Number|Name|Analog|Serial|Timer|Other|Type|floating|wpu|ext.i|High sink|speed|OD|PP|Function|AFR remap|
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
|`Encoder D2`|1|PD4| |UART1_CK|TIM2_CH1|BEEP|I/O|X|X|X|HS|O3|X|X|Port D4| |
|`systick`|2|PD5|AIN5|UART1_TX| | |I/O|X|X|X|HS|O3|X|X|Port D5| |
|`Encoder Button`|3|PD6|AIN6|UART1_RX| | |I/O|X|X|X|HS|O3|X|X|Port D6| |
| |4|nRST| | | | |I/O| |X| | | | | |Reset| |
|`LCD_RS`|5|PA1| | | | |I/O|X|X|X| |O1|X|X|Port A1| |
|`LCD_EN`|6|PA2| | | | |I/O|X|X|X| |O1|X|X|Port A2| |
| |7|VSS| | | | |S| | | | | | | |Digital Ground| |
| |8|VCAP| | | | |S| | | | | | | |1.8V Regulator cap| |
| |9|VDD| | | | |S| | | | | | | |Digital Power| |
| |10|PA3| |SPI_NSS|TIM2_CH3| |I/O|X|X|X|HS|O3|X|X|Port A3|SPI MSS [AFR1]|
|**Project Assignment**|**Number**|**Name**|**Analog**|**Serial**|**Timer**|**Other**|**Type**|**floating**|**wpu**|**ext.i**|**High sink**|**speed**|**OD**|**PP**|**Function**|**AFR remap**|
|`LCD_D4`|11|PB5| |I2C_SDA|TIM1_BKIN| |I/O|X| | |X|O1|T| |Port B5|TIM1_BKIN [AFR4]|
|`LCD_D5`|12|PB4| |I2S_SCL| | |I/O|X| | |X|O1|T| |Port B4|ADC_ETR [AFR4]|
|`LCD_D6`|13|PC3| | |TIM1_CH3| |I/O|X|X|X|HS|O3|X|X|Port C3|TLI [AFR3] TIM1_CH1n[AFR7]|
|`LCD_D7`|14|PC4|AIN2| |TIM1_CH4|CLK_CCO|I/O|X|X|X|HS|O3|X|X|Port C4|TIM1_CH2n [AFR7]|
|`SPI_CLK`|15|PC5| |SPI_SCK|TIM2_CH1| |I/O|X|X|X|HS|O3|X|X|Port C5|TIM2_CH1 [AFR0]|
|`SPI_MOSI`|16|PC6| |SPI_MOSI|TIM1_CH1| |I/O|X|X|X|HS|O3|X|X|Port C6|TIM1_CH1 [AFR0]|
|`SS`|17|PC7| |SPI_MISO|TIM1_CH2| |I/O|X|X|X|HS|O3|X|X|Port C7|TIM1_CH2 [AFR0]|
| |18|PD1| | | |SWIM|I/O|X|X|X|HS|O4|X|X|Port D1| |
| |19|PD2|AIN3| |TIM2_CH3| |I/O|X|X|X|HS|O3|X|X|Port D2|TIM2_CH3 [AFR1]|
|`Encoder D1`|20|PD3|AIN4| |TIM2_CH2|ADC_ETR|I/O|X|X|X|HS|O3|X|X|Port D3| |

### Note
This is compiled against a modified version of STMicro's SPL library. Library has been modified for compatibility with SDCC, and has been altered to use inlined functions becasue SDCC can't otherwise trim out unused functions. This saves a ton of flash space (see https://github.com/MightyPork/stm8s_inline_spl). This should compile against the 'full' SPL as well, though I haven't tested it, and it's likely that such a version wouldn't fit into 8K of flash.

Currently, this library only supports one 9833 module, although it's feasible to adapt it to support many such modules. This would involve changing from a single global register variable (AD_REG_VAL) to several (or, an array), and enhancing each of the functions to accept an additional argument specifying which module to use.

There are a bunch of possible configurations of the AD9833 that I don't fully understand, or rather, can't imagine a use case for, and as such, aren't supported directly. And example is the FSELECT register: there are two registers which can each hold a frequency value, and a control register bit that specifies which frequency register to use. This could be used to switch back and forth between two different output frequencies - but - I don't understand why I would need to do that, or why that's more desirable than just updating the frequency register that I'm already using. However, this library should be easily extensible to send any concievable combination of commands to the module.


