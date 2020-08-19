Content-Type: multipart/mixed; boundary="===============7632764147065811125=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v3 mptcp-next 0/3] add ADD_ADDR echo flag
 support
Date: Wed, 19 Aug 2020 14:19:33 +0800
Message-ID: <cover.1597817375.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 5573

--===============7632764147065811125==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

v3:
 - move add_addr_echo into mptcp_pm_announce_addr()
 - check return value of mptcp_pm_add_add_received
 - hold lock for add_addr_echo writing

v2:
 - add ADD_ADDR mibs
 - add selftests for ADD_ADDR

v1:
 - mptcp: send out ADD_ADDR with echo flag

Geliang Tang (3):
  mptcp: send out ADD_ADDR with echo flag
  mptcp: add ADD_ADDR related mibs
  selftests: mptcp: add ADD_ADDR mibs check function

 net/mptcp/mib.c                               |  2 +
 net/mptcp/mib.h                               |  2 +
 net/mptcp/options.c                           | 38 +++++++++++-----
 net/mptcp/pm.c                                | 13 ++++--
 net/mptcp/pm_netlink.c                        |  2 +-
 net/mptcp/protocol.h                          |  8 ++--
 .../testing/selftests/net/mptcp/mptcp_join.sh | 44 +++++++++++++++++++
 7 files changed, 89 insertions(+), 20 deletions(-)

-- =

2.17.1

--===============7632764147065811125==--
