#
# Automatically generated file; DO NOT EDIT.
# Configuration
#

#
# Board, chip & architecture configuration
#
CONFIG_CHIP_STM32=y
# CONFIG_CHIP_STM32F0 is not set
# CONFIG_CHIP_STM32F1 is not set
# CONFIG_CHIP_STM32F4 is not set
CONFIG_CHIP_STM32F7=y
# CONFIG_CHIP_STM32L0 is not set
# CONFIG_BOARD_CUSTOM is not set
CONFIG_BOARD_SOURCE_BOARD_ST_32F746GDISCOVERY_ST_32F746GDISCOVERY=y
# CONFIG_BOARD_SOURCE_BOARD_ST_32F769IDISCOVERY_ST_32F769IDISCOVERY is not set
CONFIG_BOARD_INCLUDES="source/board/ST_32F746GDISCOVERY/include"
CONFIG_BOARD="ST,32F746GDISCOVERY"
CONFIG_LDSCRIPT="source/board/ST_32F746GDISCOVERY/ST_32F746GDISCOVERY.ld"
CONFIG_BOARD_HAS_BUTTONS=y
CONFIG_BOARD_HAS_LEDS=y
CONFIG_KCONFIG_BOARDOPTIONS_STM32_GPIO=y
# CONFIG_CHIP_STM32F7_VDD_MV_CONFIGURABLE is not set
CONFIG_CHIP_STM32F7_VDD_MV_DEFAULT=3300
# CONFIG_CHIP_STM32F7_RCC_HSE_CLOCK_BYPASS_CONFIGURABLE is not set
CONFIG_CHIP_STM32F7_RCC_HSE_CLOCK_BYPASS_DEFAULT=y
# CONFIG_CHIP_STM32F7_RCC_HSE_FREQUENCY_CONFIGURABLE is not set
CONFIG_CHIP_STM32F7_RCC_HSE_FREQUENCY_DEFAULT=25000000

#
# Generic board options
#
CONFIG_BOARD_BUTTONS_ENABLE=y
CONFIG_BOARD_LEDS_ENABLE=y
CONFIG_BOARD_HAS_DTS=y
CONFIG_CHIP_ROM_SIZE=1048576
CONFIG_CHIP_ROM_ADDRESS=0x08000000
CONFIG_CHIP="STM32F746NG"
CONFIG_CHIP_INCLUDES="source/chip/STM32/include source/chip/STM32/STM32F7/include source/chip/STM32/peripherals/GPIOv2/include source/chip/STM32/peripherals/SPIv2/include source/chip/STM32/peripherals/USARTv2/include external/CMSIS-STM32F7 external/CMSIS"

#
# STM32F7 chip options
#
CONFIG_CHIP_STM32F7_VDD_MV=3300

#
# Clocks configuration
#
CONFIG_CHIP_STM32F7_STANDARD_CLOCK_CONFIGURATION_ENABLE=y
CONFIG_CHIP_STM32F7_PWR_VOLTAGE_SCALE_MODE=1
CONFIG_CHIP_STM32F7_PWR_OVER_DRIVE_ENABLE=y
CONFIG_CHIP_STM32F7_RCC_HSE_ENABLE=y
CONFIG_CHIP_STM32F7_RCC_HSE_CLOCK_BYPASS=y

