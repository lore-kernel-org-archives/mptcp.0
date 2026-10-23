Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792722948;
	b=asvNgPkzBkmofpf3O+AejdPlIX2Jz4nANU8miEDp2ethvmD4W2zDEdiUNaosbFqxhNjd
	 igB5S0TC8WFxg0/i/BKTqUVjxe1O/Qk02pHL+u5bgCFTamtIxAiYWXQzk7ATYJHtAkfvj
	 Cel5xhcXdgjxGfAiLbr0q202++xrgAv020uQRiZSlwCE2Sie7L+VbqIy8iHJXGS9eWI3z
	 ZSkVGntiFGWEUScLGxpxV3p0TAaF93Ynn9NLFpX8Z3KTt834N80nHK7KU/O4uvsVFsnVD
	 hJ1+HGhcmv2SbIhJNASAyfsVpGsPgbyg4MeuyEnntjRtX4mgpH8QCMBG7P1xnLgtAKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792722948;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hqHHme+8j2G6oPRP7KXnJVkvSL76xdAAamHKMm8FVQY=;
	b=vozw+2oNLWWJ0uYkrjS9tB0Sn0ENqmSebvJSEEz1c7jb8Ljb3Idiuzj/HlbYJwgIzgkP
	 +O/ZTYnbtUN/3c1ih4xfqppPLdsAVD5h6Ndo5FzwxnfwzG1FIN+QWZdM3IoHhZQD+db/G
	 dxoR3tjww//NPO82UxyhPkkiX9nAyC1vEZqmXQR5dJa1kvdm0tA1OK9heW/KdFgKhJADU
	 kDwaJHhfEUPZUtJ/ZSMP/ALTE/y+xEyzkbQTD7S3CTtKjyN2gyRjtuBSvDyng5T2LP5xj
	 bVDW4JC3fGjBBqlHXFnQ0zeSOZVnm91RqxArKPVuRxqKAi/R99QeoUbFkGSmawCQvaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OT4Jy5df;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D89F606A319
	for <mptcp@lists.linux.dev>; Fri, 23 Oct 2026 02:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OT4Jy5df
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C77171F01825;
	Fri, 23 Oct 2026 02:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792722947;
	bh=hqHHme+8j2G6oPRP7KXnJVkvSL76xdAAamHKMm8FVQY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=OT4Jy5dfB7+kP56dFcRiBm4TD5LGTqWNJ/i6zDllUSUzeElDmvZTX9veEZeCRGv2z
	 zUNp61/GHSUpKaoO0X3oD4lnYnpbJPTl4w4z+zo8kpXVnJmdkBpR1tZPAg3hsNpL/K
	 yX+TnADQ34hHJ5JrRiBs3bAftlfa/1tUTaKYh+OMj0rap7njJhY0wA6TKoDNSK+aWp
	 yBk3mafM1dnjV6oYX/reVDAiuxzjiCdJ1YKdtpEllRiJ6I+xRHvV/OJKGPqnzOg50z
	 CkiLYMYYFWcOx/Ud4tqPj277BXx8+p0E27OudEEmaoSCW+DCm8MQGHeWqDP+hPd/rO
	 AVlpxx5FGoJzw==
Message-ID: <sashiko-outbox-182243@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v15 04/11] mptcp: sync mptcp skb cb layout
 with tcp one
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <a0dc7793379f9fd85ac0f9ba8acb9e7f8f7100e3.1792718041.git.tanggeliang@kylinos.cn>
References: <cover.1792718041.git.tanggeliang@kylinos.cn>
 <a0dc7793379f9fd85ac0f9ba8acb9e7f8f7100e3.1792718041.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 02:35:47 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] mptcp: subtracting offset in mptcp_init_skb() corrupts OoO and=
 coalescing
- [High] mptcp: double offset subtraction in mptcp_init_skb() on TCP fallba=
ck
- [High] mptcp: unlocked cb_flags and sequence sync in __mptcp_move_skb()
- [Medium] mptcp: race and TFO byte overcount in mptcp_inq_hint()
- [Medium] mptcp: missing rcvd_dummy_seq reset in mptcp_disconnect()
--

commit e9c4071fc5ac0354ced408d757ea20835f2b3153
Author: Paolo Abeni <pabeni@redhat.com>

mptcp: sync mptcp skb cb layout with tcp one

