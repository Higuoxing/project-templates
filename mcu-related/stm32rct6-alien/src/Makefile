# Original Author   :   Malkavian(His github repo is : https://github.com/Malkavian/tuts.git)
# Modified          :   Eric(higuoxing@outlook.com)
# I modified his makefile to make stm32 easy to be programmed under Linux or OS X
# Moreover, I could learn more about stm32 programming from this simple makefile

# Makefile for STM32F103RCT6
# Name of your project
PROJECT_NAME = blank

# Project root path
PROJECT_ROOT_PATH = ..
STM_STD_LIB_PATH = $(PROJECT_ROOT_PATH)/STM32F10x_StdPeriph_Lib_V3.5.0/Libraries

# STM header files path should be registered here
# Standard libraries inc file path
STM_INC_PATH  = .
STM_INC_PATH += $(STM_STD_LIB_PATH)/CMSIS/CM3/CoreSupport 
STM_INC_PATH += $(STM_STD_LIB_PATH)/CMSIS/CM3/DeviceSupport/ST/STM32F10x
STM_INC_PATH += $(STM_STD_LIB_PATH)/STM32F10x_StdPeriph_Driver/inc

# TM libraries inc file path

# STM source files path should be registered here
STM_SRC_PATH  = .
STM_SRC_PATH += $(STM_STD_LIB_PATH)/CMSIS/CM3/CoreSupport 
STM_SRC_PATH += $(STM_STD_LIB_PATH)/CMSIS/CM3/DeviceSupport/ST/STM32F10x
STM_SRC_PATH += $(STM_STD_LIB_PATH)/STM32F10x_StdPeriph_Driver/src

vpath %.c $(STM_SRC_PATH)

#main source file
SRCS          = main.c
SRCS         += $(STM_STD_LIB_PATH)/CMSIS/CM3/DeviceSupport/ST/STM32F10x/startup/gcc_ride7/startup_stm32f10x_hd.s
SRCS         += system_stm32f10x.c
SRCS         += stm32f10x_it.c

# dependencies must be declared here
# EXAMPLE     :   SRCS += stm32f10x_gpio.c
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# =======================STD_LIB====================================
SRCS += stm32f10x_adc.c
SRCS += stm32f10x_bkp.c
SRCS += stm32f10x_can.c
SRCS += stm32f10x_cec.c
SRCS += stm32f10x_crc.c
SRCS += stm32f10x_dac.c
SRCS += stm32f10x_dbgmcu.c
SRCS += stm32f10x_dma.c
SRCS += stm32f10x_exti.c
SRCS += stm32f10x_flash.c
SRCS += stm32f10x_fsmc.c
SRCS += stm32f10x_gpio.c
SRCS += stm32f10x_i2c.c
SRCS += stm32f10x_iwdg.c
SRCS += stm32f10x_pwr.c
SRCS += stm32f10x_rcc.c
SRCS += stm32f10x_sdio.c
SRCS += stm32f10x_spi.c
SRCS += stm32f10x_tim.c
SRCS += stm32f10x_usart.c
SRCS += stm32f10x_wwdg.c
SRCS += misc.c
# ==================third-party-lib=================================


# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#########SHOULD NOT BE CHANGED UNLESS PROFESSIONAL###################

#####################################################################
# 						TOOLCHAINS CONFIG                           #
#####################################################################
#Toolchain has been exported
# The tool we use
CC      = arm-none-eabi-gcc
OBJCOPY = arm-none-eabi-objcopy
GDB     = arm-none-eabi-gdb

## Preprocessor options

# directories to be searched for header files
INCLUDE = $(addprefix -I,$(STM_INC_PATH))

# #defines needed when working with the STM library
DEFS    = -DUSE_STDPERIPH_DRIVER
# if you use the following option, you must implement the function 
#    assert_failed(uint8_t* file, uint32_t line)
# because it is conditionally used in the library
# DEFS   += -DUSE_FULL_ASSERT

## Compiler options
CFLAGS  = -ggdb
# please do not optimize anything because we are debugging
CFLAGS += -O3 
CFLAGS += -Wall -Wextra -Warray-bounds
CFLAGS += -mlittle-endian -mthumb -mcpu=cortex-m3 -mthumb-interwork
CFLAGS += -mfloat-abi=soft -mfix-cortex-m3-ldrd -ffunction-sections -fdata-sections
CFLAGS += -fsingle-precision-constant -DSTM32F1 -DSTM32F10X_XL

## Linker options
# tell ld which linker file to use
# (this file is in the current directory)
LFLAGS  = -Tstm32_flash.ld

######################################################################
#                         SETUP TARGETS                              #
######################################################################

.PHONY: $(PROJECT_NAME)
$(PROJECT_NAME): $(PROJECT_NAME).elf

$(PROJECT_NAME).elf: $(SRCS)
	$(CC) $(INCLUDE) $(DEFS) $(CFLAGS) $(LFLAGS) $^ -o $@ 
	$(OBJCOPY) -O ihex $(PROJECT_NAME).elf   $(PROJECT_NAME).hex
	$(OBJCOPY) -O binary $(PROJECT_NAME).elf $(PROJECT_NAME).bin

.PHONY: clean
clean:
	rm -f *.o $(PROJECT_NAME).elf $(PROJECT_NAME).hex $(PROJECT_NAME).bin

# Flash the STM32F4
flash: 
	st-flash write $(PROJECT_NAME).bin 0x8000000

.PHONY: debug
debug:
# before you start gdb, you must start st-util
	$(GDB) $(PROJECT_NAME).elf

