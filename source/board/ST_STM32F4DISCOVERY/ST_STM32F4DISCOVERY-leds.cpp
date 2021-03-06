/**
 * \file
 * \brief Definition of leds for ST,STM32F4DISCOVERY
 *
 * \author Copyright (C) 2014-2017 Kamil Szczygiel http://www.distortec.com http://www.freddiechopin.info
 *
 * \par License
 * This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not
 * distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * \warning
 * Automatically generated file - do not edit!
 */

#include "distortos/board/leds.hpp"

#include "distortos/chip/ChipOutputPin.hpp"

namespace distortos
{

namespace board
{

/*---------------------------------------------------------------------------------------------------------------------+
| global objects
+---------------------------------------------------------------------------------------------------------------------*/

chip::ChipOutputPin leds[totalLeds]
{
		chip::ChipOutputPin{chip::Pin::pd13, false, chip::PinOutputSpeed::low, chip::PinPull::none, false, false},
		chip::ChipOutputPin{chip::Pin::pd12, false, chip::PinOutputSpeed::low, chip::PinPull::none, false, false},
		chip::ChipOutputPin{chip::Pin::pd14, false, chip::PinOutputSpeed::low, chip::PinPull::none, false, false},
		chip::ChipOutputPin{chip::Pin::pd15, false, chip::PinOutputSpeed::low, chip::PinPull::none, false, false},
};

}	// namespace board

}	// namespace distortos