#
# HSE Clock Bypass is enabled (not configurable)
#
CONFIG_CHIP_STM32F7_RCC_HSE_FREQUENCY=25000000
CONFIG_CHIP_STM32F7_RCC_PLL_ENABLE=y
# CONFIG_CHIP_STM32F7_RCC_PLLSRC_HSI is not set
CONFIG_CHIP_STM32F7_RCC_PLLSRC_HSE=y
CONFIG_CHIP_STM32F7_RCC_PLLM=25
CONFIG_CHIP_STM32F7_RCC_PLLN=432
CONFIG_CHIP_STM32F7_RCC_PLLP_DIV2=y
# CONFIG_CHIP_STM32F7_RCC_PLLP_DIV4 is not set
# CONFIG_CHIP_STM32F7_RCC_PLLP_DIV6 is not set
# CONFIG_CHIP_STM32F7_RCC_PLLP_DIV8 is not set
CONFIG_CHIP_STM32F7_RCC_PLLQ=9
# CONFIG_CHIP_STM32F7_RCC_SYSCLK_HSI is not set
# CONFIG_CHIP_STM32F7_RCC_SYSCLK_HSE is not set
CONFIG_CHIP_STM32F7_RCC_SYSCLK_PLL=y
CONFIG_CHIP_STM32F7_RCC_AHB_DIV1=y
# CONFIG_CHIP_STM32F7_RCC_AHB_DIV2 is not set
# CONFIG_CHIP_STM32F7_RCC_AHB_DIV4 is not set
# CONFIG_CHIP_STM32F7_RCC_AHB_DIV8 is not set
# CONFIG_CHIP_STM32F7_RCC_AHB_DIV16 is not set
# CONFIG_CHIP_STM32F7_RCC_AHB_DIV64 is not set
# CONFIG_CHIP_STM32F7_RCC_AHB_DIV128 is not set
# CONFIG_CHIP_STM32F7_RCC_AHB_DIV256 is not set
# CONFIG_CHIP_STM32F7_RCC_AHB_DIV512 is not set
# CONFIG_CHIP_STM32F7_RCC_APB1_DIV1 is not set
# CONFIG_CHIP_STM32F7_RCC_APB1_DIV2 is not set
CONFIG_CHIP_STM32F7_RCC_APB1_DIV4=y
# CONFIG_CHIP_STM32F7_RCC_APB1_DIV8 is not set
# CONFIG_CHIP_STM32F7_RCC_APB1_DIV16 is not set
# CONFIG_CHIP_STM32F7_RCC_APB2_DIV1 is not set
CONFIG_CHIP_STM32F7_RCC_APB2_DIV2=y
# CONFIG_CHIP_STM32F7_RCC_APB2_DIV4 is not set
# CONFIG_CHIP_STM32F7_RCC_APB2_DIV8 is not set
# CONFIG_CHIP_STM32F7_RCC_APB2_DIV16 is not set

