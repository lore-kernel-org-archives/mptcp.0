Content-Type: multipart/mixed; boundary="===============2536534017342027597=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2] mptcp: reset 'first' and ack_hint on subflow close
Date: Mon, 22 Feb 2021 17:18:15 +0100
Message-ID: <20210222161815.27469-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 7893

--===============2536534017342027597==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Just like with last_snd, we have to NULL 'first' on subflow close.

ack_hint isn't strictly required (its never dereferenced), but better to
clear this explicitly as well instead of making it an exception.

msk->first is dereferenced unconditionally at accept time, but
at that point the ssk is not on the conn_list yet -- this means
worker can't see it when iterating the conn_list.

Reported-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 v2: add comment to clarify msk->first access in accept()
 is safe even if tcp connection has been closed already.

 net/mptcp/protocol.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6b4eac26256f..e3865d59009b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2161,6 +2161,12 @@ static void __mptcp_close_ssk(struct sock *sk, struc=
t sock *ssk,
 	if (ssk =3D=3D msk->last_snd)
 		msk->last_snd =3D NULL;
 =

+	if (ssk =3D=3D msk->ack_hint)
+		msk->ack_hint =3D NULL;
+
+	if (ssk =3D=3D msk->first)
+		msk->first =3D NULL;
+
 	if (msk->subflow && ssk =3D=3D msk->subflow->sk)
 		mptcp_dispose_initial_subflow(msk);
 }
@@ -3298,6 +3304,9 @@ static int mptcp_stream_accept(struct socket *sock, s=
truct socket *newsock,
 		/* PM/worker can now acquire the first subflow socket
 		 * lock without racing with listener queue cleanup,
 		 * we can notify it, if needed.
+		 *
+		 * Even if remote has reset the initial subflow by now
+		 * the refcnt is still at least one.
 		 */
 		subflow =3D mptcp_subflow_ctx(msk->first);
 		list_add(&subflow->node, &msk->conn_list);
-- =

2.26.2

--===============2536534017342027597==--
