Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793364732;
	b=f+On1s5RfTbSwaNYzxM12i6zPS7G5R5NRxQEkaNyiqCTNDZqHDl1vgVTlZMdA1Cv1jZw
	 e0Ygka3RtxO/6JQvBJdGOxSh1LOSkN09Er4gtc0XDKU8FMQGG3ja6458EvJwawfcj4C27
	 jiqYJaY4Ej/KfwXY+8bnVdgiaiH2UE5H7AhHkqmMlJVweVCD0QMJNgn5VOcISdmMflees
	 JG7uiimXRArSmVxtE6b8NnSAgeQNhgg4KWKJlFUQugvMV7zCssWAOn+I2nFjkOGboukeY
	 BqGv439P3XqBYBLoSvUtOMlBoyf59J9HbGl74SgyFk9vyBuYk+TTWyTBnK7RoYALcKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793364732;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QKA1fAOj1a0e2wDhq4/FS0LiasuvXxL7Dm/mfVAWbIQ=;
	b=ugFV2RbvOLWuiYm31Rv10xDw6dUwzFc9YnqUJhLNiEL7vaz0MVSOLwpTirBPVDL873L7
	 uFJTaH3+o8iBBaLAkqiDxdaF4qYqj6J3CTFjHGszyi+fx4KASgyKGiue3LV6w0UIhn/3I
	 ytPC1wTBiaOf6eBp1eP0FgffDd6EwBUobMZ5/HkDi6dcSySdN9p+D78LEdp+PY8pG2WxH
	 z4pFcYBqssSmF5Uj4l8XJkCsRgb8WTXDS5uftn/TQePO++0KrpDl/83PMlB8PCXvOYc0a
	 MRFFUl7Kc3QOMlgMbWt7uGdSzU+pL5R/s6hMKk7LIHAkxAf9Xm3/Mez1sz+wrDB/vbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YXqOXOhe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A7F606A329
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 12:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YXqOXOhe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B87D1F00A21;
	Fri, 30 Oct 2026 12:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793364731;
	bh=QKA1fAOj1a0e2wDhq4/FS0LiasuvXxL7Dm/mfVAWbIQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=YXqOXOhelZs0b+kW5sxSrO9g3zPD7/zFYn1EZ9Kj40VL3rGheNwF5E9YlzWqH8Wwa
	 rfZObm6CIJRBGZGCA6N3NfHOC1HKwhGZhvsHAtI9iNhZHAlu1e3+RFkHQEsSkyZM6H
	 rlurkDYMNnE96gTgKisQCrx+tGVdk96nsA7/DVyT6+Yk61nEmth2IHm7f1ZVzLx9W+
	 KGVqNXVeOwMc/HEoyYq+72Hxb1YJnuz447AE7JYz5x+RVBBbqtJgwVHt+jBlndiYV7
	 kUQ4eECpbBpjshr8I7DrFlbhu4LZU14bMsUZ1P7eOmH9Ugfm6oyg7FQPh+YSaqBg5h
	 L4i6QhutLmzFg==
Message-ID: <sashiko-outbox-191034@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v19 3/5] mptcp: remove CB offset field
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <1dac839fffd26114e35382b256fdee9923c0949b.1793361629.git.tanggeliang@kylinos.cn>
References: <cover.1793361629.git.tanggeliang@kylinos.cn>
 <1dac839fffd26114e35382b256fdee9923c0949b.1793361629.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 12:52:10 +0000
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
- [High] mptcp: stream corruption in mptcp_init_skb() on non-zero subflow o=
ffset
- [High] mptcp: unsynchronized copied_seq when MPTCP_SYNC_SEQ is deferred
- [Medium] mptcp: unlocked test_and_clear_bit() on cb_flags in mptcp_move_s=
kbs()
- [Medium] mptcp: missing reset of tfo_iasn in mptcp_disconnect() and __mpt=
cp_init_sock()
--

commit 373a78c8c2985557d0ce492ed496a374c5080029
Author: Paolo Abeni <pabeni@redhat.com>

mptcp: remove CB offset field

