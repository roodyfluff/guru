# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

MY_COMMIT="7d9f232c412ad697a4ace35c8b5f7fe22f46124d"
DESCRIPTION="Non-blocking I/O tcp network lib based on c++14/17"
HOMEPAGE="https://github.com/an-tao/trantor"
SRC_URI="https://github.com/an-tao/trantor/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${MY_COMMIT}"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="adns doc +ssl test"
RESTRICT="!test? ( test )"

RDEPEND="
	adns? ( net-dns/c-ares:= )
	ssl? ( dev-libs/openssl:= )
"
DEPEND="
	${RDEPEND}
	test? ( dev-cpp/gtest )
"
BDEPEND="doc? ( app-doc/doxygen[dot] )"

src_configure() {
	local -a mycmakeargs=(
		"-DBUILD_SHARED_LIBS=YES"
		"-DBUILD_DOC=$(usex doc)"
		"-DBUILD_TESTING=$(usex test)"
		"-DBUILD_C-ARES=$(usex adns)"
		"$(cmake_use_find_package ssl OpenSSL)"
	)

	cmake_src_configure
}

src_install() {
	use doc && HTML_DOCS="${BUILD_DIR}/docs/trantor/html/*"

	cmake_src_install
}
