## CMake date File
##
## PHP License
##
## Author: bob_zy@yeah.net
##
## $Id$

# Extension: posix

option(posix "Enable hash support" ON)
option(posix-shared "Shared hash" OFF)


set(EXT_POSIX_SOURCES posix.c)

add_library(EXT_POSIX OBJECT ${EXT_POSIX_SOURCES})
