Content-Type: multipart/mixed; boundary="===============3967984798406643965=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v5 mptcp-next 0/3] move to next addr and
 testcases
Date: Fri, 19 Feb 2021 11:08:01 +0800
Message-ID: <cover.1613703548.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 7856

--===============3967984798406643965==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

v5:
 - rename lookup_anno_list_by_saddr to mptcp_lookup_anno_list_by_saddr.

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

Geliang Tang (3):
  mptcp: export lookup_anno_list_by_saddr
  mptcp: move to next addr when subflow creation fail
  selftests: mptcp: signal addresses testcases

 net/mptcp/options.c                           |  1 +
 net/mptcp/pm.c                                | 15 +++++
 net/mptcp/pm_netlink.c                        | 10 ++--
 net/mptcp/protocol.h                          |  5 ++
 .../testing/selftests/net/mptcp/mptcp_join.sh | 58 +++++++++++++++++++
 5 files changed, 84 insertions(+), 5 deletions(-)

-- =

2.29.2

--===============3967984798406643965==--
