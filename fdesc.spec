Name:           fdesc
Version:        0
Release:        1%{?dist}
Summary:        CLI tools to generarte fake description.

License:        GPLv3+
URL:            https://github.com/msoodb/fdesc
Source0:        https://raw.githubusercontent.com/msoodb/fdesc/master/archive/v%{version}/%{name}-%{version}.tar.gz

BuildRequires:  gcc
BuildRequires:  make

%description
Fdesc tools get a number for characters count and generarte fake description.

%prep	
%global _hardened_build 1
%autosetup

%build	
export CFLAGS="%{optflags}"
export LDFLAGS="%{__global_ldflags}"
%make_build

%install
mkdir -p %{buildroot}%{_bindir}
install -p -m 755 %{name} %{buildroot}%{_bindir}/%{name}

%files	
%license LICENSE.txt
%{_bindir}/%{name}

%changelog
* Wed Mar  3 2021 msoodb <masoud.bolhassani@gmail.com> - 0-1
- First fdesc package
