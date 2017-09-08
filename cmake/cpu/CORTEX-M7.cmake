############################################################
#
#	CMake configuration for CORTEX-M7 models
#
#	(c) 2017-2017 elbe informatik GmbH
#
#	$Id$
#

message(STATUS "Configuring for CORTEX-M7")

#
# fixed configuration
#
set_dconf(ARCHITECTURE_ARMV7_M TRUE BOOL INTERNAL)
set_dconf(ARCHITECTURE_ARM_CORTEX_M7 TRUE BOOL INTERNAL)
set_dconf(ARCHITECTURE_ARM_CORTEX_M7_R1P0 TRUE BOOL INTERNAL)
set_dconf(ARCHITECTURE_HAS_FPV5_D16 TRUE BOOL INTERNAL)
set_dconf(ARCHITECTURE_FPU TRUE BOOL INTERNAL)
set_dconf(ARCHITECTURE_HAS_FPU TRUE BOOL INTERNAL)
		
#
# user settable parameters
#
set_dconf(ARCHITECTURE_ARMV7_M_KERNEL_BASEPRI 0 INT
	"Min prio (inclusive) of interrupt handlers that can use system's functions."
	VALUES 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15)
set_dconf(ARCHITECTURE_ARMV6_M_ARMV7_M_MAIN_STACK_SIZE 1024 INT
		"Size (in bytes) of 'main' stack used by core exceptions and interrupts in Handler mode."
		RANGE 8-4294967295
)

#
# add source files
#

# include more generic CPU definitions
include(CORTEX)
