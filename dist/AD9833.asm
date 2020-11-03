;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.0.4 #11922 (Linux)
;--------------------------------------------------------
	.module AD9833
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _AD_REG_VAL
	.globl _AD_REG_ADDRESS
	.globl _AD9833_WriteReg
	.globl _AD9833_Init
	.globl _AD9833_Reset
	.globl _AD9833_SetFreq
	.globl _AD9833_SetPhase
	.globl _AD9833_SetMode
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
_AD_REG_ADDRESS::
	.ds 5
_AD_REG_VAL::
	.ds 10
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
; global & static initialisations
;--------------------------------------------------------
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME
	.area HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CODE
;	./AD9833_reg.h: 12: static inline uint16_t calcPhase(float phase){return (uint16_t)((512.0 * (phase/10) / 45) + 0.5);}
;	-----------------------------------------
;	 function calcPhase
;	-----------------------------------------
_calcPhase:
	clrw	x
	pushw	x
	push	#0x20
	push	#0x41
	ldw	x, (0x09, sp)
	pushw	x
	ldw	x, (0x09, sp)
	pushw	x
	call	___fsdiv
	addw	sp, #8
	pushw	x
	pushw	y
	clrw	x
	pushw	x
	push	#0x00
	push	#0x44
	call	___fsmul
	addw	sp, #8
	push	#0x00
	push	#0x00
	push	#0x34
	push	#0x42
	pushw	x
	pushw	y
	call	___fsdiv
	addw	sp, #8
	push	#0x00
	push	#0x00
	push	#0x00
	push	#0x3f
	pushw	x
	pushw	y
	call	___fsadd
	addw	sp, #8
	pushw	x
	pushw	y
	call	___fs2uint
	addw	sp, #4
	ret
;	./AD9833_reg.h: 14: static inline uint32_t calcFreq(float freq){return (uint32_t)((freq * (1UL << 28)/AD_MCLK) + 0.5);}
;	-----------------------------------------
;	 function calcFreq
;	-----------------------------------------
_calcFreq:
	ldw	x, (0x05, sp)
	pushw	x
	ldw	x, (0x05, sp)
	pushw	x
	clrw	x
	pushw	x
	push	#0x80
	push	#0x4d
	call	___fsmul
	addw	sp, #8
	push	#0x20
	push	#0xbc
	push	#0xbe
	push	#0x4b
	pushw	x
	pushw	y
	call	___fsdiv
	addw	sp, #8
	push	#0x00
	push	#0x00
	push	#0x00
	push	#0x3f
	pushw	x
	pushw	y
	call	___fsadd
	addw	sp, #8
	pushw	x
	pushw	y
	call	___fs2ulong
	addw	sp, #4
	ret
;	AD9833.c: 5: void AD9833_WriteReg(uint8_t reg)
;	-----------------------------------------
;	 function AD9833_WriteReg
;	-----------------------------------------
_AD9833_WriteReg:
	sub	sp, #3
;	AD9833.c: 7: uint8_t addr=AD_REG_ADDRESS[reg];
	clrw	x
	ld	a, (0x06, sp)
	ld	xl, a
	ld	a, (_AD_REG_ADDRESS, x)
	ld	(0x01, sp), a
;	AD9833.c: 10: uint8_t byte0 = (uint8_t)( (addr|(uint8_t)(AD_REG_VAL[reg] >>8)));
	ld	a, (0x06, sp)
	clrw	x
	ld	xl, a
	sllw	x
	addw	x, #(_AD_REG_VAL + 0)
	ldw	x, (x)
	ld	a, xh
	clr	(0x02, sp)
	or	a, (0x01, sp)
	ld	(0x03, sp), a
;	AD9833.c: 11: uint8_t byte1 = (uint8_t)AD_REG_VAL[reg];
	ldw	y, x
