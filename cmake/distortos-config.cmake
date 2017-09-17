############################################################
#
#	CMake configuration for distortos
#
#	(c) 2017-2017 elbe informatik GmbH
#
#	$Id$
#
 
list(APPEND DISTORTOS_CONFIG_REPLACE_PREFIXES "DISTORTOS_")

#
# fixed configuration
#

#
# user settable parameters
#
set_dconf(DISTORTOS_DISABLE_LLINIT FALSE BOOL "Disable low level HW init")
set_dconf(DISTORTOS_TICK_FREQUENCY 1000 INT "Scheduler tick frequency [Hz]")
set_dconf(DISTORTOS_ROUND_ROBIN_FREQUENCY 10 INT "Scheduler RR frequency [Hz]")
set_dconf(DISTORTOS_SIGNALS_ENABLE TRUE BOOL "Enable signal functionality")
set_dconf(DISTORTOS_THREAD_DETACH_ENABLE TRUE BOOL "Enable detached threads")
set_dconf(DISTORTOS_MAIN_THREAD_STACK_SIZE 4096 INT "Stack size for main [Bytes]")
set_dconf(DISTORTOS_MAIN_THREAD_PRIORITY 127 INT "main prio")
if(NOT DISTORTOS_SIGNALS_ENABLE)
	unset(DISTORTOS_MAIN_THREAD_CAN_RECEIVE_SIGNALS CACHE)
endif()
set_dconf(DISTORTOS_MAIN_THREAD_CAN_RECEIVE_SIGNALS ${DISTORTOS_SIGNALS_ENABLE} BOOL "Depends on DISTORTOS_SIGNALS_ENABLE.")
if(NOT DISTORTOS_MAIN_THREAD_CAN_RECEIVE_SIGNALS)
	set(tmpqs 0)
	unset(DISTORTOS_MAIN_THREAD_QUEUED_SIGNALS CACHE)
	unset(DISTORTOS_MAIN_THREAD_SIGNAL_ACTIONS CACHE)
else()
	set(tmpqs 8)
endif()
set_dconf(DISTORTOS_MAIN_THREAD_QUEUED_SIGNALS ${tmpqs} INT "Max queud signals, 0-4294967295 (depends on DISTORTOS_MAIN_THREAD_CAN_RECEIVE_SIGNALS)" RANGE 0-4294967295)
set_dconf(DISTORTOS_MAIN_THREAD_SIGNAL_ACTIONS ${tmpqs} INT "Max signal actions, 0-32 (depends on DISTORTOS_MAIN_THREAD_CAN_RECEIVE_SIGNALS)" RANGE 0-32)

set_dconf(DISTORTOS_CHECK_FUNCTION_CONTEXT_ENABLE TRUE BOOL "Enable context")
set_dconf(DISTORTOS_CHECK_STACK_POINTER_RANGE_CONTEXT_SWITCH_ENABLE TRUE BOOL "Enable")
set_dconf(DISTORTOS_CHECK_STACK_POINTER_RANGE_SYSTEM_TICK_ENABLE TRUE BOOL "Enable")
set_dconf(DISTORTOS_CHECK_STACK_GUARD_CONTEXT_SWITCH_ENABLE TRUE BOOL "Enable")
set_dconf(DISTORTOS_CHECK_STACK_GUARD_SYSTEM_TICK_ENABLE TRUE BOOL "Enable")
set_dconf(DISTORTOS_STACK_GUARD_SIZE 32 INT "[bytes]")
set_dconf(DISTORTOS_STATIC_DESTRUCTORS_ENABLE FALSE BOOL "Enable destructors for objects with static storage duration.")
if(DISTORTOS_STATIC_DESTRUCTORS_ENABLE)
	set_dconf(DISTORTOS_STATIC_DESTRUCTORS_RUN_TIME_REGISTRATION_ENABLE FALSE BOOL "Use __cxa_atexit for static destructor registration")
