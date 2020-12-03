#include "stm8s.h"
#include "delay.h"

/** Global tick */
volatile uint16_t time_ms;

void TIM4_Config(void)
{
	CLK_PeripheralClockConfig (CLK_PERIPHERAL_TIMER4 , ENABLE); 

	TIM4_DeInit();
	TIM4_TimeBaseInit(TIM4_PRESCALER_128, 125); //TimerClock = 16000000 / 128 / 125 = 1000Hz
	TIM4_ClearFlag(TIM4_FLAG_UPDATE);
	TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);

	enableInterrupts(); // global interrupt enable
	TIM4_Cmd(ENABLE);  //Start Timer 4
}

INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
{
	time_ms++;
	TIM4_ClearITPendingBit(TIM4_IT_UPDATE);
}

/** Delay ms */
void delay_ms(uint16_t ms)
{
	uint16_t start = time_ms;
	uint16_t t2;
	while (1) {
		t2 = time_ms;
		if ((t2 - start) >= ms) {
			break;
		}
	}
} 
