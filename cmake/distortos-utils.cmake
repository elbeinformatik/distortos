############################################################
#
#	distortos CMake configuration
#
#	(c) 2017-2017 elbe informatik GmbH
#
#	$Id$
#

########
#	find board configurations:
#	assemble list of known boards in
#	DISTORTOS_BOARD_NAMES and DISTORTOS_BOARD_DIRECTORIES
function(distortos_getboards)
	set(dbb "${CMAKE_SOURCE_DIR}/source/board")
	set(DISTORTOS_BOARDS_PATH "${dbb}" PARENT_SCOPE)
	file(GLOB_RECURSE bwc RELATIVE "${dbb}" "*.cmake")
	if(NOT bwc)
		message(FATAL_ERROR "Cannot find .cmake files for board configurations under ${dbb}")
	endif()
	# GLOB searches CMAKE_SOURCE_DIR. Filter out paths that point above source/board.
	list(FILTER bwc EXCLUDE REGEX "\\.\\..+")

	foreach(dbp IN LISTS bwc)
		get_filename_component(dbn "${dbp}" NAME_WE)
		get_filename_component(dbd "${dbp}" DIRECTORY)
		get_filename_component(dbpdn "${dbd}" NAME)
		message(STATUS "Found cmake file ${dbp} in path ${dbd}, basename is ${dbn}, parent dir is ${dbpdn}")

		# main board cmake config files must have the same base name as their parent directory
		if(dbn STREQUAL dbpdn)
			list(APPEND bns "${dbn}")
			list(APPEND bdirs "${dbd}")
		endif()
	endforeach()
	list(LENGTH bwc bwcl)
	list(LENGTH bns bnsl)
	if(NOT DEFINED bns OR NOT(bwcl EQUAL bnsl))
		message(FATAL_ERROR "Could not deduce board names")
	endif()
	set(DISTORTOS_BOARD_DIRECTORIES "${bdirs}" PARENT_SCOPE)
	set(DISTORTOS_BOARD_NAMES "${bns}" PARENT_SCOPE)
endfunction(distortos_getboards)

########
#	Find chip configurations:
#	assemble list of known chips in
#	DISTORTOS_CHIP_NAMES
function(distortos_getchips)
	list(APPEND dcn
		"STM32F769NI"
	)
	set(DISTORTOS_CHIP_NAMES "${dcn}" PARENT_SCOPE)
endfunction(distortos_getchips)


# Set a distortos configuration variable. Arguments:
# <variable name>
# <value>
# <BOOL|STRING|PATH|FILEPATH|INT|HEXINT>
# <ccmake help text>
# [INTERNAL]
# [ADVANCED]
# [VALUES <list of valid values>]
# [RANGE <valid range>]
# [DEPENDS <VARNAME=value>]
# [DEPENDSRANGE <VARNAME=range>]
function(set_dconf VN VV VT)
#	message(STATUS "ARGN ist ${ARGN}")
	list(FIND DISTORTOS_CONFIGS "${VN}" vni)
	if(vni GREATER_EQUAL 0)
		message(STATUS "${VN} already set")
		return()
	endif()
	cmake_parse_arguments(S "INTERNAL" "RANGE" "VALUES;DEPENDS;DEPENDSRANGE" ${ARGN})
#	string(REPLACE ";" "," S_UNPARSED_ARGUMENTS "${S_UNPARSED_ARGUMENTS}")
	list(LENGTH S_UNPARSED_ARGUMENTS dlen)
	if(NOT S_INTERNAL)
		if(NOT (dlen EQUAL 1))
			message(FATAL_ERROR "Configuration variable ${VN}: Missing help text")
		endif()
		list(GET S_UNPARSED_ARGUMENTS 0 VDOC)
	else()
		set(VDOC "")
	endif()
	set(dconftypes "BOOL;STRING;PATH;FILEPATH;INT;HEXINT")
	set(ccachetypes "BOOL;STRING;PATH;FILEPATH")
	list(FIND dconftypes "${VT}" dvi)
	if(dvi LESS 0)
		message(FATAL_ERROR "Configuration variable ${VN}: Type ${VT} unknown")
	endif()
	if(NOT S_INTERNAL)
		list(FIND ccachetypes "${VT}" svi)
		if(svi LESS 0)
			set(cct "STRING")
		else()
			set(cct "${VT}")
		endif()
	else()
		set(cct "INTERNAL")
	endif()
	set(${VN} "${VV}" CACHE ${cct} "${VDOC}")
	if(S_VALUES)
		set_property(CACHE ${VN} PROPERTY STRINGS ${S_VALUES})
	endif()
	if(S_ADVANCED)
		mark_as_advanced(${VN})
	endif()

	# for documentation of each list element, see distortos_genconfig
	set(dce "${VT}")
	string(REPLACE ";" "," values "${S_VALUES}")
	set(dce "${dce}|${values}")
	string(REPLACE ";" "," range "${S_RANGE}")
	set(dce "${dce}|${range}")
	string(REPLACE ";" "," depends "${S_DEPENDS}")
	set(dce "${dce}|${depends}")
	string(REPLACE ";" "," dependsrange "${S_DEPENDSRANGE}")
	set(dce "${dce}|${dependsrange}")

