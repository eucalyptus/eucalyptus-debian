#!/bin/sh

VERSION=$2
TAR=../guava-libraries_$VERSION.orig.tar.gz
DIR=guava-r$VERSION

mkdir -p $DIR/src/main/java
(cd $DIR/src/main/java
	jar xf ../../../../$3
)
GZIP=--best tar -cz --owner root --group root --mode a+rX \
  --anchored -X debian/orig-tar.excludes -f $TAR $DIR
rm -rf $DIR $3
