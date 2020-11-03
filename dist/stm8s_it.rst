                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 4.0.4 #11922 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module stm8s_it
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _TRAP_IRQHandler
                                     12 	.globl _TLI_IRQHandler
                                     13 	.globl _AWU_IRQHandler
                                     14 	.globl _CLK_IRQHandler
                                     15 	.globl _EXTI_PORTA_IRQHandler
                                     16 	.globl _EXTI_PORTB_IRQHandler
                                     17 	.globl _EXTI_PORTC_IRQHandler
                                     18 	.globl _EXTI_PORTD_IRQHandler
                                     19 	.globl _EXTI_PORTE_IRQHandler
                                     20 	.globl _SPI_IRQHandler
                                     21 	.globl _TIM1_UPD_OVF_TRG_BRK_IRQHandler
                                     22 	.globl _TIM1_CAP_COM_IRQHandler
                                     23 	.globl _TIM2_UPD_OVF_BRK_IRQHandler
                                     24 	.globl _TIM2_CAP_COM_IRQHandler
                                     25 	.globl _UART1_TX_IRQHandler
                                     26 	.globl _UART1_RX_IRQHandler
                                     27 	.globl _I2C_IRQHandler
                                     28 	.globl _ADC1_IRQHandler
                                     29 	.globl _TIM4_UPD_OVF_IRQHandler
                                     30 	.globl _EEPROM_EEC_IRQHandler
                                     31 ;--------------------------------------------------------
                                     32 ; ram data
                                     33 ;--------------------------------------------------------
                                     34 	.area DATA
                                     35 ;--------------------------------------------------------
                                     36 ; ram data
                                     37 ;--------------------------------------------------------
                                     38 	.area INITIALIZED
                                     39 ;--------------------------------------------------------
                                     40 ; absolute external ram data
                                     41 ;--------------------------------------------------------
                                     42 	.area DABS (ABS)
                                     43 
                                     44 ; default segment ordering for linker
                                     45 	.area HOME
                                     46 	.area GSINIT
                                     47 	.area GSFINAL
                                     48 	.area CONST
                                     49 	.area INITIALIZER
                                     50 	.area CODE
                                     51 
                                     52 ;--------------------------------------------------------
                                     53 ; global & static initialisations
                                     54 ;--------------------------------------------------------
                                     55 	.area HOME
                                     56 	.area GSINIT
                                     57 	.area GSFINAL
                                     58 	.area GSINIT
                                     59 ;--------------------------------------------------------
                                     60 ; Home
                                     61 ;--------------------------------------------------------
                                     62 	.area HOME
                                     63 	.area HOME
                                     64 ;--------------------------------------------------------
                                     65 ; code
                                     66 ;--------------------------------------------------------
                                     67 	.area CODE
                                     68 ;	stm8s_it.c: 66: INTERRUPT_HANDLER_TRAP(TRAP_IRQHandler)
                                     69 ;	-----------------------------------------
                                     70 ;	 function TRAP_IRQHandler
                                     71 ;	-----------------------------------------
      008099                         72 _TRAP_IRQHandler:
                                     73 ;	stm8s_it.c: 71: }
      008099 80               [11]   74 	iret
                                     75 ;	stm8s_it.c: 78: INTERRUPT_HANDLER(TLI_IRQHandler, 0)
                                     76 ;	-----------------------------------------
                                     77 ;	 function TLI_IRQHandler
                                     78 ;	-----------------------------------------
      00809A                         79 _TLI_IRQHandler:
                                     80 ;	stm8s_it.c: 84: }
      00809A 80               [11]   81 	iret
                                     82 ;	stm8s_it.c: 91: INTERRUPT_HANDLER(AWU_IRQHandler, 1)
                                     83 ;	-----------------------------------------
                                     84 ;	 function AWU_IRQHandler
                                     85 ;	-----------------------------------------
      00809B                         86 _AWU_IRQHandler:
                                     87 ;	stm8s_it.c: 96: }
      00809B 80               [11]   88 	iret
                                     89 ;	stm8s_it.c: 103: INTERRUPT_HANDLER(CLK_IRQHandler, 2)
                                     90 ;	-----------------------------------------
                                     91 ;	 function CLK_IRQHandler
                                     92 ;	-----------------------------------------
      00809C                         93 _CLK_IRQHandler:
                                     94 ;	stm8s_it.c: 108: }
      00809C 80               [11]   95 	iret
                                     96 ;	stm8s_it.c: 115: INTERRUPT_HANDLER(EXTI_PORTA_IRQHandler, 3)
                                     97 ;	-----------------------------------------
                                     98 ;	 function EXTI_PORTA_IRQHandler
                                     99 ;	-----------------------------------------
      00809D                        100 _EXTI_PORTA_IRQHandler:
                                    101 ;	stm8s_it.c: 120: }
      00809D 80               [11]  102 	iret
                                    103 ;	stm8s_it.c: 127: INTERRUPT_HANDLER(EXTI_PORTB_IRQHandler, 4)
                                    104 ;	-----------------------------------------
                                    105 ;	 function EXTI_PORTB_IRQHandler
                                    106 ;	-----------------------------------------
      00809E                        107 _EXTI_PORTB_IRQHandler:
                                    108 ;	stm8s_it.c: 132: }
      00809E 80               [11]  109 	iret
                                    110 ;	stm8s_it.c: 139: INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
                                    111 ;	-----------------------------------------
                                    112 ;	 function EXTI_PORTC_IRQHandler
                                    113 ;	-----------------------------------------
      00809F                        114 _EXTI_PORTC_IRQHandler:
                                    115 ;	stm8s_it.c: 144: }
      00809F 80               [11]  116 	iret
                                    117 ;	stm8s_it.c: 151: INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
                                    118 ;	-----------------------------------------
                                    119 ;	 function EXTI_PORTD_IRQHandler
                                    120 ;	-----------------------------------------
      0080A0                        121 _EXTI_PORTD_IRQHandler:
                                    122 ;	stm8s_it.c: 156: }
      0080A0 80               [11]  123 	iret
                                    124 ;	stm8s_it.c: 163: INTERRUPT_HANDLER(EXTI_PORTE_IRQHandler, 7)
                                    125 ;	-----------------------------------------
                                    126 ;	 function EXTI_PORTE_IRQHandler
                                    127 ;	-----------------------------------------
      0080A1                        128 _EXTI_PORTE_IRQHandler:
                                    129 ;	stm8s_it.c: 168: }
      0080A1 80               [11]  130 	iret
                                    131 ;	stm8s_it.c: 215: INTERRUPT_HANDLER(SPI_IRQHandler, 10)
                                    132 ;	-----------------------------------------
                                    133 ;	 function SPI_IRQHandler
                                    134 ;	-----------------------------------------
      0080A2                        135 _SPI_IRQHandler:
                                    136 ;	stm8s_it.c: 220: }
      0080A2 80               [11]  137 	iret
                                    138 ;	stm8s_it.c: 227: INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
                                    139 ;	-----------------------------------------
                                    140 ;	 function TIM1_UPD_OVF_TRG_BRK_IRQHandler
                                    141 ;	-----------------------------------------
      0080A3                        142 _TIM1_UPD_OVF_TRG_BRK_IRQHandler:
                                    143 ;	stm8s_it.c: 232: }
      0080A3 80               [11]  144 	iret
                                    145 ;	stm8s_it.c: 239: INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
                                    146 ;	-----------------------------------------
                                    147 ;	 function TIM1_CAP_COM_IRQHandler
                                    148 ;	-----------------------------------------
      0080A4                        149 _TIM1_CAP_COM_IRQHandler:
                                    150 ;	stm8s_it.c: 244: }
      0080A4 80               [11]  151 	iret
                                    152 ;	stm8s_it.c: 277: INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
                                    153 ;	-----------------------------------------
                                    154 ;	 function TIM2_UPD_OVF_BRK_IRQHandler
                                    155 ;	-----------------------------------------
      0080A5                        156 _TIM2_UPD_OVF_BRK_IRQHandler:
                                    157 ;	stm8s_it.c: 282: }
      0080A5 80               [11]  158 	iret
                                    159 ;	stm8s_it.c: 289: INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
                                    160 ;	-----------------------------------------
                                    161 ;	 function TIM2_CAP_COM_IRQHandler
                                    162 ;	-----------------------------------------
      0080A6                        163 _TIM2_CAP_COM_IRQHandler:
                                    164 ;	stm8s_it.c: 294: }
      0080A6 80               [11]  165 	iret
                                    166 ;	stm8s_it.c: 331: INTERRUPT_HANDLER(UART1_TX_IRQHandler, 17)
                                    167 ;	-----------------------------------------
                                    168 ;	 function UART1_TX_IRQHandler
                                    169 ;	-----------------------------------------
      0080A7                        170 _UART1_TX_IRQHandler:
                                    171 ;	stm8s_it.c: 336: }
      0080A7 80               [11]  172 	iret
                                    173 ;	stm8s_it.c: 343: INTERRUPT_HANDLER(UART1_RX_IRQHandler, 18)
                                    174 ;	-----------------------------------------
                                    175 ;	 function UART1_RX_IRQHandler
                                    176 ;	-----------------------------------------
      0080A8                        177 _UART1_RX_IRQHandler:
                                    178 ;	stm8s_it.c: 348: }
      0080A8 80               [11]  179 	iret
                                    180 ;	stm8s_it.c: 382: INTERRUPT_HANDLER(I2C_IRQHandler, 19)
                                    181 ;	-----------------------------------------
                                    182 ;	 function I2C_IRQHandler
                                    183 ;	-----------------------------------------
      0080A9                        184 _I2C_IRQHandler:
                                    185 ;	stm8s_it.c: 387: }
      0080A9 80               [11]  186 	iret
                                    187 ;	stm8s_it.c: 461: INTERRUPT_HANDLER(ADC1_IRQHandler, 22)
                                    188 ;	-----------------------------------------
                                    189 ;	 function ADC1_IRQHandler
                                    190 ;	-----------------------------------------
      0080AA                        191 _ADC1_IRQHandler:
                                    192 ;	stm8s_it.c: 466: }
      0080AA 80               [11]  193 	iret
                                    194 ;	stm8s_it.c: 487: INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
                                    195 ;	-----------------------------------------
                                    196 ;	 function TIM4_UPD_OVF_IRQHandler
                                    197 ;	-----------------------------------------
      0080AB                        198 _TIM4_UPD_OVF_IRQHandler:
                                    199 ;	stm8s_it.c: 492: }
      0080AB 80               [11]  200 	iret
                                    201 ;	stm8s_it.c: 500: INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
                                    202 ;	-----------------------------------------
                                    203 ;	 function EEPROM_EEC_IRQHandler
                                    204 ;	-----------------------------------------
      0080AC                        205 _EEPROM_EEC_IRQHandler:
                                    206 ;	stm8s_it.c: 505: }
      0080AC 80               [11]  207 	iret
                                    208 	.area CODE
                                    209 	.area CONST
      008024                        210 _AWU_Init_APR_Array_65536_122:
      008024 00                     211 	.db #0x00	; 0
      008025 1E                     212 	.db #0x1e	; 30
      008026 1E                     213 	.db #0x1e	; 30
      008027 1E                     214 	.db #0x1e	; 30
      008028 1E                     215 	.db #0x1e	; 30
      008029 1E                     216 	.db #0x1e	; 30
      00802A 1E                     217 	.db #0x1e	; 30
      00802B 1E                     218 	.db #0x1e	; 30
      00802C 1E                     219 	.db #0x1e	; 30
      00802D 1E                     220 	.db #0x1e	; 30
      00802E 1E                     221 	.db #0x1e	; 30
      00802F 1E                     222 	.db #0x1e	; 30
      008030 1E                     223 	.db #0x1e	; 30
      008031 3D                     224 	.db #0x3d	; 61
      008032 17                     225 	.db #0x17	; 23
      008033 17                     226 	.db #0x17	; 23
      008034 3E                     227 	.db #0x3e	; 62
      008035                        228 _AWU_Init_TBR_Array_65536_122:
      008035 00                     229 	.db #0x00	; 0
      008036 01                     230 	.db #0x01	; 1
      008037 02                     231 	.db #0x02	; 2
      008038 03                     232 	.db #0x03	; 3
      008039 04                     233 	.db #0x04	; 4
      00803A 05                     234 	.db #0x05	; 5
      00803B 06                     235 	.db #0x06	; 6
      00803C 07                     236 	.db #0x07	; 7
      00803D 08                     237 	.db #0x08	; 8
      00803E 09                     238 	.db #0x09	; 9
      00803F 0A                     239 	.db #0x0a	; 10
      008040 0B                     240 	.db #0x0b	; 11
      008041 0C                     241 	.db #0x0c	; 12
      008042 0C                     242 	.db #0x0c	; 12
      008043 0E                     243 	.db #0x0e	; 14
      008044 0F                     244 	.db #0x0f	; 15
      008045 0F                     245 	.db #0x0f	; 15
                                    246 	.area INITIALIZER
                                    247 	.area CABS (ABS)
