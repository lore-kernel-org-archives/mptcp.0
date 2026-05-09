Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722C937AA98
	for <mptcp@lists.linux.dev>; Sat,  9 May 2026 07:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778312968; cv=none; b=HiaS1bOQx9ZEQUtFowYjKcXlBYSFIqeuKNOXZC0pvi7QtsmPkOJM/6irK57hjmroHhc0oGiS2Am00LTnzUphoZRoYmBL2RBODRyC0axgjYeUBR5hqM22Qe6ibsBbY/kRJWgI2jrRMt+NacCZExnMpo5JxjPqlTavW9pgz6d0RP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778312968; c=relaxed/simple;
	bh=g15amtVo3sD45psbFPdkeJWrQqY2ebGG/5yLClHvK3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=q4Dup6TcNCMJQEHFGIyhNSW4+tl8Zx1XWR5raMTui5oAkiQmzutYHrFogn9MKBriKjAxzgSMAEmn5US5mjU4xCUdBauQtzXMDGwmS1zERxo4ji8kVGJuRojyN6eINZadex4pvqqJtn1oVxzri86ytGYvUTYbr7rbqISmB6e7hn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dUf7AZqZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dUf7AZqZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778312965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x/egfToxNaYd2WeWloTD+USy3SRE+oESIt6EnJRKBPk=;
	b=dUf7AZqZbIus595TNIS59X28DOLgiPUhxb2NsDV7DK0OYMK8UtK/T3bn5EEv8vE4HPDFCJ
	cDc9Q/5Lprt2RvdO+BewaLN1yYZgzxPi5K4nO5m2CFiiWEVh5xpb6dcngOGAos/MmXKMpM
	D7BNb/bKv1gCwQc/tWtvsCca2hQ5tGg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-k_XiRgoXOai_S6M78g8joA-1; Sat,
 09 May 2026 03:49:22 -0400
X-MC-Unique: k_XiRgoXOai_S6M78g8joA-1
X-Mimecast-MFC-AGG-ID: k_XiRgoXOai_S6M78g8joA_1778312961
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 427BE1956061;
	Sat,  9 May 2026 07:49:21 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.24])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3E62318004A3;
	Sat,  9 May 2026 07:49:20 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Shardul Bankar <shardul.b@mpiricsoftware.com>
Subject: [PATCH mptcp-next 09/12] mptcp: implemented OoO queue pruning
Date: Sat,  9 May 2026 09:48:29 +0200
Message-ID: <2f2a0f359e54d949cf90ebb92cc3886693b00bda.1778312843.git.pabeni@redhat.com>
In-Reply-To: <cover.1778312843.git.pabeni@redhat.com>
References: <cover.1778312843.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CJcAFDwpUb0CbCDdOJf1dAT67DwtuR7pygGSGj0qLPk_1778312961
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Leverage the hybrid helpers to implement the receive queue and OoO queue
collapsing at ingress time when reaching memory bounds.

If the msk is owned by the user-space at incoming skb time, perform the
pruning in the release_cb. The prune check is additionally performed
when the skb reaches the msk-level queues.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v2 -> v3:
 - deal with unsynced TFO skb at prune time - only possible when pruning
   in mptcp_over_limit()

v1 -> v2:
 - collapse rcv queue, too
 - deal with MPC map, too
 - drop left-over sentence in the commit message

RFC -> v1:
 - use data_seq only when available
 - avoid ack_seq lockless access
 - drop limit on fallback
 - collapse rcvqueue, too
 - drop only when pruning is not possible and over rcvbuf * 2

Note:
 - sashiko can be confused about fwd memory lifecycle (I can
 understand that :). Any exceeding amount of fwd allocated memory
 is always released by the next sk_mem_uncharge() - i.e. fwd memory
 is not tied to the current skb.
---
 net/mptcp/mib.c      |  3 +++
 net/mptcp/mib.h      |  3 +++
 net/mptcp/options.c  | 49 +++++++++++++++++++++++++++++-----
 net/mptcp/protocol.c | 62 ++++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h |  2 ++
 5 files changed, 112 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index f23fda0c55a7..5128feec942c 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -85,6 +85,9 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("SimultConnectFallback", MPTCP_MIB_SIMULTCONNFALLBACK),
 	SNMP_MIB_ITEM("FallbackFailed", MPTCP_MIB_FALLBACKFAILED),
 	SNMP_MIB_ITEM("WinProbe", MPTCP_MIB_WINPROBE),
