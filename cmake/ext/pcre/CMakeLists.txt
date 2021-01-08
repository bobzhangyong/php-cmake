## CMake date File
##
## PHP License
##
## Author: Alejandro Leiva <gloob@php.net>
##
## $Id$


## This extension is not well parsed by ext_to_cmake.php!!

# Extension: pcre
project(pcre C)

option(pcre "Enable pcre support" ON)
option(pcre-shared "Shared pcre" OFF)


## Check if user provided --with-pcre-regex
include_directories("${CMAKE_CURRENT_SOURCE_DIR}/pcrelib")

file(GLOB PCRELIB_SOURCES "pcrelib/*.c")
list(REMOVE_ITEM PCRELIB_SOURCES "${CMAKE_CURRENT_SOURCE_DIR}/pcrelib/dftables.c")

set(EXT_PCRE_SOURCES php_pcre.c)

#add_library(EXT_XML [STATIC | SHARED | MODULE] [EXCLUDE_FROM_ALL]
add_library(EXT_PCRE STATIC ${PCRELIB_SOURCES} ${EXT_PCRE_SOURCES})
set_target_properties(EXT_PCRE
        PROPERTIES COMPILE_FLAGS "-DHAVE_CONFIG_H -DZEND_ENABLE_STATIC_TSRMLS_CACHE=1"
        )
##target_link_libraries(EXT_PCRE ${@@EXTENSION_LIBRARIES@@})
