# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit eutils multilib python

DESCRIPTION="Utils for Asus G61J laptops"
HOMEPAGE=""
SRC_URI="asus-G51J.tar.bz"


LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="sys-power/acpid dev-python/pynotifier"
RDEPEND="${DEPEND}"

S="${WORKDIR}/asus-kb-acpid-notifyosd-G51J"


src_install() {
	emake DESTDIR="${D}" install
}

