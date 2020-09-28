Content-Type: multipart/mixed; boundary="===============4581940750210829494=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v3 mptcp-next 0/2] mptcp: add ADD_ADDR timeout
 test case and others
Date: Mon, 28 Sep 2020 14:51:50 +0800
Message-ID: <cover.1601275610.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 6065

--===============4581940750210829494==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

v3:
 - rename run_add_addr_timeout_tests to run_tests_slow, it can be reused in
   other test cases.

v2:
 - drop add_addr_echo sysctl in v1
 - use iptables rules to drop ADD_ADDR echo packets.

Geliang Tang (2):
  mptcp: add a new sysctl add_addr_timeout
  selftests: mptcp: add ADD_ADDR timeout test case

 net/mptcp/ctrl.c                              | 14 ++++++
 net/mptcp/pm_netlink.c                        |  8 +++-
 net/mptcp/protocol.h                          |  1 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 43 +++++++++++++++++--
 4 files changed, 61 insertions(+), 5 deletions(-)

-- =

2.17.1

--===============4581940750210829494==--
