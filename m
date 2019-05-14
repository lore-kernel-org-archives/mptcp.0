Content-Type: multipart/mixed; boundary="===============7672177742758304261=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp v2 2/3] mptcp: store tcp socket,
 not tcp sock in subflow ctx
Date: Tue, 14 May 2019 12:36:46 +0200
Message-ID: <20190514103647.15994-3-fw@strlen.de>
In-Reply-To: 20190514103647.15994-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1165

--===============7672177742758304261==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Instead of using sk->sk_socket to get back the socket reference, store
the 'socket' pointer that is coming from kernel_accept().

This doesn't fix a bug, but it appears cleaner to me.

v2: rename helper (Peter)

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 19 ++++++++++---------
 net/mptcp/protocol.h |  6 +++---
 net/mptcp/subflow.c  | 10 +++++++---
 3 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ae65b5b6a1dd..e738bfad7430 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -27,7 +27,7 @@ static inline bool before64(__u64 seq1, __u64 seq2)
 =

 static bool mptcp_subflow_hold(struct subflow_context *subflow)
 {
-	struct sock *sk =3D sock_sk(subflow);
+	struct sock *sk =3D mptcp_subflow_tcp_socket(subflow)->sk;
 =

 	return refcount_inc_not_zero(&sk->sk_refcnt);
 }
@@ -40,7 +40,7 @@ static struct sock *mptcp_subflow_get_ref(const struct mp=
tcp_sock *msk)
 	mptcp_for_each_subflow(msk, subflow) {
 		if (mptcp_subflow_hold(subflow)) {
 			rcu_read_unlock();
-			return sock_sk(subflow);
+			return mptcp_subflow_tcp_socket(subflow)->sk;
 		}
 	}
 =

@@ -232,7 +232,7 @@ static u64 expand_seq(u64 old_seq, u16 old_data_len, u6=
4 seq)
 =

 static u64 get_mapped_dsn(struct subflow_context *subflow)
 {
-	u32 map_offset =3D (tcp_sk(sock_sk(subflow))->copied_seq -
+	u32 map_offset =3D (tcp_sk(mptcp_subflow_tcp_socket(subflow)->sk)->copied=
_seq -
 			  subflow->ssn_offset -
 			  subflow->map_subflow_seq);
 =

@@ -601,8 +601,8 @@ static void mptcp_close(struct sock *sk, long timeout)
 =

 	list_for_each_entry_safe(subflow, tmp, &list, node) {
 		pr_debug("conn_list->subflow=3D%p", subflow);
-		sock_release(sock_sk(subflow)->sk_socket);
-	};
+		sock_release(mptcp_subflow_tcp_socket(subflow));
+	}
 =

 	sock_orphan(sk);
 	sock_put(sk);
@@ -656,6 +656,7 @@ static struct sock *mptcp_accept(struct sock *sk, int f=
lags, int *err,
 		subflow->map_subflow_seq =3D 1;
 		subflow->rel_write_seq =3D 1;
 		subflow->conn =3D new_mptcp_sock->sk;
+		subflow->tcp_sock =3D new_sock;
 	} else {
 		msk->subflow =3D new_sock;
 	}
@@ -934,8 +935,8 @@ static __poll_t mptcp_poll(struct file *file, struct so=
cket *sock,
 		if (!tmp)
 			break;
 =

-		ret |=3D tcp_poll(file, sock_sk(tmp)->sk_socket, wait);
-		sock_put(sock_sk(tmp));
+		ret |=3D tcp_poll(file, mptcp_subflow_tcp_socket(tmp), wait);
+		sock_put(mptcp_subflow_tcp_socket(tmp)->sk);
 	}
 =

 	return ret;
@@ -964,9 +965,9 @@ static int mptcp_shutdown(struct socket *sock, int how)
 	lock_sock(sock->sk);
 	rcu_read_lock();
 	list_for_each_entry_rcu(subflow, &msk->conn_list, node) {
-		rcu_read_unlock();
 		pr_debug("conn_list->subflow=3D%p", subflow);
-		ret =3D kernel_sock_shutdown(sock_sk(subflow)->sk_socket, how);
+		rcu_read_unlock();
+		ret =3D kernel_sock_shutdown(mptcp_subflow_tcp_socket(subflow), how);
 		rcu_read_lock();
 	}
 	rcu_read_unlock();
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index de1131c543d0..3dfe15f42058 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -90,7 +90,7 @@ struct subflow_context {
 		map_valid : 1,
 		use_checksum : 1;
 =

-	struct  sock *sk;       /* underlying tcp_sock */
+	struct  socket *tcp_sock;/* underlying tcp_sock */
 	struct  sock *conn;     /* parent mptcp_sock */
 	void	(*tcp_sk_data_ready)(struct sock *sk);
 };
@@ -101,9 +101,9 @@ static inline struct subflow_context *subflow_ctx(const=
 struct sock *sk)
 	return (struct subflow_context *)icsk->icsk_ulp_data;
 }
 =

-static inline struct sock *sock_sk(const struct subflow_context *subflow)
+static inline struct socket *mptcp_subflow_tcp_socket(const struct subflow=
_context *subflow)
 {
-	return subflow->sk;
+	return subflow->tcp_sock;
 }
 =

 int subflow_init(void);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index f88bc48ca997..7487753d531d 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -174,6 +174,7 @@ static void subflow_data_ready(struct sock *sk)
 }
 =

 static struct subflow_context *subflow_create_ctx(struct sock *sk,
+						  struct socket *sock,
 						  gfp_t priority)
 {
 	struct inet_connection_sock *icsk =3D inet_csk(sk);
@@ -187,7 +188,8 @@ static struct subflow_context *subflow_create_ctx(struc=
t sock *sk,
 =

 	pr_debug("subflow=3D%p", ctx);
 =

-	ctx->sk =3D sk;
+	/* might be NULL */
+	ctx->tcp_sock =3D sock;
 =

 	return ctx;
 }
@@ -199,7 +201,7 @@ static int subflow_ulp_init(struct sock *sk)
 	struct subflow_context *ctx;
 	int err =3D 0;
 =

-	ctx =3D subflow_create_ctx(sk, GFP_KERNEL);
+	ctx =3D subflow_create_ctx(sk, sk->sk_socket, GFP_KERNEL);
 	if (!ctx) {
 		err =3D -ENOMEM;
 		goto out;
@@ -234,7 +236,9 @@ static void subflow_ulp_clone(const struct request_sock=
 *req,
 	struct subflow_context *new_ctx;
 =

 	old_ctx =3D inet_csk(newsk)->icsk_ulp_data;
-	new_ctx =3D subflow_create_ctx(newsk, priority);
+
+	/* newsk->sk_socket is NULL at this point */
+	new_ctx =3D subflow_create_ctx(newsk, NULL, priority);
 =

 	if (!new_ctx)
 		return;
-- =

2.21.0


--===============7672177742758304261==--
