EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Amplifier_Operational:LM358 U1
U 1 1 600B1E41
P 7450 4900
F 0 "U1" H 7450 5267 50  0000 C CNN
F 1 "LT1364" H 7450 5176 50  0000 C CNN
F 2 "" H 7450 4900 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/lm2904-n.pdf" H 7450 4900 50  0001 C CNN
	1    7450 4900
	1    0    0    -1  
$EndComp
$Comp
L Amplifier_Operational:LM358 U1
U 2 1 600B2B24
P 8550 5000
F 0 "U1" H 8550 5367 50  0000 C CNN
F 1 "LT1364" H 8550 5276 50  0000 C CNN
F 2 "" H 8550 5000 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/lm2904-n.pdf" H 8550 5000 50  0001 C CNN
	2    8550 5000
	1    0    0    -1  
$EndComp
$Comp
L Device:R_US R3
U 1 1 600B6447
P 6900 5000
F 0 "R3" V 7100 5000 50  0000 C CNN
F 1 "1k" V 7000 5000 50  0000 C CNN
F 2 "" V 6940 4990 50  0001 C CNN
F 3 "~" H 6900 5000 50  0001 C CNN
	1    6900 5000
	0    1    1    0   
$EndComp
$Comp
L Device:R_US R2
U 1 1 600B69AF
P 6900 4800
F 0 "R2" V 6695 4800 50  0000 C CNN
F 1 "1k" V 6786 4800 50  0000 C CNN
F 2 "" V 6940 4790 50  0001 C CNN
F 3 "~" H 6900 4800 50  0001 C CNN
	1    6900 4800
	0    1    1    0   
$EndComp
$Comp
L Device:R_US R1
U 1 1 600B6DEC
P 6500 5100
F 0 "R1" H 6350 5150 50  0000 L CNN
F 1 "10k" H 6250 5050 50  0000 L CNN
F 2 "" V 6540 5090 50  0001 C CNN
F 3 "~" H 6500 5100 50  0001 C CNN
	1    6500 5100
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR02
U 1 1 600C46E1
P 6700 5350
F 0 "#PWR02" H 6700 5100 50  0001 C CNN
F 1 "GND" H 6705 5177 50  0000 C CNN
F 2 "" H 6700 5350 50  0001 C CNN
F 3 "" H 6700 5350 50  0001 C CNN
	1    6700 5350
	1    0    0    -1  
$EndComp
Wire Wire Line
	6500 4950 6500 4800
Wire Wire Line
	6500 4800 6750 4800
Wire Wire Line
	6700 5350 6700 5000
Wire Wire Line
	6700 5000 6750 5000
$Comp
L power:GND #PWR01
U 1 1 600CCE84
P 6500 5350
F 0 "#PWR01" H 6500 5100 50  0001 C CNN
F 1 "GND" H 6505 5177 50  0000 C CNN
F 2 "" H 6500 5350 50  0001 C CNN
F 3 "" H 6500 5350 50  0001 C CNN
	1    6500 5350
	1    0    0    -1  
$EndComp
Wire Wire Line
	6500 5250 6500 5350
Wire Wire Line
	7050 4800 7150 4800
Wire Wire Line
	7050 5000 7100 5000
$Comp
L Device:C C1
U 1 1 600CEED6
P 6250 4800
F 0 "C1" V 5998 4800 50  0000 C CNN
F 1 "C" V 6089 4800 50  0000 C CNN
F 2 "" H 6288 4650 50  0001 C CNN
F 3 "~" H 6250 4800 50  0001 C CNN
	1    6250 4800
	0    1    1    0   
$EndComp
Wire Wire Line
	6400 4800 6500 4800
Connection ~ 6500 4800
Wire Wire Line
	6100 4800 5850 4800
Text Label 5850 4800 0    50   ~ 0
V_SIG
$Comp
L Amplifier_Operational:LM358 U1
U 3 1 600D56A4
P 10000 5000
F 0 "U1" H 9650 5050 50  0000 L CNN
F 1 "LT1364" H 9600 4950 50  0000 L CNN
F 2 "" H 10000 5000 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/lm2904-n.pdf" H 10000 5000 50  0001 C CNN
	3    10000 5000
	1    0    0    -1  
