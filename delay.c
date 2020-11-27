#include "stm8s.h"
#include "delay.h"

/** Global tick */
volatile uint16_t time_ms;

void TIM4_Config(void)
{
	TIM4_UpdateRequestConfig(TIM4_UPDATESOURCE_REGULAR);
	TIM4_PrescalerConfig(TIM4_PRESCALER_128, TIM4_PSCRELOADMODE_IMMEDIATE);
	TIM4_SetAutoreload(0xFF);
	TIM4_ARRPreloadConfig(ENABLE);
	TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);
	TIM4_Cmd(ENABLE);

	enableInterrupts();
}

INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
{
	time_ms++;
	TIM4_ClearITPendingBit(TIM4_IT_UPDATE);
}

/** Delay ms */
void Delay(uint16_t ms)
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

/** Delay N seconds */
void Delay_s(uint16_t s)
{
	while (s != 0) {
		Delay(1000);
		s--;
	}
}

/*void delay_ms(u32 ms){  //hack. Kinda-sorta approximates 1ms. Kinda.
	for(u32 j=0;j<ms;j++)
		for(u32 i=0;i<1000;i++)
			__asm__("nop");
}*/