+	SNMP_MIB_ITEM("OfoPruned", MPTCP_MIB_OFO_PRUNED),
+	SNMP_MIB_ITEM("RcvPruned", MPTCP_MIB_RCVPRUNED),
+	SNMP_MIB_ITEM("RcvCollapsed", MPTCP_MIB_RCVCOLLAPSED),
 };
 
 /* mptcp_mib_alloc - allocate percpu mib counters
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 812218b5ed2b..2f8f68e33ac5 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -88,6 +88,9 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_SIMULTCONNFALLBACK,	/* Simultaneous connect */
 	MPTCP_MIB_FALLBACKFAILED,	/* Can't fallback due to msk status */
 	MPTCP_MIB_WINPROBE,		/* MPTCP-level zero window probe */
+	MPTCP_MIB_OFO_PRUNED,		/* MPTCP-level OoO queue pruned */
+	MPTCP_MIB_RCVPRUNED,		/* Dropped due to memory constrains */
+	MPTCP_MIB_RCVCOLLAPSED,		/* Collapsed due to memory pressure */
 	__MPTCP_MIB_MAX
 };
 
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 19c0bc92f04e..d7e712171d3b 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1159,9 +1159,12 @@ static bool add_addr_hmac_valid(struct mptcp_sock *msk,
 }
 
 static bool mptcp_over_limit(struct sock *sk, struct sock *ssk,
-			     const struct sk_buff *skb)
+			     const struct sk_buff *skb,
+			     const struct mptcp_options_received *mp_opt)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	u64 limit;
+	bool ret;
 
 	if (likely(sk_rmem_alloc_get(sk) + READ_ONCE(msk->backlog_len) <=
 		   READ_ONCE(sk->sk_rcvbuf)))
@@ -1173,10 +1176,38 @@ static bool mptcp_over_limit(struct sock *sk, struct sock *ssk,
 	    !after(TCP_SKB_CB(skb)->end_seq, tcp_sk(ssk)->rcv_nxt))
 		return false;
 
-	/* Dropped due to memory constraints, schedule an ack. */
-	inet_csk(ssk)->icsk_ack.pending |= ICSK_ACK_NOMEM | ICSK_ACK_NOW;
-	inet_csk_schedule_ack(ssk);
-	return true;
+	mptcp_data_lock(sk);
+	if (!sock_owned_by_user(sk)) {
+		/* When the data sequence is not (yet) available for the
+		 * incoming skb, allow pruning the whole OoO queue.
+		 */
+		u32 seq = (u32)((!mp_opt->use_map || mp_opt->mpc_map) ?
+				msk->ack_seq : mp_opt->data_seq);
+
+		/* Be sure TFO skb sequence number is in-sync, as the
+		 * TCP pruning helper will be badly fouled otherwise.
+		 */
+		if (unlikely(msk->rcvd_dummy_seq))
+			__mptcp_sync_rcv_sequence(sk);
+
+		limit = sk->sk_rcvbuf;
+		__mptcp_check_prune(sk, seq);
+	} else {
+		/* Pruning will take place later in the RX path, allow
+		 * some extra slack.
+		 */
+		limit = ((u64)READ_ONCE(sk->sk_rcvbuf)) << 1;
+		__set_bit(MPTCP_PRUNE, &msk->cb_flags);
+	}
+	ret = sk_rmem_alloc_get(sk) + msk->backlog_len > limit;
+	mptcp_data_unlock(sk);
+
+	if (ret) {
+		/* Dropped due to memory constraints, schedule an ack. */
+		inet_csk(ssk)->icsk_ack.pending |= ICSK_ACK_NOMEM | ICSK_ACK_NOW;
+		inet_csk_schedule_ack(ssk);
+	}
+	return ret;
 }
 
 /* Return false when the caller must drop the packet, i.e. in case of error,
@@ -1207,7 +1238,11 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 		__mptcp_data_acked(subflow->conn);
 		mptcp_data_unlock(subflow->conn);
 
-		if (mptcp_over_limit(subflow->conn, sk, skb))
+		/* Will use ack_seq as limit for OoO pruning; any value would do
+		 * as OoO queue must be empty.
+		 */
+		mp_opt.use_map = 0;
+		if (mptcp_over_limit(subflow->conn, sk, skb, &mp_opt))
 			return false;
 		return true;
 	}
