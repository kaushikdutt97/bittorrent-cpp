Name:           bittorent
Version:        0
Release:        0
Summary:        Bittorent your files
License:        GPL-2.0
URL:            https://github.com/kaushikdutt97/bittorrent-cpp.git
Source:         %{name}-%{version}.tar.gz
BuildRequires:  libcurl-devel, cmake, ninja, gcc-c++

%description
Bittorent 

%prep
%setup

%build
make

%install
install -D %{_builddir}/%{name}-%{version}/build/bittorrent %{buildroot}/usr/bin/bittorrent

%files
/usr/bin/bittorrent

%debug_package

%changelog
