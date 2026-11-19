Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795072618;
	b=wsHZS3TXf84QBjJ2ZK1h5poST7YmDd7XCEr6/KM9F9ZBABIQtVPGV6WUdycU6uHkEZua
	 KrQi58QtH5Gw/Qz2bJwlD0VxhIawlIkJXy05rBcGIuhdIIn5+GAk/6S9c8Z3ggpHZbDmB
	 Jnkbhkh/JCdjMQ9zIO9cF+aT+ZFFjkNCAV/Ji4MNEN6nNDeeQF/Q9YcZyIEpVS/JzrGaB
	 fjP3GqJXMoBXeIMWJH1jLwQ5/8H7AVP44bpxL/hoJB/4fl0dFBqvUC0htwFYhG2UKKVTk
	 Swc2hPUBQFCzsAWdjoUrM9eNQiSBLJVLfoWdIoG+TBsbhIACZNqqt6K/gIDV9Laxjcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795072618;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=CMnj+t+BttJGwsYDnQr6glYXkdhn5BK2wJJ0r6rAzhA=;
	b=5L461wgbnQPCDyh4fzXe88ePCBo9XHks7GmCvBhidkerC7mdjGRpqZBLziHsqvm3lObw
	 M61/ey2nepb4Bp3eQ51qKtAtQU7oC3IbM+gvJm6L9Uc2jJ3nPpd4Tb3mZBRqrGWFqsl2E
	 K8QyUkDLOhQn8rXrBYUd5R6XYm4M6V7c4r60g/pT7lq3PRMHSXLic6+2l+PltQP8yJ1hd
	 wiUTFiJeorEGTN2NOm5ErD4TtxHD1Aq88c6Wlw3MTMBB2318t7vXpu+lfncpz+W7BadVD
	 FckhCSa5nhcjDuN1a6p9ffSM5qO94fDP98nzitO5gAfnPJ6dQJspCCK1RPNx56XxtpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ibH41Qe3;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1A560A2615
	for <mptcp@lists.linux.dev>; Thu, 19 Nov 2026 07:16:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B1A560A2615
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ibH41Qe3
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ed05b3eaecso16403965ad.1
        for <mptcp@lists.linux.dev>; Wed, 18 Nov 2026 23:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795072618; x=1795677418; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CMnj+t+BttJGwsYDnQr6glYXkdhn5BK2wJJ0r6rAzhA=;
        b=ibH41Qe3DNDtenj2NwsPSbs4KMJUh+X73QCIJ6rblCuZf9jgNAKCgE9n7MOk4K67tK
         AGCBF6GVdC0jWvarU/wLQoC6ZY0fVYUbuG9EV1JEfrQcevuk4RkRrJVxHuTwfdT0zsuo
         vaRVtHCG0mTwMDXf+UQ3V3MkP6vw789VFinrObcOolMwZxF0QcYZb9R2ZEQlubP4CozZ
         6xAAVOkBpFbNX9ID76bSxBT1yzJ9L9+jQZP08sSlwH/W0ZEuIZQiLLeyppUdgEI1U9Om
         /V/7fGcGh8g1DaBymAPFtSQZDVAA5FNXSxSCe5oxqkfxXHdGqEp4zGg6A4821lAAUWS7
         IbgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795072618; x=1795677418;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CMnj+t+BttJGwsYDnQr6glYXkdhn5BK2wJJ0r6rAzhA=;
        b=FCVHeQXJYUlfZoWmWe2gxqdSDCpSNxVXJmwRWIcG+wFBgd8lTNVk2uPflDgTfY9T/R
         vk0SOjrev+r0YtBr1gs5XI7Ns1N/w1VNlB1kuOics6tGo9iX55/wVubehehmqbjgPjjB
         0Z2DbNK7crHqF7c5PrSLPxkZfpIJWKBt4nLGNc1rKG30W/NCPJVZo15an9PlrWVbo5cB
         xxfjdQEQkHrJQoOPYVwxvinX17Tv5XftktIIqomqMK8/ZmZraQbhLozOXUcB4UO9TC25
         P7qpxktpOW9/1Zb3jkIszTcusYoJet7jpihwgEkztYtFPLhHYkJsFNn01NVIOJa+zGsK
         ZJkw==
X-Forwarded-Encrypted: i=1; AL+hErGWgkERL5Of+X7yBrfIrAnvQ3VdQTHTs4nq0wW40fW9E8oI7vGgKyjikta3SkOLQL2BxBVOlw==@lists.linux.dev
X-Gm-Message-State: APuU4Z8FQl1fFp0a7kXEEegCZORN2A+HVnB57oj/mUIMfWHbkbLDxQXb
	K5ArvTb/dVZEafM6TjmGkH+QFlKlaFdPblIjelWfGo74KklX3lpIFhY9np1/7Y4P3d1c0EPdAAh
	4eUiyOQ==
