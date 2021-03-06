
# This file is generated throw deploy process
# DO NOT EDIT MANUALLY!


rm -rf ~/rpmbuild
rpmdev-setuptree

wget -O ~/rpmbuild/SPECS/fdesc.spec https://raw.githubusercontent.com/msoodb/fdesc/master/fdesc.spec
wget -O ~/rpmbuild/SOURCES/fdesc-0.tar.gz https://raw.githubusercontent.com/msoodb/fdesc/master/archive/v0/fdesc-0.tar.gz

rpmlint ~/rpmbuild/SPECS/fdesc.spec

rpmbuild -bs ~/rpmbuild/SPECS/fdesc.spec
rpmlint ~/rpmbuild/SRPMS/fdesc-0-1.fc30.src.rpm

rpmbuild -bb ~/rpmbuild/SPECS/fdesc.spec
rpmlint ~/rpmbuild/RPMS/x86_64/fdesc-0-1.fc30.x86_64.rpm


