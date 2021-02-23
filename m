Content-Type: multipart/mixed; boundary="===============0750567829908006800=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next 0/4] move to next addr when
 timeout
Date: Tue, 23 Feb 2021 12:29:54 +0800
Message-ID: <cover.1614053997.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 7907

--===============0750567829908006800==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

v2:
 - invoke lookup_subflow_by_daddr in mptcp_pm_add_addr_received, not in
 mptcp_pm_nl_add_addr_received.
 - add a sanity check on cfg_do_w.

apply: export/20210222T184014
       move to next addr and testcases

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/151

Geliang Tang (4):
  mptcp: skip connecting the connected address
  mptcp: move to next addr when timeout
  selftests: mptcp: add cfg_do_w for cfg_remove
  selftests: mptcp: timeout testcases for multi addresses

 net/mptcp/pm.c                                |  3 ++-
 net/mptcp/pm_netlink.c                        | 23 +++++++++++++++-
 net/mptcp/protocol.h                          |  2 ++
 .../selftests/net/mptcp/mptcp_connect.c       | 10 ++++---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 26 +++++++++++++++++--
 5 files changed, 57 insertions(+), 7 deletions(-)

-- =

2.29.2

--===============0750567829908006800==--
