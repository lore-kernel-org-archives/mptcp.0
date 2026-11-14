Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794667275;
	b=EAOWhlcegmveX5C3rgJa8aspzmUGskifNV89NjlGdOn7ibc0B1fgGVuuTI/twXCqRAf2
	 72XktYHOksre5tCC0ke+x1kfHMnqxbgm5B6+HkCVC0nGxxnABzuDZvWucmWJO2xujZwOe
	 H/0ehDa9rT/5kRA0QCdlLTux5I5zII64WXhFwwC0CiGz1DwpcyagHMSUjwMKGE0YcsP3j
	 oeZIKc5xwxX2qlV1SbJXYHhp3HsArEvVDxVGkOiq/KfuQQi0dw5RKyAGJuiJWCmJT8zEr
	 /jWltHN3F+6n+nxlNorVwkQfl5unpRY+n6gdaN3aKN/PO7YtbicZPuDXqPeWvfKmPQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794667275;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=juq+z5mo2/EFSKu7iFHGFsx99ESL0A9H0rZmqYjTpbk=;
	b=bsbaWHRxOsA/VTgxTd8CLcLm70gXDUpqKIDP222I2J57PrGGEVDYW1onw+9l20xqkIPX
	 f11LyawgQeOaNvJe7rwneZbNOh93tXs0RQi0ixUNwscE1owrZCfNiDSvWF30BHwJwr5cy
	 ISRZLQ+Kej26nr0choQLBc0puRnUzlx0kjOOMzDZ9c+FFdPoQpgk0z4hvfYslR+N/L3te
	 aZO92XaTPfcE4ozYiZTfhTijqbdweqPfIV3rD213WbM8T/R4yzpLh7LM6mHQRlMiOJpUg
	 5Y4qR/sKW23+CMhlbmAqRy81buhiWvyK6y+jPxD+5EV+qCgkMURE+Guuar4UUoDx2Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ct+bQuWK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC4F606A32E
	for <mptcp@lists.linux.dev>; Sat, 14 Nov 2026 14:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ct+bQuWK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61FE61F000C4;
	Sat, 14 Nov 2026 14:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794667275;
	bh=juq+z5mo2/EFSKu7iFHGFsx99ESL0A9H0rZmqYjTpbk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Ct+bQuWK3IWPo9vT5KnReIGMxgpESDi5NixJ7WEKXam2TyYMjTly6FCLb8ZKiIEGa
	 0Soubz3q7lELIVjom4afRBC4ObPv/fq5BhAlBz5VopIGHDCLus8gno1EFYklUdgnqD
	 mCA893FaE40vrbjRPE49QaF21GY3P77cWKdDxFw48y406/9uDGAWhILqj/6JfLfzB0
	 OVwwbv3pq0vS6LMYekFnr+hTMNdyqWLziIe3r4DJPEJWUevKV/ehUXjBHpVTUtltX/
	 JfNZ+YobQ+IpwwTm4wL7rVZFdhzMmDc8yNhFTxPDf8ojEywnlBbjoO/GNgM9jnFN5G
	 a3Nzi7mYOaD+A==
Message-ID: <sashiko-outbox-214644@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v27 7/8] mptcp: sync mptcp skb cb layout with
 tcp one
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <67a345724d8dfd927d8adb63fe851d096da4c8de.1794663678.git.tanggeliang@kylinos.cn>
References: <cover.1794663678.git.tanggeliang@kylinos.cn>
 <67a345724d8dfd927d8adb63fe851d096da4c8de.1794663678.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 14:41:14 +0000
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
- [High] mptcp: use of offset-shifted map_seq instead of mptcp_dsn() in
  OoO queue
- [Medium] mptcp: copied_seq offset underflow in recv path for data
  after DATA_FIN
--

commit 84c94fa4a2c64ea1454102c7e6fa9ff2a5c5884a
Author: Paolo Abeni <pabeni@redhat.com>

mptcp: sync mptcp skb cb layout with tcp one

