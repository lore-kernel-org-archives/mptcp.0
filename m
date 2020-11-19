Content-Type: multipart/mixed; boundary="===============7596128798974334732=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 00/10] mptcp: More miscellaneous MPTCP fixes
Date: Thu, 19 Nov 2020 11:45:53 -0800
Message-ID: <20201119194603.103158-1-mathew.j.martineau@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 6840

--===============7596128798974334732==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Here's another batch of fixup and enhancement patches that we have
collected in the MPTCP tree.

Patch 1 removes an unnecessary flag and related code.

Patch 2 fixes a bug encountered when closing fallback sockets.

Patches 3 and 4 choose a better transmit subflow, with a self test.

Patch 5 adjusts tracking of unaccepted subflows

Patches 6-8 improve handling of long ADD_ADDR options, with a test.

Patch 9 more reliably tracks the MPTCP-level window shared with peers.

Patch 10 sends MPTCP-level acknowledgements more aggressively, so the
peer can send more data without extra delay.


Florian Westphal (3):
  mptcp: skip to next candidate if subflow has unacked data
  selftests: mptcp: add link failure test case
  mptcp: track window announced to peer

Geliang Tang (3):
  mptcp: change add_addr_signal type
  mptcp: send out dedicated ADD_ADDR packet
  selftests: mptcp: add ADD_ADDR IPv6 test cases

Paolo Abeni (4):
  mptcp: drop WORKER_RUNNING status bit
  mptcp: fix state tracking for fallback socket
  mptcp: keep unaccepted MPC subflow into join list
  mptcp: refine MPTCP-level ack scheduling

 include/net/mptcp.h                           |   3 +-
 net/ipv4/tcp_output.c                         |  11 +-
 net/mptcp/options.c                           |  48 ++++-
 net/mptcp/pm.c                                |  31 ++-
 net/mptcp/pm_netlink.c                        |  29 +++
 net/mptcp/protocol.c                          | 178 +++++++++---------
 net/mptcp/protocol.h                          |  44 ++++-
 net/mptcp/subflow.c                           |  14 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 174 ++++++++++++++---
 9 files changed, 391 insertions(+), 141 deletions(-)


base-commit: 657bc1d10bfc23ac06d5d687ce45826c760744f9
-- =

2.29.2

--===============7596128798974334732==--
