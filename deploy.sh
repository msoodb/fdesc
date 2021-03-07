#!/bin/bash

# """ Clean Project """
make clean

# """ Variables """
NAME=fdesc
VERSION=0
RELEASE=1
TARGET=fc32
ARCH=x86_64

# """ Create tar file """
mkdir $NAME-$VERSION
rm -rf $NAME-$VERSION/*
cp -r src $NAME-$VERSION/
cp $NAME.1 $NAME-$VERSION/
cp Makefile $NAME-$VERSION/
cp README.md $NAME-$VERSION/
cp LICENSE $NAME-$VERSION/
tar -czvf archive/v$VERSION/$NAME-$VERSION.$RELEASE.tar.gz $NAME-$VERSION
cp archive/v$VERSION/$NAME-$VERSION.$RELEASE.tar.gz archive/v$VERSION/$NAME-$VERSION.tar.gz

# """ Clean UP """
rm -rf $NAME-$VERSION

# """ Create package.sh """
touch $NAME-package.sh
chmod 755 $NAME-package.sh
__package="
#
# This file is generated throw deploy process
# DO NOT EDIT MANUALLY!
# Copy this file in ~ and run it
# cp $NAME-package.sh ~
# cd ~
# ./$NAME-package.sh


# setuptree
rm -rf ~/rpmbuild
rpmdev-setuptree

# get spec and source
wget -O ~/rpmbuild/SPECS/$NAME.spec https://raw.githubusercontent.com/msoodb/$NAME/master/$NAME.spec
wget -O ~/rpmbuild/SOURCES/$NAME-$VERSION.tar.gz https://raw.githubusercontent.com/msoodb/$NAME/master/archive/v$VERSION/$NAME-$VERSION.tar.gz

# lint spec
rpmlint ~/rpmbuild/SPECS/$NAME.spec

# build and lint SRPM
rpmbuild -bs ~/rpmbuild/SPECS/$NAME.spec
rpmlint ~/rpmbuild/SRPMS/$NAME-$VERSION-$RELEASE.$TARGET.src.rpm

# build and lint RPM
rpmbuild -bb ~/rpmbuild/SPECS/$NAME.spec
rpmlint ~/rpmbuild/RPMS/x86_64/$NAME-$VERSION-$RELEASE.$TARGET.$ARCH.rpm

# Building in Copr
copr-cli build $NAME ~/rpmbuild/SRPMS/$NAME-$VERSION-$RELEASE.$TARGET.src.rpm
# sudo dnf copr enable msoodb/fdesc fedora-32-x86_64

"
echo "$__package" > $NAME-package.sh




# """ Push "
git add .
git commit -m "deploy"
git push origin master

# """ Package commands"
echo ""
echo ""
echo "# cp $NAME-package.sh ~"
echo "# cd ~"
echo "# ./$NAME-package.sh"
echo ""