This commit aligns the MPTCP skb control buffer layout with TCP's by
shrinking map_seq and end_seq to 32-bit values, adding a 64-bit map_seq64
field, and switching the receive and out-of-order paths to 32-bit sequence
arithmetic where possible.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index f4ab3bdd368f2..44f4a680a4bdb 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -256,8 +256,8 @@ static void mptcp_prune_ofo_queue(struct sock *sk,
>  		struct sk_buff *skb =3D rb_to_skb(node);
> =20
>  		/* Stop pruning if the incoming skb would land in OoO tail. */
> -		if (after64(MPTCP_SKB_CB(in_skb)->map_seq,
> -			    MPTCP_SKB_CB(skb)->map_seq))
> +		if (after(MPTCP_SKB_CB(in_skb)->map_seq,
> +			  MPTCP_SKB_CB(skb)->map_seq))
>  			break;
> =20
>  		pruned =3D true;

[ ... ]

> @@ -359,18 +360,18 @@ static void mptcp_data_queue_ofo(struct mptcp_sock =
*msk, struct sk_buff *skb)
>  	while (*p) {
>  		parent =3D *p;
>  		skb1 =3D rb_to_skb(parent);
> -		if (before64(seq, MPTCP_SKB_CB(skb1)->map_seq)) {
> +		if (before(seq, MPTCP_SKB_CB(skb1)->map_seq)) {
>  			p =3D &parent->rb_left;
>  			continue;
>  		}
> -		if (before64(seq, mptcp_end_dsn(skb1))) {
> -			if (!after64(end_seq, mptcp_end_dsn(skb1))) {
> +		if (before(seq, (u32)mptcp_end_dsn(skb1))) {
> +			if (!after((u32)end_seq, (u32)mptcp_end_dsn(skb1))) {
>  				/* All the bits are present. Drop. */
>  				mptcp_drop(sk, skb);
>  				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
>  				return;
>  			}
> -			if (after64(seq, MPTCP_SKB_CB(skb1)->map_seq)) {
> +			if (after(seq, MPTCP_SKB_CB(skb1)->map_seq)) {
>  				/* partial overlap:
>  				 *     |     skb      |
>  				 *  |     skb1    |

[ ... ]

> @@ -424,10 +425,11 @@ static void mptcp_init_skb(struct sock *ssk, struct=
 sk_buff *skb, int offset,
> =20
>  	/* the skb map_seq accounts for the skb offset:
>  	 * mptcp_subflow_get_mapped_dsn() is based on the current tp->copied_seq
> -	 * value
> +	 * value; note that end seq number is only available in 32bits format.
>  	 */
> -	MPTCP_SKB_CB(skb)->map_seq =3D mptcp_subflow_get_mapped_dsn(subflow) -
> -				     offset;
> +	MPTCP_SKB_CB(skb)->map_seq64 =3D mptcp_subflow_get_mapped_dsn(subflow) -
> +				       offset;
> +	MPTCP_SKB_CB(skb)->map_seq =3D (u32)MPTCP_SKB_CB(skb)->map_seq64;
>  	MPTCP_SKB_CB(skb)->end_seq =3D MPTCP_SKB_CB(skb)->map_seq + copy_len;
>  	MPTCP_SKB_CB(skb)->flags =3D offset ? MPTCP_SKB_CB_F_OFFSET : 0;
>  	MPTCP_SKB_CB(skb)->has_rxtstamp =3D has_rxtstamp;

[Severity: High]
Can comparing against MPTCP_SKB_CB(skb)->map_seq instead of
(u32)mptcp_dsn(skb) in mptcp_data_queue_ofo() and mptcp_prune_ofo_queue()
drop valid out-of-order segments or corrupt the RB-tree ordering?

mptcp_init_skb() subtracts offset from map_seq64 and map_seq, so for any
out-of-order skb with a non-zero subflow offset (for example, when a
subflow skb spans two DSS mappings and the first mapping was already
discarded), MPTCP_SKB_CB(skb1)->map_seq is (u32)mptcp_dsn(skb1) - offset
rather than the starting DSN of the mapped payload.

When a subsequent segment arrives covering the preceding range
[mptcp_dsn(skb1) - offset, mptcp_dsn(skb1)), its seq ((u32)mptcp_dsn(skb))
is not before MPTCP_SKB_CB(skb1)->map_seq.  In mptcp_data_queue_ofo(), it
misses the rb_left branch and is either falsely dropped as duplicate data
(if end_seq <=3D mptcp_end_dsn(skb1)) or inserted into the right subtree of
skb1 despite having a smaller DSN (if end_seq > mptcp_end_dsn(skb1)),
stalling the connection once msk->ack_seq reaches the missing range.
mptcp_prune_ofo_queue() likewise compares raw map_seq values instead of
(u32)mptcp_dsn().

[ ... ]

> @@ -2212,7 +2214,7 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, st=
ruct msghdr *msg,
>  	int copied =3D 0;
> =20
>  	skb_queue_walk_safe(&sk->sk_receive_queue, skb, tmp) {
> -		u64 offset =3D *seq - MPTCP_SKB_CB(skb)->map_seq;
> +		u32 offset =3D (u32)(*seq) - MPTCP_SKB_CB(skb)->map_seq;
>  		u32 data_len =3D skb->len - offset;
>  		u32 count;
>  		int err;
> @@ -4635,7 +4637,7 @@ static struct sk_buff *mptcp_recv_skb(struct sock *=
sk, u32 *off)
>  		mptcp_move_skbs(sk);
> =20
>  	while ((skb =3D skb_peek(&sk->sk_receive_queue)) !=3D NULL) {
> -		offset =3D msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq;
> +		offset =3D (u32)msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq;
>  		if (offset < skb->len) {
>  			*off =3D offset;
>  			return skb;

[Severity: Medium]
Can offset underflow in __mptcp_recvmsg_mskq() and mptcp_recv_skb() if a
peer sends mapped data at or after DATA_FIN?

When mptcp_check_data_fin() processes an incoming DATA_FIN at
rcv_data_fin_seq, it advances msk->ack_seq to rcv_data_fin_seq + 1 without
advancing msk->copied_seq:

net/mptcp/protocol.c:mptcp_check_data_fin() {
    ...
	if (mptcp_pending_data_fin(sk, &rcv_data_fin_seq)) {
		WRITE_ONCE(msk->ack_seq, msk->ack_seq + 1);
		WRITE_ONCE(msk->rcv_data_fin, 0);

		WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | RCV_SHUTDOWN);
    ...
}

Because __mptcp_move_skb() does not reject segments after DATA_FIN, a
subsequent segment with dsn =3D=3D rcv_data_fin_seq + 1 matches
dsn =3D=3D msk->ack_seq, increments msk->bytes_received, and is queued to
sk->sk_receive_queue with map_seq =3D=3D (u32)(rcv_data_fin_seq + 1).  When
__mptcp_recvmsg_mskq() or mptcp_recv_skb() inspects that skb with
msk->copied_seq =3D=3D rcv_data_fin_seq, offset underflows to 0xffffffff >=
=3D
skb->len and mptcp_eat_recv_skb() frees the skb without updating
msk->bytes_consumed, leaving mptcp_data_avail(msk) permanently non-zero
and causing __mptcp_close() to trigger mptcp_do_fastclose().

If the post-DATA_FIN segment instead starts at rcv_data_fin_seq with its
first byte discarded by mptcp_subflow_discard_data() (offset =3D=3D 1 in
mptcp_init_skb()), map_seq equals (u32)rcv_data_fin_seq, so offset in
__mptcp_recvmsg_mskq() evaluates to 0 instead of 1 and copies the
discarded prefix byte to userspace.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794663678.gi=
t.tanggeliang@kylinos.cn?part=3D7
