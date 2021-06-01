## CMake date File
##
## PHP License
##
## Author: Alejandro Leiva <gloob@php.net>
##
## $Id$

# Extension: sqlite3

option(mysqli "Enable mysqli support" ON)
option(mysqli-shared "Shared mysqli" OFF)


set(EXT_MYSQLI_SOURCES
mysqli.c mysqli_api.c mysqli_prop.c mysqli_nonapi.c
mysqli_fe.c mysqli_report.c mysqli_driver.c mysqli_warning.c
mysqli_exception.c mysqli_result_iterator.c
)

set(EXT_MYSQLI_HEADER php_mysqli_structs.h mysqli_libmysql.h)

#run mysql_config, copy --cflags path here
include_directories("/usr/include/mysql")


#add_library(EXT_XML [STATIC | SHARED | MODULE] [EXCLUDE_FROM_ALL]
add_library(EXT_MYSQLI OBJECT ${EXT_MYSQLI_SOURCES} ${EXT_MYSQLI_HEADER})
set_target_properties(EXT_MYSQLI
        PROPERTIES COMPILE_FLAGS "-DZEND_ENABLE_STATIC_TSRMLS_CACHE=1"
        )
##target_link_libraries(EXT_SQLITE3 ${@@EXTENSION_LIBRARIES@@})
