#  PHP Version
#
#  Copyright (c) 2008 Alejandro Leiva <gloob@php.net>
#
#  Redistribution and use is allowed according to the terms of the New
#  BSD license.
#  For details see the accompanying COPYING-CMAKE-SCRIPTS file.
#
# $Id$

if(_configure_in_filepath)

  file(READ ${PHP_SOURCE_DIR}/main/php_version.h _configure_in_contents)

  string(REGEX MATCH "PHP_MAJOR_VERSION ([0-9]*)" _match_major_version "${_configure_in_contents}")
  string(REGEX MATCH "PHP_MINOR_VERSION ([0-9]*)" _match_minor_version "${_configure_in_contents}")
  string(REGEX MATCH "PHP_RELEASE_VERSION ([0-9]*)" _match_release_version "${_configure_in_contents}")
  string(REGEX MATCH "PHP_EXTRA_VERSION \"([^\"]*)\"" _match_extra_version "${_configure_in_contents}")
  string(REGEX MATCH "PHP_VERSION \"(.*)\"" _match_version "${_configure_in_contents}")
  string(REGEX MATCH "PHP_VERSION_ID ([0-9]*)" _match_version_id "${_configure_in_contents}")

  string(REPLACE "PHP_MAJOR_VERSION " "" match_major_version ${_match_major_version})
  string(REPLACE "PHP_MINOR_VERSION " "" match_minor_version ${_match_minor_version})
  string(REPLACE "PHP_RELEASE_VERSION " "" match_release_version ${_match_release_version})
  string(REPLACE "PHP_VERSION_ID " "" match_version_id ${_match_version_id})

  string(REPLACE "PHP_EXTRA_VERSION " "" match_extra_version ${_match_extra_version})
  string(REPLACE "\"" "" match_extra_version ${match_extra_version})

  string(REPLACE "PHP_VERSION " "" match_version ${_match_version})
  string(REPLACE "\"" "" match_version ${match_version})


  set(PHP_MAJOR_VERSION ${match_major_version})
  set(PHP_MINOR_VERSION ${match_minor_version})
  set(PHP_RELEASE_VERSION ${match_release_version})
  set(PHP_EXTRA_VERSION ${match_extra_version})
  set(PHP_VERSION_ID ${match_version_id})
  set(PHP_VERSION ${match_version})

  message("** PHP_MAJOR_VERSION: ${PHP_MAJOR_VERSION}")
  message("** PHP_MINOR_VERSION: ${PHP_MINOR_VERSION}")
  message("** PHP_RELEASE_VERSION: ${PHP_RELEASE_VERSION}")
  message("** PHP_EXTRA_VERSION: ${PHP_EXTRA_VERSION}")
  message("** PHP_VERSION: ${PHP_VERSION}")
  message("** PHP_VERSION_ID: ${PHP_VERSION_ID}")

endif(_configure_in_filepath)
