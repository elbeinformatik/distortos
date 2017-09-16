############################################################
#
#	GNU ld script generation for ARM CORTEX
#
#	(c) 2017-2017 elbe informatik GmbH
#
#	$Id$
#

set(AVAILABLE_MEMORY_TYPES RAM ROM)
set(AVAILABLE_SECTION_TYPES text data bss noinit heap stack main_stack process_stack)

# add a memory region to the list of known regions
# parameters:
# memoryname: identification for the region, and for symbols defined by the linker script (e.g. __<name>_start etc.)
# memoryaddress: absolute start address
# memorysize: size of the region in bytes
# memorytype: RAM or ROM
# PROVIDE_SEPARATE_DATA (flag): provide for .<memoryname>.data sections in the linker script
# PROVIDE_SEPARATE_BSS (flag): provide for .<memoryname>.bss sections in the linker script
# PROVIDE_SEPARATE_NOINIT (flag): provide for .<memoryname>.noinit sections in the linker script
# VMADDR <mapaddress>: contents of this region should have the load addr <mapaddress> instead of <memoryaddress>
# ALLOWED_SECTIONS <list>: list with section names allowed in this region (see AVAILABLE_SECTION_TYPES)
#
macro(add_memory_region
	memoryname
	memoryaddress
	memorysize
	memorytype
)
	message(STATUS "add_memory_region(${memoryname})")
	cmake_parse_arguments(_S "PROVIDE_SEPARATE_DATA;PROVIDE_SEPARATE_BSS;PROVIDE_SEPARATE_NOINIT" "VMADDR" "ALLOWED_SECTIONS" ${ARGN})
	is_integer(${memoryaddress} _ii)
	if(NOT _ii)
		MESSAGE(FATAL_ERROR "add_memory_region: ${memoryname} has invalid address ${memoryaddress}")
	endif()
	is_integer(${memorysize} _ii)
	if(NOT _ii)
		MESSAGE(FATAL_ERROR "add_memory_region: ${memoryname} has invalid size ${memorysize}")
	endif()
	if(_S_VMADDR)
		is_integer(${_S_VMADDR} _ii)
		if(NOT _ii)
			MESSAGE(FATAL_ERROR "add_memory_region: ${memoryname} has invalid VMADDR ${_S_VMADDR}")
		endif()		
	endif()
	list(FIND AVAILABLE_MEMORY_TYPES "${memorytype}" _ti)
	if(_ti LESS 0)
		MESSAGE(FATAL_ERROR "add_memory_region: ${memoryname} has invalid type ${memorytype}")
	endif()
	foreach(_ar IN LISTS _S_ALLOWED_SECTIONS)
		list(FIND AVAILABLE_SECTION_TYPES "${_ar}" _ti)
		if(_ti LESS 0)
			MESSAGE(FATAL_ERROR "add_memory_region: ${memoryname} has invalid allowed section ${_ar}")
		endif()		
	endforeach()
	list(APPEND MEMORY_REGIONS ${memoryname})
	set(MEMORY_ADDRESS_${memoryname} ${memoryaddress})
	set(MEMORY_SIZE_${memoryname} ${memorysize})
	set(MEMORY_TYPE_${memoryname} ${memorytype})
	set(MEMORY_VMADDR_${memoryname} ${_S_VMADDR})
	set(MEMORY_ALLOWED_SECTIONS_${memoryname} ${_S_ALLOWED_SECTIONS})
	if(_S_PROVIDE_SEPARATE_DATA)
		set(_sms TRUE)
	else()
		set(_sms FALSE)
	endif()
	set(MEMORY_SEPARATE_DATA_SECTION_${memoryname} ${_sms})
	if(_S_PROVIDE_SEPARATE_BSS)
		set(_sms TRUE)
	else()
		set(_sms FALSE)
	endif()
	set(MEMORY_SEPARATE_BSS_SECTION_${memoryname} ${_sms})
	if(_S_PROVIDE_SEPARATE_NOINIT)
		set(_sms TRUE)
	else()
		set(_sms FALSE)
	endif()
	set(MEMORY_SEPARATE_NOINIT_SECTION_${memoryname} ${_sms})
endmacro(add_memory_region)

