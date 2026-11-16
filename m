Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794870363;
	b=HHyPP8tiitt/EwBWVVVYHkwuidiDfSnMXLD39ZLja48awJFxX6Zc/9QB2g21AZeIFpIk
	 ogmCsyCgl7aBLqbMeUUlzOtQgzfVKrUJAx3kqRINd6SZuCgP3JvRiOYVbOtMJrNOVY0dx
	 RboG5SpMJQOA3MY6qv1TDVB1exjNbyUGI2mw7f9hKEI6tflwd7EhUfdh04XxH4BiMcsWX
	 6MOqtB2U3CZrVxFn2Tr/1ABdjZccPucOXloPW2iWgVK9dD3/R7z7c2+GajFw7dGCOa92d
	 iUcqyjd2YoZSEfCNN1kSClVIv+fzEe2S0JsEGfJZl2vs85RTX8oZvmRcNnD4iExaMiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794870363;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Oxki1cduy7Jlef3gLyF5h+aCOZHnxGDcLpRSm3QnCQM=;
	b=1sfSaHuXlffCOOHc8e0QV6MpW/z48e8VkAAdKTVZkkQGFp8FFs1IJsAt239RaANQkR7V
	 m4P00WZ3mlhrJlFu+VJa128tnfkP3oVM2bgBcCen0UnUn+vP2AIUmT+A/Mg0l9+fovoPi
	 zh8MDtJpk9EK/HEUUuXGYkPeHX/x7TS9w/gdxMoepzvCTQ+v4jjc79xCGhoiiQ8axnbWa
	 hq/7Chi976Yi/FYvVQJ26Du3pr2Nz2QmxXiEN/XuQ+DK65gB8t9rrGEDjE0VHpcztxMkb
	 iIA9MZaLRq87URlEcKhPLFozVIZyN7VGpUNRp+aw40fghZp+rcqgdMk/Gm+KkWTHlnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=j4sxo+lI;
	arc=none smtp.remote-ip=209.85.215.199
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD0D606A33D
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 23:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DD0D606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=j4sxo+lI
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc4216aee8fso1920243a12.1
        for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 15:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794870362; x=1795475162; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Oxki1cduy7Jlef3gLyF5h+aCOZHnxGDcLpRSm3QnCQM=;
        b=j4sxo+lIlx58kit6UudOGqXENr/uEGfowN7ZMuRNaQVBmLikcmbWQESXThjLEZ/mRW
         gNLsIRq8CbebTrgm/NJVDSLU2QwzXedUamYWlPR6spgTANhHUdLELkP4VnGsQA9fOkwp
         7ZAzVEWNpTqDAL4JNSO4P2zYeJ3oVZC64fkjEPuwG/4eA6v+7cz/2Iz1ZiLqDYg93HAT
         dkGBd9YJmwWrn/ivVPN7OkRg6vs0WheA+LbUKGjfbdrkL9L2leP6BTfriNLRin53kg8U
         UszpG/gkw8k6qPluivni921RwI2ur1hk5NgxW8S/ZXM9trnr7SJiaTvSYP8oXv62YfBt
         1lAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794870362; x=1795475162;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Oxki1cduy7Jlef3gLyF5h+aCOZHnxGDcLpRSm3QnCQM=;
        b=ExmjlE+t9WK/8rDpazbCw3ePJKaAF1bRuK0lo0RmYqtlNYc90UNW61CuUR/fAj9LfE
         3mCv6rgzts7bsYEAg7fLl7yDwlItea2W3lfNUVQlwY4Rzpf6hcfBr4ZWyDW6suLPiGoZ
         Pp1UzaDBH3JUyK6jB7XDhehOi/BWdnOxaJoxV1oZHalg0hQ9YUIqRX4xT3vosJa23vds
         2GPPHuFkyuu/J+TCK0WqXkF5louSvH1HJ/3nkhAaKKsP+fXjjtoDZRn1w4xxPXkKMTYy
         j6JO0CWpLaOoQmLmXwCVY6pdg22bAX/jyJnySEIR2F5lc9IGcOqz7aOf6Mlty8m1aWms
         VLew==
X-Forwarded-Encrypted: i=1; AL+hErEsMd9vN8Wg5mGlO9vj34S2o7MoiF0cghJtIB0w6+YCOO2/yRzOcFc0yMF0nBYtI7foXSWcKg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+7UN8tJ7NbUoG+0T5iTrxJHu+z1SwkMfvIaoVINWOXY8hUXHGr
	EY3GaxOOgYavcWDMngVyMErkk3BmOvWa7BtRiPcJIQp0BaoN1OfMIja74OcEperpkelbtoVFa8D
	GpK66Og==
