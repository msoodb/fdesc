Name:           fdesc
Version:        0.0.1
Release:        1%{?dist}
Summary:        command line application generarte fake description.

License:        GPLv3+
URL:            https://github.com/msoodb/fdesc
Source0:        fdesc-0.0.1.tar.gz

Requires(post): info
Requires(preun): info

%description
A command line application generarte fake description.

%global debug_package %{nil}

%prep
%setup

%build
make PREFIX=/usr %{?_smp_mflags}

%install
make PREFIX=/usr DESTDIR=%{?buildroot} install

%clean
make PREFIX=/usr DESTDIR=%{?buildroot} clean
# rm -rf %{buildroot}

%files
%{_bindir}/fdesc
