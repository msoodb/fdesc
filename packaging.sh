#!/bin/bash

# """ Create tar file """
VERSION=0
RELEASE=1

# """ rpm command """
cd ~/rpmbuild
wget https://raw.githubusercontent.com/msoodb/fdesc/master/fdesc.spec SPECS/
wget https://raw.githubusercontent.com/msoodb/fdesc/master/archive/v$VERSION/fdesc-$VERSION.tar.gz /SOURCES
rpmlint SPECS/fdesc.spec
rpmbuild -bs SPECS/fdesc.spec
rpmlint SRPMS/fdesc-0-1.fc30.src.rpm
rpmbuild -bb SPECS/fdesc.spec
rpmlint RPMS/x86_64/fdesc-0-1.fc30.x86_64.rpm


# """ Building in Copr and Koji """
# Create a Copr repository for fdesc https://copr.fedorainfracloud.org/coprs/msoodb/fdesc/
# Config Copr-cli with apikey https://copr.fedorainfracloud.org/api/
copr-cli build fdesc ~/rpmbuild/SRPMS/fdesc-0-1.fc30.src.rpm
koji build --scratch f35 SRPMS/fdesc-0-1.fc30.src.rpm

# """ Submitting the package """
# create a new bug in the Red Hat Bugzilla to ask for a package review


