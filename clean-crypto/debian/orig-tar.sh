#!/bin/sh -e

TAR=../../clean-crypto_1.orig.tar.gz
DIR=clean-crypto-1

# clean up the upstream tarball
bzr export $DIR http://bazaar.launchpad.net/~chris-grze/eucalyptus-commons-ext/clean-crypto 
GZIP="--best --no-name" tar -c -z -f $TAR $DIR
rm -rf $DIR

# move to directory 'tarballs'
if [ -r .svn/deb-layout ]; then
  . .svn/deb-layout
  mv $TAR $origDir
  echo "moved $TAR to $origDir"
fi
