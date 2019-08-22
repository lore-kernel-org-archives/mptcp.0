Content-Type: multipart/mixed; boundary="===============3109970053009774761=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH v2 0/8] mptcp: implement retransmit infrastructure
Date: Thu, 22 Aug 2019 15:47:37 +0200
Message-ID: <cover.1566481012.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 1666

--===============3109970053009774761==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Note this is still early draft, only lightly tested. It builds and somtimes
it passes the selftests

In addition to the first iteration now:
- implement actual retransmission infrastructure and trigger it when MPTCP
  timer expires (patches 7,8)
- fixes several bugs in many patches - but others are still there

RFC v1:
- updates the MPTCP unacked sequence number (patches 1-3) on sendmsg()
  - also try to cope with 32 bit sequence number
- queue data (page frags) in MPTCP retransmission queue
- cleanup acked data from retransmission queue and schedule a timeout to
   update MPTCP unacked sequence number (patch 5)

Open points:
- IIRC, the RFC mandate to always retransmit even on the failing subflow (?=
!?)
  why? Should we preserve the original subflow seq number, so that
  retransmission there will get the same mapping as the original packet?

Paolo Abeni (8):
  mptcp: move before/after64 into the header file
  mptcp: update per subflow unacked sequence on pkt reception
  mptcp: update msk unacked sequence in sendmsg()
  mptcp: queue data for mptcp level retransmission
  mptcp: use retransmission timer to update msk una
  mptcp: implement memory accounting for mptcp rtx queue
  mptcp: rework mptcp_sendmsg_frag to accept optional dfrag
  mptcp: implement and use MPTCP-level retransmission

 net/mptcp/options.c  |  31 +++-
 net/mptcp/protocol.c | 405 +++++++++++++++++++++++++++++++++++++++----
 net/mptcp/protocol.h |  41 +++++
 3 files changed, 437 insertions(+), 40 deletions(-)

-- =

2.21.0


--===============3109970053009774761==--