else()
	unset(DISTORTOS_STATIC_DESTRUCTORS_RUN_TIME_REGISTRATION_ENABLE CACHE)
endif()

get_text_regions(tmr)
list(LENGTH tmr ntr)
if(ntr GREATER 0)
	set_dconf(DISTORTOS_MEMORY_ENABLE_RAMTEXT FALSE BOOL "Enable copying a particular text section to RAM")
	if(DISTORTOS_MEMORY_ENABLE_RAMTEXT)
		if(DEFINED PREVIOUS_MEMORY_ENABLE_RAMTEXT AND NOT(PREVIOUS_MEMORY_ENABLE_RAMTEXT STREQUAL DISTORTOS_MEMORY_ENABLE_RAMTEXT))
			unset(DISTORTOS_MEMORY_RAMTEXT CACHE)
			unset(DISTORTOS_RAMTEXT_SECTION CACHE)
		endif()
		set(PREVIOUS_MEMORY_ENABLE_RAMTEXT ${DISTORTOS_MEMORY_ENABLE_RAMTEXT} CACHE INTERNAL "")
		list(GET tmr 0 tdef)
		set_dconf(DISTORTOS_MEMORY_RAMTEXT "${tdef}" STRING "Use this memory for text section in ram" VALUES ${tmr})
		set_dconf(DISTORTOS_RAMTEXT_SECTION ".ramtext.${DISTORTOS_MEMORY_RAMTEXT}" STRING "Name of text section to be copied to RAM")
	else()
		if(DEFINED PREVIOUS_MEMORY_ENABLE_RAMTEXT AND NOT(PREVIOUS_MEMORY_ENABLE_RAMTEXT STREQUAL DISTORTOS_MEMORY_ENABLE_RAMTEXT))
			unset(DISTORTOS_MEMORY_RAMTEXT CACHE)
			unset(DISTORTOS_RAMTEXT_SECTION CACHE)
		endif()
		set(PREVIOUS_MEMORY_ENABLE_RAMTEXT ${DISTORTOS_MEMORY_ENABLE_RAMTEXT} CACHE INTERNAL "")
		set_dconf(DISTORTOS_MEMORY_RAMTEXT "" STRING INTERNAL)
		set_dconf(DISTORTOS_RAMTEXT_SECTION "" STRING INTERNAL)
	endif()
else()
	unset(DISTORTOS_MEMORY_ENABLE_RAMTEXT CACHE)
	set(DISTORTOS_MEMORY_ENABLE_RAMTEXT FALSE)
endif()

if(UNIFIED_RAM_SECTION)
	if(DEFINED PREVIOUS_UNIFIED_RAM_SECTION AND NOT(PREVIOUS_UNIFIED_RAM_SECTION STREQUAL UNIFIED_RAM_SECTION))
		unset(DISTORTOS_MEMORY_BSS CACHE)
		unset(DISTORTOS_MEMORY_DATA CACHE)
		unset(DISTORTOS_MEMORY_NOINIT CACHE)
		unset(DISTORTOS_MEMORY_HEAP CACHE)
		unset(DISTORTOS_MEMORY_PROCSTACK CACHE)
		unset(DISTORTOS_MEMORY_MAINSTACK CACHE)
	endif()
	set(PREVIOUS_UNIFIED_RAM_SECTION ${UNIFIED_RAM_SECTION} CACHE INTERNAL "")
	set_dconf(DISTORTOS_MEMORY_BSS ${UNIFIED_RAM_SECTION} STRING INTERNAL)
	set_dconf(DISTORTOS_MEMORY_DATA ${UNIFIED_RAM_SECTION} STRING INTERNAL)
	set_dconf(DISTORTOS_MEMORY_NOINIT ${UNIFIED_RAM_SECTION} STRING INTERNAL)
	set_dconf(DISTORTOS_MEMORY_HEAP ${UNIFIED_RAM_SECTION} STRING INTERNAL)
	set_dconf(DISTORTOS_MEMORY_PROCSTACK ${UNIFIED_RAM_SECTION} STRING INTERNAL)
	set_dconf(DISTORTOS_MEMORY_MAINSTACK ${UNIFIED_RAM_SECTION} STRING INTERNAL)
