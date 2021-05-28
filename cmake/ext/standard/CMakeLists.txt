## CMake date File
##
## PHP License
##
## Author: Alejandro Leiva <gloob@php.net>
##
## $Id$

## dependency with ext/date

option(standard "Enable standard support" ON)
option(standard-shared "Shared standard" OFF)

include_directories(${CMAKE_CURRENT_BINARY_DIR}/../date/lib)

file(GLOB EXT_STANDARD_SOURCES *.c)
file(GLOB EXT_STANDARD_HEADERS *.h)

if(WIN32)
  option(config-file-scan-dir "Dir to check for additional php ini files")
  set(HAVE_INET_PTON 1)
  set(HAVE_INET_NTOP 1)
else(WIN32)
  list(REMOVE_ITEM EXT_STANDARD_SOURCES ${CMAKE_CURRENT_SOURCE_DIR}/dns_win32.c)
endif(WIN32)

set(RE2C_MINIMAL_VERSION 1304)
find_package(RE2C)

if(RE2C_FOUND)
  if(RE2C_VERNUM LESS ${RE2C_MINIMAL_VERSION})
    message(STATUS "You will need re2c 0.13.4 or later if you want to regenerate PHP parsers.")
  endif(RE2C_VERNUM LESS ${RE2C_MINIMAL_VERSION})
endif(RE2C_FOUND)

find_file(EXT_VAR_UNSERIALZER "var_unserializer.c" PATHS ${PHP_SOURCE_DIR}/ext/standard/)
if(NOT EXT_VAR_UNSERIALZER)
  message("Regenerating var_unserializer")
  RE2C_TARGET(var_unserializer var_unserializer.re var_unserializer.c ${PHP_SOURCE_DIR}/ext/standard/ -b "" "")
endif(NOT EXT_VAR_UNSERIALZER)

find_file(EXT_URL_SCANNER "url_scanner_ex.c" PATHS ${PHP_SOURCE_DIR}/ext/standard/)
if(NOT EXT_URL_SCANNER)
  message("Regenerating url_scanner_ex")
  RE2C_TARGET(url_scanner_ex url_scanner_ex.re url_scanner_ex.c ${PHP_SOURCE_DIR}/ext/standard/ -b "" "")
endif(NOT EXT_URL_SCANNER)


add_library(EXT_STANDARD ${EXT_STANDARD_SOURCES} ${EXT_STANDARD_HEADERS} ${RE2C_var_unserializer_OUTPUT} ${RE2C_url_scanner_ex_OUTPUT} )
#add_library(EXT_STANDARD ${EXT_STANDARD_SOURCES} ${EXT_STANDARD_HEADERS})
target_link_libraries(EXT_STANDARD "resolv")
target_link_libraries(EXT_STANDARD "dl")
target_link_libraries(EXT_STANDARD "m")
