#!/bin/bash

# """ Clean Project """
make clean

# """ Create tar file """
VERSION=0
RELEASE=2


mkdir -p fdesc-$VERSION
rm -rf fdesc-$VERSION/*
cp -r src fdesc-$VERSION/
cp Makefile fdesc-$VERSION/
cp README.md fdesc-$VERSION/


tar -czvf archive/v$VERSION/fdesc-$VERSION.$RELEASE.tar.gz fdesc-$VERSION
cp archive/v$VERSION/fdesc-$VERSION.$RELEASE.tar.gz archive/v$VERSION/fdesc-$VERSION.tar.gz

# """ Copy spec file """
cp fdesc.spec ~/rpmbuild/SPECS/

# """ Copy Source """
cp archive/v$VERSION/fdesc-$VERSION.tar.gz ~/rpmbuild/SOURCES

# """ Download Source """
# cd ~/rpmbuild/SOURCES
# wget https://raw.githubusercontent.com/msoodb/fdesc/master/archive/v$VERSION/fdesc-$VERSION.tar.gz

# """ Clean UP"""
rm -rf fdesc-$VERSION
