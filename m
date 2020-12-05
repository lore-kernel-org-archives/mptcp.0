Content-Type: multipart/mixed; boundary="===============5854921072297964159=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next 0/2] mptcp: add the address ID
 assignment bitmap and testcase
Date: Sat, 05 Dec 2020 21:37:10 +0800
Message-ID: <cover.1607174930.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 7059

--===============5854921072297964159==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

v2:
 - use BITS_PER_LONG macro.
 - add back the callback argument in cmd_dump_addrs.
 - add a testcase.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/117

Geliang Tang (2):
  mptcp: add the address ID assignment bitmap
  selftests: mptcp: add testcase for setting the address ID

 net/mptcp/pm_netlink.c                        | 60 +++++++++++++------
 .../testing/selftests/net/mptcp/pm_netlink.sh | 25 +++++++-
 2 files changed, 64 insertions(+), 21 deletions(-)

-- =

2.26.2

--===============5854921072297964159==--
