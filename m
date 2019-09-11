Content-Type: multipart/mixed; boundary="===============2011920284058343725=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 0/7] mptcp: implement retransmit infrastructure
Date: Wed, 11 Sep 2019 14:55:34 +0200
Message-ID: <cover.1568206133.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 1818

--===============2011920284058343725==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The retransmission infrastructure is now functionally completed, and I don't
observe anymore memleak/socket reference leak.

Still there are a few self-test failures I still have to investigate.
I *think* we could merge this series even with such failure pending, and fix
them later, _if_ there is agreement.

v1 -> v2
- rebased on top of "mptcp: remove token_release"
- handle unacked sequence update collision with a loop, as suggested by Mat

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

 net/mptcp/options.c  |  47 ++++-
 net/mptcp/protocol.c | 396 +++++++++++++++++++++++++++++++++++++++----
 net/mptcp/protocol.h |  41 +++++
 3 files changed, 446 insertions(+), 38 deletions(-)

-- =

2.21.0


--===============2011920284058343725==--
