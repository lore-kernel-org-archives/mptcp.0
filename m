Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794565804;
	b=LigbrvX0xsZsgHMGjyf1GS9ugk544D9CdRYx/BJu4voP2+uAdme7RtcZPEBy3AtEjnx7
	 jNmOabjCfNOXe1mqolqEZiUWhWdFpuK8bUZl01mbvf/DPMKTiXHqDRXyAESjQ20hs7kNn
	 dN0GOyis1XZrHvUc+5Zn6r3y5IaKfiC+OFwtfSlaxllzSkR0WDYVijFM3A0oIdDUsFgrQ
	 U62qnodu7me4DoiHzeH8HFG0eNQR7hSsBxlJ3WOuAd36ihfa9j6z3oPxowxm1LRy53A+x
	 MYgOBTZYbQ7FxFuDlSkCTiABdCBPJG/uymMTSgjNJoUuIBqwKVxRJiJO72AnxodjVqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794565804;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iYxTebdkRo9pCaReGGjoLSMYyPQcqr7yefUlpDw3fG0=;
	b=2sNuErWlVyAgtWPVS37DtKwsqf8KeofMq3eJix8pPGOm2xqTPbeN/WBl0+eRexG/aqV+
	 proWykyqOliKRlM44ZGvaVpeoVcBKCNUeQrAC5Hh1lkeddL4dYPJmGxhqkYdH6N/alOgD
	 KMEvEEmqJKZ0F2gloV31V8DcRGeaJ2M2OrjRk21BC0R37ubanQGopOtFixjExQh5RwhU4
	 N5kT/FJhqRQw2xYop+rgD8xzTbyBSyk+BKBLhL8P7nt90dbMZanzkSjAtVfUbNszG1Vvd
	 0xaiMb4adZ5+guRK2qTEhV1OqYAvmO4d0RH+hMi1LrA3pSMCu0I8iE1P3ujSiWH9K4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E5cICXBD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A55D606A330
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 10:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E5cICXBD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7172F1F000C4;
	Fri, 13 Nov 2026 10:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794565803;
	bh=iYxTebdkRo9pCaReGGjoLSMYyPQcqr7yefUlpDw3fG0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=E5cICXBDxE1Qsk4xQ/196YiKNjDzXWqPpBOerg5D2vbvH7dd2XEdlWp9erYezZg6e
	 uy4ldNyRanEcV0MxkH38TJ7flumM4rqz28b2aYFVvKX52OlCVcsrCimdhv0vpcSF83
	 UWGg0xDj0r/U/7SVD0rWxbstrDpsX+wO5Vf9sTWpG/+bnQxGV67PgDKCkEvEQNLGYY
	 VqZIFlfpiHJWGWgLtRUwpvBUg/BOlNrHh8n/MR7aUz0lPcH9H4d2+lISokssy/JtOJ
	 xQVgBLZIg+iZruUJtwPTuG9xDY73A6UlHcGSDNvX9PLvl4OKQB7FcqiUFaFiG1fgQv
	 ElpsM97eS2EYw==
Message-ID: <sashiko-outbox-212622@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v26 7/8] mptcp: sync mptcp skb cb layout with
 tcp one
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <328ddc33883506606aecad77f6645616df082740.1794563432.git.tanggeliang@kylinos.cn>
References: <cover.1794563432.git.tanggeliang@kylinos.cn>
 <328ddc33883506606aecad77f6645616df082740.1794563432.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 10:30:02 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [High] mptcp: u32 underflow of partial-packet copy_len in
  __mptcp_move_skb()
- [High] mptcp: __mptcp_try_coalesce() overwrites target skb offset in
  end_seq
- [High] mptcp: mptcp_data_queue_ofo() uses map_seq instead of payload
  start dsn
- [High] mptcp: rmem and fwdmem leak in __mptcp_move_skb() on
  rcv_data_fin drop
- [Medium] mptcp: incomplete DATA_FIN sequence and state check in
  __mptcp_move_skb()
--

commit af240c23f3ffb2394bc65420f6d1a5d0d83763e5
Author: Paolo Abeni <pabeni@redhat.com>

mptcp: sync mptcp skb cb layout with tcp one

