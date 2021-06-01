## CMake date File
##
## PHP License
##
## Author: Alejandro Leiva <gloob@php.net>
##
## $Id$

# Extension: simplexml

option(simplexml "Enable simplexml support" ON)
option(simplexml-shared "Shared simplexml" OFF)

set(HAVE_SIMPLEXML 1)

set(EXT_SIMPLEXML_SOURCES
  simplexml.c
  sxe.c
)

#add_library(EXT_XML [STATIC | SHARED | MODULE] [EXCLUDE_FROM_ALL]
add_library(EXT_SIMPLEXML OBJECT ${EXT_SIMPLEXML_SOURCES})

