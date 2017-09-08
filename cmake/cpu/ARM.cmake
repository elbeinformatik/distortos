############################################################
#
#	CMake configuration for ARM architecture
#
#	(c) 2017-2017 elbe informatik GmbH
#
#	$Id$
#

message(STATUS "Configuring for ARM")

#
# fixed configuration
#
set_dconf(ARCHITECTURE_ARM TRUE BOOL INTERNAL)
set_dconf(ARCHITECTURE_STACK_ALIGNMENT 8 INT INTERNAL)

#
# user settable parameters
#

#
# add source files
#

# ARM is the most generic architecture designator, nothing to include
