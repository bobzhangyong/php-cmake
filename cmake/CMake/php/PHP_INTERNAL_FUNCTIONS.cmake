#  PHP internal_functions
#
#  Copyright (c) 2008 Alejandro Leiva <gloob@php.net>
#
# $Id$

# @EXT_INCLUDE_CODE@
# @EXT_MODULE_PTRS@

## TODO:
## * Port build/genif.sh + build/order_by_dep.awk + build/print_include.awk
##   to CMake script.
## * Look for windows build system behavior with internal_function and 
##   implement it.

macro(PHP_INTERNAL_FUNCTIONS exts_list exts_cli_list target)

	string(REPLACE ${PHP_SOURCE_DIR} "" relative_target ${target})
	message("[php-CMake]: Creating ${relative_target} ${target}")
	
	# 1. mv target target.old
	#file(READ ${target} target_contents)
	#file(WRITE "${target}.old" ${target_contents})

	# 2. call to genif.sh
	execute_process(COMMAND "sh" "${PHP_SOURCE_DIR}/build/genif.sh"
					"${PHP_SOURCE_DIR}/main/internal_functions.c.in"
					"${PHP_SOURCE_DIR}"
					""
					"gawk"
					${exts_list}
#					WORKING_DIRECTORY ${PHP_SOURCE_DIR}
					OUTPUT_FILE ${target}
#					RESULT_VARIABLE ret
					)
	# check if all went fine.
#	file(WRITE "${target}" ${process_out})
#	message("execute: ${ret}")

endmacro(PHP_INTERNAL_FUNCTIONS)