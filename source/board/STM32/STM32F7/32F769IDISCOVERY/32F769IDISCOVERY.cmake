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

set(tmp_arch_dir "${DISTORTOS_TOPDIR}/source/board/STM32/STM32F7/32F769IDISCOVERY")

# add specific #include path
list(APPEND DISTORTOS_ARCH_INCLUDE_PATH
	"${tmp_arch_dir}/include"
)

# add board specific source files
list(APPEND DISTORTOS_SRCS
	"${tmp_arch_dir}/32F769IDISCOVERY-buttons.cpp"
	"${tmp_arch_dir}/32F769IDISCOVERY-leds.cpp"
)