This commit replaces the per-skb MPTCP_SKB_CB(skb)->offset field with an
msk-level copied_seq counter to track bytes consumed from the receive queue.
It also updates fastopen sequence synchronization, receive queue coalescing,
and mptcp_inq_hint() to compute offsets and hints from copied_seq.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index e855aaa59da29..3f967c4dc825f 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -168,7 +168,6 @@ static bool __mptcp_try_coalesce(struct sock *sk, str=
uct sk_buff *to,
>  	int limit =3D READ_ONCE(sk->sk_rcvbuf);
> =20
>  	if (MPTCP_SKB_CB(from)->map_seq !=3D MPTCP_SKB_CB(to)->end_seq ||
> -	    MPTCP_SKB_CB(from)->offset ||
>  	    ((to->len + from->len) > (limit >> 3)) ||
>  	    !skb_try_coalesce(to, from, fragstolen, delta))
>  		return false;
> @@ -415,8 +414,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *m=
sk, struct sk_buff *skb)
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
> @@ -425,9 +423,9 @@ static void mptcp_init_skb(struct sock *ssk, struct s=
k_buff *skb, int offset,
>  	 * mptcp_subflow_get_mapped_dsn() is based on the current tp->copied_seq
>  	 * value
>  	 */
> -	MPTCP_SKB_CB(skb)->map_seq =3D mptcp_subflow_get_mapped_dsn(subflow);
> -	MPTCP_SKB_CB(skb)->end_seq =3D MPTCP_SKB_CB(skb)->map_seq + copy_len;
> -	MPTCP_SKB_CB(skb)->offset =3D offset;
> +	MPTCP_SKB_CB(skb)->map_seq =3D mptcp_subflow_get_mapped_dsn(subflow) -
> +				     offset;
> +	MPTCP_SKB_CB(skb)->end_seq =3D MPTCP_SKB_CB(skb)->map_seq + skb->len;
>  	MPTCP_SKB_CB(skb)->has_rxtstamp =3D has_rxtstamp;

[Severity: High]
As reported by Sashiko on v18 [1], can subtracting offset from
mptcp_subflow_get_mapped_dsn(subflow) in mptcp_init_skb() while removing the
MPTCP_SKB_CB(from)->offset check in __mptcp_try_coalesce() corrupt the
MPTCP receive stream when offset > 0?

In __mptcp_move_skbs_from_subflow(), the skb at the head of
ssk->sk_receive_queue can have a non-zero offset (tp->copied_seq -
TCP_SKB_CB(skb)->seq > 0) while starting a new DSS mapping M2 at
tp->copied_seq with DSN mapped_dsn =3D mptcp_subflow_get_mapped_dsn(subflow=
).

For example, in subflow_check_data_avail() -> get_mapping_status(), a single
TCP skb can carry the tail of a previous DSS mapping M1 in bytes
0 .. offset - 1 and a new DSS mapping M2 in its SKB_EXT_MPTCP extension
starting at byte offset. When M1's remaining bytes were already received on
another subflow (before64(ack_seq, old_ack)), get_mapping_status() sees
!skb_is_fully_mapped(ssk, skb) and keeps SKB_EXT_MPTCP on the skb,
mptcp_subflow_discard_data() advances tp->copied_seq by offset without
eating the skb and resets subflow->map_valid =3D 0, and the next iteration =
of
subflow_check_data_avail() installs M2 starting at tp->copied_seq. A
partially overlapping TCP segment queued by tcp_data_queue() or
tcp_ofo_queue() at a mapping boundary can also produce offset > 0.

Because MPTCP stripes data across multiple subflows, the discarded prefix
bytes in skb->data[0 .. offset) do not belong to DSN range
[mapped_dsn - offset, mapped_dsn). Setting map_seq =3D mapped_dsn - offset =
and
end_seq =3D map_seq + skb->len appears to cause three issues:

1. In __mptcp_add_backlog(), __mptcp_move_skb(), mptcp_data_queue_ofo(), and
__mptcp_ofo_queue(), whenever mapped_dsn - offset equals to->end_seq,
__mptcp_try_coalesce() calls skb_try_coalesce(to, from, ...), which appends
all from->len bytes starting from byte 0 (including the discarded prefix
from->data[0 .. offset)) onto to.

2. When M2 is out of order at the MPTCP level (mapped_dsn > msk->ack_seq)
because [msk->ack_seq, mapped_dsn) is in flight on another subflow, and
mapped_dsn - offset <=3D msk->ack_seq < mapped_dsn, __mptcp_move_skb() sees
MPTCP_SKB_CB(skb)->map_seq <=3D msk->ack_seq and treats the out-of-order skb
as in-sequence or a partial packet starting at msk->ack_seq. It advances
msk->ack_seq and msk->bytes_received across the unreceived gap
[msk->ack_seq, mapped_dsn), queues or coalesces the skb into
sk->sk_receive_queue, delivers the stale bytes from skb->data[0 .. offset)
to user space in __mptcp_recvmsg_mskq() and mptcp_recv_skb(), and causes the
genuine data for [msk->ack_seq, mapped_dsn) arriving on the other subflow to
be dropped as MPTCP_MIB_DUPDATA.

3. When mapped_dsn - offset > msk->ack_seq, mptcp_data_queue_ofo() inserts
the skb into msk->out_of_order_queue at mapped_dsn - offset, where it can
coalesce with or replace legitimate out-of-order segments covering
[mapped_dsn - offset, mapped_dsn) and be dequeued early by
__mptcp_ofo_queue() once msk->ack_seq reaches mapped_dsn - offset.

[ ... ]

> @@ -2396,8 +2376,10 @@ static bool mptcp_move_skbs(struct sock *sk)
>  	bool enqueued =3D false;
>  	u32 moved =3D 0;
> =20
> -	if (test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags))
> +	if (test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags)) {
> +		msk->copied_seq +=3D msk->tfo_iasn;
>  		__mptcp_sync_rcv_sequence(sk);
> +	}
> =20
>  	mptcp_data_lock(sk);
>  	while (mptcp_can_spool_backlog(sk, &skbs)) {

[Severity: Medium]
As reported by Sashiko on v15 [2], is it safe to call
test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags) and
__mptcp_sync_rcv_sequence(sk) in mptcp_move_skbs() before acquiring
mptcp_data_lock(sk)?

