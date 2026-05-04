Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D426D1ADC83
	for <mptcp@lists.linux.dev>; Mon,  4 May 2026 15:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777909233; cv=none; b=A19R2BG/epwNd/788zcariiDG6nwrzFXeZacxqmtFGUT3hecSmd7K2YtpZf4t5fbH3Bs8KwZ4f0EAKlR2NfzjeBh5p1GlqkR90d39dMn+A1iu5Zr2VYhjeqj/tC+3j35JZ03AJq0mw0/X9ZaSxR2tZBesgGdwVcf+BvLmtz0EqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777909233; c=relaxed/simple;
	bh=ASAzDuadUJnVtyaPF0pfuMsXwUp/oGz9Xmbb2yzRWvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=SsI/+v4qD3lB0AsPnbRBGD6ImbzVNhYD7lnsAPp0boiz6zmUlMN7RbXLnBmR8BeeMQX4i+WoXYxsip09NkgwxMcvpzvLUuAXt1XXOVRUmnOJ0GZMjyAnSd+M5T8De6qfhwWfwbTWbySG3dJpd45HL3GpYo2Iy1ScJk0Ola7WwwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DiOmn+5p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DiOmn+5p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777909231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zXks0lGydBj7jlcvDwgPDMkhrPLzAjWV8sxn1OOvL7g=;
	b=DiOmn+5pYj9z1kyeg901xbP29qVu1i+iMOpMQgO57MgRRw7BcZA7GCD+Y8b6/wmF6KI8Au
	YSvZULmURlaZrdTq53WphmIKLxh5GTbDrvGsB0zIAupoxrJJDMrVajS+wqyYaJKSSkOeLK
	KA4GgsIuW+GObCuyl0eS+ZXKvWMhQDA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-490-V2FnvOkuPlGw3KtIXfMXFA-1; Mon,
 04 May 2026 11:40:29 -0400
X-MC-Unique: V2FnvOkuPlGw3KtIXfMXFA-1
X-Mimecast-MFC-AGG-ID: V2FnvOkuPlGw3KtIXfMXFA_1777909228
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A8631195609F;
	Mon,  4 May 2026 15:40:28 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.49.107])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6279E19560A6;
	Mon,  4 May 2026 15:40:27 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>,
	gang.yan@linux.dev
Subject: [PATCH v3 mptcp-next 07/10] mptcp: implemented OoO queue pruning
Date: Mon,  4 May 2026 17:40:02 +0200
Message-ID: <6c7a1e7d307c948d10ad2e5b18e820d87ecfc384.1777908248.git.pabeni@redhat.com>
In-Reply-To: <cover.1777908248.git.pabeni@redhat.com>
References: <cover.1777908248.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _k-ho8-jITAjyitXTpSjvtoYvTHjgdg_ONdPzuC0V-A_1777909228
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
---
 net/mptcp/mib.c      |  3 ++
 net/mptcp/mib.h      |  3 ++
 net/mptcp/options.c  | 42 ++++++++++++++++++++++++---
 net/mptcp/protocol.c | 69 ++++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h |  2 ++
 5 files changed, 115 insertions(+), 4 deletions(-)

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
index ad4bb6fd86e1..607451166d77 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1159,8 +1159,12 @@ static bool add_addr_hmac_valid(struct mptcp_sock *msk,
 }
 
 static bool mptcp_over_limit(struct sock *sk, const struct sock *ssk,
-			     const struct sk_buff *skb)
+			     const struct sk_buff *skb,
+			     const struct mptcp_options_received *mp_opt)
 {
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	bool ret;
+
 	if (likely(sk_rmem_alloc_get(sk) <= READ_ONCE(sk->sk_rcvbuf)))
 		return false;
 
@@ -1170,7 +1174,33 @@ static bool mptcp_over_limit(struct sock *sk, const struct sock *ssk,
 	    !after(TCP_SKB_CB(skb)->end_seq, tcp_sk(ssk)->rcv_nxt))
 		return false;
 
-	return true;
+	mptcp_data_lock(sk);
+	if (!sock_owned_by_user(sk)) {
+		/* When the data sequence is not (yet) available for the
+		 * incoming skb, allow pruning the whole OoO queue.
+		 */
+		u32 seq = !mp_opt->use_map || mp_opt->mpc_map ? msk->ack_seq :
+			  mp_opt->data_seq;
+
+		/* Be sure TFO skb sequence number is in-sync, as the
+		 * TCP pruning helper will be badly fouled otherwise.
+		 */
+		if (unlikely(msk->rcvd_dummy_seq))
+			__mptcp_sync_rcv_sequence(sk);
+
+		__mptcp_check_prune(sk, seq);
+		ret = sk_rmem_alloc_get(sk) > READ_ONCE(sk->sk_rcvbuf);
+	} else {
+		u64 limit = ((u64)READ_ONCE(sk->sk_rcvbuf)) << 1;
+
+		/* Pruning will take place later in the RX path, allow
+		 * some extra slack.
+		 */
+		ret = sk_rmem_alloc_get(sk) > limit;
+		__set_bit(MPTCP_PRUNE, &msk->cb_flags);
+	}
+	mptcp_data_unlock(sk);
+	return ret;
 }
 
 /* Return false when the caller must drop the packet, i.e. in case of error,
@@ -1201,7 +1231,11 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
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
@@ -1281,7 +1315,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 		return true;
 	}
 
-	if (mptcp_over_limit(subflow->conn, sk, skb))
+	if (mptcp_over_limit(subflow->conn, sk, skb, &mp_opt))
 		return false;
 
 	mpext = skb_ext_add(skb, SKB_EXT_MPTCP);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 048d556d75e1..f4015a949f6f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -386,6 +386,67 @@ void __mptcp_sync_rcv_sequence(struct sock *sk)
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
+	if (likely(atomic_read(&sk->sk_rmem_alloc) < sk->sk_rcvbuf))
+		return false;
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
@@ -400,6 +461,12 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 	if (unlikely(msk->rcvd_dummy_seq))
 		__mptcp_sync_rcv_sequence(sk);
 
+	if (__mptcp_check_prune(sk, MPTCP_SKB_CB(skb)->map_seq)) {
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
+		mptcp_drop(sk, skb);
+		return false;
+	}
+
 	if (MPTCP_SKB_CB(skb)->map_seq64 == msk->ack_seq) {
 		/* in sequence */
 		msk->bytes_received += copy_len;
@@ -3701,6 +3768,8 @@ static void mptcp_release_cb(struct sock *sk)
 			msk->copied_seq += mptcp_iasn(msk);
 			__mptcp_sync_rcv_sequence(sk);
 		}
+		if (__test_and_clear_bit(MPTCP_PRUNE, &msk->cb_flags))
+			__mptcp_check_prune(sk, msk->ack_seq - 1);
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

