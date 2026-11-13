Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794610431;
	b=SkskKjglCijPrEvdc/2Ds+hCa5IULhU7GeBaVgt1THXRfCtpygsCyTO4YjnQ/kCgNROK
	 NmhREIQhzVJV2DCFENyLWsgME726mMz7qjT8sR5h2201HQblk9OX8B+7OnId0bv37gTrw
	 oJqy6jD7MZVdklzQyx9Vk6/HaZCo6ytnOAV9kJjfTXs8HIzD0dARh/YKLcrkBpjqIj7ZH
	 kKWPofY+gmmdtweVTDy42XRZ0uLugXRTdCBPcwzYVS6RUHoum70dbXuAS+Ou1U04DrF0W
	 HvzobnPspC8wHWNFJfO5dL0oPREyUP/jSPtfCZ9rYuSSxYXeFGHWi7g5YnkllBFQalw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794610431;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jdlr2TRJmpVrQSJFFbJPWY1uCgMaVMKmwnk3POfexT8=;
	b=CK4sHgKeNks1bQzcf9dc+OkuAQW+wwMTYrFMoe4C/lUoW2C63Q7ynpVSYfyNcphB3+zc
	 kQri4MRAhUaCOlBZKh+M79R7TRCnvQfRLqqPDWfM93GQrisKuJUfOaMVbreuHs/7rMl/n
	 CLeB35TiZ6GcXTpCKv7mCl9Nra5sX4w/QaIJY1mVIq3TDweEjdohMTME4RsmHxRTNYS6J
	 8G9M9caQHKSJxHXgaOn6R/GA1O5JcTbVv7g6N8qxoKARkJFFXidQEVNfS363mBhHySskx
	 CH1yPnFL8y5f+oIdbYcxfr1L6d5mvE3WCNIaUmUnANsInfPO5vZgH4Fj+AuX2InmAPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WXXtt+e0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE56606A337
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 22:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WXXtt+e0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D58C1F000C4;
	Fri, 13 Nov 2026 22:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794610431;
	bh=jdlr2TRJmpVrQSJFFbJPWY1uCgMaVMKmwnk3POfexT8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=WXXtt+e0tNOJVwiuLQuSwp0To30T1pKVbdnJu0dGXIX+VMbqUejkgISUTvw+BIm1d
	 /J1E+6wYFDGRJvMlXmb0sJ+6MYz69QyA6MUyqgz9qbsAiAEA/gv+W/b7wDS1L0g71U
	 5yAH2+fBuI+TbV0Lcf2t2UJkxhUdj/VqQRD9GIhxvMGsfcWK+4Hk0V7p4fEnh/JWU+
	 la1ujLspgPMvcSuFnbRHymoHuZzsA2/HAq5cT66OuYRP3xXHA+hoPl5QKHTBLShJ+u
	 pBUsHbQkBa9EAyQjXWKq+ylghHbksHpfrYlPMkEHMDyGlIQk95g9eIPCTW2Kk73Xky
	 x7HdJ+hX6139w==
Message-ID: <sashiko-outbox-213841@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-net 20/34] mptcp: stop resending data to a peer
 that fell back
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0dGhpZXUgQmFlcnRzIChOR0kwKQ==?= <matttbe@kernel.org>, "MPTCP
 Linux" <mptcp@lists.linux.dev>
In-Reply-To: <20261113-mptcp-cmason-fixes-v1-20-9205b77e9a2f@kernel.org>
References: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
 <20261113-mptcp-cmason-fixes-v1-20-9205b77e9a2f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 22:53:50 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] mptcp: drop skb in mptcp_incoming_options() if
  ack_update_msk() resets subflow
--

commit 7d0f1ec53421d182e690548304d3c287dc956345
Author: Chris Mason <mason@kernel.org>

mptcp: stop resending data to a peer that fell back

This commit resets the subflow when mptcp_sendmsg_frag() is about to queue
more old data after previous old data was acknowledged only by bare ACKs,
clears old_data_pending on any non-infinite MPTCP option, and skips zero
window probes while the subflow retransmit queue is non-empty.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 7329deb43c622..388e77da8f16c 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
[ ... ]
> @@ -1527,11 +1528,29 @@ static int mptcp_sendmsg_frag(struct sock *sk, st=
ruct sock *ssk,
>  			return 0;
>  		}
> =20
> +		/* a new probe would move old_data_end: one at a time */
> +		if (!tcp_rtx_queue_empty(ssk)) {
> +			tcp_remove_empty_skb(ssk);
> +			return 0;
> +		}
> +
>  		zero_window_probe =3D true;
>  		data_seq =3D snd_una - 1;
>  		copy =3D 1;
>  	}
> =20
> +	/* old data acked without MPTCP opts: the peer may have fallen back */
> +	if (unlikely(before64(data_seq, msk->snd_nxt) &&
> +		     subflow->old_data_pending &&
> +		     !before(tcp_sk(ssk)->snd_una, subflow->old_data_end))) {
> +		tcp_remove_empty_skb(ssk);
> +		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_FALLBACKFAILED);
> +		subflow->reset_transient =3D 0;
> +		subflow->reset_reason =3D MPTCP_RST_EMIDDLEBOX;
> +		mptcp_subflow_reset(ssk);
> +		return -EAGAIN;
> +	}

[Severity: Medium]
Can mptcp_incoming_options() still return true to tcp_data_queue() after
mptcp_sendmsg_frag() resets the subflow from ack_update_msk()?

mptcp_incoming_options() only checks for sk->sk_state !=3D TCP_CLOSE right
after check_fully_established(), assuming nothing later in the function
can reset sk.  However, ack_update_msk() calls __mptcp_check_push() ->
__mptcp_subflow_push_pending() -> __subflow_push_pending() ->
mptcp_sendmsg_frag() when !sock_owned_by_user(sk):

net/mptcp/options.c:mptcp_incoming_options() {
	...
	if (!check_fully_established(msk, sk, subflow, skb, &mp_opt))
		return sk->sk_state !=3D TCP_CLOSE;
	...
	if (mp_opt.use_ack)
		ack_update_msk(msk, sk, skb, &mp_opt);
	rwin_update(msk, sk, skb);
	...
	return true;
}

If the subflow has old_data_pending set and snd_una has reached
old_data_end (for example via a prior bare ACK or an incoming DSS carrying
both DATA_ACK and an infinite mapping) while msk has unsent reinjected
data, mptcp_sendmsg_frag() calls mptcp_subflow_reset(ssk), which purges
sk_receive_queue, sends a RST, and moves ssk to TCP_CLOSE via tcp_done().
Because mptcp_incoming_options() still returns true, tcp_data_queue()
continues processing the incoming skb on the TCP_CLOSE subflow socket,
queueing payload onto sk_receive_queue, re-arming ACK timers, or hitting
tcp_fin() on a closed socket.

Checking sk->sk_state =3D=3D TCP_CLOSE after ack_update_msk() and returning
false would let tcp_data_queue() drop the packet.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-mptcp-cmas=
on-fixes-v1-0-9205b77e9a2f@kernel.org?part=3D20
