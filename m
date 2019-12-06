Content-Type: multipart/mixed; boundary="===============3492392972623553355=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 4/5] mptcp: remove 'fallback' field
Date: Fri, 06 Dec 2019 13:22:46 +0100
Message-ID: <cf5eae7cef72fb9de835b31bf8a5488fe7e6996f.1575634848.git.pabeni@redhat.com>
In-Reply-To: cover.1575634848.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2815

--===============3492392972623553355==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

After the previous commit we can drop the fallback field, moving
the subflow into conn_list at creation time. Just update the
access helper to use conn_list only.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 35 +++++++++++++++++------------------
 net/mptcp/protocol.h |  1 -
 2 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 069aeda69a19..6ec4aed0338e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -29,22 +29,23 @@
  */
 static struct socket *__mptcp_nmpc_socket(const struct mptcp_sock *msk)
 {
+	struct mptcp_subflow_context *subflow;
+
 	sock_owned_by_me((const struct sock *)msk);
 =

-	if (!msk->subflow)
+	if (msk->can_ack || list_empty(&msk->conn_list))
 		return NULL;
 =

-	return msk->subflow;
+	subflow =3D list_first_entry(&msk->conn_list,
+				   struct mptcp_subflow_context, node);
+	return mptcp_subflow_tcp_socket(subflow);
 }
 =

 /* get a reference to the first subflow socket and returns it */
 static struct socket *__mptcp_first_socket(const struct mptcp_sock *msk)
 {
-	struct socket *ssock =3D __mptcp_nmpc_socket(msk);
 	struct mptcp_subflow_context *subflow;
 =

-	if (ssock)
-		return ssock;
 	if (list_empty(&msk->conn_list))
 		return NULL;
 =

@@ -59,11 +60,17 @@ static struct socket *__mptcp_first_socket(const struct=
 mptcp_sock *msk)
  */
 static struct socket *__mptcp_tcp_fallback_get(const struct mptcp_sock *ms=
k)
 {
-	if (!msk->subflow || tcp_sk(msk->subflow->sk)->is_mptcp)
+	struct socket *ssock;
+
+	if (msk->can_ack)
 		return NULL;
 =

-	sock_hold(msk->subflow->sk);
-	return msk->subflow;
+	ssock =3D __mptcp_first_socket(msk);
+	if (tcp_sk(ssock->sk)->is_mptcp)
+		return NULL;
+
+	sock_hold(ssock->sk);
+	return ssock;
 }
 =

 static struct sock *mptcp_subflow_get(const struct mptcp_sock *msk)
@@ -109,8 +116,8 @@ static struct socket *mptcp_socket_create_get(struct mp=
tcp_sock *msk, int state)
 		goto release;
 	}
 =

-	msk->subflow =3D ssock;
-	subflow =3D mptcp_subflow_ctx(msk->subflow->sk);
+	subflow =3D mptcp_subflow_ctx(ssock->sk);
+	list_add(&subflow->node, &msk->conn_list);
 	subflow->request_mptcp =3D 1; /* @@ if MPTCP enabled */
 	subflow->request_version =3D 1; /* only v1 supported */
 =

@@ -535,11 +542,6 @@ static void mptcp_close(struct sock *sk, long timeout)
 =

 	lock_sock(sk);
 =

-	if (msk->subflow) {
-		sock_release(msk->subflow);
-		msk->subflow =3D NULL;
-	}
-
 	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
 		pr_debug("conn_list->subflow=3D%p", subflow);
 		sock_release(mptcp_subflow_tcp_socket(subflow));
@@ -598,7 +600,6 @@ static struct sock *mptcp_accept(struct sock *sk, int f=
lags, int *err,
 		msk->token =3D subflow->token;
 =

 		mptcp_token_update_accept(new_sock->sk, new_mptcp_sock);
-		msk->subflow =3D NULL;
 =

 		msk->write_seq =3D subflow->idsn + 1;
 		if (subflow->can_ack) {
@@ -751,8 +752,6 @@ void mptcp_finish_connect(struct sock *sk,
 		subflow->map_seq =3D ack_seq;
 		subflow->map_subflow_seq =3D 1;
 		subflow->rel_write_seq =3D 1;
-		list_add(&subflow->node, &msk->conn_list);
-		msk->subflow =3D NULL;
 		bh_unlock_sock(sk);
 		local_bh_enable();
 	}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7e8a37f5b35c..ab29fc476a13 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -69,7 +69,6 @@ struct mptcp_sock {
 	unsigned long	flags;
 	bool		can_ack;
 	struct list_head conn_list;
-	struct socket	*subflow; /* outgoing connect/listener/!mp_capable */
 };
 =

 #define mptcp_for_each_subflow(__msk, __subflow)			\
-- =

2.21.0

--===============3492392972623553355==--
