Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793589569;
	b=Rm+Ibc37LprxOXGNfjgaO2Fdx0B8K3F7laI6WHcDVGx3NOF3iVjPm9An2dE7GKJlzHyw
	 zSdnO+vRjY3cgJ3lltMgTBRQevk9OJJD4kC2QwX3++Ko5KKA974CZkcC9tOKL2o25BLeu
	 OSiZ6iaRwRKBtFmlhntFqPPo4XSAfGfBrlofJlo2Tq63iuEzwjlkdC/3CwWLMdaQo6t47
	 zS+Xbv4cF6B+RNSa/2TNktIlEOIQ9wxPLCg84Bgdc7C/Cv/OTxokvoVG+I2Nt62xCyJt5
	 /nRsKz/tF0WpC1FUhJcXHLzurVjAEHFJTTBDUb+2ZGCadvNCBV5T6vAhSGulZ2sJoYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793589569;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=unq+HZsFZqT8rbZSUZnLAg6IJGCrTqTJxMIVPE8Wcc8=;
	b=0ldYDtJl+5hMM7D32iKSKNv82YtZEgtADyWMcmrqGYjrlwOfugvb5TxBu4L5ENUsMs7N
	 /rdj3mwl/5p6lNYOmnroZWmuui0VbsZ6TzrGIUi3B2741lPnUo/nnKlkcbXvrIpIrxyq4
	 0JU47DaaW/mITjexeGdbGhjrJojGFXF4v/mGMax606LT3flH38HC1Kk8k2p+0geVGN+XP
	 Gb5HRvinJoYMbL44dqjWJXMTwAPK6lCudSo6B7QHg0m9XzSJU67pasU41YNI/QgyTStvb
	 f7jYvP2h8fk77XedDEg7pDbAyScF3+FheNTtuaidDDx78XaYze9ppfI5nxdkH5lYXDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L1WDSWwe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A0F606A324
	for <mptcp@lists.linux.dev>; Mon,  2 Nov 2026 03:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L1WDSWwe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 002451F000C1;
	Mon,  2 Nov 2026 03:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793589569;
	bh=unq+HZsFZqT8rbZSUZnLAg6IJGCrTqTJxMIVPE8Wcc8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=L1WDSWweB2weBdIvINevh9JG6rQBbCpppRH94NOTfuohEu3zs8WRcmq7X1jHWrDgn
	 xLDrbirG2iI18A5FDRrw1hyia3ZoJXaA37QW0WnniTOX+dKXcfftgD704HkMY8NYIv
	 JnYjLzMqYnc5P1JOu4TIRju1Ukd8hXOTkfotX8WpfrfisQoR+qPu5s672JbDP61mjw
	 6t6RHFxOWut7EG9XyFWc17dX/FZPh9SigoUnSIkOi1aa3a8x1lyYn9B8Qg4Y0kJgw2
	 j8cpFXehwnAdguLJrFp9f0bDJYhCBktAtW9sphLtJvq9YYu+zm3ofHB1TCNyrH62Ui
	 C3RBtyai4K5KA==
Message-ID: <sashiko-outbox-192858@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v4 2/5] mptcp: implement peek_len for
 proto_ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <60417d840527fb839aec6e9a15a3a4a906d59919.1793588257.git.tanggeliang@kylinos.cn>
References: <cover.1793588257.git.tanggeliang@kylinos.cn>
 <60417d840527fb839aec6e9a15a3a4a906d59919.1793588257.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 03:19:28 +0000
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
- [Medium] mptcp: incorrect readable byte count in mptcp_inq_hint() on pass=
ive TFO
--

commit c2b974abec7822444a7f621944b513eb168889a9
Author: Geliang Tang <geliang@kernel.org>

mptcp: implement peek_len for proto_ops

This commit implements the peek_len callback for mptcp_stream_ops and
mptcp_v6_stream_ops using mptcp_data_avail(). It also changes
mptcp_inq_hint() to return 0 instead of INT_MAX when msk->ack_seq minus the
head skb's map_seq is at least INT_MAX.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 0caa31525b907..c6d354900e7d2 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2409,7 +2409,7 @@ static unsigned int mptcp_inq_hint(const struct soc=
k *sk)
>  		u64 hint_val =3D READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
> =20
>  		if (hint_val >=3D INT_MAX)
> -			return INT_MAX;
> +			return 0;
> =20
>  		return (unsigned int)hint_val;
>  	}

[Severity: Medium]
On passive TFO connections, won't returning 0 here cause mptcp_inq_hint() to
report 0 readable bytes (or a bogus subflow->iasn-derived value when hint_v=
al
wraps below INT_MAX) even when unread data is queued in sk->sk_receive_queu=
e?

During passive TFO, mptcp_fastopen_subflow_synack_set_params() queues the S=
YN
payload skb onto sk->sk_receive_queue with map_seq =3D -skb->len and increm=
ents
msk->bytes_received by skb->len while msk->ack_seq is 0:

net/mptcp/fastopen.c:mptcp_fastopen_subflow_synack_set_params() {
	...
	/* Only the sequence delta is relevant */
	MPTCP_SKB_CB(skb)->map_seq =3D -skb->len;
	MPTCP_SKB_CB(skb)->end_seq =3D 0;
	MPTCP_SKB_CB(skb)->offset =3D 0;
	...
}

When the third ACK carrying MP_CAPABLE_ACK arrives,
__mptcp_subflow_fully_established() -> subflow_set_remote_key() sets
msk->ack_seq to subflow->iasn without rebasing the TFO head skb's map_seq:

net/mptcp/subflow.c:subflow_set_remote_key() {
	...
	WRITE_ONCE(msk->remote_key, subflow->remote_key);
	WRITE_ONCE(msk->ack_seq, subflow->iasn);
	...
}

While any unconsumed bytes of the TFO skb remain at the head of
sk->sk_receive_queue (before the first read, during MSG_PEEK, or after a
partial read), mptcp_inq_hint() computes:

	hint_val =3D READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;

which evaluates to subflow->iasn + mptcp_data_avail(msk) (mod 2^64).

When hint_val >=3D INT_MAX, mptcp_inq_hint() returns 0 despite unread data
sitting in sk->sk_receive_queue, and when the 64-bit sum wraps below INT_MA=
X,
it returns a bogus byte count up to INT_MAX - 1. This causes SIOCINQ in
mptcp_ioctl() and the TCP_CM_INQ cmsg in mptcp_recvmsg() to report an
incorrect readable byte count to userspace, and causes
mptcp_rcv_space_adjust() to subtract 0 (or a bogus iasn offset) instead of
the unread receive queue occupancy.

Should mptcp_inq_hint() compute the available bytes using
mptcp_data_avail(msk) like mptcp_inq() does?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793588257.gi=
t.tanggeliang@kylinos.cn?part=3D2
