Content-Type: multipart/mixed; boundary="===============8676811213923952780=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 0/4] mptcp: [try to] fix armegaddon on late tcp
 fallback
Date: Fri, 13 Dec 2019 15:33:48 +0100
Message-ID: <cover.1576247361.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 2938

--===============8676811213923952780==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Passive connection can fallback to TCP after that the subflow is establishe=
d.
That leads to disaster in several nasty ways.

Address the issue explicitly falling back to TCP (converting the socket) as
soon as we notice the unsuccessful MPC hanshake completion.

Sent as a very early RFC - completely untested yet.

Paolo Abeni (4):
  mptcp: add helper to forcefully fallback the msk socket to TCP
  mptcp: cache the first subflow sock
  mptcp: late fallback support
  mptcp: deal with fallback in additional places.

 net/mptcp/protocol.c | 92 +++++++++++++++++++++++++++++++++++++-------
 net/mptcp/protocol.h |  1 +
 2 files changed, 79 insertions(+), 14 deletions(-)

-- =

2.21.0

--===============8676811213923952780==--
