############################################################
#
#	CMake configuration for CPU STM32F769NI
#
#	(c) 2017-2017 elbe informatik GmbH
#
#	$Id$
#

message(STATUS "Configuring for CPU STM32F769NI")

# Set the CPU
set_dconf(CHIP_STM32F769NI TRUE BOOL INTERNAL)

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
include(STM32F769N)
