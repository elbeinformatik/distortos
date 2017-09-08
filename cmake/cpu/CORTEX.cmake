############################################################
#
#	CMake configuration for all CORTEX models
#
#	(c) 2017-2017 elbe informatik GmbH
#
#	$Id$
#

message(STATUS "Configuring for CORTEX")

#
# fixed configuration
#

#
# user settable parameters
#

#
# add source files
#

set(tmp_arch_dir "${DISTORTOS_TOPDIR}/source/architecture/ARM/ARMv6-M-ARMv7-M")
# add specific #include path
list(APPEND DISTORTOS_ARCH_INCLUDE_PATH
	"${tmp_arch_dir}/include"
)

# add arch specific source files
list(APPEND DISTORTOS_SRCS
	"${tmp_arch_dir}/ARMv6-M-ARMv7-M-initializeStack.cpp"
	"${tmp_arch_dir}/ARMv6-M-ARMv7-M-lowLevelInitialization.cpp"
	"${tmp_arch_dir}/ARMv6-M-ARMv7-M-restoreInterruptMasking.cpp"
	"${tmp_arch_dir}/ARMv6-M-ARMv7-M-SVC_Handler.cpp"
	"${tmp_arch_dir}/ARMv6-M-ARMv7-M-getMainStack.cpp"
	"${tmp_arch_dir}/ARMv6-M-ARMv7-M-SysTick_Handler.cpp"
	"${tmp_arch_dir}/ARMv6-M-ARMv7-M-Reset_Handler.cpp"
	"${tmp_arch_dir}/ARMv6-M-ARMv7-M-requestFunctionExecution.cpp"
	"${tmp_arch_dir}/ARMv6-M-ARMv7-M-isInInterruptContext.cpp"
	"${tmp_arch_dir}/ARMv6-M-ARMv7-M-startScheduling.cpp"
	"${tmp_arch_dir}/ARMv6-M-ARMv7-M-disableInterruptMasking.cpp"
	"${tmp_arch_dir}/ARMv6-M-ARMv7-M-enableInterruptMasking.cpp"
	"${tmp_arch_dir}/ARMv6-M-ARMv7-M-coreVectors.cpp"
	"${tmp_arch_dir}/ARMv6-M-ARMv7-M-requestContextSwitch.cpp"
	"${tmp_arch_dir}/ARMv6-M-ARMv7-M-PendSV_Handler.cpp"
	"${tmp_arch_dir}/ARMv6-M-ARMv7-M-supervisorCall.cpp"
)

set(tmp_src_dir "${DISTORTOS_TOPDIR}/test/architecture/ARM/ARMv7-M")
list(APPEND DISTORTOS_TEST_SRCS
	"${tmp_src_dir}/ARMv7-M-architectureTestCases.cpp"
	"${tmp_src_dir}/ARMv7-M-checkFpuRegisters.cpp"
	"${tmp_src_dir}/ARMv7-M-FpuThreadTestCase.cpp"
	"${tmp_src_dir}/ARMv7-M-FpuSignalTestCase.cpp"
	"${tmp_src_dir}/ARMv7-M-setFpuRegisters.cpp"
)

# include more generic CPU definitions
include(ARM)
