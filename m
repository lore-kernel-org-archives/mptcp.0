Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795072618;
	b=jU9iTooi2mceMeFLPz4jIle6dWZoSLSqx+McxO5Ga85wcrmklKrcmEkrxhuCGolzTcud
	 kltKXwWp/e+bK79Vg2DT9Bmr05RYt6zLhgyTi2mlEJjF7c4MumHsg0sK3j+gyztEnqneG
	 L0b5oYPgvii4gB84XSLpZ8tFXs5SvpiD8ndaX0zFIJMRDEbfDo3usVT2E6ArbM1KFZyw0
	 90r5kRF6Rm282lLAYioV2qlh+fTNd97yFl9OU+d+5EJMnc2FYmJpkGD0uy1pRZHG87IW2
	 FuiXMPiGBqzdAw3Lr4uJVTa0Df0MRaCITquCD8pwcsxreDNBsP/nKOe9WAX16ZC9c8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795072618;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=WTJSAbVd18SG4y7u4B/Xr6BzdN9hE6nrl/zI/oyvASw=;
	b=M7Y3/MdFnKPqvH92FyjJqb6/SCAhXWsWx6Y3/kQFgiw6wY92MuVToC1fHSqHkFZ/S1ct
	 PnxeuStalMDqR6ihm7Fxo12mE1O+qaAfEWy4WKaKboEIqSXgEPDFbZwzCP21K5YbLMVbl
	 TOqun6E+z5z2v9/vcGFb80xsbV15Lqa1/twtLITWIKhxUZe+EJxjMbEwozxrrS9Pag962
	 +vADwhwDKGjHXgp65690L1HQWwRoo2Hwr+KxQz/TYmCSDv+8ZorOhiBWVfWdwAuPXcf8b
	 KS5cgBjTw+OX24mLXtkwS47th+BErgDDtchEt9S94I4WA5jk/h29bGMjZACttXYBo7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=R5OjCCQ4;
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F4960A2615
	for <mptcp@lists.linux.dev>; Thu, 19 Nov 2026 07:16:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97F4960A2615
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=R5OjCCQ4
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3b3a9826f6dso1642700a91.1
        for <mptcp@lists.linux.dev>; Wed, 18 Nov 2026 23:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795072617; x=1795677417; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WTJSAbVd18SG4y7u4B/Xr6BzdN9hE6nrl/zI/oyvASw=;
        b=R5OjCCQ4qFNkGnLr/0zy7Y5NREiSBRy0CaBcLdWqlxeAT2D+EFCoOb4Myc39d5vmhj
         ZvvzzUHPEPphP+CGnCgS8rwEp6LQZP3Xm2tHsEGvh2VQKh7RnZd3AxzFtyORfzho0XYI
         e/YGgGxhz8nmYeaQi9me9gyMVTH2LjI/4zscGXHK0LB9xoJFqW/eyI1ag70nVDDJGO6x
         /9T7GMNYIaC56F8MZMnv7haajjC69hI1tjdcBIp/aJIykX77CLcASzST/iO0g5lMtIy/
         RaUAgjYzFr8OatbwznyOSC3H5TJ5ZOX+IY6au5ti1P/YZgSgMy5VoM1a7jSqHpOYexeN
         wUwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795072617; x=1795677417;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WTJSAbVd18SG4y7u4B/Xr6BzdN9hE6nrl/zI/oyvASw=;
        b=OeaIfRbzzIpCyKMCyhHZvj6Fna+B3Xfm1xf7hZ9dBrNBogtufrx0cw8GwdkZ0y9u7g
         EyctutFEu1cNp1bAzOsPVe+Z95bobf69R0gq+67RX2J53fh/sQu0kM3Zj2P4fha4UdG7
         pVct2eL6mzoDZb+BCWeOUWEVykYE6Wv7HWj75gJNAPJGTbw2WHIZnc+ESB2Vhn92kODr
         LU5SPLz+CY0vg71ze/bomDoY3oTb8KcQUYRiwhZAwadPDPBh0ZX2nPqIkgxdBPAUbjml
         slnFdmIDvtMszNtCrxRDw0vw9uO79OMpscwwuljTHDGS8UIV/sUlzP6jNGpbdA1B9Gtn
         aAUw==
X-Forwarded-Encrypted: i=1; AL+hErHDoq6A5nXtBvhvFFb5yhwBr4nlB3IfMkAF9YOFa5w/nek7MwtZJijT0ZRyno1TIvFR6lxFNA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9ZAZ15JAgRu7XBcZboG6JJm29t9hINqDwRFLq51d0Wp8WahiGL
	pE0/MObyht2wHRyUlKgJZibLbEUqtfMg7NdsiFLT7uKFSNU0JsQ+/v6jNbgsA6/12cwSZT/xpWJ
	H9UGcvA==
X-Received: from pjbhs15.prod.google.com ([2002:a17:90b:200f:b0:3b4:a90:5a08])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:254e:b0:3ad:1b31:92d8
 with SMTP id 98e67ed59e1d1-3b3d07e37e7mr4576279a91.60.1795072616783; Wed, 18
 Nov 2026 23:16:56 -0800 (PST)
Date: Thu, 19 Nov 2026 07:15:57 +0000
In-Reply-To: <20261119071649.374106-1-kuniyu@google.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261119071649.374106-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261119071649.374106-6-kuniyu@google.com>
Subject: [PATCH v3 net-next 5/7] tcp: Allocate all new skb before collapsing.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

At the final stage, tcp_collapse() iterates over collapsible
candidate skbs and repacks them to new skbs.

In each iteration, a new skb is allocated and inserted to the
receive queue or a temporary list for RB tree.

