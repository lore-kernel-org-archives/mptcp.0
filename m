Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793351327;
	b=k1xtX1om75sR71i0QXqhwc54U/g2o5burErNR312MbxyLilwFan/LHg2Bsgvc/+Jbv52
	 1eFvYbhcTnIJ6jSuY/R8AX/G6VT9NL9AQGAM/xxE4Aeiw/GpmrWxIjqGA8iuOB9Gttna7
	 xwhiAH+8MmhDXAXP1fWgBNQ04Vgm6pSrGhAXYVeTttH+WYJafqDlSn+rRZiVUHvVR+jn0
	 8wxBKUrUZGCwJwuG5dOn27MIxiyyf1teBzjka6oTlJRJgyuvxoSdbe0BJq9Qukad+lrpj
	 0Ed7TrKg8m+Xlmwb6NIB1POYDZ/q/0OXbUAs78L2wJ7wwZhqG/h+7wV+izUQcdxmfSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793351327;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=II1B+lWml+JTxr1sZjLRJsRYCTLTzIrPb6sLkfobFR0=;
	b=Fiyh9YoQMFmVx4/inBuW/NSosrM95SVzPuTQF0er4ZMIDGhdYzt6AWrQONAjje6vRucY
	 LF4bvsBGkyrh451sFwf3pLRvqf388iKBOJuhzh5GlqP4VUfXdTl/hSUiucLoe38ATk1B2
	 RzINjoQZBVYogGSC78v/qaGBcAvO1q4aNkXX2VB68WFl21BQzUg3boaRzxNO1QlQ+M+cJ
	 AVdhSDVL1Kj1njpmuXH3hmSqerUyUPDnmziVwV42oilwmuCRNc1kmy8Owxf1vWQCQCx2d
	 SzTuEJNydwYFQlg1YdrIrBUZZnWSaS5+lu9Jo4zJ09UnTSXCW8DpFVgDK+j1ZlPIEHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A3ZTEuDq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCB8606A31C
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 09:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A3ZTEuDq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A861F000C1;
	Fri, 30 Oct 2026 09:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793351327;
	bh=II1B+lWml+JTxr1sZjLRJsRYCTLTzIrPb6sLkfobFR0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=A3ZTEuDqWSamQjHlXkNEIa/2BjS8YcerCOK5qWR4N1vOr1tJBLvqCN0DDTDzP2xj1
	 +tp/VCCHJdDBHS1NQg8p4R3u2ecqwhgvDafuIKKGPpNFirZXKcHuf4uOTHzIoCSTpQ
	 Ez+KIPyQ4xNpep377KuYWusGmADu1oZcv43pjASLaLRtt7x4dD28TTOTmhoz/z5oN8
	 MIFAqxz38Uu+GnQXHx2kkF36DI2OT/C6FYfhMcK4rm9SmJznes2Xx3iXLUOGcOuf2F
	 WnUdM75BCZKnY7KY0wn6PbAxwLI4uznkTyitiokDGx6JgV1rCYS/OSDZc7ukpW3hFx
	 2MWJMLLiWJ2/w==
Message-ID: <sashiko-outbox-190736@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v18 5/5] mptcp: defer read_sock cleanup to
 mptcp_worker
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <b6e4ed70642e2f86c041381cea810db82116b836.1793349369.git.geliang@kernel.org>
References: <cover.1793349369.git.geliang@kernel.org>
 <b6e4ed70642e2f86c041381cea810db82116b836.1793349369.git.geliang@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 09:08:45 +0000
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

commit 68366c7579c4f5b2392dcf76c7e487086dcb48df
Author: Paolo Abeni <pabeni@redhat.com>

mptcp: defer read_sock cleanup to mptcp_worker

