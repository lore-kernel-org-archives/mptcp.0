Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794956769;
	b=RsWItF71xASxmNlqzpK6rJdkTemAA4mV+SHDCZWcQ7GufUV++rBkOcdAHrFfFbPu+x94
	 T4eAzH7/sljAhYHzlau7A6GpUhHbwmfspFyzNNf9Xi6tBwV7YHBAQmFIcTFLw+YPO1a9N
	 TYurQKiZczTm8t61e3k+oi8rulBdvHLMe7+lGgrg6xE8U98VNLnv6VhMy2yR2ty7w5ukc
	 u9FrWHjKdUUMDmj3x39+BpRSWvBrWOOwk1UicehjnyBhj9lgn3tqb7L0Huel92u/e1esP
	 h8ytUAvNj4U1T8rWYU1iH7oT3wguYI2HihWYdFREDS1NuZRjlE4smZ8ChmFCJuf9Yjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794956769;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=//PW0mpKyCCOdoH6HthtDBvVEPKcI7ucPO1id3K745Y=;
	b=Q/35lUuV1TPhnXSTFCMV3I2iqGeXxecd5NR+MqXu5MhnTXwI0nKukRMVOFb+UgWa3v0b
	 L6q3b+QdJKYAopLcLNQgo6fKTaEx7JeMpDrpLtXuXfpp1oPmJETrTIAoChxeDAjSatGj7
	 aWqF2eC8rggfX3zSXSBRMdeKTm+bT5dHTNwMTUcDdRzRITXzZ4H15DySz7wWVj5ItV+3D
	 9T3f0JDFeFp9e3IY/N2NDvhYUC230gASYpp87rck74nbQt3NOkO0TagxuI/FHvPoBIUf9
	 fuiBtMNXCUfDqpfy+k+QoErPAEgOIN9+e+YRDDjzqAodDXD9/HmTwJp2RGnjbs7MUCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QkOY1Nvf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19418606A31C
	for <mptcp@lists.linux.dev>; Tue, 17 Nov 2026 23:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QkOY1Nvf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C677A1F000C4;
	Tue, 17 Nov 2026 23:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794956768;
	bh=//PW0mpKyCCOdoH6HthtDBvVEPKcI7ucPO1id3K745Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QkOY1NvfipYeFBQOSQqh6kRy9HRuQG467dfgV2Y9DNwAuNNfs6uZ1tyx5Qd1A280Z
	 TDku6/iDlult4tk6iZGfMcI3PNAvs3J6tqN1t3zeb/3y+dPFzpc82DqLTjY9HOc4E8
	 ovYm4JXGX2w/mlh0LQGi4e/hPput70LzcdFAFWPY3RQPxMJLHN0JmZ0G1OJFUlI4cr
	 U4rDWfLDfBYsGEs8Y7Yd3f1/UgJWSRZJcfied0BDwMRHKulfA/Eea8eNLNjiJr3yZ1
	 A8dizNlf740wna2KsCB7hGsPBoIslis5qaZOA5+3gKY7corBFkb1Lw6XogE3lMC1VI
	 Fbhog0HeScb8w==
Message-ID: <sashiko-outbox-219780@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 net-next 4/7] tcp: Skip collapsing if collapsed skb
 is less-dense.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuniyuki Iwashima" <kuniyu@google.com>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20261116230555.2305867-5-kuniyu@google.com>
References: <20261116230555.2305867-1-kuniyu@google.com>
 <20261116230555.2305867-5-kuniyu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 23:06:08 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] tcp: rbtree order corruption in tcp_collapse() on skipped
  overlapping skb
- [Low] net: skbuff: duplicate kmalloc_size_roundup() call in
  kmalloc_reserve()
--

commit a3eb35002975ecc31de00e85abdd6d7c9480540e
Author: Kuniyuki Iwashima <kuniyu@google.com>

tcp: Skip collapsing if collapsed skb is less-dense.

