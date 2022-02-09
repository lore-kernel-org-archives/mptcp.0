Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7437C2F39
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 10:11:50 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1nHjws-0002OH-0k; Wed, 09 Feb 2022 11:11:42 +0100
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH mptcp-next] mptcp: don't save tcp data_ready and write space callbacks
Date: Wed,  9 Feb 2022 11:11:33 +0100
Message-Id: <20220209101133.19514-1-fw@strlen.de>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Assign the helpers directly rather than save/restore in the context
structure.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/mptcp/protocol.h | 6 ++----
 net/mptcp/subflow.c  | 4 ----
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f37f087caab3..202004473292 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -479,9 +479,7 @@ struct mptcp_subflow_context {
 	struct	sock *tcp_sock;	    /* tcp sk backpointer */
 	struct	sock *conn;	    /* parent mptcp_sock */
 	const	struct inet_connection_sock_af_ops *icsk_af_ops;
-	void	(*tcp_data_ready)(struct sock *sk);
 	void	(*tcp_state_change)(struct sock *sk);
-	void	(*tcp_write_space)(struct sock *sk);
 	void	(*tcp_error_report)(struct sock *sk);
 
 	struct	rcu_head rcu;
@@ -626,9 +624,9 @@ bool mptcp_subflow_active(struct mptcp_subflow_context *subflow);
 static inline void mptcp_subflow_tcp_fallback(struct sock *sk,
 					      struct mptcp_subflow_context *ctx)
 {
-	sk->sk_data_ready = ctx->tcp_data_ready;
+	sk->sk_data_ready = sock_def_readable;
 	sk->sk_state_change = ctx->tcp_state_change;
-	sk->sk_write_space = ctx->tcp_write_space;
+	sk->sk_write_space = sk_stream_write_space;
 	sk->sk_error_report = ctx->tcp_error_report;
 
 	inet_csk(sk)->icsk_af_ops = ctx->icsk_af_ops;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 485f00dcaf84..d4b4d285ffc1 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1661,9 +1661,7 @@ static int subflow_ulp_init(struct sock *sk)
 	tp->is_mptcp = 1;
 	ctx->icsk_af_ops = icsk->icsk_af_ops;
 	icsk->icsk_af_ops = subflow_default_af_ops(sk);
-	ctx->tcp_data_ready = sk->sk_data_ready;
 	ctx->tcp_state_change = sk->sk_state_change;
-	ctx->tcp_write_space = sk->sk_write_space;
 	ctx->tcp_error_report = sk->sk_error_report;
 	sk->sk_data_ready = subflow_data_ready;
 	sk->sk_write_space = subflow_write_space;
@@ -1719,9 +1717,7 @@ static void subflow_ulp_clone(const struct request_sock *req,
 
 	new_ctx->conn_finished = 1;
 	new_ctx->icsk_af_ops = old_ctx->icsk_af_ops;
-	new_ctx->tcp_data_ready = old_ctx->tcp_data_ready;
 	new_ctx->tcp_state_change = old_ctx->tcp_state_change;
-	new_ctx->tcp_write_space = old_ctx->tcp_write_space;
 	new_ctx->tcp_error_report = old_ctx->tcp_error_report;
 	new_ctx->rel_write_seq = 1;
 	new_ctx->tcp_sock = newsk;
-- 
2.34.1

