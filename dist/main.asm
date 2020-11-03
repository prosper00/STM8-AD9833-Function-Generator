;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.0.4 #11922 (Linux)
;--------------------------------------------------------
	.module main
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _AD9833_Reset
	.globl _AD9833_SetMode
	.globl _AD9833_SetPhase
	.globl _AD9833_SetFreq
	.globl _AD9833_Init
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
;--------------------------------------------------------
; Stack segment in internal ram 
;--------------------------------------------------------
	.area	SSEG
__start__stack:
	.ds	1

;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area DABS (ABS)

; default segment ordering for linker
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area CONST
	.area INITIALIZER
	.area CODE

;--------------------------------------------------------
; interrupt vector 
;--------------------------------------------------------
	.area HOME
__interrupt_vect:
	int s_GSINIT ; reset
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area GSINIT
__sdcc_init_data:
; stm8_genXINIT() start
	ldw x, #l_DATA
	jreq	00002$
00001$:
	clr (s_DATA - 1, x)
	decw x
	jrne	00001$
00002$:
	ldw	x, #l_INITIALIZER
	jreq	00004$
00003$:
	ld	a, (s_INITIALIZER - 1, x)
	ld	(s_INITIALIZED - 1, x), a
	decw	x
	jrne	00003$
00004$:
; stm8_genXINIT() end
	.area GSFINAL
	jp	__sdcc_program_startup
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME
	.area HOME
__sdcc_program_startup:
	jp	_main
;	return from main will return to caller
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CODE
;	./delay.h: 23: static inline void _delay_cycl( uint16_t __ticks )
;	-----------------------------------------
;	 function _delay_cycl
;	-----------------------------------------
__delay_cycl:
;	./delay.h: 26: __asm__("nop\n nop\n"); 
	nop
	nop
;	./delay.h: 27: do { 		// ASM: ldw X, #tick; lab$: decw X; tnzw X; jrne lab$
	ldw	x, (0x03, sp)
00101$:
;	./delay.h: 28: __ticks--;//      2c;                 1c;     2c    ; 1/2c   
	decw	x
;	./delay.h: 29: } while ( __ticks );
	tnzw	x
	jrne	00101$
;	./delay.h: 30: __asm__("nop\n");
	nop
;	./delay.h: 31: }
	ret
;	./delay.h: 33: static inline void delay_us( uint16_t __us )
;	-----------------------------------------
;	 function delay_us
;	-----------------------------------------
_delay_us:
;	./delay.h: 35: _delay_cycl( (uint16_t)( T_COUNT(__us) );
	ldw	y, (0x03, sp)
	clrw	x
	pushw	y
	pushw	x
	push	#0x00
	push	#0x24
	push	#0xf4
	push	#0x00
	call	__mullong
	addw	sp, #8
	push	#0x40
	push	#0x42
	push	#0x0f
	push	#0x00
	pushw	x
	pushw	y
	call	__divulong
	addw	sp, #8
	subw	x, #0x0005
	jrnc	00118$
	decw	y
00118$:
	push	#0x05
	push	#0x00
	push	#0x00
	push	#0x00
	pushw	x
	pushw	y
	call	__divulong
	addw	sp, #8
;	./delay.h: 26: __asm__("nop\n nop\n"); 
	nop
	nop
;	./delay.h: 27: do { 		// ASM: ldw X, #tick; lab$: decw X; tnzw X; jrne lab$
00101$:
;	./delay.h: 28: __ticks--;//      2c;                 1c;     2c    ; 1/2c   
	decw	x
;	./delay.h: 29: } while ( __ticks );
	tnzw	x
	jrne	00101$
;	./delay.h: 30: __asm__("nop\n");
	nop
;	./delay.h: 35: _delay_cycl( (uint16_t)( T_COUNT(__us) );
;	./delay.h: 36: }
	ret
;	./delay.h: 38: static inline void delay_ms( uint16_t __ms )
;	-----------------------------------------
;	 function delay_ms
;	-----------------------------------------
_delay_ms:
	pushw	x
;	./delay.h: 40: while ( __ms-- )
	ldw	y, (0x05, sp)
	ldw	(0x01, sp), y
00101$:
	ldw	x, (0x01, sp)
	ldw	y, (0x01, sp)
	decw	y
	ldw	(0x01, sp), y
	tnzw	x
	jreq	00109$
;	./delay.h: 26: __asm__("nop\n nop\n"); 
	nop
	nop
;	./delay.h: 27: do { 		// ASM: ldw X, #tick; lab$: decw X; tnzw X; jrne lab$
	ldw	x, #0x026e
00104$:
;	./delay.h: 28: __ticks--;//      2c;                 1c;     2c    ; 1/2c   
	decw	x
;	./delay.h: 29: } while ( __ticks );
	tnzw	x
	jrne	00104$
;	./delay.h: 30: __asm__("nop\n");
	nop
;	./delay.h: 42: delay_us( 1000 );
	jra	00101$
00109$:
;	./delay.h: 44: }
	popw	x
	ret