#
# Memory configuration
#
CONFIG_CHIP_STM32F7_FLASH_PREFETCH_ENABLE=y
CONFIG_CHIP_STM32F7_FLASH_ART_ACCELERATOR_ENABLE=y
# CONFIG_CHIP_STM32F72 is not set
# CONFIG_CHIP_STM32F722 is not set
# CONFIG_CHIP_STM32F722I is not set
# CONFIG_CHIP_STM32F722IC is not set
# CONFIG_CHIP_STM32F722IE is not set
# CONFIG_CHIP_STM32F722R is not set
# CONFIG_CHIP_STM32F722RC is not set
# CONFIG_CHIP_STM32F722RE is not set
# CONFIG_CHIP_STM32F722V is not set
# CONFIG_CHIP_STM32F722VC is not set
# CONFIG_CHIP_STM32F722VE is not set
# CONFIG_CHIP_STM32F722Z is not set
# CONFIG_CHIP_STM32F722ZC is not set
# CONFIG_CHIP_STM32F722ZE is not set
# CONFIG_CHIP_STM32F723 is not set
# CONFIG_CHIP_STM32F723I is not set
# CONFIG_CHIP_STM32F723IC is not set
# CONFIG_CHIP_STM32F723IE is not set
# CONFIG_CHIP_STM32F723V is not set
# CONFIG_CHIP_STM32F723VE is not set
# CONFIG_CHIP_STM32F723Z is not set
# CONFIG_CHIP_STM32F723ZC is not set
# CONFIG_CHIP_STM32F723ZE is not set
# CONFIG_CHIP_STM32F73 is not set
# CONFIG_CHIP_STM32F732 is not set
# CONFIG_CHIP_STM32F732I is not set
# CONFIG_CHIP_STM32F732IE is not set
# CONFIG_CHIP_STM32F732R is not set
# CONFIG_CHIP_STM32F732RE is not set
# CONFIG_CHIP_STM32F732V is not set
# CONFIG_CHIP_STM32F732VE is not set
# CONFIG_CHIP_STM32F732Z is not set
# CONFIG_CHIP_STM32F732ZE is not set
# CONFIG_CHIP_STM32F733 is not set
# CONFIG_CHIP_STM32F733I is not set
# CONFIG_CHIP_STM32F733IE is not set
# CONFIG_CHIP_STM32F733V is not set
# CONFIG_CHIP_STM32F733VE is not set
# CONFIG_CHIP_STM32F733Z is not set
# CONFIG_CHIP_STM32F733ZE is not set
CONFIG_CHIP_STM32F74=y
# CONFIG_CHIP_STM32F745 is not set
# CONFIG_CHIP_STM32F745I is not set
# CONFIG_CHIP_STM32F745IE is not set
# CONFIG_CHIP_STM32F745IG is not set
# CONFIG_CHIP_STM32F745V is not set
# CONFIG_CHIP_STM32F745VE is not set
# CONFIG_CHIP_STM32F745VG is not set
# CONFIG_CHIP_STM32F745Z is not set
# CONFIG_CHIP_STM32F745ZE is not set
# CONFIG_CHIP_STM32F745ZG is not set
CONFIG_CHIP_STM32F746=y
# CONFIG_CHIP_STM32F746B is not set
# CONFIG_CHIP_STM32F746BE is not set
# CONFIG_CHIP_STM32F746BG is not set
# CONFIG_CHIP_STM32F746I is not set
# CONFIG_CHIP_STM32F746IE is not set
# CONFIG_CHIP_STM32F746IG is not set
CONFIG_CHIP_STM32F746N=y
# CONFIG_CHIP_STM32F746NE is not set
CONFIG_CHIP_STM32F746NG=y
# CONFIG_CHIP_STM32F746V is not set
# CONFIG_CHIP_STM32F746VE is not set
# CONFIG_CHIP_STM32F746VG is not set
# CONFIG_CHIP_STM32F746Z is not set
# CONFIG_CHIP_STM32F746ZE is not set
# CONFIG_CHIP_STM32F746ZG is not set
# CONFIG_CHIP_STM32F75 is not set
# CONFIG_CHIP_STM32F756 is not set
# CONFIG_CHIP_STM32F756B is not set
# CONFIG_CHIP_STM32F756BG is not set
# CONFIG_CHIP_STM32F756I is not set
# CONFIG_CHIP_STM32F756IG is not set
# CONFIG_CHIP_STM32F756N is not set
# CONFIG_CHIP_STM32F756NG is not set
# CONFIG_CHIP_STM32F756V is not set
# CONFIG_CHIP_STM32F756VG is not set
# CONFIG_CHIP_STM32F756Z is not set
# CONFIG_CHIP_STM32F756ZG is not set
# CONFIG_CHIP_STM32F76 is not set
# CONFIG_CHIP_STM32F765 is not set
# CONFIG_CHIP_STM32F765B is not set
# CONFIG_CHIP_STM32F765BG is not set
# CONFIG_CHIP_STM32F765BI is not set
# CONFIG_CHIP_STM32F765I is not set
# CONFIG_CHIP_STM32F765IG is not set
# CONFIG_CHIP_STM32F765II is not set
# CONFIG_CHIP_STM32F765N is not set
# CONFIG_CHIP_STM32F765NG is not set
# CONFIG_CHIP_STM32F765NI is not set
# CONFIG_CHIP_STM32F765V is not set
# CONFIG_CHIP_STM32F765VG is not set
# CONFIG_CHIP_STM32F765VI is not set
# CONFIG_CHIP_STM32F765Z is not set
# CONFIG_CHIP_STM32F765ZG is not set
# CONFIG_CHIP_STM32F765ZI is not set
# CONFIG_CHIP_STM32F767 is not set
# CONFIG_CHIP_STM32F767B is not set
# CONFIG_CHIP_STM32F767BG is not set
# CONFIG_CHIP_STM32F767BI is not set
# CONFIG_CHIP_STM32F767I is not set
# CONFIG_CHIP_STM32F767IG is not set
# CONFIG_CHIP_STM32F767II is not set
# CONFIG_CHIP_STM32F767N is not set
# CONFIG_CHIP_STM32F767NG is not set
# CONFIG_CHIP_STM32F767NI is not set
# CONFIG_CHIP_STM32F767V is not set
# CONFIG_CHIP_STM32F767VG is not set
# CONFIG_CHIP_STM32F767VI is not set
# CONFIG_CHIP_STM32F767Z is not set
# CONFIG_CHIP_STM32F767ZG is not set
# CONFIG_CHIP_STM32F767ZI is not set
# CONFIG_CHIP_STM32F769 is not set
# CONFIG_CHIP_STM32F769A is not set
# CONFIG_CHIP_STM32F769AI is not set
# CONFIG_CHIP_STM32F769B is not set
# CONFIG_CHIP_STM32F769BG is not set
# CONFIG_CHIP_STM32F769BI is not set
# CONFIG_CHIP_STM32F769I is not set
# CONFIG_CHIP_STM32F769IG is not set
# CONFIG_CHIP_STM32F769II is not set
# CONFIG_CHIP_STM32F769N is not set
# CONFIG_CHIP_STM32F769NG is not set
# CONFIG_CHIP_STM32F769NI is not set
# CONFIG_CHIP_STM32F77 is not set
# CONFIG_CHIP_STM32F777 is not set
# CONFIG_CHIP_STM32F777B is not set
# CONFIG_CHIP_STM32F777BI is not set
# CONFIG_CHIP_STM32F777I is not set
# CONFIG_CHIP_STM32F777II is not set
# CONFIG_CHIP_STM32F777N is not set
# CONFIG_CHIP_STM32F777NI is not set
# CONFIG_CHIP_STM32F777V is not set
# CONFIG_CHIP_STM32F777VI is not set
# CONFIG_CHIP_STM32F777Z is not set
# CONFIG_CHIP_STM32F777ZI is not set
# CONFIG_CHIP_STM32F778 is not set
# CONFIG_CHIP_STM32F778A is not set
# CONFIG_CHIP_STM32F778AI is not set
# CONFIG_CHIP_STM32F779 is not set
# CONFIG_CHIP_STM32F779A is not set
# CONFIG_CHIP_STM32F779AI is not set
# CONFIG_CHIP_STM32F779B is not set
# CONFIG_CHIP_STM32F779BI is not set
# CONFIG_CHIP_STM32F779I is not set
# CONFIG_CHIP_STM32F779II is not set
# CONFIG_CHIP_STM32F779N is not set
# CONFIG_CHIP_STM32F779NI is not set
CONFIG_CHIP_STM32F7_BKPSRAM_SIZE=4096
CONFIG_CHIP_STM32F7_BKPSRAM_ADDRESS=0x40024000
CONFIG_CHIP_STM32F7_DTCM_SIZE=65536
CONFIG_CHIP_STM32F7_DTCM_ADDRESS=0x20000000
CONFIG_CHIP_STM32F7_SRAM1_SIZE=245760
CONFIG_CHIP_STM32F7_SRAM1_ADDRESS=0x20010000
CONFIG_CHIP_STM32F7_SRAM2_SIZE=16384
CONFIG_CHIP_STM32F7_SRAM2_ADDRESS=0x2004c000
CONFIG_CHIP_STM32F7_RCC_HPRE=1
CONFIG_CHIP_STM32F7_RCC_PLLP=2
CONFIG_CHIP_STM32F7_RCC_PPRE1=4
CONFIG_CHIP_STM32F7_RCC_PPRE2=2

