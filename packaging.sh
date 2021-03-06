#!/bin/bash

# """ Building in Copr and Koji """
# Create a Copr repository for fdesc https://copr.fedorainfracloud.org/coprs/msoodb/fdesc/
# Config Copr-cli with apikey https://copr.fedorainfracloud.org/api/
copr-cli build fdesc ~/rpmbuild/SRPMS/fdesc-0-1.fc30.src.rpm
koji build --scratch f35 SRPMS/fdesc-0-1.fc30.src.rpm

# """ Submitting the package """
# create a new bug in the Red Hat Bugzilla to ask for a package review https://bugzilla.redhat.com/show_bug.cgi?id=1935610

