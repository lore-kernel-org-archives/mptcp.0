Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE90B23ED5B
	for <mptcp@lists.linux.dev>; Sat,  9 May 2026 07:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778312969; cv=none; b=KofdEz/eeq2bx9bILaxWbOY8JH+98iUHzyg+N+rM2ZfM7bTKQVm2LWc4Vu5OHLF+xuMLq7FTzTQ1r9IsMF+axVCW7UTjpb/cm/T5n2wTJUB1JBTG7w9HXKBczf3v9KKtT1dM6c6kwpHJdMDjDcrq5cw9cGJ0AAYhPukK5JhFX9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778312969; c=relaxed/simple;
	bh=F3pN08Fp36nClCW6lx91KaZJ/XwbXhanRbzSvrVi9YE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=h1kphcDudKcBj3924hMdCPc/3RHkHh+PVuUlKZqKEUxd70M2RS96aXpeBsKuRbZ4k4ion1y7VMHDCtzjbo79HisHarZF/bXee56GtyEOhRte7ZYmQ+YVC4Uv+251zSXGeXvEcFTcusoDIdzfHrZeHkr/ldSY3svrYbsX2f1C1v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HR13F4pY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HR13F4pY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778312966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9CmJbuDmKQf7CZQ2IlWheYstILBqTCxYB5kKLiKGGag=;
	b=HR13F4pYiF9xwh8lvLXR0/esDed5e7V1fLxuhVqKefn/nfvTH4HmzvdJFQFwGd5TIOHmeZ
	KwpxLlJFA3+Ixro83yZHTroPoWj3ocF9KxyZrPXAs7iml03/cUV5lnrfTiKSoUVn25VT0x
	zl+JJ1R+dN0easXK81UJFKALIwzfJnA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-nq2u0hxVOzm0Hr6EZ-2v2A-1; Sat,
 09 May 2026 03:49:23 -0400
X-MC-Unique: nq2u0hxVOzm0Hr6EZ-2v2A-1
X-Mimecast-MFC-AGG-ID: nq2u0hxVOzm0Hr6EZ-2v2A_1778312962
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B9DAC1956088;
	Sat,  9 May 2026 07:49:22 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.24])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B77E918004A3;
	Sat,  9 May 2026 07:49:21 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Shardul Bankar <shardul.b@mpiricsoftware.com>
Subject: [PATCH mptcp-next 10/12] mptcp: track prune recovery status
Date: Sat,  9 May 2026 09:48:30 +0200
Message-ID: <c9803bc25b3f40f87a3081b00093068ad66fac85.1778312843.git.pabeni@redhat.com>
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
X-Mimecast-MFC-PROC-ID: Xv2-E9Lff2-sy9JWZnrIrP-O5Vi_WVpB5oA_4WMz8RU_1778312962
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

After dropping any data already acked at the TCP level, the MPTCP must
avoid inducing TCP-level retransmission until the pruned data has been
successfully acked at MPTCP level. Otherwise the subflows could keep
retransmitting skbs carring OoO MPTCP data, preventing reinjections and
stalling completely the data transfer.

Explicitly keep track of the highest pruned MPTCP-level seq number and
stop dropping at TCP level until such sequence has been acked.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/options.c  |  7 +++++++
 net/mptcp/protocol.c | 16 ++++++++++++++--
 net/mptcp/protocol.h |  3 +++
 net/mptcp/subflow.c  |  1 +
 4 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index d7e712171d3b..9b8de027848b 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1200,6 +1200,13 @@ static bool mptcp_over_limit(struct sock *sk, struct sock *ssk,
 		__set_bit(MPTCP_PRUNE, &msk->cb_flags);
 	}
 	ret = sk_rmem_alloc_get(sk) + msk->backlog_len > limit;
