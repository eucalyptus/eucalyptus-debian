#!/bin/sh -e

# $1 = version
TAR=../mule-$2.orig.tar.gz
DIR=mule-$2.orig

# clean up the upstream tarball
svn export  https://svn.codehaus.org/mule/tags/mule-$2/ $DIR
GZIP="--best --no-name" tar -c -z -f $TAR $DIR
rm -rf $DIR
rm ../mule-$2

# move to directory 'tarballs'
if [ -r .svn/deb-layout ]; then
  . .svn/deb-layout
  mv $TAR $origDir
  echo "moved $TAR to $origDir"
fi
