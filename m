Content-Type: multipart/mixed; boundary="===============4554609871144903031=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 0/5] MPTCP: IPv4-mapped IPv6 addressing for
 subflows
Date: Mon, 25 Jan 2021 10:58:59 -0800
Message-ID: <20210125185904.6997-1-mathew.j.martineau@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 7476

--===============4554609871144903031==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch series from the MPTCP tree adds support for IPv4-mapped IPv6
addressing that was missing when multiple subflows were first
implemented.

Patches 1 and 2 handle the conversion and comparison of the mapped
addresses.

Patch 3 contains a minor refactor in the path manager's handling of
addresses.

Patches 4 and 5 add selftests for the new functionality and adjust the
selftest timeout.


Geliang Tang (1):
  selftests: mptcp: add IPv4-mapped IPv6 testcases

Matthieu Baerts (4):
  mptcp: support MPJoin with IPv4 mapped in v6 sk
  mptcp: pm nl: support IPv4 mapped in v6 addresses
  mptcp: pm nl: reduce variable scope
  selftests: increase timeout to 10 min

 net/mptcp/pm_netlink.c                        | 39 +++++++---
 net/mptcp/subflow.c                           | 24 ++++--
 .../testing/selftests/net/mptcp/mptcp_join.sh | 75 +++++++++++++++++++
 tools/testing/selftests/net/mptcp/settings    |  2 +-
 4 files changed, 120 insertions(+), 20 deletions(-)


base-commit: a61e4b60761fa7fa2cfde6682760763537ce5549
-- =

2.30.0
--===============4554609871144903031==--
