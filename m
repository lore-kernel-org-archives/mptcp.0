Content-Type: multipart/mixed; boundary="===============6498031690901481803=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next 00/10] ADD_ADDR: ports support
Date: Sat, 31 Oct 2020 23:24:31 +0800
Message-ID: <cover.1604156723.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 6502

--===============6498031690901481803==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

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
  mptcp: unify ADD_ADDR and echo suboptions writing
  mptcp: unify ADD_ADDR and ADD_ADDR6 suboptions writing
  mptcp: add port support for ADD_ADDR suboption writing
  mptcp: use adding up size when get ADD_ADDR length
  mptcp: add the outgoing ADD_ADDR port support
  mptcp: send out dedicated packet for ADD_ADDR using port
  mptcp: add port parameter for mptcp_pm_announce_addr
  mptcp: deal with MPTCP_PM_ADDR_ATTR_PORT in PM netlink
  selftests: mptcp: add port argument for pm_nl_ctl
  selftests: mptcp: add testcases for ADD_ADDR with port

 include/net/mptcp.h                           |  1 +
 net/mptcp/options.c                           | 89 +++++++++++--------
 net/mptcp/pm.c                                | 14 +--
 net/mptcp/pm_netlink.c                        | 28 ++++--
 net/mptcp/protocol.h                          | 36 +++++---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 26 +++++-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 18 ++++
 7 files changed, 153 insertions(+), 59 deletions(-)

-- =

2.26.2

--===============6498031690901481803==--
