Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794870362;
	b=XnUkdVwpXmE330d/Qsr2g87LSolW1JbyHV9abtYUlagpNnnhevA0vpoz6EWvhphLhN8G
	 Hgj3mhNxRHnpDj32i+CHsPWz6AdNNhpsa16uvtasnV/roI0n+psPbzQzaJbS+39S5KLiW
	 7UHGRs35z8nbccz9gGOuQ7IySRbkh5wQ3B2Zma92YRn0FFe+3AijnGjZOfcvLSjTGJ1VF
	 U/QBOkMNM+X5hnkjHpTXzoZQdR4ERGSr9aFo8tncyi0gCZH5tZyeYApHOkcPFuH91tNMk
	 zh6YKgvWagVkPSSb/8UiwkL684CLwqSg58U21DVUf+bEHJYHkW0+xTGkiIPKZHmfNMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794870362;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=z4fBymZZSSUULWGJNGl+cnaSscVLy1TLb572Nad7Hrk=;
	b=p/XFcw84oNher2LuXEffdsTy/yJ/JeBImW2tmK1oA43kQiT6B4Q2Qwr0z/np+hr9Yls5
	 zDZl9+xmdTEG3DeOOWgJLX/R9oTaTxqV/+0iVsdaXaBjOAf/i8cOddFcqeC+P7+LAxJ+y
	 PzQeU1eIC08/Sj+z6SQkppWM+47/VS88Yo0TLW0ilWU0ako17EKTrL62+8CraSwmkwiSW
	 XAP/jzWm5G5gFTWSwx4YKa6IF82DIkce/+8okihYv1g8T5WRkoyr7s+Y6isxEcapwsfan
	 7qwol++TdUUZ5TnvviNmcCp3PhDzciRW+QS3lRhdTGPIC9otjf9lqbsufjzvMo9z4cQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Vx5PzuhL;
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7207606A882
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 23:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7207606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Vx5PzuhL
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ada6ccd402so2874447a91.2
        for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 15:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794870361; x=1795475161; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z4fBymZZSSUULWGJNGl+cnaSscVLy1TLb572Nad7Hrk=;
        b=Vx5PzuhLVqyroQvAOSmaZimf33zHM8AeZrO9OquS0mmLfqAfjlcH15FffJ5W8ibqoV
         RrwrubRpXEg0hwJy575LMtZTL3iMYS/hizwQScJRSB64Sy7F1lGlgeS8Ze7R7zHul/t8
         U2cw63EpEpEYulygBOut41HFzB8F9qPdLwiFLG+wr5vDwKo0X07s+02mr1t21b8mwqlC
         KhUsYxAovPxIl24OxY6LImCJMEcjitOxnuM0w6jdr8kxxCMG5+4Nx4hnLeYMPP6OMRu1
         AmOf9ZHw86uLSrYQ4GuiE7hO+OveAqn3W+cMVhyhdFmUtgdh6cMKDk7MWbe6HKuEbBoY
         J6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794870361; x=1795475161;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z4fBymZZSSUULWGJNGl+cnaSscVLy1TLb572Nad7Hrk=;
        b=sYvekPXW/x8fBUWwEOBPDWJYf/KjgcMhSXrODxIEvgGF15qmyk81KtyLapgFWEllwQ
         ajCp2MbM89p2N7tTcPyFbohPn5ZKxAeWdZAyc64RMMxdO+YDwamr5ynIIJb4/jPxILzV
         UfkoUxUSKYLkR1ogq/k3IH5wsqVCoWe9bXc6RIBjkWD554SWl8XveGJfbJcTJJEPc6QZ
         Onk8PNwua8gbKCMeO3wJnvtn48t7Ds5RLQfUJRy0PVE5RHAvpC6ji8znqfKwoMI32T1W
         iizNKpDuCvgcRqAgZsdUlFa2jtwPoyVBQGPp2UEchlb7n+lfLhRlvM0nJ2NMklWdASI5
         8QYQ==
