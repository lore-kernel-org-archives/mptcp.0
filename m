Content-Type: multipart/mixed; boundary="===============4211603487103647700=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v3 mptcp-next 0/4] move to next addr and
 testcases
Date: Tue, 09 Feb 2021 22:55:00 +0800
Message-ID: <cover.1612882099.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 7709

--===============4211603487103647700==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

v3:
 - drop MPTCP_PM_NEXT_ADDR, use MPTCP_PM_ESTABLISHED instead.
 - hold the msk lock in mptcp_pm_add_addr_echoed.
 - tag: export/20210209T062213

v2:
 - add patch 2 and 3 for removing testcases.
 - tag: export/20210207T062839.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/151

Geliang Tang (4):
  mptcp: move to next addr when subflow creation fail
  selftests: mptcp: add invert argument for chk_rm_nr
  selftests: mptcp: set addr id for removing testcases
  selftests: mptcp: signal addresses testcases

 net/mptcp/options.c                           |   1 +
 net/mptcp/pm.c                                |  18 +++
 net/mptcp/pm_netlink.c                        |   4 +-
 net/mptcp/protocol.h                          |   3 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 105 ++++++++++++++----
 5 files changed, 110 insertions(+), 21 deletions(-)

-- =

2.29.2

--===============4211603487103647700==--
