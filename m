Content-Type: multipart/mixed; boundary="===============1509346084400998798=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next v2 00/13] mptcp: improve multiple xmit
 streams support
Date: Thu, 12 Nov 2020 18:45:20 +0100
Message-ID: <cover.1605199807.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 6690

--===============1509346084400998798==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series improves MPTCP handling of multiple concurrent
xmit streams.

The to-be-transmitted data is enqueued to a subflow only when
the send window is open, keeping the subflows xmit queue shorter
and allowing for faster switch-over.

The above requires a more accurate msk socket state tracking
and some additional infrastructure to allow pushing the data
pending in the msk xmit queue as soon as the MPTCP's send window
opens (patches 6-10).

As a side effect, the MPTCP socket could enqueue data to subflows
after close() time - to completely spooling the data sitting in the =

msk xmit queue. Dealing with the requires some infrastructure and =

core TCP changes (patches 1-5)

Finally, patches 11-12 introduce a more accurate tracking of the other
end's receive window.

Overall this refactor the MPTCP xmit path, without introducing
new features - the new code is covered by the existing self-tests.

v1 -> v2:
 - this is just a report, to cope with patchwork issues, no changes
   at all

Florian Westphal (2):
  mptcp: rework poll+nospace handling
  mptcp: keep track of advertised windows right edge

Paolo Abeni (11):
  tcp: factor out tcp_build_frag()
  mptcp: use tcp_build_frag()
  tcp: factor out __tcp_close() helper
  mptcp: introduce mptcp_schedule_work
  mptcp: reduce the arguments of mptcp_sendmsg_frag
  mptcp: add accounting for pending data
  mptcp: introduce MPTCP snd_nxt
  mptcp: refactor shutdown and close
  mptcp: move page frag allocation in mptcp_sendmsg()
  mptcp: try to push pending data on snd una updates
  mptcp: send explicit ack on delayed ack_seq incr

 include/net/tcp.h      |   4 +
 net/ipv4/tcp.c         | 128 +++---
 net/mptcp/options.c    |  30 +-
 net/mptcp/pm.c         |   3 +-
 net/mptcp/pm_netlink.c |   6 +-
 net/mptcp/protocol.c   | 969 ++++++++++++++++++++++++-----------------
 net/mptcp/protocol.h   |  72 ++-
 net/mptcp/subflow.c    |  33 +-
 8 files changed, 758 insertions(+), 487 deletions(-)

-- =

2.26.2

--===============1509346084400998798==--
