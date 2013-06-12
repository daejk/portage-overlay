# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="4"

inherit eutils multilib

MY_P="Containers"

DESCRIPTION="A type-class based container library for Coq"
HOMEPAGE="http://coq.inria.fr/pylons/contribs/view/Containers/v8.4"
SRC_URI="http://coq.inria.fr/pylons/contribs/files/Containers/v8.4/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=sci-mathematics/coq-8.4"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

src_prepare() {
  epatch "${FILESDIR}/Make.patch"
  cd ${S}
  coq_makefile -f Make -o Makefile
}

src_compile() {
	emake
}

src_install() {
	emake DSTROOT="${D}" install
}
