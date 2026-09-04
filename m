Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B6E157487
	for <mptcp@lists.linux.dev>; Fri,  4 Sep 2026 00:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788480055; cv=none; b=JU63nh3SpDHtfBa0Mn/hOr2gBFr4Mf3W7QqTDSD++scEs0r5TvoVowAhX7gLF0T5fvjcC4/k/tnfrm88RZpmYdMIcjp3jLY0QRmDgdPqlZUqL2EMSB5p12gg/dzG03aVGDgsNwryyRxYKG5+GoiocdaTitTPcmebwI2g1GGT3e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788480055; c=relaxed/simple;
	bh=h/ll7yp1zdBHPwjIaz7Q3jZypS4YD6b3x8bWve0omWI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GmCFjX3DSa0XoIXi0snafUc2DJpwMNFykfP9DpwgoBwRi8WTI4E19X1ir7hs0Cs7AJzWphDqMPZsQL2ErR2wtyvsma74+GlIofurAf+QSYb/s4BIGqZVloOym0LkeDjbAVjtZQ0EJHROlR9s5C8+MdbqQPIPzY21nh8vtx8OErg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jE3HvwXT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jE3HvwXT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48AC51F00A3D;
	Fri,  4 Sep 2026 00:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788480054;
	bh=pIUWUKMeMH9u9kOH13slM9Csw4lhtv++aMc1e5gpYc4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jE3HvwXTjaLRoaFWEVdA82KSM/wPRwoLGYvC96rwsZ+/WgP40fwV/4mP8vxY4me9x
	 7kc7mmO3NM+jjzNpeANpBsPHbNKMu/vAFHj1nnZUxGujI0WSdi07Yo4q10u/RWlKe3
	 XVDLCQe365go6N+Th3ZZmprQSdHRcL+EIFBHfrFTs74md7QG/0KQunXCgb6+KZVN5l
	 zo+XDP9TgN0WBEDlGLhr8B0HbjE0AKepvNuKPU9KtNZkGzKRV8xl9xylHHuPveWSHB
	 AK6NXZjNNdZthe+1gNHbTxjTZEJLCfQO0YLU20wQbHOQz9FrMVUQcAMqpaA8zhMk6V
	 NOaCRg7FrUi8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH stable 5.15.y] tcp: fix potential race in
 tcp_v6_syn_recv_sock()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Florian Fainelli" <florian.fainelli@broadcom.com>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260903000029.3508006-2-florian.fainelli@broadcom.com>
References: <20260903000029.3508006-1-florian.fainelli@broadcom.com>
 <20260903000029.3508006-2-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 00:00:53 +0000
Message-Id: <20260904000054.48AC51F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Low] The patch adds a 7th argument (`opt_child_init`) to the `syn_recv_s=
ock` function pointer in `struct inet_connection_sock_af_ops`, but complete=
ly fails to update the DCCP subsystem. This breaks the build for DCCP.

Pre-existing issues:
- [Critical] This problem wasn't introduced by this patch, but if route loo=
kup fails when creating an IPv4-mapped IPv6 child socket, the listener's IP=
v6 resources are erroneously freed.
- [High] This problem wasn't introduced by this patch, but the exact race c=
ondition fixed by this patch in TCP is also present in DCCP's IPv6-mapped i=
mplementation, which remains unfixed.
--

commit eed5a807840b9b1bb7db87da21b6f743e2ad19f8
Author: Eric Dumazet <edumazet@google.com>

tcp: fix potential race in tcp_v6_syn_recv_sock()

This commit addresses a race condition in tcp_v6_syn_recv_sock() where the
child socket is visible in the TCP ehash table before its ipv6_pinfo is
fully initialized. It moves the initialization code into a new helper
tcp_v6_mapped_child_init() and passes it to tcp_v4_syn_recv_sock() to run
before ehash insertion.

Link: https://lore.kernel.org/netdev/69949275.050a0220.2eeac1.0145.GAE@goog=
le.com/
Link: https://patch.msgid.link/20260217161205.2079883-1-edumazet@google.com

> diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connec=
tion_sock.h
> index 7a015055fe6db..97e8969b37967 100644
> --- a/include/net/inet_connection_sock.h
> +++ b/include/net/inet_connection_sock.h
[ ... ]
> @@ -41,7 +41,9 @@ struct inet_connection_sock_af_ops {
>  				      struct request_sock *req,
>  				      struct dst_entry *dst,
>  				      struct request_sock *req_unhash,
> -				      bool *own_req);
> +				      bool *own_req,
> +				      void (*opt_child_init)(struct sock *newsk,
> +							     const struct sock *sk));

[Severity: Low]
Does this change break the build for DCCP? The patch adds the opt_child_init
argument to the syn_recv_sock function pointer, but does not appear to
update the DCCP subsystem. Calling syn_recv_sock with 6 arguments in
net/dccp/minisocks.c:dccp_check_req(), and defining
dccp_v4_request_recv_sock() and dccp_v6_request_recv_sock() without the 7th
argument will likely cause compiler errors.

[Severity: High]
This is a pre-existing issue, but does the same race condition you fixed
here in TCP also affect DCCP?

In net/dccp/ipv6.c:dccp_v6_request_recv_sock(), the IPv6 fields for mapped
sockets are initialized after the socket is already created and inserted
into the ehash by dccp_v4_request_recv_sock():

    newsk =3D dccp_v4_request_recv_sock(sk, skb, req, dst, req_unhash, own_=
req);
    if (newsk =3D=3D NULL) return NULL;
   =20
    newdp6 =3D (struct dccp6_sock *)newsk;
    newinet =3D inet_sk(newsk);
    newinet->pinet6 =3D &newdp6->inet6;

This appears to leave pinet6 pointing to the listener while the child socket
is already visible to other CPUs, exposing the same race.

[ ... ]
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index f7693166c5161..32b55a6b5e033 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
[ ... ]
> @@ -1612,6 +1614,10 @@ struct sock *tcp_v4_syn_recv_sock(const struct soc=
k *sk, struct sk_buff *skb,
>  	}
>  	sk_setup_caps(newsk, dst);
> =20
> +#if IS_ENABLED(CONFIG_IPV6)
> +	if (opt_child_init)
> +		opt_child_init(newsk, sk);
> +#endif

[Severity: Critical]
This is a pre-existing issue, but can this lead to freeing the listener's
IPv6 resources if route lookup fails?

If inet_csk_route_child_sock() fails before opt_child_init() is called
in tcp_v4_syn_recv_sock():

    if (!dst) {
        dst =3D inet_csk_route_child_sock(sk, newsk, req);
        if (!dst)
            goto put_and_exit;
    }

It jumps directly to the put_and_exit label where tcp_done(newsk) is called
to destroy the child socket. Since pinet6 has not yet been reassigned by
opt_child_init(), it still points to the listener's ipv6_pinfo. This appears
to incorrectly free the listener's resources, such as pktoptions and rxpmtu,
which could lead to a double-free or use-after-free on the listener.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903000029.3508=
006-2-florian.fainelli@broadcom.com?part=3D1
