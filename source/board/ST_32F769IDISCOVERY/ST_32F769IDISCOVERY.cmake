############################################################
#
#	CMake configuration for board 32F769IDISCOVERY
#
#	(c) 2017-2017 elbe informatik GmbH
#
#	$Id$
#

message(STATUS "Configuring for board ${BOARD}")

#
# fixed configuration
#
# Set the CPU
set_dconf(CHIP STM32F769NI STRING INTERNAL)
# set #define with board name included
set_dconf(BOARD_32F769IDISCOVERY TRUE BOOL INTERNAL)

set_dconf(BOARD_HAS_BUTTONS 1 BOOL INTERNAL)
set_dconf(BOARD_HAS_LEDS 1 BOOL INTERNAL)

set_dconf(CHIP_STM32_GPIOV2_GPIOA_ENABLE TRUE BOOL INTERNAL)
set_dconf(CHIP_STM32_GPIOV2_GPIOJ_ENABLE TRUE BOOL INTERNAL)
# USART1 is the "virtual com port" on the ST link
set_dconf(CHIP_STM32_USARTV2_USART1_ENABLE TRUE BOOL INTERNAL)
# USART6 is the serial port on the arduino expansion connector
set_dconf(CHIP_STM32_USARTV2_USART6_ENABLE TRUE BOOL INTERNAL)

set_dconf(CHIP_STM32F7_VDD_MV 3300 INT INTERNAL)
set_dconf(CHIP_STM32F7_RCC_HSE_ENABLE TRUE BOOL INTERNAL)
set_dconf(CHIP_STM32F7_RCC_HSE_FREQUENCY 25000000 INT INTERNAL)

#
# user settable parameters
#
set_dconf(BOARD_BUTTONS_ENABLE 1 BOOL "Enable GPIO for the user button(s)")
set_dconf(BOARD_LEDS_ENABLE 1 BOOL "Enable GPIO for the user LED(s)")

#
# add source files
#

set(tmp_arch_dir "${DISTORTOS_BOARDS_PATH}/${DISTORTOS_BOARD_DIRECTORY}")

# add specific #include path
list(APPEND DISTORTOS_ARCH_INCLUDE_PATH
	"${tmp_arch_dir}/include"
)

# add board specific source files
list(APPEND DISTORTOS_SRCS
	"${tmp_arch_dir}/${BOARD}-buttons.cpp"
	"${tmp_arch_dir}/${BOARD}-leds.cpp"
)
