# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/coq/coq-8.4_p1.ebuild,v 1.3 2013/03/05 16:44:07 ago Exp $

EAPI="4"

inherit eutils multilib

MY_PV=${PV/_p/pl}
MY_P=${PN}-${MY_PV}

DESCRIPTION="Coq is a proof assistant written in O'Caml"
HOMEPAGE="http://coq.inria.fr/"
SRC_URI="http://${PN}.inria.fr/V${MY_PV}/files/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86"
IUSE="gtk debug +ocamlopt doc camlp5 mtac"

RDEPEND=">=dev-lang/ocaml-3.11.2[ocamlopt?]
	camlp5? ( >=dev-ml/camlp5-6.02.3[ocamlopt?] )
	gtk? ( >=dev-ml/lablgtk-2.10.1[ocamlopt?] )"
DEPEND="${RDEPEND}
	doc? (
		media-libs/netpbm[png,zlib]
		virtual/latex-base
		dev-tex/hevea
		dev-tex/xcolor
		dev-texlive/texlive-pictures
		dev-texlive/texlive-mathextra
		dev-texlive/texlive-latexextra
		)"

S=${WORKDIR}/${MY_P}

src_prepare() {
	use mtac && epatch "${FILESDIR}"/mtac-1.0.patch
	epatch "${FILESDIR}"/coqlib.patch
}

src_configure() {
	ocaml_lib=`ocamlc -where`
	local myconf="--prefix /usr
		--bindir /usr/bin
		--libdir /usr/$(get_libdir)/coq
		--mandir /usr/share/man
		--emacslib /usr/share/emacs/site-lisp
		--coqdocdir /usr/$(get_libdir)/coq/coqdoc
		--docdir /usr/share/doc/${PF}
		--configdir /etc/xdg/${PN}
		--lablgtkdir ${ocaml_lib}/lablgtk2"

	use debug && myconf="--debug $myconf"
	use doc || myconf="$myconf --with-doc no"

	if use gtk; then
		use ocamlopt && myconf="$myconf --coqide opt"
		use ocamlopt || myconf="$myconf --coqide byte"
	else
		myconf="$myconf --coqide no"
	fi
	use ocamlopt || myconf="$myconf -byte-only"
	use ocamlopt && myconf="$myconf --opt"

	use camlp5 || myconf="$myconf --usecamlp4"
	use camlp5 && myconf="$myconf --camlp5dir ${ocaml_lib}/camlp5"

	export CAML_LD_LIBRARY_PATH="${S}/kernel/byterun/"
	./configure $myconf || die "configure failed"
}

src_compile() {
	emake STRIP="true" -j1 || die "make failed"
}

src_install() {
	emake STRIP="true" COQINSTALLPREFIX="${D}" install || die
	dodoc README CREDITS CHANGES

	use gtk && make_desktop_entry "/usr/bin/coqide" "Coq IDE" "/usr/share/coq/coq.png"
}
