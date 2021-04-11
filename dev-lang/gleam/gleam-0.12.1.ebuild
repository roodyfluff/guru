# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
	adler-0.2.3
	aho-corasick-0.7.13
	ansi_term-0.11.0
	ansi_term-0.12.1
	arrayref-0.3.6
	arrayvec-0.5.1
	ascii-canvas-2.0.0
	askama-0.10.3
	askama_derive-0.10.3
	askama_escape-0.10.1
	askama_shared-0.10.4
	async-trait-0.1.40
	atty-0.2.14
	autocfg-1.0.1
	base64-0.12.3
	bit-set-0.5.2
	bit-vec-0.6.2
	bitflags-1.2.1
	bitmaps-2.1.0
	blake2b_simd-0.5.10
	block-buffer-0.7.3
	block-padding-0.1.5
	bstr-0.2.13
	bumpalo-3.4.0
	byte-tools-0.3.1
	byteorder-1.3.4
	bytes-0.5.6
	cc-1.0.59
	cfg-if-0.1.10
	chrono-0.4.15
	clap-2.33.3
	codespan-0.9.5
	codespan-reporting-0.9.5
	constant_time_eq-0.1.5
	core-foundation-0.7.0
	core-foundation-sys-0.7.0
	crc32fast-1.2.0
	crossbeam-utils-0.7.2
	ctor-0.1.15
	ctrlc-3.1.6
	data-encoding-2.3.0
	der-oid-macro-0.2.0
	der-parser-4.0.2
	diff-0.1.12
	difference-2.0.0
	digest-0.8.1
	dirs-1.0.5
	docopt-1.1.0
	dtoa-0.4.6
	either-1.6.0
	ena-0.14.0
	encoding_rs-0.8.24
	fake-simd-0.1.2
	filetime-0.2.12
	fixedbitset-0.2.0
	flate2-1.0.17
	fnv-1.0.7
	foreign-types-0.3.2
	foreign-types-shared-0.1.1
	fs_extra-1.2.0
	fuchsia-zircon-0.3.3
	fuchsia-zircon-sys-0.3.3
	futures-channel-0.3.5
	futures-core-0.3.5
	futures-sink-0.3.5
	futures-task-0.3.5
	futures-util-0.3.5
	generic-array-0.12.3
	getopts-0.2.21
	getrandom-0.1.14
	globset-0.4.5
	h2-0.2.6
	hashbrown-0.8.2
	heck-0.3.1
	hermit-abi-0.1.15
	hexpm-1.1.1
	http-0.2.1
	http-body-0.3.1
	httparse-1.3.4
	humansize-1.1.0
	hyper-0.13.7
	hyper-tls-0.4.3
	idna-0.2.0
	ignore-0.4.16
	im-15.0.0
	indexmap-1.5.1
	iovec-0.1.4
	ipnet-2.3.0
	itertools-0.9.0
	itoa-0.4.6
	js-sys-0.3.44
	kernel32-sys-0.2.2
	lalrpop-0.19.0
	lalrpop-util-0.19.0
	lazy_static-1.4.0
	lexical-core-0.7.4
	libc-0.2.76
	log-0.4.11
	matchers-0.0.1
	matches-0.1.8
	memchr-2.3.3
	mime-0.3.16
	mime_guess-2.0.3
	miniz_oxide-0.4.1
	mio-0.6.22
	miow-0.2.1
	native-tls-0.2.4
	net2-0.2.34
	new_debug_unreachable-1.0.4
	nix-0.17.0
	nom-5.1.2
	num-bigint-0.3.0
	num-integer-0.1.43
	num-traits-0.2.12
	once_cell-1.4.1
	opaque-debug-0.2.3
	openssl-0.10.30
	openssl-probe-0.1.2
	openssl-sys-0.9.58
	output_vt100-0.1.2
	percent-encoding-2.1.0
	petgraph-0.5.1
	phf_shared-0.8.0
	pin-project-0.4.23
	pin-project-internal-0.4.23
	pin-project-lite-0.1.7
	pin-utils-0.1.0
	pkg-config-0.3.18
	ppv-lite86-0.2.9
	precomputed-hash-0.1.1
	pretty_assertions-0.6.1
	proc-macro-error-1.0.4
	proc-macro-error-attr-1.0.4
	proc-macro-hack-0.5.18
	proc-macro2-1.0.19
	protobuf-2.17.0
	protobuf-codegen-2.17.0
	protobuf-codegen-pure-2.17.0
	pulldown-cmark-0.7.2
	quote-1.0.7
	rand-0.7.3
	rand_chacha-0.2.2
	rand_core-0.5.1
	rand_hc-0.2.0
	rand_xoshiro-0.4.0
	redox_syscall-0.1.57
	redox_users-0.3.5
	regex-1.3.9
	regex-automata-0.1.9
	regex-syntax-0.6.18
	remove_dir_all-0.5.3
	reqwest-0.10.8
	ring-0.16.15
	rpassword-5.0.0
	rust-argon2-0.8.2
	rusticata-macros-2.1.0
	rustversion-1.0.3
	ryu-1.0.5
	same-file-1.0.6
	schannel-0.1.19
	security-framework-0.4.4
	security-framework-sys-0.4.3
	serde-1.0.115
	serde_derive-1.0.115
	serde_json-1.0.57
	serde_urlencoded-0.6.1
	sha2-0.8.2
	sharded-slab-0.0.9
	siphasher-0.3.3
	sized-chunks-0.6.2
	slab-0.4.2
	smallvec-1.4.2
	socket2-0.3.12
	spin-0.5.2
	static_assertions-1.1.0
	string_cache-0.8.0
	strsim-0.10.0
	strsim-0.8.0
	strsim-0.9.3
	structopt-0.3.17
	structopt-derive-0.4.10
	strum-0.19.2
	strum_macros-0.19.2
	syn-1.0.39
	tar-0.4.30
	tempfile-3.1.0
	term-0.5.2
	termcolor-1.1.0
	textwrap-0.11.0
	thiserror-1.0.20
	thiserror-impl-1.0.20
	thread_local-1.0.1
	time-0.1.44
	tinyvec-0.3.4
	tokio-0.2.22
	tokio-tls-0.3.1
	tokio-util-0.3.1
	toml-0.5.6
	tower-service-0.3.0
	tracing-0.1.19
	tracing-attributes-0.1.11
	tracing-core-0.1.15
	tracing-log-0.1.1
	tracing-serde-0.1.1
	tracing-subscriber-0.2.11
	try-lock-0.2.3
	typenum-1.12.0
	unicase-2.6.0
	unicode-bidi-0.3.4
	unicode-normalization-0.1.13
	unicode-segmentation-1.6.0
	unicode-width-0.1.8
	unicode-xid-0.2.1
	untrusted-0.7.1
	url-2.1.1
	vcpkg-0.2.10
	vec_map-0.8.2
	version_check-0.9.2
	void-1.0.2
	walkdir-2.3.1
	want-0.3.0
	wasi-0.10.0+wasi-snapshot-preview1
	wasi-0.9.0+wasi-snapshot-preview1
	wasm-bindgen-0.2.67
	wasm-bindgen-backend-0.2.67
	wasm-bindgen-futures-0.4.17
	wasm-bindgen-macro-0.2.67
	wasm-bindgen-macro-support-0.2.67
	wasm-bindgen-shared-0.2.67
	web-sys-0.3.44
	winapi-0.2.8
	winapi-0.3.9
	winapi-build-0.1.1
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	winreg-0.7.0
	ws2_32-sys-0.2.1
	x509-parser-0.8.0-beta4
	xattr-0.2.2
"

inherit cargo

DESCRIPTION="A statically typed functional language for the BEAM"
HOMEPAGE="https://gleam.run"
SRC_URI="
	https://github.com/gleam-lang/gleam/archive/v${PV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris ${CRATES})
"

LICENSE="Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 BSD BSL-1.1 CC0-1.0 MIT MPL-2.0 Unlicense ZLIB"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

QA_FLAGS_IGNORED="usr/bin/gleam"

src_configure() {
	export RUSTFLAGS="${RUSTFLAGS} --cap-lints warn"
	cargo_src_configure
}

src_install() {
	cargo_src_install
	einstalldocs
}
