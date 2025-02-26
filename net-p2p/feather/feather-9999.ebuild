# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3 desktop

DESCRIPTION="A free, open-source Monero wallet"
HOMEPAGE="https://featherwallet.org"
SRC_URI=""
EGIT_REPO_URI="https://github.com/feather-wallet/feather.git"

# Feather is released under the terms of the BSD license, but it vendors
# code from Monero and Tor too.
LICENSE="BSD MIT"
SLOT="0"
KEYWORDS=""
IUSE="qrcode xmrig"

DEPEND="
	dev-libs/boost:=[nls]
	dev-libs/libgcrypt:=
	dev-libs/libsodium:=
	dev-libs/libzip:=
	dev-libs/openssl:=
	>=dev-qt/qtcore-5.15:5
	>=dev-qt/qtgui-5.15:5
	>=dev-qt/qtnetwork-5.15:5
	>=dev-qt/qtsvg-5.15:5
	>=dev-qt/qtwebsockets-5.15:5
	>=dev-qt/qtwidgets-5.15:5
	>=dev-qt/qtxml-5.15:5
	media-gfx/qrencode:=
	net-dns/unbound:=[threads]
	net-libs/czmq:=
	media-gfx/zbar:=[v4l]
"
RDEPEND="
	${DEPEND}
	net-vpn/tor
	xmrig? ( net-misc/xmrig )
"
BDEPEND="virtual/pkgconfig"

src_configure() {
	local mycmakeargs=(
		-DARCH=x86-64
		-DBUILD_64=ON
		-DBUILD_SHARED_LIBS=Off # Vendored Monero libs collision
		-DBUILD_TAG="linux-x64"
		-DBUILD_TESTS=OFF
		-DDONATE_BEG=OFF
		-DINSTALL_VENDORED_LIBUNBOUND=OFF
		-DMANUAL_SUBMODULES=1
		-DSTATIC=OFF
		-DSELF_CONTAINED=OFF
		-DUSE_DEVICE_TREZOR=OFF
		-DXMRIG=$(usex xmrig)
		-DWITH_SCANNER=$(usex qrcode)
		-DVERSION_IS_RELEASE=true
	)

	cmake_src_configure
}

src_compile() {
	cmake_build feather
}

src_install() {
	dobin "${BUILD_DIR}/bin/feather"

	doicon "${WORKDIR}"/${PF}/src/assets/images/feather.png
	domenu "${WORKDIR}"/${PF}/src/assets/feather.desktop
}

pkg_postinst() {
	einfo "Ensure that Tor is running with 'rc-service tor start' before"
	einfo "using Feather."
}
