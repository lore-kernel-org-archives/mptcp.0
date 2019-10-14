Content-Type: multipart/mixed; boundary="===============1026594440533600778=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC 0/6] mptcp: sendmsg scheduler skeleton
Date: Tue, 15 Oct 2019 01:19:13 +0200
Message-ID: <20191014231919.2454-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 2122

--===============1026594440533600778==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch series adds minimal support for multiple subflows on
the writer side.

Instead of always picking the first ssk (and reliance on tcp to block
the mptcp sendmsg in case the subflows write buffer is full),
grab a suitable/writeable subflow from the list.

The main point here isn't the 'chose the right subflow' strategy,
we will likely want to adapt/change it later -- but the handling
of the 'no suitable subflows present' case.

See patch #6 for details on how userspace is blocked/unblocked.

Patch #2 is silly but needed until subflows are expected to close
the connection on the mptcp level rather than relying on tcp fin.

Paolo, please also have a closr look at patch 5 since it impacts the
retransmission strategy: no more mptcp-level retransmissions if
ssk still has skbs in its write queue.

At this time, there is a theoretical problem remaining:

1. userspace calls poll(POLLOUT), one subflow available -> POLLOUT revent
2. retransmission kicks in and fills subflow
3. userspace calls write(), which might block even though poll() said
   otherwise

This is unlikely because most programs will not mix blocking IO with
event driven (select/poll/epoll) models.

But still, its something to keep in mind -- might be enough to
prevent retrans from using up the entire write queue for instance.

 include/net/tcp.h    |    1
 net/ipv4/tcp.c       |   12 ++-
 net/mptcp/protocol.c |  154 ++++++++++++++++++++++++++++++++++++++++++++++=
+----
 net/mptcp/protocol.h |    2
 net/mptcp/subflow.c  |   46 +++++++++++++--
 5 files changed, 197 insertions(+), 18 deletions(-)

--===============1026594440533600778==--
