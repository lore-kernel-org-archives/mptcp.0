Content-Type: multipart/mixed; boundary="===============4309709293152408853=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC 5/7] store tcp_sk, not socket
Date: Mon, 25 Nov 2019 03:15:06 +0100
Message-ID: <20191125021508.29153-6-fw@strlen.de>
In-Reply-To: 20191125021508.29153-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2677

--===============4309709293152408853==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

preparation patch to avoid outer 'struct socket'.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 23 ++++++++++++-----------
 net/mptcp/protocol.h |  8 ++++----
 net/mptcp/subflow.c  |  8 +++-----
 3 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 720c0ab46cfb..68ae6796359f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -101,7 +101,7 @@ static struct sock *mptcp_subflow_recv_lookup(const str=
uct mptcp_sock *msk)
 =

 	mptcp_for_each_subflow(msk, subflow) {
 		if (subflow->data_avail)
-			return mptcp_subflow_tcp_socket(subflow)->sk;
+			return mptcp_subflow_tcp_sock(subflow);
 =

 		receivers +=3D !subflow->rx_eof;
 	}
@@ -382,7 +382,7 @@ static struct sock *mptcp_subflow_get_send(struct mptcp=
_sock *msk)
 	sock_owned_by_me((const struct sock *)msk);
 =

 	mptcp_for_each_subflow(msk, subflow) {
-		struct sock *ssk =3D mptcp_subflow_tcp_socket(subflow)->sk;
+		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
 =

 		if (!sk_stream_memory_free(ssk)) {
 			struct socket *sock =3D ssk->sk_socket;
@@ -745,7 +745,7 @@ static struct sock *mptcp_subflow_get_retrans(const str=
uct mptcp_sock *msk)
 	sock_owned_by_me((const struct sock *)msk);
 =

 	mptcp_for_each_subflow(msk, subflow) {
-		struct sock *ssk =3D mptcp_subflow_tcp_socket(subflow)->sk;
+		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
 =

 		/* still data outstanding at TCP level?  Don't retransmit. */
 		if (!tcp_write_queue_empty(ssk))
@@ -900,8 +900,11 @@ static void mptcp_close(struct sock *sk, long timeout)
 	}
 =

 	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
+		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+
 		pr_debug("conn_list->subflow=3D%p", subflow);
-		sock_release(mptcp_subflow_tcp_socket(subflow));
+		list_del(&subflow->node);
+		sock_release(ssk->sk_socket);
 	}
 =

 	__mptcp_clear_xmit(sk);
@@ -1015,10 +1018,10 @@ static struct sock *mptcp_accept(struct sock *sk, i=
nt flags, int *err,
 		subflow->map_seq =3D ack_seq;
 		subflow->map_subflow_seq =3D 1;
 		subflow->rel_write_seq =3D 1;
-		subflow->tcp_sock =3D new_sock;
+		subflow->tcp_sock =3D ssk;
 		subflow->conn =3D new_mptcp_sock;
-		if (unlikely(!skb_queue_empty(&new_sock->sk->sk_receive_queue)))
-			mptcp_subflow_data_available(new_sock->sk);
+		if (unlikely(!skb_queue_empty(&ssk->sk_receive_queue)))
+			mptcp_subflow_data_available(ssk);
 		release_sock(ssk);
 	} else {
 		newsk =3D new_sock->sk;
@@ -1475,11 +1478,9 @@ static int mptcp_shutdown(struct socket *sock, int h=
ow)
 	}
 =

 	mptcp_for_each_subflow(msk, subflow) {
-		struct socket *tcp_socket;
+		struct sock *tcp_sk =3D mptcp_subflow_tcp_sock(subflow);
 =

-		tcp_socket =3D mptcp_subflow_tcp_socket(subflow);
-		pr_debug("conn_list->subflow=3D%p", subflow);
-		ret =3D kernel_sock_shutdown(tcp_socket, how);
+		ret =3D kernel_sock_shutdown(tcp_sk->sk_socket, how);
 	}
 	release_sock(sock->sk);
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 237c5efd0ba7..015102402432 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -226,7 +226,7 @@ struct mptcp_subflow_context {
 	u8	local_id;
 	u8	remote_id;
 =

-	struct	socket *tcp_sock;   /* underlying tcp_sock */
+	struct	sock *tcp_sock;	    /* tcp sk backpointer */
 	struct	sock *conn;	    /* parent mptcp_sock */
 	const	struct inet_connection_sock_af_ops *icsk_af_ops;
 	void	(*tcp_sk_data_ready)(struct sock *sk);
@@ -242,8 +242,8 @@ mptcp_subflow_ctx(const struct sock *sk)
 	return (__force struct mptcp_subflow_context *)icsk->icsk_ulp_data;
 }
 =

-static inline struct socket *
-mptcp_subflow_tcp_socket(const struct mptcp_subflow_context *subflow)
+static inline struct sock *
+mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
 {
 	return subflow->tcp_sock;
 }
@@ -251,7 +251,7 @@ mptcp_subflow_tcp_socket(const struct mptcp_subflow_con=
text *subflow)
 static inline u64
 mptcp_subflow_get_map_offset(const struct mptcp_subflow_context *subflow)
 {
-	return tcp_sk(mptcp_subflow_tcp_socket(subflow)->sk)->copied_seq -
+	return tcp_sk(mptcp_subflow_tcp_sock(subflow))->copied_seq -
 		      subflow->ssn_offset -
 		      subflow->map_subflow_seq;
 }
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index ffbe0a4a04be..e6a512bf6230 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -769,7 +769,6 @@ int mptcp_subflow_create_socket(struct sock *sk, struct=
 socket **new_sock)
 }
 =

 static struct mptcp_subflow_context *subflow_create_ctx(struct sock *sk,
-							struct socket *sock,
 							gfp_t priority)
 {
 	struct inet_connection_sock *icsk =3D inet_csk(sk);
@@ -782,8 +781,7 @@ static struct mptcp_subflow_context *subflow_create_ctx=
(struct sock *sk,
 =

 	pr_debug("subflow=3D%p", ctx);
 =

-	/* might be NULL */
-	ctx->tcp_sock =3D sock;
+	ctx->tcp_sock =3D sk;
 =

 	return ctx;
 }
@@ -825,7 +823,7 @@ static int subflow_ulp_init(struct sock *sk)
 		goto out;
 	}
 =

-	ctx =3D subflow_create_ctx(sk, sk->sk_socket, GFP_KERNEL);
+	ctx =3D subflow_create_ctx(sk, GFP_KERNEL);
 	if (!ctx) {
 		err =3D -ENOMEM;
 		goto out;
@@ -870,7 +868,7 @@ static void subflow_ulp_clone(const struct request_sock=
 *req,
 	struct mptcp_subflow_context *new_ctx;
 =

 	/* newsk->sk_socket is NULL at this point */
-	new_ctx =3D subflow_create_ctx(newsk, NULL, priority);
+	new_ctx =3D subflow_create_ctx(newsk, priority);
 	if (!new_ctx)
 		return;
 =

-- =

2.23.0

--===============4309709293152408853==--
