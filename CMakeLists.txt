############################################################
#
#	distortos CMake configuration
#
#	(c) 2017-2017 elbe informatik GmbH
#
#	$Id$
#

cmake_minimum_required(VERSION 3.8)

#
# build environment setup
#

# find some paths
if(NOT DISTORTOS_TOPDIR)
	set(DISTORTOS_TOPDIR ${CMAKE_CURRENT_SOURCE_DIR})
endif()
set(DISTORTOS_INCLUDE_PATH "${DISTORTOS_TOPDIR}/include")
set(DISTORTOS_ARCH_INCLUDE_PATH "")
set(CMAKE_MODULE_PATH ${DISTORTOS_TOPDIR}/cmake ${DISTORTOS_TOPDIR}/cmake/cpu)


# clear configuration variable list
set(DISTORTOS_CONFIGS "")

include(distortos-utils)
include(hexmath)
include(ldscript)

set(DISTORTOS_LDSCRIPT_PATH "${CMAKE_BINARY_DIR}")
set(DISTORTOS_LDSCRIPT_FILE "distortos.ld")
set(DISTORTOS_SYBOLSLD_FILE "symbols.ld")

#
# project definitions
#
if(NOT CMAKE_BUILD_TYPE)
	message(STATUS "CMAKE_BUILD_TYPE defaults to Debug")
	set(CMAKE_BUILD_TYPE "Debug")
endif()
project(distortos)

#
# configuration stuff
#

# set additional config variable prefixes to be replaced by "CONFIG_"
# The additional prefixes are used  for grouping the config variables for cmake-gui/ccmake
# TODO: rather use these prefixes in the source code.
set(DISTORTOS_CONFIG_REPLACE_PREFIXES "")

# unset any ldscript RAM definitions
set(LDSCRIPT_RAM_REGIONS "")

# find available boards:
# generate list DISTORTOS_BOARD_NAMES
distortos_getboards()

# make sure the target board is known
if(NOT BOARD OR (BOARD STREQUAL "INVALID_BOARD"))
	set_dconf(BOARD "INVALID_BOARD" STRING "Board name (avail: ${DISTORTOS_BOARD_NAMES})" VALUES ${DISTORTOS_BOARD_NAMES})
	message(FATAL_ERROR "Please specify BOARD to one of ${DISTORTOS_BOARD_NAMES}")
endif()

# set up board variables
list(FIND DISTORTOS_BOARD_NAMES "${BOARD}" DISTORTOS_BOARD_INDEX)
if(DISTORTOS_BOARD_INDEX LESS 0)
	message(FATAL_ERROR "Board ${BOARD} unknown, should be one of '" ${DISTORTOS_BOARD_NAMES} "'")
endif()
list(GET DISTORTOS_BOARD_DIRECTORIES ${DISTORTOS_BOARD_INDEX} DISTORTOS_BOARD_DIRECTORY)
if(NOT DISTORTOS_BOARD_DIRECTORY)
	message(FATAL_ERROR "Internal error: cannot get board directory")
endif()
message(STATUS "Board directory for board ${BOARD} is ${DISTORTOS_BOARDS_PATH}/${DISTORTOS_BOARD_DIRECTORY}")

# include board CMake file
set(DISTORTOS_BOARD_CMAKE_FILE "${DISTORTOS_BOARDS_PATH}/${DISTORTOS_BOARD_DIRECTORY}/${BOARD}.cmake")
include("${DISTORTOS_BOARD_CMAKE_FILE}")
if(NOT DEFINED CHIP)
	message(FATAL_ERROR "Board config file ${DISTORTOS_BOARD_CMAKE_FILE} does not specify CONFIG_CHIP")
endif()

#
# build test application?
#
set_dconf(TEST_APPLICATION_ENABLE FALSE BOOL "Build test application")

# include CPU configs
include(${CHIP})
# include distortos configs
include(distortos-config)

set(DISTORTOS_GENERATED_INCLUDE_DIR ${CMAKE_BINARY_DIR}/include)
set(DISTORTOS_CFG_DIR ${DISTORTOS_GENERATED_INCLUDE_DIR}/distortos)
set(DISTORTOS_CFG_FILE distortosConfiguration.h)

# message(STATUS "DISTORTOS_CONFIGS ist ${DISTORTOS_CONFIGS}") #, DISTORTOS_CONFIG_TYPES ist ${DISTORTOS_CONFIG_TYPES}")

distortos_genconfig()

#
# distortos library build setup
#

add_compile_options(-Wall -Wextra -Wshadow)
add_compile_options(-std=gnu++11)
add_compile_options(-ffunction-sections -fdata-sections -fno-rtti -fno-exceptions)

# include directories
include_directories("${DISTORTOS_INCLUDE_PATH}" "${DISTORTOS_GENERATED_INCLUDE_DIR}")
foreach(di IN LISTS DISTORTOS_ARCH_INCLUDE_PATH)
	include_directories("${di}")
endforeach()

add_library(distortos STATIC ${DISTORTOS_SRCS})

# generate linker script
hexmath(HEX rombegin "${DISTORTOS_LDSCRIPT_ROM_BEGIN} + ${CHIP_ROM_ADDRESS}")
hexmath(EXPR romsize "${DISTORTOS_LDSCRIPT_ROM_END} - ${DISTORTOS_LDSCRIPT_ROM_BEGIN}")
generate_ldscript("${DISTORTOS_LDSCRIPT_PATH}/${DISTORTOS_LDSCRIPT_FILE}"
	"${CHIP}"
	"${rombegin}"
	"${DISTORTOS_LDSCRIPT_ROM_END}"
	"${LDSCRIPT_RAM_BEGIN}"
	"${LDSCRIPT_RAM_SIZE}"
	${LDSCRIPT_RAM_REGIONS}
)

generate_symbolsld("${DISTORTOS_LDSCRIPT_PATH}/${DISTORTOS_SYBOLSLD_FILE}")

#
# Build settings for test application
#
if(TEST_APPLICATION_ENABLE)
	set(dtest distortos-test)
	set(dtarg ${dtest}.elf)
	include(distortos-test)
	add_executable(${dtarg} ${DISTORTOS_TEST_SRCS})
	target_link_libraries(${dtarg}
		-Wl,--whole-archive distortos -Wl,--no-whole-archive
		-Wl,-Map=${CMAKE_BINARY_DIR}/${dtest}.map,--cref,--gc-sections
		-T${DISTORTOS_LDSCRIPT_PATH}/${DISTORTOS_LDSCRIPT_FILE}
		-T${DISTORTOS_LDSCRIPT_PATH}/${DISTORTOS_SYBOLSLD_FILE}
	)
	target_include_directories(${dtarg} PUBLIC "${DISTORTOS_TOPDIR}/test")

	if(NOT CMAKE_OBJCOPY)
		message(WARNING "Not generating .bin and .hex output. Please set CMAKE_OBJCOPY in your toolchain file")
	else()
		# .bin-Datei und hex-Datei erstellen
		add_custom_command(TARGET ${dtarg} POST_BUILD
				  COMMAND ${CMAKE_OBJCOPY} -O binary ${dtarg} ${dtest}.bin
				  COMMAND ${CMAKE_OBJCOPY} -O ihex ${dtarg} ${dtest}.hex
				  WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
				  COMMENT "Generating ${dtest}.bin and ${dtest}.hex"
		)
	endif()
endif()
