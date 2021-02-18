Content-Type: multipart/mixed; boundary="===============0577601617112190805=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v4 mptcp-next 0/2] move to next addr and
 testcases
Date: Thu, 18 Feb 2021 16:22:14 +0800
Message-ID: <cover.1613635984.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 7839

--===============0577601617112190805==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

v4:
 - use lookup_anno_list_by_saddr instead of lookup_subflow_by_saddr.
 - use MPTCP_PM_SUBFLOW_ESTABLISHED instead of MPTCP_PM_ESTABLISHED.

v3:
 - drop MPTCP_PM_NEXT_ADDR, use MPTCP_PM_ESTABLISHED instead.
 - hold the msk lock in mptcp_pm_add_addr_echoed.
 - tag: export/20210209T062213

v2:
 - add patch 2 and 3 for removing testcases.
 - tag: export/20210207T062839.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/151

Geliang Tang (2):
  mptcp: move to next addr when subflow creation fail
  selftests: mptcp: signal addresses testcases

 net/mptcp/options.c                           |  1 +
 net/mptcp/pm.c                                | 15 +++++
 net/mptcp/pm_netlink.c                        |  2 +-
 net/mptcp/protocol.h                          |  5 ++
 .../testing/selftests/net/mptcp/mptcp_join.sh | 58 +++++++++++++++++++
 5 files changed, 80 insertions(+), 1 deletion(-)

-- =

2.29.2

--===============0577601617112190805==--
