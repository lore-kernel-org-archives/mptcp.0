Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795865101;
	b=InNZodqYRAAfZqldGqXeE0+XpAx7IeSynreMjNcsp2VWAFyFLbQCpGq4t7a0FtoXsdYp
	 vjJO57G2ZcQdW9Vvjk8JVsC2y0sG81zt6z+wapXaQ8GRdBtKqc6yXnbQl0k6/NUDQst8y
	 igUzAmDfet4Ea+C5dQpcgxBym+CcW4IE1CQEZ85dQp6nAsaNdIRjBlkVoN10XPEeolHky
	 yxpr4Ale4C79gj3ucTpXPLarIlCEoc/4AnbPA0S6ffvt63TLYjzw5QbYC+ptAoToyaHh1
	 G5pG1jRoQD8I00RO8Kf11ZwK37waj08HTIG6WFwKh/uc5io7hnYA+tOOAaYAeIlaUJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795865101;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jQSR+PMVdet0vPbxKG321ML8KR6fJ9x9A4DjN72ta8o=;
	b=cQm37CatAb2NGaDQfhwXUIqtQWHS9B4p6M6K+lxbPqMRNMYsDeVPKsRd2czx/lN6UiM4
	 9FAWCn3gi0O0J0spF4/md+Y1czXFRX58uyC0a+UMsuExgicdqxFanQIrUuSGleth1sALV
	 jnkE20UGjJ2Dn1VQ1YcF2hk5c+I7oWw8SSpJg7UvvlnEOjIDSU4VVA73QroWRgDZLEZ2y
	 Q+lrY9W5M8ZAiJXDFx+mm59SkmC7AYMd02T5trqGmQ8TozW1S1+zz4156tebWD/H5ZCrZ
	 X64kl+q+Z4iDK1UJ6YuA4C1+sKLgERUrUYtMhAI25SlNUEoLMM1Ru84M1dYNE4qcXaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZDduOi8T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1004A606A31C
	for <mptcp@lists.linux.dev>; Sat, 28 Nov 2026 11:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZDduOi8T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A181F00893;
	Sat, 28 Nov 2026 11:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795865100;
	bh=jQSR+PMVdet0vPbxKG321ML8KR6fJ9x9A4DjN72ta8o=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=ZDduOi8TBsuennmMMmX9Xjn+B/nRpAFbmeDuucklYwT4NfZyD4zXZXbduTK+9HZZ4
	 hyMoLXkMDPvGgiBcM0jqoM/+sO56sbySmoG4C0IUwbvLgqIZsLg2A0BQMBF/Tjrlgi
	 RPhJxvEjSvS/ZAoRh2r1Ez9wnADeeLCfx9qh3oTZnQ6qY0bxZ4mtdVKG0YxzC+YaqQ
	 TuQ8hgvsAjwBfH7t0KEdL2dLfsNRewB8nO7FkAemYjvgj28bSuYSboWfdoOwnQopfH
	 bsn4mJnhkxYXGT78ednx5receXRUwGNGq+oA4ze5UW4s+ngc1WjrV+5ViVD9hcBDuA
	 GQsFu+Xzarz8Q==
Message-ID: <sashiko-outbox-238659@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-net v4 3/4] mptcp: fix TFO SIOCINQ overflow in
 mptcp_inq_hint
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <36402c6a6c41fdd1c5c4a06edbe9f95f4657e573.1795863454.git.tanggeliang@kylinos.cn>
References: <cover.1795863454.git.tanggeliang@kylinos.cn>
 <36402c6a6c41fdd1c5c4a06edbe9f95f4657e573.1795863454.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Nov 2026 11:25:00 +0000
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
- [Medium] mptcp: spurious FIN byte in mptcp_inq_hint() on fallback TCP
  reset
--

commit e8009d5eaab8f8edb7310542593678227a6679d0
Author: Geliang Tang <geliang@kernel.org>

mptcp: fix TFO SIOCINQ overflow in mptcp_inq_hint

This commit updates mptcp_inq_hint() to compute readable bytes from
mptcp_data_avail() and adds a mptcp_data_fin() helper to account for a
pending FIN byte.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 52b5b6d2f1ce9..69facb6a86f04 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -2437,22 +2443,16 @@ static bool mptcp_move_skbs(struct sock *sk)
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
> +	if (sock_flag(sk, SOCK_DONE) ||
> +	    (READ_ONCE(msk->rcv_data_fin) && mptcp_data_fin(msk, NULL)))
> +		hint_val +=3D 1;
> =20
> -		return (unsigned int)hint_val;
> -	}
> -
> -	if (sock_flag(sk, SOCK_DONE))
> -		return 1;
> -
> -	return 0;
> +	return (unsigned int)hint_val;
>  }

[Severity: Medium]
Can mptcp_inq_hint() add a spurious FIN byte when a fallback connection is
closed by a TCP RST?

On fallback, subflow_sched_work_if_closed() sets msk->rcv_data_fin whenever
the subflow enters TCP_CLOSE, including after receiving a TCP RST without a
prior FIN.  mptcp_check_data_fin() and __mptcp_subflow_error_report() both
check sock_flag(ssk, SOCK_DONE) before setting SOCK_DONE on sk, and
__mptcp_subflow_error_report() moves sk to TCP_CLOSE without clearing
msk->rcv_data_fin:

net/mptcp/protocol.c:mptcp_check_data_fin() {
    ...
		/* on fallback, also emulated after a reset: check for a FIN */
		if (!__mptcp_check_fallback(msk) ||
		    (msk->first && sock_flag(msk->first, SOCK_DONE)))
			sock_set_flag(sk, SOCK_DONE);
    ...
}

Because mptcp_inq_hint() checks msk->rcv_data_fin and mptcp_data_fin()
directly without verifying the socket state or whether a fallback subflow
actually received a FIN, TCP_CM_INQ (and mptcp_rcv_space_adjust()) will
count an extra FIN byte that was never received.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795863454.gi=
t.tanggeliang@kylinos.cn?part=3D3
