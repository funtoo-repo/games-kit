# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop pax-utils xdg

DESCRIPTION="Real-time chess analysis GUI"
HOMEPAGE="https://github.com/fohristiwhirl/nibbler"
SRC_URI="https://github.com/fohristiwhirl/nibbler/releases/download/v2.4.8/nibbler-2.4.8-linux.zip -> nibbler-2.4.8-linux.zip"
LICENSE="GPL-3"
SLOT="0"

KEYWORDS="*"
IUSE=""

QA_PREBUILT="*"

src_unpack() {
	default

	mv nibbler-${PV}-linux nibbler-${PV}
}

src_prepare() {
	default

	cp "${FILESDIR}/nibbler.png" .
	cp "${FILESDIR}/nibbler.desktop" .
}

src_install() {
	doicon nibbler.png
	domenu nibbler.desktop

	insinto /opt/nibbler
	doins -r .

	fperms +x /opt/nibbler/nibbler
	fperms 4755 /opt/nibbler/chrome-sandbox || die
	dosym ../../opt/nibbler/nibbler usr/bin/nibbler
	pax-mark -m "${ED%/}"/opt/nibbler/nibbler
}

pkg_postinst() {
	xdg_mimeinfo_database_update
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_mimeinfo_database_update
	xdg_icon_cache_update
	xdg_desktop_database_update
}