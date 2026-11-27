Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795784452;
	b=oLihxkrHzsopeO5RXrFNuOrZKGBHqpkfIzETjQ7LqyaFqzN8YXvfTS/VONbeF/eBB2w4
	 C3klggPkfG3DuU3Tohbz8cz8azPSEIB/8T08D9lRPFsjKo6NuG5NzXz45+Pokr/z5a2WQ
	 iIqiHapLZp+2wXQvZSLV1PTAjglzmGU0lG6bI6F1Z6BVUPqe9/zE28hVVrNNpQp1huDLx
	 tokJPHV33lbgMNeELpMZIV4EYYZkFxhDDv1qizMJmS7gUHLePu6AJ2PPYWoN1d5Cabn2G
	 ubW0OjFs4vXceg2ppnBOrjXucCNN0oBjJ23v6G8niZpqX6Zf0Xb+kiXN7GNU+MUoOoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795784452;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HXxEBRqIb0cifldOXpnQdO/CKsXoxE2GdmajvjMmMCA=;
	b=wwKdiXI4v+s099KIXk4vJ0gqPlk3uODLeSJcm9SfC7yMMflypaqUQbeKTzaWFPLFP9Ef
	 VJXs0tH0EPPeHB2uHvomkIN7S+C/KwHero1R+SQVzII1KLyWqZtdZQ5my4ZiogDm/iOTO
	 a+dXOKnjJzS89Jh55iNGCs2y9ulcMUkc4rbFGKA9YwBOUb+T8jXSxkIzQzELXmwizsY6A
	 llUJBOPHTD0yBef5wyWLyE3yoy3jdmGfZhUbDM2agcmLW94EJJXeAKGqkECjTPTm/sr5E
	 TYGcaPTc5eso+Zwrc1TJVJsKU4qNxhxgAF/+sp38o0iUa0cDxxu4rWTfvQBXX59fJ2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VdFbwihl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F72606A323
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 13:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VdFbwihl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C95A31F00893;
	Fri, 27 Nov 2026 13:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795784451;
	bh=HXxEBRqIb0cifldOXpnQdO/CKsXoxE2GdmajvjMmMCA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=VdFbwihlCOsdKkS/38mFiMe9pvoBTHdgJeDlN7Ad+D2eBUZRuAoDOHqskfuLMoZ1d
	 SeZyhQF0iPzw/AE6gzPFRnaP/e15KHL8WOXsl8NJCFd79AdJcdYMW2F0Nc0d2syYyP
	 T9yNoGhYOj4iegtwOODsNZHBxemh2Dme1Tvy+OLPgwTrr7W4hrRzhw7/aTB37D9fpN
	 TBwU0opt+PZge3Zr0kMbV187ZKBb34+BYpCtF6F/yEMJznmvfhtsTCHdmBcAfzR0rq
	 TtlP2WfAQWBFObf9jVv5VYni9jdBrdFL1l0eoBdMA/Fo6RqGRg8WJvxqAU0ZNdUWBi
	 Jx9zFyQKRbkhw==
Message-ID: <sashiko-outbox-237455@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v11 6/7] selftests: net: msg_zerocopy: add
 MPTCP support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <3c4914ba16cf7712f0cda60f9d8ca1bc7d8e49ca.1795783388.git.tanggeliang@kylinos.cn>
References: <cover.1795783388.git.tanggeliang@kylinos.cn>
 <3c4914ba16cf7712f0cda60f9d8ca1bc7d8e49ca.1795783388.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 13:00:51 +0000
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
- [Low] selftests: net: missing IPv6 MPTCP support check in
  msg_zerocopy.sh
--

commit 9cc486d6ab2a729fb7c0e3662152245a03185926
Author: Geliang Tang <geliang@kernel.org>

selftests: net: msg_zerocopy: add MPTCP support

This commit adds "mptcp" and "check" test modes to msg_zerocopy.c and
updates msg_zerocopy.sh to run IPv4 and IPv6 MPTCP zerocopy tests.

> diff --git a/tools/testing/selftests/net/msg_zerocopy.sh b/tools/testing/=
selftests/net/msg_zerocopy.sh
> index 28178a38a4e7b..a9cb6b449f342 100755
> --- a/tools/testing/selftests/net/msg_zerocopy.sh
> +++ b/tools/testing/selftests/net/msg_zerocopy.sh
> @@ -32,13 +32,20 @@ if [[ "$#" -eq "0" ]]; then
>  	$0 4 udp -t 1 || ret=3D1
>  	$0 6 udp -t 1 || ret=3D1
> =20
> +	if ${BIN} -4 -t 1 check && ${BIN} -4 -t 1 check -z; then
> +		$0 4 mptcp -t 1 || ret=3D1
> +		$0 6 mptcp -t 1 || ret=3D1
> +	else
> +		echo "SKIP: MPTCP tests (not supported)"
> +	fi

[Severity: Low]
Should this check IPv6 MPTCP support with -6 before running the IPv6
subtest?

Both check invocations pass -4 (and the second check with -z already
tests socket creation), so IPv6 MPTCP support is never probed.  Because
CONFIG_MPTCP_IPV6 depends on CONFIG_IPV6=3Dy, a kernel built with
CONFIG_MPTCP=3Dy and CONFIG_MPTCP_IPV6=3Dn (for example when CONFIG_IPV6=3D=
m)
passes the -4 checks and then fails "$0 6 mptcp -t 1" with
EPROTONOSUPPORT instead of skipping it.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795783388.gi=
t.tanggeliang@kylinos.cn?part=3D6
