%define modname mp3cut
%define modversion 1.06
%define modpath authors/id/J/JV/JV/%{modname}-%{modversion}.tar.gz
%define modreq perl

Name: %{modname}
Version: %{modversion}
Release: 1
Source: ftp://ftp.cpan.org/pub/CPAN/%{modpath}

URL: http://www.cpan.org/
BuildArch: noarch
BuildRoot: %{_tmppath}/rpm-buildroot-%{name}-%{version}-%{release}
Prefix: %{_prefix}

Summary: MP3 file splitter / concatenator
License: Artistic or GPL
Group: Applications/Multimedia
Requires: %{modreq}
BuildPrereq: %{modreq}
Packager: jv@cpan.org

%description
This package provides a couple of tools to cut and cat MP3 audio files
at the frame level.

* mp3cut uses a so called 'cue sheet' to cut an MP3 audio file into
  individual pieves (usually tracks)

* mp3cat concatenates the audio data from one or more MP3 files.

* cddb2cue generates a cue file from a CDDB file.

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
