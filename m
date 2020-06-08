Content-Type: multipart/mixed; boundary="===============5777705247719191169=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 0/2] mptcp: more token follow-up
Date: Mon, 08 Jun 2020 18:44:26 +0200
Message-ID: <cover.1591615582.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4613

--===============5777705247719191169==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The patch 1 addesses a race on close which may possibly fix
issues/36 && issues/29, the 2nd patch is a follow-up cleanup.

Patch 2 should be inserted just after "mptcp: refactor token container."

Note: I'm observing frequent (1 every a few runs) self-tests failure on top
of export branch due to timeout, but looks unrelated from series (happens =

on unpatched tree)

Paolo Abeni (2):
  mptcp: do nonce initialization at subflow creation time
  dbg

 net/core/sock.c      | 16 +------------
 net/mptcp/protocol.c | 23 +++++++++++++++++++
 net/mptcp/protocol.h |  7 ++++++
 net/mptcp/subflow.c  | 54 ++++++++++++++++----------------------------
 net/mptcp/token.c    |  3 +++
 5 files changed, 54 insertions(+), 49 deletions(-)

-- =

2.21.3

--===============5777705247719191169==--
