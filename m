Content-Type: multipart/mixed; boundary="===============0096783494338398176=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 0/2] mptcp: fix some mp_join error paths
Date: Thu, 11 Jun 2020 19:20:55 +0200
Message-ID: <cover.1591895765.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4651

--===============0096783494338398176==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently we do not handle correctly MP_JOIN + syncookie and MP_JOIN
failure due to passive socket being already closed.

First patch place the infrastructure needed, the 2nd one addresses the issu=
es.
Note: in such error path, we will end-up creating the child socket just to
reset the connection. I don't see an easy way to avoid such allocation and
doing differently (reset on syn) could be dangerous (attacker can use the m=
ptcp
server to target a victim using spoofed bogus mp_join syn)

Paolo Abeni (2):
  mptcp: cache msk on MP_JOIN init_req
  mptcp: drop MP_JOIN request sock on syn cookies

 net/mptcp/protocol.h |  1 +
 net/mptcp/subflow.c  | 56 ++++++++++++++++++++------------------------
 2 files changed, 27 insertions(+), 30 deletions(-)

-- =

2.21.3

--===============0096783494338398176==--
