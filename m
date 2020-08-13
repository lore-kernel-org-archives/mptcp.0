Content-Type: multipart/mixed; boundary="===============0551791950360659140=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next 0/3] add ADD_ADDR echo flag
 support
Date: Thu, 13 Aug 2020 18:59:36 +0800
Message-ID: <cover.1597316052.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 5550

--===============0551791950360659140==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

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
 net/mptcp/options.c                           | 33 +++++++++-----
 net/mptcp/pm.c                                |  1 +
 net/mptcp/pm_netlink.c                        |  1 +
 net/mptcp/protocol.h                          |  1 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 45 +++++++++++++++++++
 7 files changed, 74 insertions(+), 11 deletions(-)

-- =

2.17.1

--===============0551791950360659140==--
