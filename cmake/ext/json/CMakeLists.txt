## CMake date File
##
## PHP License
##
## Author: Alejandro Leiva <gloob@php.net>
##
## $Id$

# Extension: json

option(json "Enable json support" ON)
option(json-shared "Shared json" OFF)

set(RE2C_MINIMAL_VERSION 1304)
find_package(RE2C)

find_file(EXT_PHAR_CHECK "json_scanner.c" PATHS ${PHP_SOURCE_DIR}/ext/json/)
if(NOT JSON_SCANNER)
    message("Regenerating json_scanner")
    RE2C_TARGET(json_scanner json_scanner.re json_scanner.c ${PHP_SOURCE_DIR}/ext/json/ -bci -t php_json_scanner_defs.h)
endif(NOT JSON_SCANNER)

find_package(BISON)
if(BISON_FOUND)
    message("[php-CMake]: Regenerating zend_language_parser.c")
    set(BISON_json_parser_SET_PARAM_P TRUE)
    BISON_TARGET(json_parser ${PHP_SOURCE_DIR}/ext/json/json_parser.y ${PHP_SOURCE_DIR}/ext/json/json_parser.tab.c COMPILE_FLAGS "--defines -l" )
endif(BISON_FOUND)

file(GLOB EXT_JSON_SOURCES *.c)
file(GLOB EXT_JSON_HEADER *.h)

#add_library(EXT_XML [STATIC | SHARED | MODULE] [EXCLUDE_FROM_ALL]
add_library(EXT_JSON OBJECT ${EXT_JSON_SOURCES} ${EXT_JSON_HEADER} ${PHP_SOURCE_DIR}/ext/json/${RE2C_json_scanner_OUTPUT} ${BISON_json_parser_OUTPUTS})
##target_link_libraries(EXT_JSON ${@@EXTENSION_LIBRARIES@@})
