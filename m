Content-Type: multipart/mixed; boundary="===============8834275579873725854=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH mptcp-next 0/9] initial SOL_SOCKET support
Date: Wed, 17 Mar 2021 17:38:19 +0100
Message-ID: <20210317163828.27406-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 8190

--===============8834275579873725854==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch set improves support for several SOL_SOCKET tuneables.

First patch adds skeleton synchronization functions to copy mptcp socket
settings to a subflow socket.

For the incoming connection case a work queue based synchronization
point is added.

A sequence number tells which subflows are out-of-sync and need
updating.

setsockopt SOL_SOCKET gets extended to handle several
tuneables.

Some of these get copied to all subflows:
- keepalive
- packet mark (influences routing decision)
- SO_LINGER

Others are only set on the initial socket, e.g.
BINDTODEVICE.

Some of these are debateable, for instance SO_INCOMING_CPU.

Last two patches add support for two TCP sockopts, TCP_CONGESTION
and TCP_INFO.

The former is only set for the initial subflow, since that is what
userspace program knows about (bind/connect address).

It seems better to allow mptcpd/iproute2 to augment subflows
with TCPcc info instead.

TCP_INFO is another item open for debate.
The patch here will take the TCP info from the subflow that was
last used to send data.

This may not be what is expected, however.
Since the struct format is fixed, there are not many alternatives:
1. - always fail with -EOPNOTSUPP
2. - try to artificially synthesize TCP_INFO record based on mptcp
level sequence numbers, etc.
3. - always follow the initial subflow only.

Comments welcome.

Furthermore, support for various SO_TIMESTAMP* settings will need
cmsg support in mptcp to be useful.  Let me know if anyone is already
looking at that.

Florian Westphal (9):
  mptcp: add skeleton to sync msk socket options to subflows
  mptcp: setsockopt: handle SO_KEEPALIVE and SO_PRIORITY
  mptcp: setsockopt: handle receive/send buffer and device bind
  mptcp: setsockopt: support SO_LINGER
  mptcp: setsockopt: add SO_MARK support
  mptcp: setsockopt: add SO_INCOMING_CPU
  mptcp: setsockopt: SO_DEBUG and no-op options
  mptcp: sockopt: add TCP_CONGESTION
  mptcp: sockopt: handle TCP_INFO

 net/mptcp/protocol.c |  31 +++-
 net/mptcp/protocol.h |  12 ++
 net/mptcp/sockopt.c  | 431 +++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/subflow.c  |   1 +
 4 files changed, 472 insertions(+), 3 deletions(-)

-- =

2.26.2

--===============8834275579873725854==--
