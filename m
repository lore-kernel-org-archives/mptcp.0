Content-Type: multipart/mixed; boundary="===============4555379499842712429=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next 0/3] mptcp: create subflow for
 newly added address and testcases
Date: Fri, 18 Dec 2020 23:24:53 +0800
Message-ID: <cover.1608304480.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 7217

--===============4555379499842712429==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

v2:
 - drop the unused addr parameter in mptcp_nl_add_subflow_or_signal_addr
 - use the pernet *_max values in mptcp_pm_create_subflow_or_signal_addr
instead of the per-msk values.

Address issue 19 "let PM netlink update live sockets on local addresses
list change". The removed addresses part of this issue is done, this
patchset only implemented the added addresses part.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/19

Geliang Tang (3):
  mptcp: create subflow or signal addr for newly added address
  selftests: mptcp: use minus value for removing address numbers
  selftests: mptcp: add testcases for newly added addresses

 net/mptcp/pm_netlink.c                        |  43 ++++++--
 .../testing/selftests/net/mptcp/mptcp_join.sh | 101 +++++++++++++++---
 2 files changed, 123 insertions(+), 21 deletions(-)

-- =

2.29.2

--===============4555379499842712429==--
