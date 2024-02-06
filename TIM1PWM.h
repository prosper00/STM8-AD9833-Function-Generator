#ifndef TIM1PWM_H
#define TIM1PWM_H

//includes
	#include "stm8s.h"
	//#include "delay.h"

//function declarations
	void TIM1_Config(void);
	void PWMSetDuty(unsigned int duty);

//defines
	#define CCR1_Val  ((uint16_t)8)
	#define CCR2_Val  ((uint16_t)8)
	#define CCR3_Val  ((uint16_t)8)
	#define CCR4_Val  ((uint16_t)8)


#endif // TIM1PWM_H
