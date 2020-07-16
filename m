Content-Type: multipart/mixed; boundary="===============0640537223818661179=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next 00/12] DATA_FIN support
Date: Wed, 15 Jul 2020 17:20:24 -0700
Message-ID: <20200716002036.705306-1-mathew.j.martineau@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 5024

--===============0640537223818661179==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Here is a series adding DATA_FIN support with these improvements
relative to the RFC patch:

 * Split in to a series
 * A few enhancements suggested by Paolo
 * Lots of fixes, including handling of fallback sockets and
   connections that are already doing the disconnect handshake before
   accept() even returns.
 * Self tests pass. I have not yet tested with mptcp_trunk...

See the patch 8 commit message for information about the disconnection
state machine.

The TCP fallback tests would hang at disconnect when I removed the
subflow EOF handling altogether. Instead I only enabled that code for
fallback sockets (see patch 9).

Mat Martineau (12):
  mptcp: Allow DATA_FIN in headers without TCP FIN
  mptcp: Return EPIPE if sending is shut down during a sendmsg
  mptcp: Add mptcp_close_state() helper
  mptcp: Track received DATA_FIN sequence number and add related helpers
  mptcp: Use MPTCP-level flag for sending DATA_FIN
  mptcp: Add helper to process acks of DATA_FIN
  mptcp: Send DATA_FIN in appropriate states during shutdown or close
  mptcp: Use full MPTCP-level disconnect state machine
  mptcp: Only use subflow EOF signaling on fallback connections
  mptcp: Skip unnecessary skb extension allocation for bare acks
  mptcp: Safely read sequence number when lock isn't held
  mptcp: Safely store sequence number when sending data

 net/mptcp/options.c  |  54 ++++++--
 net/mptcp/protocol.c | 301 ++++++++++++++++++++++++++++++++++++-------
 net/mptcp/protocol.h |   6 +-
 net/mptcp/subflow.c  |  14 +-
 4 files changed, 309 insertions(+), 66 deletions(-)


base-commit: 9389d1bcffad728d53fc5860d8201c14d1c86042
-- =

2.27.0

--===============0640537223818661179==--