;	AD9833.c: 15: while(SPI_GetFlagStatus(SPI_FLAG_BSY));  //check to ensure SPI is ready before we begin.
00101$:
;	inc/stm8s_spi.h: 613: if ((SPI->SR & (uint8_t) SPI_FLAG) != (uint8_t) RESET) {
	ld	a, 0x5203
	jrmi	00101$
;	inc/stm8s_gpio.h: 296: GPIOx->ODR &= (uint8_t) (~PortPins);
	bres	20480, #3
;	inc/stm8s_spi.h: 476: SPI->DR = Data; /* Write in the DR register the data to be sent*/
	ldw	x, #0x5204
	ld	a, (0x03, sp)
	ld	(x), a
;	AD9833.c: 19: while(!SPI_GetFlagStatus(SPI_FLAG_TXE)); //wait until the buffer is empty before we add another byte to it
00104$:
;	inc/stm8s_spi.h: 613: if ((SPI->SR & (uint8_t) SPI_FLAG) != (uint8_t) RESET) {
	ld	a, 0x5203
	bcp	a, #0x02
	jreq	00104$
;	inc/stm8s_spi.h: 476: SPI->DR = Data; /* Write in the DR register the data to be sent*/
	ldw	x, #0x5204
	ld	a, yl
	ld	(x), a
;	AD9833.c: 22: while(SPI_GetFlagStatus(SPI_FLAG_BSY));  //wait until SPI has finished transmitting before we release CS.
00107$:
;	inc/stm8s_spi.h: 613: if ((SPI->SR & (uint8_t) SPI_FLAG) != (uint8_t) RESET) {
	ld	a, 0x5203
	jrmi	00107$
;	inc/stm8s_gpio.h: 283: GPIOx->ODR |= (uint8_t) PortPins;
	bset	20480, #3
;	AD9833.c: 23: GPIO_WriteHigh(GPIOA, GPIO_PIN_3);
;	AD9833.c: 31: }
	addw	sp, #3
	ret
;	AD9833.c: 33: void AD9833_Init(void)
;	-----------------------------------------
;	 function AD9833_Init
;	-----------------------------------------
_AD9833_Init:
;	AD9833.c: 38: BITS_SET(AD_REG_VAL[AD_REG_CTL],(BIT(AD_CTL_RESET) | BIT(AD_CTL_B28)));
	ldw	x, _AD_REG_VAL+0
	ld	a, xh
	or	a, #0x21
	ld	xh, a
	ldw	_AD_REG_VAL+0, x
;	AD9833.c: 39: AD9833_WriteReg(AD_REG_CTL);
	push	#0x00
	call	_AD9833_WriteReg
	pop	a
;	AD9833.c: 40: }
	ret
;	AD9833.c: 42: void AD9833_Reset(bool reset)
;	-----------------------------------------
;	 function AD9833_Reset
;	-----------------------------------------
_AD9833_Reset:
;	AD9833.c: 44: reset==1?BIT_SET(AD_REG_VAL[AD_REG_CTL],AD_CTL_RESET):\
	ld	a, (0x03, sp)
	dec	a
	jrne	00103$
	ldw	x, _AD_REG_VAL+0
	ld	a, xh
	or	a, #0x01
	ld	xh, a
	ldw	_AD_REG_VAL+0, x
	jra	00104$
00103$:
	ldw	x, _AD_REG_VAL+0
	ld	a, xh
	and	a, #0xfe
	ld	xh, a
	ldw	_AD_REG_VAL+0, x
00104$:
;	AD9833.c: 46: AD9833_WriteReg(AD_REG_CTL);
	push	#0x00
	call	_AD9833_WriteReg
	pop	a
;	AD9833.c: 47: }
	ret
;	AD9833.c: 50: void AD9833_SetFreq(float frequency)
;	-----------------------------------------
;	 function AD9833_SetFreq
;	-----------------------------------------
_AD9833_SetFreq:
	sub	sp, #4
;	AD9833.c: 54: uint32_t freqreg = calcFreq(frequency);
	ldw	x, (0x09, sp)
	ldw	y, (0x07, sp)
	pushw	x
	pushw	y
	clrw	x
	pushw	x
	push	#0x80
	push	#0x4d
	call	___fsmul
	addw	sp, #8
	push	#0x20
	push	#0xbc
	push	#0xbe
	push	#0x4b
	pushw	x
	pushw	y
	call	___fsdiv
	addw	sp, #8
	push	#0x00
	push	#0x00
	push	#0x00
	push	#0x3f
	pushw	x
	pushw	y
	call	___fsadd
	addw	sp, #8
	pushw	x
	pushw	y
	call	___fs2ulong
	addw	sp, #4
	ldw	(0x01, sp), y
;	AD9833.c: 63: AD_REG_VAL[AD_REG_FREQ0] = (uint16_t)(freqreg & 0x3FFF);
	ldw	y, x
	ld	a, xh
	and	a, #0x3f
	ld	yh, a
	ldw	_AD_REG_VAL+2, y
;	AD9833.c: 64: AD9833_WriteReg(AD_REG_FREQ0);
	pushw	x
	push	#0x01
	call	_AD9833_WriteReg
	pop	a
	popw	x
;	AD9833.c: 67: AD_REG_VAL[AD_REG_FREQ0] = (uint16_t)((freqreg>>14)&0x3FFF); 
	ldw	y, (0x01, sp)
	ld	a, #0x0e
00104$:
	srlw	y
	rrcw	x
	dec	a
	jrne	00104$
	ld	a, xh
	and	a, #0x3f
	ld	xh, a
	ldw	_AD_REG_VAL+2, x
;	AD9833.c: 68: AD9833_WriteReg(AD_REG_FREQ0);
	push	#0x01
	call	_AD9833_WriteReg
;	AD9833.c: 69: }
	addw	sp, #5
	ret
;	AD9833.c: 71: void AD9833_SetPhase(float phase)
;	-----------------------------------------
;	 function AD9833_SetPhase
;	-----------------------------------------
_AD9833_SetPhase:
;	AD9833.c: 73: AD_REG_VAL[AD_REG_PHASE0] = calcPhase(phase);
	ldw	x, (0x05, sp)
	ldw	y, (0x03, sp)
