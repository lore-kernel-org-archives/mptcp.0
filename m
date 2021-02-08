Content-Type: multipart/mixed; boundary="===============4888017605510720352=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next 0/4] move to next addr and
 testcases
Date: Mon, 08 Feb 2021 22:44:08 +0800
Message-ID: <cover.1612795124.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 7668

--===============4888017605510720352==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

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
 net/mptcp/pm.c                                |  15 +++
 net/mptcp/pm_netlink.c                        |  13 ++-
 net/mptcp/protocol.h                          |   4 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 105 ++++++++++++++----
 5 files changed, 117 insertions(+), 21 deletions(-)

-- =

2.29.2

--===============4888017605510720352==--
