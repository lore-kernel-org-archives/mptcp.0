Content-Type: multipart/mixed; boundary="===============1369259694551031660=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v3 mptcp-next 0/2] add IPv4-mapped address
 support
Date: Fri, 18 Dec 2020 19:17:33 +0800
Message-ID: <cover.1608289899.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 7213

--===============1369259694551031660==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patchset added the IPv4-mapped address support and the testcases.

v3:
 - add Matt's code in it.
 - deal with the IPv4-mapped back to IPv4 case too.
 - add two new IPv4-mapped back to IPv4 testcases.

v2:
 - v1 calls mptcp_pm_addr_convert_v4mapped in mptcp_pm_nl_add_addr_received,
on the receiving side. v2 calls it in select_signal_address, on the
sending side.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/122


Geliang Tang (2):
  mptcp: convert IPv4 address with IPv4-mapped address
  selftests: mptcp: add IPv4-mapped IPv6 testcases

 net/mptcp/pm_netlink.c                        | 21 ++++----
 net/mptcp/subflow.c                           | 22 +++++---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 51 +++++++++++++++++++
 3 files changed, 78 insertions(+), 16 deletions(-)

-- =

2.29.2

--===============1369259694551031660==--
