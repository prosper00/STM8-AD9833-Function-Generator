#ifndef DELAY_H
#define DELAY_H

/** Global tick */
extern volatile uint16_t time_ms;

/** Millis tick handler */
void TIM4_UPD_OVF_IRQHandler(void) INTERRUPT(23);
void TIM4_Config(void);

void Delay(uint16_t ms);
#define delay_ms(ms) Delay(ms>>1)


#endif //DELAY_H
