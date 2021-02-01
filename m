Content-Type: multipart/mixed; boundary="===============1902046546495668404=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next 1/2] mptcp: deliver ssk errors to msk
Date: Mon, 01 Feb 2021 19:12:13 +0100
Message-ID: <3188611374c07952906f5d92df9638fc8c647b10.1612201708.git.pabeni@redhat.com>
In-Reply-To: cover.1612201708.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7555

--===============1902046546495668404==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently all errors received on msk subflows are ignored.
We need to catch at least the errors on connect() and
on fallback sockets.

Use a custom sk_error_report callback at subflow level,
and do the real action under the msk socket lock - via
the usual sock_owned_by_user()/release_callback() schema.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c |  7 +++++++
 net/mptcp/protocol.h |  4 ++++
 net/mptcp/subflow.c  | 43 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b5ba832ca58b6..fdd2a30118978 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2944,6 +2944,8 @@ static void mptcp_release_cb(struct sock *sk)
 		mptcp_push_pending(sk, 0);
 		spin_lock_bh(&sk->sk_lock.slock);
 	}
+	if (test_and_clear_bit(MPTCP_ERROR_REPORT, &mptcp_sk(sk)->flags))
+		__mptcp_error_report(sk);
 =

 	/* clear any wmem reservation and errors */
 	__mptcp_update_wmem(sk);
@@ -3356,6 +3358,11 @@ static __poll_t mptcp_poll(struct file *file, struct=
 socket *sock,
 	if (sk->sk_shutdown & RCV_SHUTDOWN)
 		mask |=3D EPOLLIN | EPOLLRDNORM | EPOLLRDHUP;
 =

+	/* This barrier is coupled with smp_wmb() in tcp_reset() */
+	smp_rmb();
+	if (sk->sk_err)
+		mask |=3D EPOLLERR;
+
 	return mask;
 }
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d31edbae8da81..1024ea1512d2b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -102,6 +102,7 @@
 #define MPTCP_WORK_CLOSE_SUBFLOW 5
 #define MPTCP_PUSH_PENDING	6
 #define MPTCP_CLEAN_UNA		7
+#define MPTCP_ERROR_REPORT	8
 =

 static inline bool before64(__u64 seq1, __u64 seq2)
 {
@@ -436,6 +437,7 @@ struct mptcp_subflow_context {
 	void	(*tcp_data_ready)(struct sock *sk);
 	void	(*tcp_state_change)(struct sock *sk);
 	void	(*tcp_write_space)(struct sock *sk);
+	void	(*tcp_error_report)(struct sock *sk);
 =

 	struct	rcu_head rcu;
 };
@@ -560,6 +562,7 @@ static inline void mptcp_subflow_tcp_fallback(struct so=
ck *sk,
 	sk->sk_data_ready =3D ctx->tcp_data_ready;
 	sk->sk_state_change =3D ctx->tcp_state_change;
 	sk->sk_write_space =3D ctx->tcp_write_space;
+	sk->sk_error_report =3D ctx->tcp_error_report;
 =

 	inet_csk(sk)->icsk_af_ops =3D ctx->icsk_af_ops;
 }
@@ -587,6 +590,7 @@ bool mptcp_finish_join(struct sock *sk);
 bool mptcp_schedule_work(struct sock *sk);
 void __mptcp_check_push(struct sock *sk, struct sock *ssk);
 void __mptcp_data_acked(struct sock *sk);
+void __mptcp_error_report(struct sock *sk);
 void mptcp_subflow_eof(struct sock *sk);
 bool mptcp_update_rcv_data_fin(struct mptcp_sock *msk, u64 data_fin_seq, b=
ool use_64bit);
 void __mptcp_flush_join_list(struct mptcp_sock *msk);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index b8b670cb61167..7a5518f751105 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1105,6 +1105,46 @@ static void subflow_write_space(struct sock *ssk)
 	mptcp_write_space(sk);
 }
 =

+void __mptcp_error_report(struct sock *sk)
+{
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+		int err =3D sock_error(ssk);
+
+		if (!err)
+			continue;
+
+		/* only propagate errors on fallen-back sockets or
+		 * on MPC connect
+		 */
+		if (sk->sk_state !=3D TCP_SYN_SENT && !__mptcp_check_fallback(msk))
+			continue;
+
+		inet_sk_state_store(sk, inet_sk_state_load(ssk));
+		sk->sk_err =3D -err;
+
+		/* This barrier is coupled with smp_rmb() in mptcp_poll() */
+		smp_wmb();
+		sk->sk_error_report(sk);
+		break;
+	}
+}
+
+static void subflow_error_report(struct sock *ssk)
+{
+	struct sock *sk =3D mptcp_subflow_ctx(ssk)->conn;
+
+	mptcp_data_lock(sk);
+	if (!sock_owned_by_user(sk))
+		__mptcp_error_report(sk);
+	else
+		set_bit(MPTCP_ERROR_REPORT,  &mptcp_sk(sk)->flags);
+	mptcp_data_unlock(sk);
+}
+
 static struct inet_connection_sock_af_ops *
 subflow_default_af_ops(struct sock *sk)
 {
@@ -1449,9 +1489,11 @@ static int subflow_ulp_init(struct sock *sk)
 	ctx->tcp_data_ready =3D sk->sk_data_ready;
 	ctx->tcp_state_change =3D sk->sk_state_change;
 	ctx->tcp_write_space =3D sk->sk_write_space;
+	ctx->tcp_error_report =3D sk->sk_error_report;
 	sk->sk_data_ready =3D subflow_data_ready;
 	sk->sk_write_space =3D subflow_write_space;
 	sk->sk_state_change =3D subflow_state_change;
+	sk->sk_error_report =3D subflow_error_report;
 out:
 	return err;
 }
@@ -1505,6 +1547,7 @@ static void subflow_ulp_clone(const struct request_so=
ck *req,
 	new_ctx->tcp_data_ready =3D old_ctx->tcp_data_ready;
 	new_ctx->tcp_state_change =3D old_ctx->tcp_state_change;
 	new_ctx->tcp_write_space =3D old_ctx->tcp_write_space;
+	new_ctx->tcp_error_report =3D old_ctx->tcp_error_report;
 	new_ctx->rel_write_seq =3D 1;
 	new_ctx->tcp_sock =3D newsk;
 =

-- =

2.26.2

--===============1902046546495668404==--
