Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD12F25A62E
	for <mptcp@lists.linux.dev>; Mon, 27 Oct 2025 14:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761577120; cv=none; b=nBQsVS0xpaNJIOgMQioqWgZXJ8gpg5kqTWblJoYS3LpC1MZ3qBY2L3fcrC89vUSJ1pqP3+jrhrs4qwBTXDNdJLRl88phfZ+K4Mx6RGAcG5/yZW3D4t7H5QxR1/LMceQmDTiHvH/0q+znlYI3cavgAuHvR1+UdtNcFXO0ERJU9Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761577120; c=relaxed/simple;
	bh=RbkjZkB/FrAMd4k9miI8xHjwZj0b4qDggwfbE9r150k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=NYm5CEVr782sz6c8WiczxmVJ9l5YVWDvrw7ESwQIMwAW9xYffMAxlFMHI4Ouljor7V7ZFPFFlz7QGGoQgVIYVVi/pmp+dAdgUE/E23ktvzouVney6qE820DAbJf/+QJrXU4XI2yoW7X67Ss4gaO7+ocqc46VntNa+Mwn/s3Y3+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bn+3qfko; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bn+3qfko"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761577117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZCy/4QjaOZmrRReCuFIZW3dwV4HIs+r47Zwy2iUmx10=;
	b=bn+3qfkocW2l1NPOmPn+QAJEq0kPNogdF6dCpVSNeR37tNa23NFmmTJvf5stTFpMijCofJ
	ON5dQltPNzdNYM4aCLuU5Hg6AKtYKfnC+POoX8QJS5nkGt2lKsRzdDXHG71xQIBjQj/r8O
	B9dCcC6FYgQjHFp9cGPyW1ebHFJhdtA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-ygN0PANTPTuxbce9NVnoPQ-1; Mon,
 27 Oct 2025 10:58:34 -0400
X-MC-Unique: ygN0PANTPTuxbce9NVnoPQ-1
X-Mimecast-MFC-AGG-ID: ygN0PANTPTuxbce9NVnoPQ_1761577113
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7775718007EB;
	Mon, 27 Oct 2025 14:58:33 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.10])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 127F319560AD;
	Mon, 27 Oct 2025 14:58:31 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>,
	geliang@kernel.org
Subject: [PATCH RESENT v7 mptcp-next 2/4] mptcp: borrow forward memory from subflow
Date: Mon, 27 Oct 2025 15:58:00 +0100
Message-ID: <501fc84688c32f846e262a9fd44683afa73ea509.1761576117.git.pabeni@redhat.com>
In-Reply-To: <cover.1761576117.git.pabeni@redhat.com>
References: <cover.1761576117.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IdH0EnAM9CJsryLge2eZVlUo0BKEi7MRF5GWkvyTPZ4_1761577113
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

In the MPTCP receive path, we release the subflow allocated fwd
memory just to allocate it again shortly after for the msk.

That could increases the failures chances, especially when we will
add backlog processing, with other actions could consume the just
released memory before the msk socket has a chance to do the
rcv allocation.

Replace the skb_orphan() call with an open-coded variant that
explicitly borrows, the fwd memory from the subflow socket instead
of releasing it.

The borrowed memory does not have PAGE_SIZE granularity; rounding to
the page size will make the fwd allocated memory higher than what is
strictly required and could make the incoming subflow fwd mem
consistently negative. Instead, keep track of the accumulated frag and
borrow the full page at subflow close time.

This allow removing the last drop in the TCP to MPTCP transition and
the associated, now unused, MIB.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/fastopen.c |  4 +++-
 net/mptcp/mib.c      |  1 -
 net/mptcp/mib.h      |  1 -
 net/mptcp/protocol.c | 23 +++++++++++++++--------
 net/mptcp/protocol.h | 23 +++++++++++++++++++++++
 5 files changed, 41 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index b9e451197902..82ec15bcfd7f 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -32,7 +32,8 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 	/* dequeue the skb from sk receive queue */
 	__skb_unlink(skb, &ssk->sk_receive_queue);
 	skb_ext_reset(skb);
-	skb_orphan(skb);
+
+	mptcp_subflow_lend_fwdmem(subflow, skb);
 
 	/* We copy the fastopen data, but that don't belong to the mptcp sequence
 	 * space, need to offset it in the subflow sequence, see mptcp_subflow_get_map_offset()
@@ -50,6 +51,7 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 	mptcp_data_lock(sk);
 	DEBUG_NET_WARN_ON_ONCE(sock_owned_by_user_nocheck(sk));
 
+	mptcp_borrow_fwdmem(sk, skb);
 	skb_set_owner_r(skb, sk);
 	__skb_queue_tail(&sk->sk_receive_queue, skb);
 	mptcp_sk(sk)->bytes_received += skb->len;
diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 171643815076..f23fda0c55a7 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -71,7 +71,6 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("MPFastcloseRx", MPTCP_MIB_MPFASTCLOSERX),
 	SNMP_MIB_ITEM("MPRstTx", MPTCP_MIB_MPRSTTX),
 	SNMP_MIB_ITEM("MPRstRx", MPTCP_MIB_MPRSTRX),
-	SNMP_MIB_ITEM("RcvPruned", MPTCP_MIB_RCVPRUNED),
 	SNMP_MIB_ITEM("SubflowStale", MPTCP_MIB_SUBFLOWSTALE),
 	SNMP_MIB_ITEM("SubflowRecover", MPTCP_MIB_SUBFLOWRECOVER),
 	SNMP_MIB_ITEM("SndWndShared", MPTCP_MIB_SNDWNDSHARED),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index a1d3e9369fbb..812218b5ed2b 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -70,7 +70,6 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_MPFASTCLOSERX,	/* Received a MP_FASTCLOSE */
 	MPTCP_MIB_MPRSTTX,		/* Transmit a MP_RST */
 	MPTCP_MIB_MPRSTRX,		/* Received a MP_RST */
