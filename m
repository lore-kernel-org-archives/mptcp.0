Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794870359;
	b=32dC8/bKKHK7iYPbJRnS7MtvgFn2ZsQwOu0NdaMx7YEjpM/tTtQe8I5ngb2tt48r3L9g
	 T+IgffEAscbuU9cELjTEcHDO2OK5SJLI6+aTIBpIKI7g5SdZKBjRro/xpe/Ix4GIM6Oze
	 hbUsKuTufRo1F3zM48lPJIIQWes/ihz+CAvvw6mdfEWOL1mcP+rhj49aitVgtxbbqSKNE
	 wk99p14A40FlGenAeNosN2SXm86XvJDcFzH+x6OGomxJQj3jSp3GH46wVLvhGs5S935DC
	 RKwU218laHkhUoATTbFY20r9ldkZF9j+Bp0Xl9pogTyGidC0qhC/a9uEoBv7UjK2J5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794870359;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=kEaEXO/J1xQxeEQZwu8ZzIT12eLGw74qjW2MKVja9P0=;
	b=qe8lH16lN2pglA2l+I2n1oqUg4+WHRSLBH8poxs6Or2CTFaQJ84qQ3QKc3Wktcc3XU1G
	 KcaF1gAWPYffVDYDdj87/9iFCbn2wUAR6awWo8gV0se63Nk1wfeAoR+H4yWAzLNaMqV45
	 nq+HbjbEeCZQY4cinmmWE/pr4YLoSYh8duOrKj7foQs7NVanCtvwD/pjsNmiJneoL63Dy
	 c4g/1KDfkOb9Q5m+t5mC6tDzTCOYaGf4n9wZIoMFoLVekboOkFdAuK5DyWR1Zt5vdh94A
	 zrc0VwEBMrWaX2ZQGyLKwk6fhO9+mB8y44Z3gxlmelzbyOoDKFJ0rL8x/6ZaFbTc1YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WoRpsLgp;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8688E606A331
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 23:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8688E606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WoRpsLgp
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e95f8543c9so56946825ad.3
        for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 15:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794870359; x=1795475159; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kEaEXO/J1xQxeEQZwu8ZzIT12eLGw74qjW2MKVja9P0=;
        b=WoRpsLgpCij5w5RJXdFcPVD0HLGr+ZIv3s5GlqA26u5L0fM2EAtBTj6PgjcMiqJcg/
         lojanHiyHuYXUEry0Xn+1g2ZRB1iQTWzIBERBZdCxELvThZvbOrztsrVxskA0xNSoCqy
         T7yHU+/PU9sWtIQa1G/+PMZcvKkjuUJjfDJGEE7XiRMT2heiG7iiHXNn3iNVPC8NmP2o
         X655ER2GbPfWp2GSZSGQ1st4vHE2Ld3DsKVYgK1uQGg8Nw4JDBLwC2OZlansuP8qSDuz
         CKJA4pyKwTs6F9T7mSLjpy2KbN6rxMXzU10tgK2sygcTsKfqfqMcZs1bg8KOHHzA04db
         ejpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794870359; x=1795475159;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kEaEXO/J1xQxeEQZwu8ZzIT12eLGw74qjW2MKVja9P0=;
        b=thL7BrY0ZkCvBltCS7DwckUyTfF/wyLPK0NLRH1qkAbIejIjNjRMI/wtTG/1mJxlsD
         bv3+RMGwSTnKgtMvWgRB3xtsEcZ5Lhli/JixTu7OaqJ5bss05FqOc09t8hXXT8h6fe0i
         Y4+5citjqlpMhEqRS2Gql2Pk/vMQBRONEu7Ip1F6LtIxr+0IKMLKdpoa1YQBcdYdWgF8
         p/34AknGqL3jEtYYCuGBRowEWUNsG5OXv+d0pYC/TCj0xeUG+NWpU7B1wGAEImDcySsS
         vUVjF32JAPg4wOvv4OoKm1gGA2UnQr4Ef8AzSxVvvDhwWSFLpufyZAsMnt7lR8c9PFeC
         xARA==
