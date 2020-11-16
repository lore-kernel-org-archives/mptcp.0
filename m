Content-Type: multipart/mixed; boundary="===============2460926881181911453=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 0/3] Squash to "ADD_ADDR: ports
 support v4"
Date: Mon, 16 Nov 2020 12:30:58 +0800
Message-ID: <cover.1605500515.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 6734

--===============2460926881181911453==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patchset includes a squash-to patch and two new patch. They all
should be squashed into the "ADD_ADDR: ports support v4" series.

The first new patch should be inserted into the patchset after the 8th
patch "mptcp: print out port and ahmac when receiving ADD_ADDR".

The second new patch should be inserted into the patchset after the 9th
patch "mptcp: add port number check for MP_JOIN".

Geliang Tang (3):
  mptcp: create listening socket for new port
  mptcp: add new flag listen_new_port
  Squash to "selftests: mptcp: add testcases for ADD_ADDR with port"

 net/mptcp/pm_netlink.c                        |  3 +
 net/mptcp/protocol.h                          |  4 +-
 net/mptcp/subflow.c                           | 59 +++++++++++++++----
 .../testing/selftests/net/mptcp/mptcp_join.sh | 29 ++++++---
 4 files changed, 77 insertions(+), 18 deletions(-)

-- =

2.26.2

--===============2460926881181911453==--
