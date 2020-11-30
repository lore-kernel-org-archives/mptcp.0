Content-Type: multipart/mixed; boundary="===============4219849474716606668=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v7 mptcp-next 0/7] ADD_ADDR: ports support
Date: Mon, 30 Nov 2020 14:17:48 +0800
Message-ID: <cover.1606716547.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 6971

--===============4219849474716606668==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

v7:
 - use the MPTCP listening socket instead of TCP one
 - release subflow_req->msk in subflow_init_req
 - add mismatched port MIBs
 - use sock_common in source_address

v6:
 - create and bind the listening socket in mptcp_nl_cmd_add_addr.
 - drop the patch "mptcp: add port number listened in kernel check" in
   v5.

v5:
 - use the per netns listening socket.
 - First 8 patches in v4 had been merged to the export branch, drop them
   from this patchset.

v4:
 - hold msk->pm.lock in mptcp_pm_sport_in_anno_list.
 - Merge the patchset 'Squash to "ADD_ADDR: ports support v3"' into v4.

v3:
 - add two new patches, 8 and 11
 - add more IS_ENABLED(CONFIG_MPTCP_IPV6) in patch 2
 - define TCPOLEN_MPTCP_ADD_ADDR_HMAC in patch 4
 - add flags check in patch 10
 - update the testcases

v2:
 - change mptcp_out_options's port field in CPU bype order.
 - keep mptcp_options_received's port field in CPU bype order.
 - add two new patches to simplify ADD_ADDR suboption writing.
 - update mptcp_add_addr_len helper use adding up size.
 - add more commit messages.

v1:
 This series is the first version of ADD_ADDR ports support. I have solved
 the listener problem which I mentioned at the meeting on 15th of October
 by adding a new listening socket from the userspace (see patch 8). Up to
 now this patchset works well.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/54

Geliang Tang (7):
  mptcp: create the listening socket for new port
  mptcp: add port number check for MP_JOIN
  mptcp: add port number announced check
  mptcp: deal with MPTCP_PM_ADDR_ATTR_PORT in PM netlink
  selftests: mptcp: add port argument for pm_nl_ctl
  mptcp: add the mibs for ADD_ADDR with port
  selftests: mptcp: add testcases for ADD_ADDR with port

 net/mptcp/mib.c                               |   6 +
 net/mptcp/mib.h                               |   6 +
 net/mptcp/options.c                           |   4 +
 net/mptcp/pm_netlink.c                        |  97 ++++++++++++
 net/mptcp/protocol.c                          |   2 +-
 net/mptcp/protocol.h                          |   4 +
 net/mptcp/subflow.c                           |  48 +++++-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 148 +++++++++++++++++-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c |  24 ++-
 9 files changed, 333 insertions(+), 6 deletions(-)

-- =

2.26.2

--===============4219849474716606668==--
