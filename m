Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9074398F2
	for <mptcp@lists.linux.dev>; Thu, 24 Sep 2026 07:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790236265; cv=none; b=ecYOT5xTtu94ITIZAmIu+iWVR9OyNZna4EwaKJhNcM//hPpeOTBCA4K+mp3+leufhBdAik0a5etMK4VTOFddlGPptjbLK0sN4kT2lPWXUpnojKBQsJTAesYV0F6j1aNajb33KXEGDPRIJk/U5PqjvhV4mRIaGxNNbIj1YtNqSKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790236265; c=relaxed/simple;
	bh=NCYoDjC96JZWpa0Ml3XH6sYYU5owLur43FEXOIUoziI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BAC3FcGS9fFhQQKsP6E8JbOH/3TuM3PVYgAanhefnZOKU1q2U4PLrjCjsScSqt9mK8anXDffNOZGNSwVGtk58OAqQk310DoYLVWbWsagFKzf3RA3YsafXyvbLUnEPlG8RwOFmJ2eIMpzJCTTDeLjvxlyPw1A7oL2PO8n/qQT0kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VwqMMyvA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwqMMyvA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F211F00893;
	Thu, 24 Sep 2026 07:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790236263;
	bh=XxOo0z8R90ITimuTHoUf50+NMBiPsVas7lEFCRxmXcI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VwqMMyvA69n487HfaKf+wsSlOXdFOTe61AUD5F/URCZsBMVK53OokTWn1Y0yfh3FV
	 fSLdlGVJIjnn+MGrfUo1IEi/7bcjCkGtSv18lpyHOPiS0dSgXiBgEo1QkBuJemJ7Zn
	 BCAlc0DG4Oce3JCjXkoolOxnRMqBRiQBHo1xPRuNrCOevRnViVqvAJmlEJUsggDKUR
	 tDEWtLONdkum3U26a1tF544sG0QWIVw1dW6gP0geiKwlt263ENUmHIarc10+UmnQzU
	 lj2U50FnLf97ockfPS3z6cIe+0KTdYX6dNoNWaylsMkdASl/Ff9S+tx8c3X1ZQgCVC
	 GK1NhLxFpc0SA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC -next 2/5] tcp: sync memcg budget on protocol buffer
 updates
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cai Xinchen" <caixinchen1@huawei.com>
Cc: mptcp@lists.linux.dev, hannes@cmpxchg.org, tj@kernel.org, mkoutny@suse.com
In-Reply-To: <20260924080219.1036588-3-caixinchen1@huawei.com>
References: <20260924080219.1036588-1-caixinchen1@huawei.com>
 <20260924080219.1036588-3-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 07:51:02 +0000
Message-Id: <20260924075102.A3F211F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] tcp: memcg limit bypass via unhandled budget sync failures
--

commit e6770a5d905e4be1d779ff6b117516aca572b367
Author: Cai Xinchen <caixinchen1@huawei.com>
Date:   Thu Sep 24 08:02:16 2026 +0000

tcp: sync memcg budget on protocol buffer updates

This commit updates the memcg budget tracker during various TCP autotuning
and buffer adjustment operations by adding calls to sk_memcg_budget_sync()
after sk_sndbuf and sk_rcvbuf are written.

> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 1e2074f733f43..629ce7dc3032d 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -471,6 +471,10 @@ void tcp_init_sock(struct sock *sk)
> =20
>  	WRITE_ONCE(sk->sk_sndbuf, READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_wmem[=
1]));
>  	WRITE_ONCE(sk->sk_rcvbuf, READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_rmem[=
1]));
> +	/* The default buffers grew from the generic sock_init_data()
> +	 * values: charge the difference to the memcg.
> +	 */
> +	sk_memcg_budget_sync(sk, gfp_memcg_charge());

