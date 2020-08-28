Content-Type: multipart/mixed; boundary="===============3546862915644759540=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v7 mptcp-next 0/4] add ADD_ADDR echo flag
 support
Date: Fri, 28 Aug 2020 15:16:00 +0800
Message-ID: <cover.1598598749.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 5653

--===============3546862915644759540==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

v7:
 - add accept_subflow re-check

v6:
 - add "drop re-check mechanism for PM's flags"

v5:
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

Geliang Tang (4):
  mptcp: send out ADD_ADDR with echo flag
  mptcp: add ADD_ADDR related mibs
  selftests: mptcp: add ADD_ADDR mibs check function
  mptcp: add accept_subflow re-check

 net/mptcp/mib.c                               |  2 +
 net/mptcp/mib.h                               |  2 +
 net/mptcp/options.c                           | 34 +++++++++-----
 net/mptcp/pm.c                                | 28 ++++++------
 net/mptcp/pm_netlink.c                        |  4 +-
 net/mptcp/protocol.h                          |  6 ++-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 44 +++++++++++++++++++
 7 files changed, 92 insertions(+), 28 deletions(-)

-- =

2.17.1

--===============3546862915644759540==--
