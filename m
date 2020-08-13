Content-Type: multipart/mixed; boundary="===============8559237498487543054=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v7 mptcp-next 0/5] Add REMOVE_ADDR support
Date: Thu, 13 Aug 2020 18:37:14 +0800
Message-ID: <cover.1597314634.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 5544

--===============8559237498487543054==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

v7:
 - add RM_ADDR mib
 - update RM_ADDR selftests test case

v6:
 - rename lookup_anno_list_by_saddr to remove_anno_list_by_saddr as
   Paolo suggested.
 - add msk socket lock when traverse msk->conn_list as Paolo suggested.
 - Since the first three patches in v5 have been merged to export
   branch, drop them from this patchset.
 - add remove addr and subflow selftest test case.
 - this patchset is against mptcp_net-next's export branch.

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

Geliang Tang (5):
  mptcp: remove addr and subflow in PM netlink
  mptcp: add RM_ADDR mib
  selftests: mptcp: drop first flag in do_rnd_write
  selftests: mptcp: add remove addr and subflow test case
  selftests: mptcp: add RM_ADDR mib check function

 net/mptcp/mib.c                               |  1 +
 net/mptcp/mib.h                               |  1 +
 net/mptcp/options.c                           |  2 +
 net/mptcp/pm.c                                |  7 +-
 net/mptcp/pm_netlink.c                        | 87 ++++++++++++++++++-
 net/mptcp/protocol.c                          |  2 +
 net/mptcp/protocol.h                          |  2 +
 .../selftests/net/mptcp/mptcp_connect.c       |  7 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 67 ++++++++++++++
 9 files changed, 166 insertions(+), 10 deletions(-)

-- =

2.17.1

--===============8559237498487543054==--
