#include "eeprom.h"
/***********************************************************************
 * Library courtesy of luiji:
 * https://github.com/lujji/stm8-bare-min
 * 
 * Adapted by Brad Roy
 ***********************************************************************/
 
void eeprom_write(uint16_t addr, uint8_t *buf, uint16_t len) {
    /* unlock EEPROM */
    FLASH_DUKR = FLASH_DUKR_KEY1;
    FLASH_DUKR = FLASH_DUKR_KEY2;
    
    while (!(FLASH_IAPSR & (1 << 3)));
    /* write data from buffer */
    for (uint16_t i = 0; i < len; i++, addr++) {
        _MEM_(addr) = buf[i];
        while (!(FLASH_IAPSR & (1 << 2)));
    }
    
    /* lock EEPROM */
    FLASH_IAPSR &= ~(1 << 3);
}

void eeprom_read(uint16_t addr, uint8_t *buf, uint16_t len) {
    /* read EEPROM data into buffer */
    for (int i = 0; i < len; i++, addr++)
        buf[i] = _MEM_(addr);
}
