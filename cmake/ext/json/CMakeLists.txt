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


set(EXT_JSON_SOURCES
  json.c json_encoder.c json_parser.tab.c json_scanner.c
)


#add_library(EXT_XML [STATIC | SHARED | MODULE] [EXCLUDE_FROM_ALL]
add_library(EXT_JSON ${EXT_JSON_SOURCES})
##target_link_libraries(EXT_JSON ${@@EXTENSION_LIBRARIES@@})
