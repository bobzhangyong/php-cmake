## CMake Zend File
##
## PHP License
##
## Author: Alejandro Leiva <gloob@php.net>
##
## $Id$

cmake_minimum_required(VERSION 2.4.5)
project(Zend C)

# Includes
include_directories(${CMAKE_CURRENT_SOURCE_DIR})
include_directories(${CMAKE_CURRENT_BINARY_DIR})

# ######### General setup ##########
message("A: ${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_BINARY_DIR}")
message("CMAKE_SOURCE_DIR: ${CMAKE_SOURCE_DIR}")
#include_directories(${CMAKE_SOURCE_DIR})

## Constants
set(BISON_MINIMAL_VERSION "2.3")
set(RE2C_MINIMAL_VERSION 1304)


## Automatic way ? dependency ?
include_directories(${PHP_SOURCE_DIR}/TSRM)
message("PHP_SOURCE_DIR: ${PHP_SOURCE_DIR}")

find_package(BISON)

if(BISON_FOUND)
  if(BISON_VERSION LESS ${BISON_MINIMAL_VERSION})
    message(STATUS "Bison version should be greater than 2.3")
  endif(BISON_VERSION LESS ${BISON_MINIMAL_VERSION})
endif(BISON_FOUND)

find_package(RE2C)

if(RE2C_FOUND)
  if(RE2C_VERNUM LESS ${RE2C_MINIMAL_VERSION})
    message(STATUS "You will need re2c 0.13.4 or later if you want to regenerate PHP parsers.")
  endif(RE2C_VERNUM LESS ${RE2C_MINIMAL_VERSION})
endif(RE2C_FOUND)

# Language parser/scanner rules
find_file(ZEND_LANGUAGE_SCANNER NAMES "zend_language_scanner.c" "zend_language_scanner.h" PATHS ${Zend_SOURCE_DIR})

if(NOT ZEND_LANGUAGE_SCANNER AND NOT RE2C_FOUND)
  message(FATAL_ERROR "You need r2c to regenerate zend_language_scanner.c")
endif(NOT ZEND_LANGUAGE_SCANNER AND NOT RE2C_FOUND)

if(NOT ZEND_LANGUAGE_SCANNER)
  message("Regenerating zend_language_scanner")
  RE2C_TARGET(${Zend_SOURCE_DIR}/zend_language_scanner.l ${Zend_SOURCE_DIR}/zend_language_scanner.c "--case-inverted -cbdFt ${Zend_SOURCE_DIR}/zend_language_scanner_defs.h")
endif(NOT ZEND_LANGUAGE_SCANNER)


## Regenerate always ? some options force ?
if(NOT EXISTS "zend_language_parser.c" OR NOT EXISTS "zend_language_parser.h" AND NOT BISON_FOUND)
  message(FATAL_ERROR "You need bison parser to regenerate zend_language_parser.c")
endif(NOT EXISTS "zend_language_parser.c" OR NOT EXISTS "zend_language_parser.h" AND NOT BISON_FOUND)

if(BISON_FOUND)
	message("[php-CMake]: Regenerating zend_language_parser.c")
	# yacc -p zend -v -d ./zend_language_parser.y -o zend_language_parser.c
	# bison -p zend -v -d zend_language_parser.y -o zend_language_parser.c
	BISON_TARGET(zend ${Zend_SOURCE_DIR}/zend_language_parser.y ${Zend_SOURCE_DIR}/zend_language_parser.c COMPILE_FLAGS "-v")
endif(BISON_FOUND)

# INI parser/scanner rules
if (BISON_FOUND)
	message("[php-CMake]: Regenerating zend_ini_parser.c")
	BISON_TARGET(ini_ ${Zend_SOURCE_DIR}/zend_ini_parser.y ${Zend_SOURCE_DIR}/zend_ini_parser.c COMPILE_FLAGS "-v")
endif (BISON_FOUND)

find_file(ZEND_INI_SCANNER "zend_ini_scanner.c" PATHS ${Zend_SOURCE_DIR})
if(NOT ZEND_INI_SCANNER)
  message("Regenerating zend_ini_scanner")
  RE2C_TARGET(${Zend_SOURCE_DIR}/zend_ini_scanner.l ${Zend_SOURCE_DIR}/zend_ini_scanner.c "--case-inverted -cbdFt ${Zend_SOURCE_DIR}/zend_ini_scanner_defs.h")
endif(NOT ZEND_INI_SCANNER)

#set(PHP_ZEND_OBJECTS ${Zend_BINARY_DIR}/CMakeFiles/Zend.dir/zend_ini_parser.o ${Zend_BINARY_DIR}/CMakeFiles/Zend.dir/zend_default_classes.o PARENT_SCOPE)
#set(PHP_ZEND_SOURCES ${Zend_SOURCE_DIR}/zend_ini_parser.c ${Zend_SOURCE_DIR}/zend_default_classes.c PARENT_SCOPE)
set(PHP_ZEND_SOURCES ${Zend_SOURCE_DIR}/zend_ini_parser.c ${Zend_SOURCE_DIR}/zend_default_classes.c PARENT_SCOPE)


# Linux sources...

# ########## Zend library ##########
# Sources:

file(GLOB Zend_library_SRCS "${Zend_SOURCE_DIR}/*.c")

# Headers:
file(GLOB Zend_library_HDRS "${Zend_SOURCE_DIR}/*.h")

# actual target:
add_library(Zend ${Zend_library_SRCS} ${Zend_library_HDRS} ${BISON_zend_OUTPUTS} ${BISON_ini__OUTPUTS})
set_target_properties(Zend PROPERTIES VERSION 0.0.0)

# add install target:
#install(TARGETS Zend DESTINATION lib)
