Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794259089;
	b=aM5mFqHQh8DpJoXccmJs/61VyWnPDiwN3MPqIupq5Kai36WxfyYC6T7m/D2KKeaFfrY0
	 z9FttvcJXNp0a+eAXp6J2+/50lVufSeN7jcSj3VLWoVNLzr7UPivNQjSV3JRXzqYpqS1V
	 oXMU3QcX53r1HGgF+qkU4L4KugHjo46bMG2i+lxWMA+Z67k/vM1t2B/ALdtqnwVOy9ucZ
	 VSOPwUAbB+oksYtj+ZMyCd/pXYbNy/1JmwgjhMfrSP0upvS5o0fcDL0WWq5FupWpNbeZI
	 aEgzwi1RXIx9xSrd2LMpyip67t4Qy4lTNntO1BWUebS5528KqyL9XDkGDRlaH55tTCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794259089;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ri0hcF0W3GTDqk3KQ/zQKLhbNb5p4CTCiXZjdtf5Pxk=;
	b=XIAcrdpTzkxt2zZMMjAUBtid7hgDrr/Xkdz+BD3NdUcNTyHpA/CfjVKXjsoOp4kYD82D
	 IUy0LLq4ESd9joc14l7DfWwFTSczI0jzoTwVfE1TScwJJxSNhrHrQd6RNiLq/Yi2CbaJr
	 s3CGXsXLJqcD1RbXUDXMv6yPXkwRzBY5bzZqA6nUbTtVwIyouHYkDi30xUxCJqsshYwEY
	 0QFkoCvRc8pk3UqKJqkpUFqWkdps8D4QvZvYZNJ+Pnk/uoplogF7mZ0k0rlEw6J3YSkZ7
	 zd0c9xkIX48G10J5f7i52BcXxXNMIv2WLM4HNxUWnHYC3kqVa2G82vgm59SWlP+BTGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HQrGXtde;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895B2606A31C
	for <mptcp@lists.linux.dev>; Mon,  9 Nov 2026 21:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HQrGXtde
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E10E61F0089F;
	Mon,  9 Nov 2026 21:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794259089;
	bh=Ri0hcF0W3GTDqk3KQ/zQKLhbNb5p4CTCiXZjdtf5Pxk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=HQrGXtdeJqPPgai2KI3ViJ9x/RZB6+Eur6IO0XGq2snfoeMs0m3u3MG8CDPIKVnqE
	 gxBzfWoSJqSzb0dZIoJxLGJvgVqCbiZQdViMlfoU2shCHvBGhRjmi9DfKTHyPxeRbi
	 u08Y4QYgozyLks07UTV7nYhCe460DZENkqOFNyx8l/E/8Zj66wb0p6PA2icH7ceVYC
	 cBdnuI5Zpl4ZaPqgV64c7E7mL5xPqYvOqeg4/JxLBFKjYc3nzRApqU3dspQlBT2EJx
	 SP2JAdf/Zfriu2SuWdOhzMPpFDZ2taex1nY+NI7IHG3b39BD0+dLPcix1X9mcT6Jrs
	 2N9QDPl3j/63g==
Message-ID: <sashiko-outbox-205661@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v24 6/8] mptcp: remove CB offset field
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <8b30d5f811cfc37189badb3f7c86f565059063e4.1794215614.git.tanggeliang@kylinos.cn>
References: <cover.1794215614.git.tanggeliang@kylinos.cn>
 <8b30d5f811cfc37189badb3f7c86f565059063e4.1794215614.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 21:18:08 +0000
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
- [High] mptcp: sk_forward_alloc corruption in mptcp_init_skb() on paged
  pull
- [Medium] mptcp: rewound map_seq in mptcp_init_skb() exposes
  unvalidated prefix
--

commit 53ea4c3d9a0507effa8276bb08b2e103414e8c2d
Author: Paolo Abeni <pabeni@redhat.com>

mptcp: remove CB offset field

