#!/bin/bash

# """ Clean Project """
make clean

# """ Create tar file """
VERSION=0
RELEASE=1

mkdir fdesc-$VERSION
rm -rf fdesc-$VERSION/*
cp -r src fdesc-$VERSION/
cp fdesc.1 fdesc-$VERSION/
cp Makefile fdesc-$VERSION/
cp README.md fdesc-$VERSION/
cp LICENSE fdesc-$VERSION/

tar -czvf archive/v$VERSION/fdesc-$VERSION.$RELEASE.tar.gz fdesc-$VERSION
cp archive/v$VERSION/fdesc-$VERSION.$RELEASE.tar.gz archive/v$VERSION/fdesc-$VERSION.tar.gz

# """ Clean UP """
rm -rf fdesc-$VERSION

# """ Push "
git add .
git commit -m "deploy"
git push origin master

# """ echo packagin command """
echo  wget -O SPECS/fdesc.spec https://raw.githubusercontent.com/msoodb/fdesc/master/fdesc.spec
echo  wget -O SOURCES/fdesc-$VERSION.tar.gz https://raw.githubusercontent.com/msoodb/fdesc/master/archive/v$VERSION/fdesc-$VERSION.tar.gz
echo  rpmlint SPECS/fdesc.spec
echo  rpmbuild -bs SPECS/fdesc.spec
echo  rpmlint SRPMS/fdesc-0-1.fc30.src.rpm
echo  rpmbuild -bb SPECS/fdesc.spec
echo  rpmlint RPMS/x86_64/fdesc-0-1.fc30.x86_64.rpm