#
# Peripherals configuration
#
# CONFIG_CHIP_STM32_GPIOV2_GPIOA_ENABLE is not set
# CONFIG_CHIP_STM32_GPIOV2_GPIOB_ENABLE is not set
# CONFIG_CHIP_STM32_GPIOV2_GPIOC_ENABLE is not set
# CONFIG_CHIP_STM32_GPIOV2_GPIOD_ENABLE is not set
# CONFIG_CHIP_STM32_GPIOV2_GPIOE_ENABLE is not set
# CONFIG_CHIP_STM32_GPIOV2_GPIOF_ENABLE is not set
# CONFIG_CHIP_STM32_GPIOV2_GPIOG_ENABLE is not set
# CONFIG_CHIP_STM32_GPIOV2_GPIOH_ENABLE is not set
CONFIG_CHIP_STM32_GPIOV2_GPIOI_ENABLE=y
# CONFIG_CHIP_STM32_GPIOV2_GPIOJ_ENABLE is not set
# CONFIG_CHIP_STM32_GPIOV2_GPIOK_ENABLE is not set
CONFIG_CHIP_STM32_GPIOV2_HAS_4_AF_BITS=y
CONFIG_CHIP_STM32_GPIOV2_HAS_HIGH_SPEED=y
CONFIG_CHIP_STM32_GPIOV2_HAS_GPIOA=y
CONFIG_CHIP_STM32_GPIOV2_HAS_GPIOB=y
CONFIG_CHIP_STM32_GPIOV2_HAS_GPIOC=y
CONFIG_CHIP_STM32_GPIOV2_HAS_GPIOD=y
CONFIG_CHIP_STM32_GPIOV2_HAS_GPIOE=y
CONFIG_CHIP_STM32_GPIOV2_HAS_GPIOF=y
CONFIG_CHIP_STM32_GPIOV2_HAS_GPIOG=y
CONFIG_CHIP_STM32_GPIOV2_HAS_GPIOH=y
CONFIG_CHIP_STM32_GPIOV2_HAS_GPIOI=y
CONFIG_CHIP_STM32_GPIOV2_HAS_GPIOJ=y
CONFIG_CHIP_STM32_GPIOV2_HAS_GPIOK=y
# CONFIG_CHIP_STM32_GPIOV1 is not set
CONFIG_CHIP_STM32_GPIOV2=y
# CONFIG_CHIP_STM32_SPIV1 is not set
CONFIG_CHIP_STM32_SPIV2=y
# CONFIG_CHIP_STM32_USARTV1 is not set
CONFIG_CHIP_STM32_USARTV2=y
# CONFIG_CHIP_STM32_SPIV2_SPI1_ENABLE is not set
# CONFIG_CHIP_STM32_SPIV2_SPI2_ENABLE is not set
# CONFIG_CHIP_STM32_SPIV2_SPI3_ENABLE is not set
# CONFIG_CHIP_STM32_SPIV2_SPI4_ENABLE is not set
# CONFIG_CHIP_STM32_SPIV2_SPI5_ENABLE is not set
# CONFIG_CHIP_STM32_SPIV2_SPI6_ENABLE is not set
CONFIG_CHIP_STM32_SPIV2_HAS_SPI1=y
CONFIG_CHIP_STM32_SPIV2_HAS_SPI2=y
CONFIG_CHIP_STM32_SPIV2_HAS_SPI3=y
CONFIG_CHIP_STM32_SPIV2_HAS_SPI4=y
CONFIG_CHIP_STM32_SPIV2_HAS_SPI5=y
CONFIG_CHIP_STM32_SPIV2_HAS_SPI6=y
# CONFIG_CHIP_STM32_USARTV2_USART1_ENABLE is not set
# CONFIG_CHIP_STM32_USARTV2_USART2_ENABLE is not set
# CONFIG_CHIP_STM32_USARTV2_USART3_ENABLE is not set
# CONFIG_CHIP_STM32_USARTV2_UART4_ENABLE is not set
# CONFIG_CHIP_STM32_USARTV2_UART5_ENABLE is not set
# CONFIG_CHIP_STM32_USARTV2_USART6_ENABLE is not set
# CONFIG_CHIP_STM32_USARTV2_UART7_ENABLE is not set
# CONFIG_CHIP_STM32_USARTV2_UART8_ENABLE is not set
CONFIG_CHIP_STM32_USARTV2_HAS_CR1_M1_BIT=y
# CONFIG_CHIP_STM32_USARTV2_USART3_USART6_COMBINED_INTERRUPT is not set
# CONFIG_CHIP_STM32_USARTV2_USART3_USART8_COMBINED_INTERRUPT is not set
# CONFIG_CHIP_STM32_USARTV2_USART4_USART5_COMBINED_INTERRUPT is not set
CONFIG_CHIP_STM32_USARTV2_HAS_USART1=y
CONFIG_CHIP_STM32_USARTV2_HAS_USART2=y
CONFIG_CHIP_STM32_USARTV2_HAS_USART3=y
CONFIG_CHIP_STM32_USARTV2_HAS_UART4=y
# CONFIG_CHIP_STM32_USARTV2_HAS_USART4 is not set
CONFIG_CHIP_STM32_USARTV2_HAS_UART5=y
# CONFIG_CHIP_STM32_USARTV2_HAS_USART5 is not set
CONFIG_CHIP_STM32_USARTV2_HAS_USART6=y
CONFIG_CHIP_STM32_USARTV2_HAS_UART7=y
# CONFIG_CHIP_STM32_USARTV2_HAS_USART7 is not set
CONFIG_CHIP_STM32_USARTV2_HAS_UART8=y
# CONFIG_CHIP_STM32_USARTV2_HAS_USART8 is not set

