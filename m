Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793363986;
	b=WwxoghOorJmTdCNa5R/C+XWROIK76QQXxlRuWb0e1m5bLP7d6BWH20tIn2PRYq3Jmcq0
	 N2dDDkEpXKBvVErVFxRZM8FTCBQ4eUk+E9pbYl4XLSCsuPsYLxVv4d531heMz12U6KtFC
	 qSvXJv+KMHoUoliCfwGsIusLAkw8hVve1yMV4MeJQPLnH9RDQA0c12OV2DUzvBNLJyiVk
	 oklNRy3B437C6ToQcLJSCKueZ+HlnEACaMQgIRluZOM8MwqmEM+PAdU2/0N3cn1BYAEut
	 VFIDXxHuCAgztE6gpzHKYrz5ETDsZL1Jq3jigqt/cBTXJfHurDsMfZ2p9zcxuBfGkFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793363986;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=97it38aObATBvo3ucm1ZecoKdpetAxfjRXEwAvMrV5M=;
	b=VcdqlrUinbM72bYft00xzgz4QuBtN8nRs1LnnR5qQhyB3049tpZMpCXvrxUbUj367uM2
	 ejZWR7S/yzvOK65joD4/6dUypCT7CR4YnT+Slq/bSWOPa+dqpHtpNfC2mxxu+oGhQOwOp
	 Ry3LFlCOxamAtccCX5my8nvkGIrnV24aFidrdVLVkfz/ORzq/8qi6UgbE3Q32Csc2Yh0L
	 gdkEwVpK6h8FECP0hpW9h9evcIRYYccPPHpsUlzm3A87TQswKLY4jS7ky6w1JbbuulTck
	 y72Qx88qSP6o8yGK9xs3/H9S1JZX0KuBZop8IlSR6bF68qRiOOd+U0dsiYz4DHlOCQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dBkp1g8o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF37606A31C
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 12:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dBkp1g8o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E6F1F000C1;
	Fri, 30 Oct 2026 12:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793363985;
	bh=97it38aObATBvo3ucm1ZecoKdpetAxfjRXEwAvMrV5M=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=dBkp1g8ou/nowWLasaYQcwcRkIDd6VAQiFVtkNSP6U2LP+ptiy5PjH8G8/BfGDxG7
	 Z1ekZmSuGWIu3ucPchNZPpUzEfWH7JPj5FePzJsd+rTAaWNkG6+iztU3LRUICA/LAE
	 83iaSr9vViATdmh5tw8zaAYa9tDphc3snoVcdv2rl1fbcikDI5qNT611znr6AMdfq6
	 DkLl4MYEgKJBNz58tZdT9K/ddjbOGAUzqEAw0vJfKCXEltR96mNZQZvnHPD8pPzVP5
	 /cXv34hcdA37TyCIVUwo4VFxl5AUGo5VqPGBjD+chKaeugqpdr314jDAidjdkaREX6
	 7xyIPXxbL3NzA==
Message-ID: <sashiko-outbox-191020@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v19 4/5] mptcp: sync mptcp skb cb layout with
 tcp one
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <1c928472a89719130041c92cadd7e0fb6dbf552a.1793361629.git.tanggeliang@kylinos.cn>
References: <cover.1793361629.git.tanggeliang@kylinos.cn>
 <1c928472a89719130041c92cadd7e0fb6dbf552a.1793361629.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 12:39:44 +0000
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
- [Critical] mptcp: subtracting offset from map_seq64 in mptcp_init_skb() c=
orrupts OFO data
- [High] mptcp: TFO sequence desync in mptcp_move_skbs() and mptcp_inq_hint=
()
--

commit 078393e5a4729e83b409065c8fc8170a9248094b
Author: Paolo Abeni <pabeni@redhat.com>

mptcp: sync mptcp skb cb layout with tcp one

This commit updates struct mptcp_skb_cb to store 32-bit map_seq and end_seq
fields aligned with struct tcp_skb_cb alongside a 64-bit map_seq64 field, a=
nd
converts receive and out-of-order queue operations to use 32-bit sequence
arithmetic after window validation.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 3f967c4dc825f..3ff07b9de08c0 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -421,11 +430,13 @@ static void mptcp_init_skb(struct sock *ssk, struct=
 sk_buff *skb, int offset)
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
>  	MPTCP_SKB_CB(skb)->end_seq =3D MPTCP_SKB_CB(skb)->map_seq + skb->len;
> +	MPTCP_SKB_CB(skb)->flags =3D 0;
>  	MPTCP_SKB_CB(skb)->has_rxtstamp =3D has_rxtstamp;

[Severity: Critical]
As reported by Sashiko on v18 [1], can subtracting offset from map_seq64 and
map_seq in mptcp_init_skb() corrupt out-of-order data when offset is non-ze=
ro?

In __mptcp_move_skbs_from_subflow(), offset =3D tp->copied_seq -
TCP_SKB_CB(skb)->seq is non-zero when the leading [0, offset) bytes of the
subflow skb were already consumed or discarded (for instance, when an skb
straddles the end of a discarded DSS mapping in subflow_check_data_avail() =
and
the start of the next mapping, or when TCP queues a partially overlapping
segment). In subflow_check_data_avail(), validate_mapping() and
validate_data_csum() only validate the active mapping starting at
tp->copied_seq, which corresponds to mapped_dsn =3D
mptcp_subflow_get_mapped_dsn(subflow).

