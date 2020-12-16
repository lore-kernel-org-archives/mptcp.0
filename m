Content-Type: multipart/mixed; boundary="===============4412437542201993535=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next 0/2] add IPv4-mapped address
 support
Date: Wed, 16 Dec 2020 15:14:23 +0800
Message-ID: <cover.1608102360.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 7181

--===============4412437542201993535==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patchset added the IPv4-mapped address support and the testcases.

v2:
 - v1 calls mptcp_pm_addr_convert_v4mapped in mptcp_pm_nl_add_addr_received,
on the receiving side. v2 calls it in select_signal_address, on the
sending side.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/122

Geliang Tang (2):
  mptcp: convert IPv4 address to IPv4-mapped
  selftests: mptcp: add IPv4-mapped IPv6 testcases

 net/mptcp/pm_netlink.c                        | 25 ++++++++++++--
 .../testing/selftests/net/mptcp/mptcp_join.sh | 34 +++++++++++++++++++
 2 files changed, 56 insertions(+), 3 deletions(-)

-- =

2.29.2

--===============4412437542201993535==--
