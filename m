Content-Type: multipart/mixed; boundary="===============7877965271071245101=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 0/2] drop rm_addr_signal flag and
 more
Date: Mon, 09 Nov 2020 23:39:33 +0800
Message-ID: <cover.1604935892.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 6604

--===============7877965271071245101==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patchset should be applied after the 'ADD_ADDR: ports support'
series.

Geliang Tang (2):
  mptcp: drop rm_addr_signal flag
  mptcp: rename add_addr_signal and mptcp_add_addr_status

 net/mptcp/pm.c         | 18 +++++++++++-------
 net/mptcp/pm_netlink.c |  4 ++--
 net/mptcp/protocol.h   | 16 ++++++++--------
 3 files changed, 21 insertions(+), 17 deletions(-)

-- =

2.26.2

--===============7877965271071245101==--
