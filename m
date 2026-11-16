Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794870361;
	b=jRnU9yloKGGV7VRtcOT51pJQB4LSBm/R/HCC7kxctOgKQNIS9GiJU/x5hAXofa4NPEjg
	 qdlb4xWcxNHEnn7EM2ztkgT8zBM8XEHJAVR9ebpRKGRJALJ2GAgqpOoOBQNNgpctFlnaa
	 SLOxjAo1Dz5BD08g3I5OFfzFa3YnS7MVtKuVZQtu6mTA1FyrXC0U8YgosWIoiQeWRD1Zb
	 rcOHi1nVVokqvITzYu8Q0rZ+MIScOQEFzizXBBJjTXkFIfBm7U7zmzbOa07MMvKaiIX2P
	 UnRPI4Ru3awwx+4OPwVorO3Pr3tE7bP1JXNHVvCnzD5Cd/0CCG0y8vyUhklyG9jNkkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794870361;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=82kaqSP7iEmpNxWJnQWMoEafhsr/yOtqX12R6w+tpRU=;
	b=EdXX1pkaNHdh0WbNZmuTDf4XKxg6EMqwnec5LbLLBqj5trXN6CsUeRAyyTOJmnmnFmN4
	 Wiivy4aunjtPPMQKMkPAx1seo1yrlhbmOpodpxBO9SHZz9fPBjzsDx9CyTNZLaeJez5Zn
	 RjORPF0c3kDjcYfkwfVbZTxp/7M7DozunXHOY8XFVYD8u6sFryIpXjwP3RctP2F5D+FoG
	 PX6sgRGREDdy+c9MmSU4G2dKhDJPFRvObVM+j0+WyvBMBrtXSKKHrCY8kvayPZ4u+8F+U
	 xwKdut/4zuNPrVNjRxksw4j3rHRYJaywxbCVN6P+QnQuY3gFhYirtwqd5rnJmOPOFEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=J36b73gi;
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4669D606A33A
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 23:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4669D606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=J36b73gi
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3b3a9ee822fso548091a91.0
        for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 15:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794870359; x=1795475159; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=82kaqSP7iEmpNxWJnQWMoEafhsr/yOtqX12R6w+tpRU=;
        b=J36b73gixq665zWKeITRVB1csegpn6C3D5aK1DeEi1E7Edd4k/TXyWX5wY5E5dQXKz
         Ab5Bb/UAgdUkEep01XUWHgMEOU6ouS0T+7CWQtr98v0c3P02+383nDjuNTIXewBy33+P
         JGaB8JNG3GQTK769gfhHNLsIjU2uy7duuX8gyeIG+WI6S4cULDSuMWmM3Gk4LsNx0o9+
         sL9pjvTIeGIelqx/d+D4PG/nO8GcqneDgpX/yjV1CzZvxEOw8g/kg8fuGmgGSvvXTjdd
         O6km2qC2gJ0/3vcv1WP+CcGgW26s6fYR6JuRF6LDj4+BDceTTwBAZ8E3QJHCSsbknUYl
         SuIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794870359; x=1795475159;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=82kaqSP7iEmpNxWJnQWMoEafhsr/yOtqX12R6w+tpRU=;
        b=Brf0h6U6FGDPo5sztVQFXK5n3NENgDd8Urvql69UunBr9Ig97AlA1KbrIMOJOpeL6Y
         +rsNd3dY/Cg8s2XbgfiK/hDyF9JZbJ43dXC6jgOFiucpO+t/CQXsTkgpLNBMfkZSWaiY
         0MStW+3aCimEi6P6XUEQrVajsN5FWb3lExjuj6lPbynyvtK5lOYHj7xlJxM7jGtPstNH
         Iupt0S9FLnHQkchbe0F3aYCf8s/+Kw42kLXD4BgdIKR7CsHF5EJ4YGPkO9ZOqIzCIRCY
         s6oUTQpbf1Qxv0gmJMBl12MKzRBMcB8JzZ1mNCsbqDfIV/xchQBM2QO6ANWzZ0hx0LqZ
         SCCA==
X-Forwarded-Encrypted: i=1; AL+hErEivdb/1cEENDg2LeTdkn24gKwK0EPv/7rUeG1TECnAu0eodPXRlLKIC8WuzsIi0FlMaUMmPQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+cW4yTKuZi1QALi0GWYE27D7ixo5Okyeyro/qPVnJMx6YMEEXS
	t410RBjLzkq+WbRhkXfIYeNalbVEPBXtLjSo8VFclSdvVx13k8/Jeq+4XBSHGFtKvtCQPZVwxsu
	jERjW0A==
