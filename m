Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCEB38AC68
	for <mptcp@lists.linux.dev>; Sun, 16 Aug 2026 01:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786842598; cv=none; b=iOfVq7MHQkpMYF69BaoeCcXENGydsibWtQ1B2Wh2HvwcrNSpj9rYxR08dvxr9hEpxi93kMecpQazQzdpDOa+GZINtuunMmPpI+OsDaJJRtqwI0xEQ6FBMXu30wPmwg2NvO+Zdyh/s67I4JP+BfGdjr7Rfmod60dClmxlCu+TyBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786842598; c=relaxed/simple;
	bh=Icwqq2RsXn5LO3KyCWNTzMzMfzMjHkYLvWpioF872eI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Lh+7jQuZObphT/fY6G5xYC49OGVcpDqcIK9j0UrHfpAO5yr29CkHTx/o0+iOzM9KUfQogfok139FHeNiKrI0jAqS8+JMLP06Cx38nsjoLxcU80D4tBZBYn8J5ORFr6ihGPeuEr81YigF8+UZaWJRo+FJSvwPkIeTYgAf/x3knbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFiNE3sF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFiNE3sF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 285D91F000E9;
	Sun, 16 Aug 2026 01:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786842597;
	bh=XXBIg9fQ91SFRH8B5KV3o/wkpdkwhzWfpKJ2ylmyEj8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SFiNE3sFEIAo0LccjaZ5CwolIDp2lj5h8UQowoWag8L6US4vfnNLuMpiFBmRXwtF0
	 iUUPH0kqQ/pMmd0p+ew8uJqkPozW1RCfa5qByq2k5JTHC+h/V4oVtqFqzeVUuigh7y
	 wyzGSsgQnCCzjOUYEfgYOxWbeHaiEMOamLOQLPfDwiB+Vo0wsJ9SVo/JrtQl4HTUc5
	 rgb02fNnb6jcXBB0MjcSLAXifGyf07cvsbypsoKg1NP5vtl5Ab6ZQbltxQSEay4yeH
	 tPoRZoLBGeUqHT/z0tPU/hUgknvfd52uvVIVcXW06MkQuLDmIHfu677e/L4ZLCDDc3
	 UlygV5GBClfNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] nvme-tcp: support IPv6 traffic class
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
In-Reply-To: <52c4840e36ee6016d18806c2d205f4f9fdc1e830.1786841319.git.tanggeliang@kylinos.cn>
References: <cover.1786841319.git.tanggeliang@kylinos.cn>
 <52c4840e36ee6016d18806c2d205f4f9fdc1e830.1786841319.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 16 Aug 2026 01:09:56 +0000
Message-Id: <20260816010957.285D91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The NVMe TCP target silently fails to set the IPv6 traffic class=
 because it passes a 1-byte option length for IPV6_TCLASS.
--

--- Patch [4]: [PATCH v3 4/4] nvme-tcp: support IPv6 traffic class ---
commit f06d75be38a565495a1d84b7e856f1a1a552b88e
Author: Geliang Tang <geliang@kernel.org>

nvme-tcp: support IPv6 traffic class

This commit extends the NVMe TCP host queue socket setup to support the IPv6
traffic class. It applies the TOS value to IPv6 sockets via the IPV6_TCLASS
socket option.

> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 3bc41a4735d94..feedd46bd3a2b 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
[ ... ]
> @@ -1815,6 +1815,15 @@ static void nvme_tcp_sock_set_tos(struct sock *sk,=
 int tos)
>  			   KERNEL_SOCKPTR(&tos), sizeof(tos));
>  }
> =20
> +static void nvme_tcp_sock_set_tclass(struct sock *sk, int tclass)
> +{
> +#if IS_ENABLED(CONFIG_IPV6)
> +	if (sk->sk_family =3D=3D AF_INET6)
> +		do_sock_setsockopt(sk->sk_socket, false, SOL_IPV6, IPV6_TCLASS,
> +				   KERNEL_SOCKPTR(&tclass), sizeof(tclass));

While reviewing this patch, I noticed a related bug in the target implement=
ation
which handles this exact same logic.

In drivers/nvme/target/tcp.c:nvmet_tcp_sock_set_tclass():

	u8 tclass =3D ip6_tclass(inet6_sk(sk)->rcv_flowinfo);

	if (tclass > 0)
		do_sock_setsockopt(sk->sk_socket, false, SOL_IPV6,
				   IPV6_TCLASS, KERNEL_SOCKPTR(&tclass),
				   sizeof(tclass));
                                   ^^^^^^^^^^^^^^

[Severity: Medium]
Will this setsockopt call fail silently in the target code?

The tclass variable is declared as a u8, so sizeof(tclass) evaluates to 1. =
The
IPv6 networking core strictly requires an option length of at least 4 bytes=
 for
IPV6_TCLASS.

Passing sizeof(u8) causes do_ipv6_setsockopt() to return -EINVAL, which mea=
ns
the IPv6 traffic class is silently ignored instead of being applied to the
socket, leading to incorrect QoS behavior without alerting the user.

Does the target code need to be updated to pass a 4-byte length?

> +#endif
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1786841319.gi=
t.tanggeliang@kylinos.cn?part=3D4
