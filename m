Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794565686;
	b=jA+w5vT30lXH3D162C94kux3tHfkC6eU5atDyq2OMC2bJdgy01WgGD2aCetj0wm+zn+B
	 vOhvYPR7V6xlIKOJUHRWhSkv1shOoFOA07tedRbQF5y3Lht8qUWAP2V1q/+QAix3qR3Mg
	 CcyInWFZTCGrZlaL4PTpX//V4jOqy+/FBA2bEtYNmtux+lA0DEjEKpN+IwHp5cobvnVGq
	 ndPr1Wy5cUbePdtmAuyjf/+B86HaJ1EM+mYqfRDFOF/jJkJI7Q4JhHSQvLtYYDurAJ08V
	 enmtC5U0YiRQ0vX/IqIoU/i2MXLI2cZfgaeZp/AlREu8InPDw8gZNF4c7P455Xg3poA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794565686;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RVtWJfvbLB5pZ9e9XVs5TRfAahTvKhkfuuIdiEsJmHk=;
	b=AX9Eneif7NMtSkRYJjnBhNs/5h5fjGTa42gFgA24RJfkB0CMsPokokNSOjJwRVGij4Ic
	 9GvRfkD6wNja/vT2kdQkatUEBj1ODXxakgVkBcySwu/Q4/Jg9Qzh1rkH9f/mGWhH8clvp
	 l/JcLZIRHWm1EpXCMghvvn2QoQ68Jc0mi0WJ0cFrq2QO5Qfr1XAH+k3+1Pt4lfisbt466
	 3efYNRw+tzAnZaGkZJzPr4PffjepeREj8Snp3XrThmNmrJ4vzHAfHehi82lVNv196N1+B
	 He5iSS+mEuvJFzgNZbLRGkTJhhv0DLfHc/4VOKJX3eBGGOVsTPajVuImTfJf5yQGL9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WvYkpT3Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7678B606A31C
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 10:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WvYkpT3Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 343621F000C4;
	Fri, 13 Nov 2026 10:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794565686;
	bh=RVtWJfvbLB5pZ9e9XVs5TRfAahTvKhkfuuIdiEsJmHk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=WvYkpT3Z9W/I8RQzHdg6q59GsJ9/+nyjuVb/x0olwNf6USmLG1SCG4lOp+JwYMKWY
	 dYtaNxfESbWXVirX0mUZMNySk5hMBn1mJqHHfseblwGBe1ub5H8FDLmUfqnavJcQIG
	 TATPqv5KHn/DqztPkdGzgHWd2tULN56nZhD/FiPTJg2hBmuSuoWO/BrIO8KFNvSwmg
	 BjcCP7iuOisJ0J9XjKK1jpiAoUbCKPNrbdyp81SiD2uATqi23UnpH7+TCO5alwihnH
	 1Vz8Fc7t6HJpXjxZc7vLkXCqxutRXMkyhhTXp1uOF6ZJjJgMiw3SfsRATZZC5bhxyR
	 URpTTZXZwsJRQ==
Message-ID: <sashiko-outbox-212621@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v26 6/8] mptcp: remove CB offset field
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <0bd74213de97c6d796b835f567e0f426bee89008.1794563432.git.tanggeliang@kylinos.cn>
References: <cover.1794563432.git.tanggeliang@kylinos.cn>
 <0bd74213de97c6d796b835f567e0f426bee89008.1794563432.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 10:28:05 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 6 potential
issues to consider:
- [High] mptcp: subflow sk_rmem_alloc leak in __mptcp_move_skb() on
  rcv_data_fin drop
- [High] mptcp: rcv_data_fin guard bypass in __mptcp_move_skb()
  underflows offset
- [High] mptcp: out-of-order queue corruption and stall on non-zero skb
  offset
- [High] mptcp: wrong partial-packet copy_len in __mptcp_move_skb() when
  offset > 0
- [High] mptcp: __mptcp_try_coalesce() clobbers encoded offset on target
  skb
- [Medium] mptcp: commit message describes unimplemented
  mptcp_init_skb() changes
--

commit c03fb1e5a208813143363f01640f8ace04366cfd
Author: Paolo Abeni <pabeni@redhat.com>

mptcp: remove CB offset field

This commit replaces the per-skb MPTCP_SKB_CB(skb)->offset field with an
msk-level copied_seq field to track the read offset in the MPTCP receive
queue.