else()
	if(DEFINED PREVIOUS_UNIFIED_RAM_SECTION AND NOT(PREVIOUS_UNIFIED_RAM_SECTION STREQUAL UNIFIED_RAM_SECTION))
		unset(DISTORTOS_MEMORY_BSS CACHE)
		unset(DISTORTOS_MEMORY_DATA CACHE)
		unset(DISTORTOS_MEMORY_NOINIT CACHE)
		unset(DISTORTOS_MEMORY_HEAP CACHE)
		unset(DISTORTOS_MEMORY_PROCSTACK CACHE)
		unset(DISTORTOS_MEMORY_MAINSTACK CACHE)
	endif()
	set(PREVIOUS_UNIFIED_RAM_SECTION ${UNIFIED_RAM_SECTION} CACHE INTERNAL "")
	get_data_regions(dmr)
	get_bss_regions(bmr)
	get_noinit_regions(nmr)
	get_heap_regions(hmr)
	get_stack_regions(smr)
	list(GET dmr 0 ddef)
	list(GET bmr 0 bdef)
	list(GET nmr 0 ndef)
	list(GET hmr 0 hdef)
	list(GET smr 0 sdef)
	set_dconf(DISTORTOS_MEMORY_BSS ${bdef} STRING "Memory for .bss section" VALUES ${bmr})
	set_dconf(DISTORTOS_MEMORY_DATA ${ddef} STRING "Memory for .data section" VALUES ${dmr})
	set_dconf(DISTORTOS_MEMORY_NOINIT ${ndef} STRING "Memory for .noinit section" VALUES ${nmr})
	set_dconf(DISTORTOS_MEMORY_HEAP ${hdef} STRING "Memory for the heap" VALUES ${hmr})
	set_dconf(DISTORTOS_MEMORY_PROCSTACK ${ndef} STRING "Memory for PSP stack" VALUES ${smr})
	set_dconf(DISTORTOS_MEMORY_MAINSTACK ${ndef} STRING "Memory for MSP stack" VALUES ${smr})
endif()

#
# add source files
#
set(tmp_src_dir "${DISTORTOS_TOPDIR}/source")
list(APPEND DISTORTOS_SRCS
	"${tmp_src_dir}/fatalErrorHandler.cpp"
)

set(tmp_src_dir "${DISTORTOS_TOPDIR}/source/clocks")
list(APPEND DISTORTOS_SRCS
	"${tmp_src_dir}/TickClock.cpp"
)

set(tmp_src_dir "${DISTORTOS_TOPDIR}/source/devices")
list(APPEND DISTORTOS_SRCS
	"${tmp_src_dir}/communication/SpiDevice.cpp"
	"${tmp_src_dir}/communication/Rs485.cpp"
	"${tmp_src_dir}/communication/SpiMasterLowLevel.cpp"
	"${tmp_src_dir}/communication/SpiMaster.cpp"
	"${tmp_src_dir}/communication/SerialPort.cpp"
	"${tmp_src_dir}/communication/UartBase.cpp"
	"${tmp_src_dir}/communication/SpiMasterBase.cpp"
	"${tmp_src_dir}/communication/UartLowLevel.cpp"
	"${tmp_src_dir}/io/InputPin.cpp"
	"${tmp_src_dir}/memory/SpiEeprom.cpp"
)

set(tmp_src_dir "${DISTORTOS_TOPDIR}/source/gcc")
list(APPEND DISTORTOS_SRCS
	"${tmp_src_dir}/cxa_pure_virtual.cpp"
)

set(tmp_src_dir "${DISTORTOS_TOPDIR}/source/memory")
list(APPEND DISTORTOS_SRCS
	"${tmp_src_dir}/DeferredThreadDeleter.cpp"
	"${tmp_src_dir}/getDeferredThreadDeleter.cpp"
)

