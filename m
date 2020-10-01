Content-Type: multipart/mixed; boundary="===============8788803435595738214=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v5 mptcp-next 0/2] mptcp: add ADD_ADDR timeout
 test case and others
Date: Thu, 01 Oct 2020 15:25:53 +0800
Message-ID: <cover.1601536190.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 6123

--===============8788803435595738214==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

v5:
 - fix nfbpf_compile dependence
 - add optional arguments for run_test, drop run_tests_slow and run_remove_=
tests
 - use 'slow/fast' in do_transfer

v4:
 - use proc_dointvec_jiffies instead of proc_douintvec.
 - use the reverse x-mas tree order.
 - update the 'config' file for netfilter.

v3:
 - rename run_add_addr_timeout_tests to run_tests_slow, it can be reused in
   other test cases.

v2:
 - drop add_addr_echo sysctl in v1
 - use iptables rules to drop ADD_ADDR echo packets.

Geliang Tang (2):
  mptcp: add a new sysctl add_addr_timeout
  selftests: mptcp: add ADD_ADDR timeout test case

 net/mptcp/ctrl.c                              | 14 ++++
 net/mptcp/pm_netlink.c                        |  8 +-
 net/mptcp/protocol.h                          |  1 +
 tools/testing/selftests/net/mptcp/config      |  6 ++
 .../testing/selftests/net/mptcp/mptcp_join.sh | 73 +++++++++++++------
 5 files changed, 76 insertions(+), 26 deletions(-)

-- =

2.26.2

--===============8788803435595738214==--
