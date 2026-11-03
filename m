Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704110;
	b=2Myr4540rgaxRwLNFoyM0Cbm+iTCw9ZZakiaMfr+djVIhExlByjY0xBCe/LFteEFHbv4
	 194Koscf7bAHfmhH9BlaGbuGDvwIjdlDGitpQn4a0F5ngRa8dtRr7bBx9t9ej+jtUGdgl
	 O87gRme8f71UzLINBworudXlG1L7xcGHQibgJN7cz2+tmXUHORfJJpeVpjcn9882M2D+f
	 YC8xPME3DY4goUYllHPiGwZy2so1obt1L/V5L19Mn3Z5UhWw2oh0rV+0SVfx05NjB625a
	 m2rXIs/5WA//gC0perkI9RgO5vVe9/gKm7y/S9JYMs4XtyRJPwGTytC6O3WspXnc6DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704110;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EmrQEDyP1TWjI+8EeQGWOr11fiq6UxGbr7QjBWJ5c0E=;
	b=mBZq3qg/x2p3oK49MZvfQ3tHGhu9hg5fOp10kqqKaymI6/5kVf3hZ6O3k8ZK6tdv51z9
	 Dxl40tsDInOR8bIEtIcs+ci03DklQqkrvUxNZ4488SpBZskrZ4uiLKYTW8ntObaGCaDqp
	 N6H8GP4fM18aOw9e5dplK3az1fKoLx5pl0pjPDXqtrxknN4SDO9MnxvU4WQHIZsrWCrI9
	 rRi2J3CiN+SNfizI38blcksUAQJ28Mzgqy66+dT6J5ApP0dAVuQoY0vCzOSYkdkk7e4nF
	 TMz3AygeWmYCDzkIaj7UElyiIAJ0svYrfbh4BonTxQGf8Kt/Dub323FlqDCvW4vyoIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eL7rUcdH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A328D606A830
	for <mptcp@lists.linux.dev>; Tue,  3 Nov 2026 11:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eL7rUcdH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6311C1F000C1;
	Tue,  3 Nov 2026 11:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793704109;
	bh=EmrQEDyP1TWjI+8EeQGWOr11fiq6UxGbr7QjBWJ5c0E=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=eL7rUcdH68sdHL/byY9W4CZflFQHUP++AxcFWykwssegiaWEbCvQXurX77nJFT+hb
	 s+H8jUKiFBm3eMJcmeTQUuU4OhLkXNB0lOUK5uWt51gkEbP5Nf4B1ddbsVk74NmDGX
	 5O4FpmdMERNpijxeRaqmc8Hslc+gDwIvV37Kox9CsslQCyvP5urRi5b93SLRlzIKFL
	 tGlDRYmepS2bFdQYmjneDJ1pNpbyqDjCiV83iVIpBH/b8KHPpPPjZ4lhDygSYLK5pF
	 pbRlrwqZS0zRFdIMVXtco8k/No2vRSJk9Y5JV7J4jlXWSaAYmIxFOoDP6z/9zSErqF
	 J6h7vh+d66WPQ==
Message-ID: <sashiko-outbox-195115@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v20 6/6] mptcp: defer read_sock cleanup to
 mptcp_worker
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <278ffcf759c109e3753112e62cb7c53b58159650.1793695518.git.tanggeliang@kylinos.cn>
References: <cover.1793695518.git.tanggeliang@kylinos.cn>
 <278ffcf759c109e3753112e62cb7c53b58159650.1793695518.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 11:08:28 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] mptcp: broken mptcp_inq_hint() 32-bit map_seq subtraction and MSG_=
PEEK sync
- [High] mptcp: data corruption in mptcp_init_skb() when subtracting non-ze=
ro offset
- [Medium] mptcp: link failure in __mptcp_read_sock() when CONFIG_LOCKDEP=
=3Dn
- [Low] mptcp: redundant mptcp_recv_skb() call retained in __mptcp_read_soc=
k()
--

commit db7d508291f7183730bd0d3c5939151c2b4d01c3
Author: Geliang Tang <geliang@kernel.org>

mptcp: defer read_sock cleanup to mptcp_worker

