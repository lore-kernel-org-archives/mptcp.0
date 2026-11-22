Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795350103;
	b=okTCBk4cGbWlcJOZKR61CtdnqCsU4F9ydFHJf/9sLfTzJbRMMOKjjqKPVxUmFZ32+oiM
	 dFyiL8803ea6bQ9VQkDiTihehcGNGGtmd3McV9bRn3EUTvFQYCGqV+VBuF8vugwuoRMFs
	 +t8DoBv/KEQGUjIln8Rl6i67u0fUy59tjee//+bn7+1ZnJ+oe/yPRCUWzpBfGspD/NQyZ
	 23kgNvPqhSZ2QnRtkvlsimyWu76epShTTtOpwNYSZy8zjAdTP4WLW6mKvFk56cixBQWZb
	 wClXoyuPGxXlyozxNwjxuF9pHbBBBW1fDqAMHuLDP3lsKqaX1MPqzdeZlaJWDgw3LXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795350103;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KOF1Wt/jgTkSs+xTlPyIuKA/dkN5ylNmNtg+A1JoG7o=;
	b=ZLKhlU5eL6fjqiQA+9hpJJdTq4NoT/MFdQbiLBz1cf9zLVGvGPF3Yz4j/DN0pDtdA6r4
	 FuYPYQLyg5+C/OgMGJkvHHq5ePMWbVwdJmlZShzLPJKPXll2LmINJYWtg4uMgI3YwEn2x
	 j/i9QyvuiHiNveCsjuZ+kNTusd5Ol95ti48OLS+ZBn70OU9G8467kcHpmMPZoQRG4PPjq
	 ZJgBkqDInUz1AvjhiaHNYkCm1edbNwQg/eBc14ycrM5Iy4IM1WJl/df1J3IsL/TGRgdfb
	 z4BUL7SttDTPqMlwQUC2XjSU7+NlHtk7szx/f+IXDqZqt1jH0aRMb/89uoPYPZh4Ecg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DEupuldJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDA2606A320
	for <mptcp@lists.linux.dev>; Sun, 22 Nov 2026 12:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DEupuldJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A073F1F000C6;
	Sun, 22 Nov 2026 12:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795350102;
	bh=KOF1Wt/jgTkSs+xTlPyIuKA/dkN5ylNmNtg+A1JoG7o=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=DEupuldJ86wbz7g1pUdtiX0vUT6ldWxc8bDoD2ojnYZZ8KBQo49uojHXEO3LambFp
	 jNkfyl9nkr27hU/2RN5//GdR8ZoU+7tfA2zFcXcEaDEkPirgXcUtrRI/2GGiADbiI5
	 OSyjF2XTp040aZnVILzj4usejKL7V/nW7QWtdkj0xqqi0ajmfxNoa/F3yitjCFlPnn
	 vNb+YkvdH7ZYFzJIkLDRX/mxMEBK13xgyI1wWNjuxbsLRiX4pDm7KUFreLCV0VT9+w
	 JCzd0mVRFeUi/GyolIO++rioDI1W+prdXLE4oKI9K3mUDdHUnUniQGDqhHb63gr1OZ
	 kOvxoooig9nFQ==
Message-ID: <sashiko-outbox-227923@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-net v2 3/4] mptcp: fix TFO SIOCINQ overflow in
 mptcp_inq_hint
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <692168c4f75bdb59bc8a9ec9ed116674747c3898.1795348666.git.tanggeliang@kylinos.cn>
References: <cover.1795348666.git.tanggeliang@kylinos.cn>
 <692168c4f75bdb59bc8a9ec9ed116674747c3898.1795348666.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 12:21:42 +0000
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
- [Medium] mptcp: mptcp_inq_hint() compares ack_seq with unset
  rcv_data_fin_seq
--

commit 91eba8ecdb62213836985c3edebbb4b735538410
Author: Geliang Tang <geliang@kernel.org>

mptcp: fix TFO SIOCINQ overflow in mptcp_inq_hint

This commit updates mptcp_inq_hint() to compute available bytes from
mptcp_data_avail() and adds a mptcp_data_fin() helper to check whether
ack_seq has passed rcv_data_fin_seq.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 259a16068afad..7ef37f978f5b1 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -558,6 +558,21 @@ static void mptcp_check_data_fin_ack(struct sock *sk)
>  	}
>  }
> =20
> +static bool mptcp_data_fin(const struct mptcp_sock *msk, u64 *seq)
> +{
> +	u64 rcv_data_fin_seq;
> +
> +	smp_rmb(); /* pair with smp_wmb() in mptcp_update_rcv_data_fin() */
> +	rcv_data_fin_seq =3D READ_ONCE(msk->rcv_data_fin_seq);
> +	if (!before64(READ_ONCE(msk->ack_seq), rcv_data_fin_seq)) {
> +		if (seq)
> +			*seq =3D rcv_data_fin_seq;
> +
> +		return true;
> +	}
> +	return false;
> +}

[ ... ]

> @@ -2364,22 +2370,18 @@ static bool mptcp_move_skbs(struct sock *sk)
>  static unsigned int mptcp_inq_hint(const struct sock *sk)
>  {
>  	const struct mptcp_sock *msk =3D mptcp_sk(sk);
> -	const struct sk_buff *skb;
> -
> -	skb =3D skb_peek(&sk->sk_receive_queue);
> -	if (skb) {
> -		u64 hint_val =3D READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
> +	u64 hint_val =3D mptcp_data_avail(msk);
> =20
> -		if (hint_val >=3D INT_MAX)
> -			return INT_MAX;
> +	if (hint_val >=3D INT_MAX)
> +		return INT_MAX;
> =20
> -		return (unsigned int)hint_val;
> +	if (READ_ONCE(msk->rcv_data_fin) ||
> +	    sk->sk_state =3D=3D TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN)) {
> +		if (mptcp_data_fin(msk, NULL))
> +			hint_val +=3D 1;
>  	}
> =20
> -	if (sk->sk_state =3D=3D TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN))
> -		return 1;
> -
> -	return 0;
> +	return (unsigned int)hint_val;
>  }

[Severity: Medium]
Can mptcp_inq_hint() call mptcp_data_fin() when msk->rcv_data_fin is false
and msk->rcv_data_fin_seq has never been set?

When a socket enters TCP_CLOSE or sets RCV_SHUTDOWN without receiving a
DATA_FIN (for example via shutdown(fd, SHUT_RD) or a peer reset),
msk->rcv_data_fin_seq is still 0.  Because before64() uses signed 64-bit
modular arithmetic, !before64(msk->ack_seq, 0) tests (__s64)msk->ack_seq >=
=3D 0,
and subflow_set_remote_key() seeds msk->ack_seq from a 64-bit SHA-256 hash.

Depending on bit 63 of msk->ack_seq, mptcp_inq_hint() will either omit the
+1 EOF indication on a closed or shut-down empty socket or add a spurious
+1 while unread data is still queued after SHUT_RD.  Checking
sk->sk_state =3D=3D TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN) directly =
for
the +1, and only calling mptcp_data_fin() when READ_ONCE(msk->rcv_data_fin)
is true, would avoid comparing against an unset rcv_data_fin_seq.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795348666.gi=
t.tanggeliang@kylinos.cn?part=3D3
