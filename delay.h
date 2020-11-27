#ifndef DELAY_H
#define DELAY_H

#ifndef F_CPU
#warning "F_CPU not defined, using 16MHz by default"
#define F_CPU 16000000UL
#endif

//#include <stdint.h>

inline void delay_us(uint32_t us) {
    for (uint32_t i = 0; i < ((F_CPU / 18 / 1000000UL) * us); i++) {
        __asm__("nop");
    }
}

inline void delay_ms(uint32_t ms) {
     delay_us(1000 * ms);
}

#endif /* DELAY_H */
