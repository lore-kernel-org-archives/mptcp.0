Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794957223;
	b=N1NYUuf0nJ2i2oghMe+nHG8Quz4eATYnlmuUaOSBRQ1h8mZ9fuIGTnS4oPAulvEY1PgA
	 pl1yBLefD/Bh4wkvJ+cYhLAwXdVGrpZBssJgeG8oD5IICXdIMzCTZlcngv2y+bBWZwDmf
	 MB5dvmIxtkXPr0+nibKkpxnJGSjUTKLjVoKtQqMbNUTH9dWRrpE6QIcjnjMT8Ctw1FG6J
	 x3efM2y+EiGDndZWqPcMp0NXfoiouHanb4MC15mxvO03t8uwIgt/B+9e9f3vH85B6f0rF
	 ILsBPGKvNDo5VAhwYOk/s08rXv922PbxZP57nj7u610AwpOxVzMfMKUITZJw3XxjZwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794957223;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=YwZwj/n+VRmpfJQeULH3OEv0yOcIiFih9ma9S3v9x38=;
	b=KQ1IPyUtjiu4r0NccBcSuiZYLtqckXEZtcivnDju47FBWX1FkxwRHkl0hd+40hKy4Uox
	 b+drZKsHEKhYDYuw1Vl+oMiIORiK+cbvVXdvVTKDLxPhaB+NamTXKxNPq4nA6cvEo3jB9
	 EsPnDpC41ssmHv/X7OQewHCMZthS5SCmT9QBBR80TI70rcLeRFhTeJdfjluxQljTtPDLx
	 mnhsocsrAxv8IxNY9S6J4Dq2RbDj0BdxhfDdvgHz+ytV+lCFAnfImcVxirZdtoaqdjOEn
	 UpptLXksJ+sBW5ARwwGMg0z0c5AM5UEZA+waqVV0mH2ThrAf3D/Wk8agF4J4IIEe7wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eOaISg0c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F394606A88F;
	Tue, 17 Nov 2026 23:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eOaISg0c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B291F000C6;
	Tue, 17 Nov 2026 23:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794957223;
	bh=YwZwj/n+VRmpfJQeULH3OEv0yOcIiFih9ma9S3v9x38=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eOaISg0c0/dYK6zLv8uIKRbPxSp+VedmmKsJr3YDaSIytyiwuIm7ep+G5NFpXJ919
	 GchS4PjNp7r+kSvGWw/JnuYL2sbcqKcYIduJ/sSTqImPMiBvgcSyfYF5i85LNbiJ+4
	 hRoRVT7UfUgBrm+qjPZfAmrYnaV7KLFR0XG7Xx6qodj7lJdfP0mGId45Fj1hcPSKoE
	 rmcYygCXyy8Snuj9qp4anRQW/zgqn5cfAE112HJPcWkVosH4TlzG4tLsGFBkEWg4tI
	 OyS/erK640CMdu4VJbp7WbxiqwyXvD8it4r3HRHOFKOMPl4lJQe6b/6AMC346vAg4/
	 I//LKfCmNj2mw==
Subject:
 Re: [PATCH v2 net-next 5/7] tcp: Allocate all new skb before collapsing.
From: netdev-bot+sashiko@kernel.org
To: kuniyu@google.com
Cc: edumazet@kernel.org, ncardwell@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, matttbe@kernel.org, martineau@kernel.org,
 horms@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org,
 mptcp@lists.linux.dev
Date: Tue, 17 Nov 2026 23:13:42 +0000
Message-ID: <179495722211.3136.15241045445062201797@kernel.org>
In-Reply-To: <20261116230555.2305867-6-kuniyu@google.com>
References: <20261116230555.2305867-6-kuniyu@google.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This patch makes tcp_collapse() (net/ipv4/tcp_input.c)
  allocate every replacement skb for a section up front with GFP_ATOMIC,…
- [Low] The commit message says the old alloc_skb() failure path only
  left duplicate skbs that waste memory.
- [Low] In tcp_collapse() (net/ipv4/tcp_input.c), this patch adds a
  second job to the second-loop break condition: stop once…

--

tcp: Allocate all new skb before collapsing.

This commit makes tcp_collapse() allocate every replacement skb for a
section into a temporary pool before it copies any data. An alloc_skb()
failure then no longer leaves partially copied originals and duplicate
new skbs behind. Sections are capped at TCP_COLLAPSE_MAX_TOTAL_SIZE (16
skbs), except for a single bloated skb or overlapping ofo skbs.

> If alloc_skb() fails while splitting a large bloated skb across
> multiple new skbs, the partially-copied skb is not removed and
> new skbs remain in the queue as duplicates, consuming more memory.

[Severity: Low]

The code change looks right. For the ofo rbtree case, though, is this
description of the old failure path complete?

In the old code, a failed alloc_skb() jumped to end:. That path inserted
every deferred nskb from tmp with tcp_rbtree_insert() while the partially
copied original was still in the tree. tcp_rbtree_insert() sends equal
seq to the right:

	if (before(TCP_SKB_CB(skb)->seq, TCP_SKB_CB(skb1)->seq))
		p = &parent->rb_left;
	else
		p = &parent->rb_right;

