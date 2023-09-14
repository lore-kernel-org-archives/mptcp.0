Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF0921355
	for <mptcp@lists.linux.dev>; Thu, 14 Sep 2023 17:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694710946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K2V6kA5BNS8EBaRzBYd95kZPjGOJA63K1doaYQebCj0=;
	b=aYymcA3Llo99fD2E2gaGBQVPEYknh9njP5TNT9+XeBLPaHEYqDA+ThFBPpkQHQGzhcn0iT
	ROkYMamCkP5Ha9nzy1QtMFiGaBkkBP1Z31hqzkdndOrwPXaCn25VYZlMWSACX4Li4nIe7J
	B97EUKAofrgG8XwrVwcuzCIGafHnfNM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-H7XB-Q10MV2umUtFBwgapw-1; Thu, 14 Sep 2023 13:02:22 -0400
X-MC-Unique: H7XB-Q10MV2umUtFBwgapw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6C951105DAAC
	for <mptcp@lists.linux.dev>; Thu, 14 Sep 2023 17:02:14 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.154])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EE674200A391
	for <mptcp@lists.linux.dev>; Thu, 14 Sep 2023 17:02:13 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 3/3] mptcp: refactor sndbuf auto-tuning.
Date: Thu, 14 Sep 2023 19:02:06 +0200
Message-ID: <91b50314a17d427087f718d4b77aa23dd07fcde4.1694710538.git.pabeni@redhat.com>
In-Reply-To: <cover.1694710538.git.pabeni@redhat.com>
References: <cover.1694710538.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The MPTCP protocol account for the data enqueued on all the subflows
to the main socket send buffer, while the send buffer auto-tuning
algorithm set the main socket send buffer size as the max size among
the subflows.

That causes bad performances when at least one subflow is sndbuf
limited, e.g. due to very high latency, as the MPTCP scheduler can't
even fill such buffer.

Change the send-buffer auto-tuning algorithm to compute the main socket
send buffer size as the sum of all the subflows buffer size.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 25 ++++++++++++++++++++++++-
 net/mptcp/protocol.h | 32 +++++++++++++++++++++++++++-----
 net/mptcp/subflow.c  |  3 +--
 3 files changed, 52 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3a905c122306..180755c8c4d1 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -891,6 +891,7 @@ static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
 	mptcp_sockopt_sync_locked(msk, ssk);
 	mptcp_subflow_joined(msk, ssk);
 	mptcp_stop_tout_timer(sk);
+	__mptcp_propagate_sndbuf(sk, ssk);
 	return true;
 }
 
@@ -2403,6 +2404,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		 * disconnect should never fail
 		 */
 		WARN_ON_ONCE(tcp_disconnect(ssk, 0));
+		__mptcp_propagate_sndbuf(sk, ssk);
 		mptcp_subflow_ctx_reset(subflow);
 		release_sock(ssk);
 
@@ -2427,6 +2429,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	}
 
 out_release:
+	__mptcp_update_sndbuf(sk, -subflow->cached_sndbuf);
 	__mptcp_subflow_error_report(sk, ssk);
 	release_sock(ssk);
 
@@ -3214,7 +3217,7 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	 * uses the correct data
 	 */
 	mptcp_copy_inaddrs(nsk, ssk);
-	mptcp_propagate_sndbuf(nsk, ssk);
+	__mptcp_propagate_sndbuf(nsk, ssk);
 
 	mptcp_rcv_space_init(msk, ssk);
 	bh_unlock_sock(nsk);
@@ -3339,6 +3342,14 @@ void __mptcp_check_push(struct sock *sk, struct sock *ssk)
 		__set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->cb_flags);
 }
 
+static void __mptcp_tune_sndbuf(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+
+	__mptcp_update_sndbuf(sk, msk->delta_sndbuf);
+	msk->delta_sndbuf = 0;
+}
+
 #define MPTCP_FLAGS_PROCESS_CTX_NEED (BIT(MPTCP_PUSH_PENDING) | \
 				      BIT(MPTCP_RETRANSMIT) | \
 				      BIT(MPTCP_FLUSH_JOIN_LIST))
@@ -3392,6 +3403,8 @@ static void mptcp_release_cb(struct sock *sk)
 			__mptcp_set_connected(sk);
 		if (__test_and_clear_bit(MPTCP_ERROR_REPORT, &msk->cb_flags))
 			__mptcp_error_report(sk);
+		if (__test_and_clear_bit(MPTCP_TUNE_SNDBUF, &msk->cb_flags))
+			__mptcp_tune_sndbuf(sk);
 	}
 
 	__mptcp_update_rmem(sk);
@@ -3437,6 +3450,15 @@ void mptcp_subflow_process_delegated(struct sock *ssk)
 		mptcp_data_unlock(sk);
 		mptcp_subflow_delegated_done(subflow, MPTCP_DELEGATE_SEND);
 	}
