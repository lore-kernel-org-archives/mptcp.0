Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794957222;
	b=XncnanLp9MAtRLrgUm1BARit9AROqandehlZfaG8AcXvhEIdvPbj8fab6ig5ew6ZQ4ef
	 XrVSerN3ob51UEm+pxpprhmCHLJYx2DW7ZwYgVcmxg/f8fV1q495f+3CXSrjMNUEXpKZY
	 Axg2fKDwCCvPbbWnQdOGPjE2XfjWbrFBd7hRS5Enqg4qwxxPsAdgB5jMb7H1MT5VkT+wq
	 t9w3Cg087WvBySeInkD1O4ONaGDE+5nJWN1afl7lnSs1ljGg/x/o6oNd46f39xPDerH9H
	 0Plh7tvQaBbY3muc5n9bhfCqR4xXuygrA483PN4Xnf2oc1wkm/JsPTZ7/0dC3OfNq0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794957222;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=zJAS+r6ombv5JJef9g3H2kuyJN8JBc1VyyF6yLLl9hI=;
	b=WzRZp9duiwxQo8VL98ud+/YQmGP9oV5AfgBnDOckepisXKow43pyoV7+3ug58IIVCw3t
	 TcTI20GLvJCzufQ8jXV3drjMLG8b9iC4P7CqNXB9O1RRR6W3XyPoDGNwAquHft6zC79x2
	 E8Kjlxhf0sgisPRNtv3nCDT6iaahQryKgoga9IgWk51A4fb6IlX/8UmPqbrEksZ/gLrBY
	 9BLR/QOrlmW7YPm3C+o1nKQe8Nvl59MWpAV5jECnGnvoYxP0ZDmwbP4tE1XMKn2Ne2cRQ
	 2mDTqEXV79UPCHzjTp49r/P6ZtOXoX/doBidFWS6JE2qEGlImSDWnQIYKvtBY59pn3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GgstLJbI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D367606A885;
	Tue, 17 Nov 2026 23:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GgstLJbI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A3C1F000C5;
	Tue, 17 Nov 2026 23:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794957221;
	bh=zJAS+r6ombv5JJef9g3H2kuyJN8JBc1VyyF6yLLl9hI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GgstLJbIQTcmncePrFHBxW51SulbU9RY4jUxpbMSQP/V/Pa9m55koEVHZe/7r55YB
	 piVZ5PWatVP4elIpuzyUc81/phc4z4xS8iXYB9PHqBnx3b0LSa+giOrbUy0SO0kOXT
	 fR7zsiP/RYDYR6kE64mXNNUR1ReKcWigFBmjvBANDjnxICWnMVoszqOmTaIZDEhlW1
	 7nc1wLQYyv48alcwKSGHWwwR7xeVkqx5aVCqRSr9y2rsWld2S/qqzwBHCQG1JjI6Kq
	 o+/AZ5TgPNtOBd+1r/0ojEyOmHyoM5LjH1ZdQ7HiiTnQArGiaID/BkNZNEfdijxlhF
	 bKLkjiIGwNrXw==
Subject: Re: [PATCH v2 net-next 4/7] tcp: Skip collapsing if collapsed skb is
 less-dense.
From: netdev-bot+sashiko@kernel.org
To: kuniyu@google.com
Cc: edumazet@kernel.org, ncardwell@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, matttbe@kernel.org, martineau@kernel.org,
 horms@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org,
 mptcp@lists.linux.dev
Date: Tue, 17 Nov 2026 23:13:40 +0000
Message-ID: <179495722091.3136.1223304567026487070@kernel.org>
In-Reply-To: <20261116230555.2305867-5-kuniyu@google.com>
References: <20261116230555.2305867-5-kuniyu@google.com>
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

- [Medium] tcp: rbtree order corruption in tcp_collapse() on skipped
  overlapping skb
- [Low] kmalloc_reserve() in net/core/skbuff.c now rounds the skb head
  size up twice.
- [Low] The concern says the local `nskbs` in tcp_collapse()
  (net/ipv4/tcp_input.c) is set but never read in this patch, and that…

--

tcp: Skip collapsing if collapsed skb is less-dense.

This patch makes tcp_collapse() estimate the truesize of the collapsed
skbs before allocating them. If the result would not be smaller than the
original skbs, the range is skipped. To support this, the head size
calculation in kmalloc_reserve() is moved into a new kmalloc_reserve_size()
helper, and compute_skb_truesize() is added.

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 2e81aacc998b6..a89eaadc729f4 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -589,6 +589,17 @@ struct sk_buff *napi_build_skb(void *data, unsigned int frag_size)
>  }
>  EXPORT_SYMBOL(napi_build_skb);
>  
> +static __always_inline size_t kmalloc_reserve_size(unsigned int size, gfp_t flags)
> +{
> +	size_t obj_size = SKB_HEAD_ALIGN(size);
> +
> +	if (obj_size <= SKB_SMALL_HEAD_CACHE_SIZE &&
> +	    !(flags & KMALLOC_NOT_NORMAL_BITS))
> +		return 0;
> +
> +	return kmalloc_size_roundup(obj_size);
> +}
> +

