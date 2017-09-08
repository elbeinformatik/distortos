############################################################
#
#	CMake configuration for CPU STM32F7
#
#	(c) 2017-2017 elbe informatik GmbH
#
#	$Id$
#

message(STATUS "Configuring for CPU STM32F7")

set(tmp_arch_dir "${DISTORTOS_TOPDIR}/source/chip/STM32/STM32F7")

# Set the CPU
set_dconf(CHIP_STM32F7 TRUE BOOL INTERNAL)

#
# fixed configuration
#
set_dconf(CHIP_STM32F7_RCC_HSE_CLOCK_BYPASS TRUE BOOL INTERNAL)
set_dconf(CHIP_STM32F7_DTCM_SIZE 131072 INT INTERNAL)
set_dconf(CHIP_STM32F7_DTCM_ADDRESS 0x20000000 HEXINT INTERNAL)
set_dconf(CHIP_STM32F7_SRAM1_SIZE 376832 INT INTERNAL)
set_dconf(CHIP_STM32F7_SRAM1_ADDRESS 0x20020000 HEXINT INTERNAL)
set_dconf(CHIP_STM32F7_SRAM2_SIZE 16384 INT INTERNAL)
set_dconf(CHIP_STM32F7_SRAM2_ADDRESS 0x2007c000 HEXINT INTERNAL)
set_dconf(CHIP_STM32F7_BKPSRAM_ADDRESS 0x40024000 HEXINT INTERNAL)
set_dconf(CHIP_STM32F7_BKPSRAM_SIZE 4096 INT INTERNAL)

set_dconf(CHIP_STM32_GPIOV2_HAS_GPIOA 1 BOOL INTERNAL)
set_dconf(CHIP_STM32_GPIOV2_HAS_GPIOB 1 BOOL INTERNAL)
set_dconf(CHIP_STM32_GPIOV2_HAS_GPIOC 1 BOOL INTERNAL)
set_dconf(CHIP_STM32_GPIOV2_HAS_GPIOD 1 BOOL INTERNAL)
set_dconf(CHIP_STM32_GPIOV2_HAS_GPIOE 1 BOOL INTERNAL)
set_dconf(CHIP_STM32_GPIOV2_HAS_GPIOF 1 BOOL INTERNAL)
set_dconf(CHIP_STM32_GPIOV2_HAS_GPIOG 1 BOOL INTERNAL)
set_dconf(CHIP_STM32_GPIOV2_HAS_GPIOH 1 BOOL INTERNAL)
set_dconf(CHIP_STM32_GPIOV2_HAS_GPIOI 1 BOOL INTERNAL)
set_dconf(CHIP_STM32_GPIOV2_HAS_GPIOJ 1 BOOL INTERNAL)
set_dconf(CHIP_STM32_GPIOV2_HAS_GPIOK 0 BOOL INTERNAL)
set_dconf(CHIP_STM32_SPIV2_HAS_SPI1 TRUE BOOL INTERNAL)
set_dconf(CHIP_STM32_SPIV2_HAS_SPI2 TRUE BOOL INTERNAL)
set_dconf(CHIP_STM32_SPIV2_HAS_SPI3 TRUE BOOL INTERNAL)
set_dconf(CHIP_STM32_SPIV2_HAS_SPI4 TRUE BOOL INTERNAL)
set_dconf(CHIP_STM32_SPIV2_HAS_SPI5 TRUE BOOL INTERNAL)
set_dconf(CHIP_STM32_SPIV2_HAS_SPI6 TRUE BOOL INTERNAL)
set_dconf(CHIP_STM32_USARTV2_HAS_CR1_M1_BIT TRUE BOOL INTERNAL)
set_dconf(CHIP_STM32_USARTV2_HAS_USART1 TRUE BOOL INTERNAL)
set_dconf(CHIP_STM32_USARTV2_HAS_USART2 TRUE BOOL INTERNAL)
set_dconf(CHIP_STM32_USARTV2_HAS_USART3 TRUE BOOL INTERNAL)
set_dconf(CHIP_STM32_USARTV2_HAS_UART4 TRUE BOOL INTERNAL)
set_dconf(CHIP_STM32_USARTV2_HAS_UART5 TRUE BOOL INTERNAL)
set_dconf(CHIP_STM32_USARTV2_HAS_USART6 TRUE BOOL INTERNAL)
set_dconf(CHIP_STM32_USARTV2_HAS_UART7 TRUE BOOL INTERNAL)
set_dconf(CHIP_STM32_USARTV2_HAS_UART8 TRUE BOOL INTERNAL)


