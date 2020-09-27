Content-Type: multipart/mixed; boundary="===============5026501620179825960=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next 0/2] mptcp: add ADD_ADDR timeout
 test case and others
Date: Sun, 27 Sep 2020 12:38:37 +0800
Message-ID: <cover.1601181105.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 6058

--===============5026501620179825960==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

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

--===============5026501620179825960==--