This series replaces the MPTCP SKB control buffer offset tracking with
msk->copied_seq, aligns struct mptcp_skb_cb with struct tcp_skb_cb using
32-bit sequence numbers, and defers __mptcp_read_sock() receive buffer
cleanup to mptcp_worker().

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 02a4f479d9d8c..a59247495987a 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -424,21 +421,21 @@ static void mptcp_data_queue_ofo(struct mptcp_sock =
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
> @@ -446,15 +443,40 @@ static void mptcp_init_skb(struct sock *ssk, struct=
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
> @@ -472,18 +494,14 @@ static bool __mptcp_move_skb(struct sock *sk, struc=
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
When __mptcp_move_skbs_from_subflow() passes a non-zero offset to
mptcp_init_skb() (for example, when the leading offset bytes of skb on
ssk->sk_receive_queue belonged to a prior or duplicate DSS mapping that was
already consumed or discarded via subflow_check_data_avail() ->
mptcp_subflow_discard_data()), mptcp_init_skb() subtracts offset from
mptcp_subflow_get_mapped_dsn(subflow):

	MPTCP_SKB_CB(skb)->map_seq64 =3D mptcp_subflow_get_mapped_dsn(subflow) -
				       offset;
	MPTCP_SKB_CB(skb)->map_seq =3D (u32)MPTCP_SKB_CB(skb)->map_seq64;
	MPTCP_SKB_CB(skb)->end_seq =3D MPTCP_SKB_CB(skb)->map_seq + skb->len;

If the new DSS mapping starting at offset has mapped_dsn > msk->ack_seq
(out-of-order at the MPTCP level because the range [msk->ack_seq, mapped_ds=
n)
is still in flight on another subflow), doesn't subtracting offset assign t=
he
DSN range [mapped_dsn - offset, mapped_dsn) to the already-discarded bytes
0..offset of skb?

Specifically, in __mptcp_move_skb():

1. When mapped_dsn - offset <=3D msk->ack_seq < mapped_dsn, __mptcp_move_sk=
b()
sees map_seq64 <=3D msk->ack_seq and map_seq64 + skb->len > msk->ack_seq.
Instead of queueing skb to msk->out_of_order_queue, it takes the in-sequence
or partial-packet insert path, advances msk->ack_seq across the unreceived
DSN gap, and causes __mptcp_recvmsg_mskq() to copy the stale subflow bytes =
at
0..offset to user-space.

2. When mapped_dsn - offset > msk->ack_seq, __mptcp_move_skb() queues skb i=
nto
msk->out_of_order_queue with map_seq =3D mapped_dsn - offset, so
mptcp_data_queue_ofo() and __mptcp_ofo_queue() treat bytes 0..offset as val=
id
data for [mapped_dsn - offset, mapped_dsn) and drop the real segments arriv=
ing
on other subflows as duplicate data.

Can this corrupt the MPTCP receive stream when an out-of-order subflow SKB =
has
a non-zero offset?

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 78e886b202585..899ffaba0b2b6 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -515,6 +515,8 @@ static void subflow_set_remote_key(struct mptcp_sock =
*msk,
>  				   struct mptcp_subflow_context *subflow,
>  				   const struct mptcp_options_received *mp_opt)
>  {
> +	struct sock *sk =3D (struct sock *)msk;
> +
>  	/* active MPC subflow will reach here multiple times:
>  	 * at subflow_finish_connect() time and at 4th ack time
>  	 */
> @@ -533,6 +535,13 @@ static void subflow_set_remote_key(struct mptcp_sock=
 *msk,
>  	WRITE_ONCE(msk->ack_seq, subflow->iasn);
>  	WRITE_ONCE(msk->can_ack, true);
>  	atomic64_set(&msk->rcv_wnd_sent, subflow->iasn);
> +
> +	if (!sock_owned_by_user(sk)) {
> +		msk->copied_seq +=3D subflow->iasn;
> +		__mptcp_sync_rcv_sequence(sk);
> +	} else {
> +		set_bit(MPTCP_SYNC_SEQ, &msk->cb_flags);
> +	}
>  }

[Severity: High]
When subflow_set_remote_key() runs in BH context while sock_owned_by_user(s=
k)
is true, msk->ack_seq is updated immediately to subflow->iasn while updating
msk->copied_seq is deferred via MPTCP_SYNC_SEQ until mptcp_release_cb().
Could leaving msk->copied_seq unsynchronized while the user holds the socket
lock cause several issues?

First, in net/mptcp/protocol.c:mptcp_recvmsg():

		bytes_read =3D __mptcp_recvmsg_mskq(sk, msg, len - copied, flags,
						  seq, &tss, &cmsg_flags,
						  &last);
		...
		if (!list_empty(&msk->backlog_list) && mptcp_move_skbs(sk)) {
			if (flags & MSG_PEEK)
				peek_seq =3D msk->copied_seq + copied;
			continue;
		}

If payload arrives with or right after the MP_CAPABLE packet while the user
holds lock_sock(sk) in mptcp_recvmsg(), mptcp_data_ready() queues the
IASN-based SKBs onto msk->backlog_list. Before release_sock(sk) and
mptcp_release_cb() run, mptcp_recvmsg() calls mptcp_move_skbs(sk) and
continues to the next iteration of __mptcp_recvmsg_mskq(). Inside
mptcp_move_skbs() -> __mptcp_move_skb(), __mptcp_sync_rcv_sequence(sk) upda=
tes
any TFO SKB in sk->sk_receive_queue to the IASN sequence space and clears
msk->rcvd_dummy_seq, and queues the new IASN-based SKBs onto
sk->sk_receive_queue, while MPTCP_SYNC_SEQ is still pending and
msk->copied_seq has not been advanced by subflow->iasn.

On the next iteration, __mptcp_recvmsg_mskq() computes:

		u32 offset =3D (u32)(*seq) - MPTCP_SKB_CB(skb)->map_seq;

using the unsynchronized msk->copied_seq against the IASN-based map_seq. Wh=
en
offset >=3D skb->len, __mptcp_recvmsg_mskq() treats the unread SKB as
already-peeked data, sets *last =3D skb, and skips it; sk_wait_data(sk, &ti=
meo,
last) then blocks waiting for skb_peek_tail(&sk->sk_receive_queue) !=3D last
even after release_sock(sk) runs MPTCP_SYNC_SEQ, stalling the reader with
unread data in the queue. When offset < skb->len, __mptcp_recvmsg_mskq()
copies from a bogus offset inside skb and eats the remainder.

Second, any call to mptcp_inq_hint(sk) while MPTCP_SYNC_SEQ is pending (via
mptcp_ioctl() for SIOCINQ, mptcp_recvmsg() for TCP_CM_INQ, or
mptcp_rcv_space_adjust()) subtracts the unsynchronized msk->copied_seq from
the IASN-based msk->ack_seq and returns INT_MAX.

Third, in net/mptcp/protocol.c:mptcp_release_cb():

	do {
		...
		if (__mptcp_move_skbs(sk))
			need_push =3D true;
		...
	} while (!list_empty(&msk->backlog_list));

	if (need_push)
		__mptcp_push_pending(sk, 0);

	if (msk->cb_flags) {
		...
		if (__test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags)) {
			msk->copied_seq +=3D mptcp_iasn(msk);
			__mptcp_sync_rcv_sequence(sk);
		}
	}

Because __mptcp_move_skbs(sk) runs before MPTCP_SYNC_SEQ is handled, if a
spooled backlog SKB carries a DATA_FIN (arriving with or right after the 3rd
ACK while the user holds lock_sock(sk)), __mptcp_move_skbs() ->
mptcp_check_data_fin() increments msk->ack_seq by 1 without incrementing
msk->bytes_received, causing mptcp_iasn(msk) to shift msk->copied_seq one b=
yte
past the real IASN.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793349369.gi=
t.geliang@kernel.org?part=3D5
