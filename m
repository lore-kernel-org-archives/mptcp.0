Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794870361;
	b=puIx7Bclr59UFyl0CP6w+HfuvrbGqzHBxWjDAz5XMlsPFvmMPdCaYjTlqu0heis7dYQc
	 wixCEGWnuRcE/eEVMwWxWFDVAryrZ2vMDxAUUFEI3A4TrICoqfYozZs2WCptisDFGFkQm
	 jzTdm8XLGo912jfxNAjzk7A+9TerM0MDUj7b3yea5M/mUxqlsXm3oSFCZ/gK3DQ2NBXFd
	 WQ1qGA+MhOnPCqv3CqCDdz7yhBFedI9I2LS9pVDWThri5vIapz6apLxP5f0yTBeRyiCNj
	 vJINlcEXCBNLWjqRBW+iEClPXqsIPpbOi7gaNh7AscrICClMCTurPE73uqgMXBI3S5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794870361;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=aoUoBk1HZavue3Km3O2AQLSN8BcEHTWpRN3NYo57aBs=;
	b=AIKEJIbFTSiwz3vwrmVqlrN95gDn1XmrdeZcj1vflmtW1ejsPD7lBXkWYTHmbDm/9xzM
	 sirKr2+ZSxQVmTruSJlbLVRmzpF3icOzAG2SbwI6RcqIGKZsLpW8veUJRknKOhdGm23As
	 +rayt8PZgnfcvhpb0nZOdv20LpYXm8mP1IAAsImakgoVpTk/kpd3t2ejE5kPdtcRTbdZw
	 dL7jJQL0UtKbihwW58xr/XEnlwxv8vafhMp9BrOSUy/7ipP41WiqvT95WA1JtvbAb1BGw
	 nnn8l9X3mzNooXbHOwhpAXUotC1+EDsE6lOXrczKkGRVaUlVOnXxdMNiSt5NLD6ADPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="AxMI/Qj9";
	arc=none smtp.remote-ip=209.85.215.198
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFB4606A336
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 23:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DFB4606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AxMI/Qj9
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cde02b50dd6so182849a12.1
        for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 15:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794870360; x=1795475160; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aoUoBk1HZavue3Km3O2AQLSN8BcEHTWpRN3NYo57aBs=;
        b=AxMI/Qj9ieV175Zb27czpTU49kpqGxY0vEecZvQAFJhaalOUsyW6OI1IfWguI3BL9u
         xllri/K0dbykA2TnNtO4q93T7JMUEeRHuUuzch8MYVXRoVCcaNgjQjI/bRFgHiYdHtA2
         0XlfVAstLJ5zgVaFfhs1WxdAQ3BoOd7IDKiX+I0xLO1v1zRLwVTRMLGaZMe/fb7ImW1X
         cAiU5Tea01d04GPwbtUeS2xv8MlpNf5OtlXEkG557V5kDO+2uhzeeDF/uiYfp5FOATMS
         SjiHXBJlQCqfX9o9UsAH8rQDBMy7esUeDg8MDqNLJzCNL29Pv+QNwQUo06MVKKffLunx
         nRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794870360; x=1795475160;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aoUoBk1HZavue3Km3O2AQLSN8BcEHTWpRN3NYo57aBs=;
        b=xQZsufwbTs9xFKANtQpZKdmAvi1tBwYYx5mcKmOOWMjWURBtcpexcGQyZJTIK1d1So
         ee5HGEzegweoFWV272u5c+hcR6G4bp5ytD0WqOWWRH10KOYUWeedqzxXjitDw6bQQI9G
         MrVH6fvRXmxxFHM4R+33WgzYYFSC2ZH2LnHkEAYY3j5rzHYqmexEaiegYeeletAcVPq+
         1Etq0NGK+o3gDOdCPvgNnrKlP0BbQpQN4oNnG39d+q1in5dC01rPjKasCZdz304WzIt7
         0RvdrXrBg0JXP5q8fH8R03R8iyF79XvW+c4eqnW0aeJHrcg2JCfCmBEJnl4UJBaFPiG4
         kKHQ==
X-Forwarded-Encrypted: i=1; AL+hErGExIChT46mngqzSmF22qIMzUpGCA6OsF5l/7lMLy2Ir4E/g8kaIT/hNHZruljT2xjyIUP73Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z+sXq2R8AJ+eMFBn+m5wedrQfRpFw1dJOf/ylhVdzz3MBJcgk1l
	2wU6HTUJF8xCkizBwfJ3Ab3TY1nBuJskxX6Gr+dGvUQTKyt9nhT9BtV6kOxCmtvJNFAIQdptSi2
	/WwWFdA==
