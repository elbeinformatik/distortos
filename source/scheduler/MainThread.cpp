/**
 * \file
 * \brief MainThread class implementation
 *
 * \author Copyright (C) 2014-2017 Kamil Szczygiel http://www.distortec.com http://www.freddiechopin.info
 *
 * \par License
 * This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not
 * distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

#include "distortos/internal/scheduler/MainThread.hpp"

#include "distortos/architecture/getMainStack.hpp"

namespace distortos
{

namespace internal
{

namespace
{

/*---------------------------------------------------------------------------------------------------------------------+
| local functions
+---------------------------------------------------------------------------------------------------------------------*/

/**
 * \brief Wrapper for Stack's constructor.
 *
 * Enables use of architecture::getMainStack() result to construct Stack.
 *
 * \param [in] stackBuffer is a pair with beginning of stack and its size in bytes
 *
 * \return constructed Stack object
 */

Stack stackWrapper(const std::pair<void*, size_t> stackBuffer)
{
	return {stackBuffer.first, stackBuffer.second};
}

}	// namespace

/*---------------------------------------------------------------------------------------------------------------------+
| public functions
+---------------------------------------------------------------------------------------------------------------------*/

MainThread::MainThread(const uint8_t priority, ThreadGroupControlBlock& threadGroupControlBlock,
		SignalsReceiver* const signalsReceiver) :
		UndetachableThread{stackWrapper(architecture::getMainStack()), priority, SchedulingPolicy::roundRobin,
				&threadGroupControlBlock, signalsReceiver}
{

}

}	// namespace internal

}	// namespace distortos
