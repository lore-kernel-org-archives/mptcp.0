Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792722912;
	b=hdjE+VkagM4rYtsIolmBrWgp76bWbWBgeZpHe4jnfQLHUO0pmM5oidHbpllk0YUBk/gX
	 PdXdBoYufL098AHztJTQ0C1a/u+INNM3W4jTgAZYRMbqZd63AJHi9dlhN+XtttaKsUGI3
	 uIH2aHCzrULH20njq45B5l2KYs5bu/laS9qXCx/BuIcs/mX3ylMUJprggDpkLWqtRqQdn
	 Mbx0wJiFbpaHv2alPU2JEaXlBwKKaVbRAMjWuuTwESvOOxR3yY8Nqy8exd6tijrJNt1Lt
	 9MUfZRlqLHCQ+8er5922GGAaK316CDhLqWnl+nn0/Un2RktcUx9mIT2ADQ2vCYHR5PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792722912;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vkoZkjVEK2LbpeDn8/NxeUAHIP8SXexjz058+rN6Uls=;
	b=Qcddf37/OeM0JNlgEQVkJ9hSDHwDGC7Ukp9vTyxQ9npM88QhE9u81XF/GdVLBFtoJeUR
	 ZG7WRa6heDfeg0ScToNSWjD+745Ul0trRMMAJqYN66yW5OH83DvmE6BDzxikeGvOFz+l0
	 gflxj5BaxGGr0tHPxws1DE9qe5Aaorlm5i+nf0AMkCeNYge8ZEU0R5ZXIVCHOtaGaYUKo
	 LUZ4Hb8bcU+v0Y718IDK6KUskRb55yJ04qxjp3wru+qczRnY0jKvhoRGSREWN2POMQXyU
	 vDEJBD66A0Cly5Y+of+7jrylJSObTSdNrd6AlsFn9McoNUKX8Uhh56faRUGFohkSw0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IbXoCvOm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682D5606A31E
	for <mptcp@lists.linux.dev>; Fri, 23 Oct 2026 02:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IbXoCvOm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1221F01825;
	Fri, 23 Oct 2026 02:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792722912;
	bh=vkoZkjVEK2LbpeDn8/NxeUAHIP8SXexjz058+rN6Uls=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=IbXoCvOmVgjUIrfZkxk7NgA8lbCV2vlGs0BgBOedUb0ZeXz5zZOIANoi3SATBWUaS
	 jeD8lpA66B0bjYEgu8ii/Y3MLzU2AkjNsRpfecN0g1lBRuE5LKHM+wDyA5mQhTJScO
	 OfYlTyI7eyeDoTq9UQ9blhS9W6sBHDOkf+gdn1ufXqxsudkHmB9/xVZveaoOByERFQ
	 Li3VDBA8XIxD+KhOKorYmje4PIhx47rKnFKwcw/gFiCAsyfkt7MJWrqE6t8kmb15We
	 f7fcV9MDV9pgl5wEsVZkFJJNU9KgEckYXeCg7LyWUmeMR998zBr/+iKGq7jqnQq/zJ
	 4L3Yf66qnYiaQ==
Message-ID: <sashiko-outbox-182241@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v15 02/11] mptcp: drop the cant_coalesce CB
 field
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <25f42bae1af43649a5c89ca10cfe0d962941c6f7.1792718041.git.tanggeliang@kylinos.cn>
References: <cover.1792718041.git.tanggeliang@kylinos.cn>
 <25f42bae1af43649a5c89ca10cfe0d962941c6f7.1792718041.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 02:35:11 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] mptcp: race between subflow_set_remote_key() and mptcp_inq_hint()
- [Medium] mptcp: unlocked test_and_clear_bit() on cb_flags in __mptcp_move=
_skb()
- [Medium] mptcp: off-by-one TFO sequence sync if mptcp_check_data_fin() ru=
ns first
--

commit 95b8582af133b9f96581ec94b3c12f504f8d4881
Author: Paolo Abeni <pabeni@redhat.com>

mptcp: drop the cant_coalesce CB field