[Severity: High]
In tcp_init_sock(), if sk_memcg_budget_sync() returns false here (e.g., if
the memcg limit is reached), does this leave the socket buffers expanded
without being properly charged?

Could this allow a socket to consume uncharged memory up to the expanded
limits, bypassing memcg resource isolation?

[ ... ]
> @@ -1850,6 +1854,7 @@ int tcp_set_rcvlowat(struct sock *sk, int val)
>  	space =3D tcp_space_from_win(sk, val);
>  	if (space > sk->sk_rcvbuf) {
>  		WRITE_ONCE(sk->sk_rcvbuf, space);
> +		sk_memcg_budget_sync(sk, gfp_memcg_charge());

[Severity: High]
In tcp_set_rcvlowat(), if sk_memcg_budget_sync() fails to charge the memcg,
shouldn't sk_rcvbuf be rolled back to its previous value?

[ ... ]
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 892ff256e2352..9fdb2c66821b7 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -629,9 +629,11 @@ static void tcp_sndbuf_expand(struct sock *sk)
>  	sndmem =3D ca_ops->sndbuf_expand ? ca_ops->sndbuf_expand(sk) : 2;
>  	sndmem *=3D nr_segs * per_mss;
> =20
> -	if (sk->sk_sndbuf < sndmem)
> +	if (sk->sk_sndbuf < sndmem) {
>  		WRITE_ONCE(sk->sk_sndbuf,
>  			   min(sndmem, READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_wmem[2])));
> +		sk_memcg_budget_sync(sk, gfp_memcg_charge());
> +	}

[Severity: High]
In tcp_sndbuf_expand(), since this runs in softirq and uses GFP_ATOMIC,
memcg charges are more likely to fail under pressure.

If sk_memcg_budget_sync() returns false, does the expanded sk_sndbuf need
to be reverted to prevent uncharged memory consumption up to
sysctl_tcp_wmem[2]?

[ ... ]
> @@ -791,6 +793,7 @@ static void tcp_clamp_window(struct sock *sk)
>  	    sk_memory_allocated(sk) < sk_prot_mem_limits(sk, 0)) {
>  		WRITE_ONCE(sk->sk_rcvbuf,
>  			   min(atomic_read(&sk->sk_rmem_alloc), rmem2));
> +		sk_memcg_budget_sync(sk, gfp_memcg_charge());
>  	}

[Severity: High]
Is it safe to ignore the return value of sk_memcg_budget_sync() here after
expanding sk_rcvbuf in tcp_clamp_window()?

[ ... ]
> @@ -948,6 +951,7 @@ void tcp_rcvbuf_grow(struct sock *sk, u32 newval)
>  	rcvbuf =3D min_t(u32, tcp_space_from_win(sk, rcvwin), cap);
>  	if (rcvbuf > sk->sk_rcvbuf) {
>  		WRITE_ONCE(sk->sk_rcvbuf, rcvbuf);
> +		sk_memcg_budget_sync(sk, gfp_memcg_charge());

[Severity: High]
Similar to the other autotuning functions, if the charge fails in
tcp_rcvbuf_grow(), does this leave sk_rcvbuf increased without charging
the memcg?

[ ... ]
> @@ -6055,8 +6059,10 @@ static bool tcp_should_expand_sndbuf(struct sock *=
sk)
>  		 * it never goes below SOCK_MIN_SNDBUF.
>  		 * See sk_stream_moderate_sndbuf() for more details.
>  		 */
> -		if (unused_mem > SOCK_MIN_SNDBUF)
> +		if (unused_mem > SOCK_MIN_SNDBUF) {
>  			WRITE_ONCE(sk->sk_sndbuf, unused_mem);
> +			sk_memcg_budget_sync(sk, gfp_memcg_charge());
> +		}

[Severity: High]
Should sk_sndbuf be restored in tcp_should_expand_sndbuf() if the budget
sync fails here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924080219.1036=
588-1-caixinchen1@huawei.com?part=3D2
