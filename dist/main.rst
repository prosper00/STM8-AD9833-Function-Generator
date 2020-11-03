                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 4.0.4 #11922 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module main
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _main
                                     12 	.globl _AD9833_Reset
                                     13 	.globl _AD9833_SetMode
                                     14 	.globl _AD9833_SetPhase
                                     15 	.globl _AD9833_SetFreq
                                     16 	.globl _AD9833_Init
                                     17 ;--------------------------------------------------------
                                     18 ; ram data
                                     19 ;--------------------------------------------------------
                                     20 	.area DATA
                                     21 ;--------------------------------------------------------
                                     22 ; ram data
                                     23 ;--------------------------------------------------------
                                     24 	.area INITIALIZED
                                     25 ;--------------------------------------------------------
                                     26 ; Stack segment in internal ram 
                                     27 ;--------------------------------------------------------
                                     28 	.area	SSEG
      008D75                         29 __start__stack:
      008D75                         30 	.ds	1
                                     31 
                                     32 ;--------------------------------------------------------
                                     33 ; absolute external ram data
                                     34 ;--------------------------------------------------------
                                     35 	.area DABS (ABS)
                                     36 
                                     37 ; default segment ordering for linker
                                     38 	.area HOME
                                     39 	.area GSINIT
                                     40 	.area GSFINAL
                                     41 	.area CONST
                                     42 	.area INITIALIZER
                                     43 	.area CODE
                                     44 
                                     45 ;--------------------------------------------------------
                                     46 ; interrupt vector 
                                     47 ;--------------------------------------------------------
                                     48 	.area HOME
      008000                         49 __interrupt_vect:
      008000 82 00 80 07             50 	int s_GSINIT ; reset
                                     51 ;--------------------------------------------------------
                                     52 ; global & static initialisations
                                     53 ;--------------------------------------------------------
                                     54 	.area HOME
                                     55 	.area GSINIT
                                     56 	.area GSFINAL
                                     57 	.area GSINIT
      008007                         58 __sdcc_init_data:
                                     59 ; stm8_genXINIT() start
      008007 AE 00 00         [ 2]   60 	ldw x, #l_DATA
      00800A 27 07            [ 1]   61 	jreq	00002$
      00800C                         62 00001$:
      00800C 72 4F 00 00      [ 1]   63 	clr (s_DATA - 1, x)
      008010 5A               [ 2]   64 	decw x
      008011 26 F9            [ 1]   65 	jrne	00001$
      008013                         66 00002$:
      008013 AE 00 0F         [ 2]   67 	ldw	x, #l_INITIALIZER
      008016 27 09            [ 1]   68 	jreq	00004$
      008018                         69 00003$:
      008018 D6 80 89         [ 1]   70 	ld	a, (s_INITIALIZER - 1, x)
      00801B D7 00 00         [ 1]   71 	ld	(s_INITIALIZED - 1, x), a
      00801E 5A               [ 2]   72 	decw	x
      00801F 26 F7            [ 1]   73 	jrne	00003$
      008021                         74 00004$:
                                     75 ; stm8_genXINIT() end
                                     76 	.area GSFINAL
      008021 CC 80 04         [ 2]   77 	jp	__sdcc_program_startup
                                     78 ;--------------------------------------------------------
                                     79 ; Home
                                     80 ;--------------------------------------------------------
                                     81 	.area HOME
                                     82 	.area HOME
      008004                         83 __sdcc_program_startup:
      008004 CC 83 32         [ 2]   84 	jp	_main
                                     85 ;	return from main will return to caller
                                     86 ;--------------------------------------------------------
                                     87 ; code
                                     88 ;--------------------------------------------------------
                                     89 	.area CODE
                                     90 ;	./delay.h: 23: static inline void _delay_cycl( uint16_t __ticks )
                                     91 ;	-----------------------------------------
                                     92 ;	 function _delay_cycl
                                     93 ;	-----------------------------------------
      0082C8                         94 __delay_cycl:
                                     95 ;	./delay.h: 26: __asm__("nop\n nop\n"); 
      0082C8 9D               [ 1]   96 	nop
      0082C9 9D               [ 1]   97 	nop
                                     98 ;	./delay.h: 27: do { 		// ASM: ldw X, #tick; lab$: decw X; tnzw X; jrne lab$
      0082CA 1E 03            [ 2]   99 	ldw	x, (0x03, sp)
      0082CC                        100 00101$:
                                    101 ;	./delay.h: 28: __ticks--;//      2c;                 1c;     2c    ; 1/2c   
      0082CC 5A               [ 2]  102 	decw	x
                                    103 ;	./delay.h: 29: } while ( __ticks );
      0082CD 5D               [ 2]  104 	tnzw	x
      0082CE 26 FC            [ 1]  105 	jrne	00101$
                                    106 ;	./delay.h: 30: __asm__("nop\n");
      0082D0 9D               [ 1]  107 	nop
                                    108 ;	./delay.h: 31: }
      0082D1 81               [ 4]  109 	ret
                                    110 ;	./delay.h: 33: static inline void delay_us( uint16_t __us )
                                    111 ;	-----------------------------------------
                                    112 ;	 function delay_us
                                    113 ;	-----------------------------------------
      0082D2                        114 _delay_us:
                                    115 ;	./delay.h: 35: _delay_cycl( (uint16_t)( T_COUNT(__us) );
      0082D2 16 03            [ 2]  116 	ldw	y, (0x03, sp)
      0082D4 5F               [ 1]  117 	clrw	x
      0082D5 90 89            [ 2]  118 	pushw	y
      0082D7 89               [ 2]  119 	pushw	x
      0082D8 4B 00            [ 1]  120 	push	#0x00
      0082DA 4B 24            [ 1]  121 	push	#0x24
      0082DC 4B F4            [ 1]  122 	push	#0xf4
      0082DE 4B 00            [ 1]  123 	push	#0x00
      0082E0 CD 8C 13         [ 4]  124 	call	__mullong
      0082E3 5B 08            [ 2]  125 	addw	sp, #8
      0082E5 4B 40            [ 1]  126 	push	#0x40
      0082E7 4B 42            [ 1]  127 	push	#0x42
      0082E9 4B 0F            [ 1]  128 	push	#0x0f
      0082EB 4B 00            [ 1]  129 	push	#0x00
      0082ED 89               [ 2]  130 	pushw	x
      0082EE 90 89            [ 2]  131 	pushw	y
      0082F0 CD 89 52         [ 4]  132 	call	__divulong
      0082F3 5B 08            [ 2]  133 	addw	sp, #8
      0082F5 1D 00 05         [ 2]  134 	subw	x, #0x0005
      0082F8 24 02            [ 1]  135 	jrnc	00118$
      0082FA 90 5A            [ 2]  136 	decw	y
      0082FC                        137 00118$:
      0082FC 4B 05            [ 1]  138 	push	#0x05
      0082FE 4B 00            [ 1]  139 	push	#0x00
      008300 4B 00            [ 1]  140 	push	#0x00
      008302 4B 00            [ 1]  141 	push	#0x00
      008304 89               [ 2]  142 	pushw	x
      008305 90 89            [ 2]  143 	pushw	y
      008307 CD 89 52         [ 4]  144 	call	__divulong
      00830A 5B 08            [ 2]  145 	addw	sp, #8
                                    146 ;	./delay.h: 26: __asm__("nop\n nop\n"); 
      00830C 9D               [ 1]  147 	nop
      00830D 9D               [ 1]  148 	nop
                                    149 ;	./delay.h: 27: do { 		// ASM: ldw X, #tick; lab$: decw X; tnzw X; jrne lab$
      00830E                        150 00101$:
                                    151 ;	./delay.h: 28: __ticks--;//      2c;                 1c;     2c    ; 1/2c   
      00830E 5A               [ 2]  152 	decw	x
                                    153 ;	./delay.h: 29: } while ( __ticks );
      00830F 5D               [ 2]  154 	tnzw	x
      008310 26 FC            [ 1]  155 	jrne	00101$
                                    156 ;	./delay.h: 30: __asm__("nop\n");
      008312 9D               [ 1]  157 	nop
                                    158 ;	./delay.h: 35: _delay_cycl( (uint16_t)( T_COUNT(__us) );
                                    159 ;	./delay.h: 36: }
      008313 81               [ 4]  160 	ret
                                    161 ;	./delay.h: 38: static inline void delay_ms( uint16_t __ms )
                                    162 ;	-----------------------------------------
                                    163 ;	 function delay_ms
                                    164 ;	-----------------------------------------
      008314                        165 _delay_ms:
      008314 89               [ 2]  166 	pushw	x
                                    167 ;	./delay.h: 40: while ( __ms-- )
      008315 16 05            [ 2]  168 	ldw	y, (0x05, sp)
      008317 17 01            [ 2]  169 	ldw	(0x01, sp), y
      008319                        170 00101$:
      008319 1E 01            [ 2]  171 	ldw	x, (0x01, sp)
      00831B 16 01            [ 2]  172 	ldw	y, (0x01, sp)
      00831D 90 5A            [ 2]  173 	decw	y
      00831F 17 01            [ 2]  174 	ldw	(0x01, sp), y
      008321 5D               [ 2]  175 	tnzw	x
      008322 27 0C            [ 1]  176 	jreq	00109$
                                    177 ;	./delay.h: 26: __asm__("nop\n nop\n"); 
      008324 9D               [ 1]  178 	nop
      008325 9D               [ 1]  179 	nop
                                    180 ;	./delay.h: 27: do { 		// ASM: ldw X, #tick; lab$: decw X; tnzw X; jrne lab$
      008326 AE 02 6E         [ 2]  181 	ldw	x, #0x026e
      008329                        182 00104$:
                                    183 ;	./delay.h: 28: __ticks--;//      2c;                 1c;     2c    ; 1/2c   
      008329 5A               [ 2]  184 	decw	x
                                    185 ;	./delay.h: 29: } while ( __ticks );
      00832A 5D               [ 2]  186 	tnzw	x
      00832B 26 FC            [ 1]  187 	jrne	00104$
                                    188 ;	./delay.h: 30: __asm__("nop\n");
      00832D 9D               [ 1]  189 	nop
                                    190 ;	./delay.h: 42: delay_us( 1000 );
      00832E 20 E9            [ 2]  191 	jra	00101$
      008330                        192 00109$:
                                    193 ;	./delay.h: 44: }
      008330 85               [ 2]  194 	popw	x
      008331 81               [ 4]  195 	ret
                                    196 ;	main.c: 16: void main(void)
                                    197 ;	-----------------------------------------
                                    198 ;	 function main
                                    199 ;	-----------------------------------------
      008332                        200 _main:
      008332 89               [ 2]  201 	pushw	x
                                    202 ;	main.c: 18: CLK_Config();
      008333 CD 83 EC         [ 4]  203 	call	_CLK_Config
                                    204 ;	main.c: 19: ADC_Config();
      008336 CD 84 4D         [ 4]  205 	call	_ADC_Config
                                    206 ;	main.c: 21: SPI_Config();
      008339 CD 84 D7         [ 4]  207 	call	_SPI_Config
                                    208 ;	main.c: 22: AD9833_Init();
      00833C CD 81 74         [ 4]  209 	call	_AD9833_Init
                                    210 ;	main.c: 23: AD9833_SetFreq(100000);
      00833F 4B 00            [ 1]  211 	push	#0x00
      008341 4B 50            [ 1]  212 	push	#0x50
      008343 4B C3            [ 1]  213 	push	#0xc3
      008345 4B 47            [ 1]  214 	push	#0x47
      008347 CD 81 A7         [ 4]  215 	call	_AD9833_SetFreq
      00834A 5B 04            [ 2]  216 	addw	sp, #4
                                    217 ;	main.c: 24: AD9833_SetPhase(0);
      00834C 5F               [ 1]  218 	clrw	x
      00834D 89               [ 2]  219 	pushw	x
      00834E 5F               [ 1]  220 	clrw	x
      00834F 89               [ 2]  221 	pushw	x
      008350 CD 82 11         [ 4]  222 	call	_AD9833_SetPhase
      008353 5B 04            [ 2]  223 	addw	sp, #4
                                    224 ;	main.c: 25: AD9833_Reset(0);
      008355 4B 00            [ 1]  225 	push	#0x00
      008357 CD 81 85         [ 4]  226 	call	_AD9833_Reset
      00835A 84               [ 1]  227 	pop	a
                                    228 ;	./delay.h: 40: while ( __ms-- )
      00835B                        229 00131$:
      00835B AE 27 10         [ 2]  230 	ldw	x, #0x2710
      00835E 1F 01            [ 2]  231 	ldw	(0x01, sp), x
      008360                        232 00104$:
      008360 1E 01            [ 2]  233 	ldw	x, (0x01, sp)
      008362 16 01            [ 2]  234 	ldw	y, (0x01, sp)
      008364 90 5A            [ 2]  235 	decw	y
      008366 17 01            [ 2]  236 	ldw	(0x01, sp), y
      008368 5D               [ 2]  237 	tnzw	x
      008369 27 0C            [ 1]  238 	jreq	00112$
                                    239 ;	./delay.h: 26: __asm__("nop\n nop\n"); 
      00836B 9D               [ 1]  240 	nop
      00836C 9D               [ 1]  241 	nop
                                    242 ;	./delay.h: 27: do { 		// ASM: ldw X, #tick; lab$: decw X; tnzw X; jrne lab$
      00836D AE 02 6E         [ 2]  243 	ldw	x, #0x026e
      008370                        244 00105$:
                                    245 ;	./delay.h: 28: __ticks--;//      2c;                 1c;     2c    ; 1/2c   
      008370 5A               [ 2]  246 	decw	x
                                    247 ;	./delay.h: 29: } while ( __ticks );
      008371 5D               [ 2]  248 	tnzw	x
      008372 26 FC            [ 1]  249 	jrne	00105$
                                    250 ;	./delay.h: 30: __asm__("nop\n");
      008374 9D               [ 1]  251 	nop
                                    252 ;	./delay.h: 42: delay_us( 1000 );
      008375 20 E9            [ 2]  253 	jra	00104$
                                    254 ;	main.c: 30: delay_ms(10000);
      008377                        255 00112$:
                                    256 ;	main.c: 31: AD9833_Reset(1);
      008377 4B 01            [ 1]  257 	push	#0x01
      008379 CD 81 85         [ 4]  258 	call	_AD9833_Reset
      00837C 84               [ 1]  259 	pop	a
                                    260 ;	main.c: 32: AD9833_SetFreq(100000);
      00837D 4B 00            [ 1]  261 	push	#0x00
      00837F 4B 50            [ 1]  262 	push	#0x50
      008381 4B C3            [ 1]  263 	push	#0xc3
      008383 4B 47            [ 1]  264 	push	#0x47
      008385 CD 81 A7         [ 4]  265 	call	_AD9833_SetFreq
      008388 5B 04            [ 2]  266 	addw	sp, #4
                                    267 ;	main.c: 33: AD9833_SetMode(TRIANGLE);
      00838A 4B 01            [ 1]  268 	push	#0x01
      00838C CD 82 65         [ 4]  269 	call	_AD9833_SetMode
      00838F 84               [ 1]  270 	pop	a
                                    271 ;	main.c: 34: AD9833_Reset(0);
      008390 4B 00            [ 1]  272 	push	#0x00
      008392 CD 81 85         [ 4]  273 	call	_AD9833_Reset
      008395 84               [ 1]  274 	pop	a
                                    275 ;	./delay.h: 40: while ( __ms-- )
      008396 AE 27 10         [ 2]  276 	ldw	x, #0x2710
      008399 1F 01            [ 2]  277 	ldw	(0x01, sp), x
      00839B                        278 00113$:
      00839B 1E 01            [ 2]  279 	ldw	x, (0x01, sp)
      00839D 16 01            [ 2]  280 	ldw	y, (0x01, sp)
      00839F 90 5A            [ 2]  281 	decw	y
      0083A1 17 01            [ 2]  282 	ldw	(0x01, sp), y
      0083A3 5D               [ 2]  283 	tnzw	x
      0083A4 27 0C            [ 1]  284 	jreq	00121$
                                    285 ;	./delay.h: 26: __asm__("nop\n nop\n"); 
      0083A6 9D               [ 1]  286 	nop
      0083A7 9D               [ 1]  287 	nop
                                    288 ;	./delay.h: 27: do { 		// ASM: ldw X, #tick; lab$: decw X; tnzw X; jrne lab$
      0083A8 AE 02 6E         [ 2]  289 	ldw	x, #0x026e
      0083AB                        290 00114$:
                                    291 ;	./delay.h: 28: __ticks--;//      2c;                 1c;     2c    ; 1/2c   
      0083AB 5A               [ 2]  292 	decw	x
                                    293 ;	./delay.h: 29: } while ( __ticks );
      0083AC 5D               [ 2]  294 	tnzw	x
      0083AD 26 FC            [ 1]  295 	jrne	00114$
                                    296 ;	./delay.h: 30: __asm__("nop\n");
      0083AF 9D               [ 1]  297 	nop
                                    298 ;	./delay.h: 42: delay_us( 1000 );
      0083B0 20 E9            [ 2]  299 	jra	00113$
                                    300 ;	main.c: 35: delay_ms(10000);
      0083B2                        301 00121$:
                                    302 ;	main.c: 36: AD9833_Reset(1);
      0083B2 4B 01            [ 1]  303 	push	#0x01
      0083B4 CD 81 85         [ 4]  304 	call	_AD9833_Reset
      0083B7 84               [ 1]  305 	pop	a
                                    306 ;	main.c: 37: AD9833_SetFreq(100000);
      0083B8 4B 00            [ 1]  307 	push	#0x00
      0083BA 4B 50            [ 1]  308 	push	#0x50
      0083BC 4B C3            [ 1]  309 	push	#0xc3
      0083BE 4B 47            [ 1]  310 	push	#0x47
      0083C0 CD 81 A7         [ 4]  311 	call	_AD9833_SetFreq
      0083C3 5B 04            [ 2]  312 	addw	sp, #4
                                    313 ;	main.c: 38: AD9833_SetMode(SINE);
      0083C5 4B 00            [ 1]  314 	push	#0x00
      0083C7 CD 82 65         [ 4]  315 	call	_AD9833_SetMode
      0083CA 84               [ 1]  316 	pop	a
                                    317 ;	main.c: 39: AD9833_Reset(0);   
      0083CB 4B 00            [ 1]  318 	push	#0x00
      0083CD CD 81 85         [ 4]  319 	call	_AD9833_Reset
      0083D0 84               [ 1]  320 	pop	a
                                    321 ;	main.c: 41: int PotVal=ADC1_GetConversionValue();
      0083D1 C6 54 02         [ 1]  322 	ld	a, 0x5402
      0083D4 A5 08            [ 1]  323 	bcp	a, #0x08
      0083D6 27 09            [ 1]  324 	jreq	00123$
      0083D8 C6 54 05         [ 1]  325 	ld	a, 0x5405
      0083DB C6 54 04         [ 1]  326 	ld	a, 0x5404
      0083DE CC 83 5B         [ 2]  327 	jp	00131$
      0083E1                        328 00123$:
      0083E1 C6 54 04         [ 1]  329 	ld	a, 0x5404
      0083E4 C6 54 05         [ 1]  330 	ld	a, 0x5405
      0083E7 CC 83 5B         [ 2]  331 	jp	00131$
                                    332 ;	main.c: 43: }
      0083EA 85               [ 2]  333 	popw	x
      0083EB 81               [ 4]  334 	ret
                                    335 ;	main.c: 45: static void CLK_Config(void)
                                    336 ;	-----------------------------------------
                                    337 ;	 function CLK_Config
                                    338 ;	-----------------------------------------
      0083EC                        339 _CLK_Config:
                                    340 ;	inc/stm8s_clk.h: 741: CLK->CKDIVR &= (uint8_t) (~CLK_CKDIVR_HSIDIV);
      0083EC C6 50 C6         [ 1]  341 	ld	a, 0x50c6
      0083EF A4 E7            [ 1]  342 	and	a, #0xe7
      0083F1 C7 50 C6         [ 1]  343 	ld	0x50c6, a
                                    344 ;	inc/stm8s_clk.h: 744: CLK->CKDIVR |= (uint8_t) HSIPrescaler;
      0083F4 C6 50 C6         [ 1]  345 	ld	a, 0x50c6
      0083F7 C7 50 C6         [ 1]  346 	ld	0x50c6, a
                                    347 ;	inc/stm8s_clk.h: 823: CLK->CKDIVR &= (uint8_t) (~CLK_CKDIVR_HSIDIV);
      0083FA C6 50 C6         [ 1]  348 	ld	a, 0x50c6
      0083FD A4 E7            [ 1]  349 	and	a, #0xe7
      0083FF C7 50 C6         [ 1]  350 	ld	0x50c6, a
                                    351 ;	inc/stm8s_clk.h: 824: CLK->CKDIVR |= (uint8_t) ((uint8_t) CLK_Prescaler & (uint8_t) CLK_CKDIVR_HSIDIV);
      008402 C6 50 C6         [ 1]  352 	ld	a, 0x50c6
      008405 C7 50 C6         [ 1]  353 	ld	0x50c6, a
                                    354 ;	inc/stm8s_clk.h: 664: clock_master = (CLK_Source_TypeDef) CLK->CMSR;
      008408 C6 50 C3         [ 1]  355 	ld	a, 0x50c3
      00840B 90 97            [ 1]  356 	ld	yl, a
                                    357 ;	inc/stm8s_clk.h: 669: CLK->SWCR |= CLK_SWCR_SWEN;
      00840D 72 12 50 C5      [ 1]  358 	bset	20677, #1
                                    359 ;	inc/stm8s_clk.h: 675: CLK->SWCR &= (uint8_t) (~CLK_SWCR_SWIEN);
      008411 72 15 50 C5      [ 1]  360 	bres	20677, #2
                                    361 ;	inc/stm8s_clk.h: 679: CLK->SWR = (uint8_t) CLK_NewClock;
      008415 35 E1 50 C4      [ 1]  362 	mov	0x50c4+0, #0xe1
                                    363 ;	inc/stm8s_clk.h: 682: while ((((CLK->SWCR & CLK_SWCR_SWBSY) != 0) && (DownCounter != 0))) {
      008419 5F               [ 1]  364 	clrw	x
      00841A 5A               [ 2]  365 	decw	x
      00841B                        366 00110$:
      00841B C6 50 C5         [ 1]  367 	ld	a, 0x50c5
      00841E 44               [ 1]  368 	srl	a
      00841F 24 06            [ 1]  369 	jrnc	00112$
      008421 5D               [ 2]  370 	tnzw	x
      008422 27 03            [ 1]  371 	jreq	00112$
                                    372 ;	inc/stm8s_clk.h: 683: DownCounter--;
      008424 5A               [ 2]  373 	decw	x
      008425 20 F4            [ 2]  374 	jra	00110$
      008427                        375 00112$:
                                    376 ;	inc/stm8s_clk.h: 686: if (DownCounter != 0) {
      008427 5D               [ 2]  377 	tnzw	x
      008428 26 01            [ 1]  378 	jrne	00195$
      00842A 81               [ 4]  379 	ret
      00842B                        380 00195$:
                                    381 ;	inc/stm8s_clk.h: 718: if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && (clock_master == CLK_SOURCE_HSI)) {
      00842B 90 9F            [ 1]  382 	ld	a, yl
      00842D A1 E1            [ 1]  383 	cp	a, #0xe1
      00842F 26 05            [ 1]  384 	jrne	00138$
                                    385 ;	inc/stm8s_clk.h: 719: CLK->ICKR &= (uint8_t) (~CLK_ICKR_HSIEN);
      008431 72 11 50 C0      [ 1]  386 	bres	20672, #0
      008435 81               [ 4]  387 	ret
      008436                        388 00138$:
                                    389 ;	inc/stm8s_clk.h: 720: } else if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && (clock_master == CLK_SOURCE_LSI)) {
      008436 90 9F            [ 1]  390 	ld	a, yl
      008438 A1 D2            [ 1]  391 	cp	a, #0xd2
      00843A 26 05            [ 1]  392 	jrne	00136$
                                    393 ;	inc/stm8s_clk.h: 721: CLK->ICKR &= (uint8_t) (~CLK_ICKR_LSIEN);
      00843C 72 17 50 C0      [ 1]  394 	bres	20672, #3
      008440 81               [ 4]  395 	ret
      008441                        396 00136$:
                                    397 ;	inc/stm8s_clk.h: 722: } else if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && (clock_master == CLK_SOURCE_HSE)) {
      008441 90 9F            [ 1]  398 	ld	a, yl
      008443 A1 B4            [ 1]  399 	cp	a, #0xb4
      008445 27 01            [ 1]  400 	jreq	00204$
      008447 81               [ 4]  401 	ret
      008448                        402 00204$:
                                    403 ;	inc/stm8s_clk.h: 723: CLK->ECKR &= (uint8_t) (~CLK_ECKR_HSEEN);
      008448 72 11 50 C1      [ 1]  404 	bres	20673, #0
                                    405 ;	main.c: 51: CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE, CLK_CURRENTCLOCKSTATE_DISABLE);
                                    406 ;	main.c: 52: }
      00844C 81               [ 4]  407 	ret
                                    408 ;	main.c: 54: static void ADC_Config(void)
                                    409 ;	-----------------------------------------
                                    410 ;	 function ADC_Config
                                    411 ;	-----------------------------------------
      00844D                        412 _ADC_Config:
                                    413 ;	inc/stm8s_gpio.h: 212: GPIOx->CR2 &= (uint8_t) (~(GPIO_Pin));
      00844D 72 15 50 13      [ 1]  414 	bres	20499, #2
                                    415 ;	inc/stm8s_gpio.h: 232: GPIOx->DDR &= (uint8_t) (~(GPIO_Pin));
      008451 72 15 50 11      [ 1]  416 	bres	20497, #2
                                    417 ;	inc/stm8s_gpio.h: 244: GPIOx->CR1 &= (uint8_t) (~(GPIO_Pin));
      008455 72 15 50 12      [ 1]  418 	bres	20498, #2
                                    419 ;	inc/stm8s_gpio.h: 256: GPIOx->CR2 &= (uint8_t) (~(GPIO_Pin));
      008459 72 15 50 13      [ 1]  420 	bres	20499, #2
                                    421 ;	inc/stm8s_adc1.h: 376: ADC1->CSR = ADC1_CSR_RESET_VALUE;
      00845D 35 00 54 00      [ 1]  422 	mov	0x5400+0, #0x00
                                    423 ;	inc/stm8s_adc1.h: 377: ADC1->CR1 = ADC1_CR1_RESET_VALUE;
      008461 35 00 54 01      [ 1]  424 	mov	0x5401+0, #0x00
                                    425 ;	inc/stm8s_adc1.h: 378: ADC1->CR2 = ADC1_CR2_RESET_VALUE;
      008465 35 00 54 02      [ 1]  426 	mov	0x5402+0, #0x00
                                    427 ;	inc/stm8s_adc1.h: 379: ADC1->CR3 = ADC1_CR3_RESET_VALUE;
      008469 35 00 54 03      [ 1]  428 	mov	0x5403+0, #0x00
                                    429 ;	inc/stm8s_adc1.h: 380: ADC1->TDRH = ADC1_TDRH_RESET_VALUE;
      00846D 35 00 54 06      [ 1]  430 	mov	0x5406+0, #0x00
                                    431 ;	inc/stm8s_adc1.h: 381: ADC1->TDRL = ADC1_TDRL_RESET_VALUE;
      008471 35 00 54 07      [ 1]  432 	mov	0x5407+0, #0x00
                                    433 ;	inc/stm8s_adc1.h: 382: ADC1->HTRH = ADC1_HTRH_RESET_VALUE;
      008475 35 FF 54 08      [ 1]  434 	mov	0x5408+0, #0xff
                                    435 ;	inc/stm8s_adc1.h: 383: ADC1->HTRL = ADC1_HTRL_RESET_VALUE;
      008479 35 03 54 09      [ 1]  436 	mov	0x5409+0, #0x03
                                    437 ;	inc/stm8s_adc1.h: 384: ADC1->LTRH = ADC1_LTRH_RESET_VALUE;
      00847D 35 00 54 0A      [ 1]  438 	mov	0x540a+0, #0x00
                                    439 ;	inc/stm8s_adc1.h: 385: ADC1->LTRL = ADC1_LTRL_RESET_VALUE;
      008481 35 00 54 0B      [ 1]  440 	mov	0x540b+0, #0x00
                                    441 ;	inc/stm8s_adc1.h: 386: ADC1->AWCRH = ADC1_AWCRH_RESET_VALUE;
      008485 35 00 54 0E      [ 1]  442 	mov	0x540e+0, #0x00
                                    443 ;	inc/stm8s_adc1.h: 387: ADC1->AWCRL = ADC1_AWCRL_RESET_VALUE;
      008489 35 00 54 0F      [ 1]  444 	mov	0x540f+0, #0x00
                                    445 ;	inc/stm8s_adc1.h: 408: ADC1->CR2 &= (uint8_t) (~ADC1_CR2_ALIGN);
      00848D 72 17 54 02      [ 1]  446 	bres	21506, #3
                                    447 ;	inc/stm8s_adc1.h: 410: ADC1->CR2 |= (uint8_t) (ADC1_Align);
      008491 72 16 54 02      [ 1]  448 	bset	21506, #3
                                    449 ;	inc/stm8s_adc1.h: 414: ADC1->CR1 |= ADC1_CR1_CONT;
      008495 72 12 54 01      [ 1]  450 	bset	21505, #1
                                    451 ;	inc/stm8s_adc1.h: 422: ADC1->CSR &= (uint8_t) (~ADC1_CSR_CH);
      008499 C6 54 00         [ 1]  452 	ld	a, 0x5400
      00849C A4 F0            [ 1]  453 	and	a, #0xf0
      00849E C7 54 00         [ 1]  454 	ld	0x5400, a
                                    455 ;	inc/stm8s_adc1.h: 424: ADC1->CSR |= (uint8_t) (ADC1_Channel);
      0084A1 C6 54 00         [ 1]  456 	ld	a, 0x5400
      0084A4 AA 03            [ 1]  457 	or	a, #0x03
      0084A6 C7 54 00         [ 1]  458 	ld	0x5400, a
                                    459 ;	inc/stm8s_adc1.h: 481: ADC1->CR1 &= (uint8_t) (~ADC1_CR1_SPSEL);
      0084A9 C6 54 01         [ 1]  460 	ld	a, 0x5401
      0084AC A4 8F            [ 1]  461 	and	a, #0x8f
      0084AE C7 54 01         [ 1]  462 	ld	0x5401, a
                                    463 ;	inc/stm8s_adc1.h: 483: ADC1->CR1 |= (uint8_t) (ADC1_Prescaler);
      0084B1 C6 54 01         [ 1]  464 	ld	a, 0x5401
      0084B4 C7 54 01         [ 1]  465 	ld	0x5401, a
                                    466 ;	inc/stm8s_adc1.h: 503: ADC1->CR2 &= (uint8_t) (~ADC1_CR2_EXTSEL);
      0084B7 C6 54 02         [ 1]  467 	ld	a, 0x5402
      0084BA A4 CF            [ 1]  468 	and	a, #0xcf
      0084BC C7 54 02         [ 1]  469 	ld	0x5402, a
                                    470 ;	inc/stm8s_adc1.h: 511: ADC1->CR2 &= (uint8_t) (~ADC1_CR2_EXTTRIG);
      0084BF 72 1D 54 02      [ 1]  471 	bres	21506, #6
                                    472 ;	inc/stm8s_adc1.h: 515: ADC1->CR2 |= (uint8_t) (ADC1_ExtTrigger);
      0084C3 C6 54 02         [ 1]  473 	ld	a, 0x5402
      0084C6 C7 54 02         [ 1]  474 	ld	0x5402, a
                                    475 ;	inc/stm8s_adc1.h: 455: ADC1->TDRL |= (uint8_t) ((uint8_t) 0x01 << (uint8_t) ADC1_SchmittTriggerChannel);
      0084C9 72 16 54 07      [ 1]  476 	bset	21511, #3
                                    477 ;	inc/stm8s_adc1.h: 571: ADC1->CR1 |= ADC1_CR1_ADON;
      0084CD 72 10 54 01      [ 1]  478 	bset	21505, #0
                                    479 ;	inc/stm8s_adc1.h: 665: ADC1->CR1 |= ADC1_CR1_ADON;
      0084D1 72 10 54 01      [ 1]  480 	bset	21505, #0
                                    481 ;	main.c: 71: ADC1_StartConversion();
                                    482 ;	main.c: 72: }
      0084D5 81               [ 4]  483 	ret
                                    484 ;	main.c: 74: static void UART1_Config(void)
                                    485 ;	-----------------------------------------
                                    486 ;	 function UART1_Config
                                    487 ;	-----------------------------------------
      0084D6                        488 _UART1_Config:
                                    489 ;	main.c: 81: }
      0084D6 81               [ 4]  490 	ret
                                    491 ;	main.c: 83: static void SPI_Config(void)
                                    492 ;	-----------------------------------------
                                    493 ;	 function SPI_Config
                                    494 ;	-----------------------------------------
      0084D7                        495 _SPI_Config:
                                    496 ;	inc/stm8s_gpio.h: 212: GPIOx->CR2 &= (uint8_t) (~(GPIO_Pin));
      0084D7 72 17 50 04      [ 1]  497 	bres	20484, #3
                                    498 ;	inc/stm8s_gpio.h: 222: GPIOx->ODR |= (uint8_t) GPIO_Pin;
      0084DB 72 16 50 00      [ 1]  499 	bset	20480, #3
                                    500 ;	inc/stm8s_gpio.h: 228: GPIOx->DDR |= (uint8_t) GPIO_Pin;
      0084DF 72 16 50 02      [ 1]  501 	bset	20482, #3
                                    502 ;	inc/stm8s_gpio.h: 241: GPIOx->CR1 |= (uint8_t) GPIO_Pin;
      0084E3 72 16 50 03      [ 1]  503 	bset	20483, #3
                                    504 ;	inc/stm8s_gpio.h: 253: GPIOx->CR2 |= (uint8_t) GPIO_Pin;
      0084E7 72 16 50 04      [ 1]  505 	bset	20484, #3
                                    506 ;	inc/stm8s_spi.h: 366: SPI->CR1 = SPI_CR1_RESET_VALUE;
      0084EB 35 00 52 00      [ 1]  507 	mov	0x5200+0, #0x00
                                    508 ;	inc/stm8s_spi.h: 367: SPI->CR2 = SPI_CR2_RESET_VALUE;
      0084EF 35 00 52 01      [ 1]  509 	mov	0x5201+0, #0x00
                                    510 ;	inc/stm8s_spi.h: 368: SPI->ICR = SPI_ICR_RESET_VALUE;
      0084F3 35 00 52 02      [ 1]  511 	mov	0x5202+0, #0x00
                                    512 ;	inc/stm8s_spi.h: 369: SPI->SR = SPI_SR_RESET_VALUE;
      0084F7 35 02 52 03      [ 1]  513 	mov	0x5203+0, #0x02
                                    514 ;	inc/stm8s_spi.h: 370: SPI->CRCPR = SPI_CRCPR_RESET_VALUE;
      0084FB 35 07 52 05      [ 1]  515 	mov	0x5205+0, #0x07
                                    516 ;	inc/stm8s_spi.h: 409: (uint8_t) ((uint8_t) ClockPolarity | ClockPhase));
      0084FF 35 1A 52 00      [ 1]  517 	mov	0x5200+0, #0x1a
                                    518 ;	inc/stm8s_spi.h: 412: SPI->CR2 = (uint8_t) ((uint8_t) (Data_Direction) | (uint8_t) (Slave_Management));
      008503 35 C2 52 01      [ 1]  519 	mov	0x5201+0, #0xc2
                                    520 ;	inc/stm8s_spi.h: 415: SPI->CR2 |= (uint8_t) SPI_CR2_SSI;
      008507 72 10 52 01      [ 1]  521 	bset	20993, #0
                                    522 ;	inc/stm8s_spi.h: 421: SPI->CR1 |= (uint8_t) (Mode);
      00850B 72 14 52 00      [ 1]  523 	bset	20992, #2
                                    524 ;	inc/stm8s_spi.h: 424: SPI->CRCPR = (uint8_t) CRCPolynomial;
      00850F 35 00 52 05      [ 1]  525 	mov	0x5205+0, #0x00
                                    526 ;	inc/stm8s_spi.h: 439: SPI->CR1 |= SPI_CR1_SPE; /* Enable the SPI peripheral*/
      008513 72 1C 52 00      [ 1]  527 	bset	20992, #6
                                    528 ;	main.c: 98: SPI_Cmd(ENABLE);
                                    529 ;	main.c: 99: }
      008517 81               [ 4]  530 	ret
                                    531 	.area CODE
                                    532 	.area CONST
      008068                        533 _AWU_Init_APR_Array_65536_122:
      008068 00                     534 	.db #0x00	; 0
      008069 1E                     535 	.db #0x1e	; 30
      00806A 1E                     536 	.db #0x1e	; 30
      00806B 1E                     537 	.db #0x1e	; 30
      00806C 1E                     538 	.db #0x1e	; 30
      00806D 1E                     539 	.db #0x1e	; 30
      00806E 1E                     540 	.db #0x1e	; 30
      00806F 1E                     541 	.db #0x1e	; 30
      008070 1E                     542 	.db #0x1e	; 30
      008071 1E                     543 	.db #0x1e	; 30
      008072 1E                     544 	.db #0x1e	; 30
      008073 1E                     545 	.db #0x1e	; 30
      008074 1E                     546 	.db #0x1e	; 30
      008075 3D                     547 	.db #0x3d	; 61
      008076 17                     548 	.db #0x17	; 23
      008077 17                     549 	.db #0x17	; 23
      008078 3E                     550 	.db #0x3e	; 62
      008079                        551 _AWU_Init_TBR_Array_65536_122:
      008079 00                     552 	.db #0x00	; 0
      00807A 01                     553 	.db #0x01	; 1
      00807B 02                     554 	.db #0x02	; 2
      00807C 03                     555 	.db #0x03	; 3
      00807D 04                     556 	.db #0x04	; 4
      00807E 05                     557 	.db #0x05	; 5
      00807F 06                     558 	.db #0x06	; 6
      008080 07                     559 	.db #0x07	; 7
      008081 08                     560 	.db #0x08	; 8
      008082 09                     561 	.db #0x09	; 9
      008083 0A                     562 	.db #0x0a	; 10
      008084 0B                     563 	.db #0x0b	; 11
      008085 0C                     564 	.db #0x0c	; 12
      008086 0C                     565 	.db #0x0c	; 12
      008087 0E                     566 	.db #0x0e	; 14
      008088 0F                     567 	.db #0x0f	; 15
      008089 0F                     568 	.db #0x0f	; 15
                                    569 	.area INITIALIZER
                                    570 	.area CABS (ABS)
