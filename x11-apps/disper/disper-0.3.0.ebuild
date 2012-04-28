# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit eutils multilib python

DESCRIPTION="Disper is an on-the-fly display switch utility"
HOMEPAGE="http://willem.engen.nl/projects/disper/"
SRC_URI="http://ppa.launchpad.net/disper-dev/ppa/ubuntu/pool/main/d/${PN}/${PN}_${PV}.tar.gz"


LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-lang/python"
RDEPEND="${DEPEND}"

PYTHON_DEPEND="2"
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/dispercur"

src_prepare() {
    epatch "${FILESDIR}/${P}-delay_backend_init.patch"
    python_convert_shebangs -r 2 .
}

pkg_setup() {
    python_set_active_version 2
}

src_install() {
	emake DESTDIR="${D}" install
	doman "${PN}.1"
	dodoc README
}

