Content-Type: multipart/mixed; boundary="===============3809194337147869106=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v4 mptcp-next 0/9] RM_ADDR: remove a list of
 addrs
Date: Fri, 05 Feb 2021 22:24:24 +0800
Message-ID: <cover.1612534633.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 7637

--===============3809194337147869106==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

v4:
 - use MAX_ADDR_ID as the default value in the rm_ids array.
 - keep the free_list and pass it to mptcp_nl_remove_addrs_list.
 - handle remove anno_addrs and subflows in one function.

v3:
 - avoid looping twice in mptcp_write_options
 - drop nr in mptcp_get_rm_ids_nr
 - use rm_ids[0] in patch 1 and patch 3
 - separate pm.rm_ids for incoming and outgoing
 - tag: export/20210131T062218

v2:
 - use an array of ids instead of a u64 map
 - drop "mptcp: update the netlink event for rm_addr" in v1
 - tag: export/20210131T062218

This patchset added the removing a list of addresses support for
RM_ADDR. It addressed issue #140.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/140

Geliang Tang (9):
  mptcp: use rm_ids array in mptcp_out_options
  mptcp: use rm_ids_tx array in mptcp_pm_data
  mptcp: use rm_ids array in mptcp_options_received
  mptcp: use rm_ids_rx array in mptcp_pm_data
  mptcp: remove multi addresses in PM
  mptcp: remove multi subflows in PM
  mptcp: remove multi addresses and subflows in PM
  mptcp: remove a list of addrs when flushing
  selftests: mptcp: add testcases for removing addrs

 include/net/mptcp.h                           |   4 +-
 net/mptcp/options.c                           |  54 +++++--
 net/mptcp/pm.c                                |  29 ++--
 net/mptcp/pm_netlink.c                        | 150 +++++++++++++-----
 net/mptcp/protocol.h                          |  31 +++-
 .../testing/selftests/net/mptcp/mptcp_join.sh |  23 +++
 6 files changed, 218 insertions(+), 73 deletions(-)

-- =

2.29.2

--===============3809194337147869106==--