All other flags in msk->cb_flags share the same unsigned long word and are
updated when sock_owned_by_user(sk) is true under mptcp_data_lock(sk) using
non-atomic __set_bit() or |=3D, such as in mptcp_propagate_state() right af=
ter
subflow_set_remote_key():

    mptcp_propagate_state()
        subflow_set_remote_key()
            set_bit(MPTCP_SYNC_SEQ, &msk->cb_flags);
        ...
        __set_bit(MPTCP_SYNC_STATE, &msk->cb_flags);

as well as in __mptcp_data_acked(), __mptcp_check_push(),
mptcp_retransmit_timer(), mptcp_subflow_process_delegated(),
mptcp_finish_join(), subflow_error_report(), and
mptcp_check_and_set_pending().

If a BH or timer handler on another CPU holds mptcp_data_lock(sk) and
performs a non-atomic read-modify-write on msk->cb_flags while
MPTCP_SYNC_SEQ is set, and mptcp_move_skbs() clears MPTCP_SYNC_SEQ without
holding mptcp_data_lock(sk) between that load and store, can the store
restore MPTCP_SYNC_SEQ to 1 and cause mptcp_release_cb() or a later
mptcp_move_skbs() call to add msk->tfo_iasn to msk->copied_seq a second
time?

> @@ -2418,22 +2400,17 @@ static bool mptcp_move_skbs(struct sock *sk)
>  static unsigned int mptcp_inq_hint(const struct sock *sk)
>  {
>  	const struct mptcp_sock *msk =3D mptcp_sk(sk);
> -	const struct sk_buff *skb;
> -
> -	skb =3D skb_peek(&sk->sk_receive_queue);
> -	if (skb) {
> -		u64 hint_val =3D READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
> +	u64 hint_val;
> =20
> -		if (hint_val >=3D INT_MAX)
> -			return INT_MAX;
> +	hint_val =3D READ_ONCE(msk->ack_seq) - READ_ONCE(msk->copied_seq);
> +	if (hint_val >=3D INT_MAX)
> +		return INT_MAX;
> =20
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

[Severity: High]
As reported by Sashiko on v15 [2], can deferring the msk->copied_seq update
via MPTCP_SYNC_SEQ in subflow_set_remote_key() leave msk->copied_seq out of
sync with sk->sk_receive_queue and msk->ack_seq?

When subflow_set_remote_key() runs in BH context while sock_owned_by_user(s=
k)
is true, it immediately updates WRITE_ONCE(msk->ack_seq, subflow->iasn) and
msk->tfo_iasn =3D subflow->iasn under mptcp_data_lock(sk), while deferring
msk->copied_seq +=3D subflow->iasn and __mptcp_sync_rcv_sequence(sk) via
MPTCP_SYNC_SEQ. This appears to leave two windows where sequence numbers are
mismatched:

1. In mptcp_move_skbs(), test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags)
is only checked once before acquiring mptcp_data_lock(sk) and outside the
while (mptcp_can_spool_backlog(sk, &skbs)) loop (which drops
mptcp_data_lock(sk) on each iteration). If the 3rd ACK carrying MP_CAPABLE
and data arrives in BH after that initial check, subflow_set_remote_key()
sets msk->tfo_iasn and MPTCP_SYNC_SEQ, and mptcp_data_ready() queues the new
skb onto msk->backlog_list.

mptcp_move_skbs() then splices msk->backlog_list and calls
__mptcp_move_skbs() -> __mptcp_move_skb(), which sees msk->rcvd_dummy_seq
and calls __mptcp_sync_rcv_sequence(sk) directly:

    __mptcp_move_skb()
        if (unlikely(msk->rcvd_dummy_seq))
            __mptcp_sync_rcv_sequence(sk);

This clears msk->rcvd_dummy_seq =3D false and rebases the TFO skb in
sk->sk_receive_queue to map_seq =3D msk->tfo_iasn - skb->len, without adding
msk->tfo_iasn to msk->copied_seq. When mptcp_move_skbs() returns to
mptcp_recv_skb() or mptcp_recvmsg(), sk->sk_receive_queue is in the
post-IASN sequence space while msk->copied_seq (and peek_seq) is still in
the pre-IASN sequence space. In mptcp_recv_skb(),
offset =3D msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq underflows by
msk->tfo_iasn, causing mptcp_eat_recv_skb() to drop unread skbs (or return a
corrupted offset if (u32)(-msk->tfo_iasn) < skb->len), and
__mptcp_recvmsg_mskq() skips unread skbs as already-peeked data.

2. While MPTCP_SYNC_SEQ is still pending, msk->ack_seq holds subflow->iasn
while msk->copied_seq is still pre-IASN. Calling mptcp_inq_hint(sk) before
MPTCP_SYNC_SEQ is processed (such as in __mptcp_recvmsg_mskq() ->
mptcp_rcv_space_adjust(), in mptcp_recvmsg() for TCP_CM_INQ when
msk->backlog_list is empty after a pure 3rd ACK without payload, in
__mptcp_read_sock() -> mptcp_rcv_space_adjust(), or in mptcp_ioctl(SIOCINQ)
if the remote key arrives after mptcp_move_skbs()) subtracts the pre-IASN
msk->copied_seq from the post-IASN msk->ack_seq, returning INT_MAX (or an
IASN-inflated value) and underflowing copied -=3D mptcp_inq_hint(sk) in
mptcp_rcv_space_adjust().

[ ... ]

> @@ -3699,6 +3689,7 @@ static int mptcp_disconnect(struct sock *sk, int fl=
ags)
>  	mptcp_pm_data_reset(msk);
>  	mptcp_ca_reset(sk);
>  	msk->bytes_consumed =3D 0;
> +	msk->copied_seq =3D 0;
>  	msk->bytes_acked =3D 0;
>  	msk->bytes_received =3D 0;
>  	msk->bytes_sent =3D 0;

[Severity: Medium]
Should mptcp_disconnect() (and __mptcp_init_sock()) also reset
msk->tfo_iasn =3D 0?

If an MPTCP socket connects and receives a remote key,
subflow_set_remote_key() sets msk->tfo_iasn =3D subflow->iasn. If the socket
is later disconnected via mptcp_disconnect() and reused as a listener, child
sockets cloned in mptcp_sk_clone_init() via sk_clone_lock() will inherit the
stale non-zero msk->tfo_iasn.

If a passive TFO connection on that listener queues a SYN payload in
mptcp_fastopen_subflow_synack_set_params() (setting map_seq and
msk->copied_seq to -(u64)skb->len and msk->rcvd_dummy_seq =3D true) and then
falls back to TCP on the 3rd ACK without receiving MP_CAPABLE,
subflow_set_remote_key() is never called on the child. When the next
fallback data segment arrives in __mptcp_move_skb(),
__mptcp_sync_rcv_sequence() will rebase the TFO skb's map_seq to
msk->tfo_iasn - skb->len using the stale msk->tfo_iasn while
msk->copied_seq remains -(u64)skb->len.

[1] https://lore.kernel.org/r/3cc892c20ed48f8f31f40e7a9ff7363d4b7b0806.1793=
349369.git.geliang@kernel.org
[2] https://lore.kernel.org/r/25f42bae1af43649a5c89ca10cfe0d962941c6f7.1792=
718041.git.tanggeliang@kylinos.cn

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793361629.gi=
t.tanggeliang@kylinos.cn?part=3D3