This commit replaces the per-skb MPTCP_SKB_CB(skb)->offset field with an
msk-level copied_seq counter and handles already-consumed skb prefixes in
mptcp_init_skb().

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index ce0f9c2e6fd1a..30933dd9f0b1d 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -375,6 +375,11 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *=
msk, struct sk_buff *skb)
>  				 *  |     skb1    |
>  				 * continue traversing
>  				 */
> +			} else if (MPTCP_SKB_CB(skb)->flags &
> +				   MPTCP_SKB_CB_F_OFFSET) {
> +				/* skb covers skb1 but has an unvalidated
> +				 * prefix; keep skb1, continue traversing.
> +				 */
>  			} else {
>  				/* skb's seq =3D=3D skb1's seq and skb covers skb1.
>  				 * Replace skb1 with skb.
> @@ -415,25 +420,54 @@ static void mptcp_data_queue_ofo(struct mptcp_sock =
*msk, struct sk_buff *skb)
>  	skb_set_owner_r(skb, sk);
>  }
> =20
> -static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int of=
fset,
> -			   int copy_len)
> +static bool mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int of=
fset)
>  {
>  	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
>  	bool has_rxtstamp =3D TCP_SKB_CB(skb)->has_rxtstamp;
> =20
> +	/* Detect mapping boundary: skb spans multiple mappings */
> +	if (unlikely(offset > 0 &&
> +		     before(TCP_SKB_CB(skb)->seq - subflow->ssn_offset,
> +			    subflow->map_subflow_seq))) {
> +		if (offset >=3D skb->len) {
> +			sk_eat_skb(ssk, skb);
> +			return false;
> +		}
> +
> +		if (offset > skb_headlen(skb)) {
> +			skb_orphan(skb);
> +			if (!pskb_pull(skb, offset)) {
> +				sk_eat_skb(ssk, skb);
> +				return false;
> +			}
> +			skb->truesize =3D SKB_TRUESIZE(skb_end_offset(skb)) +
> +					skb->data_len;
> +			skb_set_owner_r(skb, ssk);
> +		} else {
> +			if (!skb_pull(skb, offset)) {
> +				sk_eat_skb(ssk, skb);
> +				return false;
> +			}
> +		}
> +		offset =3D 0;
> +	}

[Severity: High]
Does orphaning and re-charging skb here corrupt ssk->sk_forward_alloc and
subflow->lent_mem_frag?

skb_orphan(skb) invokes sock_rfree() -> sk_mem_uncharge(ssk, orig_truesize),
which calls sk_mem_reclaim() and returns whole pages from
ssk->sk_forward_alloc to tcp_memory_allocated.  skb_set_owner_r(skb, ssk)
then calls sk_mem_charge(ssk, skb->truesize) without sk_rmem_schedule(),
subtracting the new truesize from ssk->sk_forward_alloc without allocating
backing pages, and altering skb->truesize breaks the PAGE_SIZE alignment
that mptcp_subflow_lend_fwdmem() and __mptcp_close_ssk() rely on.  When the
subflow closes, ssk->sk_forward_alloc is left negative (triggering
WARN_ON_ONCE(sk->sk_forward_alloc) in inet_sock_destruct()) while msk
reclaims the transferred pages a second time.

Note that pskb_expand_head() only adjusts skb->truesize when !skb->sk or
skb->destructor =3D=3D sock_edemux, so calling pskb_pull() directly while s=
kb is
still owned by ssk avoids changing skb->truesize or touching
ssk->sk_forward_alloc.

> +
>  	/* the skb map_seq accounts for the skb offset:
>  	 * mptcp_subflow_get_mapped_dsn() is based on the current tp->copied_seq
>  	 * value
>  	 */
> -	MPTCP_SKB_CB(skb)->map_seq =3D mptcp_subflow_get_mapped_dsn(subflow);
> -	MPTCP_SKB_CB(skb)->end_seq =3D MPTCP_SKB_CB(skb)->map_seq + copy_len;
> -	MPTCP_SKB_CB(skb)->offset =3D offset;
> +	MPTCP_SKB_CB(skb)->map_seq =3D mptcp_subflow_get_mapped_dsn(subflow) -
> +				     offset;
> +	MPTCP_SKB_CB(skb)->end_seq =3D MPTCP_SKB_CB(skb)->map_seq + skb->len;
> +	MPTCP_SKB_CB(skb)->flags =3D offset ? MPTCP_SKB_CB_F_OFFSET : 0;

[Severity: Medium]
Can rewinding MPTCP_SKB_CB(skb)->map_seq by offset expose the unvalidated
prefix to the receive and out-of-order queues?

When an incoming subflow segment overlaps tp->copied_seq within the current
DSS mapping, validate_data_csum() starts at tp->copied_seq +
subflow->map_csum_len and does not validate the first offset bytes of skb.
Because mptcp_init_skb() rewinds map_seq to include that prefix and only
records a single bit in MPTCP_SKB_CB_F_OFFSET:

In mptcp_data_queue_ofo(), if the already-validated range in
msk->out_of_order_queue spans more than one skb (for example skb1a covering
[1000, 1050) and skb1b covering [1050, 1100)) and a segment arrives with
mapped_dsn 1100 and offset 100, traversal skips replacing skb1a via the
MPTCP_SKB_CB_F_OFFSET check, moves right to skb1b, sees seq (1000) <
skb1b->map_seq (1050), inserts skb to the left of skb1b, and then drops the
checksum-validated skb1b in merge_right, replacing [1050, 1100) with skb's
unvalidated prefix.  Similarly, mptcp_prune_ofo_queue() compares the rewound
in_skb->map_seq against the validated ooo_last_skb and can prune it, and in
__mptcp_move_skb(), if the earlier segment that advanced tp->copied_seq was
dropped at the msk level due to backlog or rmem limits before advancing
msk->ack_seq, the unvalidated prefix is accepted as in-sequence data.

Pulling offset bytes in mptcp_init_skb() whenever offset > 0 (not only
across mapping boundaries) would strip the unvalidated prefix before map_seq
is set.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794215614.gi=
t.tanggeliang@kylinos.cn?part=3D6
