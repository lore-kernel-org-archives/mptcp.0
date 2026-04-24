Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E093DBD56
	for <mptcp@lists.linux.dev>; Fri, 24 Apr 2026 14:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777039779; cv=none; b=TKnhnAAmkEBYNs4KMR6SpVHvIqJznJzRkqk07GDT7JdfAJin1JxYvSZq5uGlqYatknEnmThw9dU8AqTqyrnOj8FWNmQaE6T9lg0529+TWbH+Xs5ibcNFCFhJcNdr28LmKNhdoiehTqHb0TDMiVqvxezA5iHtg1S8+JvdbFYLokM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777039779; c=relaxed/simple;
	bh=zmaAT2Jav9BnjZZlQAXUVmwvRtvdpze9ISEVACDtkNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=DSCz2y0DA3mP08+6SN6/NfpbmJXjbGyCJR70E6FLnfR9IluDKUpq0o/1z+FnN/TJJ9ZPZDXOfelcc6Z4sSNNVWd4H80ASPo3xN04WVhKvFbpPN2koaQ/6NgNCm5gmT9bg3CreTbApXeQXGK+xmPGdsFazBlLf5hslNwmMmgdiOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VJspjSOj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VJspjSOj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777039774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cabw49sIZW+xRUY9uUvxfzr0jxPOBrQE3hIdwXN4ZYQ=;
	b=VJspjSOjExtcioz6NjQfKYH6QpXpJAn0iZhDQVPrDe/Ruyx5WsWYwcuoYd3Lde0DonIjNN
	sE5HM0ITOzJqVAmmOM+zO+KJ5X6gvXiBgzxjQgeVfD437m5sikFcRxdJFgh6zb6ZxcU2OL
	MoeJ64dhsAuHb+zHiYVz8e5XmK7zqIA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-9P1x4VR4PEWzP-CEgQw0Kg-1; Fri,
 24 Apr 2026 10:09:29 -0400
X-MC-Unique: 9P1x4VR4PEWzP-CEgQw0Kg-1
X-Mimecast-MFC-AGG-ID: 9P1x4VR4PEWzP-CEgQw0Kg_1777039768
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6C12A1828AD2;
	Fri, 24 Apr 2026 14:09:12 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.130])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DB7A630078E3;
	Fri, 24 Apr 2026 14:09:10 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: yangang@kylinos.cn,
	geliang@kernel.org,
	matttbe@kernel.org
Subject: [PATCH mptcp-next v1 7/9] mptcp: track prune recovery status
Date: Fri, 24 Apr 2026 16:08:40 +0200
Message-ID: <1ee70eda6b3706f038191b332fae8f69e7078b4e.1777038888.git.pabeni@redhat.com>
In-Reply-To: <cover.1777038888.git.pabeni@redhat.com>
References: <cover.1777038888.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AEO3OwJNTYiWJBIKmfAGPXfQmFiqVsThGhipnzp0nk0_1777039768
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
 net/mptcp/options.c  |  7 ++++++-
 net/mptcp/protocol.c | 14 +++++++++++++-
 net/mptcp/protocol.h |  1 +
 net/mptcp/subflow.c  |  1 +
 4 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index a49cb03954e5..941e4ec705fe 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1191,7 +1191,12 @@ static bool mptcp_over_limit(struct sock *sk, struct sk_buff *skb,
 		__set_bit(MPTCP_PRUNE, &msk->cb_flags);
 	}
 	mptcp_data_unlock(sk);
-	return ret;
+
+	/* After pruning any packets ensure that MPTCP-driven drops do not
+	 * cause TCP-level retransmission
+	 */
+	return ret &&
+	       !before(READ_ONCE(msk->ack_seq), READ_ONCE(msk->pruned_seq));
 }
 
 /* Return false when the caller must drop the packet, i.e. in case of error,
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0c57561ee046..44840020e53a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -369,12 +369,14 @@ static void mptcp_prune_ofo_queue(struct sock *sk, u32 seq)
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
 
@@ -385,16 +387,21 @@ static void mptcp_prune_ofo_queue(struct sock *sk, u32 seq)
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
 		NET_INC_STATS(sock_net(sk), MPTCP_MIB_OFO_PRUNED);
+	}
 }
 
 bool __mptcp_check_prune(struct sock *sk, u32 seq)
@@ -433,6 +440,8 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 	mptcp_borrow_fwdmem(sk, skb);
 
 	if (__mptcp_check_prune(sk, MPTCP_SKB_CB(skb)->map_seq)) {
+		if (after(MPTCP_SKB_CB(skb)->end_seq, msk->pruned_seq))
+			WRITE_ONCE(msk->pruned_seq, MPTCP_SKB_CB(skb)->end_seq);
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
 		mptcp_drop(sk, skb);
 		return false;
@@ -866,6 +875,8 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 		WRITE_ONCE(msk->ack_seq, msk->ack_seq + seq_delta);
 		moved = true;
 	}
+	if (after(msk->ack_seq, msk->pruned_seq))
+		WRITE_ONCE(msk->pruned_seq, (u32)msk->ack_seq);
 	return moved;
 }
 
@@ -3520,6 +3531,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	/* for fallback's sake */
 	WRITE_ONCE(msk->ack_seq, 0);
 	WRITE_ONCE(msk->copied_seq, 0);
+	WRITE_ONCE(msk->pruned_seq, 0);
 
 	WRITE_ONCE(sk->sk_shutdown, 0);
 	sk_error_report(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a6b7eedf36cf..b7b32301e7c4 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -306,6 +306,7 @@ struct mptcp_sock {
 	u64		bytes_acked;
 	u64		snd_una;
 	u64		wnd_end;
+	u32		pruned_seq;		/* if after ack_seq, highest seq pruned */
 	u32		last_data_sent;
 	u32		last_data_recv;
 	u32		last_ack_recv;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 2a8d5da4aaea..70a5c2a08278 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -495,6 +495,7 @@ static void subflow_set_remote_key(struct mptcp_sock *msk,
 	WRITE_ONCE(msk->remote_key, subflow->remote_key);
 	WRITE_ONCE(msk->ack_seq, subflow->iasn);
 	WRITE_ONCE(msk->copied_seq, subflow->iasn);
+	WRITE_ONCE(msk->pruned_seq, subflow->iasn);
 	WRITE_ONCE(msk->can_ack, true);
 	atomic64_set(&msk->rcv_wnd_sent, subflow->iasn);
 }
-- 
2.53.0

