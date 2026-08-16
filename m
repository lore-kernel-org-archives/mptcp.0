Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915D338C433
	for <mptcp@lists.linux.dev>; Sun, 16 Aug 2026 01:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786842739; cv=none; b=ApPmqK0wakCHAgkaRmZiTHIFg4xf9Wx6KSCOa/rFUCSZvKhMOfpZDvfZ3zw/H2pAfpNERyQYL/EntNyLcezt6KJbmgA11T6hjMA3obIEH9dCrshcFjfm49dOU3PRRJnlA10lp89yFMKt9xiZljD7KwWcT8efZ4fKnw3BGA+w9Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786842739; c=relaxed/simple;
	bh=Yd32Cis52+d2lqcJ/gjledP4r0Fya178CjKqRn2bYR8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nK5vvm+5sdkfqxAvDhy2AHVpfQYJqK1sAUzVSjpTqAxv6SSHMoYNKL7my1QlyKul59lUAIdZBBPvAFZPmaOSXIQH73HORTHv1pfzRL3N6cGI+BdIjNW11KO8Zke5DANptOhM1gcFlY9xxKLwHm4W183ERP326Fc2DDd9G1ILxpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HK3VPPs6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HK3VPPs6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 020481F000E9;
	Sun, 16 Aug 2026 01:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786842738;
	bh=9ZET8BdZPn8K5vK2klEUK72Y9O9KfFudTgvpi4WjK1Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HK3VPPs6cgKDE/zWnAyDadIxCpd+gmf9ph0kmvN5U1jP3fChSUlRviXnxh76OrQZi
	 0ZtxcI5IN6dM/ETvGXoYCw4cS+H0XNScNR/8XPfYyxvHrgkb0TupZmiU/OuyUacQ8H
	 PnGlB4q74yiOGNgWLQgYQLhk17IPkma/ZLlaWziryUBWy+W8K7Krls9CJi22C4KZ8b
	 s20vhBZgBX9ekMrYC8wLkBzW160Oj3S3UHHsFQMzvXeWqpXqaDNbV6wkyqWpmuUvNT
	 +RoP4Hhs7fNxRmUnt6Q1AH2XTdvzTqjzFdapQOFNl20w+Dih7qfyULwSCtnBjSzswK
	 lGdVbMo4YZcaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] nvmet-tcp: support IPv6 traffic class
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
In-Reply-To: <7d09c3211dfa76d536c7a30505cea6da626ee5e6.1786841319.git.tanggeliang@kylinos.cn>
References: <cover.1786841319.git.tanggeliang@kylinos.cn>
 <7d09c3211dfa76d536c7a30505cea6da626ee5e6.1786841319.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 16 Aug 2026 01:12:17 +0000
Message-Id: <20260816011218.020481F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The nvmet_tcp_sock_set_tclass function attempts to configure the=
 IPv6 Traffic Class by passing a 1-byte length to do_sock_setsockopt. Howev=
er, do_ipv6_setsockopt rigidly requires the option length to be at least 4 =
bytes for IPV6_TCLASS. As a result, the operation fails with -EINVAL, which=
 is silently ignored, and the traffic class is never applied.
--

--- Patch [3]: [PATCH v3 3/4] nvmet-tcp: support IPv6 traffic class ---
commit 97f9471c35e4e1cd4f5b7c6f1f3a6b3f8e13683a
Author: Geliang Tang <geliang@kernel.org>

nvmet-tcp: support IPv6 traffic class

Currently, nvmet-tcp only applies the received IPv4 TOS value when setting
up a queue socket, but does not handle the IPv6 traffic class. This patch
extends the queue socket setup to handle AF_INET6 sockets.

> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index e64592b792577..d34249cf37564 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1735,6 +1735,20 @@ static void nvmet_tcp_sock_set_tos(struct sock *sk)
>  				   KERNEL_SOCKPTR(&tos), sizeof(tos));
>  }
> =20
> +static void nvmet_tcp_sock_set_tclass(struct sock *sk)
> +{
> +#if IS_ENABLED(CONFIG_IPV6)
> +	if (sk->sk_family =3D=3D AF_INET6) {
> +		u8 tclass =3D ip6_tclass(inet6_sk(sk)->rcv_flowinfo);
> +
> +		if (tclass > 0)
> +			do_sock_setsockopt(sk->sk_socket, false, SOL_IPV6,
> +					   IPV6_TCLASS, KERNEL_SOCKPTR(&tclass),
> +					   sizeof(tclass));
[Severity: Medium]
Will this silently fail to set the traffic class?

Looking at do_ipv6_setsockopt() in net/ipv6/ipv6_sockglue.c, the IPV6_TCLASS
handler explicitly requires a minimum optlen of sizeof(int):

    case IPV6_TCLASS:
        if (optlen < sizeof(int))
            goto e_inval;

Since tclass is a u8, sizeof(tclass) is 1. This causes the internal
setsockopt implementation to reject the option with -EINVAL, leaving the
traffic class unset.

Would it be better to store the traffic class in an int variable before
passing it to do_sock_setsockopt()?

> +	}
> +#endif
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1786841319.gi=
t.tanggeliang@kylinos.cn?part=3D3
