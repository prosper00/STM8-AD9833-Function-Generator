/**
  ******************************************************************************
  * Delay.c - Interrupt-based tick and millisecond delay function
  * Requires a 16MHz CPU to product millisecond ticks. 
  * Edit this line for other clock rates:
  *   TIM4_TimeBaseInit(TIM4_PRESCALER_128, 125); //TimerClock = 16000000 / 128 / 125 = 1000Hz
  *
  * @author  Brad Roy
  * @version V1.0 All major functions implemented and working.
  * @date    04-Dec-2020
  *****************************************************************************/ 
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
/***********************************************************************
 * NOTE: this function will delay until the _start_ of the next 
 * millisecond. delay_ms(1) will NOT give you a full 1 ms of delay, but 
 * an unpredictable delay between 0 and 1 depending on whether we start 
 * the delay at (say) t=999us or t=0ms.
 * 
 * If a precision delay is needed, we'd want to start TIM4 within this 
 * function, and stop it before returning. But, that would break our 1ms 
 * 'tick' timer. ...I wonder if there's a way to read the current TIM4 
 * counter value, which should be 1/125th of 1 ms...?
************************************************************************/
void delay_ms(uint16_t ms)
{
	uint16_t start = time_ms;
	while((time_ms - start) < ms);
}
