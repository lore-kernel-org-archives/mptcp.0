Content-Type: multipart/mixed; boundary="===============2783206064665345600=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v3 mptcp-next 0/9] RM_ADDR: remove a list of
 addrs
Date: Tue, 02 Feb 2021 15:20:51 +0800
Message-ID: <cover.1612250255.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 7579

--===============2783206064665345600==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

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
 net/mptcp/options.c                           |  56 ++++--
 net/mptcp/pm.c                                |  29 +--
 net/mptcp/pm_netlink.c                        | 190 ++++++++++++++----
 net/mptcp/protocol.h                          |  27 ++-
 .../testing/selftests/net/mptcp/mptcp_join.sh |  23 +++
 6 files changed, 255 insertions(+), 74 deletions(-)

-- =

2.29.2

--===============2783206064665345600==--
