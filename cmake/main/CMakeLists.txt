# PHP main zone.
#
# PHP License
#
# Author: Alejandro Leiva <gloob@php.net>
#
# $Id$

project(main C)

# Includes
include(php/PHP_INTERNAL_FUNCTIONS)

#message("$$ including: ${CMAKE_CURRENT_SOURCE_DIR}")
include_directories(${CMAKE_CURRENT_SOURCE_DIR})
include_directories(${CMAKE_CURRENT_BINARY_DIR})

#include_directories(${CMAKE_SOURCE_DIR})

## Automatic way ? <- REFACTOR THIS
include_directories(${PHP_SOURCE_DIR}/Zend)
include_directories(${PHP_BINARY_DIR}/Zend)
include_directories(${PHP_SOURCE_DIR}/TSRM)
include_directories(${PHP_BINARY_DIR}/ext/date/lib)



set(PHP_main_LIBRARIES)

PHP_INTERNAL_FUNCTIONS("${EXTENSION_FOR_GENIF}" "${EXTENSION_FOR_GENIF}" ${CMAKE_CURRENT_SOURCE_DIR}/internal_functions.c)
PHP_INTERNAL_FUNCTIONS("${EXTENSION_FOR_GENIF}" "${EXTENSION_FOR_GENIF}" ${CMAKE_CURRENT_SOURCE_DIR}/internal_functions_cli.c)

#configure_file(internal_functions.c.in ${CMAKE_CURRENT_SOURCE_DIR}/internal_functions.c)

# ########## main library ##########
# Sources:

file(GLOB main_library_SRCS *.c streams/*.c)
list(REMOVE_ITEM main_library_SRCS ${CMAKE_CURRENT_SOURCE_DIR}/internal_functions_nw.c)
list(REMOVE_ITEM main_library_SRCS ${CMAKE_CURRENT_SOURCE_DIR}/internal_functions_win32.c)
list(REMOVE_ITEM main_library_SRCS ${CMAKE_CURRENT_SOURCE_DIR}/internal_functions_cli.c)
list(REMOVE_ITEM main_library_SRCS ${CMAKE_CURRENT_SOURCE_DIR}/internal_functions.c)

# Headers:
file(GLOB main_library_HDRS *.h streams/*.h)

# actual target:
add_library(main OBJECT ${main_library_SRCS} ${main_library_HDRS})
set_target_properties(main
        PROPERTIES COMPILE_FLAGS "-DZEND_ENABLE_STATIC_TSRMLS_CACHE=1"
        )

file(GLOB main_cli_SRCS internal_functions_cli.c)
add_library(main_cli OBJECT ${main_cli_SRCS})
set_target_properties(main_cli
        PROPERTIES COMPILE_FLAGS "-DZEND_ENABLE_STATIC_TSRMLS_CACHE=1"
        )

## add install target:
#install(TARGETS main DESTINATION lib)