$EndComp
$Comp
L power:+15V #PWR06
U 1 1 600E811B
P 9900 4200
F 0 "#PWR06" H 9900 4050 50  0001 C CNN
F 1 "+15V" H 9915 4373 50  0000 C CNN
F 2 "" H 9900 4200 50  0001 C CNN
F 3 "" H 9900 4200 50  0001 C CNN
	1    9900 4200
	1    0    0    -1  
$EndComp
$Comp
L power:-15V #PWR07
U 1 1 600E885F
P 9900 5800
F 0 "#PWR07" H 9900 5900 50  0001 C CNN
F 1 "-15V" H 9915 5973 50  0000 C CNN
F 2 "" H 9900 5800 50  0001 C CNN
F 3 "" H 9900 5800 50  0001 C CNN
	1    9900 5800
	-1   0    0    1   
$EndComp
Wire Wire Line
	9900 4200 9900 4250
$Comp
L Device:C C3
U 1 1 600F9A9E
P 10050 5550
F 0 "C3" H 9935 5504 50  0000 R CNN
F 1 "100n" H 9935 5595 50  0000 R CNN
F 2 "" H 10088 5400 50  0001 C CNN
F 3 "~" H 10050 5550 50  0001 C CNN
	1    10050 5550
	-1   0    0    1   
$EndComp
$Comp
L Device:C C2
U 1 1 600FCABB
P 10050 4450
F 0 "C2" H 9935 4404 50  0000 R CNN
F 1 "100n" H 9935 4495 50  0000 R CNN
F 2 "" H 10088 4300 50  0001 C CNN
F 3 "~" H 10050 4450 50  0001 C CNN
	1    10050 4450
	-1   0    0    1   
$EndComp
Wire Wire Line
	10050 4300 10050 4250
Wire Wire Line
	10050 4250 9900 4250
Connection ~ 9900 4250
Wire Wire Line
	10050 4600 10050 4650
Wire Wire Line
	10050 5400 10050 5350
Wire Wire Line
	10050 5700 10050 5750
Wire Wire Line
	10050 5750 9900 5750
Connection ~ 9900 5750
Wire Wire Line
	9900 5750 9900 5800
$Comp
L Device:C C5
U 1 1 6011BBE4
P 10350 5550
F 0 "C5" H 10235 5504 50  0000 R CNN
F 1 "10u" H 10235 5595 50  0000 R CNN
F 2 "" H 10388 5400 50  0001 C CNN
F 3 "~" H 10350 5550 50  0001 C CNN
	1    10350 5550
	-1   0    0    1   
$EndComp
$Comp
L Device:C C4
U 1 1 6011C1DF
P 10350 4450
F 0 "C4" H 10235 4404 50  0000 R CNN
F 1 "10u" H 10235 4495 50  0000 R CNN
F 2 "" H 10388 4300 50  0001 C CNN
F 3 "~" H 10350 4450 50  0001 C CNN
	1    10350 4450
	-1   0    0    1   
$EndComp
Wire Wire Line
	10050 4250 10350 4250
Wire Wire Line
	10350 4250 10350 4300
Connection ~ 10050 4250
Wire Wire Line
	10350 4600 10350 4650
Wire Wire Line
	10350 4650 10200 4650
Wire Wire Line
	10050 5350 10200 5350
Wire Wire Line
	10350 5350 10350 5400
Wire Wire Line
	10350 5700 10350 5750
Wire Wire Line
	10350 5750 10050 5750
Connection ~ 10050 5750
Wire Wire Line
	9900 4250 9900 4700
Wire Wire Line
	9900 5300 9900 5750
$Comp
L power:GND #PWR08
U 1 1 6011EED0
P 10200 4700
F 0 "#PWR08" H 10200 4450 50  0001 C CNN
F 1 "GND" H 10205 4527 50  0000 C CNN
F 2 "" H 10200 4700 50  0001 C CNN
F 3 "" H 10200 4700 50  0001 C CNN
	1    10200 4700
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR09
U 1 1 6011F480
P 10200 5300
F 0 "#PWR09" H 10200 5050 50  0001 C CNN
F 1 "GND" H 10205 5127 50  0000 C CNN
F 2 "" H 10200 5300 50  0001 C CNN
F 3 "" H 10200 5300 50  0001 C CNN
	1    10200 5300
	-1   0    0    1   
