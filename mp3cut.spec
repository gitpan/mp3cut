%define modname mp3cut
%define modversion 1.04
%define modpath authors/id/J/JV/JV/%{modname}-%{modversion}.tar.gz
%define modreq perl

Name: %{modname}
Version: %{modversion}
Release: %{modversion}
Source: ftp://ftp.cpan.org/pub/CPAN/%{modpath}

URL: http://www.cpan.org/
BuildArch: noarch
BuildRoot: %{_tmppath}/rpm-buildroot-%{name}-%{version}-%{release}
Prefix: %{_prefix}

Summary: Perl module %{modname}
License: distributable
Group: Development/Languages
Requires: %{modreq}
BuildPrereq: %{modreq}

%description
This package contains the Perl module %{modname} from CPAN.

%define __find_provides /usr/lib/rpm/find-provides.perl
%define __find_requires /usr/lib/rpm/find-requires.perl

%prep
%setup -q -n %{modname}-%{modversion}

%build
CFLAGS="$RPM_OPT_FLAGS" perl Makefile.PL \
	PREFIX=%{buildroot}%{_prefix} INSTALLDIRS=vendor
make
make test

%install
rm -rf %buildroot
make install_vendor

[ ! -x /usr/lib/rpm/brp-compress ] || /usr/lib/rpm/brp-compress

find %buildroot \( -name perllocal.pod -o -name .packlist \) -exec rm -vf {} \;
find %{buildroot}%{_prefix} -type f -print | sed 's|^%{buildroot}||' > rpm-files
[ -s rpm-files ] || exit 1

%clean
rm -rf %buildroot

%files -f rpm-files
%defattr(-,root,root)

%changelog
* Thu Jul 31 2003 Jos Vos <jos@xos.nl> 1.08-XOS.1
- Build for LinuX/OS 2.0.1.
- Initial version.
