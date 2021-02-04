Content-Type: multipart/mixed; boundary="===============5996831123834960909=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 0/2] move to next addr and testcases
Date: Thu, 04 Feb 2021 17:04:55 +0800
Message-ID: <cover.1612429260.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 7618

--===============5996831123834960909==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tag: export/20210204T061905

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/151

Geliang Tang (2):
  mptcp: move to next addr when subflow creation fail
  selftests: mptcp: signal addresses testcases

 net/mptcp/options.c                           |  1 +
 net/mptcp/pm.c                                | 15 ++++++
 net/mptcp/pm_netlink.c                        | 13 +++++-
 net/mptcp/protocol.h                          |  4 ++
 .../testing/selftests/net/mptcp/mptcp_join.sh | 46 +++++++++++++++++++
 5 files changed, 77 insertions(+), 2 deletions(-)

-- =

2.29.2

--===============5996831123834960909==--
