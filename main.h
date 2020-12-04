/**
  ******************************************************************************
  * FuncGen - A function generator based on the AD9833, controlled by an STM8
  *
  * @author  Brad Roy
  * @version V1.0 All major functions implemented and working.
  * @date    04-Dec-2020
  *****************************************************************************/ 

static void CLK_Config(void);
static void SPI_Config(void);
static void ADC_Config(void);
static void UART1_Config(void);
static void GPIO_Config(void);
int putchar(int c);
//int getchar(void);

/* Pin Assignments------------------------------------------------------------*/
//awkward - pin d2 == ADC1 channel3, would be nice to do this with one #define instead of two
#define POTPIN GPIOD, GPIO_PIN_2  //our frequency control potentiometer pin
#define POTCH ADC1_CHANNEL_3      // if you change this, you may also have to update ADC_Config()

/* Pin Assignment for AD9833. Assumes CLK and DAT are using hardware SPI pins */
#define SPISS GPIOA, GPIO_PIN_3   //our slave select pin

/* Pins Assignment for LCD module, 4-bit mode */
#define LCD_DB7 GPIOC,GPIO_PIN_4 // C4
#define LCD_DB6 GPIOC,GPIO_PIN_3 // C3
#define LCD_DB5 GPIOB,GPIO_PIN_4 // B4
#define LCD_DB4 GPIOB,GPIO_PIN_5 // B5
#define LCD_EN  GPIOA,GPIO_PIN_2 // A2
#define LCD_RS  GPIOA,GPIO_PIN_1 // A1

#define MODE_BTN GPIOD,GPIO_PIN_4  // mode shift button
#define RANGE_BTN GPIOD,GPIO_PIN_6 // coarse/med/fine button

volatile uint8_t mode_btn_event = 0; // has the mode button been pressed?
volatile uint8_t range_btn_event = 0;// has the range button been pressed?

char modes[3][9]={"SINE    ","TRIANGLE","SQUARE  "};