This series removes the cant_coalesce and offset fields from struct
mptcp_skb_cb, tracks consumed receive bytes via msk->copied_seq, and
aligns the 32-bit sequence number and flags layout of struct mptcp_skb_cb
with struct tcp_skb_cb while keeping the 64-bit sequence number in
map_seq64.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 02a4f479d9d8c..01eb7fb314e76 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -167,13 +167,14 @@ static bool __mptcp_try_coalesce(struct sock *sk, s=
truct sk_buff *to,
>  {
>  	int limit =3D READ_ONCE(sk->sk_rcvbuf);
> =20
> -	if (unlikely(MPTCP_SKB_CB(to)->cant_coalesce) ||
> -	    MPTCP_SKB_CB(from)->offset ||
> +	if (MPTCP_SKB_CB(from)->map_seq !=3D MPTCP_SKB_CB(to)->end_seq ||
> +	    MPTCP_SKB_CB(from)->map_seq64 !=3D MPTCP_SKB_CB(to)->map_seq64 +
> +					     to->len ||
>  	    ((to->len + from->len) > (limit >> 3)) ||
>  	    !skb_try_coalesce(to, from, fragstolen, delta))
>  		return false;

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

[Severity: Critical]
When __mptcp_move_skbs_from_subflow() passes a non-zero offset to
mptcp_init_skb() (for example, after mptcp_subflow_discard_data() advances
tp->copied_seq past an already-received mapping in the prefix of a
multi-mapping skb, or when a partial-overlap subflow segment has
TCP_SKB_CB(skb)->seq < tp->copied_seq), the valid mapped payload starts at
skb->data + offset with data sequence number dsn =3D
mptcp_subflow_get_mapped_dsn(subflow), while skb->data[0 .. offset - 1]
contains discarded or unrelated subflow bytes.

By shifting map_seq64 and map_seq backwards to dsn - offset and removing
the offset check from __mptcp_try_coalesce(), what prevents the following
regressions when offset > 0?

1. If a preceding skb in backlog_list, out_of_order_queue, or
sk_receive_queue ends at dsn - offset, __mptcp_try_coalesce() sees
MPTCP_SKB_CB(from)->map_seq =3D=3D MPTCP_SKB_CB(to)->end_seq and
MPTCP_SKB_CB(from)->map_seq64 =3D=3D MPTCP_SKB_CB(to)->map_seq64 + to->len,=
 and
skb_try_coalesce() appends the entire from buffer (including the leading
bytes in from->data[0 .. offset - 1]) onto to.

2. If the mapping at skb->data + offset is out-of-order (dsn >
msk->ack_seq) with dsn - offset <=3D msk->ack_seq, __mptcp_move_skb() sees
MPTCP_SKB_CB(skb)->map_seq64 <=3D msk->ack_seq and treats the out-of-order
skb as in-sequence or a partial packet, queuing it to sk->sk_receive_queue
and advancing msk->ack_seq so __mptcp_recvmsg_mskq() copies stale prefix
bytes to user space in place of [msk->ack_seq, dsn).

3. If dsn - offset > msk->ack_seq, mptcp_data_queue_ofo() inserts the skb
into msk->out_of_order_queue at map_seq =3D (u32)(dsn - offset), where it c=
an
drop or overwrite legitimate out-of-order segments in [dsn - offset, dsn)
as MPTCP_MIB_DUPDATA, and __mptcp_ofo_queue() will dequeue it as soon as
msk->ack_seq reaches dsn - offset.

[Severity: High]
Also in mptcp_init_skb(), doesn't subtracting offset from
mptcp_subflow_get_mapped_dsn(subflow) subtract offset twice when the
connection is in fallback mode?

In net/mptcp/subflow.c:subflow_check_data_avail():

	skb =3D skb_peek(&ssk->sk_receive_queue);
	subflow->map_valid =3D 1;
	subflow->map_data_len =3D skb->len;
	subflow->map_subflow_seq =3D tcp_sk(ssk)->copied_seq - subflow->ssn_offset;
	subflow->map_seq =3D __mptcp_expand_seq(subflow->map_seq,
					      subflow->iasn +
					      TCP_SKB_CB(skb)->seq -
					      subflow->ssn_offset - 1);

Because subflow->map_subflow_seq is based on tcp_sk(ssk)->copied_seq,
mptcp_subflow_get_map_offset(subflow) is 0, while subflow->map_seq is set
from TCP_SKB_CB(skb)->seq (which is tcp_sk(ssk)->copied_seq - offset).
Thus mptcp_subflow_get_mapped_dsn(subflow) is already msk->ack_seq -
offset.

When mptcp_init_skb() subtracts offset again, map_seq64 becomes
msk->ack_seq - 2 * offset and end_seq becomes (u32)msk->ack_seq + skb->len
- 2 * offset. In __mptcp_move_skb(), won't this drop the skb as
MPTCP_MIB_DUPDATA when skb->len <=3D 2 * offset, or compute copy_len =3D
skb->len - 2 * offset and skip 2 * offset bytes in __mptcp_recvmsg_mskq()
while leaving msk->ack_seq behind tp->copied_seq?

>  	MPTCP_SKB_CB(skb)->flags =3D 0;
>  	MPTCP_SKB_CB(skb)->has_rxtstamp =3D has_rxtstamp;
> -	MPTCP_SKB_CB(skb)->cant_coalesce =3D 0;
> =20
>  	__skb_unlink(skb, &ssk->sk_receive_queue);
> =20
> @@ -446,15 +443,47 @@ static void mptcp_init_skb(struct sock *ssk, struct=
 sk_buff *skb, int offset,
>  	skb_dst_drop(skb);
>  }
> =20
> +/* Caller must hold the msk data lock */
> +void __mptcp_sync_rcv_sequence(struct sock *sk)
> +{
> +	struct mptcp_sock *msk =3D mptcp_sk(sk);
> +	struct sk_buff *skb;
> +
> +	if (likely(!msk->rcvd_dummy_seq))
> +		return;
> +
> +	/* User space can have already received the TFO skb. */
> +	msk->rcvd_dummy_seq =3D false;
> +	skb =3D skb_peek_tail(&sk->sk_receive_queue);
> +	if (!skb)
> +		return;
> +
> +	MPTCP_SKB_CB(skb)->map_seq64 =3D mptcp_iasn(msk) - skb->len;
> +	MPTCP_SKB_CB(skb)->map_seq =3D (u32)MPTCP_SKB_CB(skb)->map_seq64;
> +	MPTCP_SKB_CB(skb)->end_seq =3D MPTCP_SKB_CB(skb)->map_seq + skb->len;
> +}
> +
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
> +	if (test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags)) {
> +		/* Ensure we see the updated ack_seq after seeing the flag */
> +		smp_rmb();
> +		msk->copied_seq +=3D mptcp_iasn(msk);
> +
> +		/* Be sure to sync the eventual fastopen dummy mapping before
> +		 * any other skb lands into the msk.
> +		 */
> +		if (unlikely(msk->rcvd_dummy_seq))
> +			__mptcp_sync_rcv_sequence(sk);
> +	}

[Severity: High]
Is it safe for __mptcp_move_skb() to run test_and_clear_bit(MPTCP_SYNC_SEQ,
&msk->cb_flags) and call __mptcp_sync_rcv_sequence(sk) without holding
mptcp_data_lock(sk)?

When __mptcp_move_skb() is called from mptcp_move_skbs() or
mptcp_release_cb() -> __mptcp_move_skbs(), sk->sk_lock.slock has been
dropped while sock_owned_by_user(sk) is true:

net/mptcp/protocol.c:mptcp_move_skbs() {
	mptcp_data_lock(sk);
	while (mptcp_can_spool_backlog(sk, &skbs)) {
		mptcp_data_unlock(sk);
		enqueued |=3D __mptcp_move_skbs(sk, &skbs, &moved);

		mptcp_data_lock(sk);
	}
}

At the same time, other paths holding mptcp_data_lock(sk) while
sock_owned_by_user(sk) is true update msk->cb_flags using non-atomic
__set_bit() or |=3D operations, such as __mptcp_data_acked(),
__mptcp_check_push(), and mptcp_propagate_state():

net/mptcp/protocol.c:__mptcp_data_acked() {
	if (!sock_owned_by_user(sk))
		__mptcp_clean_una(sk);
	else
		__set_bit(MPTCP_CLEAN_UNA, &mptcp_sk(sk)->cb_flags);
}

If a concurrent softirq path loads msk->cb_flags (while MPTCP_SYNC_SEQ is
set) for a non-atomic __set_bit() and stores the word back after
test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags) in __mptcp_move_skb()
clears it, won't MPTCP_SYNC_SEQ be re-set and cause a subsequent
__mptcp_move_skb() or mptcp_release_cb() call to add mptcp_iasn(msk) to
msk->copied_seq a second time? Calling __mptcp_sync_rcv_sequence(sk) here
without mptcp_data_lock(sk) also violates the lock requirement noted above
__mptcp_sync_rcv_sequence().

[ ... ]

> @@ -2403,21 +2411,22 @@ static unsigned int mptcp_inq_hint(const struct s=
ock *sk)
>  {
>  	const struct mptcp_sock *msk =3D mptcp_sk(sk);
>  	const struct sk_buff *skb;
> +	u64 hint_val;
> =20
> -	skb =3D skb_peek(&sk->sk_receive_queue);
> -	if (skb) {
> -		u64 hint_val =3D READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
> -
> -		if (hint_val >=3D INT_MAX)
> -			return INT_MAX;
> -
> -		return (unsigned int)hint_val;
> +	if (test_bit(MPTCP_SYNC_SEQ, &msk->cb_flags)) {
> +		skb =3D skb_peek(&sk->sk_receive_queue);
> +		return skb ? skb->len : 0;
>  	}
> =20
> -	if (sk->sk_state =3D=3D TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN))
> +	hint_val =3D READ_ONCE(msk->ack_seq) - msk->copied_seq;

[Severity: Medium]
Can mptcp_inq_hint() return an inflated byte count in two cases here?

First, in subflow_set_remote_key() when sock_owned_by_user(sk) is true,
msk->ack_seq is written before MPTCP_SYNC_SEQ is set:

net/mptcp/subflow.c:subflow_set_remote_key() {
	WRITE_ONCE(msk->ack_seq, subflow->iasn);
	WRITE_ONCE(msk->can_ack, true);
	atomic64_set(&msk->rcv_wnd_sent, subflow->iasn);

	if (!sock_owned_by_user(sk)) {
		...
	} else {
		/* Ensure ack_seq is visible before setting the flag */
		smp_wmb();
		set_bit(MPTCP_SYNC_SEQ, &msk->cb_flags);
	}
}

Because mptcp_inq_hint() tests MPTCP_SYNC_SEQ first and then reads
READ_ONCE(msk->ack_seq) without holding mptcp_data_lock(sk), it can observe
MPTCP_SYNC_SEQ =3D=3D 0 and then read the updated msk->ack_seq =3D=3D subfl=
ow->iasn
before msk->copied_seq has been synced, causing READ_ONCE(msk->ack_seq) -
msk->copied_seq to wrap or clamp to INT_MAX.

Second, when test_bit(MPTCP_SYNC_SEQ, &msk->cb_flags) is true and user
space has already partially read from the fastopen skb (advancing
msk->copied_seq), returning skb->len does not subtract the already-copied
offset ((u32)msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq).

[ ... ]

> @@ -3689,11 +3711,13 @@ static int mptcp_disconnect(struct sock *sk, int =
flags)
>  	msk->bytes_retrans =3D 0;
>  	msk->rcvspace_init =3D 0;
>  	msk->fastclosing =3D 0;
> +	msk->tfo_skb_len =3D 0;
>  	mptcp_init_rtt_est(msk);
> =20
>  	/* for fallback's sake */
>  	WRITE_ONCE(msk->ack_seq, 0);
>  	atomic64_set(&msk->rcv_wnd_sent, 0);
> +	msk->copied_seq =3D 0;

[Severity: Medium]
Should mptcp_disconnect() also reset msk->rcvd_dummy_seq =3D false (and cle=
ar
MPTCP_SYNC_SEQ)?

If a passive fastopen socket sets msk->rcvd_dummy_seq =3D true in
mptcp_fastopen_subflow_synack_set_params() and is then disconnected via
mptcp_disconnect() before __mptcp_sync_rcv_sequence() runs,
msk->rcvd_dummy_seq remains true and a subsequent connection on the same
socket can invoke __mptcp_sync_rcv_sequence() and overwrite the tail skb's
sequence numbers in sk->sk_receive_queue.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792718041.gi=
t.tanggeliang@kylinos.cn?part=3D4