#
# Generic chip options
#
# CONFIG_ARCHITECTURE_ARMV6_M is not set
CONFIG_ARCHITECTURE_ARMV7_M=y
CONFIG_ARCHITECTURE_STACK_ALIGNMENT=8
CONFIG_TOOLCHAIN_PREFIX="arm-none-eabi-"
CONFIG_ARCHITECTURE_FLAGS="-mcpu=cortex-m7 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16"

#
# ARMv7-M architecture options
#
CONFIG_ARCHITECTURE_ARMV7_M_KERNEL_BASEPRI=0
# CONFIG_ARCHITECTURE_ARM_CORTEX_M3 is not set
# CONFIG_ARCHITECTURE_ARM_CORTEX_M4 is not set
CONFIG_ARCHITECTURE_ARM_CORTEX_M7=y
CONFIG_ARCHITECTURE_ARM_CORTEX_M7_R0P1=y
# CONFIG_ARCHITECTURE_ARM_CORTEX_M7_R0P2 is not set
# CONFIG_ARCHITECTURE_ARM_CORTEX_M7_R1P0 is not set
# CONFIG_ARCHITECTURE_ARM_CORTEX_M7_R1P1 is not set
# CONFIG_ARCHITECTURE_HAS_FPV5_D16 is not set
CONFIG_ARCHITECTURE_ARMV6_M_ARMV7_M_MAIN_STACK_SIZE=1024
CONFIG_ARCHITECTURE_INCLUDES="source/architecture/ARM/ARMv6-M-ARMv7-M/include"

