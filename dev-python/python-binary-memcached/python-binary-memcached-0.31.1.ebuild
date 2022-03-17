# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1

DESCRIPTION="access memcached via it's binary protocol with SASL auth support"
HOMEPAGE="
	https://github.com/jaysonsantos/python-binary-memcached
	https://pypi.org/project/python-binary-memcached/
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/uhashring[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	test? ( net-misc/memcached )
"
BDEPEND="
	test? (
		>=dev-python/m2r-0.2.1[${PYTHON_USEDEP}]
		dev-python/mistune[${PYTHON_USEDEP}]
		>=dev-python/pytest-6.2[${PYTHON_USEDEP}]
		>=dev-python/trustme-0.9.0[${PYTHON_USEDEP}]
		>=dev-python/mock-4.0[${PYTHON_USEDEP}]
	)
"

RESTRICT="test" # tests require a running memcached

distutils_enable_tests pytest