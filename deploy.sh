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

# """ echo packagin command """
touch $NAME-package.sh
chmod 755 $NAME-package.sh
echo "" > $NAME-package.sh
echo "# This file is generated throw deploy process" >> $NAME-package.sh
echo "# DO NOT EDIT MANUALLY!" >> $NAME-package.sh
echo "# Copy this file in ~ and run it" >> $NAME-package.sh
echo "" >> $NAME-package.sh
echo "# cp $NAME-package.sh ~" >> $NAME-package.sh
echo "# cd ~" >> $NAME-package.sh
echo "# ./$NAME-package.sh" >> $NAME-package.sh
echo "" >> $NAME-package.sh
echo "" >> $NAME-package.sh
echo "# setuptree" >> $NAME-package.sh
echo "rm -rf ~/rpmbuild" >> $NAME-package.sh
echo "rpmdev-setuptree" >> $NAME-package.sh
echo "" >> $NAME-package.sh
echo "# get spec and source" >> $NAME-package.sh
echo "wget -O ~/rpmbuild/SPECS/$NAME.spec https://raw.githubusercontent.com/msoodb/$NAME/master/$NAME.spec" >> $NAME-package.sh
echo "wget -O ~/rpmbuild/SOURCES/$NAME-$VERSION.tar.gz https://raw.githubusercontent.com/msoodb/$NAME/master/archive/v$VERSION/$NAME-$VERSION.tar.gz" >> $NAME-package.sh
echo "" >> $NAME-package.sh
echo "# lint spec" >> $NAME-package.sh
echo "rpmlint ~/rpmbuild/SPECS/$NAME.spec" >> $NAME-package.sh
echo "" >> $NAME-package.sh
echo "# build and lint SRPM" >> $NAME-package.sh
echo "rpmbuild -bs ~/rpmbuild/SPECS/$NAME.spec" >> $NAME-package.sh
echo "rpmlint ~/rpmbuild/SRPMS/$NAME-$VERSION-$RELEASE.$TARGET.src.rpm" >> $NAME-package.sh
echo "" >> $NAME-package.sh
echo "# build and lint RPM" >> $NAME-package.sh
echo "rpmbuild -bb ~/rpmbuild/SPECS/$NAME.spec" >> $NAME-package.sh
echo "rpmlint ~/rpmbuild/RPMS/x86_64/$NAME-$VERSION-$RELEASE.$TARGET.$ARCH.rpm" >> $NAME-package.sh
echo "" >> $NAME-package.sh
echo "" >> $NAME-package.sh


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