This commit defers mptcp_rcv_space_adjust() and mptcp_cleanup_rbuf() from
__mptcp_read_sock() to mptcp_worker() via MPTCP_WORK_READ_COMPLETE when cal=
led
in BH context, while keeping cleanup inline when the user owns the socket
lock. It also updates the socket lock check in __mptcp_read_sock() and remo=
ves
the backlog flush from mptcp_recv_skb().

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 3e10b06b7772d..25f0d10373d22 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3156,6 +3156,21 @@ static void mptcp_backlog_purge(struct sock *sk)
>  	sk_mem_reclaim(sk);
>  }
> =20
> +static void mptcp_read_complete(struct sock *sk)
> +{
> +	struct mptcp_sock *msk =3D mptcp_sk(sk);
> +	int read_copied;
> +
> +	mptcp_data_lock(sk);
> +	read_copied =3D msk->read_copied;
> +	msk->read_copied =3D 0;
> +	mptcp_data_unlock(sk);
> +
> +	mptcp_rcv_space_adjust(msk, read_copied);

[Severity: High]
As reported by Sashiko on v19 [1], does mptcp_rcv_space_adjust() ->
mptcp_inq_hint() break receive buffer autotuning here (as well as SIOCINQ a=
nd
TCP_CM_INQ) due to subtracting the 32-bit MPTCP_SKB_CB(skb)->map_seq from t=
he
64-bit msk->ack_seq?

In commit 698eb6e05455 ("mptcp: remove CB offset field"),
MPTCP_SKB_CB(skb)->map_seq stopped being advanced on partial reads, which
instead advance msk->copied_seq, and commit 0495d49fc957 ("mptcp: sync mptcp
skb cb layout with tcp one") then narrowed MPTCP_SKB_CB(skb)->map_seq from =
u64
to u32:

net/mptcp/protocol.h:
struct mptcp_skb_cb {
	u32 map_seq;
	u32 end_seq;
	u32 unused;
	u16 flags;
	u8  has_rxtstamp;
	u64 map_seq64;
};

However, mptcp_inq_hint() still subtracts MPTCP_SKB_CB(skb)->map_seq from
msk->ack_seq:

net/mptcp/protocol.c:mptcp_inq_hint() {
	skb =3D skb_peek(&sk->sk_receive_queue);
	if (skb) {
		u64 hint_val =3D READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;

		if (hint_val >=3D INT_MAX)
			return INT_MAX;

		return (unsigned int)hint_val;
	}
}

Because MPTCP_SKB_CB(skb)->map_seq is zero-extended from u32 to u64 while
msk->ack_seq is a 64-bit sequence number whose upper 32 bits are non-zero on
nearly all MPTCP connections (or 0 while a passive TFO packet has map_seq =
=3D
(u32)-skb->len), hint_val retains non-zero upper 32 bits and returns INT_MAX
whenever any skb is present in sk->sk_receive_queue. Even when the upper 32
bits of msk->ack_seq happen to be zero, MPTCP_SKB_CB(skb)->map_seq does not
account for bytes already consumed via msk->copied_seq.

In mptcp_rcv_space_adjust(), subtracting INT_MAX causes copied to become
negative and skip mptcp_rcvbuf_grow():

net/mptcp/protocol.c:mptcp_rcv_space_adjust() {
	copied =3D msk->rcvq_space.copied;
	copied -=3D mptcp_inq_hint(sk);
	if (copied <=3D msk->rcvq_space.space)
		goto new_measure;
}

Additionally, in mptcp_recvmsg(), peek_seq is only updated when
mptcp_move_skbs(sk) returns true:

net/mptcp/protocol.c:mptcp_recvmsg() {
		if (!list_empty(&msk->backlog_list) && mptcp_move_skbs(sk)) {
			if (flags & MSG_PEEK)
				peek_seq =3D msk->copied_seq + copied;
			continue;
		}
}

If the third ACK arrives with an out-of-order or duplicate segment while
lock_sock(sk) is held during MSG_PEEK, mptcp_move_skbs(sk) processes
MPTCP_SYNC_SEQ (adding msk->tfo_iasn to msk->copied_seq and updating the TFO
skb map_seq) but returns false, leaving peek_seq unsynchronized in the
pre-IASN sequence space. Should mptcp_inq_hint() subtract msk->copied_seq f=
rom
READ_ONCE(msk->ack_seq), and should mptcp_recvmsg() also resynchronize
peek_seq when MPTCP_SYNC_SEQ runs?

[ ... ]

> @@ -4643,9 +4663,6 @@ static struct sk_buff *mptcp_recv_skb(struct sock *=
sk, u32 *off)
>  	struct sk_buff *skb;
>  	u32 offset;
> =20
> -	if (!list_empty(&msk->backlog_list))
> -		mptcp_move_skbs(sk);
> -
>  	while ((skb =3D skb_peek(&sk->sk_receive_queue)) !=3D NULL) {
>  		offset =3D (u32)msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq;

[Severity: High]
As reported by Sashiko on v19 [2], can subtracting a non-zero subflow offset
in mptcp_init_skb() corrupt data delivery when an out-of-order subflow skb =
has
a discarded prefix?

In subflow_check_data_avail(), when a TCP skb on ssk->sk_receive_queue
contains the tail of an already-acknowledged DSS mapping in bytes 0..offset
and the start of a new DSS mapping at offset (which get_mapping_status()
allows when !skb_is_fully_mapped(ssk, skb)), mptcp_subflow_discard_data()
advances tp->copied_seq by offset, clears subflow->map_valid, and loops to
activate the new DSS mapping on the same skb:

net/mptcp/subflow.c:subflow_check_data_avail() {
		if (unlikely(before64(ack_seq, old_ack))) {
			mptcp_subflow_discard_data(ssk, skb, old_ack - ack_seq);
			continue;
		}
}

When __mptcp_move_skbs_from_subflow() then initializes the skb via
mptcp_init_skb(), it subtracts offset from mptcp_subflow_get_mapped_dsn():

net/mptcp/protocol.c:mptcp_init_skb() {
	MPTCP_SKB_CB(skb)->map_seq64 =3D mptcp_subflow_get_mapped_dsn(subflow) -
				       offset;
	MPTCP_SKB_CB(skb)->map_seq =3D (u32)MPTCP_SKB_CB(skb)->map_seq64;
	MPTCP_SKB_CB(skb)->end_seq =3D MPTCP_SKB_CB(skb)->map_seq + skb->len;
}

Because MPTCP stripes mappings across subflows, the new mapping starting at
offset in skb can have an out-of-order DSN (mapped_dsn > msk->ack_seq) that=
 is
not contiguous with the discarded bytes in 0..offset. Subtracting offset
assigns the unreceived DSN range [mapped_dsn - offset, mapped_dsn) to the
stale discarded prefix in 0..offset:

net/mptcp/protocol.c:__mptcp_move_skb() {
	if (MPTCP_SKB_CB(skb)->map_seq64 =3D=3D msk->ack_seq) {
		/* in sequence */
insert:
...
	} else if (after64(MPTCP_SKB_CB(skb)->map_seq64, msk->ack_seq)) {
		mptcp_data_queue_ofo(msk, skb);
		return false;
	}

	/* Partial packet */
	if (after64(MPTCP_SKB_CB(skb)->map_seq64 + skb->len, msk->ack_seq)) {
		copy_len =3D MPTCP_SKB_CB(skb)->end_seq - (u32)msk->ack_seq;
		goto insert;
	}
}

If mapped_dsn - offset <=3D msk->ack_seq < mapped_dsn, __mptcp_move_skb() s=
ees
map_seq64 <=3D msk->ack_seq, queues the out-of-order skb onto
sk->sk_receive_queue, and advances msk->ack_seq across the missing DSN gap,
causing mptcp_recv_skb() and __mptcp_recvmsg_mskq() to deliver the discarded
prefix bytes from 0..offset to user space. If mapped_dsn - offset >
msk->ack_seq, mptcp_data_queue_ofo() queues the skb into
msk->out_of_order_queue as covering [mapped_dsn - offset, mapped_dsn +
skb->len - offset), dropping legitimate segments for [mapped_dsn - offset,
mapped_dsn) as duplicates and delivering the stale prefix once msk->ack_seq
reaches mapped_dsn - offset.

> @@ -4660,6 +4677,7 @@ static struct sk_buff *mptcp_recv_skb(struct sock *=
sk, u32 *off)
>  /*
>   * Note:
>   *	- It is assumed that the socket was locked by the caller.
> + *	- Can be invoked in BH scope.
>   */
>  static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
>  			     sk_read_actor_t recv_actor, bool noack)
> @@ -4669,7 +4687,7 @@ static int __mptcp_read_sock(struct sock *sk, read_=
descriptor_t *desc,
>  	int copied =3D 0;
>  	u32 offset;
> =20
> -	msk_owned_by_me(msk);
> +	DEBUG_NET_WARN_ON_ONCE(!lockdep_sock_is_held(sk));

[Severity: Medium]
Does replacing msk_owned_by_me(msk) with
DEBUG_NET_WARN_ON_ONCE(!lockdep_sock_is_held(sk)) cause a link failure when
CONFIG_DEBUG_NET=3Dy and CONFIG_LOCKDEP=3Dn?

In include/net/sock.h, lockdep_sock_is_held(sk) calls lockdep_is_held() on
both sk->sk_lock and sk->sk_lock.slock:

include/net/sock.h:lockdep_sock_is_held() {
	return lockdep_is_held(&sk->sk_lock) ||
	       lockdep_is_held(&sk->sk_lock.slock);
}

When CONFIG_LOCKDEP=3Dn, include/linux/lockdep.h only declares lockdep_is_h=
eld()
as a dummy extern prototype with no definition, relying on dead-code
elimination. Because CONFIG_DEBUG_NET does not depend on CONFIG_LOCKDEP,
enabling CONFIG_DEBUG_NET=3Dy with CONFIG_LOCKDEP=3Dn expands
DEBUG_NET_WARN_ON_ONCE(!lockdep_sock_is_held(sk)) to WARN_ON_ONCE() and lea=
ves
an undefined reference to lockdep_is_held at link time.

Note that msk_owned_by_me(msk) calls sock_owned_by_me(sk):

include/net/sock.h:sock_owned_by_me() {
#ifdef CONFIG_LOCKDEP
	WARN_ON_ONCE(!lockdep_sock_is_held(sk) && debug_locks);
#endif
}

Since sock_owned_by_me(sk) already checks lockdep_sock_is_held(sk) for both
process and BH contexts while guarding on CONFIG_LOCKDEP and debug_locks, c=
an
msk_owned_by_me(msk) be kept here as-is?

> =20
>  	if (sk->sk_state =3D=3D TCP_LISTEN)
>  		return -ENOTCONN;
> @@ -4701,11 +4719,18 @@ static int __mptcp_read_sock(struct sock *sk, rea=
d_descriptor_t *desc,
>  	if (noack)
>  		goto out;
> =20
> -	mptcp_rcv_space_adjust(msk, copied);
> -
>  	if (copied > 0) {
> -		mptcp_recv_skb(sk, &offset);
> -		mptcp_cleanup_rbuf(msk, copied);
> +		if (sock_owned_by_user(sk)) {
> +			/* Process context: inline cleanup */
> +			mptcp_rcv_space_adjust(msk, copied);
> +			mptcp_recv_skb(sk, &offset);

[Severity: Low]
The commit message states:

  Also remove the backlog flush from mptcp_recv_skb() (covered by
  mptcp_release_cb()) and drop the redundant mptcp_recv_skb() call after
  the main loop.

Should this mptcp_recv_skb(sk, &offset) call in the sock_owned_by_user(sk)
branch be dropped to match the commit message, since the main loop already
calls mptcp_eat_recv_skb() on fully consumed skbs and mptcp_recv_skb() no
longer flushes msk->backlog_list?

[1] https://lore.kernel.org/r/90a300d74f44443759ebe14be70c07385267db5b.1793=
361629.git.tanggeliang@kylinos.cn
[2] https://lore.kernel.org/r/90a300d74f44443759ebe14be70c07385267db5b.1793=
361629.git.tanggeliang@kylinos.cn

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793695518.gi=
t.tanggeliang@kylinos.cn?part=3D6
