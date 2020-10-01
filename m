Content-Type: multipart/mixed; boundary="===============6449382574474930704=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 00/13] mptcp: support for queuing data at
 mptcp-level
Date: Thu, 01 Oct 2020 16:08:01 +0200
Message-ID: <cover.1601552158.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 6127

--===============6449382574474930704==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is necessary to cope correctly with large sendbuffer (larger then snd =
wnd)
while respecting the MPTCP level snd window.

A major rework of both xmit and shudown path is required to support this
feature (patches 8 and 9). To try to keep the related patches as small as
possible, a bunch of new helpers is created by patches 3-7.
Note that patch 5 can stand for it's own merit and possibly be upstreamed s=
oon.

Finally patch 10 uses the MPTCP equivalent of tcp_push_pending_frames(), to
spool queued data ad MPTCP level, as soon as the windows allow that.

This iteration includes a few additional fixes (patches 1,2,13) which make =
the
self-tests much more stable, even if likely some bug is still there.

Note that patches 1 and 2 are bugfixes for the current upstream tree will
target -net/-net-next soon.

Patch 13 is possibly a bit too aggressive, perhaps it could be left staging
in export branch for a while.  =


Not strictily related to this series: we currently send DATA_FIN ack only o=
nce
- the behaviour is not change here. If that is dropped, we will never
retransmit, and the peer will be stuck.

Florian Westphal (2):
  mptcp: rework poll+nospace handling
  mptcp: keep track of advertised windows right edge

Paolo Abeni (11):
  mptcp: more DATA FIN fixes
  mptcp: don't skip needed ack
  tcp: factor out __tcp_close() helper
  mptcp: introduce mptcp_schedule_work
  mptcp: reduce the arguments of mptcp_sendmsg_frag
  mptcp: add accounting for pending data
  mptcp: introduce MPTCP snd_nxt
  mptcp: refactor shutdown and close
  mptcp: move page frag allocation in mptcp_sendmsg()
  mptcp: try to push pending data on snd una updates
  mptcp: send explicit ack on delayed ack_seq incr

 include/net/tcp.h    |   1 +
 net/ipv4/tcp.c       |   9 +-
 net/mptcp/options.c  |  34 +-
 net/mptcp/pm.c       |   4 +-
 net/mptcp/protocol.c | 908 +++++++++++++++++++++++++------------------
 net/mptcp/protocol.h |  69 +++-
 net/mptcp/subflow.c  |  34 +-
 7 files changed, 644 insertions(+), 415 deletions(-)

-- =

2.26.2

--===============6449382574474930704==--
