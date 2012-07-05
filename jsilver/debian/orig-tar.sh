#!/bin/sh -e

# $1 = --upstream-version, see uscan(1).
TAR=jsilver_$2.dfsg.orig.tar.gz
TMP_DIRECTORY=`mktemp --tmpdir --directory jsilver.XXXXXXXXXX`
DIR=jsilver-$2.dfsg.orig
origDir=`pwd`

# clean up the upstream tarball
svn export http://jsilver.googlecode.com/svn/tags/jsilver-$2/ $TMP_DIRECTORY/$DIR

# remove dirs containing compiled JARs
# also, remove the file sablecc/optimizations/AOptimizedMultipleCommand.java
# which does not have a free header 
cd $TMP_DIRECTORY/$DIR && rm -rf lib\
                                 sablecc
cd $TMP_DIRECTORY && tar --create --gzip --file $TAR $DIR

# Move to directory 'tarballs' if available.
if [ -r .svn/deb-layout ]; then
  . .svn/deb-layout
fi
mv $TMP_DIRECTORY/$TAR $origDir
echo "moved $TMP_DIRECTORY/$TAR to $origDir"

rm -rf $TMP_DIRECTORY