This commit removes the cant_coalesce field from mptcp_skb_cb and instead
synchronizes the passive fastopen skb sequence numbers with the initial ack
sequence number once the third ack arrives. Synchronization is deferred via
MPTCP_SYNC_SEQ in cb_flags when the msk is owned by user space.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 528a72da646cc..96deaed109a2f 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
[ ... ]
> @@ -438,6 +436,27 @@ static void mptcp_init_skb(struct sock *ssk, struct =
sk_buff *skb, int offset,
>  	skb_dst_drop(skb);
>  }
> =20
> +/* Caller must hold the msk data lock */
> +void __mptcp_sync_rcv_sequence(struct sock *sk)
> +{
> +	struct mptcp_sock *msk =3D mptcp_sk(sk);
> +	struct sk_buff *skb;
> +	u32 offset;
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
> +	offset =3D MPTCP_SKB_CB(skb)->offset;
> +	MPTCP_SKB_CB(skb)->map_seq =3D msk->ack_seq - skb->len + offset;
> +	MPTCP_SKB_CB(skb)->end_seq =3D msk->ack_seq;
> +}
> +
>  static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
>  {
>  	u64 copy_len =3D MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_se=
q;
> @@ -446,6 +465,17 @@ static bool __mptcp_move_skb(struct sock *sk, struct=
 sk_buff *skb)
> =20
>  	mptcp_borrow_fwdmem(sk, skb);
> =20
> +	if (test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags)) {
> +		/* Ensure we see the updated ack_seq after seeing the flag */
> +		smp_rmb();
> +
> +		/* Be sure to sync the eventual fastopen dummy mapping before
> +		 * any other skb lands into the msk.
> +		 */
> +		if (unlikely(msk->rcvd_dummy_seq))
> +			__mptcp_sync_rcv_sequence(sk);
> +	}

[Severity: Medium]
Can this unlocked test_and_clear_bit() on msk->cb_flags race with non-atomic
modifications to msk->cb_flags on other CPUs?

When mptcp_move_skbs() or mptcp_release_cb() spools skbs from
msk->backlog_list, it drops mptcp_data_lock(sk) while sock_owned_by_user(sk)
remains true before calling __mptcp_move_skbs() -> __mptcp_move_skb():

net/mptcp/protocol.c:mptcp_move_skbs() {
	mptcp_data_lock(sk);
	while (mptcp_can_spool_backlog(sk, &skbs)) {
		mptcp_data_unlock(sk);
		enqueued |=3D __mptcp_move_skbs(sk, &skbs, &moved);

		mptcp_data_lock(sk);
	}
}

As a result, __mptcp_move_skb() calls __mptcp_sync_rcv_sequence(sk) without
holding mptcp_data_lock(sk) (contrary to the comment above
__mptcp_sync_rcv_sequence()), and executes an atomic test_and_clear_bit() on
msk->cb_flags without mptcp_data_lock(sk).

Meanwhile, softirq and timer paths holding mptcp_data_lock(sk) see
sock_owned_by_user(sk) =3D=3D true and update other flags in the same
msk->cb_flags word using non-atomic operations (__set_bit() or |=3D), such =
as
in __mptcp_data_acked(), __mptcp_check_push(), mptcp_propagate_state(),
mptcp_retransmit_timer(), mptcp_subflow_process_delegated(),
mptcp_finish_join(), subflow_error_report(), and
mptcp_check_and_set_pending():

net/mptcp/protocol.c:__mptcp_data_acked() {
	if (!sock_owned_by_user(sk))
		__mptcp_clean_una(sk);
	else
		__set_bit(MPTCP_CLEAN_UNA, &mptcp_sk(sk)->cb_flags);
}

If a softirq or timer handler loads msk->cb_flags while MPTCP_SYNC_SEQ is
set, and __mptcp_move_skb() clears MPTCP_SYNC_SEQ before that handler stores
back the modified msk->cb_flags word, MPTCP_SYNC_SEQ will be restored to 1.