;	main.c: 16: void main(void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
	pushw	x
;	main.c: 18: CLK_Config();
	call	_CLK_Config
;	main.c: 19: ADC_Config();
	call	_ADC_Config
;	main.c: 21: SPI_Config();
	call	_SPI_Config
;	main.c: 22: AD9833_Init();
	call	_AD9833_Init
;	main.c: 23: AD9833_SetFreq(100000);
	push	#0x00
	push	#0x50
	push	#0xc3
	push	#0x47
	call	_AD9833_SetFreq
	addw	sp, #4
;	main.c: 24: AD9833_SetPhase(0);
	clrw	x
	pushw	x
	clrw	x
	pushw	x
	call	_AD9833_SetPhase
	addw	sp, #4
;	main.c: 25: AD9833_Reset(0);
	push	#0x00
	call	_AD9833_Reset
	pop	a
;	./delay.h: 40: while ( __ms-- )
00131$:
	ldw	x, #0x2710
	ldw	(0x01, sp), x
00104$:
	ldw	x, (0x01, sp)
	ldw	y, (0x01, sp)
	decw	y
	ldw	(0x01, sp), y
	tnzw	x
	jreq	00112$
;	./delay.h: 26: __asm__("nop\n nop\n"); 
	nop
	nop
;	./delay.h: 27: do { 		// ASM: ldw X, #tick; lab$: decw X; tnzw X; jrne lab$
	ldw	x, #0x026e
00105$:
;	./delay.h: 28: __ticks--;//      2c;                 1c;     2c    ; 1/2c   
	decw	x
;	./delay.h: 29: } while ( __ticks );
	tnzw	x
	jrne	00105$
;	./delay.h: 30: __asm__("nop\n");
	nop
;	./delay.h: 42: delay_us( 1000 );
	jra	00104$
;	main.c: 30: delay_ms(10000);
00112$:
;	main.c: 31: AD9833_Reset(1);
	push	#0x01
	call	_AD9833_Reset
	pop	a
;	main.c: 32: AD9833_SetFreq(100000);
	push	#0x00
	push	#0x50
	push	#0xc3
	push	#0x47
	call	_AD9833_SetFreq
	addw	sp, #4
;	main.c: 33: AD9833_SetMode(TRIANGLE);
	push	#0x01
	call	_AD9833_SetMode
	pop	a
;	main.c: 34: AD9833_Reset(0);
	push	#0x00
	call	_AD9833_Reset
	pop	a
;	./delay.h: 40: while ( __ms-- )
	ldw	x, #0x2710
	ldw	(0x01, sp), x
00113$:
	ldw	x, (0x01, sp)
	ldw	y, (0x01, sp)
	decw	y
	ldw	(0x01, sp), y
	tnzw	x
	jreq	00121$
;	./delay.h: 26: __asm__("nop\n nop\n"); 
	nop
	nop
;	./delay.h: 27: do { 		// ASM: ldw X, #tick; lab$: decw X; tnzw X; jrne lab$
	ldw	x, #0x026e
00114$:
;	./delay.h: 28: __ticks--;//      2c;                 1c;     2c    ; 1/2c   
	decw	x
;	./delay.h: 29: } while ( __ticks );
	tnzw	x
	jrne	00114$
;	./delay.h: 30: __asm__("nop\n");
	nop
;	./delay.h: 42: delay_us( 1000 );
	jra	00113$
;	main.c: 35: delay_ms(10000);
00121$:
;	main.c: 36: AD9833_Reset(1);
	push	#0x01
	call	_AD9833_Reset
	pop	a
;	main.c: 37: AD9833_SetFreq(100000);
	push	#0x00
	push	#0x50
	push	#0xc3
	push	#0x47
	call	_AD9833_SetFreq
	addw	sp, #4
;	main.c: 38: AD9833_SetMode(SINE);
	push	#0x00
	call	_AD9833_SetMode
	pop	a
;	main.c: 39: AD9833_Reset(0);   
	push	#0x00
	call	_AD9833_Reset
	pop	a
;	main.c: 41: int PotVal=ADC1_GetConversionValue();
	ld	a, 0x5402
	bcp	a, #0x08
	jreq	00123$
	ld	a, 0x5405
	ld	a, 0x5404
	jp	00131$
00123$:
	ld	a, 0x5404
	ld	a, 0x5405
	jp	00131$
;	main.c: 43: }
	popw	x
	ret
