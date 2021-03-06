
wget -O SPECS/fdesc.spec https://raw.githubusercontent.com/msoodb/fdesc/master/fdesc.spec
wget -O SOURCES/fdesc-0.tar.gz https://raw.githubusercontent.com/msoodb/fdesc/master/archive/v0/fdesc-0.tar.gz
rpmlint SPECS/fdesc.spec
rpmbuild -bs SPECS/fdesc.spec
rpmlint SRPMS/fdesc-0-1.fc30.src.rpm
rpmbuild -bb SPECS/fdesc.spec
rpmlint RPMS/x86_64/fdesc-0-1.fc30.x86_64.rpm
