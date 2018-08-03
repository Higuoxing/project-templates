# Original Author   :   Malkavian(His github repo is : https://github.com/Malkavian/tuts.git)
# Modified          :   Eric(higuoxing@outlook.com)
# I modified his makefile to make stm32 easy to be programmed under Linux or OS X
# Moreover, I could learn more about stm32 programming from this simple makefile

# Makefile for STM32F4Discovery
# Name of your project
PROJECT_NAME = BLANK

# Project root path
PROJECT_ROOT_PATH = ..
STM_STD_LIB_PATH = $(PROJECT_ROOT_PATH)/STM32F4-Discovery_FW_V1.1.0

# Third-party libraries should be add here
TM_STM_LIB_PATH = $(PROJECT_ROOT_PATH)/TM_STM32F4xxLIBRARIES

# STM header files path should be registered here
# Standard libraries inc file path
STM_INC_PATH  = $(STM_STD_LIB_PATH)/Utitlties/STM32F4-Discovery
STM_INC_PATH += $(STM_STD_LIB_PATH)/Libraries/CMSIS/Include
STM_INC_PATH += $(STM_STD_LIB_PATH)/Libraries/CMSIS/ST/STM32F4xx/Include
STM_INC_PATH += $(STM_STD_LIB_PATH)/Libraries/STM32F4xx_StdPeriph_Driver/inc
STM_INC_PATH += .

# TM libraries inc file path
STM_INC_PATH += $(TM_STM_LIB_PATH)

# STM source files path should be registered here
STM_SRC_PATH  = $(STM_STD_LIB_PATH)/Libraries/STM32F4xx_StdPeriph_Driver/src
STM_SRC_PATH += $(TM_STM_LIB_PATH)

vpath %.c $(STM_SRC_PATH)

#main source file
SRCS          = main.c
SRCS         += system_stm32f4xx.c
SRCS         += $(STM_STD_LIB_PATH)/Libraries/CMSIS/ST/STM32F4xx/Source/Templates/TrueSTUDIO/startup_stm32f4xx.s

# dependencies must be declared here
# EXAMPLE     :   SRCS += stm32f4xx_gpio.c
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# =======================STD_LIB====================================
# SRCS         += stm32f4xx_adc.c
# SRCS         += stm32f4xx_can.c
# SRCS         += stm32f4xx_crc.c
# SRCS         += stm32f4xx_cryp_aes.c
# SRCS         += stm32f4xx_cryp_des.c
# SRCS         += stm32f4xx_cryp_tdes.c
# SRCS         += stm32f4xx_cryp.c
# SRCS         += stm32f4xx_dac.c
# SRCS         += stm32f4xx_dbgmcu.c
# SRCS         += stm32f4xx_dcmi.c
# SRCS         += stm32f4xx_dma.c
# SRCS         += stm32f4xx_exti.c
# SRCS         += stm32f4xx_flash.c
# SRCS         += stm32f4xx_fsmc.c
# SRCS         += stm32f4xx_gpio.c
# SRCS         += stm32f4xx_hash_md5.c
# SRCS         += stm32f4xx_hash_sha1
# SRCS         += stm32f4xx_hash.c
# SRCS         += stm32f4xx_i2c.c
# SRCS         += stm32f4xx_iwdg.c
# SRCS         += stm32f4xx_pwr.c
# SRCS         += stm32f4xx_rcc.c
# SRCS         += stm32f4xx_rng.c
# SRCS         += stm32f4xx_rtc.c
# SRCS         += stm32f4xx_sdio.c
# SRCS         += stm32f4xx_spi.c
# SRCS         += stm32f4xx_syscfg.c
# SRCS         += stm32f4xx_tim.c
# SRCS         += stm32f4xx_usart.c
# SRCS         += stm32f4xx_wwdg.c
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
CFLAGS += -O0 
CFLAGS += -Wall -Wextra -Warray-bounds
CFLAGS += -mlittle-endian -mthumb -mcpu=cortex-m4 -mthumb-interwork
CFLAGS += -mfloat-abi=hard -mfpu=fpv4-sp-d16

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