$EndComp
Wire Wire Line
	10200 4700 10200 4650
Connection ~ 10200 4650
Wire Wire Line
	10200 4650 10050 4650
Wire Wire Line
	10200 5300 10200 5350
Connection ~ 10200 5350
Wire Wire Line
	10200 5350 10350 5350
$Comp
L Device:R_US R4
U 1 1 60126DB9
P 8000 4900
F 0 "R4" H 7850 4950 50  0000 L CNN
F 1 "10k" H 7750 4850 50  0000 L CNN
F 2 "" V 8040 4890 50  0001 C CNN
F 3 "~" H 8000 4900 50  0001 C CNN
	1    8000 4900
	0    1    1    0   
$EndComp
Wire Wire Line
	7750 4900 7800 4900
Wire Wire Line
	8150 4900 8200 4900
$Comp
L Device:R_POT_US RV1
U 1 1 6012A936
P 7400 5300
F 0 "RV1" V 7195 5300 50  0000 C CNN
F 1 "100k" V 7286 5300 50  0000 C CNN
F 2 "" H 7400 5300 50  0001 C CNN
F 3 "~" H 7400 5300 50  0001 C CNN
	1    7400 5300
	0    1    1    0   
$EndComp
$Comp
L Device:R_POT_US RV2
U 1 1 6012D44C
P 8000 4000
F 0 "RV2" H 7932 4046 50  0000 R CNN
F 1 "10k" H 7932 3955 50  0000 R CNN
F 2 "" H 8000 4000 50  0001 C CNN
F 3 "~" H 8000 4000 50  0001 C CNN
	1    8000 4000
	1    0    0    -1  
$EndComp
Wire Wire Line
	7400 5450 7400 5500
Wire Wire Line
	7400 5500 7600 5500
Wire Wire Line
	7600 5500 7600 5300
Wire Wire Line
	7600 5300 7550 5300
Wire Wire Line
	7100 5300 7250 5300
Connection ~ 7100 5000
Wire Wire Line
	7100 5000 7150 5000
Wire Wire Line
	7800 5300 7600 5300
Connection ~ 7800 4900
Wire Wire Line
	7800 4900 7850 4900
Connection ~ 7600 5300
Wire Wire Line
	7100 5000 7100 5300
Wire Wire Line
	7800 4900 7800 5300
$Comp
L power:-15V #PWR04
U 1 1 601476E5
P 8000 4250
F 0 "#PWR04" H 8000 4350 50  0001 C CNN
F 1 "-15V" H 8015 4423 50  0000 C CNN
F 2 "" H 8000 4250 50  0001 C CNN
F 3 "" H 8000 4250 50  0001 C CNN
	1    8000 4250
	-1   0    0    1   
$EndComp
$Comp
L power:+15V #PWR03
U 1 1 60147D74
P 8000 3750
F 0 "#PWR03" H 8000 3600 50  0001 C CNN
F 1 "+15V" H 8015 3923 50  0000 C CNN
F 2 "" H 8000 3750 50  0001 C CNN
F 3 "" H 8000 3750 50  0001 C CNN
	1    8000 3750
	1    0    0    -1  
$EndComp
Wire Wire Line
	8000 3750 8000 3850
Wire Wire Line
	8000 4150 8000 4250
$Comp
L Device:R_US R5
U 1 1 6014A3DF
P 8200 4650
F 0 "R5" H 8050 4700 50  0000 L CNN
F 1 "10k" H 7950 4600 50  0000 L CNN
F 2 "" V 8240 4640 50  0001 C CNN
F 3 "~" H 8200 4650 50  0001 C CNN
	1    8200 4650
	-1   0    0    1   
$EndComp
Connection ~ 8200 4900
Wire Wire Line
	8200 4900 8250 4900
Wire Wire Line
	8200 4900 8200 4800
Wire Wire Line
	8200 4500 8200 4000
Wire Wire Line
	8200 4000 8150 4000
Wire Wire Line
	8850 5000 9000 5000
$Comp
L Device:R_US R7
U 1 1 60164D84
P 8600 5300
F 0 "R7" H 8700 5350 50  0000 L CNN
F 1 "10k" H 8700 5250 50  0000 L CNN
F 2 "" V 8640 5290 50  0001 C CNN
F 3 "~" H 8600 5300 50  0001 C CNN
	1    8600 5300
	0    1    1    0   
