#!/bin/sh -e

# $1 = version
TAR=../netty_$2.orig.tar.gz
DIR=libnetty-java-$2.orig

# clean up the upstream tarball
svn export http://anonsvn.jboss.org/repos/netty/tags/netty-$2/ $DIR
GZIP=--best tar -c -z -f $TAR $DIR
rm -rf $DIR
rm ../netty-$2

# move to directory 'tarballs'
if [ -r .svn/deb-layout ]; then
  . .svn/deb-layout
  mv $TAR $origDir
  echo "moved $TAR to $origDir"
fi
