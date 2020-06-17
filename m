Content-Type: multipart/mixed; boundary="===============7265709892138471724=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net 0/2] mptcp: cope with syncookie on MP_JOINs
Date: Wed, 17 Jun 2020 12:08:55 +0200
Message-ID: <cover.1592388398.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4716

--===============7265709892138471724==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently syncookies on MP_JOIN connections are not handled correctly: the
connections fallback to TCP and are kept alive instead of resetting them at
fallback time.

The first patch propagates the required information up to syn_recv_sock tim=
e,
and the 2nd patch addresses the unifying the error path for all MP_JOIN
requests.

Paolo Abeni (2):
  mptcp: cache msk on MP_JOIN init_req
  mptcp: drop MP_JOIN request sock on syn cookies

 net/mptcp/protocol.h |  1 +
 net/mptcp/subflow.c  | 57 +++++++++++++++++++++-----------------------
 2 files changed, 28 insertions(+), 30 deletions(-)

-- =

2.26.2

--===============7265709892138471724==--