-	MPTCP_MIB_RCVPRUNED,		/* Incoming packet dropped due to memory limit */
 	MPTCP_MIB_SUBFLOWSTALE,		/* Subflows entered 'stale' status */
 	MPTCP_MIB_SUBFLOWRECOVER,	/* Subflows returned to active status after being stale */
 	MPTCP_MIB_SNDWNDSHARED,		/* Subflow snd wnd is overridden by msk's one */
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 74be417be980..f6d96cb01e00 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -349,7 +349,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
 			   int copy_len)
 {
-	const struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	bool has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
 
 	/* the skb map_seq accounts for the skb offset:
@@ -374,11 +374,7 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct sk_buff *tail;
 
-	/* try to fetch required memory from subflow */
-	if (!sk_rmem_schedule(sk, skb, skb->truesize)) {
-		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
-		goto drop;
-	}
+	mptcp_borrow_fwdmem(sk, skb);
 
 	if (MPTCP_SKB_CB(skb)->map_seq == msk->ack_seq) {
 		/* in sequence */
@@ -400,7 +396,6 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 	 * will retransmit as needed, if needed.
 	 */
 	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
-drop:
 	mptcp_drop(sk, skb);
 	return false;
 }
@@ -701,7 +696,7 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 			size_t len = skb->len - offset;
 
 			mptcp_init_skb(ssk, skb, offset, len);
-			skb_orphan(skb);
+			mptcp_subflow_lend_fwdmem(subflow, skb);
 			ret = __mptcp_move_skb(sk, skb) || ret;
 			seq += len;
 
@@ -2428,6 +2423,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	bool dispose_it, need_push = false;
+	int fwd_remaning;
 
 	/* Do not pass RX data to the msk, even if the subflow socket is not
 	 * going to be freed (i.e. even for the first subflow on graceful
@@ -2436,6 +2432,17 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
 	subflow->closing = 1;
 
+	/* Borrow the fwd allocated page left-over; fwd memory for the subflow
+	 * could be negative at this point, but will be reach zero soon - when
+	 * the data allocated using such fragment will be freed.
+	 */
+	if (subflow->lent_mem_frag) {
+		fwd_remaning = PAGE_SIZE - subflow->lent_mem_frag;
+		sk_forward_alloc_add(sk, fwd_remaning);
+		sk_forward_alloc_add(ssk, -fwd_remaning);
+		subflow->lent_mem_frag = 0;
+	}
+
 	/* If the first subflow moved to a close state before accept, e.g. due
 	 * to an incoming reset or listener shutdown, the subflow socket is
 	 * already deleted by inet_child_forget() and the mptcp socket can't
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 9f7e5f2c964d..80d520888235 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -547,6 +547,7 @@ struct mptcp_subflow_context {
 	bool	scheduled;
 	bool	pm_listener;	    /* a listener managed by the kernel PM? */
 	bool	fully_established;  /* path validated */
+	u32	lent_mem_frag;
 	u32	remote_nonce;
 	u64	thmac;
 	u32	local_nonce;
@@ -646,6 +647,28 @@ mptcp_send_active_reset_reason(struct sock *sk)
 	tcp_send_active_reset(sk, GFP_ATOMIC, reason);
 }
 
+static inline void mptcp_borrow_fwdmem(struct sock *sk, struct sk_buff *skb)
+{
+	struct sock *ssk = skb->sk;
+
+	/* The subflow just lend the skb fwd memory, and we know that the skb
+	 * is only accounted on the incoming subflow rcvbuf.
+	 */
+	skb->sk = NULL;
+	sk_forward_alloc_add(sk, skb->truesize);
+	atomic_sub(skb->truesize, &ssk->sk_rmem_alloc);
+}
+
+static inline void
+mptcp_subflow_lend_fwdmem(struct mptcp_subflow_context *subflow,
+			  struct sk_buff *skb)
+{
+	int frag = (subflow->lent_mem_frag + skb->truesize) & (PAGE_SIZE - 1);
+
+	skb->destructor = NULL;
+	subflow->lent_mem_frag = frag;
+}
+
 static inline u64
 mptcp_subflow_get_map_offset(const struct mptcp_subflow_context *subflow)
 {
-- 
2.51.0

