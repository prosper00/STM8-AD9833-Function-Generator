#ifndef DELAY_H
#define DELAY_H

/** Global tick */
extern volatile uint16_t time_ms;

/** Millis tick handler */
void TIM4_UPD_OVF_IRQHandler(void) INTERRUPT(23);
void TIM4_Config(void);

void delay_ms(uint16_t ms);


#endif //DELAY_H
