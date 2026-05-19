Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339BF367B7C
	for <mptcp@lists.linux.dev>; Tue, 19 May 2026 17:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779210124; cv=none; b=RP1ZRD3+nlWAQQ+EytWeoCctkYiag7qYOIYAa1pi99gjFgtA/lDL5vjrmp265FzbcQhgmNY5CTVeXHJZFG6mIM4hVIkE/GBhfODmZws3BynleBclGh/jKFU8AJKlLK0ew/zDr1Tu2dXwG5lt9jOQyZ5EdkGa++iEva+FXRj25zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779210124; c=relaxed/simple;
	bh=Dbys4msg2XHqEsXPj513Rikb/yzZc336uo63BxCohlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=K6myhB2BYLvNQoEHwR80x1jy+UzzGokjb30da0v3tOUBqxqYbZ9s5g05bwa79KHoNTwGVcOTa+ZZYMCYUsGQDTUbo4u/un7IPIUxiIFhOuacdxpwcDDIf2V/9nNGMsZQe/La7YRwzd/CcqJ+i6TxoBMHZfuxYydw7n6BZYGZsS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H7PfQfIn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H7PfQfIn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779210122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/2GuRJXq9DGhHB5puJfIDLa/MIkr43VvTE9O9X/FCP4=;
	b=H7PfQfInpJUC3G/e4xnbS2cZiAn0TlULoJFg3L1729hvAORUhT1cDkSJZpaOMHpIHbd4Hu
	OQHRW/vyiuQ6W8p/s5GM2W4d9ZV3CblFPH7WH4g567FrJ2wUhd3zV1o6DAz3phP4GpeB5o
	lnGHW9McXeA9BLrVpwTa0pWH2ngbhEI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-vrtG4HvbPAqDOE0ZWNq3CQ-1; Tue,
 19 May 2026 13:01:58 -0400
X-MC-Unique: vrtG4HvbPAqDOE0ZWNq3CQ-1
X-Mimecast-MFC-AGG-ID: vrtG4HvbPAqDOE0ZWNq3CQ_1779210116
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E9F2819560B1;
	Tue, 19 May 2026 17:01:54 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.47])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9897118004A3;
	Tue, 19 May 2026 17:01:53 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>,
	gang.yan@linux.dev
Subject: [PATCH v7 mptcp-next 4/7] mptcp: implemented OoO queue pruning
Date: Tue, 19 May 2026 19:01:38 +0200
Message-ID: <9c0a479fab5bf36d8d8b098bf5c65fac4352fc42.1779210016.git.pabeni@redhat.com>
In-Reply-To: <cover.1779210016.git.pabeni@redhat.com>
References: <cover.1779210016.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MgqAq7d_pusxDavI3MmFSnlFKd1cYHP8GoE8BH2Hy_g_1779210116
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
v6 -> v7:
 - fix u64 -> u32 truncation

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
 - AFAICS KASAN handles bitmap variables in a sane way, and sashiko
 doesn't know about that
---
 net/mptcp/mib.c      |  2 ++
 net/mptcp/mib.h      |  2 ++
 net/mptcp/options.c  | 44 +++++++++++++++++++++++++++++++--------
 net/mptcp/protocol.c | 49 ++++++++++++++++++++++++++++++++++++++++++--
 net/mptcp/protocol.h |  1 +
 5 files changed, 88 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index f23fda0c55a7..bdc863c3a952 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -85,6 +85,8 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("SimultConnectFallback", MPTCP_MIB_SIMULTCONNFALLBACK),
 	SNMP_MIB_ITEM("FallbackFailed", MPTCP_MIB_FALLBACKFAILED),
 	SNMP_MIB_ITEM("WinProbe", MPTCP_MIB_WINPROBE),
+	SNMP_MIB_ITEM("OfoPruned", MPTCP_MIB_OFO_PRUNED),
+	SNMP_MIB_ITEM("RcvPruned", MPTCP_MIB_RCVPRUNED),
 };
 
 /* mptcp_mib_alloc - allocate percpu mib counters
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 812218b5ed2b..8ec314847fc3 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -88,6 +88,8 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_SIMULTCONNFALLBACK,	/* Simultaneous connect */
 	MPTCP_MIB_FALLBACKFAILED,	/* Can't fallback due to msk status */
 	MPTCP_MIB_WINPROBE,		/* MPTCP-level zero window probe */
