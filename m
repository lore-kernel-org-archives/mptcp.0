Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794928264;
	b=Dxr82XmDUkyS0gIKFqRPAqWIhe4BVZkqNb9ATEiR52HZ5vOtToPJ3HciWzV3KpV+wuiP
	 NZ6ahhx1E9YuMij0HfFQwpAHMi3byqokW/pPP7orxOHPO8w+FZmRxS6A66qPumDpDGRLx
	 NRwuEVQok9konYhtKiyWFzQ7AOutt+ZaGJL/E9Vf4KLsZ71ElYsl4Yz8niYZhDYzbv6+k
	 fFmv0CjWPvLSjJCVGHto/7DvtLAv4FCCO55SGKDqWoTc7/x2Kl7AYuNAk2KWj/mmQ/tPK
	 DMeZNm2erOpFsQdPmjKQz2W/H1yB8HGY3C/N+ucuPyWmLox2J3AUq6Rh7N9yEthsn2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794928264;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QfvHqkLAdYHUJtm4dTqvpmLc/YyGxrDki3P/MiJdOyk=;
	b=F9Lg0am0CWUXOMMjwqGA8gm61tdjGKcemVeDBpZCQyNy83AtNOs/7PMSdOUC94XaVGvg
	 tUBOXRIAH299Zh59Wr6rKaR6h+x6c6Jak1bo0dzu3oES7bFtKv0PIM5XoGkp64dg+ufY2
	 FPckVAZICm3tQsyL7zw8APedpzfL75qA5L6iEmVHVrXWvXT0j8E7PUeQVHz6SX/7M9VW5
	 PkoFpXDDcyERru4VO1qXOf2l7+E9G8bRbh/MxMOoa5bVDsS89W8eepEeBqdqa5/2S8ZJs
	 Ltl6WO2d/TuCGZ5nchZnUEgvc0QCt6St3vZrsgtds1de9is71F4VTyVyf1YI02FGvDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gskSwlPc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F9E606A31C
	for <mptcp@lists.linux.dev>; Tue, 17 Nov 2026 15:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gskSwlPc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0937E1F000C9;
	Tue, 17 Nov 2026 15:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794928264;
	bh=QfvHqkLAdYHUJtm4dTqvpmLc/YyGxrDki3P/MiJdOyk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gskSwlPcDXAKVD5iiulqumzJuECEcMwzVHzuT1jvYMMfJjql+XgkffT/PSc0ajbKf
	 oRQLkC/L57Htf5aos1Ud68dnSZ2s05YwhzT7Z1TYyckfE8VwdIbsZAqrAqC9EYxJkK
	 b0ugCbcCM9Ye0I8DEr2LqnQqYAOBCeMU7G49oscq/5SbHNfAMoVwXxFvPpC3JT6kTd
	 6eEIZhcUagRfZn0YwWPgDY347WSG+fc6ntW55rknCqxEZF/+r3CsY6Nw0ojTVzU0of
	 KiekLSN3237o+9gGry0RIXRWSd11D9PfSfjsYU3RfGhr6SD59tW9YCxDUzSx/ebCer
	 T9rqRhqLfNiCg==
Message-ID: <sashiko-outbox-219033@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v5 2/3] net: mptcp: reject token 0 in
 mptcp_token_get_sock()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hang Nan" <2122295973@qq.com>
Cc: mptcp@lists.linux.dev
In-Reply-To: <tencent_46FC62D4DE8FB8E6C90049F5AB28BDAA8C05@qq.com>
References: <20261116145829.96849-1-2122295973@qq.com>
 <tencent_46FC62D4DE8FB8E6C90049F5AB28BDAA8C05@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 15:11:03 +0000
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
- [Medium] mptcp: missing EXPORT_SYMBOL_GPL for mptcp_token_exists()
--

commit 58d873c76950c5892687659dc3383bb38a22332f
Author: Hang Nan <2122295973@qq.com>

net: mptcp: reject token 0 in mptcp_token_get_sock()

This commit rejects token 0 in mptcp_token_get_sock() so that lookups cannot
match sockets that are being torn down or have not been hashed yet, and adds
a KUnit test covering this case.

> diff --git a/net/mptcp/token_test.c b/net/mptcp/token_test.c
> index be9acce8a5673..2418d392ff7b9 100644
> --- a/net/mptcp/token_test.c
> +++ b/net/mptcp/token_test.c
> @@ -132,11 +132,62 @@ static void mptcp_token_test_destroyed(struct kunit=
 *test)
>  	mptcp_token_destroy(msk);
>  }
> =20
> +static void mptcp_token_test_zero(struct kunit *test)
> +{
> +	struct mptcp_subflow_request_sock *req =3D build_req_sock(test);
> +	struct mptcp_sock *msk =3D build_msk(test);
> +	struct mptcp_sock *null_msk =3D NULL;
> +	u32 token =3D 0;
> +	int i;
> +
> +	/* An empty chain does not answer a lookup for token 0 either. */
> +	KUNIT_EXPECT_PTR_EQ(test, null_msk, mptcp_token_get_sock(&init_net, 0));
> +
> +	/* Build the state a socket being torn down, or one that has just been
> +	 * allocated, presents to a reader: hashed and carrying token 0.  A
> +	 * lookup for token 0 only reaches a socket that hashes to bucket 0,
> +	 * and the token a connection gets is random, so retry until one lands
> +	 * there; mptcp_token_exists() reports that without going through the
> +	 * guarded lookup.
> +	 */
> +	for (i =3D 0; i < (1 << 20); i++) {
> +		/* the token is derived from local_key, so vary it */
> +		mptcp_subflow_rsk((struct request_sock *)req)->local_key =3D i + 1;
> +
> +		if (mptcp_token_new_request((struct request_sock *)req))
> +			continue;
> +
> +		token =3D req->token;
> +		msk->token =3D token;
> +		if (!mptcp_token_accept(req, msk))
> +			continue;
> +
> +		WRITE_ONCE(msk->token, 0);
> +		if (mptcp_token_exists(0))
> +			break;

[Severity: Medium]
Does calling mptcp_token_exists() here break the build when
CONFIG_MPTCP_KUNIT_TEST=3Dm?

MPTCP is built-in while mptcp_token_test can be built as a module, and
unlike the other token helpers in net/mptcp/token.c, mptcp_token_exists() is
not exported under #if IS_MODULE(CONFIG_MPTCP_KUNIT_TEST), causing modpost
to fail with an undefined symbol error.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_BB8DA72524E=
32FD374B8B2950B247B62E207@qq.com?part=3D2
