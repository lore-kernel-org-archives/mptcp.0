Content-Type: multipart/mixed; boundary="===============1996625623973077365=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v8 mptcp-next 0/8] Add REMOVE_ADDR support
Date: Mon, 24 Aug 2020 19:36:13 +0800
Message-ID: <cover.1598267961.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 5605

--===============1996625623973077365==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

v8:
 - drop anno_list in v7.
   We don't need to add a new list, conn_list is enough for the signal
address and local subflow.
 - fix local_id and remote_id issues.
   The RM_ADDR logic uses an address id to identify the removing
address, so we must make sure the subflow's local_id and remote_id be
set properly.
 - fix mptcp_pm_nl_rm_addr_received logic issue
 - update selftests

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

Geliang Tang (8):
  mptcp: remove addr and subflow in PM netlink
  mptcp: fix mptcp_pm_nl_rm_addr_received logic issue
  mptcp: implementing mptcp_pm_remove_subflow
  mptcp: fix every subflow's local_id is zero
  mptcp: fix subflow's remote_id is zero issue
  mptcp: add RM_ADDR related mibs
  selftests: mptcp: add remove cfg in mptcp_connect
  selftests: mptcp: add remove addr and subflow test cases

 net/mptcp/mib.c                               |   2 +
 net/mptcp/mib.h                               |   2 +
 net/mptcp/pm.c                                |  25 ++-
 net/mptcp/pm_netlink.c                        | 105 +++++++++++--
 net/mptcp/protocol.c                          |   4 +
 net/mptcp/protocol.h                          |   5 +-
 net/mptcp/subflow.c                           |   8 +-
 .../selftests/net/mptcp/mptcp_connect.c       |  18 ++-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 142 +++++++++++++++++-
 9 files changed, 288 insertions(+), 23 deletions(-)

-- =

2.17.1

--===============1996625623973077365==--