Subtracting offset from map_seq64 without pulling the leading offset bytes
assumes msk->ack_seq and msk->copied_seq have already reached mapped_dsn,
which only holds for in-order data. When the active mapping is out of order
(mapped_dsn > msk->ack_seq) and offset > 0:

1. If mapped_dsn - offset <=3D msk->ack_seq, __mptcp_move_skb() sees map_se=
q64
   <=3D msk->ack_seq and treats the skb as in-sequence or partial data, que=
ueing
   or coalescing it into sk->sk_receive_queue and advancing msk->ack_seq
   across the unreceived gap [msk->ack_seq, mapped_dsn). Both
   __mptcp_recvmsg_mskq() and mptcp_recv_skb() then compute a read offset of
   (u32)msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq < offset and copy the
   unmapped leading subflow bytes to user space.

2. If mapped_dsn - offset > msk->ack_seq, mptcp_data_queue_ofo() inserts the
   skb into out_of_order_queue covering [mapped_dsn - offset, mapped_dsn +
   skb->len - offset). __mptcp_try_coalesce() can then coalesce those leadi=
ng
   [0, offset) prefix bytes into a preceding OFO skb ending at mapped_dsn -
   offset, legitimate segments arriving for [mapped_dsn - offset, mapped_ds=
n)
   are dropped as MPTCP_MIB_DUPDATA, and __mptcp_ofo_queue() dequeues the s=
kb
   as soon as msk->ack_seq reaches mapped_dsn - offset.

> =20
>  	__skb_unlink(skb, &ssk->sk_receive_queue);
> @@ -448,13 +459,14 @@ void __mptcp_sync_rcv_sequence(struct sock *sk)
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
> +	u32 copy_len =3D MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_se=
q;
>  	struct mptcp_sock *msk =3D mptcp_sk(sk);
>  	struct sk_buff *tail;
> =20
> @@ -466,7 +478,7 @@ static bool __mptcp_move_skb(struct sock *sk, struct =
sk_buff *skb)
>  	if (unlikely(msk->rcvd_dummy_seq))
>  		__mptcp_sync_rcv_sequence(sk);

[Severity: High]
As reported by Sashiko on v18 [2], can __mptcp_move_skb() desynchronize the
TFO skb's map_seq from msk->copied_seq when subflow_set_remote_key() runs
while the msk socket is owned by user space?

During passive TFO, mptcp_fastopen_subflow_synack_set_params() places the T=
FO
skb on sk->sk_receive_queue with map_seq64 =3D -(u64)skb->len, sets
msk->rcvd_dummy_seq =3D true, and initializes msk->copied_seq =3D -(u64)skb=
->len.

If the third ACK carrying MP_CAPABLE arrives while sock_owned_by_user(sk) is
true, subflow_set_remote_key() under mptcp_data_lock(sk) immediately updates
msk->ack_seq and msk->tfo_iasn to subflow->iasn, and defers the
msk->copied_seq update by setting MPTCP_SYNC_SEQ:

net/mptcp/subflow.c:subflow_set_remote_key() {
	...
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
}

In mptcp_move_skbs(), MPTCP_SYNC_SEQ is only checked once before acquiring
mptcp_data_lock(sk) and before the mptcp_can_spool_backlog() loop:

net/mptcp/protocol.c:mptcp_move_skbs() {
	if (test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags)) {
		msk->copied_seq +=3D msk->tfo_iasn;
		__mptcp_sync_rcv_sequence(sk);
	}

	mptcp_data_lock(sk);
	while (mptcp_can_spool_backlog(sk, &skbs)) {
		mptcp_data_unlock(sk);
		enqueued |=3D __mptcp_move_skbs(sk, &skbs, &moved);

		mptcp_data_lock(sk);
	}
	...
}

If subflow_set_remote_key() and an incoming data skb run after that initial
test_and_clear_bit() (or while mptcp_data_lock(sk) is dropped inside the
loop), __mptcp_move_skbs() -> __mptcp_move_skb() sees msk->rcvd_dummy_seq a=
nd
calls __mptcp_sync_rcv_sequence(sk). That updates the TFO skb's map_seq to
(u32)(msk->tfo_iasn - skb->len) and clears msk->rcvd_dummy_seq while
msk->copied_seq is still -(u64)skb->len and MPTCP_SYNC_SEQ remains pending.

When mptcp_move_skbs() returns to mptcp_recv_skb() or mptcp_recvmsg() ->
__mptcp_recvmsg_mskq(), the offset calculation:

	offset =3D (u32)msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq;

evaluates to (u32)(-msk->tfo_iasn), which underflows to >=3D skb->len and c=
auses
mptcp_recv_skb() to drop the unread skb via mptcp_eat_recv_skb() and
__mptcp_recvmsg_mskq() to skip it.

In addition, while MPTCP_SYNC_SEQ is pending under lock_sock(sk) before
release_sock(sk) runs mptcp_release_cb(), mptcp_inq_hint() computes
READ_ONCE(msk->ack_seq) - READ_ONCE(msk->copied_seq) using the IASN-shifted
msk->ack_seq and the unshifted msk->copied_seq, returning INT_MAX.

[1] https://lore.kernel.org/r/ad478dff911f705f9d49c66a1a0ef1794b59c989.1793=
349369.git.geliang@kernel.org
[2] https://lore.kernel.org/r/ad478dff911f705f9d49c66a1a0ef1794b59c989.1793=
349369.git.geliang@kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793361629.gi=
t.tanggeliang@kylinos.cn?part=3D4
