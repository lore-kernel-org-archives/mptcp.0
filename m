Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793697862;
	b=RaWubx+AGG6iq+AkaOoiZAq3YZArdeR5uu/rPMxfb8h+4QD+xGyIGKXtDcLQikpU3Yy2
	 uCY1s9PKuiQnPfzosnrN0mlWJivAMkanLRvyA2xIAs+3YZH9F2Y0cV0gz78re+snlynBl
	 PcZyilNj0svy2NuGOiQ1LLP/wpI3C/8dhULV+H2XrVSn7Hwbp8Adg7D8dh4kGOQlppZST
	 FSqutEavPcXxVeOXzYG7vdGN9o19NYzivnP2cGR/gxDRS3ELP79aY6Gw7S/WJEBtLMV3h
	 XzA9oMgyxkxR1oM/F6ssZTort6+vt3AIpKqw9v8r/wLv2fVdC9589zB+sD/G+eRzn/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793697862;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=deSLALI1ycy7jfHWSiB8fuCDJJuMlkqxyCmd1tcAXzw=;
	b=gkKKZO1z6uXWnekpLsJ0RYknv8DQDkUCbW9sGXKsIe6Bc7fCGQSnEpnYnBM+BDqLMpL/
	 OlNI0iImLiiURK3D/FysTvbACoD2vX+DnDDKUSRyCMHXmuhKJ3cdo7PuVwAxCm3+1JZko
	 Iw72JxjbkcORSSpktcFFJWLF8KmWtvDPz3JCOXiRjSR58pVj3wRjvFewn455iOagwUoME
	 gplNFa2rUUTbk7+Y8VcNaPNp5+ZhINc5AmFEDM8ukigMMmSqZ9kdpVxM/UGUXfFSvk8/R
	 mpb26GRXbsV11BCTipE6fCyyhzRqBnOOoeLP2X+kJTQtzoWXILawGbYgAa64SvNeCew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ittog59j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FAF606A324
	for <mptcp@lists.linux.dev>; Tue,  3 Nov 2026 09:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ittog59j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA601F000C1;
	Tue,  3 Nov 2026 09:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793697861;
	bh=deSLALI1ycy7jfHWSiB8fuCDJJuMlkqxyCmd1tcAXzw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=ittog59jnCyblTlpCVoVUPOZGYahtEGkx4FaJxF840a9WcUWwuoVqwG1/r9g8Ptf1
	 dBCiNL5vMNFK68XwhnZj7yOxuWeWgKR7MKSge9QLJC+JArN3MMHThufqeZYbiFO8vi
	 SxjXhItEC9D4y+05Mqfbd0Q8nZnFoNVLGfzxzZ6Rp7oRsstv4G7Yxbjcc2Hd+UNn/r
	 8z3F8d4LS8HrxOSlnUxxqkMaiE0HH1ywxiUrL1KQSwn8wIs16R143A8HuOQFPL21HY
	 ssup8Ie9I0wrIGjEaDxAwiajDAFr7fQ+6FV7UvtkS729GskfpJFlH3cXinjzi9eLrE
	 h7YFeiZODY0rQ==
Message-ID: <sashiko-outbox-194951@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v20 2/6] mptcp: drop the cant_coalesce CB
 field
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <9bd00acf2721c30b79fd852167b5b1343a2d67a0.1793695518.git.tanggeliang@kylinos.cn>
References: <cover.1793695518.git.tanggeliang@kylinos.cn>
 <9bd00acf2721c30b79fd852167b5b1343a2d67a0.1793695518.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 09:24:21 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] mptcp: mptcp_inq_hint() seq mismatch when MPTCP_SYNC_SEQ is defe=
rred
--

commit 198606f4de002c65c8846681be2fa1a33a1379e5
Author: Paolo Abeni <pabeni@redhat.com>

mptcp: drop the cant_coalesce CB field

This commit removes the cant_coalesce field from struct mptcp_skb_cb and
synchronizes the passive Fast Open skb sequence numbers with the peer's
initial ACK sequence number once the 3rd ACK arrives. When the socket is
owned by user space at 3rd ACK arrival, synchronization is deferred via
the MPTCP_SYNC_SEQ flag in cb_flags.

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 78e886b202585..8a3ba490b5772 100644
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
> @@ -533,6 +535,12 @@ static void subflow_set_remote_key(struct mptcp_sock=
 *msk,
>  	WRITE_ONCE(msk->ack_seq, subflow->iasn);
>  	WRITE_ONCE(msk->can_ack, true);
>  	atomic64_set(&msk->rcv_wnd_sent, subflow->iasn);
> +	msk->tfo_iasn =3D subflow->iasn;
> +
> +	if (!sock_owned_by_user(sk))
> +		__mptcp_sync_rcv_sequence(sk);
> +	else
> +		set_bit(MPTCP_SYNC_SEQ, &msk->cb_flags);

[Severity: Medium]
As reported by Sashiko on v15 [1], when the 3rd ACK arrives on a passive Fa=
st
Open socket while user space holds the socket lock, subflow_set_remote_key()
immediately updates msk->ack_seq to subflow->iasn while deferring
__mptcp_sync_rcv_sequence() via MPTCP_SYNC_SEQ.

Until MPTCP_SYNC_SEQ is processed, the TFO skb in sk->sk_receive_queue still
carries its dummy sequence mapping (MPTCP_SKB_CB(skb)->map_seq =3D -skb->len
plus any consumed offset). If mptcp_inq_hint() is called under lock_sock(sk)
during that window, it subtracts the dummy map_seq from the newly updated
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

This can happen before release_sock(sk) runs mptcp_release_cb() in three
paths:

1. mptcp_recvmsg() -> __mptcp_recvmsg_mskq() -> mptcp_rcv_space_adjust()
   calls mptcp_inq_hint(sk) before mptcp_move_skbs(sk) is invoked, which can
   underflow copied -=3D mptcp_inq_hint(sk).

2. mptcp_recvmsg() skips mptcp_move_skbs(sk) when msk->backlog_list is empty
   (for example when the 3rd ACK carries no payload) and then calls
   mptcp_inq_hint(sk) for TCP_CM_INQ:

net/mptcp/protocol.c:mptcp_recvmsg() {
		if (!list_empty(&msk->backlog_list) && mptcp_move_skbs(sk))
			continue;
		...
		if (cmsg_flags & MPTCP_CMSG_INQ) {
			unsigned int inq =3D mptcp_inq_hint(sk);

			put_cmsg(msg, SOL_TCP, TCP_CM_INQ, sizeof(inq), &inq);
		}
}

3. In mptcp_ioctl() for SIOCINQ, if the 3rd ACK arrives in BH after
   mptcp_move_skbs(sk) drops mptcp_data_lock(sk) and before
   mptcp_inq_hint(sk) reads msk->ack_seq:

net/mptcp/protocol.c:mptcp_ioctl() {
		lock_sock(sk);
		if (mptcp_move_skbs(sk))
			mptcp_cleanup_rbuf(msk, 0);
		*karg =3D mptcp_inq_hint(sk);
		release_sock(sk);
}

Could this cause mptcp_inq_hint() to return INT_MAX (or a bogus value deriv=
ed
from subflow->iasn) to user space for TCP_CM_INQ and SIOCINQ, and corrupt t=
he
receive buffer space calculation in mptcp_rcv_space_adjust()?

[1] https://lore.kernel.org/r/25f42bae1af43649a5c89ca10cfe0d962941c6f7.1792=
718041.git.tanggeliang@kylinos.cn

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793695518.gi=
t.tanggeliang@kylinos.cn?part=3D2
