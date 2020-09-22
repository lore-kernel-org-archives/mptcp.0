Content-Type: multipart/mixed; boundary="===============9153780740990066897=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 0/3] mptcp: add ADD_ADDR timeout
 test case
Date: Tue, 22 Sep 2020 16:12:50 +0800
Message-ID: <cover.1600762109.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 5979

--===============9153780740990066897==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patchset added two new sysctls and ADD_ADDR timeout test case.

Geliang Tang (3):
  mptcp: add add_addr_echo sysctl
  mptcp: add add_addr_timeout sysctl
  selftests: mptcp: add ADD_ADDR timeout test case

 net/mptcp/ctrl.c                              | 28 +++++++++++++
 net/mptcp/pm.c                                |  9 +++--
 net/mptcp/pm_netlink.c                        | 12 ++++--
 net/mptcp/protocol.h                          |  2 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 39 +++++++++++++++++--
 5 files changed, 81 insertions(+), 9 deletions(-)

-- =

2.17.1

--===============9153780740990066897==--
