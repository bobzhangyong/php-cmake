## CMake TSRM File
##
## PHP License
##
## Author: Alejandro Leiva <gloob@php.net>
##
## $Id$

## TODO:
# Manage win32 issues...

# ########## Project setup ##########
PROJECT(TSRM C)
CMAKE_MINIMUM_REQUIRED(VERSION 2.4.5)

# Includes
INCLUDE_DIRECTORIES(${CMAKE_CURRENT_SOURCE_DIR})
INCLUDE_DIRECTORIES(${CMAKE_CURRENT_BINARY_DIR})


# ######### General setup ##########
INCLUDE_DIRECTORIES(${CMAKE_SOURCE_DIR})

MESSAGE("TSRM_SOURCE_DIR: ${TSRM_SOURCE_DIR}")
INCLUDE_DIRECTORIES(${TSRM_SOURCE_DIR})


# ########## TSRM executable ##########
# Sources:
file(GLOB TSRM_library_SRCS TSRM.c)

# Headers:
file(GLOB TSRM_library_HDRS TSRM.h)

# actual target:
ADD_LIBRARY(TSRM ${TSRM_library_SRCS} ${TSRM_library_HDRS})
SET_TARGET_PROPERTIES(TSRM PROPERTIES VERSION 0.0.0)

#ADD_EXECUTABLE(TSRM ${TSRM_executable_SRCS})

# add install target:
#INSTALL(TARGETS TSRM DESTINATION lib)
