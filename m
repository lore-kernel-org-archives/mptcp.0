Content-Type: multipart/mixed; boundary="===============3219063492995797002=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v1 3/4] mptcp: add subflow to conn_list early
Date: Tue, 10 Dec 2019 00:52:09 +0100
Message-ID: <90f7c9b09c77af5c5b577bcc30c40fe27e9db8b3.1575934525.git.pabeni@redhat.com>
In-Reply-To: cover.1575934525.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2851

--===============3219063492995797002==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

After the previous commit we can move the subflow into
conn_list at creation time, using the msk 'can_ack' field
to track the fallaback status of such subflow.

Note that we still need to keep the subflow field around,
as we can't easily access the non MP capable socket otherwise.

RFC -> v1:
 - keep 'subflow' field around, after mptcp_subflow_tcp_sock()
   conversion we need some way to track such socket around

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2a78123a20f4..a11352e5e322 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -29,7 +29,7 @@
  */
 static struct socket *__mptcp_nmpc_socket(const struct mptcp_sock *msk)
 {
-	if (!msk->subflow)
+	if (!msk->subflow || READ_ONCE(msk->can_ack))
 		return NULL;
 =

 	return msk->subflow;
@@ -94,7 +94,8 @@ static struct socket *mptcp_socket_create_get(struct mptc=
p_sock *msk, int state)
 	}
 =

 	msk->subflow =3D ssock;
-	subflow =3D mptcp_subflow_ctx(msk->subflow->sk);
+	subflow =3D mptcp_subflow_ctx(ssock->sk);
+	list_add(&subflow->node, &msk->conn_list);
 	subflow->request_mptcp =3D 1; /* @@ if MPTCP enabled */
 	subflow->request_version =3D 1; /* only v1 supported */
 =

@@ -582,11 +583,6 @@ static void mptcp_close(struct sock *sk, long timeout)
 =

 	lock_sock(sk);
 =

-	if (msk->subflow) {
-		sock_release(msk->subflow);
-		msk->subflow =3D NULL;
-	}
-
 	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
 		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
 =

@@ -669,7 +665,6 @@ static struct sock *mptcp_accept(struct sock *sk, int f=
lags, int *err,
 		msk->token =3D subflow->token;
 =

 		mptcp_token_update_accept(newsk, new_mptcp_sock);
-		msk->subflow =3D NULL;
 =

 		msk->write_seq =3D subflow->idsn + 1;
 		if (subflow->can_ack) {
@@ -825,8 +820,6 @@ void mptcp_finish_connect(struct sock *ssk)
 		subflow->map_seq =3D ack_seq;
 		subflow->map_subflow_seq =3D 1;
 		subflow->rel_write_seq =3D 1;
-		list_add(&subflow->node, &msk->conn_list);
-		msk->subflow =3D NULL;
 		bh_unlock_sock(sk);
 		local_bh_enable();
 	}
-- =

2.21.0

--===============3219063492995797002==--
