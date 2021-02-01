Content-Type: multipart/mixed; boundary="===============4614191969392071997=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next 0/7] RM_ADDR: remove a list of
 addrs
Date: Mon, 01 Feb 2021 15:11:09 +0800
Message-ID: <cover.1612163150.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 7543

--===============4614191969392071997==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

v2:
 - use an array of ids instead of a u64 map
 - drop "mptcp: update the netlink event for rm_addr" in v1
 - tag: export/20210131T062218

This patchset added the removing a list of addresses support for
RM_ADDR. It addressed issue #140.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/140

Geliang Tang (7):
  mptcp: remove multi addrs on outgoing path
  mptcp: remove multi addrs on incoming path
  mptcp: remove multi addresses in PM
  mptcp: remove multi subflows in PM
  mptcp: implement mptcp_nl_remove_addrs_and_subflows
  mptcp: remove a list of addrs when flushing
  selftests: mptcp: add testcases for removing addrs

 include/net/mptcp.h                           |   4 +-
 net/mptcp/options.c                           |  55 +++--
 net/mptcp/pm.c                                |  28 +--
 net/mptcp/pm_netlink.c                        | 190 ++++++++++++++----
 net/mptcp/protocol.h                          |  26 ++-
 .../testing/selftests/net/mptcp/mptcp_join.sh |  23 +++
 6 files changed, 252 insertions(+), 74 deletions(-)

-- =

2.29.2

--===============4614191969392071997==--
