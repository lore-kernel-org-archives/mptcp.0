Content-Type: multipart/mixed; boundary="===============7833846005054638706=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net] mptcp: explicitly zeros msk fields on clone
Date: Fri, 17 Jul 2020 17:12:59 +0200
Message-ID: <539a0cd36a6ff12d3b8d702a2cb314925a32cd9f.1594996220.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 5075

--===============7833846005054638706==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

sk_clone_lock() does not set the __GFP_ZERO flag on the
internal socket allocation, so we must explicitly zero
all the relevant msk fields, or we could see inconsitent
socket status leading to unexpected fallback or data
corruption.

Fixes: d22f4988ffec ("mptcp: process MP_CAPABLE data option")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
The goal is send this patch upstream asap, so that is hopefully =

included soon in net-next.

In the export branch should be located on top of current net-next
HEAD, that is, before all pending export branch patches
---
 net/mptcp/protocol.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index dbe43e0cd734..5449fee82239 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1511,12 +1511,15 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 		inet_sk(nsk)->pinet6 =3D mptcp_inet6_sk(nsk);
 #endif
 =

-	__mptcp_init_sock(nsk);
-
 	msk =3D mptcp_sk(nsk);
 	msk->local_key =3D subflow_req->local_key;
 	msk->token =3D subflow_req->token;
 	msk->subflow =3D NULL;
+	msk->cached_ext =3D NULL;
+	msk->flags =3D 0;
+	msk->can_ack =3D false;
+
+	__mptcp_init_sock(nsk);
 =

 	msk->write_seq =3D subflow_req->idsn + 1;
 	atomic64_set(&msk->snd_una, msk->write_seq);
-- =

2.26.2

--===============7833846005054638706==--