$EndComp
Wire Wire Line
	8750 5300 9000 5300
Wire Wire Line
	9000 5300 9000 5000
Connection ~ 9000 5000
Wire Wire Line
	9000 5000 9200 5000
Wire Wire Line
	8250 5100 8200 5100
Text Label 9050 5000 0    50   ~ 0
OUT
$Comp
L power:GND #PWR05
U 1 1 60167637
P 8200 5800
F 0 "#PWR05" H 8200 5550 50  0001 C CNN
F 1 "GND" H 8205 5627 50  0000 C CNN
F 2 "" H 8200 5800 50  0001 C CNN
F 3 "" H 8200 5800 50  0001 C CNN
	1    8200 5800
	1    0    0    -1  
$EndComp
$Comp
L Device:R_US R6
U 1 1 601644EC
P 8200 5550
F 0 "R6" H 8050 5600 50  0000 L CNN
F 1 "10k" H 7950 5500 50  0000 L CNN
F 2 "" V 8240 5540 50  0001 C CNN
F 3 "~" H 8200 5550 50  0001 C CNN
	1    8200 5550
	1    0    0    -1  
$EndComp
Wire Wire Line
	8200 5100 8200 5300
Wire Wire Line
	8200 5300 8450 5300
Wire Wire Line
	8200 5300 8200 5400
Connection ~ 8200 5300
Wire Wire Line
	8200 5800 8200 5700
$Comp
L STM8S103Blue:STM8S103F3_Blue U2
U 1 1 60140B79
P 2300 3350
F 0 "U2" H 2300 4115 50  0000 C CNN
F 1 "STM8S103F3_Blue" H 2300 4024 50  0000 C CNN
F 2 "" H 2500 4000 50  0001 C CNN
F 3 "" H 2500 4000 50  0001 C CNN
	1    2300 3350
	1    0    0    -1  
$EndComp
$Comp
L HD44780:HD44780 DIS1
U 1 1 601430DF
P 2000 1550
F 0 "DIS1" V 2667 500 50  0000 C CNN
F 1 "HD44780" V 2576 500 50  0000 C CNN
F 2 "16026-16X2" H 2000 1550 50  0001 L BNN
F 3 "" H 2000 1550 50  0001 L BNN
F 4 "5V" H 2000 1550 50  0001 L BNN "VOLTAGE"
F 5 "N/A" H 2000 1550 50  0001 L BNN "MGF#"
	1    2000 1550
	0    -1   -1   0   
$EndComp
$Comp
L AD9833~Module:CJMCU_AD9833 U3
U 1 1 6014CDA6
P 5550 3350
F 0 "U3" V 5562 3628 50  0000 L CNN
F 1 "CJMCU_AD9833" V 5653 3628 50  0000 L CNN
F 2 "" H 5550 3650 50  0001 C CNN
F 3 "" H 5550 3650 50  0001 C CNN
	1    5550 3350
	0    1    1    0   
$EndComp
$Comp
L Device:R_POT_TRIM_US RV4
U 1 1 60152081
P 4450 1350
F 0 "RV4" H 4350 1400 50  0000 R CNN
F 1 "5k" H 4350 1300 50  0000 R CNN
F 2 "" H 4450 1350 50  0001 C CNN
F 3 "~" H 4450 1350 50  0001 C CNN
	1    4450 1350
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR014
U 1 1 6015597E
P 3350 2750
F 0 "#PWR014" H 3350 2600 50  0001 C CNN
F 1 "+5V" H 3365 2923 50  0000 C CNN
F 2 "" H 3350 2750 50  0001 C CNN
F 3 "" H 3350 2750 50  0001 C CNN
	1    3350 2750
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR010
U 1 1 60170584
P 1250 2950
F 0 "#PWR010" H 1250 2700 50  0001 C CNN
F 1 "GND" H 1255 2777 50  0000 C CNN
F 2 "" H 1250 2950 50  0001 C CNN
F 3 "" H 1250 2950 50  0001 C CNN
	1    1250 2950
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR019
U 1 1 6017A3AC
P 5050 2800
F 0 "#PWR019" H 5050 2650 50  0001 C CNN
F 1 "+5V" H 5065 2973 50  0000 C CNN
F 2 "" H 5050 2800 50  0001 C CNN
F 3 "" H 5050 2800 50  0001 C CNN
	1    5050 2800
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR018
U 1 1 6017A924
P 4800 4000
F 0 "#PWR018" H 4800 3750 50  0001 C CNN
F 1 "GND" H 4805 3827 50  0000 C CNN
F 2 "" H 4800 4000 50  0001 C CNN
F 3 "" H 4800 4000 50  0001 C CNN
	1    4800 4000
	1    0    0    -1  
