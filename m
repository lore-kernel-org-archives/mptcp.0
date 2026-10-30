Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793350978;
	b=qij6Nx0J5cOa3cOfMWfQNW9YDWo1SskatNBbmzfzVTtOp4OpSgfmVefLvcPXB244mlpq
	 UYbKVf9+j+LxBblMKxRnluNz0tllwErBOHVufr9Bx3u5DSIqWhgMvSfZHW4FmIQEUYt76
	 /m5tomBZkjbSoGc6MSc2AJCg8UhEC7M6z0HwtecbGdgW0nyvTZWmL9V3VMujO5teT0JT5
	 en3mK9b3lmQ2lDpbm43mkCCTbdl0mVTC/2RCuf78FvS86NC+g42S6FN5yRYPXXiv9/1+d
	 F2f8wg2A9mrXT+FCcMsMDE6FM+hlHxuF8ezuTQTXA5yHIuSs4d/HySNUljz5UXZ62DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793350978;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=01//0KSewRvlAx+j+i8QvpD/JUbtuk3Zm4Q5KrlKh4g=;
	b=WOaNUSJUt01Z2TPNK7Tv+NeB1s/tqzVI5VnHXzVxleSHjqCdfSzx3x4FSeAWeZ6+8wiu
	 g8fto6gOvd/rFt7T+5bXBtuBu2QetSjt3hbuTr1YSmOt8S1s5tinsfqKiZVaImohCR59r
	 i4F6j1CVJqcgx/7o9jE9eL6wqo9tjkEUoyv9SVFGJDl0TVyKYaAqh0ltOmH8g4OvBvAyQ
	 kK2CdT/n4NH/jd8TERKTTscYQGKmXGlY5y2Fi+8zTYdVcviMiYBtj74rb2zkX1h+Yt0Gf
	 m+rEewtPTGpzaYWu549CIoGkxLKeAy8l/TsdiNyJRaqPn6kn0Yb3+Pr7D0tyRdUiusg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iAGR7onx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44910606A31C
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 09:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iAGR7onx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E451F000C1;
	Fri, 30 Oct 2026 09:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793350977;
	bh=01//0KSewRvlAx+j+i8QvpD/JUbtuk3Zm4Q5KrlKh4g=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=iAGR7onxjQu7z2tYpSYf0x8cTAg10d80WyQUE4473Vxd0nQiE2KWCVbLvGqob9JKn
	 ms0f2eGcZn1pXaWduPfTQAISQgUMvM8KyFGB2L9HPxp6gAgl574Jqxlo7yWBBRZXVO
	 w3ffLkL3jL0Kpcn1r7Acu7U8qcn0/rQpMyf8mjlMcHJbf0gRXuNekFHX7Pr5WkBReK
	 me1x+anxEvzsggStlP6Fv9oI15v9mcvey+W9Xpg+eRNS/Lg9cQ8s1S7qBb1gy8GqI+
	 Uwy8A81hJlHWS7yMP4frqYUitFTe5twL1dIPStcGmajVLuzzYpAKpnY268K87pwXtE
	 c/g+ir4fCOwVQ==
Message-ID: <sashiko-outbox-190731@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v18 2/5] mptcp: drop the cant_coalesce CB
 field
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <dbff20aeb3b48f16b15f4ca82915a2cc4b0bcee4.1793349369.git.geliang@kernel.org>
References: <cover.1793349369.git.geliang@kernel.org>
 <dbff20aeb3b48f16b15f4ca82915a2cc4b0bcee4.1793349369.git.geliang@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 09:02:57 +0000
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
- [Medium] mptcp: mptcp_inq_hint() seq mismatch when subflow_set_remote_key=
() defers sync
- [Medium] mptcp: off-by-one in __mptcp_sync_rcv_sequence() after mptcp_che=
ck_data_fin()
--

commit f64a32260362fb1c8168b46cd47f03ba4852fb6c
Author: Paolo Abeni <pabeni@redhat.com>

mptcp: drop the cant_coalesce CB field

This commit removes the cant_coalesce skb control buffer field and instead
synchronizes the sequence numbers of a passive TCP Fast Open skb once the
initial ACK sequence number becomes available on the third ACK.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 528a72da646cc..fe154b1816834 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
[ ... ]
> @@ -438,6 +436,26 @@ static void mptcp_init_skb(struct sock *ssk, struct =
sk_buff *skb, int offset,
>  	skb_dst_drop(skb);
>  }
> =20
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

[Severity: Medium]
As reported by Sashiko on v15 [1], can __mptcp_sync_rcv_sequence() compute
an off-by-one map_seq and end_seq if mptcp_check_data_fin() runs before
mptcp_release_cb()?

When mptcp_worker() holds lock_sock(sk) on a passive TFO socket with SYN da=
ta
queued in sk->sk_receive_queue (msk->rcvd_dummy_seq is true), the peer's th=
ird
ACK carrying MP_CAPABLE and a zero-payload DATA_FIN (with data_seq equal to
subflow->iasn and data_len equal to 1) can arrive in BH context.

