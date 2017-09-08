############################################################
#
#	CMake configuration for CPU STM32
#
#	(c) 2017-2017 elbe informatik GmbH
#
#	$Id$
#

message(STATUS "Configuring for CPU STM32")

# Set the CPU
set_dconf(CHIP_STM32 true BOOL INTERNAL)

#
# fixed configuration
#
set_dconf(CHIP_STM32_GPIOV2 TRUE BOOL INTERNAL)
set_dconf(CHIP_STM32_SPIV2 TRUE BOOL INTERNAL)
set_dconf(CHIP_STM32_USARTV2 TRUE BOOL INTERNAL)

#
# user settable parameters
#

#
# add source files
#

set(tmp_arch_dir "${DISTORTOS_TOPDIR}/source/chip/STM32")

# add specific #include path
list(APPEND DISTORTOS_ARCH_INCLUDE_PATH
	"${tmp_arch_dir}/STM32/include"
	"${tmp_arch_dir}/peripherals/GPIOv2/include"
	"${tmp_arch_dir}/peripherals/SPIv2/include"
	"${tmp_arch_dir}/peripherals/USARTv2/include"
	"${DISTORTOS_TOPDIR}/external/CMSIS"
)

# add arch specific source files
list(APPEND DISTORTOS_SRCS
	"${tmp_arch_dir}/peripherals/STM32-peripheralsLowLevelInitialization.cpp"
	"${tmp_arch_dir}/peripherals/GPIOv2/STM32-GPIOv2-ChipInputPin.cpp"
	"${tmp_arch_dir}/peripherals/GPIOv2/STM32-GPIOv2.cpp"
	"${tmp_arch_dir}/peripherals/GPIOv2/STM32-GPIOv2-ChipOutputPin.cpp"
	"${tmp_arch_dir}/peripherals/SPIv2/STM32-SPIv2-ChipSpiMasterLowLevel.cpp"
	"${tmp_arch_dir}/peripherals/SPIv2/STM32-SPIv2-spiLowLevelInitialization.cpp"
	"${tmp_arch_dir}/peripherals/SPIv2/STM32-SPIv2-spis.cpp"
	"${tmp_arch_dir}/peripherals/USARTv2/STM32-USARTv2-uarts.cpp"
	"${tmp_arch_dir}/peripherals/USARTv2/STM32-USARTv2-usartLowLevelInitialization.cpp"
	"${tmp_arch_dir}/peripherals/USARTv2/STM32-USARTv2-ChipUartLowLevel.cpp"
)

# STM32 is the most generic family designator, nothing to include
