#ifndef EEPROM_H
#define EEPROM_H
#include <stdint.h>

/***********************************************************************
 * Library courtesy of luiji:
 * https://github.com/lujji/stm8-bare-min
 * 
 * Adapted by Brad Roy
 * Register definitions are for the STM8s103f3. Others will require 
 * validating or updating against the datasheet
 ***********************************************************************/

/*Macros*/
	#define _MEM_(mem_addr)	(*(volatile uint8_t *)(mem_addr))
	#define _SFR_(mem_addr)	(*(volatile uint8_t *)(0x5000 + (mem_addr)))

/*Register definitions */
	#define EEPROM_START_ADDR	0x4000
	#define EEPROM_END_ADDR		0x427F
	#define FLASH_CR1		_SFR_(0x5a)     // Flash control 1
	#define FLASH_CR2		_SFR_(0x5b)     // Flash control 2
	#define FLASH_NCR2		_SFR_(0x5c)     // Flash control 2 complement
	#define FLASH_FPR		_SFR_(0x5d)     // Flash protection
	#define FLASH_NFPR		_SFR_(0x5e)     // Flash protection complement
	#define FLASH_IAPSR		_SFR_(0x5f)     // Flash control 1
	#define FLASH_PUKR		_SFR_(0x62)     // Flash in-application program status
	#define FLASH_DUKR		_SFR_(0x64)     // Data EEPROM unprotect
	#define FLASH_DUKR_KEY1	0xae
	#define FLASH_DUKR_KEY2	0x56

/*function definitions*/
	void eeprom_write(uint16_t addr, uint8_t *buf, uint16_t len);
	void eeprom_read(uint16_t addr, uint8_t *buf, uint16_t len);

#endif //EEPROM_H
