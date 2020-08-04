Content-Type: multipart/mixed; boundary="===============1398871499702598156=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v5 mptcp-next 0/4] Add REMOVE_ADDR support
Date: Tue, 04 Aug 2020 18:01:31 +0800
Message-ID: <cover.1596534832.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 5454

--===============1398871499702598156==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

v5:
 - merge mptcp_nl_remove_subflow() and mptcp_nl_remove_addr()
 - add cond_resched
 - reduce the indentation level in mptcp_pm_nl_rm_addr_received

v4:
 - update mptcp_subflow_shutdown()'s args.
 - add rm_id check to make sure we don't shutdown the first subflow.
 - add conn_list empty check.
 - move anno_list to mptcp_pm_data.
 - add a new patch 'mptcp: add remove subflow support'.

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
  mptcp: remove addr and subflow in PM netlink

 net/mptcp/options.c    |  48 ++++++++++++---
 net/mptcp/pm.c         |  56 +++++++++++++++---
 net/mptcp/pm_netlink.c | 129 +++++++++++++++++++++++++++++++++++++++--
 net/mptcp/protocol.c   |  14 +++--
 net/mptcp/protocol.h   |  28 +++++++--
 net/mptcp/subflow.c    |   1 +
 6 files changed, 248 insertions(+), 28 deletions(-)

-- =

2.17.1

--===============1398871499702598156==--
