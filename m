Content-Type: multipart/mixed; boundary="===============9028426084465976993=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v4 mptcp-next 0/2] mptcp: add ADD_ADDR timeout
 test case and others
Date: Wed, 30 Sep 2020 16:50:42 +0800
Message-ID: <cover.1601455568.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 6107

--===============9028426084465976993==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

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

 net/mptcp/ctrl.c                              | 14 ++++++
 net/mptcp/pm_netlink.c                        |  8 +++-
 net/mptcp/protocol.h                          |  1 +
 tools/testing/selftests/net/mptcp/config      |  6 +++
 .../testing/selftests/net/mptcp/mptcp_join.sh | 43 +++++++++++++++++--
 5 files changed, 67 insertions(+), 5 deletions(-)

-- =

2.26.2

--===============9028426084465976993==--