If alloc_skb() fails while splitting a large bloated skb across
multiple new skbs, the partially-copied skb is not removed and
new skbs remain in the queue as duplicates, consuming more memory.

It is only when all candidates are properly collapsed that
we can save memory.

To avoid complicated rollback, let's preallocate skbs before
collapsing.

Now all skb in [start, sub_end) must be allocated in a batch,
so the section size is capped at TCP_COLLAPSE_MAX_TOTAL_SIZE
(16 skbs), except for the first single skb.

Once the size exceeds the limit, the remaining skbs are
re-evaluated from restart:.

Legitimate overlaps (retransmits with a different segmentation)
only involve a few skbs, so if an overlapping OOO chain reaches
the limit, we simply skip it.

Note that the next skb can be skipped if its density already meets
tp->scaling_ratio, and each cut adds at most one remainder skb
(~3.4% worst-case truesize overhead on 4 KiB pages), which is a
small tradeoff to bound the temporary allocation.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v3: Make TCP_COLLAPSE_MAX_TOTAL_SIZE hard-limit for multiple skbs
---
 net/ipv4/tcp_input.c | 41 ++++++++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 27ed9ba11ec9..990e34896373 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5822,6 +5822,11 @@ static struct sk_buff *tcp_skb_next(struct sk_buff *skb, struct sk_buff_head *li
 #define TCP_COLLAPSE_SCALING_RATIO				\
 	((TCP_COLLAPSE_MAX_SIZE << TCP_RMEM_TO_WIN_SCALE) /	\
 	 (SKB_TRUESIZE(TCP_COLLAPSE_MAX_SIZE)))
+/* Cap pool preallocation per sub-range to at most 16 skbs in seq
+ * space.  A single first skb exceeding this is still collapsed,
+ * whereas an exceeding overlapping ofo range is skipped.
+ */
+#define TCP_COLLAPSE_MAX_TOTAL_SIZE (TCP_COLLAPSE_MAX_SIZE * 16)
 
 static bool tcp_collapse_skb_bloated(const struct sk_buff *skb,
 				     u32 start, u8 scaling_ratio)
@@ -5862,8 +5867,9 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 {
 	unsigned int old_truesize, new_truesize;
 	struct sk_buff *skb = head, *n;
-	struct sk_buff_head tmp;
+	struct sk_buff_head tmp, pool;
 	int remainder, nskbs;
+	struct sk_buff *nskb;
 	u8 scaling_ratio;
 	u32 sub_end;
 
@@ -5871,6 +5877,7 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 			    TCP_COLLAPSE_SCALING_RATIO);
 
 	__skb_queue_head_init(&tmp);
+	__skb_queue_head_init(&pool);
 
 	/* First, check that queue is collapsible and find
 	 * the point where collapsing can be useful.
@@ -5926,8 +5933,9 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 		}
 
 		if (!overlap &&
-		    !tcp_collapse_skb_bloated(n, sub_end,
-					      TCP_COLLAPSE_SCALING_RATIO))
+		    (TCP_SKB_CB(n)->end_seq - start >= TCP_COLLAPSE_MAX_TOTAL_SIZE ||
+		     !tcp_collapse_skb_bloated(n, sub_end,
+					       TCP_COLLAPSE_SCALING_RATIO)))
 			break;
 
 		sub_end = TCP_SKB_CB(n)->end_seq;
@@ -5935,25 +5943,38 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 		n = tcp_skb_next(n, list);
 	}
 
+	if (sub_end != TCP_SKB_CB(skb)->end_seq &&
+	    sub_end - start >= TCP_COLLAPSE_MAX_TOTAL_SIZE)
+		goto skip;
+
 	/* Third, check if the new skbs have high density. */
 	nskbs = (sub_end - start) / TCP_COLLAPSE_MAX_SIZE;
 	new_truesize = nskbs * SKB_TRUESIZE(TCP_COLLAPSE_MAX_SIZE);
 
 	remainder = (sub_end - start) % TCP_COLLAPSE_MAX_SIZE;
-	if (remainder)
+	if (remainder) {
+		nskbs++;
 		new_truesize += skb_head_truesize(remainder, GFP_ATOMIC);
+	} else {
+		remainder = TCP_COLLAPSE_MAX_SIZE;
+	}
 
 	if (old_truesize <= new_truesize)
 		goto skip;
 
-	while (before(start, sub_end)) {
-		int copy = min_t(int, TCP_COLLAPSE_MAX_SIZE, sub_end - start);
-		struct sk_buff *nskb;
-
-		nskb = alloc_skb(copy, GFP_ATOMIC);
+	while (nskbs--) {
+		nskb = alloc_skb(nskbs ? TCP_COLLAPSE_MAX_SIZE : remainder,
+				 GFP_ATOMIC);
 		if (!nskb)
 			goto end;
 
+		__skb_queue_tail(&pool, nskb);
+	}
+
+	while (before(start, sub_end)) {
+		int copy = min_t(int, TCP_COLLAPSE_MAX_SIZE, sub_end - start);
+
+		nskb = __skb_dequeue(&pool);
 		memcpy(nskb->cb, skb->cb, sizeof(skb->cb));
 		TCP_SKB_CB(nskb)->has_rxtstamp = false;
 		skb_copy_decrypted(nskb, skb);
@@ -6003,6 +6024,8 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 end:
 	skb_queue_walk_safe(&tmp, skb, n)
 		tcp_rbtree_insert(root, skb);
+
+	__skb_queue_purge_reason(&pool, SKB_CONSUMED);
 }
 
 /* Collapse ofo queue. Algorithm: select contiguous sequence of skbs
-- 
2.56.1.708.g77570a6a1d-goog

