Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E5B2FAE
	for <mptcp@lists.linux.dev>; Thu,  2 Sep 2021 15:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1630597966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lvgijn04rkBbFuXU24CIyP2H68wXwzmEnNA1gqXKzi8=;
	b=hAz/i5WaCImd4ziQXBDqvXbp0gWeg66GKWVQhyD+jD6sINoC8DSMEXz3F0hON/OwpkPCOS
	+fTSlp2Pa7sBE7Ad4UIM13oaJvght2uRHZoeY9ZEpGAeugUkjd+VxK5ag56uVvypbdksBN
	wKdwbmWmqxR8DsWc6I+YaNhRjL2SWzs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-iwcANvgBOImM6k52pswlaQ-1; Thu, 02 Sep 2021 11:52:45 -0400
X-MC-Unique: iwcANvgBOImM6k52pswlaQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02043801AFC
	for <mptcp@lists.linux.dev>; Thu,  2 Sep 2021 15:52:45 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.237])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6D1725D9DC
	for <mptcp@lists.linux.dev>; Thu,  2 Sep 2021 15:52:44 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 3/4] Partially revert "tcp: factor out tcp_build_frag()"
Date: Thu,  2 Sep 2021 17:52:13 +0200
Message-Id: <03dce55be4a164a139da069a3fa3f424cb3f8c95.1630595171.git.pabeni@redhat.com>
In-Reply-To: <cover.1630595171.git.pabeni@redhat.com>
References: <cover.1630595171.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

This is a partial revert for commit b796d04bd014 ("tcp:
factor out tcp_build_frag()").

MPTCP was the only user of the tcp_build_frag helper, and after
the previous patch MPTCP does not use the mentioned helper anymore.
Let's avoid exposing TCP internals.

The revert is partial, as tcp_remove_empty_skb(), exposed
by the same commit is still required.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 include/net/tcp.h |   2 -
 net/ipv4/tcp.c    | 117 ++++++++++++++++++++--------------------------
 2 files changed, 51 insertions(+), 68 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index dc52ea8adfc7..91f4397c4c08 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -330,8 +330,6 @@ int tcp_sendpage(struct sock *sk, struct page *page, int offset, size_t size,
 		 int flags);
 int tcp_sendpage_locked(struct sock *sk, struct page *page, int offset,
 			size_t size, int flags);
-struct sk_buff *tcp_build_frag(struct sock *sk, int size_goal, int flags,
-			       struct page *page, int offset, size_t *size);
 ssize_t do_tcp_sendpages(struct sock *sk, struct page *page, int offset,
 		 size_t size, int flags);
 int tcp_send_mss(struct sock *sk, int *size_goal, int flags);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 7a3e632b0048..caf0c50d86bc 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -963,68 +963,6 @@ void tcp_remove_empty_skb(struct sock *sk, struct sk_buff *skb)
 	}
 }
 
