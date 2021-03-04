
cp fdesc-0.0.1/fdesc.spec ~/rpmbuild/SPECS/
tar -czvf fdesc-0.0.1.tar.gz \
    --exclude="fdesc-0.0.1/fdesc.spec" \
    --exclude="fdesc-0.0.1/fdesc" \
    --exclude="fdesc-0.0.1/.git" \
    --exclude="fdesc-0.0.1/.gitignore" \
    --exclude="fdesc-0.0.1/deploy.sh" \
    fdesc-0.0.1/
cp fdesc-0.0.1.tar.gz ~/rpmbuild/SOURCES
