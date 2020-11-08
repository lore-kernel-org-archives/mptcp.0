Content-Type: multipart/mixed; boundary="===============3373284889970314584=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 0/4] Squash to "ADD_ADDR: ports
 support v3"
Date: Sun, 08 Nov 2020 22:43:43 +0800
Message-ID: <cover.1604845519.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 6580

--===============3373284889970314584==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patchset includes three squash-to patches and a new patch. They all
should be squashed into the "ADD_ADDR: ports support" series.

All three squash-to patches's commit massages need to be updated.

The new patch should be inserted into the patchset after the 8th patch
"mptcp: print out port and ahmac when receiving ADD_ADDR".


Geliang Tang (4):
  Squash to "mptcp: add port support for ADD_ADDR suboption writing"
  mptcp: add port number check for MP_JOIN
  Squash to "mptcp: add the mib for ADD_ADDR with port"
  Squash to "selftests: mptcp: add testcases for ADD_ADDR with port"

 net/mptcp/mib.c                               |  3 +
 net/mptcp/mib.h                               |  3 +
 net/mptcp/options.c                           | 17 +++---
 net/mptcp/pm_netlink.c                        | 12 ++++
 net/mptcp/protocol.h                          |  1 +
 net/mptcp/subflow.c                           | 37 ++++++++++++
 .../testing/selftests/net/mptcp/mptcp_join.sh | 56 ++++++++++++++++---
 7 files changed, 114 insertions(+), 15 deletions(-)

-- =

2.26.2

--===============3373284889970314584==--
