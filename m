Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19084CA6D
	for <mptcp@lists.linux.dev>; Wed, 13 Dec 2023 05:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sH3kMG+/"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702447049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PEQIM6nNzJXMEI/4bp/NKolf3oO3tRWrqX+a1AvJfz4=;
	b=sH3kMG+/FIRQl813Y9Q0YSJyNeZ0TmEqXyhv1pDuBP+ZlVvxJaAEWIZi84+uNyPhmIHr2p
	OnRc/9jh8MTYk+Gg+COC6in6ItJ8GtzHKhvW8eFdScjin9feO8ozyicHGIYBNkqgECyRbB
	cfSsAwiN3nlkGcaWRaahBk/p7QprCNs=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v5 2/3] mptcp: use mptcp_set_state
Date: Wed, 13 Dec 2023 13:56:38 +0800
Message-Id: <d6ac6b189ca025dd510455c37daa17fa98db8259.1702446832.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1702446832.git.geliang.tang@linux.dev>
References: <cover.1702446832.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch replaces all the 'inet_sk_state_store()' calls under net/mptcp
with the new helper mptcp_set_state().

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 net/mptcp/pm_netlink.c |  3 +++
 net/mptcp/protocol.c   | 38 +++++++++++++++++++-------------------
 net/mptcp/subflow.c    |  2 +-
 3 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index bf4d96f6f99a..b93683b5e618 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1048,6 +1048,9 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	if (err)
 		return err;
 
+	/* avoid replacing inet_sk_state_store with mptcp_set_state here, as the
+	 * old status is known to be TCP_CLOSE, hence will not affect the count.
+	 */
 	inet_sk_state_store(newsk, TCP_LISTEN);
 	lock_sock(ssk);
 	err = __inet_listen_sk(ssk, backlog);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b0b149cc89aa..d73dc76e5bfc 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -443,11 +443,11 @@ static void mptcp_check_data_fin_ack(struct sock *sk)
 
 		switch (sk->sk_state) {
 		case TCP_FIN_WAIT1:
-			inet_sk_state_store(sk, TCP_FIN_WAIT2);
+			mptcp_set_state(sk, TCP_FIN_WAIT2);
 			break;
 		case TCP_CLOSING:
 		case TCP_LAST_ACK:
-			inet_sk_state_store(sk, TCP_CLOSE);
+			mptcp_set_state(sk, TCP_CLOSE);
 			break;
 		}
 
@@ -608,13 +608,13 @@ static bool mptcp_check_data_fin(struct sock *sk)
 
 		switch (sk->sk_state) {
 		case TCP_ESTABLISHED:
-			inet_sk_state_store(sk, TCP_CLOSE_WAIT);
+			mptcp_set_state(sk, TCP_CLOSE_WAIT);
 			break;
 		case TCP_FIN_WAIT1:
-			inet_sk_state_store(sk, TCP_CLOSING);
+			mptcp_set_state(sk, TCP_CLOSING);
 			break;
 		case TCP_FIN_WAIT2:
-			inet_sk_state_store(sk, TCP_CLOSE);
+			mptcp_set_state(sk, TCP_CLOSE);
 			break;
 		default:
 			/* Other states not expected */
@@ -789,7 +789,7 @@ static bool __mptcp_subflow_error_report(struct sock *sk, struct sock *ssk)
 	 */
 	ssk_state = inet_sk_state_load(ssk);
 	if (ssk_state == TCP_CLOSE && !sock_flag(sk, SOCK_DEAD))
-		inet_sk_state_store(sk, ssk_state);
+		mptcp_set_state(sk, ssk_state);
 	WRITE_ONCE(sk->sk_err, -err);
 
 	/* This barrier is coupled with smp_rmb() in mptcp_poll() */
@@ -2477,7 +2477,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	    inet_sk_state_load(msk->first) == TCP_CLOSE) {
 		if (sk->sk_state != TCP_ESTABLISHED ||
 		    msk->in_accept_queue || sock_flag(sk, SOCK_DEAD)) {
-			inet_sk_state_store(sk, TCP_CLOSE);
+			mptcp_set_state(sk, TCP_CLOSE);
 			mptcp_close_wake_up(sk);
 		} else {
 			mptcp_start_tout_timer(sk);
@@ -2572,7 +2572,7 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
 		WRITE_ONCE(sk->sk_err, ECONNRESET);
 	}
 
-	inet_sk_state_store(sk, TCP_CLOSE);
+	mptcp_set_state(sk, TCP_CLOSE);
 	WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK);
 	smp_mb__before_atomic(); /* SHUTDOWN must be visible first */
 	set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags);