This commit aligns struct mptcp_skb_cb with struct tcp_skb_cb by converting
map_seq and end_seq to u32, adding a 64-bit map_seq64 field, and updating
the receive and out-of-order paths to use 32-bit sequence helpers where
applicable.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 99dfcd0488a45..d124b702c9576 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -167,14 +167,14 @@ static bool __mptcp_try_coalesce(struct sock *sk, s=
truct sk_buff *to,
>  {
>  	int limit =3D READ_ONCE(sk->sk_rcvbuf);
> =20
> -	if (MPTCP_SKB_CB(from)->map_seq !=3D MPTCP_SKB_CB(to)->map_seq +
> -					   to->len ||
> +	if (MPTCP_SKB_CB(from)->map_seq64 !=3D MPTCP_SKB_CB(to)->map_seq64 +
> +					     to->len ||
>  	    MPTCP_SKB_CB(from)->flags & MPTCP_SKB_CB_F_OFFSET ||
>  	    ((to->len + from->len) > (limit >> 3)) ||
>  	    !skb_try_coalesce(to, from, fragstolen, delta))
>  		return false;
> =20
> -	pr_debug("colesced seq %llx into %llx new len %d new end seq %llx\n",
> +	pr_debug("colesced seq %x into %x new len %d new end seq %x\n",
>  		 MPTCP_SKB_CB(from)->map_seq, MPTCP_SKB_CB(to)->map_seq,
>  		 to->len, MPTCP_SKB_CB(from)->end_seq);
>  	MPTCP_SKB_CB(to)->end_seq =3D MPTCP_SKB_CB(from)->end_seq;

[Severity: High]
Does assigning MPTCP_SKB_CB(to)->end_seq =3D MPTCP_SKB_CB(from)->end_seq lo=
se
the subflow offset encoded in to when to has MPTCP_SKB_CB_F_OFFSET set?

mptcp_init_skb() sets end_seq to map_seq + copy_len (which is map_seq +
skb->len - offset), and __mptcp_move_skb() and __mptcp_ofo_queue() recover
copy_len =3D end_seq - map_seq and dsn =3D map_seq64 + skb->len - copy_len.
When from (with offset =3D=3D 0 and end_seq =3D=3D from->map_seq + from->le=
n) is
coalesced into a target skb that had offset > 0, overwriting to->end_seq
with from->end_seq instead of adding from->len makes to->end_seq -
to->map_seq equal the full new to->len.  When the coalesced skb is later
dequeued from the backlog or out-of-order queue, its recovered dsn is
shifted backwards by offset bytes, causing premature dequeue across gaps and
delivering stale subflow prefix bytes to user space.

[ ... ]

> @@ -303,14 +303,15 @@ static void mptcp_data_queue_ofo(struct mptcp_sock =
*msk, struct sk_buff *skb)
>  {
>  	struct sock *sk =3D (struct sock *)msk;
>  	struct rb_node **p, *parent;
> -	u64 seq, end_seq, max_seq;
> +	u64 end_seq, max_seq;
>  	struct sk_buff *skb1;
> +	u32 seq;
> =20
>  	seq =3D MPTCP_SKB_CB(skb)->map_seq;
> -	end_seq =3D MPTCP_SKB_CB(skb)->map_seq + skb->len;
> +	end_seq =3D MPTCP_SKB_CB(skb)->map_seq64 + skb->len;
>  	max_seq =3D atomic64_read(&msk->rcv_wnd_sent);

[ ... ]

> @@ -360,19 +361,19 @@ static void mptcp_data_queue_ofo(struct mptcp_sock =
*msk, struct sk_buff *skb)
>  	while (*p) {
>  		parent =3D *p;
>  		skb1 =3D rb_to_skb(parent);
> -		if (before64(seq, MPTCP_SKB_CB(skb1)->map_seq)) {
> +		if (before(seq, MPTCP_SKB_CB(skb1)->map_seq)) {
>  			p =3D &parent->rb_left;
>  			continue;
>  		}
> -		if (before64(seq, MPTCP_SKB_CB(skb1)->map_seq + skb1->len)) {
> -			if (!after64(end_seq,
> -				     MPTCP_SKB_CB(skb1)->map_seq + skb1->len)) {
> +		if (before(seq, MPTCP_SKB_CB(skb1)->map_seq + skb1->len)) {
> +			if (!after((u32)end_seq,
> +				   MPTCP_SKB_CB(skb1)->map_seq + skb1->len)) {
>  				/* All the bits are present. Drop. */
>  				mptcp_drop(sk, skb);
>  				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
>  				return;
>  			}
> -			if (after64(seq, MPTCP_SKB_CB(skb1)->map_seq)) {
> +			if (after(seq, MPTCP_SKB_CB(skb1)->map_seq)) {

[Severity: High]
Should mptcp_data_queue_ofo() order and deduplicate out-of-order segments
using the start DSN of their mapped payload rather than
MPTCP_SKB_CB(skb)->map_seq?

When an out-of-order skb has offset > 0, map_seq is dsn - offset, so
mptcp_data_queue_ofo() treats the unmapped subflow prefix [dsn - offset,
dsn) as present data in msk->out_of_order_queue.  A valid out-of-order
segment covering [dsn - offset, dsn) is then dropped as MPTCP_MIB_DUPDATA
(or evicted by rb_replace_node() / merge_right), while __mptcp_ofo_queue()
computes the true dsn and waits for msk->ack_seq to reach dsn before
dequeuing the skb, stalling the connection.

[ ... ]

> @@ -455,19 +457,20 @@ void __mptcp_sync_rcv_sequence(struct sock *sk)
>  	if (!skb)
>  		return;
> =20
> -	MPTCP_SKB_CB(skb)->map_seq =3D msk->tfo_iasn - skb->len;
> +	MPTCP_SKB_CB(skb)->map_seq64 =3D msk->tfo_iasn - skb->len;
> +	MPTCP_SKB_CB(skb)->map_seq =3D (u32)MPTCP_SKB_CB(skb)->map_seq64;
>  	MPTCP_SKB_CB(skb)->end_seq =3D MPTCP_SKB_CB(skb)->map_seq + skb->len;
>  }
> =20
>  static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
>  {
> -	u64 copy_len =3D MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_se=
q;
> -	u64 dsn =3D MPTCP_SKB_CB(skb)->map_seq + skb->len - copy_len;
> +	u32 copy_len =3D MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_se=
q;
> +	u64 dsn =3D MPTCP_SKB_CB(skb)->map_seq64 + skb->len - copy_len;
>  	struct mptcp_sock *msk =3D mptcp_sk(sk);
>  	struct sk_buff *tail;
> =20
>  	if (READ_ONCE(msk->rcv_data_fin) &&
> -	    !before64(MPTCP_SKB_CB(skb)->map_seq,
> +	    !before64(MPTCP_SKB_CB(skb)->map_seq64,
>  		      READ_ONCE(msk->rcv_data_fin_seq))) {

[Severity: High]
Does dropping skb in this rcv_data_fin check before calling
mptcp_borrow_fwdmem(sk, skb) leak ssk->sk_rmem_alloc and lent forward
memory?

Callers of __mptcp_move_skb() first call mptcp_subflow_lend_fwdmem(), which
clears skb->destructor while leaving skb->truesize charged to
ssk->sk_rmem_alloc.  Because mptcp_drop(sk, skb) is called here before
mptcp_borrow_fwdmem(sk, skb) transfers the forward memory to sk and
subtracts skb->truesize from ssk->sk_rmem_alloc, ssk->sk_rmem_alloc remains
permanently charged when the subflow socket closes.

[Severity: Medium]
Can segments spanning or arriving after rcv_data_fin_seq bypass this
DATA_FIN check?

Checking MPTCP_SKB_CB(skb)->map_seq64 instead of MPTCP_SKB_CB(skb)->map_seq=
64
+ skb->len accepts segments that start before rcv_data_fin_seq (including
segments at rcv_data_fin_seq with offset > 0) and extend past it, advancing
msk->ack_seq past rcv_data_fin_seq so mptcp_pending_data_fin() never
matches.  In addition, once mptcp_check_data_fin() processes DATA_FIN, it
clears msk->rcv_data_fin to 0 and increments msk->ack_seq to
rcv_data_fin_seq + 1:

net/mptcp/protocol.c:mptcp_check_data_fin() {
	if (mptcp_pending_data_fin(sk, &rcv_data_fin_seq)) {
		WRITE_ONCE(msk->ack_seq, msk->ack_seq + 1);
		WRITE_ONCE(msk->rcv_data_fin, 0);

		WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | RCV_SHUTDOWN);
}

A subsequent segment at rcv_data_fin_seq + 1 then sees msk->rcv_data_fin =
=3D=3D 0
and dsn =3D=3D msk->ack_seq and is queued to sk_receive_queue while
msk->copied_seq stays at rcv_data_fin_seq, causing offset in
__mptcp_recvmsg_mskq() to wrap to U32_MAX and skip freeing the skb.

> @@ -505,8 +508,8 @@ static bool __mptcp_move_skb(struct sock *sk, struct =
sk_buff *skb)
>  	}
> =20
>  	/* Partial packet */
> -	if (after64(MPTCP_SKB_CB(skb)->end_seq, msk->ack_seq)) {
> -		copy_len =3D MPTCP_SKB_CB(skb)->end_seq - msk->ack_seq;
> +	if (after64(MPTCP_SKB_CB(skb)->map_seq64 + skb->len, msk->ack_seq)) {
> +		copy_len =3D MPTCP_SKB_CB(skb)->end_seq - (u32)msk->ack_seq;
>  		goto insert;
>  	}

[Severity: High]
Can copy_len undercount by offset or underflow u32 when a partial packet has
a non-zero subflow offset?

mptcp_init_skb() sets MPTCP_SKB_CB(skb)->end_seq to map_seq + copy_len,
which is map_seq + skb->len - offset.  When offset > 0 and msk->ack_seq
falls in the last offset bytes of the skb ([map_seq64 + skb->len - offset,
map_seq64 + skb->len)), the after64() check passes while end_seq <=3D
(u32)msk->ack_seq, so MPTCP_SKB_CB(skb)->end_seq - (u32)msk->ack_seq wraps
around to ~4 GiB and corrupts msk->bytes_received and msk->ack_seq at
insert.  Should this compute MPTCP_SKB_CB(skb)->map_seq + skb->len -
(u32)msk->ack_seq, matching __mptcp_ofo_queue()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794563432.gi=
t.tanggeliang@kylinos.cn?part=3D7
