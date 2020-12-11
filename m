Content-Type: multipart/mixed; boundary="===============4894996730476355398=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 0/2] add IPv4-mapped address support
Date: Fri, 11 Dec 2020 14:27:44 +0800
Message-ID: <cover.1607667912.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 7144

--===============4894996730476355398==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patchset added the IPv4-mapped address support and the testcases.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/122

Geliang Tang (2):
  mptcp: convert IPv4 address to IPv4-mapped
  selftests: mptcp: add IPv4-mapped IPv6 testcases

 net/mptcp/pm_netlink.c                        | 16 +++++++++
 .../testing/selftests/net/mptcp/mptcp_join.sh | 34 +++++++++++++++++++
 2 files changed, 50 insertions(+)

-- =

2.26.2

--===============4894996730476355398==--
