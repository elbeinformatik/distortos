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
set_dconf(DISTORTOS_DRIVERLESS FALSE BOOL "Disable all peripheral drivers (GPIO, UART, SPI, ...)")
if(DISTORTOS_DRIVERLESS)
	set(DISTORTOS_DRIVER_ENABLE FALSE)
else()
	set(DISTORTOS_DRIVER_ENABLE TRUE)
endif()
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
set_dconf(DISTORTOS_LDSCRIPT_ROM_BEGIN 0 INT "[bytes]")
set_dconf(DISTORTOS_LDSCRIPT_ROM_END 2097152 INT "[bytes]")

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