So the first nskb sorts after the original even though its end_seq is
smaller. Its seq is equal to or after the original's seq.

If this happens at the tail of the ofo queue, tcp_collapse_ofo_queue()
sets tp->ooo_last_skb = skb_rb_last(). That points at an skb whose
end_seq is below data already queued, which breaks the assumption behind
the tcp_data_queue_ofo() fast path:

	if (!before(seq, TCP_SKB_CB(tp->ooo_last_skb)->end_seq)) {

This patch fixes that as well, because no partial copy is left behind.
Could the commit message mention the restored ordering invariant, so
stable backporters can see it?

> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 92a4c978f9309..afc3c69eba781 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -5812,6 +5812,7 @@ static struct sk_buff *tcp_skb_next(struct sk_buff *skb, struct sk_buff_head *li
>  #define TCP_COLLAPSE_SCALING_RATIO				\
>  	((TCP_COLLAPSE_MAX_SIZE << TCP_RMEM_TO_WIN_SCALE) /	\
>  	 (SKB_TRUESIZE(TCP_COLLAPSE_MAX_SIZE)))
> +#define TCP_COLLAPSE_MAX_TOTAL_SIZE (TCP_COLLAPSE_MAX_SIZE * 16)

[Severity: Low]

This isn't a bug, but would a short comment help here? Neither this macro
nor the break condition in tcp_collapse() says that the cap:

  - bounds the all-or-nothing preallocation into pool,
  - is measured in sequence space from start, and
  - is skipped for the first skb and for overlapping ofo skbs.

The only comment above the condition is still:

	/* seq and end_seq must increase monotonically for rbtree. */

and it only covers the overlap exemption.

[ ... ]

> @@ -5908,8 +5911,9 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
>  
>  		/* seq and end_seq must increase monotonically for rbtree. */
>  		if ((list || !before(TCP_SKB_CB(n)->seq, sub_end)) &&
> -		    !tcp_collapse_skb_bloated(n, sub_end,
> -					      TCP_COLLAPSE_SCALING_RATIO))
> +		    (TCP_SKB_CB(n)->end_seq - start >= TCP_COLLAPSE_MAX_TOTAL_SIZE ||
> +		     !tcp_collapse_skb_bloated(n, sub_end,
> +					       TCP_COLLAPSE_SCALING_RATIO)))
>  			break;
>  
>  		sub_end = TCP_SKB_CB(n)->end_seq;

[ ... ]

> @@ -5932,14 +5938,19 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
>  		goto restart;
>  	}
>  
> -	while (before(start, sub_end)) {
> -		int copy = min_t(int, TCP_COLLAPSE_MAX_SIZE, sub_end - start);
> -		struct sk_buff *nskb;
> -
> -		nskb = alloc_skb(copy, GFP_ATOMIC);
> +	while (nskbs--) {
> +		nskb = alloc_skb(nskbs ? TCP_COLLAPSE_MAX_SIZE : remainder,
> +				 GFP_ATOMIC);
>  		if (!nskb)
>  			goto end;
>  
> +		__skb_queue_tail(&pool, nskb);
> +	}

[Severity: Medium]

Can the batch allocated here grow far beyond TCP_COLLAPSE_MAX_TOTAL_SIZE
for the ofo rbtree?

When list is NULL and n overlaps the current section,
before(TCP_SKB_CB(n)->seq, sub_end) is true. The whole break condition in
the second loop is then false. Neither the new cap nor the bloat test
runs, and n is always added to the section.

The overlap chain appears to be under the remote peer's control.
tcp_data_queue_ofo() keeps partially overlapping segments:

	if (after(seq, TCP_SKB_CB(skb1)->seq)) {
		/* Partial overlap. */
		tcp_dsack_set(sk, seq, TCP_SKB_CB(skb1)->end_seq);

tcp_try_coalesce() refuses them because from->seq != to->end_seq.
tcp_collapse_ofo_queue() only ends a range at a gap:

	if (!skb ||
	    after(TCP_SKB_CB(skb)->seq, end) ||
	    before(TCP_SKB_CB(skb)->end_seq, start)) {

A sender could send a long chain of small ofo segments, each overlapping
the previous one by one byte. That gives one tcp_collapse() section
covering the whole ofo queue. Small segments count as bloated, so they
also pass the density check.

This loop would then allocate about (sub_end - start) /
TCP_COLLAPSE_MAX_SIZE GFP_ATOMIC skbs at once. Every original skb is
still queued at that point. The pool is not charged to sk_rmem_alloc
until each nskb is dequeued. That stays true after the later patch
"tcp: Batch memory accounting in tcp_collapse()".

Before this patch, originals were freed as they were consumed, so the
extra memory at peak was about one new skb. Now the peak per socket is
close to old_truesize + new_truesize, limited only by sk_rcvbuf. Is that
intended?

There is also the failure case. One alloc_skb() failure discards the
whole batch. Under memory pressure, could a queue shaped this way never
make collapse progress?

The commit message says the cap bounds the temporary allocation and
treats overlapping OOO skbs as an exception. That exception seems to be
fully under the remote sender's control. The preallocation loop is also
unchanged at the end of the series.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261116230555.2305867-1-kuniyu%40google.com
