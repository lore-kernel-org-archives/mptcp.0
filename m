Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C171C428494
	for <mptcp@lists.linux.dev>; Fri, 15 May 2026 09:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778836072; cv=none; b=u3TS8cLPjx6KwOuAlzOGnR5iAuNzOA/u3kzYt8fQU4qewta0MMYowKV+Bvgf0kr3XuWUh0hMSmkulucMcXCGrRdfqquMrWfG+u5hYfr5KFaLReiITXmS4NgDBVlSoCFTfsw4GyaSw5H4QPajX1op+tvOOHJfxU43IzwwjO5crqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778836072; c=relaxed/simple;
	bh=TF8oCtvLfG4NNTUv5N1rpZKtVxwsm05TnexBWy6Rz/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=tAA8lMX1TjfWmROpuTzOcRNLqO1v4hCPjiAeL5MCuZja+E7WkzX+HCrQ6Z+FGuPb8sC+QnSuiUWaPAZzddyfHe+A6R31jOOM4nwc0QX/p08VYAqZbzCQ95T5Q4600iBpF0wt930RAOwEbMxgTKYAA026gKite2yOvw42jXcbxNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oqgto5LX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oqgto5LX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778836069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LzEOe6S2q3TV+VVnQV5YJrigM80s2NzuN9n98r4GebY=;
	b=Oqgto5LXWOZxnyfKjbE17SawzhhRN3iY5ct21CmHdpf1jOVLyGOjjVWibjG9zDBg0vH8sD
	trc/ZO9uDroDeOTjvEjmcGBS3MK3jsbCHTUGWlUK57CWk8Qhjfs0bb3vhxRS0IoJk9hmSF
	otqCErEbThNLpKhazcDk9RxHrB0m9QM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-530-7MzPqh02OWGvbfDh6BmmnA-1; Fri,
 15 May 2026 05:07:48 -0400
X-MC-Unique: 7MzPqh02OWGvbfDh6BmmnA-1
X-Mimecast-MFC-AGG-ID: 7MzPqh02OWGvbfDh6BmmnA_1778836067
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 22A341956080;
	Fri, 15 May 2026 09:07:47 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.244])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DAA7F1800347;
	Fri, 15 May 2026 09:07:45 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>,
	gang.yan@linux.dev
Subject: [PATCH v6 mptcp-next 4/7] mptcp: implemented OoO queue pruning
Date: Fri, 15 May 2026 11:07:25 +0200
Message-ID: <5b21b1148406d07e32e89a5c611f47c749b5ae41.1778835009.git.pabeni@redhat.com>
In-Reply-To: <cover.1778835009.git.pabeni@redhat.com>
References: <cover.1778835009.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sbcCV56eClOZFuG2LVZG-A0RvYPz_lDLxSXDZrONRII_1778836067
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
 - sashiko is also fooled by the main xtcp_collapse_ofo_queue()
 loop: ooo_last_skb is always kept up2date with the current tree
 status
 - AFAICS KASAN handles bitmap variables in a sane way, and sashiko
 doesn't know about that
---
 net/mptcp/mib.c      |  2 ++
 net/mptcp/mib.h      |  2 ++
 net/mptcp/options.c  | 42 +++++++++++++++++++++++++++++++++++-------
 net/mptcp/protocol.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h |  1 +
 5 files changed, 82 insertions(+), 7 deletions(-)

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
index 36f12e5dfa92..ec64e1a127d7 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1159,10 +1159,13 @@ static bool add_addr_hmac_valid(struct mptcp_sock *msk,
 }
 
 static bool mptcp_over_limit(struct sock *sk, struct sock *ssk,
-			     const struct sk_buff *skb)
+			     const struct sk_buff *skb,
+			     const struct mptcp_options_received *mp_opt)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	u64 mem = sk_rmem_alloc_get(sk);
+	u64 limit;
+	bool ret;
 
 	mem += READ_ONCE(msk->backlog_len);
 	if (likely(mem <= READ_ONCE(sk->sk_rcvbuf)))
@@ -1174,10 +1177,31 @@ static bool mptcp_over_limit(struct sock *sk, struct sock *ssk,
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
+		__mptcp_check_prune(sk, seq);
+	} else {
+		/* Pruning will take place later in the RX path, allow
+		 * some extra slack.
+		 */
+		limit = ((u64)READ_ONCE(sk->sk_rcvbuf)) << 1;
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
@@ -1208,7 +1232,11 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
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
@@ -1288,7 +1316,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 		return true;
 	}
 
-	if (mptcp_over_limit(subflow->conn, sk, skb))
+	if (mptcp_over_limit(subflow->conn, sk, skb, &mp_opt))
 		return false;
 
 	mpext = skb_ext_add(skb, SKB_EXT_MPTCP);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 78b8bcac7d91..b79dd4c4fe31 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -373,6 +373,46 @@ static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
 	skb_dst_drop(skb);
 }
 
+/* "Inspired" from the TCP version */
+static void mptcp_prune_ofo_queue(struct sock *sk, u64 seq)
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
+bool __mptcp_check_prune(struct sock *sk, u64 seq)
+{
+	mptcp_prune_ofo_queue(sk, seq);
+	return atomic_read(&sk->sk_rmem_alloc) >= sk->sk_rcvbuf;
+}
+
 static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 {
 	u64 copy_len = MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_seq;
@@ -385,7 +425,9 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 	 * will break.
 	 */
 	if (unlikely(sk_rmem_alloc_get(sk) > READ_ONCE(sk->sk_rcvbuf)) &&
+	    __mptcp_check_prune(sk, MPTCP_SKB_CB(skb)->map_seq) &&
 	    !__mptcp_check_fallback(msk)) {
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
 		mptcp_drop(sk, skb);
 		return false;
 	}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 661600f8b573..95774a4e7231 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -827,6 +827,7 @@ bool __mptcp_close(struct sock *sk, long timeout);
 void mptcp_cancel_work(struct sock *sk);
 void __mptcp_unaccepted_force_close(struct sock *sk);
 void mptcp_set_state(struct sock *sk, int state);
+bool __mptcp_check_prune(struct sock *sk, u64 seq);
 
 bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
 			   const struct mptcp_addr_info *b, bool use_port);
-- 
2.54.0

