Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793365018;
	b=pLz89y9xxMDTyqcBDNd204vqNfNuzdmE7ZxCTpYh0YUIxPVtf86k3iT0Ef/kxs82R8fs
	 ZLW/XGTrk7hQP97FH9qUXwNekpXQbkNc0rGSn0+rf90nZrzG7IaYKIPjWkvsHkOVGG3gN
	 sUYCyU1zKMZ3LngCZthZazD9vtDkPz9e2JPytBRtDeSc5/1XWgDkeNY9mW5r3pKER+bUY
	 wCrs7tKLmpY9OmQRnmepKqrA8k95ZJ+berHJxW5b9umz6iq7vlmxrRHGuTY45DQw9EQdT
	 1FudmM/v2Z5e5WCSqmQqifmU7ljkrjHymtaiOPBMeSAaeOmN0QrCIG/eJBFiQlJl0xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793365018;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oYOa7N78/qqY0tBF3dbyai+XpIiC5snNyJSlUt4U5N4=;
	b=gWrOXNkb+vJXI4Uro3+puOUqscdI13AcSsXpvWS1ic2WYfvjdIyaaRC8eg1Sg+Xpjg9l
	 EgxuLKlZTsflBuGGQFFK2O4EWp9dHqq2B6ZifLYSBJFiH++qdpq7cIrYxlxPdXYDLG9WS
	 7xdbzLJ85+8Dzj3cQhjbfu9khRYQdnOWtAHILh5qVqusHeFR0b9Gk/5x1dyAmTKZLY0qH
	 pwn4Bp4ekcsXU9DGvx5b5Q+sL3EbcvH+f0csszWQAM3vekppvl6neG+AhGM5z2z62nJRU
	 h3QF4v0KsuX55ZyCACFvDIOQjUhN2sGZL62I/HQNYHcxyhu3XLH0MO3c3DfacRlTT4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RL4upPei;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E8D606A31A
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 12:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RL4upPei
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF801F000C1;
	Fri, 30 Oct 2026 12:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793365018;
	bh=oYOa7N78/qqY0tBF3dbyai+XpIiC5snNyJSlUt4U5N4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=RL4upPeiBJsX6wpoxmJm8uUz+nkVuc7HAVpV+6NMf7tCmA1rQX1u050zRHA9QYmwV
	 Gy+ZEHWLP/ztqTqnhxVkppXEdt7VzWEVT5MpfmJIu3ML7aHNBOvBot2GQaX9d3VKzc
	 0fBDr8Z+6qzvwDcn5PfAWT9nlixyCRurhMJjQFlzsybxzET1sDB0wIZV8sMPJrFIf6
	 xvBnQ/yHbuh8E7zoazIhZX59GcHcOw4YOlKiQ0p1r+vMTcfWnL1oGcFD0RYtKTHguV
	 LT5BBUOXzF35u3HkLbasy1l1JmI+Ey6MIkhh5P3g7p0rX9LPmob6JZxe2DrthzlLcY
	 qlFyELVtZhsdA==
Message-ID: <sashiko-outbox-191040@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v19 5/5] mptcp: defer read_sock cleanup to
 mptcp_worker
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <90a300d74f44443759ebe14be70c07385267db5b.1793361629.git.tanggeliang@kylinos.cn>
References: <cover.1793361629.git.tanggeliang@kylinos.cn>
 <90a300d74f44443759ebe14be70c07385267db5b.1793361629.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 12:56:57 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] mptcp: unsynchronized copied_seq when MPTCP_SYNC_SEQ is deferred
- [High] mptcp: wrong map_seq64 in mptcp_init_skb() on non-zero skb offset
--

commit 1033c608c403db5f17f6be77476b0bb66333000f
Author: Geliang Tang <geliang@kernel.org>

mptcp: defer read_sock cleanup to mptcp_worker