X-Received: from pjwo1.prod.google.com ([2002:a17:90a:d241:b0:3b1:166b:a646])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4d06:b0:3b1:bd6d:fcc2
 with SMTP id 98e67ed59e1d1-3b3abe7e796mr467017a91.40.1794870360098; Mon, 16
 Nov 2026 15:06:00 -0800 (PST)
Date: Mon, 16 Nov 2026 23:05:27 +0000
In-Reply-To: <20261116230555.2305867-1-kuniyu@google.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261116230555.2305867-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
Message-ID: <20261116230555.2305867-4-kuniyu@google.com>
Subject: [PATCH v2 net-next 3/7] tcp: Stop collapsing if not bloated.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Even when a skb is not bloated, tcp_collapse() starts collapsing
if the next skb has overlapping data.

Also, tcp_collapse() does not stop until it reaches the tail or
unmergable skb (SYN/FIN, unreadable frags).

Assume we detect a low-density skb followed by fully-packed 4K-MSS
GRO skbs:

             skb->len  truesize  scaling_ratio
  skb    #1      1448      2944      125 (49%)
  skb    #2     65536     66432      252 (98%)
  skb    #3     65536     66432      252 (98%)
  ...
  skb    #9     65536     66432      252 (98%)
  --------------------------------------------
  total                  534400

Then, even the high-density skbs are repacked into lower-density
skbs, and we end up consuming much more memory.

             skb->len  truesize  scaling_ratio
  nskb   #1      3776      4352      222 (86%)
  nskb   #2      3776      4352      222 (86%)
  ...
  nskb #139      3776      4352      222 (86%)
  nskb #140       872      2304       96 (37%)
  --------------------------------------------
  total                  607232 (+72832!)

Even if we find a collapsible skb, we should not collapse
subsequent skbs with scaling_ratio >= TCP_COLLAPSE_SCALING_RATIO.

Conversely, even if tp->scaling_ratio is smaller than
TCP_COLLAPSE_SCALING_RATIO, we should repack skbs once we
start collapsing, which results in higher-density skb.

Let's remove the next skb condition in the first loop,
search for collapsible bloated skb range, and repeat
collapsing for each range.

Note that even when the next skb is not bloated, we must
collapse it for OOO rbtree if it has overlapping data.

	if ((list || !before(TCP_SKB_CB(n)->seq, sub_end)) &&
	    !tcp_collapse_skb_bloated(n, sub_end,
				      TCP_COLLAPSE_SCALING_RATIO))

For example, bloated skb_1 and non-bloated skb_2 have overlapping
data and only skb_1 is collapsed to nskb_1 and nskb_2.

   skb_1 = [1000, 5000]
   skb_2 = [2000, 66000]

Then, nskb_2 will be inserted after skb_2 in rbtree, wrongly
setting tp->ooo_last_skb to 5000.

  nskb_1 = [1000, 4776]
   skb_2 = [2000, 66000]
  nskb_2 = [4776, 5000]

This case is still inefficient, but a later patch handles this.

Another notable thing is that tcp_skb_can_collapse_rx() now checks
candidates against the first skb before mptcp_skb_ext_move(),
not against each nskb.

When a skb with an MPTCP ext spans multiple nskbs, collapsing
previously stopped at the next skb with the same ext because later
nskbs lacked the ext.

   skb1 (ext A),                  skb2 (ext A)
  nskb1 (ext A), nskb2 (no ext)             ^
                        ^- not collapsible -'

Now such skbs are also collapsed with the redundant ext dropped,
while the first nskb still carries the same mapping in sequence
order.

   skb1 (ext A),                  skb2 (ext A)
  nskb1 (ext A), nskb2 (no ext) <-' collapsed into nskb2

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: Describe slight behavioural change for MPTCP
---
 net/ipv4/tcp_input.c | 66 +++++++++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 29 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index e07f43347409..5bd42a74c6f5 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5839,7 +5839,7 @@ static struct sk_buff *tcp_collapse_one(struct sock *sk, struct sk_buff *skb,
 }
 
 /* Collapse contiguous sequence of skbs head..tail with
- * sequence numbers start..end.
+ * sequence numbers start..sub_end.
  *
  * If tail is NULL, this means until the end of the queue.
  *
@@ -5848,15 +5848,18 @@ static struct sk_buff *tcp_collapse_one(struct sock *sk, struct sk_buff *skb,
  */
 static void
 tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
