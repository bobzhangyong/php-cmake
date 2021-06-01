## CMake date File
##
## PHP License
##
## Author: bob_zy@yeah.net
##
## $Id$

# Extension: posix

option(xml "Enable hash support" ON)
option(xml-shared "Shared hash" OFF)


set(EXT_XML_SOURCES compat.c xml.c expat_compat.h)

add_library(EXT_XML OBJECT ${EXT_XML_SOURCES})
