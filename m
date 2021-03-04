Content-Type: multipart/mixed; boundary="===============1105897384391079234=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net 5/9] mptcp: reset 'first' and ack_hint on subflow
 close
Date: Thu, 04 Mar 2021 13:32:12 -0800
Message-ID: <20210304213216.205472-6-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20210304213216.205472-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 8032

--===============1105897384391079234==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Florian Westphal <fw(a)strlen.de>

Just like with last_snd, we have to NULL 'first' on subflow close.

ack_hint isn't strictly required (its never dereferenced), but better to
clear this explicitly as well instead of making it an exception.

msk->first is dereferenced unconditionally at accept time, but
at that point the ssk is not on the conn_list yet -- this means
worker can't see it when iterating the conn_list.

Reported-by: Paolo Abeni <pabeni(a)redhat.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Signed-off-by: Florian Westphal <fw(a)strlen.de>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/protocol.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a58da04bed71..3dcb564b03ad 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2169,6 +2169,12 @@ static void __mptcp_close_ssk(struct sock *sk, struc=
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
@@ -3297,6 +3303,9 @@ static int mptcp_stream_accept(struct socket *sock, s=
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

2.30.1

--===============1105897384391079234==--
