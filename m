Content-Type: multipart/mixed; boundary="===============1312725469246662475=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 0/7] mptcp: implement retransmit infrastructure
Date: Fri, 30 Aug 2019 17:03:55 +0200
Message-ID: <cover.1567177393.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 1771

--===============1312725469246662475==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is the first submission aming at git repo inclusion. It includes sever=
al
clean-ups, and covers feedback from Mat about una_seq updates and 32 bit
expansion.

In my testbet it survived a good number of self-tests iteration, but I can't
exclude more bugs are pending.

Please see the individual patches for the detailed changelog

RFC v2 -> v1
- update msk una_seq in tcp_incoming_options() and drop old patch 3/8
- cleanup timer management
- cleanup dfrag management

Paolo Abeni (7):
  mptcp: move before/after64 into the header file
  mptcp: update per unacked sequence on pkt reception
  mptcp: queue data for mptcp level retransmission
  mptcp: introduce MPTCP retransmission timer
  mptcp: implement memory accounting for mptcp rtx queue
  mptcp: rework mptcp_sendmsg_frag to accept optional dfrag
  mptcp: implement and use MPTCP-level retransmission

 net/mptcp/options.c  |  40 ++++-
 net/mptcp/protocol.c | 395 +++++++++++++++++++++++++++++++++++++++----
 net/mptcp/protocol.h |  41 +++++
 3 files changed, 439 insertions(+), 37 deletions(-)

-- =

2.21.0


--===============1312725469246662475==--
