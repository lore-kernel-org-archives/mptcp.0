Content-Type: multipart/mixed; boundary="===============5630518657908879600=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v4 mptcp-next 0/5] mptcp: create subflow for
 newly added address and testcases
Date: Wed, 06 Jan 2021 14:30:04 +0800
Message-ID: <cover.1609914325.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 7271

--===============5630518657908879600==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

v4:
 - add a new patch to use WRITE_ONCE/READ_ONCE for the pernet *_max.
 - drop pm *_max in mptcp_diag.c too.

v3:
 - add a new patch to drop *_max fields in mptcp_pm_data

v2:
 - drop the unused addr parameter in mptcp_nl_add_subflow_or_signal_addr
 - use the pernet *_max values in mptcp_pm_create_subflow_or_signal_addr
instead of the per-msk values.

Address issue 19 "let PM netlink update live sockets on local addresses
list change". The removed addresses part of this issue is done, this
patchset only implemented the added addresses part.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/19

Geliang Tang (5):
  mptcp: use WRITE_ONCE/READ_ONCE for the pernet *_max
  mptcp: drop *_max fields in mptcp_pm_data
  mptcp: create subflow or signal addr for newly added address
  selftests: mptcp: use minus values for removing address numbers
  selftests: mptcp: add testcases for newly added addresses

 net/mptcp/mptcp_diag.c                        |   6 +-
 net/mptcp/pm.c                                |   9 +-
 net/mptcp/pm_netlink.c                        | 150 +++++++++++++-----
 net/mptcp/protocol.h                          |   8 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 101 ++++++++++--
 5 files changed, 211 insertions(+), 63 deletions(-)

-- =

2.29.2

--===============5630518657908879600==--
