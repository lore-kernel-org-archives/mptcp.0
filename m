Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9FD39B493
	for <mptcp@lists.linux.dev>; Mon, 20 Apr 2026 10:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776681014; cv=none; b=AsYRbG4SSI99faERIpfJUqyLcSc374DMOfPhUvFUuUDARzfD/gQPFAAgR41RS/nPupDcmnlYHXLzr5If3nKaIlHFPLo7eRLoUPNruRLRrhLuyKKV1IBb1K6BfaV1BuXIxuAHm5M7MlpmtbikBJoJ/guV3EGkYzTJ2QHYoNj6shg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776681014; c=relaxed/simple;
	bh=UgHYfQOGttMcgjTDamWiz8RtB3Jd25f931B8VbOqt6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=RSsyhMuJ6YTmQe4ReqmLNr7zyajOjkyuMVpRBnLmjrPowtFv9GAUr0FZV5hxpA1EbARQ5X3swm4R83vRxDr3KiSG/0WwSINJslbWxIh+lBtnzMKHbjiujtTKsfmazsDmfNea/OPdDaXjYMNUpycxGfdmBuRl7MA0J9QxORnWmao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UIXffH1/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UIXffH1/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776681010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=THOubhxGvzPFCHxid3vyMZ0OgwhsBYaBwSDaMbXvTa8=;
	b=UIXffH1/7K2KQ3PWYRpsvwkHeNfXRYxPfdZjWn10yskWDdA28n1EEj3KQ05Tf81Y1DFVQ1
	LSVXkVoZJ0Yv4c2SkjW/Q4IKqAPhtH6EM21lmS+lIVAzJPV/1ZpC7EUkQxkHoFGGaKEcD8
	fRWze2znyUO3oT+VoD+5usTfq/D88oE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-ctzxc9FnOEmjpzYRvymA_w-1; Mon,
 20 Apr 2026 06:30:08 -0400
X-MC-Unique: ctzxc9FnOEmjpzYRvymA_w-1
X-Mimecast-MFC-AGG-ID: ctzxc9FnOEmjpzYRvymA_w_1776681007
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 73B9D195608E;
	Mon, 20 Apr 2026 10:30:07 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.233])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BA57119560AB;
	Mon, 20 Apr 2026 10:30:05 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: yangang@kylinos.cn,
	geliang@kernel.org,
	matttbe@kernel.org
Subject: [RFC PATCH 4/6] mptcp: implemented OoO queue pruning
Date: Mon, 20 Apr 2026 12:29:28 +0200
Message-ID: <c95aafa3889a4c767d18a24e58aaa6811c9e2049.1776680489.git.pabeni@redhat.com>
In-Reply-To: <cover.1776680489.git.pabeni@redhat.com>
References: <cover.1776680489.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hAU75YKEZvH7n_EEQb6r4wC3XJ7ENwjBb8Te5enLBPw_1776681007
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Leverage the hybrid helper to implement the OoO queue prune at
ingress time.

If the msk is owned by the user-space at incoming skb time, perform the
pruning in the release_cb. The prune check is additionally performed
when the skb reaches the msk-level queues.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
Notes:
 - Similarly to path 'mptcp: move checks vs rcvbuf size earlier in the RX
   path', some cleanup/tuning in mptcp_over_limit() will be needed
 - Pruning in the release_cb() is likely not needed, should probably be
   removed (after more testing).
---
 net/mptcp/mib.c      |  3 +++
 net/mptcp/mib.h      |  3 +++
 net/mptcp/options.c  | 22 +++++++++++++---
 net/mptcp/protocol.c | 61 ++++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h |  2 ++
 5 files changed, 87 insertions(+), 4 deletions(-)

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
index a6d290427611..a6a6da262413 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1158,15 +1158,29 @@ static bool add_addr_hmac_valid(struct mptcp_sock *msk,
 	return hmac == mp_opt->ahmac;
 }
 
