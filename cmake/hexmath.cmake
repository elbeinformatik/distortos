############################################################
#
#	hex number math
#
#	(c) 2017-2017 elbe informatik GmbH
#
#	$Id: hexmath.cmake 2643 2017-09-08 20:41:32Z titus $
#

function(is_decimal number output_variable)
	set(ret FALSE)
	string(REGEX MATCH "^ *[0-9]+ *$" nt "${number}")
	if(nt STREQUAL number)
		set(ret TRUE)
	endif()
	set(${output_variable} ${ret} PARENT_SCOPE)
endfunction()

function(is_hexadecimal number output_variable)
	set(ret FALSE)
	string(REGEX MATCH "^ *0x[0-9A-Fa-f]+ *$" nt "${number}")
	if(nt STREQUAL number)
		set(ret TRUE)
	endif()

	set(${output_variable} ${ret} PARENT_SCOPE)
endfunction()

function(is_integer number output_variable)
	set(ret FALSE)
	is_decimal("${number}" ret)
	if(NOT ret)
		is_hexadecimal("${number}" ret)
	endif()
	set(${output_variable} ${ret} PARENT_SCOPE)
endfunction()

function(decimal_to_hex number output_variable)
	is_integer("${number}" isnum)
	if(NOT isnum)
		message(FATAL_ERROR "not a number: ${number}")
	endif()
	set (hexdig "0123456789abcdef")
	set (ret "")
	
	while(number GREATER 0)
		math (EXPR nibble "${number} & 15")
		string (SUBSTRING "${hexdig}" "${nibble}" 1 nibble_hex)
		string (CONCAT ret "${nibble_hex}" "${ret}")

		math (EXPR number "${number} >> 4")
	endwhile()

	set ("${output_variable}" "0x${ret}" PARENT_SCOPE)
endfunction ()

function(hex_to_decimal hex output_variable)
	is_hexadecimal("${hex}" isnum)
	if(NOT isnum)
		message(FATAL_ERROR "not a hex number: ${hex}")
	endif()
	string(STRIP "${hex}" hex)
	string(SUBSTRING "${hex}" 2 -1 hex)
	string(TOUPPER "${hex}" hex)
	set(_res 0)
	string(LENGTH "${hex}" _strlen)

	while(_strlen GREATER 0)
		math(EXPR _res "${_res} * 16")
		string(SUBSTRING "${hex}" 0 1 nibble)
		string(SUBSTRING "${hex}" 1 -1 hex)
		if(nibble STREQUAL "A")
			math(EXPR _res "${_res} + 10")
		elseif(nibble STREQUAL "B")
			math(EXPR _res "${_res} + 11")
		elseif(nibble STREQUAL "C")
			math(EXPR _res "${_res} + 12")
		elseif(nibble STREQUAL "D")
			math(EXPR _res "${_res} + 13")
		elseif(nibble STREQUAL "E")
			math(EXPR _res "${_res} + 14")
		elseif(nibble STREQUAL "F")
			math(EXPR _res "${_res} + 15")
		else()
			math(EXPR _res "${_res} + ${nibble}")
		endif()

		string(LENGTH "${hex}" _strlen)
	endwhile()

	set(${output_variable} ${_res} PARENT_SCOPE)
endfunction()

function(hexmath EXPR output_variable expr)
#	message(STATUS "hexmath expr = ${expr}")
	string(REGEX MATCHALL "0x[0-9A-Fa-f]+" hexlist "${expr}")
	list(LENGTH hexlist hexc)
	if(hexc GREATER 0)
		foreach(hexexpr IN LISTS hexlist)
			hex_to_decimal("${hexexpr}" tmpdec)
			string(REPLACE "${hexexpr}" "${tmpdec}" expr "${expr}")
		endforeach()
	endif()
#	message(STATUS "hexmath dec expr = ${expr}")
	math(EXPR out "${expr}")
	if(EXPR STREQUAL "HEX")
		decimal_to_hex("${out}" out)
	endif()
	set(${output_variable} "${out}" PARENT_SCOPE)	
endfunction(hexmath)
