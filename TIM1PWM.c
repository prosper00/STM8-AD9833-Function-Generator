#include "TIM1PWM.h"

void TIM1_Config(void)
{

   unsigned int period = 16;

   TIM1_DeInit();
	//Time base is F_CPU / prescaler
	//the maximum duty cycle is 0 to 'period'
	//alternatively, duty cycle is pulsewidth / period
	//PWM frequency is time base / period
	TIM1_TimeBaseInit(	
						0,						//Prescaler 
						TIM1_COUNTERMODE_UP,	//Countmode
						period,					//Period
						0						//Repetition counter
	);//TIM1_TimeBase_Init

	/*TIM1_Pulse = CCR3_Val*/
	TIM1_OC3Init(		TIM1_OCMODE_PWM2,			//Output mode
						TIM1_OUTPUTSTATE_ENABLE,	//Output State
						TIM1_OUTPUTNSTATE_DISABLE,	//Complementary state
						period/2, 					//Pulse Width
						TIM1_OCPOLARITY_LOW,		//Output Polarity
						TIM1_OCNPOLARITY_HIGH,		//Complementary output polarity
						TIM1_OCIDLESTATE_SET,		//Idle State
						TIM1_OCNIDLESTATE_RESET		//Complementary idle state
	);//TIM1_OC3Init

	/* TIM1 counter enable */
	TIM1_Cmd(ENABLE);

	/* TIM1 Main Output Enable */
	TIM1_CtrlPWMOutputs(ENABLE);
}

void PWMSetDuty(unsigned int duty){
	TIM1_SetCompare3(duty);
}

/*
void 	TIM1_PrescalerConfig (uint16_t Prescaler, TIM1_PSCReloadMode_TypeDef TIM1_PSCReloadMode)
 	Configures the TIM1 Prescaler. 

void 	TIM1_SetAutoreload (uint16_t Autoreload)
 	Sets the TIM1 Autoreload Register value. 
*/
 
 
 
