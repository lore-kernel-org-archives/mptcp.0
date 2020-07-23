Content-Type: multipart/mixed; boundary="===============1282873984771475448=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next v2 00/12] DATA_FIN support
Date: Wed, 22 Jul 2020 17:32:07 -0700
Message-ID: <20200723003219.90547-1-mathew.j.martineau@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 5185

--===============1282873984771475448==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Here is a series adding full DATA_FIN support at connection shutdown /
close. See the patch 8 commit message for information about the
disconnection state machine.

Self tests are passing. Still need to check compatibility and review
wireshark traces when interacting with a mptcp_trunk peer.

v1 -> v2

Fixes from Paolo's review comments, including:

 * Squashed patch 8 (main functional changes for state machine) with the
   previous commit, since the split was causing extra churn and was
   misleading when trying to review.

 * Made more use of the mptcp_pending_data_fin helper. Also refactored
   that helper to optionally copy the read sequence number for the caller.

 * Fixed sequence number check off-by-one problem.

 * Removed redundant DATA_FIN sequence number checks in
   __mptcp_move_skbs_from_subflow().

 * Split commit 3 to clarify intentional comment removal.

RFC -> v1

 * Split in to a series

 * A few enhancements suggested by Paolo

 * Lots of fixes, including handling of fallback sockets and
   connections that are already doing the disconnect handshake before
   accept() even returns.

Mat Martineau (12):
  mptcp: Allow DATA_FIN in headers without TCP FIN
  mptcp: Return EPIPE if sending is shut down during a sendmsg
  mptcp: Remove outdated and incorrect comment
  mptcp: Add mptcp_close_state() helper
  mptcp: Track received DATA_FIN sequence number and add related helpers
  mptcp: Use MPTCP-level flag for sending DATA_FIN
  mptcp: Add helper to process acks of DATA_FIN
  mptcp: Use full MPTCP-level disconnect state machine
  mptcp: Only use subflow EOF signaling on fallback connections
  mptcp: Skip unnecessary skb extension allocation for bare acks
  mptcp: Safely read sequence number when lock isn't held
  mptcp: Safely store sequence number when sending data

 net/mptcp/options.c  |  54 ++++++--
 net/mptcp/protocol.c | 297 ++++++++++++++++++++++++++++++++++++-------
 net/mptcp/protocol.h |   6 +-
 net/mptcp/subflow.c  |  14 +-
 4 files changed, 305 insertions(+), 66 deletions(-)


base-commit: eeb83400421e0c1f9122a36936db2a6c42dc72c4
-- =

2.27.0

--===============1282873984771475448==--
