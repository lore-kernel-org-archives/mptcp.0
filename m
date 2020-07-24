Content-Type: multipart/mixed; boundary="===============1341789416042442194=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next v4 00/12] DATA_FIN support
Date: Thu, 23 Jul 2020 18:11:15 -0700
Message-ID: <20200724011127.363638-1-mathew.j.martineau@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 5275

--===============1341789416042442194==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Here is a series adding full DATA_FIN support at connection shutdown /
close. See the patch 8 commit message for information about the
disconnection state machine.

Self tests are passing. Have now checked interoperation with the
mptcp_trunk branch.

v3 -> v4

 * Fix off-by-one error in outgoing DATA_FIN-only mappings, and in the
   corresponding receive side check. Addresses mptcp_trunk
   interoperability problem, where mptcp_trunk was not accepting the
   invalid DATA_FIN sequence number.

v2 -> v3

 * Fixed checkpatch issues

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

 net/mptcp/options.c  |  57 +++++++--
 net/mptcp/protocol.c | 295 ++++++++++++++++++++++++++++++++++++-------
 net/mptcp/protocol.h |   6 +-
 net/mptcp/subflow.c  |  14 +-
 4 files changed, 306 insertions(+), 66 deletions(-)


base-commit: 936cc81106499d2332697d82592ace2f54595ffe
-- =

2.27.0

--===============1341789416042442194==--
