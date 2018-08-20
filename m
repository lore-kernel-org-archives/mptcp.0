Content-Type: multipart/mixed; boundary="===============1177813835943316056=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 0/2] Forward-ports from mptcp_trunk
Date: Mon, 20 Aug 2018 08:52:17 -0700
Message-ID: <20180820155219.16681-1-cpaasch@apple.com>
X-Status: 
X-Keywords:                  
X-UID: 702

--===============1177813835943316056==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Two forward-ports coming from mptcp_trunk.

Gregory Detal (1):
  mptcp: correct refcnt for sk in tcp_v{4,6}_rcv

Matthieu Baerts (1):
  mptcp:minisocks: fix refcnt when adding to backlog

 include/net/mptcp.h      |  2 ++
 net/ipv4/tcp_ipv4.c      |  2 +-
 net/ipv4/tcp_minisocks.c |  2 +-
 net/ipv6/tcp_ipv6.c      |  2 +-
 net/mptcp/mptcp_ctrl.c   | 18 ++++++++++++++++--
 5 files changed, 21 insertions(+), 5 deletions(-)

-- =

2.16.2


--===============1177813835943316056==--
