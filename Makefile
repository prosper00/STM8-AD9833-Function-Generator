#######
# makefile for STM8*_StdPeriph_Lib and SDCC compiler
# modified for SDCC
# modified use SPL functions inlined from https://github.com/MightyPork/stm8s_inline_spl
#   inlined functions save much flash space, but may not be totally complete.
#
# usage:
#   1. if SDCC not in PATH set path -> CC_ROOT
#   2. set correct STM8 device -> DEVICE
#   3. set project paths -> PRJ_ROOT, PRJ_SRC_DIR, PRJ_INC_DIR
#   4. set SPL paths -> SPL_ROOT
#   5. add required SPL modules -> SPL_SOURCE
#   6. add required STM8S_EVAL modules -> EVAL_SOURCE, EVAL_128K_SOURCE, EVAL_COMM_SOURCE
#
#######

# STM8 device (for supported devices see stm8s.h)
DEVICE = STM8S103
PARTNO = stm8s103f3
PROGRAMMER = stlinkv2

# set compiler path & parameters
CC_ROOT =
CC      = sdcc
CFLAGS  = -mstm8 -lstm8 --opt-code-size --disable-warning 126 --disable-warning 110 --out-fmt-elf --debug

# set output folder and target name
OUTPUT_DIR = ./dist
TARGET     := $(addprefix $(OUTPUT_DIR)/, $(notdir $(CURDIR))).elf

# set project folder and files (all *.c)
PRJ_ROOT    = .
PRJ_SRC_DIR = $(PRJ_ROOT)
PRJ_INC_DIR = $(PRJ_ROOT)
PRJ_SOURCE  = $(notdir $(wildcard $(PRJ_SRC_DIR)/*.c))
PRJ_OBJECTS := $(addprefix $(OUTPUT_DIR)/, $(PRJ_SOURCE:.c=.rel))


# set SPL paths
SPL_ROOT    = 
#uncomment the next line if you're not usig the 'inlined' SPL headers
#SPL_SRC_DIR = $(SPL_ROOT)/Libraries/STM8S_StdPeriph_Driver/src

SPL_INC_DIR = inc

#SPL_SOURCE: not needed with the 'inline' library, *except* the stm8s_flash.c, if used
#SPL_SOURCE  = stm8s_gpio.c stm8s_clk.c stm8s_uart1.c stm8s_tim1.c stm8s_adc1.c
SPL_SOURCE = 


SPL_OBJECTS := $(addprefix $(OUTPUT_DIR)/, $(SPL_SOURCE:.c=.rel))


COMMON_INC = ./common

# collect all include folders
INCLUDE = -I$(PRJ_SRC_DIR) -I$(SPL_INC_DIR) -I$(COMMON_INC)

# collect all source directories
VPATH=$(PRJ_SRC_DIR):$(SPL_SRC_DIR)

all: $(OUTPUT_DIR) $(TARGET)

$(OUTPUT_DIR):
	mkdir -p $(OUTPUT_DIR)

# $(OUTPUT_DIR)/%.rel: %.c
# 	$(CC) $(CFLAGS) $(INCLUDE) -D$(DEVICE) -c $?

$(OUTPUT_DIR)/%.rel: %.c
	$(CC) $(CFLAGS) $(INCLUDE) -D$(DEVICE) -c $? -o $@

$(TARGET): $(PRJ_OBJECTS) $(SPL_OBJECTS)
	$(CC) $(CFLAGS) -o $(TARGET) $^
	stm8-objcopy -O ihex -R DATA -R INITIALIZED -R SSEG $(TARGET) $(TARGET).ihx
	stm8-size -A $(TARGET)

clean:
	rm -rf $(OUTPUT_DIR)

flash: all
	stm8flash -c $(PROGRAMMER) -p $(PARTNO) -w $(TARGET).ihx

.PHONY: clean flash
