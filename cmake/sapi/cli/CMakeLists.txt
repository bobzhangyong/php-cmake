## CMake CLI File
##
## PHP License
##
## Author: Alejandro Leiva <gloob@php.net>
##
## $Id$

message("PHP_EXTENSION_SOURCE_LIST: ${PHP_EXTENSIONS_SOURCE_LIST}")
message("SAPI EXTENSION LIST: ${EXTENSION_LIST}")

file(GLOB sapi_cli_SRCS *.c)
list(REMOVE_ITEM sapi_cli_SRCS ${CMAKE_CURRENT_SOURCE_DIR}/cli_win32.c)

#link_directories(Zend)
#link_directories(main)
#link_directories(TSRM)
#link_directories(${EXTENSION_LIST})

#add_library(SAPI_CLI php_cli.c php_cli_process_title.c php_cli_server.c php_http_parser.c ps_title.c)

add_executable(php php_cli.c php_cli_process_title.c php_cli_server.c php_http_parser.c ps_title.c ${PHP_ZEND_SOURCES})
target_link_libraries(php ${EXTENSION_LIST} main TSRM Zend ${PHP_ZEND_LIBRARIES} ${PHP_ZEND_OBJECTS})
#target_link_libraries(php ${EXTENSION_LIST} main Zend)
#target_link_libraries(php Zend main TSRM ${EXTENSION_LIST} ${PHP_ZEND_LIBRARIES} ${PHP_ZEND_OBJECTS})