In this commit, a resurrected MPTCP_SYNC_SEQ bit causes mptcp_inq_hint() to
return only the first skb's remaining length rather than the full receive
queue length. In the later commit in this series ("mptcp: remove CB offset
field"), clearing the resurrected MPTCP_SYNC_SEQ bit a second time adds
mptcp_iasn(msk) to msk->copied_seq twice, corrupting msk->copied_seq.

> @@ -2394,11 +2424,14 @@ static unsigned int mptcp_inq_hint(const struct s=
ock *sk)
>  {
>  	const struct mptcp_sock *msk =3D mptcp_sk(sk);
>  	const struct sk_buff *skb;
> +	u64 hint_val;
> =20
>  	skb =3D skb_peek(&sk->sk_receive_queue);
>  	if (skb) {
> -		u64 hint_val =3D READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
> +		if (test_bit(MPTCP_SYNC_SEQ, &msk->cb_flags))
> +			return skb->len - MPTCP_SKB_CB(skb)->offset;
> =20
> +		hint_val =3D READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
>  		if (hint_val >=3D INT_MAX)
>  			return INT_MAX;

[Severity: Medium]
Could mptcp_inq_hint() observe MPTCP_SYNC_SEQ =3D=3D 0 together with the up=
dated
msk->ack_seq =3D=3D subflow->iasn while the fastopen skb still has its dummy
map_seq?

On a passive fastopen socket, mptcp_fastopen_subflow_synack_set_params()
queues the skb onto sk->sk_receive_queue with MPTCP_SKB_CB(skb)->map_seq =3D
-skb->len while msk->ack_seq is 0.

When the third ack arrives in softirq context while user space holds
lock_sock(sk) (for instance during mptcp_ioctl(), mptcp_recvmsg(), or
mptcp_rcv_space_adjust()), subflow_set_remote_key() updates msk->ack_seq
first and sets MPTCP_SYNC_SEQ afterwards:

net/mptcp/subflow.c:subflow_set_remote_key() {
	WRITE_ONCE(msk->ack_seq, subflow->iasn);
	WRITE_ONCE(msk->can_ack, true);
	atomic64_set(&msk->rcv_wnd_sent, subflow->iasn);

	if (!sock_owned_by_user(sk)) {
		__mptcp_sync_rcv_sequence(sk);
	} else {
		/* Ensure ack_seq is visible before setting the flag */
		smp_wmb();
		set_bit(MPTCP_SYNC_SEQ, &msk->cb_flags);
	}
}

Because mptcp_inq_hint() runs under lock_sock(sk) without mptcp_data_lock(s=
k)
and checks test_bit(MPTCP_SYNC_SEQ, &msk->cb_flags) before reading
msk->ack_seq, it can test MPTCP_SYNC_SEQ before set_bit() executes and then
read msk->ack_seq after WRITE_ONCE(msk->ack_seq, subflow->iasn) executes.

In that window, MPTCP_SKB_CB(skb)->map_seq is still -skb->len (plus offset),
so hint_val becomes subflow->iasn + skb->len - offset, causing
mptcp_inq_hint() to return a bogus value (clamped to INT_MAX or leaking the
lower bits of subflow->iasn) and corrupting the receive buffer autotuning
calculation in mptcp_rcv_space_adjust().

> @@ -3930,6 +3963,13 @@ static void mptcp_release_cb(struct sock *sk)
>  			__mptcp_error_report(sk);
>  		if (__test_and_clear_bit(MPTCP_SYNC_SNDBUF, &msk->cb_flags))
>  			__mptcp_sync_sndbuf(sk);
> +		if (__test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags)) {
> +			/* Ensure we see the updated ack_seq after seeing
> +			 * the flag
> +			 */
> +			smp_rmb();
> +			__mptcp_sync_rcv_sequence(sk);
> +		}
>  	}
>  }

[Severity: Medium]
What happens if mptcp_worker() runs mptcp_check_data_fin(sk) before
mptcp_release_cb(sk) processes MPTCP_SYNC_SEQ?

Suppose a passive fastopen socket has queued the fastopen skb with dummy
sequence numbers and msk->rcvd_dummy_seq =3D true, and mptcp_worker() is
running under lock_sock(sk). If softirq processes the third ack (carrying
MP_CAPABLE) followed by a zero-payload data_fin (with data_seq =3D=3D
subflow->iasn):

1. subflow_set_remote_key() sets msk->ack_seq =3D subflow->iasn and sets
   MPTCP_SYNC_SEQ in msk->cb_flags because sock_owned_by_user(sk) is true.

2. mptcp_incoming_options() or get_mapping_status() calls
   mptcp_update_rcv_data_fin(), setting msk->rcv_data_fin_seq =3D subflow->=
iasn
   and msk->rcv_data_fin =3D 1 without queuing an skb to msk->backlog_list.

3. Before release_sock(sk) calls mptcp_release_cb(sk), mptcp_worker() calls
   mptcp_check_data_fin(sk), which sees msk->ack_seq =3D=3D msk->rcv_data_f=
in_seq
   and increments msk->ack_seq to subflow->iasn + 1:

net/mptcp/protocol.c:mptcp_check_data_fin() {
	if (mptcp_pending_data_fin(sk, &rcv_data_fin_seq)) {
		WRITE_ONCE(msk->ack_seq, msk->ack_seq + 1);
		WRITE_ONCE(msk->rcv_data_fin, 0);
}

4. When release_sock(sk) then invokes mptcp_release_cb(sk) ->
   __mptcp_sync_rcv_sequence(sk), msk->ack_seq is already subflow->iasn + 1.

Wouldn't __mptcp_sync_rcv_sequence() (and mptcp_iasn(msk) in the subsequent
commit "mptcp: remove CB offset field") then compute the fastopen sequence
off by 1 byte, causing mptcp_inq_hint() (and mptcp_inq() in commit "mptcp:
implement peek_len for proto_ops") to under-report the pending receive queue
data by 1 byte?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792718041.gi=
t.tanggeliang@kylinos.cn?part=3D2