macro(remove_memory_region memname)
	message(STATUS "remove_memory_region(${memname})")
	list(FIND MEMORY_REGIONS ${memname} mi)
	if(mi GREATER_EQUAL 0)
		list(REMOVE_AT MEMORY_REGIONS ${mi})
		unset(MEMORY_ADDRESS_${memname})
		unset(MEMORY_SIZE_${memname})
		unset(MEMORY_TYPE_${memname})
		unset(MEMORY_VMADDR_${memname})
		unset(MEMORY_ALLOWED_SECTIONS_${memname})
		unset(MEMORY_SEPARATE_DATA_SECTION_${memname})
		unset(MEMORY_SEPARATE_BSS_SECTION_${memname})
		unset(MEMORY_SEPARATE_NOINIT_SECTION_${memname})
	endif()
endmacro(remove_memory_region)


function(get_memoryinfo memname memtype validsections)
	cmake_parse_arguments(S "" "CHECK_SECTION_ALLOWED" "" ${ARGN})

	list(FIND MEMORY_REGIONS ${memname} mi)
	if(mi LESS 0)
		message(FATAL_ERROR "get_memoryinfo(): Invalid memory name ${memname}")
	endif()
	set(${memtype} ${MEMORY_TYPE_${memname}} PARENT_SCOPE)
	set(${validsections} ${MEMORY_ALLOWED_SECTIONS_${memname}} PARENT_SCOPE)
	if(S_CHECK_SECTION_ALLOWED)
		list(FIND MEMORY_ALLOWED_SECTIONS_${memname} "${S_CHECK_SECTION_ALLOWED}" _ti)
		if(_ti LESS 0)
			MESSAGE(FATAL_ERROR "get_memoryinfo: Section ${S_CHECK_SECTION_ALLOWED} is not allowed in ${memname}")
		endif()		
	endif()
endfunction(get_memoryinfo)

# get all RAM memory regions
function(get_ram_regions section rlst)
	set(ret)
	foreach(mr IN LISTS MEMORY_REGIONS)
		get_memoryinfo(${mr} mt vr)
		if(mt STREQUAL "RAM")
			list(APPEND ret "${mr}")
		endif()
	endforeach()
	list(LENGTH ret mrc)
	if(mrc LESS_EQUAL 0)
		message(FATAL_ERROR "get_ram_regions(): no RAM memory regions known; please call add_memory_region() at least for one RAM first")
	endif()
	set(${rlst} "${ret}" PARENT_SCOPE)
endfunction(get_ram_regions rlst)

#
# Currently, we believe in all RAMs having been created equal
# TODO: Use allowed sections instead
#
# create a list with valid memory regions for the data section
function(get_data_regions rlst)
	set(ret)
	get_ram_regions("data" ret)
	set(${rlst} "${ret}" PARENT_SCOPE)
endfunction(get_data_regions rlst)

# create a list with valid memory regions for the bss section
function(get_bss_regions rlst)
	set(ret)
	get_ram_regions("bss" ret)
	set(${rlst} "${ret}" PARENT_SCOPE)
endfunction(get_bss_regions rlst)

# create a list with valid memory regions for the noinit section
function(get_noinit_regions rlst)
	set(ret)
	get_ram_regions("noinit" ret)
	set(${rlst} "${ret}" PARENT_SCOPE)
endfunction(get_noinit_regions rlst)

# create a list with valid memory regions for the heap
function(get_heap_regions rlst)
	set(ret)
	get_ram_regions("heap" ret)
	set(${rlst} "${ret}" PARENT_SCOPE)
endfunction(get_heap_regions rlst)

# create a list with valid memory regions for a stack
function(get_stack_regions rlst)
	set(ret)
	get_ram_regions("stack" ret)
	set(${rlst} "${ret}" PARENT_SCOPE)
endfunction(get_stack_regions rlst)

# create a list with valid memory regions for the MSP stack
function(get_main_stack_regions rlst)
	set(ret)
	get_ram_regions("main_stack" ret)
	set(${rlst} "${ret}" PARENT_SCOPE)
endfunction(get_main_stack_regions rlst)

# create a list with valid memory regions for the PSP stack
function(get_process_stack_regions rlst)
	set(ret)
	get_ram_regions("process_stack" ret)
	set(${rlst} "${ret}" PARENT_SCOPE)
endfunction(get_process_stack_regions rlst)