+	MPTCP_MIB_OFO_PRUNED,		/* MPTCP-level OoO queue pruned */
+	MPTCP_MIB_RCVPRUNED,		/* Dropped due to memory constrains */
 	__MPTCP_MIB_MAX
 };
 
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 35db19fd6b7a..e5d5a50a907f 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1159,9 +1159,12 @@ static bool add_addr_hmac_valid(struct mptcp_sock *msk,
 }
 
 static bool mptcp_over_limit(struct sock *sk, struct sock *ssk,
-			     const struct sk_buff *skb)
+			     const struct sk_buff *skb,
+			     const struct mptcp_options_received *mp_opt)
 {
-	u64 mem = mptcp_mem(sk);
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	u64 limit, mem = mptcp_mem(sk);
+	bool ret;
 
 	/* sk_rcvbuf is ensured to be >= 0 and <= MAX_INT. */
 	if (likely(mem <= READ_ONCE(sk->sk_rcvbuf)))
@@ -1173,10 +1176,31 @@ static bool mptcp_over_limit(struct sock *sk, struct sock *ssk,
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
+		u64 seq = (!mp_opt->use_map || mp_opt->mpc_map) ?
+			  msk->ack_seq : mp_opt->data_seq;
+
+		limit = sk->sk_rcvbuf;
+		mptcp_prune_ofo_queue(sk, true, seq);
+	} else {
+		/* Pruning will take place later in the RX path, allow
+		 * some extra slack.
+		 */
+		limit = ((u64)READ_ONCE(sk->sk_rcvbuf)) << 1;
+	}
+	ret = mptcp_mem(sk) > limit;
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
@@ -1207,7 +1231,11 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
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
@@ -1287,7 +1315,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 		return true;
 	}
 
-	if (mptcp_over_limit(subflow->conn, sk, skb))
+	if (mptcp_over_limit(subflow->conn, sk, skb, &mp_opt))
 		return false;
 
 	mpext = skb_ext_add(skb, SKB_EXT_MPTCP);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0e41596b6397..f207f001c97e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -373,6 +373,47 @@ static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
 	skb_dst_drop(skb);
 }
 
+/* "Inspired" from the TCP version */
+void mptcp_prune_ofo_queue(struct sock *sk, bool use_bl, u64 seq)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct rb_node *node, *prev;
+	bool pruned = false;
+	u64 mem;
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
+		if (after64(seq, MPTCP_SKB_CB(skb)->map_seq))
+			break;
+
+		pruned = true;
+		prev = rb_prev(node);
+		rb_erase(node, &msk->out_of_order_queue);
+		mptcp_drop(sk, skb);
+		msk->ooo_last_skb = rb_to_skb(prev);
+
+		/* On early pruning be more strict. */
+		if (use_bl)
+			mem = mptcp_mem(sk);
+		else
+			mem = (unsigned int)atomic_read(&sk->sk_rmem_alloc);
+		if (mem < sk->sk_rcvbuf)
+			break;
+
+		node = prev;
+	} while (node);
+
+	if (pruned)
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_OFO_PRUNED);
+}
+
 static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 {
 	u64 copy_len = MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_seq;
@@ -386,8 +427,12 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 	 */
 	if (unlikely(sk_rmem_alloc_get(sk) > READ_ONCE(sk->sk_rcvbuf)) &&
 	    !__mptcp_check_fallback(msk)) {
-		mptcp_drop(sk, skb);
-		return false;
+		mptcp_prune_ofo_queue(sk, false, MPTCP_SKB_CB(skb)->map_seq);
+		if (sk_rmem_alloc_get(sk) > READ_ONCE(sk->sk_rcvbuf)) {
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
+			mptcp_drop(sk, skb);
+			return false;
+		}
 	}
 
 	if (MPTCP_SKB_CB(skb)->map_seq == msk->ack_seq) {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ef878ceae577..816210ed2630 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -835,6 +835,7 @@ bool __mptcp_close(struct sock *sk, long timeout);
 void mptcp_cancel_work(struct sock *sk);
 void __mptcp_unaccepted_force_close(struct sock *sk);
 void mptcp_set_state(struct sock *sk, int state);
+void mptcp_prune_ofo_queue(struct sock *sk, bool use_bl, u64 seq);
 
 bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
 			   const struct mptcp_addr_info *b, bool use_port);
-- 
2.54.0

