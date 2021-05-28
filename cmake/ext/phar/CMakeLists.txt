## CMake date File
##
## PHP License
##
## Author: Alejandro Leiva <gloob@php.net>
##
## $Id$

# Extension: phar

option(phar "Enable phar archive support" ON)
option(phar-shared "phar shared" OFF)

set(RE2C_MINIMAL_VERSION 1304)
find_package(RE2C)

find_file(EXT_PHAR_CHECK "phar_path_check.c" PATHS ${PHP_SOURCE_DIR}/ext/phar/)
if(NOT EXT_PHAR_CHECK)
    message("Regenerating phar_path_check")
    RE2C_TARGET(phar_path_check phar_path_check.re phar_path_check.c ${PHP_SOURCE_DIR}/ext/phar/ -b "" "")
endif(NOT EXT_PHAR_CHECK)

file(GLOB EXT_PHAR_SOURCES *.c)

add_library(EXT_PHAR ${EXT_PHAR_SOURCES} ${RE2C_phar_path_check_OUTPUT})
