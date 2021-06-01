## CMake date File
##
## PHP License
##
## Author: Alejandro Leiva <gloob@php.net>
##
## $Id$

# Extension: hash

option(hash "Enable hash support" ON)
option(hash-shared "Shared hash" OFF)

#file(GLOB EXT_HASH_SOURCES *.c)
set(EXT_HASH_SOURCES hash.c hash_md.c hash_sha.c hash_ripemd.c hash_haval.c
        hash_tiger.c hash_gost.c hash_snefru.c hash_whirlpool.c hash_adler32.c
        hash_crc32.c hash_fnv.c hash_joaat.c sha3/generic64lc/KeccakP-1600-opt64.c
        sha3/generic64lc/KeccakHash.c sha3/generic64lc/KeccakSponge.c hash_sha3.c
        )

set(EXT_HASH_HEADER php_hash.h php_hash_md.h php_hash_sha.h php_hash_ripemd.h
        php_hash_haval.h php_hash_tiger.h php_hash_gost.h php_hash_snefru.h
        php_hash_whirlpool.h php_hash_adler32.h php_hash_crc32.h
        php_hash_fnv.h php_hash_joaat.h php_hash_sha3.h
        )

include_directories("${CMAKE_CURRENT_SOURCE_DIR}/sha3/generic64lc")

#add_library(EXT_XML [STATIC | SHARED | MODULE] [EXCLUDE_FROM_ALL]
add_library(EXT_HASH OBJECT ${EXT_HASH_SOURCES} ${EXT_HASH_HEADER})

set_target_properties(EXT_HASH
        PROPERTIES COMPILE_FLAGS "-DKeccakP200_excluded -DKeccakP400_excluded -DKeccakP800_excluded -DZEND_ENABLE_STATIC_TSRMLS_CACHE=1"
        )

##target_link_libraries(EXT_HASH ${@php_hash_sha3_224_ops@EXTENSION_LIBRARIES@@})