;	./AD9833_reg.h: 12: static inline uint16_t calcPhase(float phase){return (uint16_t)((512.0 * (phase/10) / 45) + 0.5);}
	push	#0x00
	push	#0x00
	push	#0x20
	push	#0x41
	pushw	x
	pushw	y
	call	___fsdiv
	addw	sp, #8
	pushw	x
	pushw	y
	clrw	x
	pushw	x
	push	#0x00
	push	#0x44
	call	___fsmul
	addw	sp, #8
	push	#0x00
	push	#0x00
	push	#0x34
	push	#0x42
	pushw	x
	pushw	y
	call	___fsdiv
	addw	sp, #8
	push	#0x00
	push	#0x00
	push	#0x00
	push	#0x3f
	pushw	x
	pushw	y
	call	___fsadd
	addw	sp, #8
	pushw	x
	pushw	y
	call	___fs2uint
	addw	sp, #4
;	AD9833.c: 73: AD_REG_VAL[AD_REG_PHASE0] = calcPhase(phase);
	ldw	_AD_REG_VAL+6, x
;	AD9833.c: 74: AD9833_WriteReg(AD_REG_PHASE0);
	push	#0x03
	call	_AD9833_WriteReg
	pop	a
;	AD9833.c: 75: }
	ret
;	AD9833.c: 77: void AD9833_SetMode(uint8_t mode)
;	-----------------------------------------
;	 function AD9833_SetMode
;	-----------------------------------------
_AD9833_SetMode:
;	AD9833.c: 79: switch(mode){
	ld	a, (0x03, sp)
	cp	a, #0x00
	jreq	00101$
	ld	a, (0x03, sp)
	dec	a
	jreq	00102$
	ld	a, (0x03, sp)
	cp	a, #0x02
	jreq	00103$
	ld	a, (0x03, sp)
	cp	a, #0x03
	jreq	00104$
	jra	00105$
;	AD9833.c: 80: case SINE     : //SIN : OPBITEN=0, MODE=0, DIV2=x
00101$:
;	AD9833.c: 81: BITS_RST(AD_REG_VAL[AD_REG_CTL], (BIT(AD_CTL_MODE)|BIT(AD_CTL_OPBITEN)));
	ldw	x, _AD_REG_VAL+0
	ld	a, xl
	and	a, #0xdd
	ld	xl, a
	ldw	_AD_REG_VAL+0, x
;	AD9833.c: 82: break;
	jra	00105$
;	AD9833.c: 83: case TRIANGLE : //TRIANGLE : OPBITEN=0, MODE=1, DIV2=x
00102$:
;	AD9833.c: 84: BIT_SET(AD_REG_VAL[AD_REG_CTL],AD_CTL_MODE);
	ldw	x, _AD_REG_VAL+0
	ld	a, xl
	or	a, #0x02
	ld	xl, a
	ldw	_AD_REG_VAL+0, x
;	AD9833.c: 85: BIT_RST(AD_REG_VAL[AD_REG_CTL],AD_CTL_OPBITEN);
	ld	a, xl
	and	a, #0xdf
	ld	xl, a
	ldw	_AD_REG_VAL+0, x
;	AD9833.c: 86: break;
	jra	00105$
;	AD9833.c: 87: case SQUARE   : //SQUARE : OPBITEN=1, MODE=0, DIV2=0
00103$:
;	AD9833.c: 88: BIT_SET(AD_REG_VAL[AD_REG_CTL],AD_CTL_OPBITEN);
	ldw	x, _AD_REG_VAL+0
	ld	a, xl
	or	a, #0x20
	ld	xl, a
	ldw	_AD_REG_VAL+0, x
;	AD9833.c: 89: BITS_RST(AD_REG_VAL[AD_REG_CTL],(BIT(AD_CTL_MODE)|BIT(AD_CTL_DIV2)));
	ld	a, xl
	and	a, #0xf5
	ld	xl, a
	ldw	_AD_REG_VAL+0, x
;	AD9833.c: 90: break;
	jra	00105$
;	AD9833.c: 91: case SQUARE2  : //SQUARE2 : OPBITEN=1, MODE=0, DIV2=1
00104$:
;	AD9833.c: 92: BITS_SET(AD_REG_VAL[AD_REG_CTL],(BIT(AD_CTL_OPBITEN)|BIT(AD_CTL_MODE)));
	ldw	x, _AD_REG_VAL+0
	ld	a, xl
	or	a, #0x22
	ld	xl, a
	ldw	_AD_REG_VAL+0, x
;	AD9833.c: 93: BIT_RST(AD_REG_VAL[AD_REG_CTL],AD_CTL_DIV2);
	ld	a, xl
	and	a, #0xf7
	ld	xl, a
	ldw	_AD_REG_VAL+0, x
;	AD9833.c: 95: }
00105$:
;	AD9833.c: 96: AD9833_WriteReg(AD_REG_CTL);
	push	#0x00
	call	_AD9833_WriteReg
	pop	a
;	AD9833.c: 97: }
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
__xinit__AD_REG_ADDRESS:
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x80	; 128
	.db #0xc0	; 192
	.db #0xe0	; 224
__xinit__AD_REG_VAL:
	.dw #0x0000
	.dw #0x0000
	.dw #0x0000
	.dw #0x0000
	.dw #0x0000
	.area CABS (ABS)
