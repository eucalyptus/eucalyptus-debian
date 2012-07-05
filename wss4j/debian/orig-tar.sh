#!/bin/bash -e

# The fake --upstream-version is there to be callable by uscan(1).
if [ -z $2 ]; then
	echo "usage: ./debian/orig-tar.sh --upstream-version <version>"
	exit 1
fi

if [ -r .svn/deb-layout ]; then
  . .svn/deb-layout
fi

if [ -z "$origDir" ]; then
	origDir=".."
fi

echo "Creating orig.tar.gz in '$origDir'."

# $2 = version
SUFFIX="+svntag"
TAR=$origDir/wss4j_$2${SUFFIX}.orig.tar.gz

# See Developers Reference § 6.7.8.2.4
DIR=wss4j-$2${SUFFIX}.orig

if [ -d "$DIR" ]; then
	echo "Cannot export upstream sources to '$DIR', directory is already existing."
	exit 1
fi

# clean up the upstream tarball
svn export  http://svn.apache.org/repos/asf/webservices/wss4j/tags/${2//\./\_}/ $DIR
GZIP="--best --no-name" tar --exclude-vcs --exclude-from=debian/exclude -c -z -f $TAR $DIR
rm -rf $DIR
rm ../${2//\./_}
