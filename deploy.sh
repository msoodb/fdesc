
cp fdesc.spec ~/rpmbuild/SPECS/
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
# cp fdesc-0.1.tar.gz ~/rpmbuild/SOURCES
