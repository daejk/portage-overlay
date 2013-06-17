# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/coq/coq-8.4_p1.ebuild,v 1.3 2013/03/05 16:44:07 ago Exp $

EAPI="4"

inherit eutils multilib

MY_P="ssreflect-1.4"

DESCRIPTION="Coq SSReflect Library"
HOMEPAGE="http://coq.inria.fr/"
SRC_URI="http://ssr.msr-inria.inria.fr/FTP/ssreflect-1.4-coq8.4.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=sci-mathematics/coq-8.4[camlp5]"
DEPEND="${RDEPEND}"

# set the source dir manually
# the upstream name is ssreflect
# the ebuild name is coq-ssreflect
S="${WORKDIR}/${MY_P}"

src_compile() {
	emake 
}

src_install() {
	emake DSTROOT="${D}" install
}