-struct sk_buff *tcp_build_frag(struct sock *sk, int size_goal, int flags,
-			       struct page *page, int offset, size_t *size)
-{
-	struct sk_buff *skb = tcp_write_queue_tail(sk);
-	struct tcp_sock *tp = tcp_sk(sk);
-	bool can_coalesce;
-	int copy, i;
-
-	if (!skb || (copy = size_goal - skb->len) <= 0 ||
-	    !tcp_skb_can_collapse_to(skb)) {
-new_segment:
-		if (!sk_stream_memory_free(sk))
-			return NULL;
-
-		skb = sk_stream_alloc_skb(sk, 0, sk->sk_allocation,
-					  tcp_rtx_and_write_queues_empty(sk));
-		if (!skb)
-			return NULL;
-
-#ifdef CONFIG_TLS_DEVICE
-		skb->decrypted = !!(flags & MSG_SENDPAGE_DECRYPTED);
-#endif
-		skb_entail(sk, skb);
-		copy = size_goal;
-	}
-
-	if (copy > *size)
-		copy = *size;
-
-	i = skb_shinfo(skb)->nr_frags;
-	can_coalesce = skb_can_coalesce(skb, i, page, offset);
-	if (!can_coalesce && i >= sysctl_max_skb_frags) {
-		tcp_mark_push(tp, skb);
-		goto new_segment;
-	}
-	if (!sk_wmem_schedule(sk, copy))
-		return NULL;
-
-	if (can_coalesce) {
-		skb_frag_size_add(&skb_shinfo(skb)->frags[i - 1], copy);
-	} else {
-		get_page(page);
-		skb_fill_page_desc(skb, i, page, offset, copy);
-	}
-
-	if (!(flags & MSG_NO_SHARED_FRAGS))
-		skb_shinfo(skb)->flags |= SKBFL_SHARED_FRAG;
-
-	skb->len += copy;
-	skb->data_len += copy;
-	skb->truesize += copy;
-	sk_wmem_queued_add(sk, copy);
-	sk_mem_charge(sk, copy);
-	skb->ip_summed = CHECKSUM_PARTIAL;
-	WRITE_ONCE(tp->write_seq, tp->write_seq + copy);
-	TCP_SKB_CB(skb)->end_seq += copy;
-	tcp_skb_pcount_set(skb, 0);
-
-	*size = copy;
-	return skb;
-}
-
 ssize_t do_tcp_sendpages(struct sock *sk, struct page *page, int offset,
 			 size_t size, int flags)
 {
@@ -1060,13 +998,60 @@ ssize_t do_tcp_sendpages(struct sock *sk, struct page *page, int offset,
 		goto out_err;
 
 	while (size > 0) {
-		struct sk_buff *skb;
-		size_t copy = size;
+		struct sk_buff *skb = tcp_write_queue_tail(sk);
+		int copy, i;
+		bool can_coalesce;
 
-		skb = tcp_build_frag(sk, size_goal, flags, page, offset, &copy);
-		if (!skb)
+		if (!skb || (copy = size_goal - skb->len) <= 0 ||
+		    !tcp_skb_can_collapse_to(skb)) {
+new_segment:
+			if (!sk_stream_memory_free(sk))
+				goto wait_for_space;
+
+			skb = sk_stream_alloc_skb(sk, 0, sk->sk_allocation,
+					tcp_rtx_and_write_queues_empty(sk));
+			if (!skb)
+				goto wait_for_space;
+
+#ifdef CONFIG_TLS_DEVICE
+			skb->decrypted = !!(flags & MSG_SENDPAGE_DECRYPTED);
+#endif
+			skb_entail(sk, skb);
+			copy = size_goal;
+		}
+
+		if (copy > size)
+			copy = size;
+
+		i = skb_shinfo(skb)->nr_frags;
+		can_coalesce = skb_can_coalesce(skb, i, page, offset);
+		if (!can_coalesce && i >= sysctl_max_skb_frags) {
+			tcp_mark_push(tp, skb);
+			goto new_segment;
+		}
+		if (!sk_wmem_schedule(sk, copy))
 			goto wait_for_space;
 
+		if (can_coalesce) {
+			skb_frag_size_add(&skb_shinfo(skb)->frags[i - 1], copy);
+		} else {
+			get_page(page);
+			skb_fill_page_desc(skb, i, page, offset, copy);
+		}
+
+		if (!(flags & MSG_NO_SHARED_FRAGS))
+			skb_shinfo(skb)->flags |= SKBFL_SHARED_FRAG;
+
+		skb->len += copy;
+		skb->data_len += copy;
+		skb->truesize += copy;
+		sk_wmem_queued_add(sk, copy);
+		sk_mem_charge(sk, copy);
+		skb->ip_summed = CHECKSUM_PARTIAL;
+		WRITE_ONCE(tp->write_seq, tp->write_seq + copy);
+		TCP_SKB_CB(skb)->end_seq += copy;
+		tcp_skb_pcount_set(skb, 0);
+
 		if (!copied)
 			TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_PSH;
 
-- 
2.26.3