+	if (test_bit(MPTCP_DELEGATE_SNDBUF, &subflow->delegated_status)) {
+		mptcp_data_lock(sk);
+		if (!sock_owned_by_user(sk))
+			__mptcp_propagate_sndbuf(sk, ssk);
+		else
+			__set_bit(MPTCP_TUNE_SNDBUF, &mptcp_sk(sk)->cb_flags);
+		mptcp_data_unlock(sk);
+		mptcp_subflow_delegated_done(subflow, MPTCP_DELEGATE_SNDBUF);
+	}
 	if (test_bit(MPTCP_DELEGATE_ACK, &subflow->delegated_status)) {
 		schedule_3rdack_retransmission(ssk);
 		mptcp_subflow_delegated_done(subflow, MPTCP_DELEGATE_ACK);
@@ -3523,6 +3545,7 @@ bool mptcp_finish_join(struct sock *ssk)
 	/* active subflow, already present inside the conn_list */
 	if (!list_empty(&subflow->node)) {
 		mptcp_subflow_joined(msk, ssk);
+		mptcp_propagate_sndbuf(parent, ssk);
 		return true;
 	}
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index aebc0cc24dad..02fb8b22c4ee 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -123,6 +123,7 @@
 #define MPTCP_RETRANSMIT	4
 #define MPTCP_FLUSH_JOIN_LIST	5
 #define MPTCP_CONNECTED		6
+#define MPTCP_TUNE_SNDBUF	7
 
 struct mptcp_skb_cb {
 	u64 map_seq;
@@ -320,6 +321,7 @@ struct mptcp_sock {
 		u64	rtt_us; /* last maximum rtt of subflows */
 	} rcvq_space;
 	u8		scaling_ratio;
+	int		delta_sndbuf;
 
 	u32		subflow_id;
 	u32		setsockopt_seq;
@@ -446,6 +448,7 @@ DECLARE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
 
 #define MPTCP_DELEGATE_SEND		0
 #define MPTCP_DELEGATE_ACK		1
+#define MPTCP_DELEGATE_SNDBUF		2
 
 /* MPTCP subflow context */
 struct mptcp_subflow_context {
@@ -518,6 +521,7 @@ struct mptcp_subflow_context {
 
 	u32	setsockopt_seq;
 	u32	stale_rcv_tstamp;
+	int     cached_sndbuf;
 
 	struct	sock *tcp_sock;	    /* tcp sk backpointer */
 	struct	sock *conn;	    /* parent mptcp_sock */
@@ -780,13 +784,31 @@ static inline bool mptcp_data_fin_enabled(const struct mptcp_sock *msk)
 	       READ_ONCE(msk->write_seq) == READ_ONCE(msk->snd_nxt);
 }
 
-static inline bool mptcp_propagate_sndbuf(struct sock *sk, struct sock *ssk)
+static inline void __mptcp_update_sndbuf(struct sock *sk, int delta)
 {
-	if ((sk->sk_userlocks & SOCK_SNDBUF_LOCK) || ssk->sk_sndbuf <= READ_ONCE(sk->sk_sndbuf))
-		return false;
+	if (!(sk->sk_userlocks & SOCK_SNDBUF_LOCK) && delta)
+		WRITE_ONCE(sk->sk_sndbuf, sk->sk_sndbuf + delta);
+}
+
+static inline void __mptcp_propagate_sndbuf(struct sock *sk, struct sock *ssk)
+{
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+	int ssk_sndbuf = READ_ONCE(ssk->sk_sndbuf);
+
+	__mptcp_update_sndbuf(sk, ssk_sndbuf - subflow->cached_sndbuf);
+	subflow->cached_sndbuf = ssk_sndbuf;
+}
+
+static inline void mptcp_propagate_sndbuf(struct sock *sk, struct sock *ssk)
+{
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+
+	if (likely(READ_ONCE(ssk->sk_sndbuf) == subflow->cached_sndbuf))
+		return;
 
-	WRITE_ONCE(sk->sk_sndbuf, ssk->sk_sndbuf);
-	return true;
+	local_bh_disable();
+	mptcp_subflow_delegate(subflow, MPTCP_DELEGATE_SNDBUF);
+	local_bh_enable();
 }
 
 static inline void mptcp_write_space(struct sock *sk)
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 1c7ff7247bc0..5a901f14e1d7 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -421,6 +421,7 @@ static bool subflow_use_different_dport(struct mptcp_sock *msk, const struct soc
 
 void __mptcp_set_connected(struct sock *sk)
 {
+	__mptcp_propagate_sndbuf(sk, mptcp_sk(sk)->first);
 	if (sk->sk_state == TCP_SYN_SENT) {
 		inet_sk_state_store(sk, TCP_ESTABLISHED);
 		sk->sk_state_change(sk);
@@ -472,7 +473,6 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 		return;
 
 	msk = mptcp_sk(parent);
-	mptcp_propagate_sndbuf(parent, sk);
 	subflow->rel_write_seq = 1;
 	subflow->conn_finished = 1;
 	subflow->ssn_offset = TCP_SKB_CB(skb)->seq;
@@ -1728,7 +1728,6 @@ static void subflow_state_change(struct sock *sk)
 
 	msk = mptcp_sk(parent);
 	if (subflow_simultaneous_connect(sk)) {
-		mptcp_propagate_sndbuf(parent, sk);
 		mptcp_do_fallback(sk);
 		mptcp_rcv_space_init(msk, sk);
 		pr_fallback(msk);
-- 
2.41.0

