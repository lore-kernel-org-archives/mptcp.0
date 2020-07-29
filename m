Content-Type: multipart/mixed; boundary="===============1563907414107149168=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v3 mptcp-next 0/4] Add REMOVE_ADDR support
Date: Wed, 29 Jul 2020 17:02:42 +0800
Message-ID: <cover.1596012283.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 5362

--===============1563907414107149168==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

v3:
 - fix memory leak and lock issue in v2.
 - drop alist in v2.
 - fix mptcp_subflow_shutdown's arguments.
 - bzero remote in mptcp_pm_create_subflow_or_signal_addr.
 - add more commit message.

Geliang Tang (4):
  mptcp: rename addr_signal and the related functions
  mptcp: add the outgoing RM_ADDR support
  mptcp: add the incoming RM_ADDR support
  mptcp: trigger the RM_ADDR signal

 net/mptcp/options.c    | 48 ++++++++++++++++++++++----
 net/mptcp/pm.c         | 54 ++++++++++++++++++++++++++----
 net/mptcp/pm_netlink.c | 76 ++++++++++++++++++++++++++++++++++++++++--
 net/mptcp/protocol.c   | 17 +++++++---
 net/mptcp/protocol.h   | 29 +++++++++++++---
 net/mptcp/subflow.c    |  1 +
 6 files changed, 199 insertions(+), 26 deletions(-)

-- =

2.17.1

--===============1563907414107149168==--