;	main.c: 45: static void CLK_Config(void)
;	-----------------------------------------
;	 function CLK_Config
;	-----------------------------------------
_CLK_Config:
;	inc/stm8s_clk.h: 741: CLK->CKDIVR &= (uint8_t) (~CLK_CKDIVR_HSIDIV);
	ld	a, 0x50c6
	and	a, #0xe7
	ld	0x50c6, a
;	inc/stm8s_clk.h: 744: CLK->CKDIVR |= (uint8_t) HSIPrescaler;
	ld	a, 0x50c6
	ld	0x50c6, a
;	inc/stm8s_clk.h: 823: CLK->CKDIVR &= (uint8_t) (~CLK_CKDIVR_HSIDIV);
	ld	a, 0x50c6
	and	a, #0xe7
	ld	0x50c6, a
;	inc/stm8s_clk.h: 824: CLK->CKDIVR |= (uint8_t) ((uint8_t) CLK_Prescaler & (uint8_t) CLK_CKDIVR_HSIDIV);
	ld	a, 0x50c6
	ld	0x50c6, a
;	inc/stm8s_clk.h: 664: clock_master = (CLK_Source_TypeDef) CLK->CMSR;
	ld	a, 0x50c3
	ld	yl, a
;	inc/stm8s_clk.h: 669: CLK->SWCR |= CLK_SWCR_SWEN;
	bset	20677, #1
;	inc/stm8s_clk.h: 675: CLK->SWCR &= (uint8_t) (~CLK_SWCR_SWIEN);
	bres	20677, #2
;	inc/stm8s_clk.h: 679: CLK->SWR = (uint8_t) CLK_NewClock;
	mov	0x50c4+0, #0xe1
;	inc/stm8s_clk.h: 682: while ((((CLK->SWCR & CLK_SWCR_SWBSY) != 0) && (DownCounter != 0))) {
	clrw	x
	decw	x
00110$:
	ld	a, 0x50c5
	srl	a
	jrnc	00112$
	tnzw	x
	jreq	00112$
;	inc/stm8s_clk.h: 683: DownCounter--;
	decw	x
	jra	00110$
00112$:
;	inc/stm8s_clk.h: 686: if (DownCounter != 0) {
	tnzw	x
	jrne	00195$
	ret
00195$:
;	inc/stm8s_clk.h: 718: if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && (clock_master == CLK_SOURCE_HSI)) {
	ld	a, yl
	cp	a, #0xe1
	jrne	00138$
;	inc/stm8s_clk.h: 719: CLK->ICKR &= (uint8_t) (~CLK_ICKR_HSIEN);
	bres	20672, #0
	ret
00138$:
;	inc/stm8s_clk.h: 720: } else if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && (clock_master == CLK_SOURCE_LSI)) {
	ld	a, yl
	cp	a, #0xd2
	jrne	00136$
;	inc/stm8s_clk.h: 721: CLK->ICKR &= (uint8_t) (~CLK_ICKR_LSIEN);
	bres	20672, #3
	ret
00136$:
;	inc/stm8s_clk.h: 722: } else if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && (clock_master == CLK_SOURCE_HSE)) {
	ld	a, yl
	cp	a, #0xb4
	jreq	00204$
	ret
00204$:
;	inc/stm8s_clk.h: 723: CLK->ECKR &= (uint8_t) (~CLK_ECKR_HSEEN);
	bres	20673, #0
;	main.c: 51: CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE, CLK_CURRENTCLOCKSTATE_DISABLE);
;	main.c: 52: }
	ret
;	main.c: 54: static void ADC_Config(void)
;	-----------------------------------------
;	 function ADC_Config
;	-----------------------------------------
_ADC_Config:
;	inc/stm8s_gpio.h: 212: GPIOx->CR2 &= (uint8_t) (~(GPIO_Pin));
	bres	20499, #2
