/**
  ******************************************************************************
  * AD9833_reg.h - internal register definitions and internal library functions
  * this file is internal to the library, and should not be #included in your project directly
  * 
  * @author  Brad Roy
  * @version V1.0 All major functions implemented and working.
  * @date    04-Dec-2020
  * @site    https://github.com/prosper00/STM8-AD9833-Function-Generator
  *****************************************************************************/
  
/******************************************************************************
 * Documentation references: 
 * https://www.analog.com/media/en/technical-documentation/data-sheets/AD9833.pdf
 * https://www.analog.com/media/en/technical-documentation/application-notes/AN-1070.pdf
 ******************************************************************************/
 
#define AD_MCLK   25000000UL  // Clock speed of the AD9833 reference clock in Hz

// Calculate the register value for AD9833 phase from given phase in tenths of a degree
static inline uint16_t calcPhase(float phase){return (uint16_t)((512.0 * (phase/10) / 45) + 0.5);}

// Calculate the register value for AD9833 frequency register from requested frequency in Hz
static inline uint32_t calcFreq(float freq){return (uint32_t)((freq * (1UL << 28)/AD_MCLK) + 0.5);}

/*Sends the contents of a register to the AD9833. Pass it a member of 
  the AD_REGISTERS enum to specify which register should be sent */
void AD9833_WriteReg(uint8_t reg);


//the 5 AD9833 register names
enum AD_REGISTERS{
	AD_REG_CTL,
	AD_REG_FREQ0,
	AD_REG_FREQ1,
	AD_REG_PHASE0,
	AD_REG_PHASE1
};

//addresses of registers
uint8_t AD_REG_ADDRESS[5]={
	0x00, // [AD_REG_CTL]    == 00nn nnnn
	0x40, // [AD_REG_FREQ0]  == 01nn nnnn
	0x80, // [AD_REG_FREQ1]  == 10nn nnnn
	0xC0, // [AD_REG_PHASE0] == 1100 nnnn
	0xE0  // [AD_REG_PHASE1] == 1111 nnnn
};

//AD9833 Control Register bit definitions. (pp14 of the datasheet)
enum CTL_BITS{
	AD_CTL_B0,
	AD_CTL_MODE,
	AD_CTL_B2,
	AD_CTL_DIV2,
	AD_CTL_B4,
	AD_CTL_OPBITEN,
	AD_CTL_SLEEP12,
	AD_CTL_SLEEP1,
	AD_CTL_RESET,
	AD_CTL_B9,
	AD_CTL_PSELECT,
	AD_CTL_FSELECT,
	AD_CTL_HLB,
	AD_CTL_B28
};

/* global register variable to store the state of all of our registers prior to sending it to the 9833.
 * Calculate the value of the register that you want to send, then call AD9833_WriteReg() 
 * with the register that you want to send (use a member of the AD_REGISTERS enum)
 */
uint16_t AD_REG_VAL[5] = {0,0,0,0,0};


//Helpermonkeys
/* Bit Manipulation Macros ***************************************************************
x    is a variable that will be modified.
y    will not.
pos  is a unsigned int (usually 0 through 7) representing a single bit position where the
     right-most bit is bit 0. So 00000010 is pos 1 since the second bit is high.
bm   (bit mask) is used to specify multiple bits by having each set ON.
bf   (bit field) is similar (it is in fact used as a bit mask) but it is used to specify a
     range of neighboring bit by having them set ON. */
#define BIT(pos) ( 1<<(pos) )                  // set bit at pos to HIGH, others LOW
#define BIT_SET(x, pos) ( (x) |= (BIT(pos)) )  // set bit at pos to HIGH
#define BITS_SET(x, bm) ( (x) |= (bm) )        // same but for multiple bits
#define BIT_RST(x, pos) ( (x) &= ~(BIT(pos)) ) // set bit at pos to LOW
#define BITS_RST(x, bm) ( (x) &= (~(bm)) )     // same but for multiple bits
#define BIT_FLIP(x, pos) ( (x) ^= (BIT(pos)) ) // toggle bit at pos 
#define BITS_FLIP(x, bm) ( (x) ^= (bm) )       // same but for multiple bits 
#define BIT_CHECK(y, pos) ( ( 0u == ( (y)&(BIT(pos)) ) ) ?0u :1u ) // pos is HIGH/LOW? 1/0 
#define BITS_CHECK_ANY(y, bm) ( ( (y) & (bm) ) ? 0u : 1u )         // 1 if all are HIGH 
#define BITS_CHECK_ALL(y, bm) ( ( (bm) == ((y)&(bm)) ) ? 0u : 1u ) // same but if any
// the next two are for following two to use
#define BIT_SET_LSB(len) ( BIT(len)-1 ) // the first len bits are '1' and the rest are '0'
#define BF_MASK(start, len) ( SET_LSBITS(len)<<(start) ) // same but with offset
#define BF_PREP(y, start, len) ( ((y)&SET_LSBITS(len)) << (start) ) // Prepare a bitmask
// Extract a bitfield of length len starting at bit start from y:
#define BF_GET(y, start, len) ( ((y)>>(start)) & SET_LSBITS(len) )
// Insert a new bitfield value bf into x.
#define BF_SET(x, bf, start, len) ( x = ((x) &~ BF_MASK(start, len)) | BF_PREP(bf, start, len) )

//debug stuff
//			printf formatter to output binary
///		e.g. a 16-bit printf();
//			printf("\n\rRegVal: "BYTE_TO_BINARY_PATTERN" "BYTE_TO_BINARY_PATTERN,BYTE_TO_BINARY(AD_REG_VAL[reg]>>8), BYTE_TO_BINARY(AD_REG_VAL[reg]));
#define BYTE_TO_BINARY_PATTERN "%c%c%c%c%c%c%c%c"
#define BYTE_TO_BINARY(byte)  \
  (byte & 0x80 ? '1' : '0'), \
  (byte & 0x40 ? '1' : '0'), \
  (byte & 0x20 ? '1' : '0'), \
  (byte & 0x10 ? '1' : '0'), \
  (byte & 0x08 ? '1' : '0'), \
  (byte & 0x04 ? '1' : '0'), \
  (byte & 0x02 ? '1' : '0'), \
  (byte & 0x01 ? '1' : '0') 
