Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792722598;
	b=uvnNHry2U5/b/KYOJsoKRcVjkhh9tNk45euA1vXQN4nWTXtgIvwl4NlIlmEvWh+VFHzS
	 DNBOsftiJbHwfWZif57iEOjxHcy1rT9O53TNfURtWU1tKGu0ysyNVHUBgb2+UttQH5JOx
	 CQmRWUDvPEkmgJaKJSjMuzLATaieCgHM0geu1emYDM7bdD7BhzR0G/OGdK0DbeWbF/f/o
	 6DtUC4zdOkAHOsx1YY7Vb8+xeuV2V9i6U1tduOVuKFjP+Aq1vh3wBAwhTB0+4Q9mZ7OoX
	 LU/d4vec9c07VlaX/LJiaSdxSvfnL9kQK7pbycC8REBozAg1OGztGVJevMbWTllXkxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792722598;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ORa+DUVw6onzOE5sbSj5qaxXtR87grRYqtv6CXCM2EQ=;
	b=DFoyBi5iMSsz1knUb1UOgm4oxW4841e8bcle1cElXcW6hynaGn4xVQI6rYyErVqMq6AI
	 qT2lzJjw99ZPAgQ1trXQaCi1xvwoBXL+AFhhERIsFDnoXJH4vM2Xmboze+beRSEwbOTE2
	 q+mBxayYDfAgaFdv06X4OWE/HBqcsohUR71imq71w/eW5G1KVFeP1EADofrmFDy/gaObD
	 bt1bFGLT0A6/HIMEgRW/ppY0jgg3Jwyv+wR+Ls++JKk7lo+ZzszEBVTHig6HutbIGCP1d
	 F3WcfptjtKWI9KUTxkDXzD4dN35Gb4voYLBl+H4qQG/XjclAllzDeAJkXRBq4b7gJJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FRYMNpR9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54F3606A319
	for <mptcp@lists.linux.dev>; Fri, 23 Oct 2026 02:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FRYMNpR9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BC681F01825;
	Fri, 23 Oct 2026 02:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792722597;
	bh=ORa+DUVw6onzOE5sbSj5qaxXtR87grRYqtv6CXCM2EQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=FRYMNpR9VlOEcouPFqViCbaLdefxxL5Elvd5X1gYVIHcryvW+yi+KPSoGOosWCIAV
	 vTtUV6eArqwZPYAt5yOcNEOEviPc9GszIxpw6UKMnblvY9zEiebOjrK8fjx/PsblWI
	 lNplgJ/jKN6af2lMtPHbR84zMrdcoYrt60bivpbOltS2lPItR8k2TO9BmaPSxi8Eem
	 9ck9L7JMpJ1gVyTw0wzfzsCYtpf12f0AlJ62wus8SrnQEH+0UypPy1sW6EPsADjNEp
	 9Ftm2FH7CWsmNpR4DP9sQ+PNKSxv3ALXanFZc7jtEPSDWk04eeMZoupuf+2TKWe0HK
	 92hSifxEh9U+g==
Message-ID: <sashiko-outbox-182233@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v15 05/11] mptcp: defer read_sock cleanup to
 mptcp_worker
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <d3072fed79af4d6dc637fd7ecf2263ac0d189cc6.1792718041.git.tanggeliang@kylinos.cn>
References: <cover.1792718041.git.tanggeliang@kylinos.cn>
 <d3072fed79af4d6dc637fd7ecf2263ac0d189cc6.1792718041.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 02:29:56 +0000
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
- [Medium] mptcp: msk->read_copied overflow in __mptcp_read_sock() skips rb=
uf cleanup
--

commit dbba5fc9642f463a94cfb4b42a591e715b089eca
Author: Paolo Abeni <pabeni@redhat.com>

mptcp: defer read_sock cleanup to mptcp_worker

This commit defers mptcp_rcv_space_adjust() and mptcp_cleanup_rbuf() from
__mptcp_read_sock() to mptcp_worker() by accumulating consumed bytes in
msk->read_copied and scheduling work with MPTCP_WORK_READ_COMPLETE.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 01eb7fb314e76..3c3ad8991799a 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3149,6 +3149,21 @@ static void mptcp_backlog_purge(struct sock *sk)
>  	sk_mem_reclaim(sk);
>  }
> =20
> +static void mptcp_read_complete(struct sock *sk)
> +{
> +	struct mptcp_sock *msk =3D mptcp_sk(sk);
> +	int read_copied;
> +
> +	mptcp_data_lock(sk);
> +	read_copied =3D msk->read_copied;
> +	msk->read_copied =3D 0;
> +	mptcp_data_unlock(sk);
> +
> +	mptcp_rcv_space_adjust(msk, read_copied);
> +	if (read_copied > 0)
> +		mptcp_cleanup_rbuf(msk, read_copied);
> +}

[ ... ]

> @@ -4696,11 +4712,14 @@ static int __mptcp_read_sock(struct sock *sk, rea=
d_descriptor_t *desc,
>  	if (noack)
>  		goto out;
> =20
> -	mptcp_rcv_space_adjust(msk, copied);
> -
> +	/* The backlog flushing is only needed when some data is actually
> +	 * moved and will take place in mptcp_release_cb() via
> +	 * release_sock() in the worker.
> +	 */
>  	if (copied > 0) {
> -		mptcp_recv_skb(sk, &offset);
> -		mptcp_cleanup_rbuf(msk, copied);
> +		msk->read_copied +=3D copied;
> +		set_bit(MPTCP_WORK_READ_COMPLETE, &msk->flags);
> +		mptcp_schedule_work(sk);
>  	}

[Severity: Medium]
Can accumulating copied into msk->read_copied in __mptcp_read_sock() without
saturating cause mptcp_read_complete() to skip receive buffer cleanup and
window updates when msk->read_copied wraps?

In net/mptcp/protocol.h, struct mptcp_sock defines read_copied as a signed
int. If multiple calls to __mptcp_read_sock() (for example via
mptcp_splice_read() or BH-context sk->sk_read_sock()) consume enough data
before mptcp_worker() runs mptcp_read_complete() that msk->read_copied
overflows and wraps to zero or a negative value, mptcp_read_complete() rese=
ts
msk->read_copied to 0 and skips mptcp_cleanup_rbuf(msk, read_copied).

At the same time, mptcp_rcv_space_adjust() in net/mptcp/protocol.c also
returns early when copied <=3D 0, and when given a large positive accumulat=
ed
read_copied it adds into another signed int without saturation:

net/mptcp/protocol.c:mptcp_rcv_space_adjust() {
	...
	if (copied <=3D 0)
		return;

	if (!msk->rcvspace_init)
		mptcp_rcv_space_init(msk, msk->first);

	msk->rcvq_space.copied +=3D copied;
	...
}

Skipping mptcp_cleanup_rbuf() after draining the receive queue prevents
subflows from calling tcp_cleanup_rbuf() to send window-update ACKs, which =
can
stall the connection if the receive window was exhausted, while also skippi=
ng
receive buffer autotuning.

Would it make sense to use saturating addition (or a wider type) when
accumulating msk->read_copied and msk->rcvq_space.copied so thatread_copied
remains positive when mptcp_read_complete() drains it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792718041.gi=
t.tanggeliang@kylinos.cn?part=3D5
