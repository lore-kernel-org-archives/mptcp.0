Content-Type: multipart/mixed; boundary="===============1895018203257881201=="
MIME-Version: 1.0
From: Rikard Falkeborn <rikard.falkeborn at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 0/2] net: Constify struct genl_ops
Date: Sun, 04 Oct 2020 23:58:08 +0200
Message-ID: <20201004215810.26872-1-rikard.falkeborn@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 6183

--===============1895018203257881201==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Make a couple of static struct genl_ops const to allow the compiler to put
them in read-only memory. Patches are independent.

Rikard Falkeborn (2):
  mptcp: Constify mptcp_pm_ops
  net: openvswitch: Constify static struct genl_ops

 net/mptcp/pm_netlink.c      | 2 +-
 net/openvswitch/conntrack.c | 2 +-
 net/openvswitch/meter.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- =

2.28.0

--===============1895018203257881201==--