X-Received: from pgam4.prod.google.com ([2002:a05:6a02:2b44:b0:cd8:bcc7:e588])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:890e:b0:3e2:9f41:9f63
 with SMTP id adf61e73a8af0-3f7a49c08f7mr9647355637.1.1794870361768; Mon, 16
 Nov 2026 15:06:01 -0800 (PST)
Date: Mon, 16 Nov 2026 23:05:29 +0000
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
Message-ID: <20261116230555.2305867-6-kuniyu@google.com>
Subject: [PATCH v2 net-next 5/7] tcp: Allocate all new skb before collapsing.
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
so the section size is normally capped at TCP_COLLAPSE_MAX_TOTAL_SIZE
(16 skbs), except when a single bloated skb or overlapping OOO skbs
must be collapsed together to free the original skb or keep the
rbtree monotonic.

Once the size exceeds the limit, the remaining skbs are re-evaluated
from restart:.

Note that the next skb can be skipped if its density already meets
tp->scaling_ratio, and each cut adds at most one remainder skb
(~3.4% worst-case truesize overhead on 4 KiB pages), which is a
small tradeoff to bound the temporary allocation.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@kernel.org>
---
 net/ipv4/tcp_input.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 0815e1891fba..ca4cdb93373d 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5812,6 +5812,7 @@ static struct sk_buff *tcp_skb_next(struct sk_buff *skb, struct sk_buff_head *li
 #define TCP_COLLAPSE_SCALING_RATIO				\
 	((TCP_COLLAPSE_MAX_SIZE << TCP_RMEM_TO_WIN_SCALE) /	\
 	 (SKB_TRUESIZE(TCP_COLLAPSE_MAX_SIZE)))
+#define TCP_COLLAPSE_MAX_TOTAL_SIZE (TCP_COLLAPSE_MAX_SIZE * 16)
 
 static bool tcp_collapse_skb_bloated(const struct sk_buff *skb,
 				     u32 start, u8 scaling_ratio)
@@ -5852,8 +5853,9 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 {
 	int old_truesize, new_truesize;
 	struct sk_buff *skb = head, *n;
-	struct sk_buff_head tmp;
+	struct sk_buff_head tmp, pool;
 	int remainder, nskbs;
+	struct sk_buff *nskb;
 	u8 scaling_ratio;
 	u32 sub_end;
 
@@ -5861,6 +5863,7 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 			    TCP_COLLAPSE_SCALING_RATIO);
 
 	__skb_queue_head_init(&tmp);
+	__skb_queue_head_init(&pool);
 
 	/* First, check that queue is collapsible and find
 	 * the point where collapsing can be useful.
@@ -5908,8 +5911,9 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 
 		/* seq and end_seq must increase monotonically for rbtree. */
 		if ((list || !before(TCP_SKB_CB(n)->seq, sub_end)) &&
-		    !tcp_collapse_skb_bloated(n, sub_end,
-					      TCP_COLLAPSE_SCALING_RATIO))
+		    (TCP_SKB_CB(n)->end_seq - start >= TCP_COLLAPSE_MAX_TOTAL_SIZE ||
+		     !tcp_collapse_skb_bloated(n, sub_end,
+					       TCP_COLLAPSE_SCALING_RATIO)))
 			break;
 
 		sub_end = TCP_SKB_CB(n)->end_seq;
@@ -5924,6 +5928,8 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 	if (remainder) {
 		nskbs++;
 		new_truesize += compute_skb_truesize(remainder, GFP_ATOMIC);
+	} else {
+		remainder = TCP_COLLAPSE_MAX_SIZE;
 	}
 
 	if (old_truesize <= new_truesize) {
@@ -5932,14 +5938,19 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 		goto restart;
 	}
 
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
@@ -5985,6 +5996,8 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 end:
 	skb_queue_walk_safe(&tmp, skb, n)
 		tcp_rbtree_insert(root, skb);
+
+	__skb_queue_purge_reason(&pool, SKB_CONSUMED);
 }
 
 /* Collapse ofo queue. Algorithm: select contiguous sequence of skbs
-- 
2.56.0.679.gc527c65306-goog