X-Forwarded-Encrypted: i=1; AL+hErHFIAhyRO72ORneVbVhufC/AgVLpsg3yRdMhyNtkwzwLFBjOoS2NhxtW4tgFFMKBpUdeI1rxg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+W0JlgiqsCkmsMWh6A5rW2+wf5vQZkKXzyJVjMGqeb111GzeHz
	OIdGja79MrHepkUmUGZsZyjqS+xJ6ehQqJuh5X1SGDPhv5KvXOdlNpGmPWgiXd05fuglo8AWHL1
	FFCNLcg==
X-Received: from pllh8.prod.google.com ([2002:a17:902:7488:b0:2ee:192c:eed2])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:4686:b0:2df:90d4:7758
 with SMTP id d9443c01a7336-2ee0dc93c50mr104420135ad.23.1794870360916; Mon, 16
 Nov 2026 15:06:00 -0800 (PST)
Date: Mon, 16 Nov 2026 23:05:28 +0000
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
Message-ID: <20261116230555.2305867-5-kuniyu@google.com>
Subject: [PATCH v2 net-next 4/7] tcp: Skip collapsing if collapsed skb is less-dense.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Once tcp_collapse() finds a collapsible skb, it collapses
consecutive bloated skbs.

However, the end result could be the same or larger than
as is in some cases:

  1. skb is already minimum

     If SKB_HEAD_ALIGN(len) <= SKB_SMALL_HEAD_CACHE_SIZE,
     skb is allocated from skbuff_small_head, and skb->truesize
     never changes.

  2. SKB_HEAD_ALIGN() and kmalloc_size_roundup() in alloc_skb()

     Assume two bloated skbs with len = 1448 B (truesize =
     2304 B, scaling_ratio = 160) and len = 300 B (truesize =
     896 B, scaling_ratio = 85), whose total truesize is
     3200 B.

     Collapsing them calls alloc_skb(1748), which rounds up
     SKB_HEAD_ALIGN(1748) = 2112 B to 4096 B and allocates a
     new skb with truesize = 4352 B (+1152 B!).

Even worse, in case 1, such a skb is reallocated repeatedly
by every tcp_collapse() in vain.

Let's calculate the final collapsed truesize before collapsing
skbs and skip the range if it does not shrink.

We could allocate skbs first and calculate the new truesize,
but given tcp_collapse() is called under memory pressure,
we want to avoid unnecessary allocation.

Note that kmalloc_reserve_size() uses __always_inline so that
this change does not affect non-FDO builds, and returns 0 when
skb_small_head_cache is used, similar to kmalloc_pfmemalloc().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: Add compute_skb_truesize() instead of macro
---
 include/linux/skbuff.h |  2 ++
 net/core/skbuff.c      | 26 +++++++++++++++++++++++---
 net/ipv4/tcp_input.c   | 24 +++++++++++++++++++++++-
 3 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 1d6832878930..310e4881045b 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -274,6 +274,8 @@
 			 SKB_DATA_ALIGN(sizeof(struct sk_buff)) +	\
 			 SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
 
+unsigned int compute_skb_truesize(unsigned int size, gfp_t flags);
+
 struct net_device;
 struct scatterlist;
 struct pipe_inode_info;
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 2e81aacc998b..a89eaadc729f 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -589,6 +589,17 @@ struct sk_buff *napi_build_skb(void *data, unsigned int frag_size)
 }
 EXPORT_SYMBOL(napi_build_skb);
 
