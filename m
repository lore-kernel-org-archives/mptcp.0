Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56EB428494
	for <mptcp@lists.linux.dev>; Fri, 15 May 2026 09:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778836074; cv=none; b=K/GMGrMYdSWK069Etc7jF9gIpZXNp0TNKWSUyKGVQtkqlvrEW6t+PN82NVIsUYyWI8MXrjRYXCWk+dsc1IgsnK0uyvBFa88cC0d1QaVmj+L9qk79VurAOTseRA7+99fcIzJmZNkoNA5i8mQQv4hhMBi5qwSdxHJtE4Mu+weEn9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778836074; c=relaxed/simple;
	bh=jVw7u+HAA35GmvnzLoI7OqoVqqPf8VQo3KaogWUGKBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=lt2mf9xvi4/ZxLlTRnPJG80delc2wFezm1WD7obvLEozMZh5YsIXmvJ3HRGC/S2PuOHuUcdTKnieOgR4yRol9TQHLhnfC79eoO/iA4990agSIO5T9l3SqTk57hHvX02+AT6790zwDzSwXSrr6ZQJvs2krszdqJFp54pKwD3o4nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FVkHuPoI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FVkHuPoI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778836071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AU5BERyTkhJRjFIQJOtMMg7fgqdJQ1k9Q476Qxh89HY=;
	b=FVkHuPoImal1+6rAl+iuua6X7VlGcOSpNFrUgnva+BEE7upcy5SUT77APUTJf5O+QQ4+gF
	AvkhbIMe6STuvAA4hwNjodcbNf5wi8OphZgYrzEM0FGk95E/8bFFw1/k7+1JIj2bHWqZRJ
	UQhZ9IoWShwli4M7CgIpbg9R8v1h4q8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-XSlzz-JjP8KKleUM4wBzkQ-1; Fri,
 15 May 2026 05:07:50 -0400
X-MC-Unique: XSlzz-JjP8KKleUM4wBzkQ-1
X-Mimecast-MFC-AGG-ID: XSlzz-JjP8KKleUM4wBzkQ_1778836069
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0756019560A2;
	Fri, 15 May 2026 09:07:49 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.244])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9EEA6180075C;
	Fri, 15 May 2026 09:07:47 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>,
	gang.yan@linux.dev
Subject: [PATCH v6 mptcp-next 5/7] mptcp: track prune recovery status
Date: Fri, 15 May 2026 11:07:26 +0200
Message-ID: <2acec9f2de6c41b18a0ef92903ea1cc11759c644.1778835009.git.pabeni@redhat.com>
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
X-Mimecast-MFC-PROC-ID: rKIEzPubZqUESbCetuN1UrjgKjTAxDvE6v_pqC49oZ8_1778836069
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
Notes:
 - sashiko may miss that msk->ack_seq access in mptcp_over_limit()
 happens under the msk data lock and this is raceless.
---
 net/mptcp/options.c  |  7 +++++++
 net/mptcp/protocol.c | 14 +++++++++++++-
 net/mptcp/protocol.h |  3 +++
 net/mptcp/subflow.c  |  1 +
 4 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index ec64e1a127d7..c96b8166224b 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1194,6 +1194,13 @@ static bool mptcp_over_limit(struct sock *sk, struct sock *ssk,
 		limit = ((u64)READ_ONCE(sk->sk_rcvbuf)) << 1;
 	}
 	ret = sk_rmem_alloc_get(sk) + msk->backlog_len > limit;
+
+	/* After pruning any packets ensure that MPTCP-driven drops do not
+	 * cause TCP-level retransmission.
+	 */
+	if (before64(msk->ack_seq, READ_ONCE(msk->pruned_seq)))
+		ret = false;
+
 	mptcp_data_unlock(sk);
 
 	if (ret) {
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b79dd4c4fe31..640632c283e1 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -379,12 +379,14 @@ static void mptcp_prune_ofo_queue(struct sock *sk, u64 seq)
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct rb_node *node, *prev;
 	bool pruned = false;
+	u64 pruned_seq;
 
 	if (RB_EMPTY_ROOT(&msk->out_of_order_queue))
 		return;
 
 	node = &msk->ooo_last_skb->rbnode;
 
+	pruned_seq = msk->pruned_seq;
 	do {
 		struct sk_buff *skb = rb_to_skb(node);
 
@@ -395,16 +397,21 @@ static void mptcp_prune_ofo_queue(struct sock *sk, u64 seq)
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
 
 bool __mptcp_check_prune(struct sock *sk, u64 seq)
@@ -427,6 +434,8 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 	if (unlikely(sk_rmem_alloc_get(sk) > READ_ONCE(sk->sk_rcvbuf)) &&
 	    __mptcp_check_prune(sk, MPTCP_SKB_CB(skb)->map_seq) &&
 	    !__mptcp_check_fallback(msk)) {
+		if (after(MPTCP_SKB_CB(skb)->end_seq, msk->pruned_seq))
+			WRITE_ONCE(msk->pruned_seq, MPTCP_SKB_CB(skb)->end_seq);
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
 		mptcp_drop(sk, skb);
 		return false;
@@ -887,6 +896,8 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 		WRITE_ONCE(msk->ack_seq, end_seq);
 		moved = true;
 	}
+	if (after64(msk->ack_seq, msk->pruned_seq))
+		WRITE_ONCE(msk->pruned_seq, msk->ack_seq);
 	return moved;
 }
 
@@ -3536,6 +3547,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	/* for fallback's sake */
 	WRITE_ONCE(msk->ack_seq, 0);
 	atomic64_set(&msk->rcv_wnd_sent, 0);
+	WRITE_ONCE(msk->pruned_seq, 0);
 
 	WRITE_ONCE(sk->sk_shutdown, 0);
 	sk_error_report(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 95774a4e7231..32daf51e48ef 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -303,6 +303,9 @@ struct mptcp_sock {
 	u64		bytes_acked;
 	u64		snd_una;
 	u64		wnd_end;
+	u64		pruned_seq;		/* If strictly above ack_seq,
+						 * the highest seq pruned.
+						 */
 	u32		last_data_sent;
 	u32		last_data_recv;
 	u32		last_ack_recv;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index d562e149606f..cc75d914c1b5 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -494,6 +494,7 @@ static void subflow_set_remote_key(struct mptcp_sock *msk,
 
 	WRITE_ONCE(msk->remote_key, subflow->remote_key);
 	WRITE_ONCE(msk->ack_seq, subflow->iasn);
+	WRITE_ONCE(msk->pruned_seq, subflow->iasn);
 	WRITE_ONCE(msk->can_ack, true);
 	atomic64_set(&msk->rcv_wnd_sent, subflow->iasn);
 }
-- 
2.54.0

