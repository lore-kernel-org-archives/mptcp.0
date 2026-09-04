Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8CA157487
	for <mptcp@lists.linux.dev>; Fri,  4 Sep 2026 00:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788480057; cv=none; b=fkioph6WS4xzb+3W0rfIg2p6k8Z7hw5+iYKJJasAH6FeSYVJnqjgUSjdgBQMM/B4/MJ7m+UKp2ou/mbLRreWaIoohDJvpeAKXgcMZB7S6w0U9C27cIlV79qReQSiebl/aTXp7u4NmpEnHonmuJQ+jnSJRvbtXjBN+5UlYAbpLEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788480057; c=relaxed/simple;
	bh=PXlA9Pg3rmHnUgUgJRbJLh5iRfR0HR5LV6rpfHx4+JI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nfzjXxJfeZpJ1dHQmRLv/u6QBJv+0u9UZk0zUzf9iCPSEYnDqPMWUSXbXBZFddu+HUfOCuuclMolodiaOeREEe4ICWuTXuBlp37/C+WjrhSToMvkI9Nsgo1dUsyCxcocaQVZSXFjOzMAUyTlPWsCLhfKAf+tagSAgLZ3+M3hFm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKXvKK/C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKXvKK/C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B461F000E9;
	Fri,  4 Sep 2026 00:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788480056;
	bh=X+z8eFFAk128vjQlc4m3ikhq+jRbtCDzFCkEuBw5HkI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DKXvKK/CJkc+En2AveCHkU/uMMavTfJt4896F265axnQqWD1fnPMjMSH5Ge0vbhxD
	 n1zcCvm/3Tq0zaDPJk4eML29Qfb84+ZI0CI4TOMEQAbBT0tQ3NPHcEbwqjL4Y/Qipw
	 Gg/FMs9APjZP2tMuLX4YM5ERfOSEhJlygnZDbVXYELWWt4cmrSgn5IDz9Tt1sC/E0T
	 wgluaoANDezrSsIrkTJTEewiKYCFEhurDLPDPdnEdhQ2IwEzFvQZCC9k0TjePYp3d1
	 g2jO3XceFJezc0CB+dcYyOMao+Q5a74TufFkgRzVZEZO5h8ULtkNR6S5VjVw39A1qN
	 7UscgVYktCrdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH stable 6.6.y] tcp: fix potential race in
 tcp_v6_syn_recv_sock()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Florian Fainelli" <florian.fainelli@broadcom.com>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260903000029.3508006-4-florian.fainelli@broadcom.com>
References: <20260903000029.3508006-1-florian.fainelli@broadcom.com>
 <20260903000029.3508006-4-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 00:00:54 +0000
Message-Id: <20260904000055.D3B461F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Low] The DCCP subsystem was not updated to handle the new `syn_recv_sock=
` function pointer signature, resulting in a build failure and Control Flow=
 Integrity (CFI) violations.

Pre-existing issues:
- [Critical] Use-After-Free and Double-Free of listener's `ipv6_pinfo` on t=
he `tcp_v4_syn_recv_sock` error path.
- [High] The patch leaves the identical ehash race condition completely unf=
ixed in the DCCP subsystem.
- [High] The `opt_child_init` callback is non-composable and ignored by IPv=
6, leaving wrapper ULPs (SMC, MPTCP) vulnerable to the same ehash race cond=
ition.
--

commit 1232c8e7afdc63a365473845ad392043814df4fb
Author: Eric Dumazet <edumazet@google.com>

tcp: fix potential race in tcp_v6_syn_recv_sock()

This commit fixes a race condition where a child socket is inserted into the
TCP ehash table while its newinet->pinet6 still points to the listener's
IPv6 info. It introduces a new opt_child_init callback parameter to
syn_recv_sock to perform the initialization before ehash insertion.

Link: https://patch.msgid.link/20260217161205.2079883-1-edumazet@google.com

> diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connec=
tion_sock.h
> --- a/include/net/inet_connection_sock.h
> +++ b/include/net/inet_connection_sock.h
> @@ -42,7 +42,9 @@ struct inet_connection_sock_af_ops {
>  				      struct request_sock *req,
>  				      struct dst_entry *dst,
>  				      struct request_sock *req_unhash,
> -				      bool *own_req);
> +				      bool *own_req,
> +				      void (*opt_child_init)(struct sock *newsk,
> +							     const struct sock *sk));

[Severity: Low]
Does this break the DCCP subsystem?

The DCCP implementations of syn_recv_sock (dccp_v4_request_recv_sock and
dccp_v6_request_recv_sock) were not updated to accept this new 7th paramete=
r.
Since dccp_check_req() still passes 6 arguments, this appears to cause a
direct compilation error (too few arguments). If compiled with loose
warnings and kCFI enabled, it could also cause pointer mismatch panics at
runtime.

