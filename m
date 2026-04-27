Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EA21D0DEE
	for <mptcp@lists.linux.dev>; Mon, 27 Apr 2026 19:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777319547; cv=none; b=K+gQ1nr588Cl09HAtnYLALXi0Q4FPPtb+XIATcUzZUWPstHHmNJ8E1cClsoWnnm5RfV10tzVmXralCdK2m4zPsZ1+ZWENiASQVF+VYIR331chwaC2e2abN/4sH34HeM1eNlgHDSCwN+vk8XkMKiCZU87wQ9XOTt/zvgn02Qgb9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777319547; c=relaxed/simple;
	bh=QAgeFVxrmR5mrmnN3gbfnYhnzJXIlgmvLuGBxnRNgpA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Z22ZoeLXqWMFR4gknhUGf4v9HoOx/X1wBggrZ3JpKr38oksMnZrpJ2gtyeloyxFwk4quLaVvAlN39c8Kl3ZQ0OsxLNYJfUnP9N3eCKjC39ZutL/zZJCIT1SQwSPhdRRXCFYVwjYS/rR2alr/5YLXkLtxH5L9G9gmpfQIeDqKZKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C870/KaD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C870/KaD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777319545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FUS3mIYnu0NHSGln8VsDNep7QRgEPvYfq6q3pmfspJA=;
	b=C870/KaDK5Ru5gRhPgGM1Fqb+vvI81WZIU9/1wTSWCkAWEXeEUGuwuXlv9/UoNd7R7TWY3
	pzNqSPre2eM+JeB3mbcya3tARMK/jwC9goo7cs+OavppWyukMMcQzsfn3+0Qd5+LOlBkzk
	gLSck064Fx3OlKTuT6c8HYOhyuJHGCY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-524-ZTCH8r2eOV-6LC1EnZ8EBw-1; Mon,
 27 Apr 2026 15:52:22 -0400
X-MC-Unique: ZTCH8r2eOV-6LC1EnZ8EBw-1
X-Mimecast-MFC-AGG-ID: ZTCH8r2eOV-6LC1EnZ8EBw_1777319541
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6C06018002C0
	for <mptcp@lists.linux.dev>; Mon, 27 Apr 2026 19:52:21 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.49.253])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A7A80300070A
	for <mptcp@lists.linux.dev>; Mon, 27 Apr 2026 19:52:20 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 06/10] tcp: expose the tcp_collapse_ofo_queue() helper to mptcp usage, too
Date: Mon, 27 Apr 2026 21:52:04 +0200
Message-ID: <f3566ea2d02c1d8fd88e4363c8562af16f75dd63.1777318959.git.pabeni@redhat.com>
In-Reply-To: <cover.1777318959.git.pabeni@redhat.com>
References: <cover.1777318959.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nz4P3szx7ThcBl6fLQCGI-29zf8qmYF9IdHdBZJ8Fco_1777319541
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The end goal is to avoid duplicating the quite untrivial strategy at MPTCP
level.

After the previous patch, the mentioned helpers could process skbs standing
in MPTCP-level queues without any CB-related adaptation.

The only additional adjustment needed is explicitly providing the OoO queue
reference, to cope with different sk layout.

Additionally rename the helper to clearly document its hybrid nature and
let it return the number of collapsed skbs, to allow proper accounting from
the future MPTCP caller.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
rfc -> v1:
 - fix arg typo

Note:
 - this will need a significant amount of testing at the TCP level and
   explicit approval from Eric, which I can't guess if we can hope.