;	inc/stm8s_gpio.h: 232: GPIOx->DDR &= (uint8_t) (~(GPIO_Pin));
	bres	20497, #2
;	inc/stm8s_gpio.h: 244: GPIOx->CR1 &= (uint8_t) (~(GPIO_Pin));
	bres	20498, #2
;	inc/stm8s_gpio.h: 256: GPIOx->CR2 &= (uint8_t) (~(GPIO_Pin));
	bres	20499, #2
;	inc/stm8s_adc1.h: 376: ADC1->CSR = ADC1_CSR_RESET_VALUE;
	mov	0x5400+0, #0x00
;	inc/stm8s_adc1.h: 377: ADC1->CR1 = ADC1_CR1_RESET_VALUE;
	mov	0x5401+0, #0x00
;	inc/stm8s_adc1.h: 378: ADC1->CR2 = ADC1_CR2_RESET_VALUE;
	mov	0x5402+0, #0x00
;	inc/stm8s_adc1.h: 379: ADC1->CR3 = ADC1_CR3_RESET_VALUE;
	mov	0x5403+0, #0x00
;	inc/stm8s_adc1.h: 380: ADC1->TDRH = ADC1_TDRH_RESET_VALUE;
	mov	0x5406+0, #0x00
;	inc/stm8s_adc1.h: 381: ADC1->TDRL = ADC1_TDRL_RESET_VALUE;
	mov	0x5407+0, #0x00
;	inc/stm8s_adc1.h: 382: ADC1->HTRH = ADC1_HTRH_RESET_VALUE;
	mov	0x5408+0, #0xff
;	inc/stm8s_adc1.h: 383: ADC1->HTRL = ADC1_HTRL_RESET_VALUE;
	mov	0x5409+0, #0x03
;	inc/stm8s_adc1.h: 384: ADC1->LTRH = ADC1_LTRH_RESET_VALUE;
	mov	0x540a+0, #0x00
;	inc/stm8s_adc1.h: 385: ADC1->LTRL = ADC1_LTRL_RESET_VALUE;
	mov	0x540b+0, #0x00
;	inc/stm8s_adc1.h: 386: ADC1->AWCRH = ADC1_AWCRH_RESET_VALUE;
	mov	0x540e+0, #0x00
;	inc/stm8s_adc1.h: 387: ADC1->AWCRL = ADC1_AWCRL_RESET_VALUE;
	mov	0x540f+0, #0x00
;	inc/stm8s_adc1.h: 408: ADC1->CR2 &= (uint8_t) (~ADC1_CR2_ALIGN);
	bres	21506, #3
;	inc/stm8s_adc1.h: 410: ADC1->CR2 |= (uint8_t) (ADC1_Align);
	bset	21506, #3
;	inc/stm8s_adc1.h: 414: ADC1->CR1 |= ADC1_CR1_CONT;
	bset	21505, #1
;	inc/stm8s_adc1.h: 422: ADC1->CSR &= (uint8_t) (~ADC1_CSR_CH);
	ld	a, 0x5400
	and	a, #0xf0
	ld	0x5400, a
;	inc/stm8s_adc1.h: 424: ADC1->CSR |= (uint8_t) (ADC1_Channel);
	ld	a, 0x5400
	or	a, #0x03
	ld	0x5400, a
;	inc/stm8s_adc1.h: 481: ADC1->CR1 &= (uint8_t) (~ADC1_CR1_SPSEL);
	ld	a, 0x5401
	and	a, #0x8f
	ld	0x5401, a
;	inc/stm8s_adc1.h: 483: ADC1->CR1 |= (uint8_t) (ADC1_Prescaler);
	ld	a, 0x5401
	ld	0x5401, a
;	inc/stm8s_adc1.h: 503: ADC1->CR2 &= (uint8_t) (~ADC1_CR2_EXTSEL);
	ld	a, 0x5402
	and	a, #0xcf
	ld	0x5402, a
;	inc/stm8s_adc1.h: 511: ADC1->CR2 &= (uint8_t) (~ADC1_CR2_EXTTRIG);
	bres	21506, #6
;	inc/stm8s_adc1.h: 515: ADC1->CR2 |= (uint8_t) (ADC1_ExtTrigger);
	ld	a, 0x5402
	ld	0x5402, a
;	inc/stm8s_adc1.h: 455: ADC1->TDRL |= (uint8_t) ((uint8_t) 0x01 << (uint8_t) ADC1_SchmittTriggerChannel);
	bset	21511, #3
