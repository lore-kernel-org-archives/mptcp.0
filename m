Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DB9328582
	for <mptcp@lists.linux.dev>; Tue, 16 Sep 2025 16:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758040068; cv=none; b=dCFNfcN+ckmZl+fbTnZEYOrqlOHTugLZknWQUlxPdJCxctkz6RYoPxHzzT11I8xoKEpE+G2Hu5VNBcsrylY+ko8s2WnwMvqgyrNVLTJ3fxPiU8ZhweKXVkkTxI94H8hO7w3lydKMp7C7WHkvNgst+c1XZ1IGaSgtk4TZ4IEhkxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758040068; c=relaxed/simple;
	bh=WP9/kZlIOsylZwrQ9Z55IMaTVHcZG5H4am5Ydp+klBc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=T7sdb8OXi4mjgn/FGjJVe5epc+ZS6bj4MrL5QO6OpBtEnRQC3BoGMlpVFhDknEReQt6VFkFlhSflcrH1/xQsEKreexYQnynY/SNv8pdPizZPE5o12lXio1CKEpwxzYt/STvqy02pHPqSImaMN0VDhEUT1L7v6WFZ/z8JO0cJmt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e2Zr7b8n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e2Zr7b8n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758040065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=crHEmzEwLcvNIVKD9ZopN/7/nNTf/0EfsKiEGs/aLdI=;
	b=e2Zr7b8nSEmPMhqFcx3EtIo6FXMji1znOw+XUkhfI/oWC+udSCsjKEfh7/Mtbn8gQJ57dR
	RojvjrP7O1isVv0uuc9uHmVEIE4zB7LNE0HtR7NmD4m45F8bRSUA9ebEKROkstFEGoFRv8
	PYK24fYjKDfvYwzWSIurnqmPbmq/QLM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-520-UBhJA6S2O9OF0JvXkbtKGA-1; Tue,
 16 Sep 2025 12:27:44 -0400
X-MC-Unique: UBhJA6S2O9OF0JvXkbtKGA-1
X-Mimecast-MFC-AGG-ID: UBhJA6S2O9OF0JvXkbtKGA_1758040063
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6977D1955DB8
	for <mptcp@lists.linux.dev>; Tue, 16 Sep 2025 16:27:43 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.160])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8845C19560B8
	for <mptcp@lists.linux.dev>; Tue, 16 Sep 2025 16:27:42 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [MPTCP next 11/12] mptcp: borrow forward memory from subflow
Date: Tue, 16 Sep 2025 18:27:21 +0200
Message-ID: <d4839bc122919c24ffe77303cc6a269d2c7c75ec.1758039775.git.pabeni@redhat.com>
In-Reply-To: <cover.1758039775.git.pabeni@redhat.com>
References: <cover.1758039775.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IKo-5y_H6Am0yL4nFric_7D5zdyYDvq0bGU5VB8iWEM_1758040063
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

In the MPTCP receive path, we release the subflow allocated
fwd memory just to allocate it again shortly after for the msk.

That could increases the change of failures, especially during
backlog processing, when other actions could consume the just
released memory before the msk socket has a chance to do the
rcv allocation.

Explicitly borrow, with a PAGE_SIZE granularity, the fwd memory
from the subflow socket instead of releasing it. During backlog
processing the borrowed memory is accounted at release_cb time.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 29 ++++++++++++++++++++++-------
 net/mptcp/protocol.h |  1 +
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f211a939daf39..b883e8548dcb8 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -335,11 +335,12 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 		mptcp_rcvbuf_grow(sk);
 }
 
-static void mptcp_init_skb(struct sock *ssk,
-			   struct mptcp_subflow_context *subflow,
-			   struct sk_buff *skb, int offset, int copy_len)
+static int mptcp_init_skb(struct sock *ssk,
+			  struct mptcp_subflow_context *subflow,
+			  struct sk_buff *skb, int offset, int copy_len)
 {
 	bool has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
+	int borrowed;
 
 	/* the skb map_seq accounts for the skb offset:
 	 * mptcp_subflow_get_mapped_dsn() is based on the current tp->copied_seq
@@ -355,6 +356,15 @@ static void mptcp_init_skb(struct sock *ssk,
 
 	skb_ext_reset(skb);
 	skb_dst_drop(skb);
+
+	/* "borrow" the fwd memory from the subflow, instead of reclaiming it */
+	skb->destructor = NULL;
+	skb->sk = NULL;
+	atomic_sub(skb->truesize, &ssk->sk_rmem_alloc);
+	borrowed = ssk->sk_forward_alloc - sk_unused_reserved_mem(ssk);
+	borrowed &= ~(PAGE_SIZE - 1);
+	sk_forward_alloc_add(ssk, skb->truesize - borrowed);
+	return borrowed;
 }
 
 static void __mptcp_add_backlog(struct sock *sk, struct sock *ssk,
@@ -701,14 +711,17 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 
 		if (offset < skb->len) {
 			size_t len = skb->len - offset;
+			int bmem;
 
-			mptcp_init_skb(ssk, subflow, skb, offset, len);
-			skb_orphan(skb);
+			bmem = mptcp_init_skb(ssk, subflow, skb, offset, len);
 
-			if (own_msk)
+			if (own_msk) {
+				sk_forward_alloc_add(sk, bmem);
 				ret |= __mptcp_move_skb(sk, skb);
-			else
+			} else {
+				msk->borrowed_fwd_mem += bmem;
 				__mptcp_add_backlog(sk, ssk, skb);
+			}
 			seq += len;
 
 			if (unlikely(map_remaining < len)) {
@@ -3477,6 +3490,8 @@ static void mptcp_release_cb(struct sock *sk)
 		if (__test_and_clear_bit(MPTCP_SYNC_SNDBUF, &msk->cb_flags))
 			__mptcp_sync_sndbuf(sk);
 	}
+	sk_forward_alloc_add(sk, msk->borrowed_fwd_mem);
+	msk->borrowed_fwd_mem = 0;
 }
 
 /* MP_JOIN client subflow must wait for 4th ack before sending any data:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2905e4b250070..93e7b1b3fe359 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -297,6 +297,7 @@ struct mptcp_sock {
 	u32		last_data_sent;
 	u32		last_data_recv;
 	u32		last_ack_recv;
+	int		borrowed_fwd_mem;
 	unsigned long	timer_ival;
 	u32		token;
 	unsigned long	flags;
-- 
2.51.0

