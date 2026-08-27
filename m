Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAEC41D64E;
	Thu, 27 Aug 2026 17:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787850858; cv=none; b=H03T5MqOM9Z5/10JWa/3H83KTbU9jQ6KJCsf+YNJFpFcItgs+BenSTQ/ldO7OclPk4Bsf5j4AT+vWopIgG1ey5vNnwRKN8Y8wKZIkLRsIIMjvgI7eOZDgng0x1aRgcAoOsWsGOmu7Cf8XnVHEjJwbF4rn+L4zYCE3ePytKSS2kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787850858; c=relaxed/simple;
	bh=FqQUW+ZSVMadaajlbySqSibhZfeHnkAeb7jDVQNafJg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G72gpZdjJu6+ALQ2IhJp/2uS38gYEbMAyLVUnlr76ZDtTQFRixrgucYvM8/HLO78h9uhchKhlVe4CwHR5WBQT/AgrQlFAzFNpSSlTt9g2BVpDvxswVX9S/r8yiLCZEK1NfIA85KjlKHRrBMU5NcQSM/MP230lI4bOPswOgZ/2LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8hnV4v5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8hnV4v5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE5DA1F00A3A;
	Thu, 27 Aug 2026 17:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787850857;
	bh=eobvjL47OENI6zedR//VmiWcf1UYCQAFkij8q9JWxWI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c8hnV4v5X+nmbTY1Z8ZjqjSNHq1nVHTnOjZ5HntsOnZc91kE0yuvCdT9mI0yhR8Ow
	 KVdszL8SlhCOkI3yHq0au0es6fgWktYZKgz1cuoei+T4C0+Laihs0B3L6oYXbWNTVN
	 EOCaFGSU6AMo8rF0tZkzdl8nz/oLwQzYz9jENz4sy1iTiz6Ems/Or1j4OjlGpgR52q
	 n0sWH2nP4Om0LuaarnuJ5n+Bt5x2AOaP5rF1xGkHP4Y/xjtG+lQB0My+rjzFz68Olw
	 mfQKqSiMP6IEBD6qY73nxbbWAWDtt9BPMtfxp03B5b3OjQUR/5Ow74QT/LUbywZ5Ps
	 Ob1INoTmVVOXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 1/2] tcp: fix use-after-free in
 do_tcp_getsockopt(TCP_CONGESTION)
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Q2VuIFpoYW5nIChNaWNyb3NvZnQp?= <blbllhy@gmail.com>
Cc: bpf@vger.kernel.org, mptcp@lists.linux.dev
In-Reply-To: <20260826171344.4133-2-blbllhy@gmail.com>
References: <20260826171344.4133-1-blbllhy@gmail.com>
 <20260826171344.4133-2-blbllhy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 17:14:16 +0000
Message-Id: <20260827171416.CE5DA1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The variable `ca_ops` is used but never declared in the `TCP_CONGES=
TION` block.
--

commit 7bf16b98f97797b307198d9ae8e078d4cbb59158
Author: Cen Zhang (Microsoft Security FORGE Labs) <blbllhy@gmail.com>

tcp: fix use-after-free in do_tcp_getsockopt(TCP_CONGESTION)

do_tcp_getsockopt() reads icsk->icsk_ca_ops->name without holding
rcu_read_lock(). Since commit 0baf26b0fcd7, icsk_ca_ops can point to
dynamically allocated BPF struct_ops memory that may be freed concurrently =
via
setsockopt(TCP_CONGESTION), leading to a use-after-free.

Link: https://lore.kernel.org/all/20260821182449.79785-2-blbllhy@gmail.com/

> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index b4237d0e994d6..4918f48ba76d5 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -4577,16 +4577,24 @@ int do_tcp_getsockopt(struct sock *sk, int level,
>  		val =3D !inet_csk_in_pingpong_mode(sk);
>  		break;
> =20
> -	case TCP_CONGESTION:
> +	case TCP_CONGESTION: {
> +		char ca_name[TCP_CA_NAME_MAX] =3D {};
> +
>  		if (copy_from_sockptr(&len, optlen, sizeof(int)))
>  			return -EFAULT;
>  		len =3D min_t(unsigned int, len, TCP_CA_NAME_MAX);
>  		if (copy_to_sockptr(optlen, &len, sizeof(int)))
>  			return -EFAULT;
> -		if (copy_to_sockptr(optval, icsk->icsk_ca_ops->name, len))
> +
> +		rcu_read_lock();
> +		ca_ops =3D READ_ONCE(icsk->icsk_ca_ops);

[Severity: Low]
Does this introduce a compilation error in do_tcp_getsockopt() because ca_o=
ps
is used but never declared in the TCP_CONGESTION block?

It appears ca_ops is scoped only inside the adjacent TCP_CC_INFO case block
and is not declared at the function level or within this block, which will
cause a build failure.

> +		memcpy(ca_name, ca_ops->name, sizeof(ca_name));
> +		rcu_read_unlock();
> +
> +		if (copy_to_sockptr(optval, ca_name, len))
>  			return -EFAULT;
>  		return 0;
> -
> +	}
>  	case TCP_ULP:
>  		if (copy_from_sockptr(&len, optlen, sizeof(int)))
>  			return -EFAULT;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826171344.4133=
-1-blbllhy@gmail.com?part=3D1
