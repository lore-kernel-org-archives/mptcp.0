Content-Type: multipart/mixed; boundary="===============1443909742572719835=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v5 mptcp-next 0/3] add ADD_ADDR echo flag
 support
Date: Sun, 23 Aug 2020 00:44:20 +0800
Message-ID: <cover.1598114251.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 5597

--===============1443909742572719835==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

v5: =

 - move READ_ONCE(msk->pm.add_addr_echo) into mptcp_pm_add_addr_signal
 - move mptcp_pm_announce_addr into mptcp_pm_nl_add_addr_received and
   mptcp_pm_add_addr_received
v4:
 - Just updated some log messages in mptcp_join.sh

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
 net/mptcp/options.c                           | 34 +++++++++-----
 net/mptcp/pm.c                                | 14 ++++--
 net/mptcp/pm_netlink.c                        |  4 +-
 net/mptcp/protocol.h                          |  6 ++-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 44 +++++++++++++++++++
 7 files changed, 88 insertions(+), 18 deletions(-)

-- =

2.17.1

--===============1443909742572719835==--
