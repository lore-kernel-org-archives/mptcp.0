Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3326B348C61
	for <mptcp@lists.linux.dev>; Tue, 25 Aug 2026 08:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787645832; cv=none; b=ePUm6hUKYWlMSaJGltCIz+jEkZoYgw9zj7isqtVR98zXIIaq+aeQPJgWgSBMim0dLus2gaV7VoD5BV+5TtLfWsyxu4b5VS4H4yhk3Wo7DwEEBcGs0qUYQx+2wQfHMzDW6/CDNY/PUHwyVo6leHwJangzYtIg+B2mzCC+kc0mY3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787645832; c=relaxed/simple;
	bh=XKrTBgu5Tl/oiIUeXHwlY4S2r0IGWSTxB4aIZW+tdGw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UriXi8wH4poGISa4JMl6vHTDWJI7Z4ewl4b3lxXXsaXB/r1wRM3JSSh+ytgB6+AcL0gCgVUsa7OBosXax0dV3mGozzpPGqfVXAxi6GQjBkXhXXaqOOYc3uEApR5xFuQoesIqKRUx7tO4grC1XPEJTzl6CKJKB7vQDNMwLixXhKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bz785ctv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bz785ctv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E11791F000E9;
	Tue, 25 Aug 2026 08:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787645831;
	bh=IPpsKlvc8qocVOjg7yvvWgrhzpUVzrJKIRV7QuhkntU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bz785ctve7w6D/S4nwFnP4EAUp5JE/W0Wo1Itk1d1lOdCpc5E17UDuVYfILm69A2e
	 hF/zY5L+ctqO+GNfDn4XsJa402QrBAvrH/5BRaSpOuGSZ9mvwHnLDRDAbt2EjB5eu+
	 63/NzIza8HSy+W0H9U6enJ4eKY0sxVFcjD1pVLpCLQ/ZKUcqyeHaHx01XphDpEvZc3
	 Cw4yB4jIST/4yvQfxJFHZLkflQWdsJhTS89Ho9ozbcC8Imh5TmI11AumDcT99c4BBO
	 qUumbAY1wkt4Apdns4sLVNISPSjVXH39XbTgN1+D/6rM8jO1sIPCCfQT1ku6+cv+UE
	 qanksvMgnAwMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v8 4/8] mptcp: remove CB offset field
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
In-Reply-To: <e5a0ab26b1dae80ae284ebe5e3adf24840f68589.1787644449.git.tanggeliang@kylinos.cn>
References: <cover.1787644449.git.tanggeliang@kylinos.cn>
 <e5a0ab26b1dae80ae284ebe5e3adf24840f68589.1787644449.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 08:17:10 +0000
Message-Id: <20260825081710.E11791F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mptcp_inq_hint() can return arbitrarily large, bogus values to use=
rspace (via FIONREAD) due to a missing sequence sync check when the unread =
data length evaluates to less than INT_MAX, enabling a remotely triggerable=
 Denial of Service.
--

--- Patch [4]: [PATCH mptcp-next v8 4/8] mptcp: remove CB offset field ---
commit f21bf73a134ec25916ac8358db183f0eea8d9925
Author: Paolo Abeni <pabeni@redhat.com>

mptcp: remove CB offset field

This commit introduces a new msk-level field to track the bytes already
consumed inside each skb, similar to TCP, instead of using a CB offset
field. It synchronizes sequence spaces and simplifies hint calculations
and buffer moves.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -2408,26 +2391,26 @@ static bool mptcp_move_skbs(struct sock *sk)
>  	return enqueued;
>  }
> =20
> -static unsigned int mptcp_inq_hint(const struct sock *sk)
> +static unsigned int mptcp_inq_hint(struct sock *sk)
>  {
>  	const struct mptcp_sock *msk =3D mptcp_sk(sk);
> -	const struct sk_buff *skb;
> +	u64 hint_val;
> =20
> -	skb =3D skb_peek(&sk->sk_receive_queue);
> -	if (skb) {
> -		u64 hint_val =3D atomic64_read(&msk->ack_seq) -
> -			       MPTCP_SKB_CB(skb)->map_seq;
> -
> -		if (hint_val >=3D INT_MAX)
> -			return INT_MAX;
> -
> -		return (unsigned int)hint_val;
> +	/* Avoid races vs ack_seq updates. */
> +	mptcp_data_lock(sk);
> +	hint_val =3D atomic64_read(&msk->ack_seq) - msk->copied_seq;
> +	mptcp_data_unlock(sk);
> +	if (hint_val >=3D INT_MAX) {
> +		if (test_bit(MPTCP_SYNC_SEQ, &msk->cb_flags))
> +			return 0;
> +		return INT_MAX;
>  	}

[Severity: High]
Does this logic allow un-synced sequence lengths smaller than INT_MAX to
leak into userspace?

If a server application is actively reading data in recvmsg() (holding the
socket lock) and a remote attacker sends a third ACK with MP_CAPABLE, the
softirq defers updating copied_seq by setting the MPTCP_SYNC_SEQ bit.

Because the test_bit(MPTCP_SYNC_SEQ, ...) check is nested inside the
if (hint_val >=3D INT_MAX) block, an attacker could bypass the sync check by
crafting a sender_key such that the resulting hint_val is just under INT_MA=
X.

Could this return an arbitrarily large hint_val to userspace via FIONREAD
(TCP_INQ), potentially leading to massive application-level memory allocati=
ons
and rapid memory exhaustion?

> =20
> -	if (sk->sk_state =3D=3D TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN))
> +	if (!hint_val &&
> +	    (sk->sk_state =3D=3D TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN)))
>  		return 1;
> =20
> -	return 0;
> +	return (unsigned int)hint_val;
>  }
> =20
>  static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787644449.gi=
t.tanggeliang@kylinos.cn?part=3D4