> In mptcp_init_skb(), map_seq is computed as mptcp_subflow_get_mapped_dsn()
> minus offset. A mapping boundary check using before() for proper 32-bit
> modular arithmetic detects when the skb spans multiple DSS mappings
> (offset > 0 and skb starts before the current mapping). In that case,
> the consumed prefix bytes belong to an old mapping and must be removed
> before setting map_seq. The function now returns bool to indicate success.
>
> When removing the prefix, we handle linear and paged data separately.
> For offset within linear data where offset <=3D skb_headlen, use skb_pull=
()
> which is safe and doesn't modify truesize. For offset in paged data where
> offset > skb_headlen, use pskb_pull() which may expand the skb head. To
> avoid truesize corruption in pskb_expand_head(), we first orphan the skb
> to disconnect it from the socket, perform the pull, recompute truesize
> manually, then reattach with skb_set_owner_r(). This ensures proper memory
> accounting.
>
> When mptcp_init_skb() fails, the caller increments seq to skip the
> problematic skb, records the failure via MPTCP_MIB_RCVPRUNED, and jumps
> to cleanup to ensure tp->copied_seq and more_data_avail are properly
> updated. This maintains TCP/MPTCP state consistency, and MPTCP-level
> retransmission will fill any resulting gaps.
>
> When the skb stays within a single mapping and offset > 0, map_seq is
> rewound to cover the already-consumed prefix. A new MPTCP_SKB_CB_F_OFFSET
> flag marks such skbs. __mptcp_try_coalesce() refuses to coalesce when the
> from skb carries this flag, preventing an unvalidated prefix from being
> merged into a validated buffer. mptcp_data_queue_ofo() skips the
> rb_replace_node() replacement when the new skb covers an existing OFO
> entry and carries the flag, so that previously validated data is not
> overwritten by an unvalidated prefix; the new skb is inserted after the
> existing entry instead, and the prefix is naturally skipped when the OFO
> queue is later processed.