This commit introduces compute_skb_truesize() and uses it in tcp_collapse()
to skip collapsing a range of SKBs when the resulting truesize would not
decrease.

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 2e81aacc998b6..a89eaadc729f4 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -589,6 +589,17 @@ struct sk_buff *napi_build_skb(void *data, unsigned =
int frag_size)
>  }
>  EXPORT_SYMBOL(napi_build_skb);
> =20
> +static __always_inline size_t kmalloc_reserve_size(unsigned int size, gf=
p_t flags)
> +{
> +	size_t obj_size =3D SKB_HEAD_ALIGN(size);
> +
> +	if (obj_size <=3D SKB_SMALL_HEAD_CACHE_SIZE &&
> +	    !(flags & KMALLOC_NOT_NORMAL_BITS))
> +		return 0;
> +
> +	return kmalloc_size_roundup(obj_size);
> +}
> +
>  static void *kmalloc_pfmemalloc(size_t obj_size, gfp_t flags, int node)
>  {
>  	if (!gfp_pfmemalloc_allowed(flags))
> @@ -612,9 +623,8 @@ static void *kmalloc_reserve(unsigned int *size, gfp_=
t flags, int node,
>  	size_t obj_size;
>  	void *obj;
> =20
> -	obj_size =3D SKB_HEAD_ALIGN(*size);
> -	if (obj_size <=3D SKB_SMALL_HEAD_CACHE_SIZE &&
> -	    !(flags & KMALLOC_NOT_NORMAL_BITS)) {
> +	obj_size =3D kmalloc_reserve_size(*size, flags);
> +	if (!obj_size) {
>  		obj =3D kmem_cache_alloc_node(net_hotdata.skb_small_head_cache,
>  				flags | __GFP_NOMEMALLOC | __GFP_NOWARN,
>  				node);

[Severity: Low]
Does kmalloc_reserve() now call kmalloc_size_roundup() twice for allocations
that do not use skb_small_head_cache?

kmalloc_reserve_size() already returns kmalloc_size_roundup(obj_size), but
kmalloc_reserve() still calls kmalloc_size_roundup(obj_size) again right
after the if (!obj_size) block.  Since kmalloc_size_roundup() is an
out-of-line function in mm/slab_common.c without const or pure attributes,
non-small SKB allocations make a redundant call on the hotpath.

[ ... ]

> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 5bd42a74c6f58..0815e1891fba0 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c

[ ... ]

> @@ -5908,6 +5913,23 @@ tcp_collapse(struct sock *sk, struct sk_buff_head =
*list, struct rb_root *root,
>  			break;
> =20
>  		sub_end =3D TCP_SKB_CB(n)->end_seq;
> +		old_truesize +=3D n->truesize;
> +	}
> +
> +	/* Third, check if the new skbs have high density. */
> +	nskbs =3D (sub_end - start) / TCP_COLLAPSE_MAX_SIZE;
> +	new_truesize =3D nskbs * SKB_TRUESIZE(TCP_COLLAPSE_MAX_SIZE);
> +
> +	remainder =3D (sub_end - start) % TCP_COLLAPSE_MAX_SIZE;
> +	if (remainder) {
> +		nskbs++;
> +		new_truesize +=3D compute_skb_truesize(remainder, GFP_ATOMIC);
> +	}
> +
> +	if (old_truesize <=3D new_truesize) {
> +		start =3D sub_end;
> +		skb =3D n;
> +		goto restart;
>  	}

[Severity: Medium]
Can skipping a sub-range on the out-of-order rbtree (list =3D=3D NULL) brea=
k the
monotonic seq and end_seq ordering of tp->out_of_order_queue when skb
partially overlaps the previously collapsed range?

Suppose tp->out_of_order_queue holds skb_1 [1000, 5000] (truesize 8448) and
an overlapping skb_2 [4500, 5100] (truesize 896 from skbuff_small_head) whe=
re
!tcp_skb_can_collapse_rx(skb_1, skb_2) is true (for example, due to differi=
ng
MPTCP DSS extensions or decrypted state).  The first pass collapses skb_1 i=
nto
nskb_1 [1000, 4776] and nskb_2 [4776, 5000] on the deferred tmp queue, eras=
es
skb_1 from root, and advances start to 5000 and skb to skb_2.

On the next pass at restart, the unread 100 bytes of skb_2 [4500, 5100] are
bloated, but compute_skb_truesize(100, GFP_ATOMIC) is 896, so
old_truesize <=3D new_truesize holds and skb_2 is left in root with seq 4500
and end_seq 5100.  At the end label, tcp_rbtree_insert() orders by seq and
inserts nskb_2 [4776, 5000] to the right of skb_2 [4500, 5100]:

net/ipv4/tcp_input.c:tcp_collapse() {
    ...
end:
	skb_queue_walk_safe(&tmp, skb, n)
		tcp_rbtree_insert(root, skb);
}

tcp_collapse_ofo_queue() then sets tp->ooo_last_skb =3D skb_rb_last() to ns=
kb_2
(end_seq 5000) instead of skb_2 (end_seq 5100), causing later
tcp_data_queue_ofo() fastpath checks to misbehave and tcp_ofo_queue() to dr=
op
nskb_2 as out-of-order after skb_2 advances tp->rcv_nxt to 5100.

Checking (list || !before(TCP_SKB_CB(skb)->seq, start)) before taking the
old_truesize <=3D new_truesize skip path would ensure overlapping OOO SKBs =
are
still trimmed and re-keyed at start.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116230555.2305=
867-1-kuniyu@google.com?part=3D4
