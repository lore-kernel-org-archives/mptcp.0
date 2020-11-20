Content-Type: multipart/mixed; boundary="===============6165546496106238313=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v4 mptcp-next 0/2] drop rm_addr_signal flag and
 more
Date: Fri, 20 Nov 2020 18:06:44 +0800
Message-ID: <cover.1605866519.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 6873

--===============6165546496106238313==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

v4:
 - add the current add_addr/rm_addr value for pm_warn

v3:
 - use pr_warn

v2:
 - use pr_err instead of WARN_ON_ONCE

Geliang Tang (2):
  mptcp: drop rm_addr_signal flag
  mptcp: rename add_addr_signal and mptcp_add_addr_status

 net/mptcp/pm.c         | 26 +++++++++++++++++++-------
 net/mptcp/pm_netlink.c |  4 ++--
 net/mptcp/protocol.h   | 16 ++++++++--------
 3 files changed, 29 insertions(+), 17 deletions(-)

-- =

2.26.2

--===============6165546496106238313==--
