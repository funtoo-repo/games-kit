# Distributed under the terms of the GNU General Public License v2

EAPI=7
WX_GTK_VER=3.0-gtk3
inherit wxwidgets eutils flag-o-matic

DESCRIPTION="utilities for the SCUMM game engine"
HOMEPAGE="http://scummvm.sourceforge.net/"
SRC_URI="https://github.com/scummvm/scummvm-tools/tarball/516246735618120eb9439cb9673a32430c18d604 -> scummvm-tools-2.9.0-5162467.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="*"
IUSE="flac iconv mad png vorbis"
RESTRICT="test" # some tests require external files

RDEPEND="
	dev-libs/boost:=
	sys-libs/zlib
	x11-libs/wxGTK:${WX_GTK_VER}
	flac? ( media-libs/flac )
	iconv? ( virtual/libiconv media-libs/freetype:2 )
	mad? ( media-libs/libmad )
	png? ( media-libs/libpng:0 )
	vorbis? ( media-libs/libvorbis )"
DEPEND="${RDEPEND}
	app-arch/xz-utils
	virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}/${PN}-1.8.0-binprefix.patch"
)

post_src_unpack() {
	if [ ! -d "${S}" ]; then
		mv "${WORKDIR}"/scummvm-* "${S}" || die
	fi
}

src_prepare() {
	default

	rm -rf *.bat dists/win32 || die
	sed -ri -e '/^(CC|CXX)\b/d' Makefile || die
}

src_configure() {
	setup-wxwidgets
	tc-export CXX STRINGS

	# Not an autoconf script
	./configure \
		--prefix=/usr \
		--disable-tremor \
		--enable-verbose-build \
		--mandir=/usr/share/man \
		$(use_enable flac) \
		$(use_enable iconv) \
		$(use_enable iconv freetype2) \
		$(use_enable mad) \
		$(use_enable png) \
		$(use_enable vorbis) || die
}

src_install() {
	EXEPREFIX="${PN}-" default
}