# writes a linker script
# expects the user to have called add_memory_region for each available memory region
# Parameters:
# ROM <memory region>: Use this region as the ROM (currently, only one region possible)
# -
# either:
#   RAM <memory region>: Use this region as the only RAM region for data,bss,noinit,stacks
# or
#   DATA_MEM <memory region>: For the .data section
#   BSS_MEM <memory region>: For the .bss section
#   NOINIT_MEM <memory region>: For the .noinit section
#   PROCESS_STACK_MEM <memory region>: For the PSP stack
#   MAIN_STACK_MEM <memory region>: For the MSP stack
# -
# VADDRSUFFIX <suff>: Use this suffix for an additional region mapping
# RAMTEXT_SECTION <section name>: Place this section into the RAM memory region RAMTEXT_MEM,
#				load it to S_ROM and place an entry into data_array
# RAMTEXT_MEM <memory region>: For the RAMTEXT_SECTION
# ENABLE_FINI <bool>: Enable/disable .fini section
#--------------
# The general section allocation sequence per memory region is
# .<region>.data .<region>.bss .<region>.noinit .data .bss .noinit heap psp-stack msp-stack
# Depending on the parameters given to add_memoryregion and generate_ldscript
# some sections may not be present.
function(generate_ldscript
	 outfile
	 chipName
)
	list(LENGTH MEMORY_REGIONS mrc)
	if(mrc LESS_EQUAL 0)
		message(FATAL_ERROR "generate_ldscript(): no memory regions known; please call add_memory_region() at least for one ROM and one RAM first")
	endif()
	cmake_parse_arguments(S "" "ROM;RAM;DATA_MEM;BSS_MEM;NOINIT_MEM;HEAP_MEM;PROCESS_STACK_MEM;MAIN_STACK_MEM;VADDRSUFFIX;RAMTEXT_SECTION;RAMTEXT_MEM" "" ${ARGN})
	# currently, all non-modifyable code goes into single rom.
	if(NOT S_ROM)
		MESSAGE(FATAL_ERROR "generate_ldscript(): Argument ROM (memory region name) missing")
	endif()
	get_memoryinfo(${S_ROM} mt vs)
	if(NOT (mt STREQUAL "ROM"))
		message(FATAL_ERROR "generate_ldscript(): argument ROM ${S_ROM} does not denote a ROM memory region")
	endif()
	if(NOT S_VADDRSUFFIX)
		set(S_VADDRSUFFIX "Vma")
	endif()

	set(ROMNAME ${S_ROM})
	set(ROMADDR ${MEMORY_ADDRESS_${S_ROM}})
	set(ROMSIZE ${MEMORY_SIZE_${S_ROM}})
	set(ROMVADDR ${MEMORY_VMADDR_${S_ROM}})
	if(ROMVADDR)
		set(ROMVNAME "${ROMNAME}${S_VADDRSUFFIX}")
	endif()
	if(S_RAM)
		message(STATUS "generate_ldscript(): Unifying ram regions in memory ${S_RAM}")
		get_memoryinfo(${S_RAM} mt vs)
		if(NOT (mt STREQUAL "RAM"))
			message(FATAL_ERROR "generate_ldscript(): argument RAM ${S_RAM} does not denote a RAM memory region")
		endif()
		set(S_DATA_MEM ${S_RAM})
		set(S_BSS_MEM ${S_RAM})
		set(S_NOINIT_MEM ${S_RAM})
		set(S_HEAP_MEM ${S_RAM})
		set(S_PROCESS_STACK_MEM ${S_RAM})
		set(S_MAIN_STACK_MEM ${S_RAM})
	else()
		get_memoryinfo(${S_DATA_MEM} mt vs CHECK_SECTION_ALLOWED "data")
		if(NOT (mt STREQUAL "RAM"))
			message(FATAL_ERROR "generate_ldscript(): argument S_DATA_MEM ${S_DATA_MEM} does not denote a RAM memory region")
		endif()
		get_memoryinfo(${S_BSS_MEM} mt vs CHECK_SECTION_ALLOWED "bss")
		if(NOT (mt STREQUAL "RAM"))
			message(FATAL_ERROR "generate_ldscript(): argument BSS_MEM ${S_BSS_MEM} does not denote a RAM memory region")
		endif()
		get_memoryinfo(${S_NOINIT_MEM} mt vs CHECK_SECTION_ALLOWED "noinit")
		if(NOT (mt STREQUAL "RAM"))
			message(FATAL_ERROR "generate_ldscript(): argument NOINIT_MEM ${S_NOINIT_MEM} does not denote a RAM memory region")
		endif()
		get_memoryinfo(${S_HEAP_MEM} mt vs CHECK_SECTION_ALLOWED "heap")
		if(NOT (mt STREQUAL "RAM"))
			message(FATAL_ERROR "generate_ldscript(): argument HEAP_MEM ${S_HEAP_MEM} does not denote a RAM memory region")
		endif()
		get_memoryinfo(${S_PROCESS_STACK_MEM} mt vs CHECK_SECTION_ALLOWED "process_stack")
		if(NOT (mt STREQUAL "RAM"))
			message(FATAL_ERROR "generate_ldscript(): argument PROCESS_STACK_MEM ${S_PROCESS_STACK_MEM} does not denote a RAM memory region")
		endif()
		get_memoryinfo(${S_MAIN_STACK_MEM} mt vs CHECK_SECTION_ALLOWED "main_stack")
		if(NOT (mt STREQUAL "RAM"))
			message(FATAL_ERROR "generate_ldscript(): argument MAIN_STACK_MEM ${S_MAIN_STACK_MEM} does not denote a RAM memory region")
		endif()
	endif()

	message(STATUS "generate_ldscript(): Have ${mrc} regions: ${MEMORY_REGIONS}")
	string(TIMESTAMP now "%Y-%m-%d %H:%M:%S")
	unset(HEAP_LOW)
	unset(HEAP_HIGH)
	unset(MS_LOW)
	unset(PS_LOW)

	hexmath(EXPR MS_SIZE "${ARCHITECTURE_ARMV6_M_ARMV7_M_MAIN_STACK_SIZE} + ${ARCHITECTURE_ARMV6_M_ARMV7_M_MAIN_STACK_SIZE} % ${ARCHITECTURE_STACK_ALIGNMENT}")
	hexmath(EXPR PS_SIZE "${DISTORTOS_MAIN_THREAD_STACK_SIZE} + ${DISTORTOS_MAIN_THREAD_STACK_SIZE} % ${ARCHITECTURE_STACK_ALIGNMENT} + (${DISTORTOS_STACK_GUARD_SIZE} + ${DISTORTOS_STACK_GUARD_SIZE} % ${ARCHITECTURE_STACK_ALIGNMENT})")
	message(STATUS "Aligned MSP stack size: ${MS_SIZE}")
	message(STATUS "Aligned PSP stack size: ${PS_SIZE}")

	foreach(mr IN LISTS MEMORY_REGIONS)
		get_memoryinfo(${mr} memoryType vs)
		set(memoryName ${mr})
		set(memoryAddress ${MEMORY_ADDRESS_${mr}})
		set(memorySize ${MEMORY_SIZE_${mr}})
		set(memoryVAddr ${MEMORY_VMADDR_${mr}})
		if(memoryVAddr)
			set(vac " / ${S_VADDRSUFFIX} ${memoryVAddr}")
		else()
			unset(vac)
		endif()
		set(sepData ${MEMORY_SEPARATE_DATA_SECTION_${mr}})
		set(sepBss ${MEMORY_SEPARATE_BSS_SECTION_${mr}})
		set(sepNoinit ${MEMORY_SEPARATE_NOINIT_SECTION_${mr}})
		set(headerComments "${headerComments} * - ${memoryName}: ${memorySize} bytes of ${memoryType} at ${memoryAddress} ${vac}\n")
		set(memoryEntries "${memoryEntries}\t${memoryName} : org = ${memoryAddress}, len = ${memorySize}\n")
		if(memoryVAddr)
			set(memoryEntries "${memoryEntries}\t${memoryName}${S_VADDRSUFFIX} : org = ${memoryVAddr}, len = ${memorySize}\n")
		endif()
		# find out low heap boundary	
		if(S_HEAP_MEM STREQUAL mr)
			set(have_heap TRUE)
		else()
			set(have_heap FALSE)
		endif()

		# calculate stacks
		if(S_MAIN_STACK_MEM STREQUAL mr)
			set(have_ms TRUE)
			hexmath(HEX MS_LOW "(${memoryAddress} + ${memorySize}) - ${MS_SIZE}")
			message(STATUS "Main Stack low: ${MS_LOW}")
		else()
			set(have_ms FALSE)
		endif()
		if(S_PROCESS_STACK_MEM STREQUAL mr)
			if(have_ms)
				hexmath(HEX PS_LOW "${MS_LOW} - ${PS_SIZE}")
			else()
				hexmath(HEX PS_LOW "(${memoryAddress} + ${memorySize}) - ${PS_SIZE}")
			endif()
			message(STATUS "PS stack low: ${PS_LOW}")
		endif()
		string(CONCAT memorySizes "${memorySizes}"
		    "PROVIDE(__${memoryName}_start = ORIGIN(${memoryName}));\n"
		    "PROVIDE(__${memoryName}_size = LENGTH(${memoryName}));\n"
		    "PROVIDE(__${memoryName}_end = ORIGIN(${memoryName}) + LENGTH(${memoryName}));\n\n"
		)

		if(memoryType STREQUAL "RAM" AND sepData)
			string(CONCAT dataArrayEntries "${dataArrayEntries}"
			    "\t\tLONG(LOADADDR(.${memoryName}.data)); LONG(ADDR(.${memoryName}.data)); "
			    "LONG(ADDR(.${memoryName}.data) + SIZEOF(.${memoryName}.data));\n"
			)
			string(CONCAT sectionEntries "${sectionEntries}"
				"	.${memoryName}.data :\n"
				"	{\n"
				"		. = ALIGN(4);\n"
				"		PROVIDE(__${memoryName}_data_init_start = LOADADDR(.${memoryName}.data));\n"
				"		PROVIDE(__${memoryName}_data_start = .);\n\n"
				"		*(.${memoryName}.data);\n\n"
				"		. = ALIGN(4);\n"
				"		PROVIDE(__${memoryName}_data_end = .);\n"
				"	} > ${memoryName} AT > ${ROMNAME}\n\n"
			)
			string(CONCAT sectionSizes "${sectionSizes}"
				"PROVIDE(__${memoryName}_data_size = SIZEOF(.${memoryName}.data));\n"
			)
			# check for heap above separate data section
			if(have_heap)
				set(HEAP_LOW "__${memoryName}_data_end")
			endif()
		endif()
		if(memoryType STREQUAL "RAM" AND sepBss)
			string(CONCAT bssArrayEntries "${bssArrayEntries}"
			    "\t\tLONG(0); LONG(ADDR(.${memoryName}.bss)); LONG(ADDR(.${memoryName}.bss) + SIZEOF(.${memoryName}.bss));\n"
			)

			string(CONCAT sectionEntries "${sectionEntries}"
				"	.${memoryName}.bss :\n"
				"	{\n"
				"		. = ALIGN(4);\n"
				"		PROVIDE(__${memoryName}_bss_start = .);\n\n"
				"		*(.${memoryName}.bss);\n\n"
				"		. = ALIGN(4);\n"
				"		PROVIDE(__${memoryName}_bss_end = .);\n"
				"	} > ${memoryName} AT > ${memoryName}\n\n"
			)
			string(CONCAT sectionSizes "${sectionSizes}"
				"PROVIDE(__${memoryName}_bss_size = SIZEOF(.${memoryName}.bss));\n"
			)
			# check for heap above separate bss section
			if(have_heap)
				set(HEAP_LOW "__${memoryName}_bss_end")
			endif()
		endif()
		if(memoryType STREQUAL "RAM" AND sepNoinit)
			string(CONCAT sectionEntries "${sectionEntries}"
				"	.${memoryName}.noinit (NOLOAD) :\n"
				"	{\n"
				"		. = ALIGN(4);\n"
				"		PROVIDE(__${memoryName}_noinit_start = .);\n\n"
				"		*(.${memoryName}.noinit);\n\n"
				"		. = ALIGN(4);\n"
				"		PROVIDE(__${memoryName}_noinit_end = .);\n"
				"	} > ${memoryName} AT > ${memoryName}\n\n"
			)
			string(CONCAT sectionSizes "${sectionSizes}"
				"PROVIDE(__${memoryName}_noinit_size = SIZEOF(.${memoryName}.noinit));\n"
			)
			# check for heap above separate noinit section
			if(have_heap)
				set(HEAP_LOW "__${memoryName}_noinit_end")
			endif()
		endif()
		# check for heap above standard sections
		if(have_heap)
			if(mr STREQUAL S_NOINIT_MEM)
				set(HEAP_LOW "__noinit_end")
			elseif(mr STREQUAL S_BSS_MEM)
				set(HEAP_LOW "__bss_end")
			elseif(mr STREQUAL S_DATA_MEM)
				set(HEAP_LOW "__data_end")
			elseif(NOT DEFINED HEAP_LOW)
				set(HEAP_LOW "__${memoryName}_start")
			endif()
		endif()
	endforeach()

	# find out high heap boundary
	if(S_HEAP_MEM STREQUAL S_PROCESS_STACK_MEM)
		set(HEAP_HIGH "__process_stack_start")
	elseif(S_HEAP_MEM STREQUAL S_PROCESS_STACK_MEM)
		set(HEAP_HIGH "__main_stack_start")
	else()
		set(HEAP_HIGH "__${memoryName}_end")
	endif()

	# determine process stack
	string(CONCAT processStackDef
		"	.process_stack ${PS_LOW} :\n"
		"	{\n"
		"		PROVIDE(__process_stack_start = .);\n"
		"\n"
		"		. += __process_stack_size;\n"
		"\n"
		"		PROVIDE(__process_stack_end = .);\n"
		"	} > ${S_PROCESS_STACK_MEM} AT > ${S_PROCESS_STACK_MEM}\n\n"
	)
	string(CONCAT mainStackDef
		"	.main_stack ${MS_LOW} :\n"
		"	{\n"
		"		PROVIDE(__main_stack_start = .);\n"
		"\n"
		"		. += __main_stack_size;\n"
		"\n"
		"		PROVIDE(__main_stack_end = .);\n"
		"	} > ${S_MAIN_STACK_MEM} AT > ${S_MAIN_STACK_MEM}\n\n"
	)

	string(CONCAT DISTORTOS_LDSCRIPT
		"/**\n"
		" * \\file\n"
		" * \\brief Linker script for ${chipName} chip:\n"
		"${headerComments}"
		" *\n"
		" * \\author Copyright (C) 2014-2017 Kamil Szczygiel http://www.distortec.com http://www.freddiechopin.info\n"
		" * Copyright (C) 2017-2017 elbe informatik GmbH\n"
		" *\n"
		" * \\par License\n"
		" * This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not\n"
		" * distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.\n"
		" *\n"
		" * \\warning\n"
		" * Automatically generated file - do not edit!\n"
		" *\n"
		" * \\date ${now}\n"
		" */\n"
		"\n"
		"SEARCH_DIR(.);\n"
		"OUTPUT_FORMAT(\"elf32-littlearm\", \"elf32-bigarm\", \"elf32-littlearm\");\n"
		"OUTPUT_ARCH(arm);\n"
		"\n"
		"/*---------------------------------------------------------------------------------------------------------------------+\n"
		"| stacks sizes\n"
		"+---------------------------------------------------------------------------------------------------------------------*/\n"
		"PROVIDE(__main_stack_size = ${MS_SIZE});\n"
		"PROVIDE(__process_stack_size = ${PS_SIZE});\n"
		"/*---------------------------------------------------------------------------------------------------------------------+\n"
		"| available memories\n"
		"+---------------------------------------------------------------------------------------------------------------------*/\n"
		"\n"
		"MEMORY\n"
		"{\n"
		"${memoryEntries}"
		"}\n"
		"\n"
		"${memorySizes}"
		"/*---------------------------------------------------------------------------------------------------------------------+\n"
		"| entry point\n"
		"+---------------------------------------------------------------------------------------------------------------------*/\n"
		"\n"
		"ENTRY(Reset_Handler);\n"
		"\n"
		"/*---------------------------------------------------------------------------------------------------------------------+\n"
		"| put data in sections\n"
		"+---------------------------------------------------------------------------------------------------------------------*/\n"
		"\n"
		"SECTIONS\n"
		"{\n"
		"	.text :\n"
		"	{\n"
		"		. = ALIGN(4);\n"
		"		PROVIDE(__text_start = .);\n"
		"\n"
		"		/* sub-section: .vectors */\n"
		"\n"
		"		. = ALIGN(4);\n"
		"		PROVIDE(__vectors_start = .);\n"
		"\n"
		"		KEEP(*(.coreVectors));\n"
		"		KEEP(*(.chipVectors));\n"
		"\n"
		"		. = ALIGN(4);\n"
		"		PROVIDE(__vectors_end = .);\n"
		"\n"
		"		/* end of sub-section: .vectors */\n"
		"\n"
		"		*(.text* .gnu.linkonce.t.*);\n"
		"		*(.rodata* .gnu.linkonce.r.*);\n"
		"		*(.glue_7t .glue_7);\n"
		"\n"
		"		*(.ARM.extab* .gnu.linkonce.armextab.*);	/* exception unwinding information */\n"
		"		*(.gcc_except_table);				/* information used for stack unwinding during exception */\n"
		"		*(.eh_frame_hdr);				/* additional information about .ex_frame section */\n"
		"		*(.eh_frame);					/* information used for stack unwinding during exception */\n"
		"\n"
		"		/* sub-section: data_array */\n"
		"\n"
		"		. = ALIGN(4);\n"
		"		PROVIDE(__data_array_start = .);\n"
		"\n"
		"		LONG(LOADADDR(.data)); LONG(ADDR(.data)); LONG(ADDR(.data) + SIZEOF(.data));\n"
		"${dataArrayEntries}"
		"\n"
		"		. = ALIGN(4);\n"
		"		PROVIDE(__data_array_end = .);\n"
		"\n"
		"		/* end of sub-section: data_array */\n"
		"\n"
		"		/* sub-section: bss_array */\n"
		"\n"
		"		. = ALIGN(4);\n"
		"		PROVIDE(__bss_array_start = .);\n"
		"\n"
		"		LONG(0); LONG(ADDR(.bss)); LONG(ADDR(.bss) + SIZEOF(.bss));\n"
		"		LONG(0xed419f25); LONG(ADDR(.main_stack)); LONG(ADDR(.main_stack) + SIZEOF(.main_stack));\n"
		"		LONG(0xed419f25); LONG(ADDR(.process_stack)); LONG(ADDR(.process_stack) + SIZEOF(.process_stack));\n"
		"${bssArrayEntries}"
		"\n"
		"		. = ALIGN(4);\n"
		"		PROVIDE(__bss_array_end = .);\n"
		"\n"
		"		/* end of sub-section: bss_array */\n"
		"\n"
		"		/* sub-sections: init, preinit_array, init_array and fini_array */\n"
		"\n"
		"		KEEP(*(.init));\n"
		"\n"
		"		. = ALIGN(4);\n"
		"		PROVIDE(__preinit_array_start = .);\n"
		"\n"
		"		KEEP(*(.preinit_array));\n"
		"\n"
		"		. = ALIGN(4);\n"
		"		PROVIDE(__preinit_array_end = .);\n"
		"\n"
		"		. = ALIGN(4);\n"
		"		PROVIDE(__init_array_start = .);\n"
		"\n"
		"		KEEP(*(SORT_BY_INIT_PRIORITY(.init_array.*)));\n"
		"		KEEP(*(.init_array));\n"
		"\n"
		"		. = ALIGN(4);\n"
		"		PROVIDE(__init_array_end = .);\n"
		"\n"
		"		KEEP(*(.fini));\n"
		"\n"
	)
	if(S_ENABLE_FINI)
		string(CONCAT DISTORTOS_LDSCRIPT "${DISTORTOS_LDSCRIPT}"
			"		. = ALIGN(4);\n"
			"		PROVIDE(__fini_array_start = .);\n"
			"\n"
			"		KEEP(*(.fini_array));\n"
			"		KEEP(*(SORT_BY_INIT_PRIORITY(.fini_array.*)));\n"
			"\n"
			"		. = ALIGN(4);\n"
			"		PROVIDE(__fini_array_end = .);\n"
			"\n"
		)
	endif()
	string(CONCAT DISTORTOS_LDSCRIPT "${DISTORTOS_LDSCRIPT}"
		"		/* end of sub-sections: init, preinit_array, init_array and fini_array */\n"
		"\n"
		"		. = ALIGN(4);\n"
		"		PROVIDE(__text_end = .);\n"
		"	} > ${ROMVNAME} AT > ${ROMNAME}\n"
		"\n"
		"	.ARM.exidx :\n"
		"	{\n"
		"		PROVIDE(__exidx_start = .);\n"
		"\n"
		"		*(.ARM.exidx* .gnu.linkonce.armexidx.*);\n"
		"\n"
		"		PROVIDE(__exidx_end = .);\n"
		"	} > ${ROMVNAME} AT > ${ROMNAME}								/* index entries for section unwinding */\n"
		"\n"
		"	.bss :\n"
		"	{\n"
		"		. = ALIGN(4);\n"
		"		PROVIDE(__bss_start = .);\n"
		"\n"
		"		*(.bss* .gnu.linkonce.b.*);\n"
		"		*(COMMON);\n"
		"\n"
		"		. = ALIGN(4);\n"
		"		PROVIDE(__bss_end = .);\n"
		"	} > ${S_BSS_MEM} AT > ${S_BSS_MEM}\n"
		"\n"
		"	.data :\n"
		"	{\n"
		"		. = ALIGN(4);\n"
		"		PROVIDE(__data_init_start = LOADADDR(.data));\n"
		"		PROVIDE(__data_start = .);\n"
		"\n"
		"		*(.data* .gnu.linkonce.d.*);\n"
		"\n"
		"		. = ALIGN(4);\n"
		"		PROVIDE(__data_end = .);\n"
		"	} > ${S_DATA_MEM} AT > ${ROMNAME}\n"
		"\n"
		"	.noinit (NOLOAD) :\n"
		"	{\n"
		"		. = ALIGN(4);\n"
		"		PROVIDE(__noinit_start = .);\n"
		"\n"
		"		*(.noinit);\n"
		"\n"
		"		. = ALIGN(4);\n"
		"		PROVIDE(__noinit_end = .);\n"
		"	} > ${S_NOINIT_MEM} AT > ${S_NOINIT_MEM}\n"
		"\n"
		"${processStackDef}"
		"${mainStackDef}"
		"${sectionEntries}"
		"	PROVIDE(__heap_start = ALIGN(${HEAP_LOW}, 8));\n"
		"	PROVIDE(__heap_end = ${HEAP_HIGH} / 8 * 8);\n"
		"	.stab				0 (NOLOAD) : { *(.stab); }\n"
		"	.stabstr			0 (NOLOAD) : { *(.stabstr); }\n"
		"	/* DWARF debug sections.\n"
		"	* Symbols in the DWARF debugging sections are relative to the beginning\n"
		"	* of the section so we begin them at 0. */\n"
		"	/* DWARF 1 */\n"
		"	.debug				0 : { *(.debug); }\n"
		"	.line				0 : { *(.line); }\n"
		"	/* GNU DWARF 1 extensions */\n"
		"	.debug_srcinfo		0 : { *(.debug_srcinfo); }\n"
		"	.debug_sfnames		0 : { *(.debug_sfnames); }\n"
		"	/* DWARF 1.1 and DWARF 2 */\n"
		"	.debug_aranges		0 : { *(.debug_aranges); }\n"
		"	.debug_pubnames		0 : { *(.debug_pubnames); }\n"
		"	/* DWARF 2 */\n"
		"	.debug_info			0 : { *(.debug_info .gnu.linkonce.wi.*); }\n"
		"	.debug_abbrev		0 : { *(.debug_abbrev); }\n"
		"	.debug_line			0 : { *(.debug_line); }\n"
		"	.debug_frame		0 : { *(.debug_frame); }\n"
		"	.debug_str			0 : { *(.debug_str); }\n"
		"	.debug_loc			0 : { *(.debug_loc); }\n"
		"	.debug_macinfo		0 : { *(.debug_macinfo); }\n"
		"	/* SGI/MIPS DWARF 2 extensions */\n"
		"	.debug_weaknames	0 : { *(.debug_weaknames); }\n"
		"	.debug_funcnames	0 : { *(.debug_funcnames); }\n"
		"	.debug_typenames	0 : { *(.debug_typenames); }\n"
		"	.debug_varnames		0 : { *(.debug_varnames); }\n"
		"\n"
		"	.note.gnu.arm.ident	0 : { KEEP(*(.note.gnu.arm.ident)); }\n"
		"	.ARM.attributes		0 : { KEEP(*(.ARM.attributes)); }\n"
		"	/DISCARD/				: { *(.note.GNU-stack); }\n"
		"}\n"
		"\n"
		"PROVIDE(__text_size = SIZEOF(.text));\n"
		"PROVIDE(__exidx_size = SIZEOF(.ARM.exidx));\n"
		"PROVIDE(__bss_size = SIZEOF(.bss));\n"
		"PROVIDE(__data_size = SIZEOF(.data));\n"
		"PROVIDE(__noinit_size = SIZEOF(.noinit));\n"
		"${sectionSizes}"
		"\n"
		"PROVIDE(__bss_start__ = __bss_start);\n"
		"PROVIDE(__bss_end__ = __bss_end);\n"
	)

	file(WRITE "${outfile}" "${DISTORTOS_LDSCRIPT}")
endfunction(generate_ldscript)
