############################################################
#
#	CMake configuration for distortos unit tests
#
#	(c) 2017-2017 elbe informatik GmbH
#
#	$Id$
#
 
# add source files

set(tmp_src_dir "${DISTORTOS_TOPDIR}/test")
list(APPEND DISTORTOS_TEST_SRCS
	"${tmp_src_dir}/SequenceAsserter.cpp"
	"${tmp_src_dir}/PrioritizedTestCase.cpp"
	"${tmp_src_dir}/priorityTestPhases.cpp"
	"${tmp_src_dir}/wasteTime.cpp"
	"${tmp_src_dir}/testCases.cpp"
	"${tmp_src_dir}/TestCaseCommon.cpp"
	"${tmp_src_dir}/waitForNextTick.cpp"
	"${tmp_src_dir}/OperationCountingType.cpp"
	"${tmp_src_dir}/TestCase.cpp"
	"${tmp_src_dir}/main.cpp"
	"${tmp_src_dir}/TestCaseGroup.cpp"
)

set(tmp_src_dir "${DISTORTOS_TOPDIR}/test/CallOnce")
list(APPEND DISTORTOS_TEST_SRCS
	"${tmp_src_dir}/CallOnceOperationsTestCase.cpp"
	"${tmp_src_dir}/CallOnceFunctionTypesTestCase.cpp"
	"${tmp_src_dir}/callOnceTestCases.cpp"
)

set(tmp_src_dir "${DISTORTOS_TOPDIR}/test/ConditionVariable")
list(APPEND DISTORTOS_TEST_SRCS
	"${tmp_src_dir}/ConditionVariablePriorityTestCase.cpp"
	"${tmp_src_dir}/conditionVariableTestCases.cpp"
	"${tmp_src_dir}/ConditionVariableOperationsTestCase.cpp"
)

set(tmp_src_dir "${DISTORTOS_TOPDIR}/test/Mutex")
list(APPEND DISTORTOS_TEST_SRCS
	"${tmp_src_dir}/MutexPriorityProtocolTestCase.cpp"
	"${tmp_src_dir}/MutexPriorityInheritanceOperationsTestCase.cpp"
	"${tmp_src_dir}/mutexTestUnlockFromWrongThread.cpp"
	"${tmp_src_dir}/MutexErrorCheckingOperationsTestCase.cpp"
	"${tmp_src_dir}/mutexTestCases.cpp"
	"${tmp_src_dir}/mutexTestTryLockWhenLocked.cpp"
	"${tmp_src_dir}/MutexPriorityTestCase.cpp"
	"${tmp_src_dir}/MutexRecursiveOperationsTestCase.cpp"
	"${tmp_src_dir}/MutexPriorityProtectOperationsTestCase.cpp"
	"${tmp_src_dir}/MutexOperationsTestCase.cpp"
)

set(tmp_src_dir "${DISTORTOS_TOPDIR}/test/Queue")
list(APPEND DISTORTOS_TEST_SRCS
	"${tmp_src_dir}/QueueWrappers.cpp"
	"${tmp_src_dir}/FifoQueuePriorityTestCase.cpp"
	"${tmp_src_dir}/queueTestCases.cpp"
	"${tmp_src_dir}/QueueOperationsTestCase.cpp"
	"${tmp_src_dir}/MessageQueuePriorityTestCase.cpp"
)

set(tmp_src_dir "${DISTORTOS_TOPDIR}/test/Semaphore")
list(APPEND DISTORTOS_TEST_SRCS
	"${tmp_src_dir}/SemaphorePriorityTestCase.cpp"
	"${tmp_src_dir}/semaphoreTestCases.cpp"
	"${tmp_src_dir}/SemaphoreOperationsTestCase.cpp"
)

set(tmp_src_dir "${DISTORTOS_TOPDIR}/test/Signals")
list(APPEND DISTORTOS_TEST_SRCS
	"${tmp_src_dir}/SignalsGenerationOperationsTestCase.cpp"
	"${tmp_src_dir}/SignalCatchingOperationsTestCase.cpp"
	"${tmp_src_dir}/signalsTestCases.cpp"
	"${tmp_src_dir}/SignalsTestCaseCommon.cpp"
	"${tmp_src_dir}/SignalsInterruptionTestCase.cpp"
	"${tmp_src_dir}/SignalsWaitTestCase.cpp"
	"${tmp_src_dir}/SignalsCatchingTestCase.cpp"
	"${tmp_src_dir}/SignalsWaitOperationsTestCase.cpp"
	"${tmp_src_dir}/abortSignalHandler.cpp"
	"${tmp_src_dir}/signalsTestSelfOneSignalPending.cpp"
	"${tmp_src_dir}/SignalsQueuedOperationsTestCase.cpp"
)

set(tmp_src_dir "${DISTORTOS_TOPDIR}/test/SoftwareTimer")
list(APPEND DISTORTOS_TEST_SRCS
	"${tmp_src_dir}/SoftwareTimerOperationsTestCase.cpp"
	"${tmp_src_dir}/SoftwareTimerPeriodicTestCase.cpp"
	"${tmp_src_dir}/SoftwareTimerOrderingTestCase.cpp"
	"${tmp_src_dir}/softwareTimerTestCases.cpp"
	"${tmp_src_dir}/SoftwareTimerFunctionTypesTestCase.cpp"
)

set(tmp_src_dir "${DISTORTOS_TOPDIR}/test/Thread")
list(APPEND DISTORTOS_TEST_SRCS
	"${tmp_src_dir}/ThreadPriorityTestCase.cpp"
	"${tmp_src_dir}/ThreadFunctionTypesTestCase.cpp"
	"${tmp_src_dir}/ThreadSleepForTestCase.cpp"
	"${tmp_src_dir}/ThreadOperationsTestCase.cpp"
	"${tmp_src_dir}/threadTestCases.cpp"
	"${tmp_src_dir}/ThreadSchedulingPolicyTestCase.cpp"
	"${tmp_src_dir}/ThreadSleepUntilTestCase.cpp"
	"${tmp_src_dir}/ThreadPriorityChangeTestCase.cpp"
)

set(tmp_src_dir "${DISTORTOS_TOPDIR}/test/SoftwareTimer")
list(APPEND DISTORTOS_TEST_SRCS
	"${tmp_src_dir}/SoftwareTimerOperationsTestCase.cpp"
	"${tmp_src_dir}/SoftwareTimerPeriodicTestCase.cpp"
	"${tmp_src_dir}/SoftwareTimerOrderingTestCase.cpp"
	"${tmp_src_dir}/softwareTimerTestCases.cpp"
	"${tmp_src_dir}/SoftwareTimerFunctionTypesTestCase.cpp"
)


#
# fixed configuration
#

#
# user settable parameters
#