X-Forwarded-Encrypted: i=1; AL+hErEkuvDp7DH54rogKWhAujMC/PbuftBoTzTFos/eDKsINSG7e78SVJndFIXVzJhLuj8DRxqhhg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/0il++c8reiBUNk/uSPXyN4xGVZeMg2RatvTX2XO0UT600pjt9
	Ti4Hz9Ox004bsE3NINFXcp2pBbSwrP58QqhtQk7tjPj6CPYLX4+sFEIKN0Z5cy4nnwS1gTE7+q5
	uOJduJQ==
X-Received: from plpw11.prod.google.com ([2002:a17:902:9a8b:b0:2e8:bfd5:b889])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fc47:b0:2ed:3eeb:b0db
 with SMTP id d9443c01a7336-2ee0de10ab1mr113092835ad.17.1794870358515; Mon, 16
 Nov 2026 15:05:58 -0800 (PST)
Date: Mon, 16 Nov 2026 23:05:25 +0000
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
Message-ID: <20261116230555.2305867-2-kuniyu@google.com>
Subject: [PATCH v2 net-next 1/7] tcp: Refactor the first loop in tcp_collapse().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

tcp_collapse() detects skb to start collapsing from in the
first loop.

If the last skb has SYN or FIN, the condition is tested
again after the loop.

skb_frags_readable() is placed inside and outside of the
loop as well.

If we goto skip_this in both cases, we can remove the second
tests and simply replace end_of_skbs with the inverted loop
condition.

Then, we do not need a test for tcp_collapse_one() too.

Also, skb_frags_readable() should be tested after the fully
overlapping check.

Let's refactor the loop.

Note that previously, when a SYN/FIN skb overlapped with the next
skb, the loop broke with end_of_skbs set to false and the check
after the loop returned without collapsing anything further.
Now such a skb is skipped instead, allowing the following skbs to
be collapsed.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@kernel.org>
---
v2: Document SYN/FIN behaviour change
---
 net/ipv4/tcp_input.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index a2074a1af422..32e63d089db8 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5839,23 +5839,17 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 {
 	struct sk_buff *skb = head, *n;
 	struct sk_buff_head tmp;
-	bool end_of_skbs;
 
 	/* First, check that queue is collapsible and find
 	 * the point where collapsing can be useful.
 	 */
 restart:
-	for (end_of_skbs = true; skb != NULL && skb != tail; skb = n) {
+	for (; skb && skb != tail; skb = n) {
 		n = tcp_skb_next(skb, list);
 
-		if (!skb_frags_readable(skb))
-			goto skip_this;
-
 		/* No new bits? It is possible on ofo queue. */
 		if (!before(start, TCP_SKB_CB(skb)->end_seq)) {
 			skb = tcp_collapse_one(sk, skb, list, root);
-			if (!skb)
-				break;
 			goto restart;
 		}
 
@@ -5864,27 +5858,25 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 		 * - bloated or contains data before "start" or
 		 *   overlaps to the next one and mptcp allow collapsing.
 		 */
-		if (!(TCP_SKB_CB(skb)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN)) &&
-		    (tcp_win_from_space(sk, skb->truesize) > skb->len ||
-		     before(TCP_SKB_CB(skb)->seq, start))) {
-			end_of_skbs = false;
+		if (!skb_frags_readable(skb) ||
+		    TCP_SKB_CB(skb)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN))
+			goto skip_this;
+
+		if (tcp_win_from_space(sk, skb->truesize) > skb->len ||
+		    before(TCP_SKB_CB(skb)->seq, start))
 			break;
-		}
 
 		if (n && n != tail && skb_frags_readable(n) &&
 		    tcp_skb_can_collapse_rx(skb, n) &&
-		    TCP_SKB_CB(skb)->end_seq != TCP_SKB_CB(n)->seq) {
-			end_of_skbs = false;
+		    TCP_SKB_CB(skb)->end_seq != TCP_SKB_CB(n)->seq)
 			break;
-		}
 
 skip_this:
 		/* Decided to skip this, advance start seq. */
 		start = TCP_SKB_CB(skb)->end_seq;
 	}
-	if (end_of_skbs ||
-	    (TCP_SKB_CB(skb)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN)) ||
-	    !skb_frags_readable(skb))
+
+	if (!skb || skb == tail)
 		return;
 
 	__skb_queue_head_init(&tmp);
-- 
2.56.0.679.gc527c65306-goog

