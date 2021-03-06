
#
# This file is generated throw deploy process
# DO NOT EDIT MANUALLY!
# Copy this file in ~ and run it
# cp fdesc-package.sh ~
# cd ~
# ./fdesc-package.sh


# setuptree
rm -rf ~/rpmbuild
rpmdev-setuptree

# get spec and source
wget -O ~/rpmbuild/SPECS/fdesc.spec https://raw.githubusercontent.com/msoodb/fdesc/master/fdesc.spec
wget -O ~/rpmbuild/SOURCES/fdesc-0.tar.gz https://raw.githubusercontent.com/msoodb/fdesc/master/archive/v0/fdesc-0.tar.gz

# lint spec
rpmlint ~/rpmbuild/SPECS/fdesc.spec

# build and lint SRPM
rpmbuild -bs ~/rpmbuild/SPECS/fdesc.spec
rpmlint ~/rpmbuild/SRPMS/fdesc-0-1.fc30.src.rpm

# build and lint RPM
rpmbuild -bb ~/rpmbuild/SPECS/fdesc.spec
rpmlint ~/rpmbuild/RPMS/x86_64/fdesc-0-1.fc30.x86_64.rpm



