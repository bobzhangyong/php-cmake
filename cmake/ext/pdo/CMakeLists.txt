## CMake date File
##
## PHP License
##
## Author: Alejandro Leiva <gloob@php.net>
##
## $Id$

# Extension: pdo

option(pdo "Enable pdo support" ON)
option(pdo-shared "Shared pdo" OFF)

set(RE2C_MINIMAL_VERSION 1304)
find_package(RE2C)

find_file(PDO_SQL_PARSER "pdo_sql_parser.c" PATHS ${PHP_SOURCE_DIR}/ext/pdo/)
if(NOT PDO_SQL_PARSER)
    message("Regenerating pdo_sql_parser")
    RE2C_TARGET(pdo_sql_parser pdo_sql_parser.re pdo_sql_parser.c ${PHP_SOURCE_DIR}/ext/pdo/ "" "" "")
endif(NOT PDO_SQL_PARSER)


file(GLOB EXT_PDO_SOURCES *.c)

#add_library(EXT_XML [STATIC | SHARED | MODULE] [EXCLUDE_FROM_ALL]
add_library(EXT_PDO ${EXT_PDO_SOURCES} ${RE2C_pdo_sql_parser_OUTPUT})
##target_link_libraries(EXT_PDO ${@@EXTENSION_LIBRARIES@@})
