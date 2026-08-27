Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EC642E8C8
	for <mptcp@lists.linux.dev>; Thu, 27 Aug 2026 11:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787829034; cv=none; b=MbbddVlFdBCBvwmP5JALp3U3E8mRrxN9PSq/Qlmzkqg/y3NTtCpwZ46AIfjESBi3obapuWyRb8HeR/wRFZj9Oq6sKLV50jZAqru5C/uImk6cQZSYssGsfn8zgGsgstHTvzZGHN3JqMYFoCqVLthNU8lIeeKtR2jEqMyamW+lrLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787829034; c=relaxed/simple;
	bh=MsHFLXrfaVesdOS2mYNTzwlCY60dDsjMFiElfbJYhXo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Zx7dFsKLYK9uakfIgxHBBi+jCI/hXuj13Bl0fppUfxLGfjn8UEUo3LhKpFbCRtE+4EG4G8zX5piiewbGCkEf6lyxLGIcxlOHQYsq+vBRoEcYlEUnoa662M4vEHftmsKFbiCDfMkCt2xwCZnp9cf9lERFj+MZ1MsCD3bUfK/OTzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOVypB7Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOVypB7Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0091F000E9;
	Thu, 27 Aug 2026 11:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787829030;
	bh=VL3qhMwF8aqAUhPmOZ1KpczL5jKmXlmX3mjar24BuS8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nOVypB7YfqMIvvIYC2NvjRYzSKisv45nIwdB8iwmlLeLJw+f2jIxgUlYf+q1L6SQC
	 2SmwpQRgCF2XxIOuP/oI2gUwTw0/zdb1fkSVTIHhU4bwUIyXgm7uQnjNFcyaqwj4P+
	 gRI1tO/mkn/rxZxlrW8+CNxAH4mPxwAHFaIA1vptGGSPs9XXzqipS4wwJ8zVNGuyg5
	 R9c9kf8icqrAKkdSX9GGVDvsnio8Zms8OW0OyPW9pJ2lWbH78crVTXMzzFiOqLcPGn
	 ZZXyk0t9mXkiqSpZixhYRPGuxSmxKGmF2dkZjuL0XhGho1kBYtANkRriEUru2aMPAA
	 Xby1t9t8LVPtw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v9 07/11] mptcp: implement peek_len for
 proto_ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
In-Reply-To: <72dfb12c36ea32e58f8f85f55c94101fca02702e.1787827525.git.tanggeliang@kylinos.cn>
References: <cover.1787827525.git.tanggeliang@kylinos.cn>
 <72dfb12c36ea32e58f8f85f55c94101fca02702e.1787827525.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 11:10:30 +0000
Message-Id: <20260827111030.BE0091F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Lockless read of 64-bit `copied_seq` causes torn reads on 32-bit s=
ystems and concurrent update races, leading to spurious INT_MAX return valu=
es.
- [High] Subtracting 1 for a FIN flag breaks EOF detection for stream consu=
mers by reporting 0 instead of 1.
--

commit 7df02914f0a616d203067af77b84f00d4f6bc119
Author: Geliang Tang <geliang@kernel.org>
mptcp: implement peek_len for proto_ops

This commit adds mptcp_inq() to compute the readable bytes at the MPTCP
level and derives the count from mptcp_inq_hint(). It wires mptcp_inq()
into mptcp_peek_len() and assigns .peek_len in the stream operations
so upper layers get the in-queue byte count.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index cc8747162cca9..9b9ace7cb977d 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -4814,6 +4814,37 @@ static ssize_t mptcp_splice_read(struct socket *so=
ck, loff_t *ppos,
>  	return ret;
>  }
> =20
> +static int mptcp_inq(struct sock *sk)
> +{
> +	const struct mptcp_sock *msk =3D mptcp_sk(sk);
> +	int answ;
> +
> +	if ((1 << sk->sk_state) & (TCPF_SYN_SENT | TCPF_SYN_RECV)) {
> +		answ =3D 0;
> +	} else if (test_bit(MPTCP_SYNC_SEQ, &msk->cb_flags)) {
> +		answ =3D 0;
> +	} else {
> +		u64 hint_val;
> +
> +		hint_val =3D atomic64_read(&msk->ack_seq) - msk->copied_seq;
> +		if (hint_val >=3D INT_MAX)
> +			hint_val =3D INT_MAX;

[Severity: High]
Could this unprotected 64-bit read of copied_seq cause torn reads on 32-bit
systems?

If a concurrent caller invokes poll or a vhost loop calls .peek_len while
another thread is calling recvmsg(), the unsynchronized read of ack_seq and
copied_seq can result in an inconsistent state and cause an underflow.

This would then trigger the INT_MAX clamp, leading .peek_len to incorrectly
report a massive amount of queued data (up to 2GB). Is there a risk that th=
is
causes stream consumers to allocate excessive memory or loop endlessly
expecting data?

> +
> +		answ =3D (unsigned int)hint_val;
> +		if (answ &&
> +		    (sk->sk_state =3D=3D TCP_CLOSE ||
> +		     (sk->sk_shutdown & RCV_SHUTDOWN)))
> +			answ--;

[Severity: High]
Does subtracting 1 here break EOF detection for stream consumers?

When the peer sends a FIN and the local MPTCP stack sets RCV_SHUTDOWN, this
logic actively suppresses the 1-byte EOF signal by reporting 0 instead of 1.

Callers relying on .peek_len for stream parsing (like strparser or KCM) mig=
ht
enter an infinite wait or hang because they will see 0 data available and
wait for more data that will never arrive, instead of issuing the final
recvmsg() to observe EOF.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787827525.gi=
t.tanggeliang@kylinos.cn?part=3D7
