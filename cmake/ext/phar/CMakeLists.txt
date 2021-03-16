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


set(EXT_PHAR_SOURCES
  util.c tar.c zip.c stream.c func_interceptors.c dirstream.c phar.c phar_object.c phar_path_check.c
)

add_library(EXT_PHAR ${EXT_PHAR_SOURCES})
