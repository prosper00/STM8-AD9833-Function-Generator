/**
  ******************************************************************************
  * FuncGen - A function generator based on the AD9833, controlled by an STM8
  *
  * @author  Brad Roy
  * @version V1.1dev Rotary Encoder support
  * @date    04-Dec-2020
  *****************************************************************************/ 

static void CLK_Config(void);
static void SPI_Config(void);
static void GPIO_Config(void);
static void Setup(void);
static int  enc_read(void);
inline long map(long x, long in_min, long in_max, long out_min, long out_max) {
  return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}

int putchar(int c);
//int getchar(void);

/* Pin Assignments------------------------------------------------------------*/
//awkward - pin d2 == ADC1 channel3, would be nice to do this with one #define instead of two
#define POTPIN GPIOD, GPIO_PIN_2  //our frequency control potentiometer pin
#define POTCH ADC1_CHANNEL_3      //make sure this corresponds to the pin chosed on previous

/* Pin Assignment for AD9833. Assumes CLK and DAT are using hardware SPI pins */
#define SPISS GPIOC, GPIO_PIN_7   //our slave select pin: defined in AD9833.c

/* Pins Assignment for LCD module, 4-bit mode */
#define LCD_DB7 GPIOC,GPIO_PIN_4 // C4
#define LCD_DB6 GPIOC,GPIO_PIN_3 // C3
#define LCD_DB5 GPIOB,GPIO_PIN_4 // B4
#define LCD_DB4 GPIOB,GPIO_PIN_5 // B5
#define LCD_EN  GPIOA,GPIO_PIN_2 // A2
#define LCD_RS  GPIOA,GPIO_PIN_1 // A1

#define ENCODER_BTN GPIOD,GPIO_PIN_6  // mode shift button
#define ENCODER_1   GPIOD,GPIO_PIN_3
#define ENCODER_2   GPIOD,GPIO_PIN_4

#define TICK_PIN GPIOD,GPIO_PIN_5  //output our systick frequency on this pin

//globals for our ISR to use - probably better to set up a struct to represent our encoder....
volatile unsigned int encoder_btn_event = 0, encoder_left = 0, encoder_right = 0, encoder_polled = 0;

//strings for our display
char modes[3][9]={"SINE    ","TRIANGLE","SQUARE  "};