#
# Generic architecture options
#
CONFIG_ARCHITECTURE_FPU=y
# CONFIG_ARCHITECTURE_ASCENDING_STACK is not set
# CONFIG_ARCHITECTURE_EMPTY_STACK is not set
CONFIG_ARCHITECTURE_HAS_FPU=y
CONFIG_ARCHITECTURE_ARM=y

#
# Scheduler configuration
#
CONFIG_TICK_FREQUENCY=1000
CONFIG_ROUND_ROBIN_FREQUENCY=10
CONFIG_SIGNALS_ENABLE=y
CONFIG_THREAD_DETACH_ENABLE=y

#
# main() thread options
#
CONFIG_MAIN_THREAD_STACK_SIZE=4096
CONFIG_MAIN_THREAD_PRIORITY=127
CONFIG_MAIN_THREAD_CAN_RECEIVE_SIGNALS=y
CONFIG_MAIN_THREAD_QUEUED_SIGNALS=8
CONFIG_MAIN_THREAD_SIGNAL_ACTIONS=8

#
# Runtime checks
#
CONFIG_CHECK_FUNCTION_CONTEXT_ENABLE=y
CONFIG_CHECK_STACK_POINTER_RANGE_CONTEXT_SWITCH_ENABLE=y
CONFIG_CHECK_STACK_POINTER_RANGE_SYSTEM_TICK_ENABLE=y
CONFIG_CHECK_STACK_GUARD_CONTEXT_SWITCH_ENABLE=y
CONFIG_CHECK_STACK_GUARD_SYSTEM_TICK_ENABLE=y
CONFIG_STACK_GUARD_SIZE=32

#
# Applications configuration
#
CONFIG_TEST_APPLICATION_ENABLE=y

#
# Build configuration
#
# CONFIG_BUILD_OPTIMIZATION_O0 is not set
# CONFIG_BUILD_OPTIMIZATION_O1 is not set
CONFIG_BUILD_OPTIMIZATION_O2=y
# CONFIG_BUILD_OPTIMIZATION_O3 is not set
# CONFIG_BUILD_OPTIMIZATION_OS is not set
# CONFIG_BUILD_OPTIMIZATION_OG is not set
# CONFIG_LINK_TIME_OPTIMIZATION_ENABLE is not set
# CONFIG_STATIC_DESTRUCTORS_ENABLE is not set
CONFIG_DEBUGGING_INFORMATION_ENABLE=y
CONFIG_ASSERT_ENABLE=y
CONFIG_LDSCRIPT_ROM_BEGIN=0
CONFIG_LDSCRIPT_ROM_END=1048576
CONFIG_BUILD_OPTIMIZATION="-O2"
CONFIG_LINK_TIME_OPTIMIZATION_COMPILATION=""
CONFIG_LINK_TIME_OPTIMIZATION_LINKING=""
CONFIG_STATIC_DESTRUCTORS_RUN_TIME_REGISTRATION="-fno-use-cxa-atexit"
CONFIG_DEBUGGING_INFORMATION_COMPILATION="-g -ggdb3"
CONFIG_DEBUGGING_INFORMATION_LINKING="-g"
CONFIG_ASSERT=""
