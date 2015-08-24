#
# file: Rules.mk
#
# author: Copyright (C) 2015 Kamil Szczygiel http://www.distortec.com http://www.freddiechopin.info
#
# This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not
# distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# date: 2015-08-24
#

#-----------------------------------------------------------------------------------------------------------------------
# compilation flags
#-----------------------------------------------------------------------------------------------------------------------

CXXFLAGS_$(d) := $(CXXFLAGS_$(d)) -Iinclude
CXXFLAGS_$(d) := $(CXXFLAGS_$(d)) -Isource/architecture/ARM/ARMv7-M/include

#-----------------------------------------------------------------------------------------------------------------------
# standard footer
#-----------------------------------------------------------------------------------------------------------------------

include footer.mk
