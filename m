Content-Type: multipart/mixed; boundary="===============7157224299068389829=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 00/12] Exchange MPTCP DATA_FIN/DATA_ACK
 before TCP FIN
Date: Tue, 28 Jul 2020 15:11:58 -0700
Message-ID: <20200728221210.92841-1-mathew.j.martineau@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 5347

--===============7157224299068389829==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series allows the MPTCP-level connection to be closed with the
peers exchanging DATA_FIN and DATA_ACK according to the state machine in
appendix D of RFC 8684. The process is very similar to the TCP
disconnect state machine. =


The prior code sends DATA_FIN only when TCP FIN packets are sent, and
does not allow for the MPTCP-level connection to be half-closed.

Patch 8 ("mptcp: Use full MPTCP-level disconnect state machine") is the
core of the series. Earlier patches in the series have some small fixes
and helpers in preparation, and the final four small patches do some
cleanup.


Mat Martineau (12):
  mptcp: Allow DATA_FIN in headers without TCP FIN
  mptcp: Return EPIPE if sending is shut down during a sendmsg
  mptcp: Remove outdated and incorrect comment
  mptcp: Use MPTCP-level flag for sending DATA_FIN
  mptcp: Track received DATA_FIN sequence number and add related helpers
  mptcp: Add mptcp_close_state() helper
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


base-commit: 0003041e7a0bf24594e5d66fe217bbbefdac44ab
-- =

2.28.0

--===============7157224299068389829==--