$EndComp
Wire Wire Line
	5200 3250 4800 3250
Wire Wire Line
	4800 3250 4800 4000
Wire Wire Line
	5200 3150 5050 3150
Wire Wire Line
	5050 3150 5050 2800
Wire Wire Line
	5200 3350 4950 3350
Wire Wire Line
	5200 3450 4950 3450
Wire Wire Line
	5200 3550 4950 3550
Wire Wire Line
	5200 3650 4950 3650
Text Label 4950 3650 0    50   ~ 0
V_SIG
Text Label 4950 3550 0    50   ~ 0
SS
Wire Wire Line
	2800 3300 3050 3300
Text Label 3050 3300 0    50   ~ 0
SS
Wire Wire Line
	2800 3400 3050 3400
Wire Wire Line
	2800 3500 3050 3500
Text Label 3050 3400 0    50   ~ 0
MOSI
Text Label 4950 3350 0    50   ~ 0
MOSI
Text Label 3050 3500 0    50   ~ 0
CLK
Text Label 4950 3450 0    50   ~ 0
CLK
$Comp
L Device:R_US R9
U 1 1 601A7794
P 3250 3800
F 0 "R9" V 3050 3800 50  0000 C CNN
F 1 "10k" V 3150 3800 50  0000 C CNN
F 2 "" V 3290 3790 50  0001 C CNN
F 3 "~" H 3250 3800 50  0001 C CNN
	1    3250 3800
	0    1    1    0   
$EndComp
$Comp
L Device:R_US R10
U 1 1 601A8E21
P 3250 3900
F 0 "R10" V 3450 3900 50  0000 C CNN
F 1 "10k" V 3350 3900 50  0000 C CNN
F 2 "" V 3290 3890 50  0001 C CNN
F 3 "~" H 3250 3900 50  0001 C CNN
	1    3250 3900
	0    1    1    0   
$EndComp
$Comp
L power:+5V #PWR016
U 1 1 601B23AA
P 3450 3700
F 0 "#PWR016" H 3450 3550 50  0001 C CNN
F 1 "+5V" H 3465 3873 50  0000 C CNN
F 2 "" H 3450 3700 50  0001 C CNN
F 3 "" H 3450 3700 50  0001 C CNN
	1    3450 3700
	1    0    0    -1  
$EndComp
Wire Wire Line
	3400 3800 3450 3800
Wire Wire Line
	3450 3800 3450 3700
Wire Wire Line
	3400 3900 3450 3900
Wire Wire Line
	3450 3900 3450 3800
Connection ~ 3450 3800
Text Label 2800 3800 0    50   ~ 0
LCD_D5
Text Label 2800 3900 0    50   ~ 0
LCD_D4
Text Label 2800 3700 0    50   ~ 0
LCD_D6
Text Label 2800 3600 0    50   ~ 0
LCD_D7
Text Label 3500 1650 3    50   ~ 0
LCD_D7
Text Label 3400 1650 3    50   ~ 0
LCD_D6
Text Label 3300 1650 3    50   ~ 0
LCD_D5
Text Label 3200 1650 3    50   ~ 0
LCD_D4
Wire Wire Line
	2800 3100 3050 3100
Text Label 3050 3100 0    50   ~ 0
FREQ_POT
Wire Wire Line
	1800 3800 1650 3800
Wire Wire Line
	1650 3800 1650 3700
Wire Wire Line
	1650 3700 1800 3700
Wire Wire Line
	1800 2850 1250 2850
Wire Wire Line
	1250 2850 1250 2950
Wire Wire Line
	2800 2850 3350 2850
Wire Wire Line
	3350 2850 3350 2750
Wire Wire Line
	1800 3000 1650 3000
