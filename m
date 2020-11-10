Content-Type: multipart/mixed; boundary="===============6136879552928116398=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 0/6] mptcp: just another complete datapath
 refactor
Date: Tue, 10 Nov 2020 12:25:42 +0100
Message-ID: <cover.1605006569.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 6644

--===============6136879552928116398==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series refactor once again the data path, with the
goal of avoding the worker usage for the fast path.

The worker will still be used to:
- cleanup closed subflows
- handle timeout
- retransmissions
- send the DATA_FIN/DATA_FIN ack. =

- fallback eof

The latters 2 use case could be fourther removed, if we accept/consider =

sending DATA_FIN/ack on a single subflow.

The code is still pretty much unstable - survives very basic tests
and don't complete yet a single self-test iteration, anyhow sharing
early to discuss a few design points.

- separate memory accunting for write memory in patch 1 is a required
  pre-req for patch 2, but also brings a bit of additional complexity
  in the following patches. I would be very happy to find any other
  alternative.

- in patch 3 we may end-up pre-allocating more-than-strictly-required
  skbs. Doing more accurate estimate would be nice, but I don't know
  how without adding even more complexity.
  Pre-allocating skbs is quite necessary, otherwise under memory
  pressure we may end-up copying data to kernel (in the msk write queue)
  but not being able later to allocate the required skbs at push_pending() =

  time and xmit will be stuck.

- I guess patch 6 could cause quite hard reaction upstream, if they will
  dare look inside. I like it ;)

Paolo Abeni (6):
  mptcp: separate accouting for wmem forward alloc mem
  mptcp: protect the rx path with the msk socket spinlock
  mptcp: allocate TX skbs in msk context.
  mptcp: avoid a few atomic ops in the rx path
  mptcp: simplify mptcp_nospace
  mptcp: use mptcp backlog.

 net/mptcp/mptcp_diag.c |   2 +-
 net/mptcp/options.c    |  47 ++--
 net/mptcp/protocol.c   | 606 +++++++++++++++++++++++++++++------------
 net/mptcp/protocol.h   |  25 +-
 net/mptcp/subflow.c    |  31 ++-
 5 files changed, 496 insertions(+), 215 deletions(-)

-- =

2.26.2

--===============6136879552928116398==--
