Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037744B04B9
	for <mptcp@lists.linux.dev>; Sat,  5 Sep 2026 18:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788633335; cv=none; b=o7dFtXoiw+h6Kul9xtZ27z/dYbyh2wgm715RL+Um5muYqwK0krOV9g/kZCFdodSkeAnEv34NZQsuS81TgcNYKSmPZSTBL+d41HgWpNNO9HzsUJgtL9RSAN2pp/KI5Y3zra/nCB0H5kL/G9uddDaLDy/a7WwwwMa+wpjOcLQ9sR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788633335; c=relaxed/simple;
	bh=cB0lawv8ssTo7+gtNcetFnr8UP/DV7pXOx1d294ddro=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RVCkxFxgvoNHFH9kCw9jrO2VNlOkI4AVCVhP1GL04JSKmIiDIz5LXKau9fLq9CG/onLpjUZErw/Utq3Vu6M8ZOIljydfBeyDOYj9hBlS7mQyqQ8jd0Alxvxq348KsVXRnYUqXa2xH6xx6S3Tf+QFx4CwMQzoBy9IEwj/tCbTJ1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cyGRuALf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cyGRuALf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5ACE1F00A3A;
	Sat,  5 Sep 2026 18:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788633330;
	bh=RjFcgfKsgrQ7lNxuMlPOlG5NDOTtAuBBHUseEJsc/aw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cyGRuALfPRGnbepFwZPq/rKb/0YuN2djT9LtrRxr7LfSeOsMcdSjJpLegyWtCS0Xp
	 sybJGe6UprbKxHm6vfRct53YQ/FFfG0zx/7cnaP1cpj5bdC2dKEiQnZzBXWtLYOBvI
	 NNaxi0AFkhjfjL/vsQll+L3EvWsbY7wGdF/T7LeMYKQXMKoYlHwa2cap/xoRP6SdFv
	 Ivj9SLU3guEA/RqIu8bb+UmxfoSL2xVMNgWRBsaYk1dJZa/SAC22hNV+Xm/UuxBDUN
	 mUbbZkebpBgANVirz+JHDQOFicrUTxFMiw0ymhAp1mRcb88pvAAE9NGM8YdLyjmyyl
	 IUoqO67VaeT8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH stable 6.12 v2] tcp: fix potential race in
 tcp_v6_syn_recv_sock()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Florian Fainelli" <florian.fainelli@broadcom.com>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260904183500.3841094-4-florian.fainelli@broadcom.com>
References: <20260904183500.3841094-1-florian.fainelli@broadcom.com>
 <20260904183500.3841094-4-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 18:35:30 +0000
Message-Id: <20260905183530.C5ACE1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The backport fails to apply the `pinet6` initialization fix to the=
 DCCP subsystem, leaving DCCP IPv4-mapped IPv6 sockets vulnerable to the or=
iginal race condition.
- [High] Listener's IPv6 lists and options are incorrectly freed if routing=
 fails for a v6-mapped TCP or DCCP child socket, due to a stale `pinet6` po=
inter.
--

commit e1ad03aa81aeb31e12241a45ce49d5481393aa47
Author: Eric Dumazet <edumazet@google.com>

tcp: fix potential race in tcp_v6_syn_recv_sock()

The commit moves the initialization of the IPv6 state for an IPv4-mapped IP=
v6
child socket to before the socket is inserted into the ehash table. This fi=
xes
a race condition where other CPUs could access the partially initialized so=
cket.

Link: https://patch.msgid.link/20260217161205.2079883-1-edumazet@google.com

> diff --git a/net/dccp/ipv4.c b/net/dccp/ipv4.c
> index 5926159a6f204..b8f5e20368ec5 100644
> --- a/net/dccp/ipv4.c
> +++ b/net/dccp/ipv4.c
> @@ -410,7 +410,9 @@ struct sock *dccp_v4_request_recv_sock(const struct s=
ock *sk,
>  				       struct request_sock *req,
>  				       struct dst_entry *dst,
>  				       struct request_sock *req_unhash,
> -				       bool *own_req)
> +				       bool *own_req,
> +				       void (*opt_child_init)(struct sock *newsk,
> +							      const struct sock *sk))
>  {
>  	struct inet_request_sock *ireq;
>  	struct inet_sock *newinet;

[Severity: High]
This isn't a bug introduced by this patch, but does this backport completely
fix the race condition for DCCP?

The `opt_child_init` parameter is accepted in `dccp_v4_request_recv_sock()`=
 but
is never executed. When `inet_ehash_nolisten()` is called later in this
function, the socket becomes visible to other CPUs.

> diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
> index d6649246188d7..c1db853667479 100644
> --- a/net/dccp/ipv6.c
> +++ b/net/dccp/ipv6.c
[ ... ]
> @@ -434,7 +436,8 @@ static struct sock *dccp_v6_request_recv_sock(const s=
truct sock *sk,
>  		 *	v6 mapped
>  		 */
>  		newsk =3D dccp_v4_request_recv_sock(sk, skb, req, dst,
> -						  req_unhash, own_req);
> +						  req_unhash, own_req,
> +						  opt_child_init);
>  		if (newsk =3D=3D NULL)
>  			return NULL;

[Severity: High]
This is a pre-existing issue, but DCCP still performs the IPv6 initializati=
on
manually after `dccp_v4_request_recv_sock()` returns and the socket is alre=
ady
in the ehash table.

Could this leave DCCP IPv4-mapped IPv6 sockets vulnerable to the same race
condition where another CPU accesses the child socket's `pinet6` concurrent=
ly?

> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index 5afe5e57c89b5..550d64babb94e 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
[ ... ]
> @@ -1796,6 +1798,10 @@ struct sock *tcp_v4_syn_recv_sock(const struct soc=
k *sk, struct sk_buff *skb,
>  	}
>  	sk_setup_caps(newsk, dst);
> =20
> +#if IS_ENABLED(CONFIG_IPV6)
> +	if (opt_child_init)
> +		opt_child_init(newsk, sk);
> +#endif
>  	tcp_ca_openreq_child(newsk, dst);
> =20
>  	tcp_sync_mss(newsk, dst_mtu(dst));

[Severity: High]
This is a pre-existing issue, but does placing `opt_child_init` here leave =
the
early routing failure path exposed to memory corruption?

Earlier in `tcp_v4_syn_recv_sock()`, `inet_csk_route_child_sock()` can fail
(e.g., due to an unroutable spoofed source IP) and jump to the `put_and_exi=
t`
label.

Because `opt_child_init` has not yet been called, `pinet6` still points to =
the
listener's `ipv6_pinfo`. When `tcp_done(newsk)` is subsequently called in t=
he
error path, it invokes the IPv6 socket destructor. Will this incorrectly fr=
ee
the listener's IPv6 lists and options, leading to a resource leak or crash?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904183500.3841=
094-4-florian.fainelli@broadcom.com?part=3D1
