//file HD44780.h - LCD external function declarations
 /*LCD Header file to interface 16x2 LCD with STM8S103F
 * Website:
 * https://circuitdigest.com/microcontroller-projects/interfacing-16x2-lcd-display-with-stm8-microcontroller
 * Code by: Aswinth Raj
 * Adapted by: Brad Roy
 */
#ifndef __HD44780_H
#define __HD44780_H
#define __HD44780_H

/* Public functions */
void LCD_Begin(void);
void LCD_Print_Char(char data);
void LCD_Clear(void);
void LCD_Set_Cursor(char a, char b);
void LCD_Print_String(char *a);

/* Internal functions */
void LCD_SetBit(char data_bit);
void LCD_Enable(void);
void LCD_Cmd(char a);

void LCD_SetBit(char data_bit) //Based on the Hex value Set the Bits of the Data Lines
{
    if(data_bit&1)
        GPIO_WriteHigh(LCD_DB4);
    else 
        GPIO_WriteLow(LCD_DB4);

    if(data_bit& 2)
        GPIO_WriteHigh(LCD_DB5); //D5 = 1
    else
        GPIO_WriteLow(LCD_DB5); //D5=0

    if(data_bit& 4)
        GPIO_WriteHigh(LCD_DB6); //D6 = 1
    else
        GPIO_WriteLow(LCD_DB6); //D6=0

    if(data_bit& 8) 
        GPIO_WriteHigh(LCD_DB7); //D7 = 1
    else
        GPIO_WriteLow(LCD_DB7); //D7=0
}

void LCD_Enable(void)
{
    GPIO_WriteHigh(LCD_EN);    //EN  = 1         
    delay_ms(2);
    GPIO_WriteLow(LCD_EN);     //EN  = 0   
    GPIO_WriteHigh(LCD_DB4);   //Turn off LED (shared with bit 4)
   
}

void LCD_Cmd(char a)
{
    GPIO_WriteLow(LCD_RS);     //RS = 0          
    LCD_SetBit(a);             //Incoming Hex value
    LCD_Enable();
}

void LCD_Begin(void)
{
//Initialize all GPIO pins as Output 
   GPIO_Init(LCD_RS,  GPIO_MODE_OUT_PP_HIGH_FAST);
   GPIO_Init(LCD_EN,  GPIO_MODE_OUT_PP_HIGH_FAST);
   GPIO_Init(LCD_DB4, GPIO_MODE_OUT_PP_HIGH_FAST);
   GPIO_Init(LCD_DB5, GPIO_MODE_OUT_PP_HIGH_FAST);
   GPIO_Init(LCD_DB6, GPIO_MODE_OUT_PP_HIGH_FAST);
   GPIO_Init(LCD_DB7, GPIO_MODE_OUT_PP_HIGH_FAST);
   delay_ms(10);
 
   LCD_SetBit(0x00);
   delay_ms(1000);

   LCD_Cmd(0x03);
   delay_ms(5);

   LCD_Cmd(0x03);
   delay_ms(11);

   LCD_Cmd(0x03); 
   LCD_Cmd(0x02); //02H is used for Return home -> Clears the RAM and initializes the LCD
   LCD_Cmd(0x02); //02H is used for Return home -> Clears the RAM and initializes the LCD
   LCD_Cmd(0x08); //Select Row 1
   LCD_Cmd(0x00); //Clear Row 1 Display
   LCD_Cmd(0x0C); //Select Row 2
   LCD_Cmd(0x00); //Clear Row 2 Display
   LCD_Cmd(0x06);
}
 
void LCD_Clear(void)
{
    LCD_Cmd(0); //Clear the LCD
    LCD_Cmd(1); //Move the curser to first position
}

void LCD_Set_Cursor(char a, char b)
{
    char temp,z,y;
    if(a== 1)
    {
      temp = 0x80 + b - 1; //80H is used to move the curser
        z = temp>>4; //Lower 8-bits
        y = temp & 0x0F; //Upper 8-bits
        LCD_Cmd(z); //Set Row
        LCD_Cmd(y); //Set Column
    }
   else if(a== 2)
   {
       temp = 0xC0 + b - 1;
       z = temp>>4; //Lower 8-bits
       y = temp & 0x0F; //Upper 8-bits
       LCD_Cmd(z); //Set Row
       LCD_Cmd(y); //Set Column
   }
}

void LCD_Print_Char(char data)  //Send 8-bits through 4-bit mode
{
   char Lower_Nibble,Upper_Nibble;
   Lower_Nibble = data&0x0F;
   Upper_Nibble = data&0xF0;
   GPIO_WriteHigh(LCD_RS);      // => RS = 1

   LCD_SetBit(Upper_Nibble>>4); //Send upper half by shifting by 4
   LCD_Enable();

   LCD_SetBit(Lower_Nibble);    //Send Lower half
   LCD_Enable();
}

void LCD_Print_String(char *a)
{
   int i;
   for(i=0;a[i]!='\0';i++)
       LCD_Print_Char(a[i]);  //Split the string using pointers and call the Char function 
}
#endif
