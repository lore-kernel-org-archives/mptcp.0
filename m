Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347632D77F7
	for <mptcp@lists.linux.dev>; Sat,  5 Sep 2026 18:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788633336; cv=none; b=GIzZbokQdT4B9EjojFY9vHuU53z3xt1LrSlZbWxaAXNmM8mY8jQPz/XdfS34VMuGdrkcjrt8durHnY3XPC0tU0eE9+BM0donodZUfQbrn2uNmXQsDjnR6x/ZRiidMeAJ7hP/Trm7dkYrDGH2vh+zJz/7HGeGZqdmv6IDvbscn/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788633336; c=relaxed/simple;
	bh=0+HmKGXgkxmRJ2rejMjyP5rK0E8vqM0d5wgLkthaWzA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NJU/wxOdyMRItFoCUwTZOezZF/zlRKa+hZ0SSFbFNfYSg48hG6Kx+2dXgZfnEz4k6L4j9HKSA3WCnkRT+1FSmQrBH89Tj9iNRhUgotIdvvdDlLuUFK39+vqwufaIyNY6srmPJJStkojmuCTV/xOHrtKGEVZ/WyyUg65noCdPI6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FBXE8SQc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBXE8SQc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74CA31F00A3D;
	Sat,  5 Sep 2026 18:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788633331;
	bh=qlakSMDh8x9Jtu9T11zcOUvS4FLGRubIjPqqxeS2slM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FBXE8SQcJ2UUGLj6DasuwTc2os+S0r5hDDObWvU43yb/HJZedcMoaJe5Diagr5+yp
	 QMTYoPQ9DRXcRowl/vWK4y0Gvxg9AjBYQyiIfy45A1dYWMYeqCy5LhvrkW6dBXNTYP
	 BKiYtG1GtR3EDU3K3cFM8KP6Epvwrpv/BTyaa+RoktCWv4SUPXisExR1ej264TklnG
	 IC5ZfIts0mpwf+tjZpzSgxT+jpQlLvJocYAZLQxNR92id92mvUuGwNloCXekzmSYHw
	 aqY8VbEM/6VgnAAVIbwXi90Ayn1afmIpe1ZqsmKCCgQA4fmHLoTJ/56gzdTrR64X4C
	 FkQ5QQW+zRqaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH stable 6.1 v2] tcp: fix potential race in
 tcp_v6_syn_recv_sock()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Florian Fainelli" <florian.fainelli@broadcom.com>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260904183500.3841094-3-florian.fainelli@broadcom.com>
References: <20260904183500.3841094-1-florian.fainelli@broadcom.com>
 <20260904183500.3841094-3-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 18:35:31 +0000
Message-Id: <20260905183531.74CA31F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Error paths in the TCP and DCCP IPv4 request receivers destroy=
 the child socket before repointing its pinet6 pointer, causing a critical =
use-after-free on the listener's IPv6 options.
- [High] The backport failed to invoke the opt_child_init callback in the D=
CCP IPv4 request receiver, leaving the original ehash visibility race condi=
tion unpatched for IPv4-mapped IPv6 DCCP sockets.
--

commit cad9903f476bc3f080a19ad95250d56fbe8d45ce
Author: Eric Dumazet <edumazet@google.com>

tcp: fix potential race in tcp_v6_syn_recv_sock()

This commit addresses a race condition where a child socket becomes
visible in the TCP ehash table before its IPv6 fields are initialized.
It moves the initialization logic to a new helper that is called
prior to ehash insertion.

Link: https://patch.msgid.link/20260217161205.2079883-1-edumazet@google.com
Link: https://lore.kernel.org/netdev/69949275.050a0220.2eeac1.0145.GAE@goog=
le.com/

> diff --git a/net/dccp/ipv4.c b/net/dccp/ipv4.c
> index b780827f5e0a5..9ae9faa61d8d7 100644
> --- a/net/dccp/ipv4.c
> +++ b/net/dccp/ipv4.c
> @@ -409,7 +409,9 @@ struct sock *dccp_v4_request_recv_sock(const struct s=
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
This is a pre-existing issue, but the backport mechanically added the
opt_child_init parameter here without actually invoking it in the function
body.

Because the callback is ignored, the socket is inserted into the ehash
table before IPv6 initialization occurs:

	*own_req =3D inet_ehash_nolisten(newsk, req_to_sk(req_unhash), NULL);

This leaves the original race condition unpatched for IPv4-mapped IPv6
DCCP sockets.

Is it possible to invoke opt_child_init(newsk, sk) in this function prior
to the inet_ehash_nolisten() call, similar to what was done for TCP?

[ ... ]

> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index da46357f501b3..df4be07457421 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c

[ ... ]

> @@ -1549,6 +1551,10 @@ struct sock *tcp_v4_syn_recv_sock(const struct soc=
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

[Severity: Critical]
This is a pre-existing issue, but does this ordering create a use-after-free
if a routing or port inheritance failure occurs before opt_child_init is
executed?

If inet_csk_route_child_sock() fails before the above block, the code jumps
to the put_and_exit error label:

	if (!dst) {
		dst =3D inet_csk_route_child_sock(sk, newsk, req);
		if (!dst)
			goto put_and_exit;
	}

The put_and_exit handler destroys the new socket:

put_and_exit:
	newinet->inet_opt =3D NULL;
	inet_csk_prepare_forced_close(newsk);
	tcp_done(newsk);
	goto exit;

At this point, newsk's pinet6 pointer still points to the listener's IPv6
configuration. When tcp_done() cleans up the child socket, won't it free
the listener's structures (such as opt, pktoptions, and rxpmtu), causing a
double-free and use-after-free?

DCCP appears to share this identical pre-existing flaw in its
dccp_v4_request_recv_sock() error path. Can we ensure the pinet6 pointer
is updated or cleared before the child socket is destroyed in these paths?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904183500.3841=
094-3-florian.fainelli@broadcom.com?part=3D1
