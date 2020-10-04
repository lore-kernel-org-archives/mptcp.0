Content-Type: multipart/mixed; boundary="===============0816119768221082841=="
MIME-Version: 1.0
From: Rikard Falkeborn <rikard.falkeborn at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next v2 0/2] net: Constify struct genl_small_ops
Date: Mon, 05 Oct 2020 01:44:15 +0200
Message-ID: <20201004234417.12768-1-rikard.falkeborn@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 6189

--===============0816119768221082841==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Make a couple of static struct genl_small_ops const to allow the compiler
to put them in read-only memory. Patches are independent.

v2: Rebase on net-next, genl_ops -> genl_small_ops

Rikard Falkeborn (2):
  mptcp: Constify mptcp_pm_ops
  net: openvswitch: Constify static struct genl_small_ops

 net/mptcp/pm_netlink.c      | 2 +-
 net/openvswitch/conntrack.c | 2 +-
 net/openvswitch/meter.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- =

2.28.0

--===============0816119768221082841==--