;	inc/stm8s_adc1.h: 571: ADC1->CR1 |= ADC1_CR1_ADON;
	bset	21505, #0
;	inc/stm8s_adc1.h: 665: ADC1->CR1 |= ADC1_CR1_ADON;
	bset	21505, #0
;	main.c: 71: ADC1_StartConversion();
;	main.c: 72: }
	ret
;	main.c: 74: static void UART1_Config(void)
;	-----------------------------------------
;	 function UART1_Config
;	-----------------------------------------
_UART1_Config:
;	main.c: 81: }
	ret
;	main.c: 83: static void SPI_Config(void)
;	-----------------------------------------
;	 function SPI_Config
;	-----------------------------------------
_SPI_Config:
;	inc/stm8s_gpio.h: 212: GPIOx->CR2 &= (uint8_t) (~(GPIO_Pin));
	bres	20484, #3
;	inc/stm8s_gpio.h: 222: GPIOx->ODR |= (uint8_t) GPIO_Pin;
	bset	20480, #3
;	inc/stm8s_gpio.h: 228: GPIOx->DDR |= (uint8_t) GPIO_Pin;
	bset	20482, #3
;	inc/stm8s_gpio.h: 241: GPIOx->CR1 |= (uint8_t) GPIO_Pin;
	bset	20483, #3
;	inc/stm8s_gpio.h: 253: GPIOx->CR2 |= (uint8_t) GPIO_Pin;
	bset	20484, #3
;	inc/stm8s_spi.h: 366: SPI->CR1 = SPI_CR1_RESET_VALUE;
	mov	0x5200+0, #0x00
;	inc/stm8s_spi.h: 367: SPI->CR2 = SPI_CR2_RESET_VALUE;
	mov	0x5201+0, #0x00
;	inc/stm8s_spi.h: 368: SPI->ICR = SPI_ICR_RESET_VALUE;
	mov	0x5202+0, #0x00
;	inc/stm8s_spi.h: 369: SPI->SR = SPI_SR_RESET_VALUE;
	mov	0x5203+0, #0x02
;	inc/stm8s_spi.h: 370: SPI->CRCPR = SPI_CRCPR_RESET_VALUE;
	mov	0x5205+0, #0x07
;	inc/stm8s_spi.h: 409: (uint8_t) ((uint8_t) ClockPolarity | ClockPhase));
	mov	0x5200+0, #0x1a
;	inc/stm8s_spi.h: 412: SPI->CR2 = (uint8_t) ((uint8_t) (Data_Direction) | (uint8_t) (Slave_Management));
	mov	0x5201+0, #0xc2
;	inc/stm8s_spi.h: 415: SPI->CR2 |= (uint8_t) SPI_CR2_SSI;
	bset	20993, #0
;	inc/stm8s_spi.h: 421: SPI->CR1 |= (uint8_t) (Mode);
	bset	20992, #2
;	inc/stm8s_spi.h: 424: SPI->CRCPR = (uint8_t) CRCPolynomial;
	mov	0x5205+0, #0x00
;	inc/stm8s_spi.h: 439: SPI->CR1 |= SPI_CR1_SPE; /* Enable the SPI peripheral*/
	bset	20992, #6
;	main.c: 98: SPI_Cmd(ENABLE);
;	main.c: 99: }
	ret
	.area CODE
	.area CONST
_AWU_Init_APR_Array_65536_122:
	.db #0x00	; 0
	.db #0x1e	; 30
	.db #0x1e	; 30
	.db #0x1e	; 30
	.db #0x1e	; 30
	.db #0x1e	; 30
	.db #0x1e	; 30
	.db #0x1e	; 30
	.db #0x1e	; 30
	.db #0x1e	; 30
	.db #0x1e	; 30
	.db #0x1e	; 30
	.db #0x1e	; 30
	.db #0x3d	; 61
	.db #0x17	; 23
	.db #0x17	; 23
	.db #0x3e	; 62
_AWU_Init_TBR_Array_65536_122:
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x05	; 5
	.db #0x06	; 6
	.db #0x07	; 7
	.db #0x08	; 8
	.db #0x09	; 9
	.db #0x0a	; 10
	.db #0x0b	; 11
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0e	; 14
	.db #0x0f	; 15
	.db #0x0f	; 15
	.area INITIALIZER
	.area CABS (ABS)
