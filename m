Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795072615;
	b=tw6rSwpf+OsM3rtYD/evzEs0tZS/CrKl8Gxa4nPXH4VQHbOo6bHnoFOZX10Akhdv/Ycs
	 oGmDU8v3gRaeNsx8jktnsImnqF4xxkohHo5lgiW3RLUfbjJT3l6gKEcQ5qzXaO/aWZlsL
	 2VksE255ajxWc2RBzWHAIAGK7mn8D6tjDJ9STCYPzdKBtvOAl9o7fC00bSnWDK5Mrsp+V
	 Zr7VZegp/XkJRsNqTOeAuhDe1uEvMrBTsVJRjGkRJJdiRdzS+LIfwQhPmcmWPqlrCdzwF
	 u2G4DtKzKs0gPJQif/VQSN2UGmpr6fGW+4v70EjaeNkEb23fwzfNb7uxssyi7fhbPpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795072615;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=XH0KR5U668j8GkdNpv7amJfmOVvHsijvl9Q4WNbhGpI=;
	b=uEk0AFpigpNRKkgCuuc7pwt10rFdsY57hTNuOSmJhLMVuf6jF5uofwkZgQXvgfrYPAlW
	 KnRblhffQdy2Pynemy5XFiOpCrzs3AoHcUo+75czRA0l6KRU6hf0zD2KhE4g76t+5FqVZ
	 qguOS+FeYs9q4S2A55l68g1yJq5YpEAjoO12xGWpXdihYhiXwOwQE4AtVuv4cNiQ0d9iM
	 WBgeLKoIL/Jr+X3gn3PUV7a8kWNYQTF4TB0+lRjEazeJNStSRdUv4UV7taTAeE8r3MW0P
	 PyXnFi6rxwFakU7zyLeU3s16zoi2jVz6CqthOQJMJ+qu2YDCLMl7oF0en4sLvXsY0wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eI8QiNuJ;
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A6C606A320
	for <mptcp@lists.linux.dev>; Thu, 19 Nov 2026 07:16:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67A6C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eI8QiNuJ
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2efdd509c6bso24364915ad.0
        for <mptcp@lists.linux.dev>; Wed, 18 Nov 2026 23:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795072614; x=1795677414; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XH0KR5U668j8GkdNpv7amJfmOVvHsijvl9Q4WNbhGpI=;
        b=eI8QiNuJ+KoiyOml0qgYvzR7ZNhwIQgKAMGgxhuH3/eE+sTApPdDFY0VlnV5//4WA+
         XVU0HguLWmOokgLjYbV5bdgQSzANmctTUrIvC1mG/5cggBcoZUcagqGXAvFdxyffIimE
         M4H6ugrSsPgLLCp9Y0VmfMlubRawnIvrej+ns/Eaxowf4GZE/mGmDD9RzZ7xWk+uYi7g
         ekWGDnu3S64yrimL6XwcaiaOyRuJl4+lmFOhuN9Sm6qqakxmL5hApbln3ZShGZn80qOM
         jd5/Jmr1Xm6mFQ5yar5fI60MrjqO+jLhSBLVzXIhVBdnnIQ6mgUA5aRq25zsfDll/4b8
         dg3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795072614; x=1795677414;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XH0KR5U668j8GkdNpv7amJfmOVvHsijvl9Q4WNbhGpI=;
        b=hicvNhQBr1mzShNO74owtpB0SSITJOQgclH+kSw8fs2qU1ufpWkKF7pKI7mtynefPb
         pE5FvVaWfzdg+30wnm/XaBKG248cwNlA4Uw7ob0mt2ZcKbrHB7Bk0tvJJwCyhtcMjAYY
         NeWbnFWLy0zBa41tW1RjN8pOeVnx26yUBsQH65BDZBrfOmNVjiN166r+LEqqZNkH6q0h
         cwElcno+OCmooMUamgG199f0hR1593vEAuqpAXoOwBs7wYuGRogijc90aSJXo0+zvWlp
         9d3TTlA8xL1ci7lVIDTCxfw6YMVjJNooVhHuR6Cp26mRGBqA+nbSYLG13zHsJOjkLWPt
         NCgg==
X-Forwarded-Encrypted: i=1; AL+hErEcABA8od2MF3yBotneoNkP9h2qfP9HxQQSEY0BO7KoD8IooAzaXSD2+80LjCmXZw8AjYGTtA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/vWCST6r+ODasIqinWBPKkrz8pcK1pe4rB/x9SNUp159ZCQEwp
	pyZ/e10GIgVtzveWo1LyefWpRwmcawM9XPd24RdD+3ZJ/sMgHGZXQAxWrUO5sBLHwx4+6mh1j7K
	csENVzA==
X-Received: from plbjb7.prod.google.com ([2002:a17:903:2587:b0:2e1:2a71:d15b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:90f:b0:2e9:8202:509c
 with SMTP id d9443c01a7336-2eff70fd303mr54789045ad.7.1795072613602; Wed, 18
 Nov 2026 23:16:53 -0800 (PST)
Date: Thu, 19 Nov 2026 07:15:53 +0000
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
Message-ID: <20261119071649.374106-2-kuniyu@google.com>
Subject: [PATCH v3 net-next 1/7] tcp: Refactor the first loop in tcp_collapse().
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
index d35048c363be..838d4f470c94 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5849,23 +5849,17 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
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
 
@@ -5874,27 +5868,25 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
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
2.56.1.708.g77570a6a1d-goog

