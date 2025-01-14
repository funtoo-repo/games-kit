# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop java-pkg-2 xdg

DESCRIPTION="Minecraft launcher which integrates multiple different ModPacks"
HOMEPAGE="https://atlauncher.com
	https://github.com/ATLauncher/ATLauncher"
SRC_URI="

https://github.com/ATLauncher/ATLauncher/releases/download/v3.4.38.1/ATLauncher-3.4.38.1.jar -> ATLauncher-3.4.38.1.jar
https://raw.githubusercontent.com/ATLauncher/ATLauncher/master/src/main/resources/assets/image/icon.ico -> ATLauncher.ico
"
KEYWORDS="*"
LICENSE="GPL-3"
SLOT="0"

BDEPEND="media-gfx/imagemagick[png]"

RDEPEND="virtual/jre:1.8"

S="${WORKDIR}"

src_unpack() {
	# do not unpack jar file
	cp "${DISTDIR}/${PN}.ico" "${S}" || die
}

src_compile() {
	convert ${PN}.ico ${PN}.png || die
}

src_install() {
	java-pkg_newjar "${DISTDIR}/${P}.jar" ${PN}.jar

	dobin "${FILESDIR}/${PN}"

	newicon -s 256x256 ${PN}-0.png atlauncher.png
	newicon -s 128x128 ${PN}-1.png atlauncher.png
	newicon -s 64x64 ${PN}-2.png atlauncher.png
	newicon -s 48x48 ${PN}-3.png atlauncher.png
	newicon -s 32x32 ${PN}-4.png atlauncher.png
	newicon -s 16x16 ${PN}-5.png atlauncher.png
	make_desktop_entry ${PN} "ATLauncher" atlauncher Game
}