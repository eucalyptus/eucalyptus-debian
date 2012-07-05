#!/bin/sh -e

# $1 = --upstream-version, see uscan(1).
TAR=gwt_$2.orig.tar.gz
TMP_DIRECTORY=`mktemp --tmpdir --directory gwt-build.XXXXXXXXXX`
DIR=libgwt-java-$2.orig
origDir=`pwd`

# clean up the upstream tarball
svn export http://google-web-toolkit.googlecode.com/svn/tags/$2/ $TMP_DIRECTORY/$DIR
svn export http://google-web-toolkit.googlecode.com/svn/tools/lib/apache/tapestry-util-text-4.0.2-src.zip $TMP_DIRECTORY/tapestry-src.zip
unzip $TMP_DIRECTORY/tapestry-src.zip -d $TMP_DIRECTORY/$DIR/user/src
#remove dirs containing compiled JARs
cd $TMP_DIRECTORY/$DIR && rm -rf samples\
                                 tools/api-checker/reference\
                                 eclipse/settings/code-style/gwt-customchecks.jar\
                                 dev/core/test/com/google/gwt/dev/resource/impl/testdata\
                                 eclipse
cd $TMP_DIRECTORY && tar --create --gzip --file $TAR $DIR

# Move to directory 'tarballs' if available.
if [ -r .svn/deb-layout ]; then
  . .svn/deb-layout
fi
mv $TMP_DIRECTORY/$TAR $origDir
echo "moved $TMP_DIRECTORY/$TAR to $origDir"

rm -rf $TMP_DIRECTORY
