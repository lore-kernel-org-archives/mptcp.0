Content-Type: multipart/mixed; boundary="===============7057164453839547682=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 0/2] mptcp: fix deadlock in mptcp{,6}_release
Date: Tue, 02 Mar 2021 18:47:10 +0100
Message-ID: <cover.1614706783.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 7979

--===============7057164453839547682==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This address the issue the easy way: removing the bugged feature
(mcast support :).

AFAICS the mcast related sockopt manipulate a global state, so there
could be existing working application doing setsockopt(mcast opt) on
TCP sockets. This is why I did not disable mcast at the inet level
for stream sockets.

Still I'm wondering if we should take the opposite approach: explicitly
forbitting all setsockopt except the one we implement in
net/mptcp/protocol.c

Additionally this possibly overlap with wider task - a more
comprehensive sockopt support. Ence the RFC tag.

Side note: syzbot confirm this fixes issues/170

Paolo Abeni (2):
  mptcp: forbit mcast-related sockopt on MPTCP sockets
  mptcp: revert "mptcp: provide subflow aware release function"$ ....$

 net/mptcp/protocol.c | 100 ++++++++++++++++++++-----------------------
 1 file changed, 47 insertions(+), 53 deletions(-)

-- =

2.26.2

--===============7057164453839547682==--