@@ -1287,7 +1322,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 		return true;
 	}
 
-	if (mptcp_over_limit(subflow->conn, sk, skb))
+	if (mptcp_over_limit(subflow->conn, sk, skb, &mp_opt))
 		return false;
 
 	mpext = skb_ext_add(skb, SKB_EXT_MPTCP);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f03f967d8679..d9aab7bbff98 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -386,6 +386,64 @@ void __mptcp_sync_rcv_sequence(struct sock *sk)
 	MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq + skb->len;
 }
 
+/* "Inspired" from the TCP version */
+static void mptcp_prune_ofo_queue(struct sock *sk, u32 seq)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct rb_node *node, *prev;
+	bool pruned = false;
+
+	if (RB_EMPTY_ROOT(&msk->out_of_order_queue))
+		return;
+
+	node = &msk->ooo_last_skb->rbnode;
+
+	do {
+		struct sk_buff *skb = rb_to_skb(node);
+
+		/* Stop pruning if the incoming skb would land in OoO tail. */
+		if (after(seq, MPTCP_SKB_CB(skb)->map_seq))
+			break;
+
+		pruned = true;
+		prev = rb_prev(node);
+		rb_erase(node, &msk->out_of_order_queue);
+		mptcp_drop(sk, skb);
+		msk->ooo_last_skb = rb_to_skb(prev);
+		if (atomic_read(&sk->sk_rmem_alloc) < sk->sk_rcvbuf)
+			break;
+
+		node = prev;
+	} while (node);
+
+	if (pruned)
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_OFO_PRUNED);
+}
+
+bool __mptcp_check_prune(struct sock *sk, u32 seq)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	unsigned int dropped;
+
+	dropped = xtcp_collapse_ofo_queue(sk, &msk->out_of_order_queue,
+					  &msk->ooo_last_skb,
+					  msk->scaling_ratio);
+	if (!skb_queue_empty(&sk->sk_receive_queue))
+		dropped += xtcp_collapse(sk, &sk->sk_receive_queue, NULL,
+					 skb_peek(&sk->sk_receive_queue),
+					 NULL,
+					 msk->copied_seq, msk->ack_seq,
+					 msk->scaling_ratio);
+
+	if (dropped)
+		MPTCP_ADD_STATS(sock_net(sk), MPTCP_MIB_RCVCOLLAPSED, dropped);
+	if (likely(atomic_read(&sk->sk_rmem_alloc) < sk->sk_rcvbuf))
+		return false;
+
+	mptcp_prune_ofo_queue(sk, seq);
+	return atomic_read(&sk->sk_rmem_alloc) >= sk->sk_rcvbuf;
+}
+
 static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 {
 	u32 copy_len = MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_seq;
@@ -404,7 +462,9 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 	 * will break.
 	 */
 	if (unlikely(sk_rmem_alloc_get(sk) > READ_ONCE(sk->sk_rcvbuf)) &&
+	    __mptcp_check_prune(sk, MPTCP_SKB_CB(skb)->map_seq) &&
 	    !__mptcp_check_fallback(msk)) {
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
 		mptcp_drop(sk, skb);
 		return false;
 	}
@@ -3718,6 +3778,8 @@ static void mptcp_release_cb(struct sock *sk)
 			msk->copied_seq += mptcp_iasn(msk);
 			__mptcp_sync_rcv_sequence(sk);
 		}
+		if (__test_and_clear_bit(MPTCP_PRUNE, &msk->cb_flags))
+			__mptcp_check_prune(sk, (u32)(msk->ack_seq - 1));
 	}
 }
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 6786da97bbc8..ae019a10e1c8 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -125,6 +125,7 @@
 #define MPTCP_SYNC_STATE	6
 #define MPTCP_SYNC_SNDBUF	7
 #define MPTCP_SYNC_SEQ		8
+#define MPTCP_PRUNE		9
 
 struct mptcp_skb_cb {
 	u32 map_seq;
@@ -832,6 +833,7 @@ bool __mptcp_close(struct sock *sk, long timeout);
 void mptcp_cancel_work(struct sock *sk);
 void __mptcp_unaccepted_force_close(struct sock *sk);
 void mptcp_set_state(struct sock *sk, int state);
+bool __mptcp_check_prune(struct sock *sk, u32 seq);
 
 bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
 			   const struct mptcp_addr_info *b, bool use_port);
-- 
2.54.0