Wire Wire Line
	1800 3200 1650 3200
Wire Wire Line
	1800 3400 1500 3400
Text Label 1500 3400 0    50   ~ 0
LCD_RS
Wire Wire Line
	1800 3500 1500 3500
Text Label 1500 3500 0    50   ~ 0
LCD_EN
Text Label 2600 1650 3    50   ~ 0
LCD_EN
Text Label 2400 1650 3    50   ~ 0
LCD_RS
$Comp
L power:GND #PWR015
U 1 1 602C2FEA
P 2500 2000
F 0 "#PWR015" H 2500 1750 50  0001 C CNN
F 1 "GND" H 2505 1827 50  0000 C CNN
F 2 "" H 2500 2000 50  0001 C CNN
F 3 "" H 2500 2000 50  0001 C CNN
	1    2500 2000
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR013
U 1 1 602C352A
P 2200 2000
F 0 "#PWR013" H 2200 1750 50  0001 C CNN
F 1 "GND" H 2205 1827 50  0000 C CNN
F 2 "" H 2200 2000 50  0001 C CNN
F 3 "" H 2200 2000 50  0001 C CNN
	1    2200 2000
	1    0    0    -1  
$EndComp
Wire Wire Line
	2500 1650 2500 2000
Wire Wire Line
	2200 1650 2200 2000
$Comp
L power:GND #PWR025
U 1 1 602CC841
P 4450 1650
F 0 "#PWR025" H 4450 1400 50  0001 C CNN
F 1 "GND" H 4455 1477 50  0000 C CNN
F 2 "" H 4450 1650 50  0001 C CNN
F 3 "" H 4450 1650 50  0001 C CNN
	1    4450 1650
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR024
U 1 1 602CCE3C
P 4450 1050
F 0 "#PWR024" H 4450 900 50  0001 C CNN
F 1 "+5V" H 4465 1223 50  0000 C CNN
F 2 "" H 4450 1050 50  0001 C CNN
F 3 "" H 4450 1050 50  0001 C CNN
	1    4450 1050
	1    0    0    -1  
$EndComp
Wire Wire Line
	4450 1050 4450 1200
Wire Wire Line
	4450 1500 4450 1650
Wire Wire Line
	4600 1350 4700 1350
Text Label 4700 1350 0    50   ~ 0
LCD_VO
Text Label 3700 1650 3    50   ~ 0
LCD_VO
$Comp
L power:+5V #PWR022
U 1 1 602E64E1
P 3900 2150
F 0 "#PWR022" H 3900 2000 50  0001 C CNN
F 1 "+5V" H 3915 2323 50  0000 C CNN
F 2 "" H 3900 2150 50  0001 C CNN
F 3 "" H 3900 2150 50  0001 C CNN
	1    3900 2150
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR023
U 1 1 602F8482
P 4100 1650
F 0 "#PWR023" H 4100 1400 50  0001 C CNN
F 1 "GND" H 4105 1477 50  0000 C CNN
F 2 "" H 4100 1650 50  0001 C CNN
F 3 "" H 4100 1650 50  0001 C CNN
	1    4100 1650
	1    0    0    -1  
$EndComp
Wire Wire Line
	4000 1650 4100 1650
$Comp
L power:+5V #PWR012
U 1 1 6030C97C
P 1850 1650
F 0 "#PWR012" H 1850 1500 50  0001 C CNN
F 1 "+5V" H 1865 1823 50  0000 C CNN
F 2 "" H 1850 1650 50  0001 C CNN
F 3 "" H 1850 1650 50  0001 C CNN
	1    1850 1650
	1    0    0    -1  
$EndComp
Wire Wire Line
	1850 1650 2100 1650
$Comp
L Device:R_US R12
U 1 1 603604F0
P 3900 1900
F 0 "R12" V 3700 1900 50  0000 C CNN
F 1 "10k" V 3800 1900 50  0000 C CNN
F 2 "" V 3940 1890 50  0001 C CNN
F 3 "~" H 3900 1900 50  0001 C CNN
	1    3900 1900
	-1   0    0    1   
$EndComp
Wire Wire Line
	2800 3800 3100 3800
Wire Wire Line
	2800 3900 3100 3900
Wire Wire Line
	3900 1650 3900 1750
