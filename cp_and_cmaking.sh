#!/bin/sh -x
#
# $Id$

if [ ! -n "$1" ]
then
  echo "Usage: `basename $0` <dir>."
  exit 65
fi  

cp -r cmake/* $1

#rm -rf build
#mkdir -p build
cd build && cmake -DCMAKE_BUILD_TYPE:STRING=Debug ../$1 && make
