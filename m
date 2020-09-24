Content-Type: multipart/mixed; boundary="===============0916458516259620351=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 0/8] mptcp: support for queuing data at mptcp-level
Date: Thu, 24 Sep 2020 15:59:22 +0200
Message-ID: <cover.1600955407.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 6015

--===============0916458516259620351==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is necessary to cope correctly with large sendbuffer (larger then snd =
wnd)
while respecting the MPTCP level snd window.

A major rework of both xmit and shudown path is required to support this
feature (patches 6 and 7). To try to keep the related patches as small as
possible, a bunch of new helpers is created by patches 1-5.
Note that patch 3 can stand for it's own merit and possibly be upstreamed s=
oon.

Finally patch 8 uses the MPTCP equivalent of tcp_push_pending_frames(), to
spool queued data ad MPTCP level, as soon as the windows allow that.

This is still more than a bit rough, and not all self-tests currently pass =
in
my local testbed, but the major issues should have been addressed.

Specifically the race described in:

https://lists.01.org/hyperkitty/list/mptcp(a)lists.01.org/message/JC7GTZHEK=
I6A3WHQKAWF3SYUSBEU5DYM/

is addressed by patch 6.

As usual any comments more than welcome!

Note: some patches include [partial] changelog, because this already went
through some private iterations.

Paolo Abeni (8):
  tcp: factor out __tcp_close() helper
  mptcp: introduce mptcp_schedule_work
  mptcp: reduce the arguments of mptcp_sendmsg_frag
  mptcp: add accounting for pending data
  mptcp: introduce MPTCP snd_nxt
  mptcp: refactor shutdown and close
  mptcp: move page frag allocation in mptcp_sendmsg()
  mptcp: try to push pending data on snd una updates

 include/net/tcp.h    |   1 +
 net/ipv4/tcp.c       |   9 +-
 net/mptcp/options.c  |   4 +-
 net/mptcp/pm.c       |   4 +-
 net/mptcp/protocol.c | 729 ++++++++++++++++++++++++-------------------
 net/mptcp/protocol.h |  60 +++-
 net/mptcp/subflow.c  |  21 +-
 7 files changed, 482 insertions(+), 346 deletions(-)

-- =

2.26.2

--===============0916458516259620351==--