[Severity: Medium]
Does the commit message match the actual code changes in this patch?
mptcp_init_skb() still returns void and does not check mapping boundaries
or call skb_pull() / pskb_pull(), __mptcp_move_skbs_from_subflow() has no
failure handling or MPTCP_MIB_RCVPRUNED accounting, and
mptcp_data_queue_ofo() does not check MPTCP_SKB_CB_F_OFFSET before calling
rb_replace_node().

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 41fc2429d2fed..99dfcd0488a45 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -167,8 +167,9 @@ static bool __mptcp_try_coalesce(struct sock *sk, str=
uct sk_buff *to,
>  {
>  	int limit =3D READ_ONCE(sk->sk_rcvbuf);
> =20
> -	if (MPTCP_SKB_CB(from)->map_seq !=3D MPTCP_SKB_CB(to)->end_seq ||
> -	    MPTCP_SKB_CB(from)->offset ||
> +	if (MPTCP_SKB_CB(from)->map_seq !=3D MPTCP_SKB_CB(to)->map_seq +
> +					   to->len ||
> +	    MPTCP_SKB_CB(from)->flags & MPTCP_SKB_CB_F_OFFSET ||
>  	    ((to->len + from->len) > (limit >> 3)) ||
>  	    !skb_try_coalesce(to, from, fragstolen, delta))
>  		return false;

[Severity: High]
Does coalescing into a target skb that had offset > 0 lose its encoded
offset?

When to has offset > 0, mptcp_init_skb() sets to->map_seq =3D mapped_dsn -
offset and to->end_seq =3D to->map_seq + to->len - offset, so __mptcp_move_=
skb()
and __mptcp_ofo_queue() can recover offset from to->len - (to->end_seq -
to->map_seq).  When from (with offset =3D=3D 0 and from->end_seq =3D=3D
from->map_seq + from->len) is coalesced into to in __mptcp_add_backlog()
or mptcp_data_queue_ofo(), __mptcp_try_coalesce() does:

net/mptcp/protocol.c:__mptcp_try_coalesce() {
    ...
	MPTCP_SKB_CB(to)->end_seq =3D MPTCP_SKB_CB(from)->end_seq;
	return true;
}

That sets to->end_seq to to->map_seq + to->len, wiping out the offset diffe=
rence.
When to is later spooled from the backlog or out-of-order queue, dsn is
computed as mapped_dsn - offset instead of mapped_dsn, causing the stale
prefix bytes in to->data[0..offset - 1] to be treated as valid unconsumed
payload.

> @@ -306,7 +307,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *m=
sk, struct sk_buff *skb)
>  	struct sk_buff *skb1;
> =20
>  	seq =3D MPTCP_SKB_CB(skb)->map_seq;
> -	end_seq =3D MPTCP_SKB_CB(skb)->end_seq;
> +	end_seq =3D MPTCP_SKB_CB(skb)->map_seq + skb->len;
>  	max_seq =3D atomic64_read(&msk->rcv_wnd_sent);

[ ... ]

> @@ -346,7 +347,8 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *m=
sk, struct sk_buff *skb)
>  	}
> =20
>  	/* Can avoid an rbtree lookup if we are adding skb after ooo_last_skb */
> -	if (!before64(seq, MPTCP_SKB_CB(msk->ooo_last_skb)->end_seq)) {
> +	if (!before64(seq, MPTCP_SKB_CB(msk->ooo_last_skb)->map_seq +
> +		      msk->ooo_last_skb->len)) {
>  		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_OFOQUEUETAIL);
>  		parent =3D &msk->ooo_last_skb->rbnode;
>  		p =3D &parent->rb_right;
> @@ -362,8 +364,9 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *m=
sk, struct sk_buff *skb)
>  			p =3D &parent->rb_left;
>  			continue;
>  		}
> -		if (before64(seq, MPTCP_SKB_CB(skb1)->end_seq)) {
> -			if (!after64(end_seq, MPTCP_SKB_CB(skb1)->end_seq)) {
> +		if (before64(seq, MPTCP_SKB_CB(skb1)->map_seq + skb1->len)) {
> +			if (!after64(end_seq,
> +				     MPTCP_SKB_CB(skb1)->map_seq + skb1->len)) {
>  				/* All the bits are present. Drop. */
>  				mptcp_drop(sk, skb);
>  				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
> @@ -400,7 +403,8 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *m=
sk, struct sk_buff *skb)
>  merge_right:
>  	/* Remove other segments covered by skb. */
>  	while ((skb1 =3D skb_rb_next(skb)) !=3D NULL) {
> -		if (before64(end_seq, MPTCP_SKB_CB(skb1)->end_seq))
> +		if (before64(end_seq,
> +			     MPTCP_SKB_CB(skb1)->map_seq + skb1->len))
>  			break;
>  		rb_erase(&skb1->rbnode, &msk->out_of_order_queue);
>  		mptcp_drop(sk, skb1);
> @@ -425,9 +429,10 @@ static void mptcp_init_skb(struct sock *ssk, struct =
sk_buff *skb, int offset,
>  	 * mptcp_subflow_get_mapped_dsn() is based on the current tp->copied_seq
>  	 * value
>  	 */
> -	MPTCP_SKB_CB(skb)->map_seq =3D mptcp_subflow_get_mapped_dsn(subflow);
> +	MPTCP_SKB_CB(skb)->map_seq =3D mptcp_subflow_get_mapped_dsn(subflow) -
> +				     offset;
>  	MPTCP_SKB_CB(skb)->end_seq =3D MPTCP_SKB_CB(skb)->map_seq + copy_len;
> -	MPTCP_SKB_CB(skb)->offset =3D offset;
> +	MPTCP_SKB_CB(skb)->flags =3D offset ? MPTCP_SKB_CB_F_OFFSET : 0;
>  	MPTCP_SKB_CB(skb)->has_rxtstamp =3D has_rxtstamp;

[Severity: High]
Can an out-of-order skb with offset > 0 cause mptcp_data_queue_ofo() to
drop valid segments and stall the receive queue?

When offset > 0, mptcp_init_skb() rewinds MPTCP_SKB_CB(skb)->map_seq to
mapped_dsn - offset while the valid unconsumed payload only starts at
mapped_dsn.  mptcp_data_queue_ofo() uses seq =3D MPTCP_SKB_CB(skb)->map_seq
(mapped_dsn - offset) to position skb and deduplicate overlapping ranges,
so any valid out-of-order segment skb1 covering [mapped_dsn - offset,
mapped_dsn) is either replaced via rb_replace_node() / merge_right if it
was queued first, or dropped as MPTCP_MIB_DUPDATA if it arrives after skb.

When msk->ack_seq later reaches mapped_dsn - offset, __mptcp_ofo_queue()
checks dsn =3D mapped_dsn > msk->ack_seq and stops draining the RB-tree
because the segment covering [mapped_dsn - offset, mapped_dsn) was
dropped, stalling the connection.

[ ... ]

> @@ -450,17 +455,24 @@ void __mptcp_sync_rcv_sequence(struct sock *sk)

[ ... ]

>  static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
>  {
>  	u64 copy_len =3D MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_se=
q;
> +	u64 dsn =3D MPTCP_SKB_CB(skb)->map_seq + skb->len - copy_len;
>  	struct mptcp_sock *msk =3D mptcp_sk(sk);
>  	struct sk_buff *tail;
> =20
> +	if (READ_ONCE(msk->rcv_data_fin) &&
> +	    !before64(MPTCP_SKB_CB(skb)->map_seq,
> +		      READ_ONCE(msk->rcv_data_fin_seq))) {
> +		mptcp_drop(sk, skb);
> +		return false;
> +	}
> +
>  	mptcp_borrow_fwdmem(sk, skb);

[Severity: High]
Does calling mptcp_drop() before mptcp_borrow_fwdmem() leak
ssk->sk_rmem_alloc on the subflow socket?

Both callers of __mptcp_move_skb() call mptcp_subflow_lend_fwdmem() first,
which clears skb->destructor =3D NULL while leaving skb->truesize charged to
ssk->sk_rmem_alloc until mptcp_borrow_fwdmem() transfers the forward
memory to sk and subtracts skb->truesize from ssk->sk_rmem_alloc.
Dropping skb before mptcp_borrow_fwdmem() skips that uncharge on ssk (so
closing the subflow triggers the sk_rmem_alloc warning in
inet_sock_destruct()) and calls sk_mem_reclaim(sk) without having credited
sk->sk_forward_alloc.

[Severity: High]
Can data arriving after DATA_FIN has been processed bypass this
rcv_data_fin check and underflow the receive offset?

Once mptcp_check_data_fin() processes the DATA_FIN, it increments
msk->ack_seq to rcv_data_fin_seq + 1 and clears msk->rcv_data_fin to 0:

net/mptcp/protocol.c:mptcp_check_data_fin() {
    ...
	if (mptcp_pending_data_fin(sk, &rcv_data_fin_seq)) {
		WRITE_ONCE(msk->ack_seq, msk->ack_seq + 1);
		WRITE_ONCE(msk->rcv_data_fin, 0);

		WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | RCV_SHUTDOWN);
    ...
}

If a peer then sends a segment at dsn =3D rcv_data_fin_seq + 1 on an open
subflow, READ_ONCE(msk->rcv_data_fin) is 0, so __mptcp_move_skb() accepts
the skb as in-sequence (dsn =3D=3D msk->ack_seq) and queues it with map_seq=
 =3D
rcv_data_fin_seq + 1 while msk->copied_seq is at most rcv_data_fin_seq.
In __mptcp_recvmsg_mskq(), offset =3D *seq - MPTCP_SKB_CB(skb)->map_seq
underflows and skips the skb without consuming or freeing it.  In
addition, while msk->rcv_data_fin is still set, checking map_seq instead
of map_seq + skb->len misses segments that straddle rcv_data_fin_seq (or
have map_seq < rcv_data_fin_seq <=3D dsn due to offset > 0) and lets them
advance msk->ack_seq past rcv_data_fin_seq.

[ ... ]

> @@ -495,10 +507,6 @@ static bool __mptcp_move_skb(struct sock *sk, struct=
 sk_buff *skb)
>  	/* Partial packet */
>  	if (after64(MPTCP_SKB_CB(skb)->end_seq, msk->ack_seq)) {
>  		copy_len =3D MPTCP_SKB_CB(skb)->end_seq - msk->ack_seq;
> -		MPTCP_SKB_CB(skb)->offset +=3D msk->ack_seq -
> -					     MPTCP_SKB_CB(skb)->map_seq;
> -		MPTCP_SKB_CB(skb)->map_seq +=3D msk->ack_seq -
> -					      MPTCP_SKB_CB(skb)->map_seq;
>  		goto insert;
>  	}

[Severity: High]
Does the partial-packet check use the wrong end sequence when offset > 0?

In mptcp_init_skb(), MPTCP_SKB_CB(skb)->end_seq is set to map_seq +
copy_len (=3D dsn + copy_len - offset), which is offset bytes less than the
actual end of the segment (map_seq + skb->len).  When before64(dsn,
msk->ack_seq) and offset > 0, using MPTCP_SKB_CB(skb)->end_seq here
falsely drops the skb as duplicate data if msk->ack_seq falls in
[end_seq, map_seq + skb->len), or under-increments msk->ack_seq and
msk->bytes_received by offset bytes while __mptcp_recvmsg_mskq() and
__mptcp_read_sock() still copy up to skb->len (advancing msk->copied_seq
past msk->ack_seq).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794563432.gi=
t.tanggeliang@kylinos.cn?part=3D6
