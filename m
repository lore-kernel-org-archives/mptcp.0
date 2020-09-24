Content-Type: multipart/mixed; boundary="===============5217489330095883758=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH net-next 00/16] mptcp: RM_ADDR/ADD_ADDR
 enhancements
Date: Thu, 24 Sep 2020 08:29:46 +0800
Message-ID: <cover.1600853093.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 5996

--===============5217489330095883758==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series include two enhancements for the MPTCP path management,
namely RM_ADDR support and ADD_ADDR echo support, as specified by RFC
sections 3.4.1 and 3.4.2.

1 RM_ADDR support include 9 patches (1-3 and 8-13):

Patch 1 is the helper for patch 2, these two patches add the RM_ADDR
outgoing functions, which are derived from ADD_ADDR's corresponding
functions.

Patch 3 adds the RM_ADDR incoming logic, when RM_ADDR suboption is
received, close the subflow matching the rm_id, and update PM counter.

Patch 8 is the main remove routine. When the PM netlink removes an address,
we traverse all the existing msk sockets to find the relevant sockets. Then
trigger the RM_ADDR signal and remove the subflow which using this local
address, this subflow removing functions has been implemented in patch 9.

Finally, patches 10-13 are the self-tests for RM_ADDR.

2 ADD_ADDR echo support include 7 patches (4-7 and 14-16).

Patch 4 adds the ADD_ADDR echo logic, when the ADD_ADDR suboption has been
received, send out the same ADD_ADDR suboption with echo-flag, and no HMAC
included.

Patches 5 and 6 are the self-tests for ADD_ADDR echo. Patch 7 is a little
cleaning up.

Patch 14 and 15 are the helpers for patch 16. These three patches add
the ADD_ADDR retransmition when no ADD_ADDR echo is received.

Geliang Tang (16):
  mptcp: rename addr_signal and the related functions
  mptcp: add the outgoing RM_ADDR support
  mptcp: add the incoming RM_ADDR support
  mptcp: send out ADD_ADDR with echo flag
  mptcp: add ADD_ADDR related mibs
  selftests: mptcp: add ADD_ADDR mibs check function
  mptcp: add accept_subflow re-check
  mptcp: remove addr and subflow in PM netlink
  mptcp: implement mptcp_pm_remove_subflow
  mptcp: add RM_ADDR related mibs
  mptcp: add mptcp_destroy_common helper
  selftests: mptcp: add remove cfg in mptcp_connect
  selftests: mptcp: add remove addr and subflow test cases
  mptcp: add struct mptcp_pm_add_entry
  mptcp: add sk_stop_timer_sync helper
  mptcp: retransmit ADD_ADDR when timeout

 include/net/sock.h                            |   2 +
 net/core/sock.c                               |   7 +
 net/mptcp/mib.c                               |   4 +
 net/mptcp/mib.h                               |   4 +
 net/mptcp/options.c                           |  81 +++--
 net/mptcp/pm.c                                |  91 ++++--
 net/mptcp/pm_netlink.c                        | 276 +++++++++++++++++-
 net/mptcp/protocol.c                          |  30 +-
 net/mptcp/protocol.h                          |  39 ++-
 net/mptcp/subflow.c                           |   3 +-
 .../selftests/net/mptcp/mptcp_connect.c       |  18 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 189 +++++++++++-
 12 files changed, 674 insertions(+), 70 deletions(-)

-- =

2.17.1

--===============5217489330095883758==--
