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
include_directories("${CMAKE_CURRENT_SOURCE_DIR}/pcre2lib")

file(GLOB PCRELIB_SOURCES pcre2lib/pcre2_auto_possess.c pcre2lib/pcre2_chartables.c pcre2lib/pcre2_compile.c pcre2lib/pcre2_config.c pcre2lib/pcre2_context.c pcre2lib/pcre2_dfa_match.c pcre2lib/pcre2_error.c pcre2lib/pcre2_jit_compile.c pcre2lib/pcre2_maketables.c pcre2lib/pcre2_match.c pcre2lib/pcre2_match_data.c pcre2lib/pcre2_newline.c pcre2lib/pcre2_ord2utf.c pcre2lib/pcre2_pattern_info.c pcre2lib/pcre2_serialize.c pcre2lib/pcre2_string_utils.c pcre2lib/pcre2_study.c pcre2lib/pcre2_substitute.c  pcre2lib/pcre2_substring.c pcre2lib/pcre2_tables.c pcre2lib/pcre2_ucd.c pcre2lib/pcre2_valid_utf.c pcre2lib/pcre2_xclass.c pcre2lib/pcre2_find_bracket.c pcre2lib/pcre2_convert.c pcre2lib/pcre2_extuni.c pcre2lib/pcre2_script_run.c)
#list(REMOVE_ITEM PCRELIB_SOURCES "${CMAKE_CURRENT_SOURCE_DIR}/pcrelib/dftables.c")

set(EXT_PCRE_SOURCES php_pcre.c)

#add_library(EXT_XML [STATIC | SHARED | MODULE] [EXCLUDE_FROM_ALL]
add_library(EXT_PCRE OBJECT ${PCRELIB_SOURCES} ${EXT_PCRE_SOURCES})
set_target_properties(EXT_PCRE
        PROPERTIES COMPILE_FLAGS "-DHAVE_CONFIG_H -DZEND_ENABLE_STATIC_TSRMLS_CACHE=1"
        )
##target_link_libraries(EXT_PCRE ${@@EXTENSION_LIBRARIES@@})
