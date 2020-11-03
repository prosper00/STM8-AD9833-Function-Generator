/* 
 * delay utilite for STM8 family
 * COSMIC and SDCC
 * Terentiev Oleg
 * t.oleg@ymail.com
 */

#ifndef _UTIL_DELAY_H_
#define _UTIL_DELAY_H_ 1

#define F_CPU 16000000UL

#ifndef F_CPU
#warning F_CPU is not defined!
#endif

/* 
 * Func delayed N cycles, where N = 3 + ( ticks * 3 )
 * so, ticks = ( N - 3 ) / 3, minimum delay is 6 CLK
 * when tick = 1, because 0 equels 65535
 */

static inline void _delay_cycl( uint16_t __ticks )
{
  #define T_COUNT(x) (( F_CPU * x / 1000000UL )-5)/5)
	__asm__("nop\n nop\n"); 
	do { 		// ASM: ldw X, #tick; lab$: decw X; tnzw X; jrne lab$
                __ticks--;//      2c;                 1c;     2c    ; 1/2c   
        } while ( __ticks );
	__asm__("nop\n");
}

static inline void delay_us( uint16_t __us )
{
	_delay_cycl( (uint16_t)( T_COUNT(__us) );
}

static inline void delay_ms( uint16_t __ms )
{
	while ( __ms-- )
	{
		delay_us( 1000 );
	}
}

#endif