In that case, subflow_set_remote_key() sets msk->ack_seq to subflow->iasn a=
nd
sets MPTCP_SYNC_SEQ in msk->cb_flags, while mptcp_incoming_options() /
get_mapping_status() calls mptcp_update_rcv_data_fin() to record
msk->rcv_data_fin_seq =3D subflow->iasn and msk->rcv_data_fin =3D 1 without
queuing an skb to msk->backlog_list.

Before release_sock(sk) invokes mptcp_release_cb() in net/mptcp/protocol.c,
mptcp_worker() calls mptcp_check_data_fin():

net/mptcp/protocol.c:mptcp_worker()
	mptcp_check_send_data_fin(sk);
	mptcp_check_data_fin_ack(sk);
	mptcp_check_data_fin(sk);

which sees msk->ack_seq =3D=3D rcv_data_fin_seq and advances msk->ack_seq b=
y 1:

net/mptcp/protocol.c:mptcp_check_data_fin()
	if (mptcp_pending_data_fin(sk, &rcv_data_fin_seq)) {
		WRITE_ONCE(msk->ack_seq, msk->ack_seq + 1);
		WRITE_ONCE(msk->rcv_data_fin, 0);

When release_sock(sk) subsequently runs mptcp_release_cb() ->
__mptcp_sync_rcv_sequence(sk), msk->ack_seq is already subflow->iasn + 1, so
both MPTCP_SKB_CB(skb)->map_seq and MPTCP_SKB_CB(skb)->end_seq on the TFO s=
kb
will be shifted forward by 1 byte.

[ ... ]
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 78e886b202585..49a000b8dcb8e 100644
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
> @@ -533,6 +535,11 @@ static void subflow_set_remote_key(struct mptcp_sock=
 *msk,
>  	WRITE_ONCE(msk->ack_seq, subflow->iasn);
>  	WRITE_ONCE(msk->can_ack, true);
>  	atomic64_set(&msk->rcv_wnd_sent, subflow->iasn);
> +
> +	if (!sock_owned_by_user(sk))
> +		__mptcp_sync_rcv_sequence(sk);
> +	else
> +		set_bit(MPTCP_SYNC_SEQ, &msk->cb_flags);
>  }

[Severity: Medium]
As reported by Sashiko on v15 [2], does deferring __mptcp_sync_rcv_sequence=
()
here while immediately updating msk->ack_seq cause mptcp_inq_hint() to retu=
rn
a bogus value when sock_owned_by_user(sk) is true?

In mptcp_fastopen_subflow_synack_set_params() in net/mptcp/fastopen.c, the =
TFO
skb is queued onto sk->sk_receive_queue with MPTCP_SKB_CB(skb)->map_seq set=
 to
-skb->len and end_seq set to 0 while msk->ack_seq is 0.

If user space holds lock_sock(sk) in mptcp_ioctl() (for SIOCINQ) or
mptcp_recvmsg() when the peer's third ACK arrives in BH context,
subflow_set_remote_key() updates msk->ack_seq to subflow->iasn immediately,
but defers __mptcp_sync_rcv_sequence(sk) via MPTCP_SYNC_SEQ until
release_sock(sk) runs mptcp_release_cb().

When the third ACK carries no payload (or arrives after mptcp_move_skbs() h=
as
checked msk->backlog_list), __mptcp_move_skb() is not called before
mptcp_inq_hint(sk) runs under lock_sock(sk):

net/mptcp/protocol.c:mptcp_ioctl()
	lock_sock(sk);
	if (mptcp_move_skbs(sk))
		mptcp_cleanup_rbuf(msk, 0);
	*karg =3D mptcp_inq_hint(sk);
	release_sock(sk);

and similarly in mptcp_recvmsg() (for TCP_CM_INQ) and
__mptcp_recvmsg_mskq() -> mptcp_rcv_space_adjust().

In mptcp_inq_hint() in net/mptcp/protocol.c:

	skb =3D skb_peek(&sk->sk_receive_queue);
	if (skb) {
		u64 hint_val =3D READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;

		if (hint_val >=3D INT_MAX)
			return INT_MAX;

		return (unsigned int)hint_val;
	}

hint_val subtracts the unsynchronized dummy map_seq (-skb->len + offset) fr=
om
subflow->iasn, evaluating to subflow->iasn + skb->len - offset and returning
INT_MAX (or a corrupted value) instead of the unread TFO payload length.

[1] https://lore.kernel.org/r/25f42bae1af43649a5c89ca10cfe0d962941c6f7.1792=
718041.git.tanggeliang@kylinos.cn
[2] https://lore.kernel.org/r/25f42bae1af43649a5c89ca10cfe0d962941c6f7.1792=
718041.git.tanggeliang@kylinos.cn

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793349369.gi=
t.geliang@kernel.org?part=3D2