Wire Wire Line
	3900 2050 3900 2150
$Comp
L power:+5V #PWR?
U 1 1 604C5E89
P 3950 3100
F 0 "#PWR?" H 3950 2950 50  0001 C CNN
F 1 "+5V" H 3965 3273 50  0000 C CNN
F 2 "" H 3950 3100 50  0001 C CNN
F 3 "" H 3950 3100 50  0001 C CNN
	1    3950 3100
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR?
U 1 1 604C665E
P 4200 3100
F 0 "#PWR?" H 4200 2950 50  0001 C CNN
F 1 "+5V" H 4215 3273 50  0000 C CNN
F 2 "" H 4200 3100 50  0001 C CNN
F 3 "" H 4200 3100 50  0001 C CNN
	1    4200 3100
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 604C6DC5
P 3950 3400
F 0 "#PWR?" H 3950 3150 50  0001 C CNN
F 1 "GND" H 3955 3227 50  0000 C CNN
F 2 "" H 3950 3400 50  0001 C CNN
F 3 "" H 3950 3400 50  0001 C CNN
	1    3950 3400
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 604C74CC
P 4200 3400
F 0 "#PWR?" H 4200 3150 50  0001 C CNN
F 1 "GND" H 4205 3227 50  0000 C CNN
F 2 "" H 4200 3400 50  0001 C CNN
F 3 "" H 4200 3400 50  0001 C CNN
	1    4200 3400
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C?
U 1 1 604C7C3B
P 3950 3250
F 0 "C?" H 3750 3300 50  0000 L CNN
F 1 "10u" H 3700 3200 50  0000 L CNN
F 2 "" H 3950 3250 50  0001 C CNN
F 3 "~" H 3950 3250 50  0001 C CNN
	1    3950 3250
	1    0    0    -1  
$EndComp
$Comp
L Device:CP1_Small C?
U 1 1 604E7780
P 4200 3250
F 0 "C?" H 4291 3296 50  0000 L CNN
F 1 "1000u" H 4291 3205 50  0000 L CNN
F 2 "" H 4200 3250 50  0001 C CNN
F 3 "~" H 4200 3250 50  0001 C CNN
	1    4200 3250
	1    0    0    -1  
$EndComp
Wire Wire Line
	3950 3100 3950 3150
Wire Wire Line
	4200 3100 4200 3150
Wire Wire Line
	4200 3350 4200 3400
Wire Wire Line
	3950 3350 3950 3400
Wire Wire Line
	5550 3850 5550 4050
Text Label 5550 4050 0    50   ~ 0
V_SIG
$Comp
L Device:Rotary_Encoder_Switch SW?
U 1 1 608E2BAD
P 2850 5400
F 0 "SW?" H 2850 5767 50  0000 C CNN
F 1 "Rotary_Encoder_Switch" H 2850 5676 50  0000 C CNN
F 2 "" H 2700 5560 50  0001 C CNN
F 3 "~" H 2850 5660 50  0001 C CNN
	1    2850 5400
	1    0    0    -1  
$EndComp
Text Label 2150 5200 1    50   ~ 0
ENCODER_1
Text Label 2150 5600 3    50   ~ 0
ENCODER_2
$Comp
L power:GND #PWR?
U 1 1 60908A19
P 1550 5400
F 0 "#PWR?" H 1550 5150 50  0001 C CNN
F 1 "GND" H 1555 5227 50  0000 C CNN
F 2 "" H 1550 5400 50  0001 C CNN
F 3 "" H 1550 5400 50  0001 C CNN
	1    1550 5400
	1    0    0    -1  
$EndComp
Text Label 3550 5200 1    50   ~ 0
ENCODER_SW
$Comp
L power:GND #PWR?
U 1 1 6090D3DD
P 3150 5600
F 0 "#PWR?" H 3150 5350 50  0001 C CNN
F 1 "GND" H 3155 5427 50  0000 C CNN
F 2 "" H 3150 5600 50  0001 C CNN
F 3 "" H 3150 5600 50  0001 C CNN
	1    3150 5600
	1    0    0    -1  
$EndComp
Wire Wire Line
	3150 5500 3150 5600
