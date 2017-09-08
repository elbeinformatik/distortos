############################################################
#
#	CMake configuration for CPU STM32F769
#
#	(c) 2017-2017 elbe informatik GmbH
#
#	$Id$
#

message(STATUS "Configuring for CPU STM32F769")

# Set the CPU
set_dconf(CHIP_STM32F769 TRUE BOOL INTERNAL)

#
# fixed configuration
#

#
# user settable parameters
#

#
# add source files
#

# include more generic CPU definitions
include(STM32F76)
