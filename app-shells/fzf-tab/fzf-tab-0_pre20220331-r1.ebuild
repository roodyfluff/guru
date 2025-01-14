# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit readme.gentoo-r1

MY_COMMIT="103330fdbeba07416d5f90b391eee680cd20d2d6"
DESCRIPTION="Replace zsh's default completion selection menu with fzf"
HOMEPAGE="https://github.com/Aloxaf/fzf-tab"
SRC_URI="https://github.com/Aloxaf/fzf-tab/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${MY_COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND="
	app-shells/fzf
	app-shells/zsh
"
BDEPEND="
	test? (
		app-shells/zsh
		dev-vcs/git
	)
"

RESTRICT="test" # bug 861638

DISABLE_AUTOFORMATTING="true"
DOC_CONTENTS="In order to use ${CATEGORY}/${PN} add
. /usr/share/zsh/site-functions/${PN}.zsh
to your ~/.zshrc after compinit, but before plugins which will wrap
widgets, such as zsh-autosuggestions or fast-syntax-highlighting"

MY_ZSH_LIBDIR="/usr/share/zsh/site-functions"

src_configure() {
	# Test fails if we modify FZF_TAB_HOME in place
	sed -E "s|^(FZF_TAB_HOME=\"[^\"]+)\"$|\1/${PN}\"|" \
		${PN}.zsh > ${PN}-patched.zsh || die "Modifying FZF_TAB_HOME failed"

	pushd modules || die "Changing directory failed"
	default_src_configure
}

src_compile() {
	pushd modules || die "Changing directory failed"
	default_src_compile
}

src_test() {
	pushd test || die "Changing directory failed"
	ZTST_verbose=1 zsh -f ./runtests.zsh fzftab.ztst || die "One or more tests failed"
}

src_install() {
	insinto ${MY_ZSH_LIBDIR}
	newins ${PN}{-patched,}.zsh

	insinto ${MY_ZSH_LIBDIR}/${PN}
	doins -r lib

	insinto ${MY_ZSH_LIBDIR}/${PN}/modules/Src/aloxaf
	doins modules/Src/aloxaf/fzftab.so

	readme.gentoo_create_doc
	einstalldocs
}

pkg_postinst() {
	readme.gentoo_print_elog
}