X-Received: from pjyd15.prod.google.com ([2002:a17:90a:dfcf:b0:3ad:ce09:ff3])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5608:b0:3ac:c024:b275
 with SMTP id 98e67ed59e1d1-3b1b089e262mr12037995a91.9.1794870359342; Mon, 16
 Nov 2026 15:05:59 -0800 (PST)
Date: Mon, 16 Nov 2026 23:05:26 +0000
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
Message-ID: <20261116230555.2305867-3-kuniyu@google.com>
Subject: [PATCH v2 net-next 2/7] tcp: Don't collapse high density skb.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

tcp_collapse() starts collapsing skb to a new skb if either
of the following is true:

  1. skb is less dense compared to tp->scaling_ratio
  2. skb has read data before @start

However, this could make situation worse.

The new skb size is SKB_TRUESIZE(SKB_MAX_ORDER(0, 0)) at most,
and with PAGE_SIZE being 4K, its scaling_ratio is 222 (86%).

If 4K-MSS GRO skb updates tp->scaling_ratio, it can be larger
than 222.

Then, even the newly collapsed skb could be detected as bloated
by the next tcp_collapse().

Also, even when only a few bytes are read from GRO skb, it is
collapsed by the 2nd rule, making less-efficient skb.

Let's cap tp->scaling_ratio with the collapsed skb's maximum
scaling_ratio and use unread bytes for bloat detection.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@kernel.org>
---
 net/ipv4/tcp_input.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 32e63d089db8..e07f43347409 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5808,6 +5808,19 @@ static struct sk_buff *tcp_skb_next(struct sk_buff *skb, struct sk_buff_head *li
 	return skb_rb_next(skb);
 }
 
+#define TCP_COLLAPSE_MAX_SIZE	SKB_MAX_ORDER(0, 0)
+#define TCP_COLLAPSE_SCALING_RATIO				\
+	((TCP_COLLAPSE_MAX_SIZE << TCP_RMEM_TO_WIN_SCALE) /	\
+	 (SKB_TRUESIZE(TCP_COLLAPSE_MAX_SIZE)))
+
+static bool tcp_collapse_skb_bloated(const struct sk_buff *skb,
+				     u32 start, u8 scaling_ratio)
+{
+	int unread = TCP_SKB_CB(skb)->end_seq - start;
+
+	return __tcp_win_from_space(scaling_ratio, skb->truesize) > unread;
+}
+
 static struct sk_buff *tcp_collapse_one(struct sock *sk, struct sk_buff *skb,
 					struct sk_buff_head *list,
 					struct rb_root *root)
@@ -5839,6 +5852,10 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 {
 	struct sk_buff *skb = head, *n;
 	struct sk_buff_head tmp;
+	u8 scaling_ratio;
+
+	scaling_ratio = min(tcp_sk(sk)->scaling_ratio,
+			    TCP_COLLAPSE_SCALING_RATIO);
 
 	/* First, check that queue is collapsible and find
 	 * the point where collapsing can be useful.
@@ -5855,15 +5872,14 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 
 		/* The first skb to collapse is:
 		 * - not SYN/FIN and
-		 * - bloated or contains data before "start" or
+		 * - the unread portion starting from "start" is bloated, or
 		 *   overlaps to the next one and mptcp allow collapsing.
 		 */
 		if (!skb_frags_readable(skb) ||
 		    TCP_SKB_CB(skb)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN))
 			goto skip_this;
 
-		if (tcp_win_from_space(sk, skb->truesize) > skb->len ||
-		    before(TCP_SKB_CB(skb)->seq, start))
+		if (tcp_collapse_skb_bloated(skb, start, scaling_ratio))
 			break;
 
 		if (n && n != tail && skb_frags_readable(n) &&
@@ -5882,7 +5898,7 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 	__skb_queue_head_init(&tmp);
 
 	while (before(start, end)) {
-		int copy = min_t(int, SKB_MAX_ORDER(0, 0), end - start);
+		int copy = min_t(int, TCP_COLLAPSE_MAX_SIZE, end - start);
 		struct sk_buff *nskb;
 
 		nskb = alloc_skb(copy, GFP_ATOMIC);
-- 
2.56.0.679.gc527c65306-goog

