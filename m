Content-Type: multipart/mixed; boundary="===============5170112647898363106=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v3 00/13] mptcp: support for queuing data at
 mptcp-level
Date: Fri, 02 Oct 2020 11:26:10 +0200
Message-ID: <cover.1601630384.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 6151

--===============5170112647898363106==
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

Patches 1 and 2 are bugfixes for the current upstream tree will
target -net/-net-next soon.

Patch 13 is possibly a bit too aggressive, perhaps it could be left staging
in export branch for a while.

This iteration fixes all known pending issue present in previous snapshow.
Note that we still hit some unexpected out of receive window events, but the
issue was already present in the export branch and its fix is unrelated to
this work.

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
 net/mptcp/options.c  |  40 +-
 net/mptcp/pm.c       |   3 +-
 net/mptcp/protocol.c | 909 +++++++++++++++++++++++++------------------
 net/mptcp/protocol.h |  69 +++-
 net/mptcp/subflow.c  |  34 +-
 7 files changed, 648 insertions(+), 417 deletions(-)

-- =

2.26.2

--===============5170112647898363106==--