set(tmp_src_dir "${DISTORTOS_TOPDIR}/source/newlib")
list(APPEND DISTORTOS_SRCS
	"${tmp_src_dir}/syscallsStubs.cpp"
	"${tmp_src_dir}/assert_func.cpp"
	"${tmp_src_dir}/locking.cpp"
	"${tmp_src_dir}/sbrk_r.cpp"
)

set(tmp_src_dir "${DISTORTOS_TOPDIR}/source/scheduler")
list(APPEND DISTORTOS_SRCS
	"${tmp_src_dir}/getScheduler.cpp"
	"${tmp_src_dir}/Stack.cpp"
	"${tmp_src_dir}/SoftwareTimerControlBlock.cpp"
	"${tmp_src_dir}/MainThread.cpp"
	"${tmp_src_dir}/ThreadControlBlock.cpp"
	"${tmp_src_dir}/forceContextSwitch.cpp"
	"${tmp_src_dir}/ThreadGroupControlBlock.cpp"
	"${tmp_src_dir}/statistics.cpp"
	"${tmp_src_dir}/Scheduler.cpp"
	"${tmp_src_dir}/idleThreadFunction.cpp"
	"${tmp_src_dir}/distortosPreinitArray.cpp"
	"${tmp_src_dir}/SoftwareTimerCommon.cpp"
	"${tmp_src_dir}/SoftwareTimer.cpp"
	"${tmp_src_dir}/SoftwareTimerSupervisor.cpp"
	"${tmp_src_dir}/RoundRobinQuantum.cpp"
	"${tmp_src_dir}/lowLevelInitialization.cpp"
)

set(tmp_src_dir "${DISTORTOS_TOPDIR}/source/synchronization")
list(APPEND DISTORTOS_SRCS
	"${tmp_src_dir}/SignalsReceiverControlBlock.cpp"
	"${tmp_src_dir}/DynamicRawMessageQueue.cpp"
	"${tmp_src_dir}/MemcpyPushQueueFunctor.cpp"
	"${tmp_src_dir}/DynamicRawFifoQueue.cpp"
	"${tmp_src_dir}/FifoQueueBase.cpp"
	"${tmp_src_dir}/SemaphoreTryWaitUntilFunctor.cpp"
	"${tmp_src_dir}/RawMessageQueue.cpp"
	"${tmp_src_dir}/SemaphoreTryWaitFunctor.cpp"
	"${tmp_src_dir}/MemcpyPopQueueFunctor.cpp"
	"${tmp_src_dir}/MutexControlBlock.cpp"
	"${tmp_src_dir}/SignalsCatcherControlBlock.cpp"
	"${tmp_src_dir}/RawFifoQueue.cpp"
	"${tmp_src_dir}/Mutex.cpp"
	"${tmp_src_dir}/ConditionVariable.cpp"
	"${tmp_src_dir}/DynamicSignalsReceiver.cpp"
	"${tmp_src_dir}/SemaphoreWaitFunctor.cpp"
	"${tmp_src_dir}/MessageQueueBase.cpp"
	"${tmp_src_dir}/SignalSet.cpp"
	"${tmp_src_dir}/Semaphore.cpp"
	"${tmp_src_dir}/SignalInformationQueue.cpp"
	"${tmp_src_dir}/ThisThread-Signals.cpp"
	"${tmp_src_dir}/SemaphoreTryWaitForFunctor.cpp"
)

set(tmp_src_dir "${DISTORTOS_TOPDIR}/source/threads")
list(APPEND DISTORTOS_SRCS
	"${tmp_src_dir}/Thread.cpp"
	"${tmp_src_dir}/ThisThread.cpp"
	"${tmp_src_dir}/DynamicThread.cpp"
	"${tmp_src_dir}/DynamicThreadBase.cpp"
	"${tmp_src_dir}/UndetachableThread.cpp"
	"${tmp_src_dir}/threadRunner.cpp"
	"${tmp_src_dir}/ThreadCommon.cpp"
)
