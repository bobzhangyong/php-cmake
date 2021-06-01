## CMake date File
##
## PHP License
##
## Author: bob_zy@yeah.net
##
## $Id$

# Extension: openssl

option(openssl "Enable openssl support" ON)
option(openssl-shared "openssl shared" OFF)

set(HAVE_OPENSSL_EXT 1)

set(EXT_OPENSSL_SOURCES
        openssl.c
        xp_ssl.c
        )

set(EXT_OPENSSL_HEADERS
        php_openssl.h
        )

add_library(EXT_OPENSSL OBJECT ${EXT_OPENSSL_SOURCES} ${EXT_OPENSSL_HEADERS})
set_target_properties(EXT_OPENSSL
        PROPERTIES COMPILE_FLAGS "-DHAVE_OPENSSL_EXT=1"
        )
