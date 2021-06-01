## CMake date File
##
## PHP License
##
## Author: Alejandro Leiva <gloob@php.net>
##
## $Id$

# Extension: pdo_mysql

option(pdo_mysql "Enable pdo_mysql support" ON)
option(pdo_mysql-shared "Shared pdo_mysql" OFF)

include_directories(${EXTENSION_DIR})

set(EXT_PDO_MYSQL_SOURCES pdo_mysql.c mysql_driver.c mysql_statement.c)

#run mysql_config, copy --cflags path here
include_directories("/usr/include/mysql")


#add_library(EXT_XML [STATIC | SHARED | MODULE] [EXCLUDE_FROM_ALL]
add_library(EXT_PDO_MYSQL OBJECT ${EXT_PDO_MYSQL_SOURCES})

set_target_properties(EXT_PDO_MYSQL
        PROPERTIES COMPILE_FLAGS "-DZEND_ENABLE_STATIC_TSRMLS_CACHE=1"
        )