---
 include/net/tcp.h    |  8 +++++++
 net/ipv4/tcp_input.c | 55 ++++++++++++++++++++++++++++----------------
 2 files changed, 43 insertions(+), 20 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 6156d1d068e1..34a96f0bcf0a 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1828,6 +1828,14 @@ extern void tcp_openreq_init_rwin(struct request_sock *req,
 
 void tcp_enter_memory_pressure(struct sock *sk);
 void tcp_leave_memory_pressure(struct sock *sk);
+unsigned int xtcp_collapse(struct sock *sk, struct sk_buff_head *list,
+			   struct rb_root *root, struct sk_buff *head,
+			   struct sk_buff *tail, u32 start, u32 end,
+			   u8 scaling_ratio);
+unsigned int xtcp_collapse_ofo_queue(struct sock *sk,
+				     struct rb_root *out_of_order_queue,
+				     struct sk_buff **ooo_last_skb,
+				     u8 scaling_ratio);
 
 static inline int keepalive_intvl_when(const struct tcp_sock *tp)
 {
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 7171442c3ed7..8417785fa48f 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5725,16 +5725,22 @@ static struct sk_buff *tcp_collapse_one(struct sock *sk, struct sk_buff *skb,
 /* Collapse contiguous sequence of skbs head..tail with
  * sequence numbers start..end.
  *
+ * sk can be either a TCP or an MPTCP socket.
+ *
  * If tail is NULL, this means until the end of the queue.
  *
  * Segments with FIN/SYN are not collapsed (only because this
  * simplifies code)
+ *
+ * Returns the number of collapsed skbs.
  */
-static void
-tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
-	     struct sk_buff *head, struct sk_buff *tail, u32 start, u32 end)
+unsigned int
+xtcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
+	      struct sk_buff *head, struct sk_buff *tail, u32 start, u32 end,
+	      u8 scaling_ratio)
 {
 	struct sk_buff *skb = head, *n;
+	unsigned int collapsed = 0;
 	struct sk_buff_head tmp;
 	bool end_of_skbs;
 
@@ -5750,6 +5756,7 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 
 		/* No new bits? It is possible on ofo queue. */
 		if (!before(start, TCP_SKB_CB(skb)->end_seq)) {
+			collapsed++;
 			skb = tcp_collapse_one(sk, skb, list, root);
 			if (!skb)
 				break;
@@ -5762,7 +5769,7 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 		 *   overlaps to the next one and mptcp allow collapsing.
 		 */
 		if (!(TCP_SKB_CB(skb)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN)) &&
-		    (tcp_win_from_space(sk, skb->truesize) > skb->len ||
+		    (__tcp_win_from_space(scaling_ratio, skb->truesize) > skb->len ||
 		     before(TCP_SKB_CB(skb)->seq, start))) {
 			end_of_skbs = false;
 			break;
@@ -5782,7 +5789,7 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 	if (end_of_skbs ||
 	    (TCP_SKB_CB(skb)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN)) ||
 	    !skb_frags_readable(skb))
-		return;
+		return collapsed;
 
 	__skb_queue_head_init(&tmp);
 
@@ -5819,6 +5826,7 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 				start += size;
 			}
 			if (!before(start, TCP_SKB_CB(skb)->end_seq)) {
+				collapsed++;
 				skb = tcp_collapse_one(sk, skb, list, root);
 				if (!skb ||
 				    skb == tail ||
@@ -5832,23 +5840,26 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 end:
 	skb_queue_walk_safe(&tmp, skb, n)
 		tcp_rbtree_insert(root, skb);
+	return collapsed;
 }
 
 /* Collapse ofo queue. Algorithm: select contiguous sequence of skbs
- * and tcp_collapse() them until all the queue is collapsed.
+ * and xtcp_collapse() them until all the queue is collapsed.
  */
-static void tcp_collapse_ofo_queue(struct sock *sk)
+unsigned int xtcp_collapse_ofo_queue(struct sock *sk,
+				     struct rb_root *ooo_queue,
+				     struct sk_buff **ooo_last_skb,
+				     u8 scaling_ratio)
 {
-	struct tcp_sock *tp = tcp_sk(sk);
-	u32 range_truesize, sum_tiny = 0;
+	u32 range_truesize, sum_tiny = 0, collapsed = 0;
 	struct sk_buff *skb, *head;
 	u32 start, end;
 
-	skb = skb_rb_first(&tp->out_of_order_queue);
+	skb = skb_rb_first(ooo_queue);
 new_range:
 	if (!skb) {
-		tp->ooo_last_skb = skb_rb_last(&tp->out_of_order_queue);
-		return;
+		*ooo_last_skb = skb_rb_last(ooo_queue);
+		return collapsed;
 	}
 	start = TCP_SKB_CB(skb)->seq;
 	end = TCP_SKB_CB(skb)->end_seq;
@@ -5866,12 +5877,13 @@ static void tcp_collapse_ofo_queue(struct sock *sk)
 			/* Do not attempt collapsing tiny skbs */
 			if (range_truesize != head->truesize ||
 			    end - start >= SKB_WITH_OVERHEAD(PAGE_SIZE)) {
-				tcp_collapse(sk, NULL, &tp->out_of_order_queue,
-					     head, skb, start, end);
+				collapsed += xtcp_collapse(sk, NULL, ooo_queue,
+					      head, skb, start, end,
+					      scaling_ratio);
 			} else {
 				sum_tiny += range_truesize;
 				if (sum_tiny > sk->sk_rcvbuf >> 3)
-					return;
+					return collapsed;
 			}
 			goto new_range;
 		}
@@ -5882,6 +5894,7 @@ static void tcp_collapse_ofo_queue(struct sock *sk)
 		if (after(TCP_SKB_CB(skb)->end_seq, end))
 			end = TCP_SKB_CB(skb)->end_seq;
 	}
+	return collapsed;
 }
 
 /*
@@ -5969,12 +5982,14 @@ static int tcp_prune_queue(struct sock *sk, const struct sk_buff *in_skb)
 	if (tcp_can_ingest(sk, in_skb))
 		return 0;
 
-	tcp_collapse_ofo_queue(sk);
+	xtcp_collapse_ofo_queue(sk, &tp->out_of_order_queue,
+				&tp->ooo_last_skb, tp->scaling_ratio);
 	if (!skb_queue_empty(&sk->sk_receive_queue))
-		tcp_collapse(sk, &sk->sk_receive_queue, NULL,
-			     skb_peek(&sk->sk_receive_queue),
-			     NULL,
-			     tp->copied_seq, tp->rcv_nxt);
+		xtcp_collapse(sk, &sk->sk_receive_queue, NULL,
+			      skb_peek(&sk->sk_receive_queue),
+			      NULL,
+			      tp->copied_seq, tp->rcv_nxt,
+			      tp->scaling_ratio);
 
 	if (tcp_can_ingest(sk, in_skb))
 		return 0;
-- 
2.53.0