+static __always_inline size_t kmalloc_reserve_size(unsigned int size, gfp_t flags)
+{
+	size_t obj_size = SKB_HEAD_ALIGN(size);
+
+	if (obj_size <= SKB_SMALL_HEAD_CACHE_SIZE &&
+	    !(flags & KMALLOC_NOT_NORMAL_BITS))
+		return 0;
+
+	return kmalloc_size_roundup(obj_size);
+}
+
 static void *kmalloc_pfmemalloc(size_t obj_size, gfp_t flags, int node)
 {
 	if (!gfp_pfmemalloc_allowed(flags))
@@ -612,9 +623,8 @@ static void *kmalloc_reserve(unsigned int *size, gfp_t flags, int node,
 	size_t obj_size;
 	void *obj;
 
-	obj_size = SKB_HEAD_ALIGN(*size);
-	if (obj_size <= SKB_SMALL_HEAD_CACHE_SIZE &&
-	    !(flags & KMALLOC_NOT_NORMAL_BITS)) {
+	obj_size = kmalloc_reserve_size(*size, flags);
+	if (!obj_size) {
 		obj = kmem_cache_alloc_node(net_hotdata.skb_small_head_cache,
 				flags | __GFP_NOMEMALLOC | __GFP_NOWARN,
 				node);
@@ -651,6 +661,16 @@ static void *kmalloc_reserve(unsigned int *size, gfp_t flags, int node,
 	return obj;
 }
 
+unsigned int compute_skb_truesize(unsigned int size, gfp_t flags)
+{
+	size_t obj_size = kmalloc_reserve_size(size, flags);
+
+	if (!obj_size)
+		obj_size = SKB_SMALL_HEAD_CACHE_SIZE;
+
+	return obj_size + SKB_DATA_ALIGN(sizeof(struct sk_buff));
+}
+
 /* 	Allocate a new skbuff. We do this ourselves so we can fill in a few
  *	'private' fields and also do memory statistics to find all the
  *	[BEEP] leaks.
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 5bd42a74c6f5..0815e1891fba 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5850,8 +5850,10 @@ static void
 tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 	     struct sk_buff *head, struct sk_buff *tail, u32 start)
 {
+	int old_truesize, new_truesize;
 	struct sk_buff *skb = head, *n;
 	struct sk_buff_head tmp;
+	int remainder, nskbs;
 	u8 scaling_ratio;
 	u32 sub_end;
 
@@ -5891,6 +5893,7 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 
 	/* Second, find consecutive collapsible skb. */
 	sub_end = TCP_SKB_CB(skb)->end_seq;
+	old_truesize = skb->truesize;
 
 	for (n = tcp_skb_next(skb, list); n && n != tail; n = tcp_skb_next(n, list)) {
 		if (!skb_frags_readable(n) ||
@@ -5898,8 +5901,10 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 		    !tcp_skb_can_collapse_rx(skb, n))
 			break;
 
-		if (!after(TCP_SKB_CB(n)->end_seq, sub_end))
+		if (!after(TCP_SKB_CB(n)->end_seq, sub_end)) {
+			old_truesize += n->truesize;
 			continue;
+		}
 
 		/* seq and end_seq must increase monotonically for rbtree. */
 		if ((list || !before(TCP_SKB_CB(n)->seq, sub_end)) &&
@@ -5908,6 +5913,23 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 			break;
 
 		sub_end = TCP_SKB_CB(n)->end_seq;
+		old_truesize += n->truesize;
+	}
+
+	/* Third, check if the new skbs have high density. */
+	nskbs = (sub_end - start) / TCP_COLLAPSE_MAX_SIZE;
+	new_truesize = nskbs * SKB_TRUESIZE(TCP_COLLAPSE_MAX_SIZE);
+
+	remainder = (sub_end - start) % TCP_COLLAPSE_MAX_SIZE;
+	if (remainder) {
+		nskbs++;
+		new_truesize += compute_skb_truesize(remainder, GFP_ATOMIC);
+	}
+
+	if (old_truesize <= new_truesize) {
+		start = sub_end;
+		skb = n;
+		goto restart;
 	}
 
 	while (before(start, sub_end)) {
-- 
2.56.0.679.gc527c65306-goog