#	message(STATUS "${VN}: ${dce}")
	set(dc ${DISTORTOS_CONFIGS})
	list(APPEND dc "${VN}")
	set(DISTORTOS_CONFIGS ${dc} PARENT_SCOPE)
	set(dcx "${DISTORTOS_CONFIG_VALUES}")
	list(APPEND dcx "${dce}")
	set(DISTORTOS_CONFIG_VALUES "${dcx}" PARENT_SCOPE)
endfunction()


#
# Generate config file
# Expects a list of configuration items set by set_dconf in list DISTORTOS_CONFIGS.
# Each list element has the subelements (separated by |)
# VARNAME (without CONFIG_ prefix): Name of variable with config value
# VARTYPE : can be BOOL, STRING, PATH, FILEPATH, INT, HEXINT
# VALUES: comma-separated list with valid values
# RANGE:
# DEPENDS:
# DEPENDSRANGE:

function(distortos_genconfig)
#	message(STATUS "DISTORTOS_CONFIG_REPLACE_PREFIXES = ${DISTORTOS_CONFIG_REPLACE_PREFIXES}")
	list(LENGTH DISTORTOS_CONFIGS dcl)
	list(LENGTH DISTORTOS_CONFIG_VALUES dvl)
	if(NOT(dcl EQUAL dvl))
		message(FATAL_ERROR "Internal config error")
	endif()
	set(dcfg "")
	set(cli 0)
	foreach(cfgvar IN LISTS DISTORTOS_CONFIGS)
		unset(cfg)
		list(GET DISTORTOS_CONFIG_VALUES ${cli} cfg)
		math(EXPR cli "${cli} + 1")
		string(REPLACE "|" ";" cfglst "${cfg}")
		list(GET cfglst 0 cfgtype)
		list(GET cfglst 1 cfgvals)
		list(GET cfglst 2 cfgrange)
		list(GET cfglst 3 cfgdepends)
		list(GET cfglst 4 cfgdeprange)
		set(cfgval "${${cfgvar}}")
		message(STATUS "var=${cfgvar}, val=${cfgval}, type=${cfgtype}, vals=${cfgvals}, range=${cfgrange}, depends=${cfgdepends}, deprange=${cfgdeprange}")
		# delete unwanted variable prefixes
		foreach(rpref IN LISTS DISTORTOS_CONFIG_REPLACE_PREFIXES)
			string(REGEX REPLACE "^${rpref}" "" cfgvarnp "${cfgvar}")
			if(NOT cfgvarnp STREQUAL cfgvar)
				break()
			endif()
		endforeach()

		# TODO: Validation of configuration values

		# value formatting for the C preprocessor
		if("${cfgtype}" STREQUAL "BOOL")
			if(cfgval)
				set(cfgval "1")
			endif()
		endif()
		if("${cfgtype}" STREQUAL "STRING")
			set(cfgval "\"${cfgval}\"")
		endif()
		# do not output boolean values defined to false/0 ?
		if(NOT("${cfgtype}" STREQUAL "BOOL") OR cfgval)
			string(CONCAT dcfg "${dcfg}"
				"#define CONFIG_${cfgvarnp}		${cfgval}\n"
			)
		endif()
	endforeach()
	if(NOT EXISTS "${DISTORTOS_CFG_DIR}")
		file(MAKE_DIRECTORY "${DISTORTOS_CFG_DIR}")
	endif()
	file(WRITE "${DISTORTOS_CFG_DIR}/${DISTORTOS_CFG_FILE}" "${dcfg}")
endfunction(distortos_genconfig)
