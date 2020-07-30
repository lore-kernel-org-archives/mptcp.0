Content-Type: multipart/mixed; boundary="===============6903451548068772140=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v4 mptcp-next 0/5] Add REMOVE_ADDR support
Date: Thu, 30 Jul 2020 19:05:58 +0800
Message-ID: <cover.1596106606.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 5392

--===============6903451548068772140==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

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

Geliang Tang (5):
  mptcp: rename addr_signal and the related functions
  mptcp: add the outgoing RM_ADDR support
  mptcp: add the incoming RM_ADDR support
  mptcp: trigger the RM_ADDR signal
  mptcp: add remove subflow support

 net/mptcp/options.c    |  48 +++++++++++++++---
 net/mptcp/pm.c         |  56 ++++++++++++++++++---
 net/mptcp/pm_netlink.c | 110 +++++++++++++++++++++++++++++++++++++++--
 net/mptcp/protocol.c   |  14 ++++--
 net/mptcp/protocol.h   |  28 +++++++++--
 net/mptcp/subflow.c    |   1 +
 6 files changed, 231 insertions(+), 26 deletions(-)

-- =

2.17.1

--===============6903451548068772140==--
