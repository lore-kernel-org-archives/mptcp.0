Content-Type: multipart/mixed; boundary="===============3192649854286555401=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net 0/2] mptcp: Fix for 32-bit DATA_FIN
Date: Tue, 29 Sep 2020 15:08:18 -0700
Message-ID: <20200929220820.278003-1-mathew.j.martineau@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 6101

--===============3192649854286555401==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


The main fix is contained in patch 2, and that commit message explains
the issue with not properly converting truncated DATA_FIN sequence
numbers sent by the peer.

With patch 2 adding an unlocked read of msk->ack_seq, patch 1 cleans up
access to that data with READ_ONCE/WRITE_ONCE.


This does introduce two merge conflicts with net-next, but both have
straightforward resolution. Patch 1 modifies a line that got removed in
net-next so the modification can be dropped when merging. Patch 2 will
require a trivial conflict resolution for a modified function
declaration.


Mat Martineau (2):
  mptcp: Consistently use READ_ONCE/WRITE_ONCE with msk->ack_seq
  mptcp: Handle incoming 32-bit DATA_FIN values

 net/mptcp/options.c  | 11 ++++++-----
 net/mptcp/protocol.c |  8 ++++----
 net/mptcp/protocol.h |  2 +-
 net/mptcp/subflow.c  | 16 +++++++++++++---
 4 files changed, 24 insertions(+), 13 deletions(-)


base-commit: c92a79829c7c169139874aa1d4bf6da32d10c38a
-- =

2.28.0

--===============3192649854286555401==--
