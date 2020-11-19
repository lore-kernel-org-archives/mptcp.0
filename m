Content-Type: multipart/mixed; boundary="===============0215004548032135237=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v5 mptcp-next 00/10] ADD_ADDR: ports support
Date: Thu, 19 Nov 2020 18:19:40 +0800
Message-ID: <cover.1605780306.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 6811

--===============0215004548032135237==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

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

Geliang Tang (10):
  mptcp: create the listening socket
  mptcp: add the pernet listening socket operations
  mptcp: bind and listen for the new port
  mptcp: add port number check for MP_JOIN
  mptcp: add port number announced check
  mptcp: add port number listened in kernel check
  mptcp: deal with MPTCP_PM_ADDR_ATTR_PORT in PM netlink
  selftests: mptcp: add port argument for pm_nl_ctl
  mptcp: add the mibs for ADD_ADDR with port
  selftests: mptcp: add testcases for ADD_ADDR with port

 net/mptcp/mib.c                               |   4 +
 net/mptcp/mib.h                               |   4 +
 net/mptcp/options.c                           |   4 +
 net/mptcp/pm_netlink.c                        |  80 +++++++++++
 net/mptcp/protocol.c                          |   5 +
 net/mptcp/protocol.h                          |  11 +-
 net/mptcp/subflow.c                           | 134 +++++++++++++++++-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 118 ++++++++++++++-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c |  24 +++-
 9 files changed, 378 insertions(+), 6 deletions(-)

-- =

2.26.2

--===============0215004548032135237==--
