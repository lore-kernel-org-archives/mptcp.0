Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476AB43D502
	for <mptcp@lists.linux.dev>; Thu, 27 Aug 2026 11:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787829217; cv=none; b=vBjqpqpqdMp260K1tgo+gElPldlsDrLSwECrS1mGyRNy0ZF9HCZVYwhCU8x+ufgY4eVkWjt79Eiv9yENSYT0Z+iMtHvDzrB1NawYKOWs2j2G0kfDzM7ib/fA16a3FMiPy0zFKVX0nU75F9m6T4BjAUEMkhXzENoKa3tVBuaoHGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787829217; c=relaxed/simple;
	bh=V5cTcd+KjCpB3F40IkqicOJ9HGyOWYmDeFRxVCz0B6Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UeO6jLOWGMKa5IxUrHvQkbUvpsU7KaSZ7inwZLdGbUGJYXJBl0OS9bEHWErsokAqs7EDkVELWt3gC0umqdiopSpJPwU4+/jwslWfad91LGnoUMedLWyRJG36Tk18xh8pGBDFe+seW+yZ81jF6oASrzE+f6nNlgsZ7UcOxkoR8kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dPN1W/nR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPN1W/nR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B40E61F000E9;
	Thu, 27 Aug 2026 11:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787829212;
	bh=BELBdlwASmXoeYoCXPxXduyQP76MvAurMQDNGRmboic=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dPN1W/nRiHZsoDr7+thz/6QjtaVb6frwQVX/7M95XgIeFUOK3FxUOgznCl30qyK1c
	 cNuxomAD/tya0RmggxVmeWwEkJQ40dWnSGJwZVxzhia7SMW54pWpvhyjILc9UxgrIW
	 efS5mTBr+QYM3zHHC0CwQsIr14TLvEh8NNduWQebMMmUhpPZd+oZUJaibnG3KKpspl
	 slbRYncetmCqnDAw7JuhZP2ZG/sMYsobiV/pWL3ggUNQZneQQPTW4Wzsjah00bNM2p
	 dyxRviNU7MfAYuXAfXzxnLFofJue3ttyiY4/LnjugZ73Zh0cgvsY41BxOXJ1la9CJU
	 C7HoTW9wC/dkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v9 04/11] mptcp: remove CB offset field
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
In-Reply-To: <abfb5ca3767e390206d6ad4056818a61263a8d33.1787827525.git.tanggeliang@kylinos.cn>
References: <cover.1787827525.git.tanggeliang@kylinos.cn>
 <abfb5ca3767e390206d6ad4056818a61263a8d33.1787827525.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 11:13:32 +0000
Message-Id: <20260827111332.B40E61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Lockless check of MPTCP_SYNC_SEQ in mptcp_inq_hint() leads to a =
TOCTOU race condition that can incorrectly return a bogus TCP_CM_INQ value =
(often INT_MAX).
--

commit 6c708b896ef73852cc85c2a1debeca40b8a72f1c
Author: Paolo Abeni <pabeni@redhat.com>

mptcp: remove CB offset field

This commit replaces the offset field in MPTCP's skb control block with a
socket-level copied_seq field. This mirrors TCP's approach for tracking
bytes consumed and delegating IASN synchronization to the msk release CB
during Fastopen.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 7d1422518aada..4cf7ad97ae0af 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
[ ... ]
> @@ -2414,27 +2397,27 @@ static bool mptcp_move_skbs(struct sock *sk)
>  	return enqueued;
>  }
> =20
> -static unsigned int mptcp_inq_hint(const struct sock *sk)
> +static unsigned int mptcp_inq_hint(struct sock *sk)
>  {
>  	const struct mptcp_sock *msk =3D mptcp_sk(sk);
> -	const struct sk_buff *skb;
>  	u64 hint_val, ack_seq;
> =20
> -	skb =3D skb_peek(&sk->sk_receive_queue);
> -	if (skb) {
> -		ack_seq =3D atomic64_read(&msk->ack_seq);
> -		hint_val =3D ack_seq - MPTCP_SKB_CB(skb)->map_seq;
> -
> -		if (hint_val >=3D INT_MAX)
> -			return INT_MAX;
> +	if (test_bit(MPTCP_SYNC_SEQ, &msk->cb_flags))
> +		return 0;
> =20
> -		return (unsigned int)hint_val;
> -	}
> +	/* Avoid races vs ack_seq updates. */
> +	mptcp_data_lock(sk);
> +	ack_seq =3D atomic64_read(&msk->ack_seq);
> +	hint_val =3D ack_seq - msk->copied_seq;
> +	mptcp_data_unlock(sk);

[Severity: Medium]
Could this lockless check of MPTCP_SYNC_SEQ lead to a Time-of-Check to
Time-of-Use (TOCTOU) race condition?

If an application calls recvmsg() with msg_control to read TCP_CM_INQ, and
concurrent to mptcp_inq_hint() executing, a softirq updates the socket's
ack_seq to the remote key (iasn) and sets the MPTCP_SYNC_SEQ flag:

mptcp_inq_hint() could test MPTCP_SYNC_SEQ outside of mptcp_data_lock(sk),
read 0 (false), wait for the lock, and then calculate hint_val using the
newly updated ack_seq but a stale copied_seq.

Since the new ack_seq is an absolute cryptographic sequence number and the
stale copied_seq is relative (negative), the difference could be larger
than INT_MAX, causing the function to incorrectly return INT_MAX.

> +	if (hint_val >=3D INT_MAX)
> +		return INT_MAX;
> =20
> -	if (sk->sk_state =3D=3D TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN))
> +	if (!hint_val &&
> +	    (sk->sk_state =3D=3D TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN)))
>  		return 1;
> =20
> -	return 0;
> +	return (unsigned int)hint_val;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787827525.gi=
t.tanggeliang@kylinos.cn?part=3D4
