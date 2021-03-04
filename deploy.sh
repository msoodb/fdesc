#!/bin/bash

# """ Copy spec file """
cp fdesc.spec ~/rpmbuild/SPECS/

# """ Create tar file """
VERSION=0
RELEASE=1
tar -czvf archive/v$VERSION/fdesc-$VERSION.$RELEASE.tar.gz \
    --exclude="fdesc.spec" \
    --exclude="fdesc" \
    --exclude=".git" \
    --exclude=".gitignore" \
    --exclude="deploy.sh" \
    --exclude="src/*.o" \
    --exclude="archive" \
    *
cp archive/v$VERSION/fdesc-$VERSION.$RELEASE.tar.gz archive/v$VERSION/fdesc-$VERSION.tar.gz

# """ Copy Source """
cp archive/v$VERSION/fdesc-$VERSION.tar.gz ~/rpmbuild/SOURCES

# """ Download Source """
# cd ~/rpmbuild/SOURCES
# wget https://raw.githubusercontent.com/msoodb/fdesc/master/archive/v$VERSION/fdesc-$VERSION.tar.gz