[Severity: High]
This is a pre-existing issue, but does this leave the identical ehash race
condition unfixed in DCCP?

dccp_v6_request_recv_sock() calls dccp_v4_request_recv_sock(), which inserts
the socket into the ehash via inet_ehash_nolisten(). Only after it returns
does dccp_v6_request_recv_sock() initialize newinet->pinet6. A lockless
reader (like sock_diag or BPF) can access the socket from the ehash in this
window and observe the listener's pinet6 pointer, which is exactly the race
condition this patch fixes for TCP.

[ ... ]

> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -1622,6 +1624,10 @@ struct sock *tcp_v4_syn_recv_sock(const struct soc=
k *sk, struct sk_buff *skb,
>  	}
>  	sk_setup_caps(newsk, dst);
> =20
> +#if IS_ENABLED(CONFIG_IPV6)
> +	if (opt_child_init)
> +		opt_child_init(newsk, sk);
> +#endif

[Severity: Critical]
This is a pre-existing issue, but is there a use-after-free of the listener=
's
ipv6_pinfo if routing fails earlier in this function?

If inet_csk_route_child_sock() fails before sk_setup_caps() and this new
opt_child_init() call:

	if (!dst) {
		dst =3D inet_csk_route_child_sock(sk, newsk, req);
		if (!dst)
			goto put_and_exit;
	}

The code jumps to put_and_exit, which destroys the child socket:

put_and_exit:
	newinet->inet_opt =3D NULL;
	inet_csk_prepare_forced_close(newsk);
	tcp_done(newsk);
	goto exit;

Since put_and_exit calls tcp_done() before opt_child_init() has repointed
pinet6 to the child's own memory, pinet6 still points to the listener. The
destruction path will free the listener's pktoptions, rxpmtu, and opt while
the listener is still active, causing a double-free memory corruption.

[ ... ]

> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -1200,60 +1237,10 @@ static struct sock *tcp_v6_syn_recv_sock(const st=
ruct sock *sk, struct sk_buff *
>  #endif
>  	struct flowi6 fl6;
> =20
> -	if (skb->protocol =3D=3D htons(ETH_P_IP)) {
[ ... ]
> +	if (skb->protocol =3D=3D htons(ETH_P_IP))
> +		return tcp_v4_syn_recv_sock(sk, skb, req, dst,
> +					    req_unhash, own_req,
> +					    tcp_v6_mapped_child_init);

[Severity: High]
This is a pre-existing issue, but by overriding opt_child_init with a
hardcoded tcp_v6_mapped_child_init callback here, does this leave wrapper
ULPs like SMC and MPTCP vulnerable to the same ehash race condition?

Because tcp_v6_syn_recv_sock() ignores the passed opt_child_init callback f=
or
IPv6 (and hardcodes it for v4-mapped), wrapper ULPs cannot use it to
initialize their state before ehash insertion.

[ ... ]

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -834,7 +836,7 @@ static struct sock *subflow_syn_recv_sock(const struc=
t sock *sk,
> =20
>  create_child:
>  	child =3D listener->icsk_af_ops->syn_recv_sock(sk, skb, req, dst,
> -						     req_unhash, own_req);
> +						     req_unhash, own_req, opt_child_init);

[Severity: High]
This is a pre-existing issue, but since MPTCP mutates ctx->conn via
mptcp_sk_clone_init() after syn_recv_sock() returns, does this create a race
window where lockless readers can access the listener's state on the newly
hashed child?

This seems especially problematic for IPv6 because the passed opt_child_init
callback is completely ignored by tcp_v6_syn_recv_sock().

[ ... ]

> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -144,7 +146,7 @@ static struct sock *smc_tcp_syn_recv_sock(const struc=
t sock *sk,
> =20
>  	/* passthrough to original syn recv sock fct */
>  	child =3D smc->ori_af_ops->syn_recv_sock(sk, skb, req, dst, req_unhash,
> -					       own_req);
> +					       own_req, opt_child_init);
>  	/* child must not inherit smc or its ops */
>  	if (child) {
>  		rcu_assign_sk_user_data(child, NULL);

[Severity: High]
This is a pre-existing issue, but does clearing the inherited user data via
rcu_assign_sk_user_data(child, NULL) here occur too late?

Because this happens after syn_recv_sock() has already hashed the child
socket globally, there is a window where lockless readers can access the
listener's SMC state on the child socket. Again, this is exacerbated for IP=
v6
where the opt_child_init callback is ignored.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903000029.3508=
006-4-florian.fainelli@broadcom.com?part=3D1
