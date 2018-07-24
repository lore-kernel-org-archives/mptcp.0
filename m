Content-Type: multipart/mixed; boundary="===============1562184273568020877=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 0/2] Forward-ports from mptcp_trunk
Date: Tue, 24 Jul 2018 16:49:38 -0700
Message-ID: <20180724234940.62909-1-cpaasch@apple.com>
X-Status: 
X-Keywords:                  
X-UID: 684

--===============1562184273568020877==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Two of the recent additions to mptcp_trunk.

Christoph Paasch (2):
  mptcp: Fix: Correct version-negotiation when SYN-cookies are set
  mptcp: Disable MPTCP when interface is non-MPTCP

 include/net/mptcp.h    |  6 +++---
 net/mptcp/mptcp_ctrl.c | 29 +++++++++++++++++++++--------
 2 files changed, 24 insertions(+), 11 deletions(-)

-- =

2.16.2


--===============1562184273568020877==--