#
# user settable parameters
#
set_dconf(CHIP_STM32F7_VDD_MV 3300 INT "CPU VDD supply voltage in mV")
set_dconf(CHIP_STM32F7_STANDARD_CLOCK_CONFIGURATION_ENABLE TRUE BOOL "Enable standard CPU clock configuration")
set_dconf(CHIP_STM32F7_PWR_VOLTAGE_SCALE_MODE TRUE BOOL "Enable CPU core voltage scaling")
set_dconf(CHIP_STM32F7_PWR_OVER_DRIVE_ENABLE TRUE BOOL "Enable CPU core voltage overdrive for higher clock frequencies")
set_dconf(CHIP_STM32F7_RCC_HSE_ENABLE TRUE BOOL "Enable external high speed oscillator")
set_dconf(CHIP_STM32F7_RCC_HSE_FREQUENCY 25000000 INT "Frequency [Hz] of external oscillator")
set_dconf(CHIP_STM32F7_RCC_PLL_ENABLE TRUE BOOL "Enable main PLL")
set_dconf(CHIP_STM32F7_RCC_PLLSRC_HSE TRUE BOOL "Main PLL clock source is HSE")
set_dconf(CHIP_STM32F7_RCC_PLLM 25 INT "PLLM division factor")
set_dconf(CHIP_STM32F7_RCC_PLLN 432 INT "PLLN division factor")
set_dconf(CHIP_STM32F7_RCC_PLLP 2 INT "PLLP division factor" VALUES 2 4 8 16)
set_dconf(CHIP_STM32F7_RCC_PLLQ 9 INT "PLLQ division factor")
set_dconf(CHIP_STM32F7_RCC_PLLR 7 INT "PLLR division factor")
set_dconf(CHIP_STM32F7_RCC_SYSCLK_PLL TRUE BOOL "Sysclock source is PLL")
set_dconf(CHIP_STM32F7_RCC_AHB_DIV 1 INT "AHB clock = SYSCLK/x" VALUES 1 2 4 8 16 32 64 128 256 512)
set_dconf(CHIP_STM32F7_RCC_APB1_DIV 4 INT "APB1 clock divisor" VALUES 1 2 4 8 16)
set_dconf(CHIP_STM32F7_RCC_APB2_DIV 2 INT "APB2 clock divisor" VALUES 1 2 4 8 16)
set_dconf(CHIP_STM32F7_RCC_HPRE ${CHIP_STM32F7_RCC_AHB_DIV} INT INTERNAL)
set_dconf(CHIP_STM32F7_RCC_PPRE1 ${CHIP_STM32F7_RCC_APB1_DIV} INT INTERNAL)
set_dconf(CHIP_STM32F7_RCC_PPRE2 ${CHIP_STM32F7_RCC_APB2_DIV} INT INTERNAL)
set_dconf(CHIP_STM32F7_FLASH_PREFETCH_ENABLE TRUE BOOL "Enable prefetch for Flash reads")
set_dconf(CHIP_STM32F7_FLASH_ART_ACCELERATOR_ENABLE TRUE BOOL "Enable ART accelerator")
set_dconf(CHIP_STM32F7_UNIFY_DTCM_SRAM1_SRAM2 TRUE BOOL "Use combined DTCM, SRAM1 and SRAM2 for the heap")

#
# add source files
#

# add specific #include path
list(APPEND DISTORTOS_ARCH_INCLUDE_PATH
	"${tmp_arch_dir}/include"
	"${DISTORTOS_TOPDIR}/external/CMSIS-STM32F7"
)

# add arch specific source files
list(APPEND DISTORTOS_SRCS
	"${tmp_arch_dir}/STM32F7-lowLevelInitialization.cpp"
	"${tmp_arch_dir}/STM32F7-FLASH.cpp"
	"${tmp_arch_dir}/STM32F7-RCC.cpp"
	"${tmp_arch_dir}/STM32F7-chipVectors.cpp"
	"${tmp_arch_dir}/STM32F7-PWR.cpp"
)

#
# Linker script settings
#
set(LDSCRIPT_RAM_BEGIN ${CHIP_STM32F7_DTCM_ADDRESS})
if(CHIP_STM32F7_UNIFY_DTCM_SRAM1_SRAM2)
	math(EXPR LDSCRIPT_RAM_SIZE "${CHIP_STM32F7_DTCM_SIZE} + ${CHIP_STM32F7_SRAM1_SIZE} + ${CHIP_STM32F7_SRAM2_SIZE}")
else()
	set(LDSCRIPT_RAM_SIZE "${CHIP_STM32F7_DTCM_SIZE}")
	list(APPEND LDSCRIPT_RAM_REGIONS
		"sram1" "${CHIP_STM32F7_SRAM1_ADDRESS}" "${CHIP_STM32F7_SRAM1_SIZE}"
		"sram2" "${CHIP_STM32F7_SRAM2_ADDRESS}" "${CHIP_STM32F7_SRAM2_SIZE}"
	)
endif()
list(APPEND LDSCRIPT_RAM_REGIONS
	"bkpsram" "${CHIP_STM32F7_BKPSRAM_ADDRESS}" "${CHIP_STM32F7_BKPSRAM_SIZE}"
)

# include more generic CPU definitions
include(STM32)
include(CORTEX-M7)
