Content-Type: multipart/mixed; boundary="===============1487271929340661648=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 0/3] mptcp: create subflow or signal
Date: Wed, 16 Dec 2020 17:40:12 +0800
Message-ID: <cover.1608111058.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 7184

--===============1487271929340661648==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Address issue 19 "let PM netlink update live sockets on local addresses
list change". The removed addresses part of this issue is done, this
patchset only implemented the added addresses part.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/19

Geliang Tang (3):
  mptcp: create subflow or signal addr for newly added address
  selftests: mptcp: use minus value for removing address numbers
  selftests: mptcp: add testcases for newly added addresses

 net/mptcp/pm_netlink.c                        |  37 ++++++
 .../testing/selftests/net/mptcp/mptcp_join.sh | 105 +++++++++++++++---
 2 files changed, 125 insertions(+), 17 deletions(-)

-- =

2.29.2

--===============1487271929340661648==--
