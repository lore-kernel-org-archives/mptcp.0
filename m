Content-Type: multipart/mixed; boundary="===============8033714252547267845=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next 0/2] drop rm_addr_signal flag and
 more
Date: Thu, 19 Nov 2020 18:37:49 +0800
Message-ID: <cover.1605781893.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 6822

--===============8033714252547267845==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

v2:
 - use pr_err instead of WARN_ON_ONCE

Geliang Tang (2):
  mptcp: drop rm_addr_signal flag
  mptcp: rename add_addr_signal and mptcp_add_addr_status

 net/mptcp/pm.c         | 30 +++++++++++++++++++++---------
 net/mptcp/pm_netlink.c |  4 ++--
 net/mptcp/protocol.h   | 16 ++++++++--------
 3 files changed, 31 insertions(+), 19 deletions(-)

-- =

2.26.2

--===============8033714252547267845==--
