Content-Type: multipart/mixed; boundary="===============2442127217391222345=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 0/6] MPTCP: improve fallback to TCP
Date: Mon, 29 Jun 2020 22:26:19 +0200
Message-ID: <cover.1593461586.git.dcaratti@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4850

--===============2442127217391222345==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

there are situations where MPTCP sockets should fall-back to regular TCP:
this series reworks the fallback code to pursue the following goals:

1) cleanup the non fallback code, removing most of 'if (<fallback>)' in
   the data path
2) improve performance for non-fallback sockets, avoiding locks in poll()

further work will also leverage on this changes to achieve:

a) more consistent behavior of gestockopt()/setsockopt() on passive sockets
   after fallback
b) support for "infinite maps" as per RFC8684, section 3.7

the series is made of the following items:

- patch 1 lets sendmsg() / recvmsg() / poll() use the main socket also
  after fallback
- patch 2 fixes 'simultaneous connect' scenario after fallback. The
  problem was present also before the rework, but the fix is much easier
  to implement after patch 1
- patch 3, 4, 5 are clean-ups for code that is no more needed after the
  fallback rework
- patch 6 fixes a race condition between close() and poll(). The problem
  was theoretically present before the rework, but it became almost
  systematic after patch 1

Davide Caratti (2):
  net: mptcp: improve fallback to TCP
  mptcp: fallback in case of simultaneous connect

Paolo Abeni (4):
  mptcp: check for plain TCP sock at accept time
  mptcp: create first subflow at msk creation time
  mptcp: __mptcp_tcp_fallback() returns a struct sock
  mptcp: close poll() races

 net/mptcp/options.c  |   9 +-
 net/mptcp/protocol.c | 267 ++++++++++++++-----------------------------
 net/mptcp/protocol.h |  43 +++++++
 net/mptcp/subflow.c  |  57 ++++++---
 4 files changed, 175 insertions(+), 201 deletions(-)

-- =

2.26.2

--===============2442127217391222345==--