This series reworks MPTCP receive sequence tracking to use msk->copied_seq =
and
32-bit SKB control block sequence numbers aligned with TCP, and defers
__mptcp_read_sock() receive buffer autotuning and cleanup to mptcp_worker().

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 02a4f479d9d8c..13078f2f3c498 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -424,21 +423,21 @@ static void mptcp_data_queue_ofo(struct mptcp_sock =
*msk, struct sk_buff *skb)
>  	skb_set_owner_r(skb, sk);
>  }
> =20
> -static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int of=
fset,
> -			   int copy_len)
> +static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int of=
fset)
>  {
>  	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
>  	bool has_rxtstamp =3D TCP_SKB_CB(skb)->has_rxtstamp;
> =20
>  	/* the skb map_seq accounts for the skb offset:
>  	 * mptcp_subflow_get_mapped_dsn() is based on the current tp->copied_seq
> -	 * value
> +	 * value; note that end seq number is only available in 32bits format.
>  	 */
> -	MPTCP_SKB_CB(skb)->map_seq =3D mptcp_subflow_get_mapped_dsn(subflow);
> -	MPTCP_SKB_CB(skb)->end_seq =3D MPTCP_SKB_CB(skb)->map_seq + copy_len;
> -	MPTCP_SKB_CB(skb)->offset =3D offset;
> +	MPTCP_SKB_CB(skb)->map_seq64 =3D mptcp_subflow_get_mapped_dsn(subflow) -
> +				       offset;
> +	MPTCP_SKB_CB(skb)->map_seq =3D (u32)MPTCP_SKB_CB(skb)->map_seq64;
> +	MPTCP_SKB_CB(skb)->end_seq =3D MPTCP_SKB_CB(skb)->map_seq + skb->len;
> +	MPTCP_SKB_CB(skb)->flags =3D 0;
>  	MPTCP_SKB_CB(skb)->has_rxtstamp =3D has_rxtstamp;
> -	MPTCP_SKB_CB(skb)->cant_coalesce =3D 0;
> =20
>  	__skb_unlink(skb, &ssk->sk_receive_queue);
> =20
> @@ -446,15 +445,40 @@ static void mptcp_init_skb(struct sock *ssk, struct=
 sk_buff *skb, int offset,
>  	skb_dst_drop(skb);
>  }

[ ... ]

>  static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
>  {
> -	u64 copy_len =3D MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_se=
q;
> +	u32 copy_len =3D MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_se=
q;
>  	struct mptcp_sock *msk =3D mptcp_sk(sk);
>  	struct sk_buff *tail;
> =20
>  	mptcp_borrow_fwdmem(sk, skb);
> =20
> -	if (MPTCP_SKB_CB(skb)->map_seq =3D=3D msk->ack_seq) {
> +	/* Be sure to sync the eventual fastopen dummy mapping before any other
> +	 * skb lands into the msk.
> +	 */
> +	if (unlikely(msk->rcvd_dummy_seq))
> +		__mptcp_sync_rcv_sequence(sk);
> +
> +	if (MPTCP_SKB_CB(skb)->map_seq64 =3D=3D msk->ack_seq) {
>  		/* in sequence */
>  insert:
>  		if (!mptcp_try_rmem_schedule(sk, skb)) {
> @@ -472,18 +496,14 @@ static bool __mptcp_move_skb(struct sock *sk, struc=
t sk_buff *skb)
>  		skb_set_owner_r(skb, sk);
>  		__skb_queue_tail(&sk->sk_receive_queue, skb);
>  		return true;
> -	} else if (after64(MPTCP_SKB_CB(skb)->map_seq, msk->ack_seq)) {
> +	} else if (after64(MPTCP_SKB_CB(skb)->map_seq64, msk->ack_seq)) {
>  		mptcp_data_queue_ofo(msk, skb);
>  		return false;
>  	}
> =20
>  	/* Partial packet */
> -	if (after64(MPTCP_SKB_CB(skb)->end_seq, msk->ack_seq)) {
> -		copy_len =3D MPTCP_SKB_CB(skb)->end_seq - msk->ack_seq;
> -		MPTCP_SKB_CB(skb)->offset +=3D msk->ack_seq -
> -					     MPTCP_SKB_CB(skb)->map_seq;
> -		MPTCP_SKB_CB(skb)->map_seq +=3D msk->ack_seq -
> -					      MPTCP_SKB_CB(skb)->map_seq;
> +	if (after64(MPTCP_SKB_CB(skb)->map_seq64 + skb->len, msk->ack_seq)) {
> +		copy_len =3D MPTCP_SKB_CB(skb)->end_seq - (u32)msk->ack_seq;
>  		goto insert;
>  	}

[Severity: High]
As reported by Sashiko on v18 [1], can subtracting offset from
mptcp_subflow_get_mapped_dsn(subflow) in mptcp_init_skb() corrupt the recei=
ve
stream when an out-of-order subflow skb has a non-zero offset?

In __mptcp_move_skbs_from_subflow(), offset =3D seq - TCP_SKB_CB(skb)->seq =
is
non-zero when the leading offset bytes of skb on ssk->sk_receive_queue were
already consumed or discarded (for instance, when skb spans the end of a
duplicate DSS mapping discarded by mptcp_subflow_discard_data() in
subflow_check_data_avail() and the start of a new DSS mapping at
tp->copied_seq).

Setting MPTCP_SKB_CB(skb)->map_seq64 =3D mptcp_subflow_get_mapped_dsn(subfl=
ow) -
offset assigns DSNs [mapped_dsn - offset, mapped_dsn) to those already
discarded leading bytes 0..offset of skb.

When the new DSS mapping starting at offset is out-of-order at the MPTCP le=
vel
(mapped_dsn > msk->ack_seq because the intervening DSN range
[msk->ack_seq, mapped_dsn) is in flight on another subflow):

1. If mapped_dsn - offset <=3D msk->ack_seq < mapped_dsn, __mptcp_move_skb()
sees map_seq64 <=3D msk->ack_seq and map_seq64 + skb->len > msk->ack_seq. It
treats the out-of-order skb as in-sequence or a partial packet, queues it
onto sk->sk_receive_queue, and advances msk->ack_seq across the missing DSN
gap [msk->ack_seq, mapped_dsn), causing __mptcp_recvmsg_mskq() or
mptcp_recv_skb() to copy the stale leading bytes in 0..offset to user space.

2. If mapped_dsn - offset > msk->ack_seq, __mptcp_move_skb() queues skb into
msk->out_of_order_queue with map_seq =3D mapped_dsn - offset, so
mptcp_data_queue_ofo() and __mptcp_ofo_queue() treat bytes 0..offset as val=
id
data for [mapped_dsn - offset, mapped_dsn) and drop the real segments arriv=
ing
on other subflows as duplicate data.

[ ... ]

> @@ -2383,6 +2386,11 @@ static bool mptcp_move_skbs(struct sock *sk)
>  	bool enqueued =3D false;
>  	u32 moved =3D 0;
> =20
> +	if (test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags)) {
> +		msk->copied_seq +=3D msk->tfo_iasn;
> +		__mptcp_sync_rcv_sequence(sk);
> +	}
> +
>  	mptcp_data_lock(sk);
>  	while (mptcp_can_spool_backlog(sk, &skbs)) {
>  		mptcp_data_unlock(sk);
> @@ -2402,22 +2410,17 @@ static bool mptcp_move_skbs(struct sock *sk)
>  static unsigned int mptcp_inq_hint(const struct sock *sk)
>  {
>  	const struct mptcp_sock *msk =3D mptcp_sk(sk);
> -	const struct sk_buff *skb;
> +	u64 hint_val;
> =20
> -	skb =3D skb_peek(&sk->sk_receive_queue);
> -	if (skb) {
> -		u64 hint_val =3D READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
> +	hint_val =3D READ_ONCE(msk->ack_seq) - READ_ONCE(msk->copied_seq);
> +	if (hint_val >=3D INT_MAX)
> +		return INT_MAX;
> =20
> -		if (hint_val >=3D INT_MAX)
> -			return INT_MAX;
> -
> -		return (unsigned int)hint_val;
> -	}
> -
> -	if (sk->sk_state =3D=3D TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN))
> +	if (!hint_val &&
> +	    (sk->sk_state =3D=3D TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN)))
>  		return 1;
> =20
> -	return 0;
> +	return (unsigned int)hint_val;
>  }
> =20
>  static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,

[ ... ]

> @@ -2463,8 +2472,11 @@ static int mptcp_recvmsg(struct sock *sk, struct m=
sghdr *msg, size_t len,
> =20
>  		copied +=3D bytes_read;
> =20
> -		if (!list_empty(&msk->backlog_list) && mptcp_move_skbs(sk))
> +		if (!list_empty(&msk->backlog_list) && mptcp_move_skbs(sk)) {
> +			if (flags & MSG_PEEK)
> +				peek_seq =3D msk->copied_seq + copied;
>  			continue;
> +		}

[Severity: High]
As reported by Sashiko on v18 [2], can deferring the msk->copied_seq update
via MPTCP_SYNC_SEQ leave msk->copied_seq out of sync with msk->ack_seq and
sk->sk_receive_queue while the socket lock is held?

In subflow_set_remote_key() in net/mptcp/subflow.c, when the remote key and
IASN arrive in BH context while sock_owned_by_user(sk) is true, msk->ack_seq
is updated immediately to subflow->iasn while updating msk->copied_seq is
deferred:

	WRITE_ONCE(msk->ack_seq, subflow->iasn);
	WRITE_ONCE(msk->can_ack, true);
	atomic64_set(&msk->rcv_wnd_sent, subflow->iasn);
	msk->tfo_iasn =3D subflow->iasn;

	if (!sock_owned_by_user(sk)) {
		msk->copied_seq +=3D subflow->iasn;
		__mptcp_sync_rcv_sequence(sk);
	} else {
		set_bit(MPTCP_SYNC_SEQ, &msk->cb_flags);
	}

This appears to leave several paths with an unsynchronized msk->copied_seq:

1. In mptcp_move_skbs(), test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags)=
 is
checked only once before mptcp_data_lock(sk) rather than inside the
while (mptcp_can_spool_backlog(sk, &skbs)) loop. If the 3rd ACK and payload
arrive in BH after that initial check or while mptcp_data_lock(sk) is dropp=
ed
around __mptcp_move_skbs(), the next iteration of the loop spools the new s=
kb
via __mptcp_move_skb(), which calls __mptcp_sync_rcv_sequence(sk) (updating
the TFO skb in sk->sk_receive_queue to the IASN sequence space and clearing
msk->rcvd_dummy_seq) and queues the new IASN-based skb while msk->copied_seq
remains unsynchronized for the next iteration of mptcp_recvmsg().

2. While MPTCP_SYNC_SEQ is pending, mptcp_inq_hint() subtracts the
pre-IASN msk->copied_seq from the IASN-based msk->ack_seq and returns INT_M=
AX.
In mptcp_recvmsg(), if the 3rd ACK or SYN-ACK arrives without payload while
lock_sock(sk) is held, msk->backlog_list is empty so mptcp_move_skbs() is n=
ot
called; both mptcp_rcv_space_adjust() and the TCP_CM_INQ cmsg calculation r=
un
before release_sock(sk) and observe INT_MAX from mptcp_inq_hint(sk). Simila=
rly,
in mptcp_ioctl() for SIOCINQ, if the remote key arrives in BH after
mptcp_move_skbs() checks MPTCP_SYNC_SEQ and before mptcp_inq_hint(sk), SIOC=
INQ
returns INT_MAX.

3. In mptcp_recvmsg(), when flags & MSG_PEEK is set and mptcp_move_skbs(sk)
consumes MPTCP_SYNC_SEQ (updating msk->copied_seq and the TFO skb map_seq) =
but
returns false because the backlog skb was out-of-order or dropped, peek_seq=
 is
only updated inside the if (mptcp_move_skbs(sk)) branch and remains stale if
the loop continues without sleeping.

[1] https://lore.kernel.org/r/b6e4ed70642e2f86c041381cea810db82116b836.1793=
349369.git.geliang@kernel.org
[2] https://lore.kernel.org/r/b6e4ed70642e2f86c041381cea810db82116b836.1793=
349369.git.geliang@kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793361629.gi=
t.tanggeliang@kylinos.cn?part=3D5
