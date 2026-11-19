Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795065986;
	b=Xo1edhV4ooRogR80921yx8fI1V4HxebVbxC2/t/VkrrH5o2pxrDqBApaQvIOLwQLMikl
	 hQwzY+QlHeJIFqWytvNN1UNmCt5c9PXtBdJNPQNh3xqpANmp9LwrOyKsFGHiLpEQ8klXK
	 1s0WlF9nhECPs2GPH7AGaQ7zxAScTfTyeUuOKa6C8dgSfnJuRU87fFN+XrvGoga+vgshn
	 D4ZJLpad1Jpkd+3apPuKxEgj0+K8UcXYdWTYU8nkre2EG60AdFT2IVrrmJ6K+zGrsK9xu
	 tbfa+g/i69HqE4ofYTYW4/jP3mhZE2x8VsATxSw1UOu9q1rWo9XQO3uBSlWqyEqAvWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795065986;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jjAMaUnMwQ6m4lRI4OSjDsXehFyr/CHtKPfWPB7rO1E=;
	b=YVyis80L3hLtVbU6kJNxiEiyDejCOdr0/2VZ1jnjRZe7cfL/xMLyqOb0EvkSbQy74foE
	 agfoDzJhDe5e2/WMQnShdvtqpwL9gcE5TZ71ozzN6TJsXmGaQwFNwgxHP7aU/dvOQVkxX
	 kwAOQAf5hPNCB4oZE5vp5LbhdQFNcOvoIu3GQBoMh6SqxQnQcWKxtzJ0Oxr8KwWVw90pW
	 eWalXb5Er6fCw8e39rug4HtkaVz9Duo5U2aM0CDqB/ZcXhW+IgabElBprrzHMjcfJlcfp
	 sZwm57NJ9U0UYmt8Fd5dy/Mwz15UTGxoh1w1qewbvuV4ni+8wogEOHD3d7NbGRjvpxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TbNKIQC+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EC5606A320
	for <mptcp@lists.linux.dev>; Thu, 19 Nov 2026 05:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TbNKIQC+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B7D01F000C4;
	Thu, 19 Nov 2026 05:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795065985;
	bh=jjAMaUnMwQ6m4lRI4OSjDsXehFyr/CHtKPfWPB7rO1E=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=TbNKIQC+wH2cT94Q1vLWGQiHKHtMNR4f05I/qqilqjH0LHBLj+C76RiKEUsKdkN2M
	 BmJAmULHPmYm5+Nd3Goy7tGt5OMKPkyoIQT4zR9TLUQzLc/x75zWuaLPeFnXvRMD6m
	 31fl3oQ6i1++u1ChsAg0BswCEbwIpaw05AcCVVopg6JwekaGkZg0Cxm11fNnsBy549
	 fA2jV4usZqUFluvfRk/sqCI2o1PNu8WzsJqKy6xDqnDahMogfU6twQYDo5KlyG25K8
	 LPBVFpkjlMaKNy1iuWCn39WA/X0fC0JB+30JNRVQi4L9v5GOvodp3f1pTMLOk5WecQ
	 GHQbe4kFcA+qQ==
Message-ID: <sashiko-outbox-222480@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-net v29 2/8] mptcp: fix TFO SIOCINQ overflow in
 mptcp_inq_hint
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <f9a5a16a7164ad9e1a09b0f58e99f0e4ab3cdb99.1795063943.git.tanggeliang@kylinos.cn>
References: <cover.1795063943.git.tanggeliang@kylinos.cn>
 <f9a5a16a7164ad9e1a09b0f58e99f0e4ab3cdb99.1795063943.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 05:26:24 +0000
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
- [Medium] mptcp: premature or missed FIN accounting in mptcp_inq_hint()
--

commit 6ab8c08660030a284e407817bd6afd88a1c90988
Author: Geliang Tang <geliang@kernel.org>

mptcp: fix TFO SIOCINQ overflow in mptcp_inq_hint

This commit changes mptcp_inq_hint() to compute available bytes from
mptcp_data_avail() and add 1 when msk->rcv_data_fin_seq is non-zero.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 382da25320378..072725c6ab5d1 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2404,22 +2404,15 @@ static bool mptcp_move_skbs(struct sock *sk)
>  static unsigned int mptcp_inq_hint(const struct sock *sk)
>  {
>  	const struct mptcp_sock *msk =3D mptcp_sk(sk);
> -	const struct sk_buff *skb;
> +	u64 hint_val =3D mptcp_data_avail(msk);
> =20
> -	skb =3D skb_peek(&sk->sk_receive_queue);
> -	if (skb) {
> -		u64 hint_val =3D READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
> +	if (hint_val >=3D INT_MAX)
> +		return INT_MAX;
> =20
> -		if (hint_val >=3D INT_MAX)
> -			return INT_MAX;
> +	if (READ_ONCE(msk->rcv_data_fin_seq))
> +		hint_val +=3D 1;
> =20
> -		return (unsigned int)hint_val;
> -	}
> -
> -	if (sk->sk_state =3D=3D TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN))
> -		return 1;
> -
> -	return 0;
> +	return (unsigned int)hint_val;
>  }

[Severity: Medium]
Can checking msk->rcv_data_fin_seq here add the FIN byte before the
in-order stream has reached DATA_FIN?

mptcp_update_rcv_data_fin() sets msk->rcv_data_fin_seq as soon as a
DATA_FIN option is parsed on any subflow, while mptcp_check_data_fin()
only sets RCV_SHUTDOWN once msk->ack_seq catches up to rcv_data_fin_seq.
If DATA_FIN arrives out of order across subflows while mptcp_data_avail()
is 0, SIOCINQ and TCP_CM_INQ will report 1, but a subsequent non-blocking
mptcp_recvmsg() will fail with -EAGAIN (or block) because RCV_SHUTDOWN is
not set yet.

Also, on an active connection that falls back to plain TCP before
receiving MP_CAPABLE and closes with 0 payload bytes,
subflow_sched_work_if_closed() records rcv_data_fin_seq as 0, so
READ_ONCE(msk->rcv_data_fin_seq) stays false and omits the FIN byte at
EOF.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795063943.gi=
t.tanggeliang@kylinos.cn?part=3D2
