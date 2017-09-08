############################################################
#
#	CMake configuration for CPU STM32F76
#
#	(c) 2017-2017 elbe informatik GmbH
#
#	$Id$
#

message(STATUS "Configuring for CPU STM32F76")

# Set the CPU
set_dconf(CHIP_STM32F76 TRUE BOOL INTERNAL)

#
# fixed configuration
#
set_dconf(CHIP_ROM_SIZE 2097152 INT INTERNAL)
set_dconf(CHIP_ROM_ADDRESS 0x08000000 HEXINT INTERNAL)

#
# user settable parameters
#

#
# add source files
#

# include more generic CPU definitions
include(STM32F7)
