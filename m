Content-Type: multipart/mixed; boundary="===============0642542890278501987=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 0/4] move to next addr when timeout
Date: Mon, 22 Feb 2021 11:50:52 +0800
Message-ID: <cover.1613965565.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 7876

--===============0642542890278501987==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

apply: tag: export/20210218T061505
       move to next addr and testcases

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/151

Geliang Tang (4):
  mptcp: skip connecting the connected address
  mptcp: move to next addr when timeout
  selftests: mptcp: add cfg_do_w for cfg_remove
  selftests: mptcp: timeout testcases for multi addresses

 net/mptcp/pm_netlink.c                        | 25 ++++++++++++++++++
 .../selftests/net/mptcp/mptcp_connect.c       |  8 +++---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 26 +++++++++++++++++--
 3 files changed, 54 insertions(+), 5 deletions(-)

-- =

2.29.2

--===============0642542890278501987==--
