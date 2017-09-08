##############################################################
#
#	Cross-Toolchain for CORTEX-M7 (STM32F7)
#
#	(c) 2016-2017 elbe informatik GmbH
#
#	$Id$

# this one is important
SET(CMAKE_SYSTEM_NAME Generic)
#this one not so much
SET(CMAKE_SYSTEM_VERSION 1)

#IF(CMAKE_HOST_WIN32)
	# CMake-Bug http://public.kitware.com/Bug/view.php?id=15278
#	IF(${CMAKE_GENERATOR} STREQUAL Ninja)
#		SET(CMAKE_COMPILER_IS_MINGW 1)
#	ENDIF()
#ENDIF()

IF(NOT DISABLE_BINUTILS_PLUGINS)
	SET(BPMOD "gcc-")
ELSE()
	SET(BPMOD "")
ENDIF()

SET(TARGET_TRIPLE "arm-none-eabi")

# Bug: CMAKE_AR and CMAKE_RANLIB have to be set as CACHE variables:
# https://cmake.org/Bug/view.php?id=13038
SET(CMAKE_C_COMPILER    ${TARGET_TRIPLE}-gcc)
SET(CMAKE_CXX_COMPILER  ${TARGET_TRIPLE}-g++)
SET(CMAKE_AR            ${TARGET_TRIPLE}-${BPMOD}ar CACHE STRING "Static library linker")
# SET(CMAKE_AR            /opt/cross/arm-none-eabi/bin/arm-none-eabi-ar.exe CACHE STRING "Static library linker")
SET(CMAKE_RANLIB        ${TARGET_TRIPLE}-${BPMOD}ranlib CACHE STRING "Static library indexer")
# Target needs assembler?
# SET(CMAKE_ASM_COMPILER  ${TARGET_TRIPLE}-gcc)
# enable_language(ASM)

# set(CMAKE_OBJCOPY	${TARGET_TRIPLE}-objcopy)
# set(CMAKE_OBJDUMP	${TARGET_TRIPLE}-objdump)

# where is the target environment
SET(CMAKE_FIND_ROOT_PATH  /opt/cross/arm-none-eabi/arm-none-eabi/sysroot)

# search for programs in the build host directories
SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# for libraries and headers in the target directories
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

add_compile_options(-mcpu=cortex-m7 -mthumb -mfloat-abi=hard -mfpu=fpv5-d16)
# ADD_FLAGS(CMAKE_EXE_LINKER_FLAGS "-Xlinker --gc-sections")

#IF(NOT NO_DUMMY_SYSCALLS)
#	ADD_FLAGS(CMAKE_EXE_LINKER_FLAGS "-specs=nosys.specs")
#ENDIF()