X-Received: from pldb12.prod.google.com ([2002:a17:902:ed0c:b0:2ef:deb6:1cc5])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ec8a:b0:2e9:9b5b:e179
 with SMTP id d9443c01a7336-2eff7545dcdmr54697525ad.50.1795072617476; Wed, 18
 Nov 2026 23:16:57 -0800 (PST)
Date: Thu, 19 Nov 2026 07:15:58 +0000
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
Message-ID: <20261119071649.374106-7-kuniyu@google.com>
Subject: [PATCH v3 net-next 6/7] tcp: Batch memory accounting in tcp_collapse().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Once tcp_collapse_one() calls sock_rfree(), skb->truesize is
reclaimed to sk->sk_forward_alloc by sk_mem_uncharge().

However, sk_mem_uncharge() rounds down sk->sk_forward_alloc
immediately once it reaches 4K since commit 4890b686f408 ("net:
keep sk->sk_forward_alloc as small as possible").

This unnecessarily reclaims memory for newly allocated skbs,
and the following skb_set_owner_r() for them underflows
sk->sk_forward_alloc without sk_forced_mem_schedule().

Let's cache the delta during tcp_collapse() and batch accounting
at the end.

Then, we no longer need sk_forced_mem_schedule(), and instead
DEBUG_NET_WARN_ON_ONCE() is added to catch a future issue.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@kernel.org>
---
 net/ipv4/tcp_input.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 990e34896373..ec47c75f9598 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5836,6 +5836,24 @@ static bool tcp_collapse_skb_bloated(const struct sk_buff *skb,
 	return __tcp_win_from_space(scaling_ratio, skb->truesize) > unread;
 }
 
+static int tcp_collapse_uncharge(struct sk_buff *skb)
+{
+	DEBUG_NET_WARN_ON_ONCE(skb->destructor != sock_rfree);
+
+	skb->sk = NULL;
+	skb->destructor = NULL;
+
+	return skb->truesize;
+}
+
+static int tcp_collapse_charge(struct sk_buff *skb, struct sock *sk)
+{
+	skb->sk = sk;
+	skb->destructor = sock_rfree;
+
+	return -skb->truesize;
+}
+
 static struct sk_buff *tcp_collapse_one(struct sock *sk, struct sk_buff *skb,
 					struct sk_buff_head *list,
 					struct rb_root *root)
@@ -5871,6 +5889,7 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 	int remainder, nskbs;
 	struct sk_buff *nskb;
 	u8 scaling_ratio;
+	int released = 0;
 	u32 sub_end;
 
 	scaling_ratio = min(tcp_sk(sk)->scaling_ratio,
@@ -5888,6 +5907,7 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 
 		/* No new bits? It is possible on ofo queue. */
 		if (!before(start, TCP_SKB_CB(skb)->end_seq)) {
+			released += tcp_collapse_uncharge(skb);
 			skb = tcp_collapse_one(sk, skb, list, root);
 			goto restart;
 		}
@@ -5917,6 +5937,7 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 		bool overlap;
 
 		if (!after(TCP_SKB_CB(n)->end_seq, sub_end)) {
+			released += tcp_collapse_uncharge(n);
 			n = tcp_collapse_one(sk, n, list, root);
 			continue;
 		}
@@ -5983,11 +6004,8 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 			__skb_queue_before(list, skb, nskb);
 		else
 			__skb_queue_tail(&tmp, nskb); /* defer rbtree insertion */
-		/* nskb is charged before the skbs it replaces are freed.
-		 * Make sure sk->sk_forward_alloc can not become negative.
-		 */
-		sk_forced_mem_schedule(sk, nskb->truesize);
-		skb_set_owner_r(nskb, sk);
+
+		released += tcp_collapse_charge(nskb, sk);
 		mptcp_skb_ext_move(nskb, skb);
 
 		/* Copy data, releasing collapsed skbs. */
@@ -6011,6 +6029,7 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 				start += size;
 			}
 			if (!before(start, TCP_SKB_CB(skb)->end_seq)) {
+				released += tcp_collapse_uncharge(skb);
 				skb = tcp_collapse_one(sk, skb, list, root);
 			}
 		}
@@ -6026,6 +6045,12 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 		tcp_rbtree_insert(root, skb);
 
 	__skb_queue_purge_reason(&pool, SKB_CONSUMED);
+
+	if (released) {
+		DEBUG_NET_WARN_ON_ONCE(released < 0);
+		atomic_sub(released, &sk->sk_rmem_alloc);
+		sk_mem_uncharge(sk, released);
+	}
 }
 
 /* Collapse ofo queue. Algorithm: select contiguous sequence of skbs
-- 
2.56.1.708.g77570a6a1d-goog