Text Label 1800 3000 2    50   ~ 0
ENCODER_2
Text Label 1800 3200 2    50   ~ 0
ENCODER_SW
Text Label 3050 3000 0    50   ~ 0
ENCODER_1
$Comp
L Device:C_Small C?
U 1 1 60916960
P 2000 5300
F 0 "C?" H 1800 5350 50  0000 L CNN
F 1 "100n" H 1750 5250 50  0000 L CNN
F 2 "" H 2000 5300 50  0001 C CNN
F 3 "~" H 2000 5300 50  0001 C CNN
	1    2000 5300
	0    1    1    0   
$EndComp
$Comp
L Device:C_Small C?
U 1 1 60917206
P 2000 5500
F 0 "C?" H 1800 5550 50  0000 L CNN
F 1 "100n" H 1750 5450 50  0000 L CNN
F 2 "" H 2000 5500 50  0001 C CNN
F 3 "~" H 2000 5500 50  0001 C CNN
	1    2000 5500
	0    -1   -1   0   
$EndComp
$Comp
L Device:R_US R?
U 1 1 60917F3B
P 2350 5500
F 0 "R?" V 2550 5500 50  0000 C CNN
F 1 "27k" V 2450 5500 50  0000 C CNN
F 2 "" V 2390 5490 50  0001 C CNN
F 3 "~" H 2350 5500 50  0001 C CNN
	1    2350 5500
	0    1    1    0   
$EndComp
$Comp
L Device:R_US R?
U 1 1 60918649
P 2350 5300
F 0 "R?" V 2550 5300 50  0000 C CNN
F 1 "27k" V 2450 5300 50  0000 C CNN
F 2 "" V 2390 5290 50  0001 C CNN
F 3 "~" H 2350 5300 50  0001 C CNN
	1    2350 5300
	0    -1   -1   0   
$EndComp
Wire Wire Line
	1550 5400 1850 5400
Wire Wire Line
	1900 5300 1850 5300
Wire Wire Line
	1850 5300 1850 5400
Connection ~ 1850 5400
Wire Wire Line
	1850 5400 2550 5400
Wire Wire Line
	1850 5400 1850 5500
Wire Wire Line
	1850 5500 1900 5500
Wire Wire Line
	2100 5500 2150 5500
Wire Wire Line
	2200 5300 2150 5300
Wire Wire Line
	2150 5300 2150 5200
Connection ~ 2150 5300
Wire Wire Line
	2150 5300 2100 5300
Wire Wire Line
	2150 5500 2150 5600
Connection ~ 2150 5500
Wire Wire Line
	2150 5500 2200 5500
Wire Wire Line
	2500 5300 2550 5300
Wire Wire Line
	2550 5500 2500 5500
$Comp
L Device:R_US R?
U 1 1 60990AD4
P 3350 5300
F 0 "R?" V 3550 5300 50  0000 C CNN
F 1 "27k" V 3450 5300 50  0000 C CNN
F 2 "" V 3390 5290 50  0001 C CNN
F 3 "~" H 3350 5300 50  0001 C CNN
	1    3350 5300
	0    -1   -1   0   
$EndComp
$Comp
L Device:C_Small C?
U 1 1 6099E9A4
P 3550 5450
F 0 "C?" H 3350 5500 50  0000 L CNN
F 1 "100n" H 3300 5400 50  0000 L CNN
F 2 "" H 3550 5450 50  0001 C CNN
F 3 "~" H 3550 5450 50  0001 C CNN
	1    3550 5450
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 6099F9C8
P 3550 5600
F 0 "#PWR?" H 3550 5350 50  0001 C CNN
F 1 "GND" H 3555 5427 50  0000 C CNN
F 2 "" H 3550 5600 50  0001 C CNN
F 3 "" H 3550 5600 50  0001 C CNN
	1    3550 5600
	1    0    0    -1  
$EndComp
Wire Wire Line
	3550 5600 3550 5550
Wire Wire Line
	3200 5300 3150 5300
Wire Wire Line
	3500 5300 3550 5300
Wire Wire Line
	3550 5300 3550 5200
Wire Wire Line
	3550 5300 3550 5350
Connection ~ 3550 5300
Wire Wire Line
	2800 3000 3050 3000
Wire Wire Line
	1800 3100 1650 3100
Text Label 1650 3100 2    50   ~ 0
SYSTICK
$EndSCHEMATC