[ ... ]

> @@ -612,9 +623,8 @@ static void *kmalloc_reserve(unsigned int *size, gfp_t flags, int node,
>  	size_t obj_size;
>  	void *obj;
>  
> -	obj_size = SKB_HEAD_ALIGN(*size);
> -	if (obj_size <= SKB_SMALL_HEAD_CACHE_SIZE &&
> -	    !(flags & KMALLOC_NOT_NORMAL_BITS)) {
> +	obj_size = kmalloc_reserve_size(*size, flags);
> +	if (!obj_size) {
>  		obj = kmem_cache_alloc_node(net_hotdata.skb_small_head_cache,
>  				flags | __GFP_NOMEMALLOC | __GFP_NOWARN,
>  				node);

[Severity: Low]
Does kmalloc_reserve() still need its own kmalloc_size_roundup() call?
kmalloc_reserve_size() already returns the rounded-up size. The unchanged
code after the small head branch rounds it a second time:

net/core/skbuff.c:kmalloc_reserve() {
    ...
	obj_size = kmalloc_size_roundup(obj_size);
	/* The following cast might truncate high-order bits of obj_size, this
	 * is harmless because kmalloc(obj_size >= 2^32) will fail anyway.
	 */
	*size = (unsigned int)obj_size;
    ...
}

The result is the same because the roundup is idempotent. However,
kmalloc_size_roundup() is an out-of-line function in mm/slab_common.c.
So every alloc_skb() head larger than SKB_SMALL_HEAD_CACHE_SIZE now does
the slab lookup twice.

That doesn't seem to match this part of the commit message:

    Note that kmalloc_reserve_size() uses __always_inline so that
    this change does not affect non-FDO builds, ...

Could the leftover obj_size = kmalloc_size_roundup(obj_size) line in
kmalloc_reserve() be removed? The duplicate call is still there at the
end of the series.

> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index d2d4796984f39..92a4c978f9309 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c

[ ... ]

> @@ -5908,6 +5913,23 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
>  			break;
>  
>  		sub_end = TCP_SKB_CB(n)->end_seq;
> +		old_truesize += n->truesize;
> +	}
> +
> +	/* Third, check if the new skbs have high density. */
> +	nskbs = (sub_end - start) / TCP_COLLAPSE_MAX_SIZE;
> +	new_truesize = nskbs * SKB_TRUESIZE(TCP_COLLAPSE_MAX_SIZE);
> +
> +	remainder = (sub_end - start) % TCP_COLLAPSE_MAX_SIZE;
> +	if (remainder) {
> +		nskbs++;

[Severity: Medium]
Can this skip leave the out_of_order_queue rbtree out of order?

On the ofo path (list == NULL), new nskbs are only queued on tmp and
inserted into root at the end label. The second loop can also stop at
an n that overlaps the current range, because tcp_skb_can_collapse_rx()
is checked before the monotonic seq check. Examples are MPTCP skbs
with different mappings, or skbs with different decrypted bits.

Say the ofo queue has skb_1 [1000, 5000) and an overlapping skb_2
[4500, 5100), and tcp_skb_can_collapse_rx(skb_1, skb_2) is false.
skb_1 is collapsed into nskbs on tmp, the last one covering
[4776, 5000). We then restart at skb_2 with start = 5000.

skb_2 is bloated for its 100 unread bytes. Before this patch it was
collapsed into a new [5000, 5100) skb and erased from root. Now
compute_skb_truesize(100, GFP_ATOMIC) returns the small head
truesize, which equals skb_2->truesize. So the range is skipped and
skb_2 stays in root with seq 4500.

At the end label, tcp_rbtree_insert() orders by seq only. The
[4776, 5000) nskb is placed to the right of skb_2 [4500, 5100), so
end_seq is no longer monotonic.

tcp_collapse_ofo_queue() then sets tp->ooo_last_skb to that nskb
(end_seq 5000) instead of skb_2. As a result, tcp_data_queue_ofo()
takes the fast path for segments in [5000, 5100) without checking the
overlap with skb_2. tcp_ofo_queue() later drops the nskb once skb_2
advances rcv_nxt.

A remote peer can trigger this with overlapping out-of-order
segments while the socket is under receive memory pressure.

Should the skip be avoided on the rbtree when the skb starts before
start, i.e. it overlaps data already collapsed into tmp? Or is there
a better way to keep the ordering intact in that case?

[Severity: Low]
This isn't a bug, but nothing reads nskbs after this nskbs++ in
tcp_collapse(), so the increment is a dead store in this patch. nskbs is
read earlier to compute new_truesize, so the compiler does not warn.

The next patch in the series ("tcp: Allocate all new skb before
collapsing.") reads the incremented value in its pre-allocation loop, so
the series resolves this. Would it be cleaner to add the increment in
that patch instead?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261116230555.2305867-1-kuniyu%40google.com
