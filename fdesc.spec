Name:           fdesc
Version:        0
Release:        1%{?dist}
Summary:        CLI tools to generate fake description

License:        GPLv3+
URL:            https://github.com/msoodb/fdesc
Source0:        https://raw.githubusercontent.com/msoodb/fdesc/master/archive/v%{version}/%{name}-%{version}.tar.gz

BuildRequires:  gcc
BuildRequires:  make

%description
Fdesc tools get a number for characters count and generate fake description.

%prep	
%global _hardened_build 1
%autosetup

%build	
export CFLAGS="%{optflags}"
export LDFLAGS="%{__global_ldflags}"
%make_build

%install
mkdir -p %{buildroot}%{_bindir}
mkdir -p %{buildroot}%{_mandir}/man1
install -p -m 755 %{name} %{buildroot}%{_bindir}/%{name}
install -p -m %{name}.1 %{buildroot}%{_mandir}/man1/%{name}.1

%files
%doc README.md
%license LICENSE
%{_bindir}/%{name}
%{_mandir}/man1/%{name}.1*

%changelog
* Wed Mar  3 2021 msoodb <masoud.bolhassani@gmail.com> - 0-1
- First fdesc package