@@ -2707,7 +2707,7 @@ static void mptcp_do_fastclose(struct sock *sk)
 	struct mptcp_subflow_context *subflow, *tmp;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	inet_sk_state_store(sk, TCP_CLOSE);
+	mptcp_set_state(sk, TCP_CLOSE);
 	mptcp_for_each_subflow_safe(msk, subflow, tmp)
 		__mptcp_close_ssk(sk, mptcp_subflow_tcp_sock(subflow),
 				  subflow, MPTCP_CF_FASTCLOSE);
@@ -2925,7 +2925,7 @@ static int mptcp_close_state(struct sock *sk)
 	int next = (int)new_state[sk->sk_state];
 	int ns = next & TCP_STATE_MASK;
 
-	inet_sk_state_store(sk, ns);
+	mptcp_set_state(sk, ns);
 
 	return next & TCP_ACTION_FIN;
 }
@@ -3036,7 +3036,7 @@ bool __mptcp_close(struct sock *sk, long timeout)
 
 	if ((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE)) {
 		mptcp_check_listen_stop(sk);
-		inet_sk_state_store(sk, TCP_CLOSE);
+		mptcp_set_state(sk, TCP_CLOSE);
 		goto cleanup;
 	}
 
@@ -3079,7 +3079,7 @@ bool __mptcp_close(struct sock *sk, long timeout)
 	 * state, let's not keep resources busy for no reasons
 	 */
 	if (subflows_alive == 0)
-		inet_sk_state_store(sk, TCP_CLOSE);
+		mptcp_set_state(sk, TCP_CLOSE);
 
 	sock_hold(sk);
 	pr_debug("msk=%p state=%d", sk, sk->sk_state);
@@ -3145,7 +3145,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 		return -EBUSY;
 
 	mptcp_check_listen_stop(sk);
-	inet_sk_state_store(sk, TCP_CLOSE);
+	mptcp_set_state(sk, TCP_CLOSE);
 
 	mptcp_stop_rtx_timer(sk);
 	mptcp_stop_tout_timer(sk);
@@ -3233,7 +3233,7 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	/* this can't race with mptcp_close(), as the msk is
 	 * not yet exposted to user-space
 	 */
-	inet_sk_state_store(nsk, TCP_ESTABLISHED);
+	mptcp_set_state(nsk, TCP_ESTABLISHED);
 
 	/* The msk maintain a ref to each subflow in the connections list */
 	WRITE_ONCE(msk->first, ssk);
@@ -3691,7 +3691,7 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	if (IS_ERR(ssk))
 		return PTR_ERR(ssk);
 
-	inet_sk_state_store(sk, TCP_SYN_SENT);
+	mptcp_set_state(sk, TCP_SYN_SENT);
 	subflow = mptcp_subflow_ctx(ssk);
 #ifdef CONFIG_TCP_MD5SIG
 	/* no MPTCP if MD5SIG is enabled on this socket or we may run out of
@@ -3741,7 +3741,7 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	if (unlikely(err)) {
 		/* avoid leaving a dangling token in an unconnected socket */
 		mptcp_token_destroy(msk);
-		inet_sk_state_store(sk, TCP_CLOSE);
+		mptcp_set_state(sk, TCP_CLOSE);
 		return err;
 	}
 
@@ -3831,13 +3831,13 @@ static int mptcp_listen(struct socket *sock, int backlog)
 		goto unlock;
 	}
 
-	inet_sk_state_store(sk, TCP_LISTEN);
+	mptcp_set_state(sk, TCP_LISTEN);
 	sock_set_flag(sk, SOCK_RCU_FREE);
 
 	lock_sock(ssk);
 	err = __inet_listen_sk(ssk, backlog);
 	release_sock(ssk);
-	inet_sk_state_store(sk, inet_sk_state_load(ssk));
+	mptcp_set_state(sk, inet_sk_state_load(ssk));
 
 	if (!err) {
 		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
@@ -3897,7 +3897,7 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 			__mptcp_close_ssk(newsk, msk->first,
 					  mptcp_subflow_ctx(msk->first), 0);
 			if (unlikely(list_is_singular(&msk->conn_list)))
-				inet_sk_state_store(newsk, TCP_CLOSE);
+				mptcp_set_state(newsk, TCP_CLOSE);
 		}
 	}
 	release_sock(newsk);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 64302a1ac306..7ca70dc785af 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -422,7 +422,7 @@ static bool subflow_use_different_dport(struct mptcp_sock *msk, const struct soc
 void __mptcp_sync_state(struct sock *sk, int state)
 {
 	if (sk->sk_state == TCP_SYN_SENT) {
-		inet_sk_state_store(sk, state);
+		mptcp_set_state(sk, state);
 		sk->sk_state_change(sk);
 	}
 }
-- 
2.35.3

