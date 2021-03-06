#!/bin/bash

# """ Clean Project """
make clean

# """ Variables """
NAME=fdesc
VERSION=0
RELEASE=1
TARGET=fc30
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

# """ Push "
git add .
git commit -m "deploy"
git push origin master

# """ echo packagin command """
touch $NAME-packag.sh
chmod 755 $NAME-packag.sh
echo "" > $NAME-packag.sh
echo "# This file is generated throw deploy process" >> $NAME-packag.sh
echo "# DO NOT EDIT MANUALLY!" >> $NAME-packag.sh
echo "" >> $NAME-packag.sh
echo "rm -rf ~/rpmbuild" > $NAME-packag.sh
echo "rpmdev-setuptree" >> $NAME-packag.sh
echo "wget -O ~/rpmbuild/SPECS/$NAME.spec https://raw.githubusercontent.com/msoodb/$NAME/master/$NAME.spec" >> $NAME-packag.sh
echo "wget -O ~/rpmbuild/SOURCES/$NAME-$VERSION.tar.gz https://raw.githubusercontent.com/msoodb/$NAME/master/archive/v$VERSION/$NAME-$VERSION.tar.gz" >> $NAME-packag.sh
echo "rpmlint ~/rpmbuild/SPECS/$NAME.spec" >> $NAME-packag.sh
echo "rpmbuild -bs ~/rpmbuild/SPECS/$NAME.spec" >> $NAME-packag.sh
echo "rpmlint ~/rpmbuild/SRPMS/$NAME-$VERSION-$RELEASE.$TARGET.src.rpm" >> $NAME-packag.sh
echo "rpmbuild -bb ~/rpmbuild/SPECS/$NAME.spec" >> $NAME-packag.sh
echo "rpmlint ~/rpmbuild/RPMS/x86_64/$NAME-$VERSION-$RELEASE.$TARGET.$ARCH.rpm" >> $NAME-packag.sh