+
+	/* After pruning any packets ensure that MPTCP-driven drops do not
+	 * cause TCP-level retransmission.
+	 */
+	if (before((u32)(msk->ack_seq), READ_ONCE(msk->pruned_seq)))
+		ret = false;
+
 	mptcp_data_unlock(sk);
 
 	if (ret) {
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d9aab7bbff98..7907d82115d0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -392,12 +392,14 @@ static void mptcp_prune_ofo_queue(struct sock *sk, u32 seq)
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct rb_node *node, *prev;
 	bool pruned = false;
+	u32 pruned_seq;
 
 	if (RB_EMPTY_ROOT(&msk->out_of_order_queue))
 		return;
 
 	node = &msk->ooo_last_skb->rbnode;
 
+	pruned_seq = msk->pruned_seq;
 	do {
 		struct sk_buff *skb = rb_to_skb(node);
 
@@ -408,16 +410,21 @@ static void mptcp_prune_ofo_queue(struct sock *sk, u32 seq)
 		pruned = true;
 		prev = rb_prev(node);
 		rb_erase(node, &msk->out_of_order_queue);
+		if (after(MPTCP_SKB_CB(skb)->end_seq, pruned_seq))
+			pruned_seq = MPTCP_SKB_CB(skb)->end_seq;
 		mptcp_drop(sk, skb);
 		msk->ooo_last_skb = rb_to_skb(prev);
+
 		if (atomic_read(&sk->sk_rmem_alloc) < sk->sk_rcvbuf)
 			break;
 
 		node = prev;
 	} while (node);
 
-	if (pruned)
+	if (pruned) {
+		WRITE_ONCE(msk->pruned_seq, pruned_seq);
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_OFO_PRUNED);
+	}
 }
 
 bool __mptcp_check_prune(struct sock *sk, u32 seq)
@@ -464,6 +471,8 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 	if (unlikely(sk_rmem_alloc_get(sk) > READ_ONCE(sk->sk_rcvbuf)) &&
 	    __mptcp_check_prune(sk, MPTCP_SKB_CB(skb)->map_seq) &&
 	    !__mptcp_check_fallback(msk)) {
+		if (after(MPTCP_SKB_CB(skb)->end_seq, msk->pruned_seq))
+			WRITE_ONCE(msk->pruned_seq, MPTCP_SKB_CB(skb)->end_seq);
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
 		mptcp_drop(sk, skb);
 		return false;
@@ -881,7 +890,7 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 	p = rb_first(&msk->out_of_order_queue);
 	pr_debug("msk=%p empty=%d\n", msk, RB_EMPTY_ROOT(&msk->out_of_order_queue));
 	while (p) {
-		ack_seq = msk->ack_seq;
+		ack_seq = (u32)(msk->ack_seq);
 		skb = rb_to_skb(p);
 		if (after(MPTCP_SKB_CB(skb)->map_seq, ack_seq))
 			break;
@@ -910,6 +919,8 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 		WRITE_ONCE(msk->ack_seq, msk->ack_seq + seq_delta);
 		moved = true;
 	}
+	if (after(msk->ack_seq, msk->pruned_seq))
+		WRITE_ONCE(msk->pruned_seq, (u32)msk->ack_seq);
 	return moved;
 }
 
@@ -3550,6 +3561,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	WRITE_ONCE(msk->ack_seq, 0);
 	atomic64_set(&msk->rcv_wnd_sent, 0);
 	msk->copied_seq = 0;
+	WRITE_ONCE(msk->pruned_seq, 0);
 
 	WRITE_ONCE(sk->sk_shutdown, 0);
 	sk_error_report(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ae019a10e1c8..70431cde1757 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -307,6 +307,9 @@ struct mptcp_sock {
 	u64		bytes_acked;
 	u64		snd_una;
 	u64		wnd_end;
+	u32		pruned_seq;		/* If strictly above ack_seq,
+						 * the highest seq pruned.
+						 */
 	u32		last_data_sent;
 	u32		last_data_recv;
 	u32		last_ack_recv;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index c8ea876bdd03..f35afe64d9cd 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -496,6 +496,7 @@ static void subflow_set_remote_key(struct mptcp_sock *msk,
 
 	WRITE_ONCE(msk->remote_key, subflow->remote_key);
 	WRITE_ONCE(msk->ack_seq, subflow->iasn);
+	WRITE_ONCE(msk->pruned_seq, subflow->iasn);
 	WRITE_ONCE(msk->can_ack, true);
 	atomic64_set(&msk->rcv_wnd_sent, subflow->iasn);
 
-- 
2.54.0

