## CMake Extension handler
##
## PHP License
##
## Author: Alejandro Leiva <gloob@php.net>
##
## $Id$

include(php/PHP_ARG_ENABLE)
include(php/PHP_NEW_EXTENSION)

include_directories(${CMAKE_CURRENT_SOURCE_DIR})
include_directories(${PHP_BINARY_DIR}/Zend)

set(EXTENSION_DIR ${CMAKE_CURRENT_SOURCE_DIR})

#file(GLOB_RECURSE EXTENSION_MODULES . CMakeLists.txt)
#list(REMOVE_ITEM EXTENSION_MODULES ${CMAKE_CURRENT_SOURCE_DIR}/CMakeLists.txt)

#If you don't need mysql, you can comment mysqli and pdo_mysql
set(EXTENSION_MODULES "date"
        "libxml"
        "openssl"
        "pcre"
        "ctype"
        "dom"
        "fileinfo"
        "filter"
        "hash"
        "iconv"
        "json"
        "mysqli"
##        "opcache"
        "pdo"
        "pdo_mysql"
        "phar"
        "posix"
        "reflection"
        "session"
        "simplexml"
        "spl"
        "standard"
        "tokenizer"
        "xml"
        "xmlreader"
        "xmlwriter"
        )


foreach(MODULE ${EXTENSION_MODULES})
  string(REPLACE ${CMAKE_CURRENT_SOURCE_DIR}/ "" MODULE_NAME ${MODULE})
  string(REPLACE /CMakeLists.txt "" MODULE_NAME ${MODULE_NAME})
  add_subdirectory(${MODULE_NAME})
  set(MOD_ACTIVE ${${MODULE_NAME}})
  if (MOD_ACTIVE)
    message("** Including extension: ${MODULE_NAME}")
#    include(${MODULE})
    string(TOUPPER "$<TARGET_OBJECTS:EXT_${MODULE_NAME}>" EXTENSION_TARGET)
    set(EXTENSION_LIST ${EXTENSION_TARGET} ${EXTENSION_LIST})
	set(EXTENSION_FOR_GENIF "${MODULE_NAME}\\\;ext/${MODULE_NAME}" ${EXTENSION_FOR_GENIF})

#  include_directories(${CMAKE_CURRENT_SOURCE_DIR}/${MODULE_NAME})
#  include_directories(${CMAKE_CURRENT_BINARY_DIR}/${MODULE_NAME})
  else()
    message("** NOT including extension: ${MODULE_NAME}")
  endif()
endforeach(MODULE)

set(EXTENSION_LIST ${EXTENSION_LIST} PARENT_SCOPE)
set(EXTENSION_FOR_GENIF ${EXTENSION_FOR_GENIF} PARENT_SCOPE)

add_library(MainAndExt ${EXTENSION_LIST} $<TARGET_OBJECTS:main> $<TARGET_OBJECTS:main_cli>)

target_link_libraries(MainAndExt "resolv")
target_link_libraries(MainAndExt "dl")
target_link_libraries(MainAndExt "m")
target_link_libraries(MainAndExt "pthread")
target_link_libraries(MainAndExt "z")
target_link_libraries(MainAndExt "ssl")
target_link_libraries(MainAndExt "crypto")

if(ICONV_FOUND)
    target_link_libraries(MainAndExt ${ICONV_LIBRARY})
endif(ICONV_FOUND)
target_link_libraries(MainAndExt ${LIBXML2_LIBRARIES})

#run mysql_config, copy --libs here
#If you don't need mysql, you can comment this part
add_library(mysqlclient SHARED IMPORTED)
set_target_properties(mysqlclient PROPERTIES
        IMPORTED_LOCATION "/usr/lib64/mysql/libmysqlclient.so"
        INTERFACE_INCLUDE_DIRECTORIES "/usr/include/mysql"
        )

target_link_libraries(MainAndExt "mysqlclient")