-static bool mptcp_over_limit(const struct sock *sk, struct sk_buff *skb)
+static bool mptcp_over_limit(struct sock *sk, struct sk_buff *skb, u32 seq)
 {
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	bool ret = true;
 	int limit;
 
 	if (!skb->len)
 		return false;
 
+	/* Allow some slack for backlog processing */
 	limit = READ_ONCE(sk->sk_rcvbuf) << 1;
-	return sk_rmem_alloc_get(sk) > limit;
+	if (sk_rmem_alloc_get(sk) < limit)
+		return false;
+
+	mptcp_data_lock(sk);
+	if (!sock_owned_by_user(sk)) {
+		__mptcp_check_prune(sk, seq);
+		ret = sk_rmem_alloc_get(sk) > READ_ONCE(sk->sk_rcvbuf);
+	} else {
+		__set_bit(MPTCP_PRUNE, &msk->cb_flags);
+	}
+	mptcp_data_unlock(sk);
+	return ret;
 }
 
 /* Return false when the caller must to drop the packet, i.e. in case of error,
@@ -1197,7 +1211,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 		__mptcp_data_acked(subflow->conn);
 		mptcp_data_unlock(subflow->conn);
 
-		if (mptcp_over_limit(subflow->conn, skb))
+		if (mptcp_over_limit(subflow->conn, skb, msk->ack_seq))
 			return false;
 		return true;
 	}
@@ -1277,7 +1291,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 		return true;
 	}
 
-	if (mptcp_over_limit(subflow->conn, skb))
+	if (mptcp_over_limit(subflow->conn, skb, mp_opt.use_map ? mp_opt.data_seq : msk->ack_seq))
 		return false;
 
 	mpext = skb_ext_add(skb, SKB_EXT_MPTCP);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 800aa7d9408e..9cf135e04d69 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -374,6 +374,59 @@ static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
 	skb_dst_drop(skb);
 }
 
+/* "Inspiered" from the TCP version */
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
+		/* If incoming skb would land last in ofo queue, stop pruning. */
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
+		NET_INC_STATS(sock_net(sk), LINUX_MIB_OFOPRUNED);
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
+					  &msk->ooo_last_skb, msk->scaling_ratio);
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
@@ -383,6 +436,12 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 
 	mptcp_borrow_fwdmem(sk, skb);
 
+	if (__mptcp_check_prune(sk, MPTCP_SKB_CB(skb)->map_seq)) {
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
+		mptcp_drop(sk, skb);
+		return false;
+	}
+
 	if (MPTCP_SKB_CB(skb)->map_seq == ack_seq) {
 		/* in sequence */
 		msk->bytes_received += copy_len;
@@ -3693,6 +3752,8 @@ static void mptcp_release_cb(struct sock *sk)
 			__mptcp_error_report(sk);
 		if (__test_and_clear_bit(MPTCP_SYNC_SNDBUF, &msk->cb_flags))
 			__mptcp_sync_sndbuf(sk);
+		if (__test_and_clear_bit(MPTCP_PRUNE, &msk->cb_flags))
+			__mptcp_check_prune(sk, msk->ack_seq - 1);
 	}
 }
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ad906737ee9f..e4bc77de725e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -124,6 +124,7 @@
 #define MPTCP_FLUSH_JOIN_LIST	5
 #define MPTCP_SYNC_STATE	6
 #define MPTCP_SYNC_SNDBUF	7
+#define MPTCP_PRUNE		8
 
 struct mptcp_skb_cb {
 	u32 map_seq;
@@ -828,6 +829,7 @@ bool __mptcp_close(struct sock *sk, long timeout);
 void mptcp_cancel_work(struct sock *sk);
 void __mptcp_unaccepted_force_close(struct sock *sk);
 void mptcp_set_state(struct sock *sk, int state);
+bool __mptcp_check_prune(struct sock *sk, u32 seq);
 
 bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
 			   const struct mptcp_addr_info *b, bool use_port);
-- 
2.53.0