-	     struct sk_buff *head, struct sk_buff *tail, u32 start, u32 end)
+	     struct sk_buff *head, struct sk_buff *tail, u32 start)
 {
 	struct sk_buff *skb = head, *n;
 	struct sk_buff_head tmp;
 	u8 scaling_ratio;
+	u32 sub_end;
 
 	scaling_ratio = min(tcp_sk(sk)->scaling_ratio,
 			    TCP_COLLAPSE_SCALING_RATIO);
 
+	__skb_queue_head_init(&tmp);
+
 	/* First, check that queue is collapsible and find
 	 * the point where collapsing can be useful.
 	 */
@@ -5872,38 +5875,48 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 
 		/* The first skb to collapse is:
 		 * - not SYN/FIN and
-		 * - the unread portion starting from "start" is bloated, or
-		 *   overlaps to the next one and mptcp allow collapsing.
+		 * - the unread portion starting from "start" is bloated.
 		 */
-		if (!skb_frags_readable(skb) ||
-		    TCP_SKB_CB(skb)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN))
-			goto skip_this;
-
-		if (tcp_collapse_skb_bloated(skb, start, scaling_ratio))
-			break;
-
-		if (n && n != tail && skb_frags_readable(n) &&
-		    tcp_skb_can_collapse_rx(skb, n) &&
-		    TCP_SKB_CB(skb)->end_seq != TCP_SKB_CB(n)->seq)
+		if (skb_frags_readable(skb) &&
+		    !(TCP_SKB_CB(skb)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN)) &&
+		    tcp_collapse_skb_bloated(skb, start, scaling_ratio))
 			break;
 
-skip_this:
 		/* Decided to skip this, advance start seq. */
 		start = TCP_SKB_CB(skb)->end_seq;
 	}
 
 	if (!skb || skb == tail)
-		return;
+		goto end;
 
-	__skb_queue_head_init(&tmp);
+	/* Second, find consecutive collapsible skb. */
+	sub_end = TCP_SKB_CB(skb)->end_seq;
+
+	for (n = tcp_skb_next(skb, list); n && n != tail; n = tcp_skb_next(n, list)) {
+		if (!skb_frags_readable(n) ||
+		    TCP_SKB_CB(n)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN) ||
+		    !tcp_skb_can_collapse_rx(skb, n))
+			break;
+
+		if (!after(TCP_SKB_CB(n)->end_seq, sub_end))
+			continue;
+
+		/* seq and end_seq must increase monotonically for rbtree. */
+		if ((list || !before(TCP_SKB_CB(n)->seq, sub_end)) &&
+		    !tcp_collapse_skb_bloated(n, sub_end,
+					      TCP_COLLAPSE_SCALING_RATIO))
+			break;
 
-	while (before(start, end)) {
-		int copy = min_t(int, TCP_COLLAPSE_MAX_SIZE, end - start);
+		sub_end = TCP_SKB_CB(n)->end_seq;
+	}
+
+	while (before(start, sub_end)) {
+		int copy = min_t(int, TCP_COLLAPSE_MAX_SIZE, sub_end - start);
 		struct sk_buff *nskb;
 
 		nskb = alloc_skb(copy, GFP_ATOMIC);
 		if (!nskb)
-			break;
+			goto end;
 
 		memcpy(nskb->cb, skb->cb, sizeof(skb->cb));
 		TCP_SKB_CB(nskb)->has_rxtstamp = false;
@@ -5942,15 +5955,11 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 			}
 			if (!before(start, TCP_SKB_CB(skb)->end_seq)) {
 				skb = tcp_collapse_one(sk, skb, list, root);
-				if (!skb ||
-				    skb == tail ||
-				    !tcp_skb_can_collapse_rx(nskb, skb) ||
-				    (TCP_SKB_CB(skb)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN)) ||
-				    !skb_frags_readable(skb))
-					goto end;
 			}
 		}
 	}
+
+	goto restart;
 end:
 	skb_queue_walk_safe(&tmp, skb, n)
 		tcp_rbtree_insert(root, skb);
@@ -5989,7 +5998,7 @@ static void tcp_collapse_ofo_queue(struct sock *sk)
 			if (range_truesize != head->truesize ||
 			    end - start >= SKB_WITH_OVERHEAD(PAGE_SIZE)) {
 				tcp_collapse(sk, NULL, &tp->out_of_order_queue,
-					     head, skb, start, end);
+					     head, skb, start);
 			} else {
 				sum_tiny += range_truesize;
 				if (sum_tiny > sk->sk_rcvbuf >> 3)
@@ -6103,8 +6112,7 @@ static int tcp_prune_queue(struct sock *sk, const struct sk_buff *in_skb)
 		if (!skb_queue_empty(&sk->sk_receive_queue))
 			tcp_collapse(sk, &sk->sk_receive_queue, NULL,
 				     skb_peek(&sk->sk_receive_queue),
-				     NULL,
-				     tp->copied_seq, tp->rcv_nxt);
+				     NULL, tp->copied_seq);
 
 		if (tcp_can_ingest(sk, in_skb))
 			return 0;
-- 
2.56.0.679.gc527c65306-goog

