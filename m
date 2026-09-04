Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1F135E926
	for <mptcp@lists.linux.dev>; Fri,  4 Sep 2026 17:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788544200; cv=none; b=hO63XYfvBDnSKmpTwuFw2ykyF5RsmBn6WTzSZns2rL3CIQZ+pUsi0/DjrVGZgaOB6BYyREcPccVWGgoBTBaqlLWhbPQWzJOMDJnRDcnP8wAvQtdK2GzsArhxxfmt8lEqeVUUVezvJWT5y0AtNKbye+gzskv/eRZNIVyhNyXPRnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788544200; c=relaxed/simple;
	bh=y3T7w1Q9zT5pdhytEtCdGKZ2pp0r5/9F5bApwHETQns=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gCZJwALc4A+9h5xMQua1Rjl8GmyD4ok+uq1F5GVdnYkxGyB2sUqcSbt44p8Jb7TiGNWQhEMu9MYqgZDlg8KBmOeGOt72uJroYJJm5GzKy4Hv/T423syEjGt+6rkcRUjV2fihdoFouxCDAZikGditrg4QVR7oaCOOEiohAGDKXeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKZdof6L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKZdof6L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15E571F00A3D;
	Fri,  4 Sep 2026 17:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788544199;
	bh=8bna2NWhWKEzwJHpikBpfgTuhssDAlLHV86ywMsPJcA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TKZdof6LXLNzOrtg3NKrLd6jM9clsU2rroXt+9JLfLs+j8dG987KUPGnGSv3Z+liY
	 UPB5RwuI6Xwuf/+F0/WdNA0HcvmjXp99iW49uZMLaHvG77TDAlsneBa8RCQl9V/Hgb
	 RiND43M+o/ypynXLoRYaoBiPodVUJgAxFLgL26Vc+fN9kJ20BBfdoCkYmn6O7BAQCU
	 0PSp9ZrdLlibqCQDwa8SUKZtsfpNLox4RZOMynUQ9e0QA0CnUpCaogZKCHiPD3K9Bb
	 0fOxCOcR8EZjZer6jA6T9DWMqNrbIuoAM+YcTTAmH7bwVnyvnj+n+2f0IZ73BLBHwb
	 +ENDvK1zHnBaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH stable 6.12] tcp: fix potential race in
 tcp_v6_syn_recv_sock()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Florian Fainelli" <florian.fainelli@broadcom.com>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260903174016.689839-1-florian.fainelli@broadcom.com>
References: <20260903174016.689839-1-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 17:49:58 +0000
Message-Id: <20260904174959.15E571F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Low] Missing updates to DCCP's syn_recv_sock implementations and callers=
 cause a build failure.

Pre-existing issues:
- [Critical] If `tcp_v4_syn_recv_sock()` hits an error path before `opt_chi=
ld_init` is called, destroying the child socket will free the listener's `i=
pv6_pinfo` state, causing a Use-After-Free.
- [High] The exact ehash insertion race condition patched in TCP remains un=
fixed in DCCP for IPv4-mapped IPv6 sockets.
--

commit bed80c01fd926d5de457cacc1f99f5af86ff3590
Author: Eric Dumazet <edumazet@google.com>

    tcp: fix potential race in tcp_v6_syn_recv_sock()
   =20
    Code in tcp_v6_syn_recv_sock() after the call to tcp_v4_syn_recv_sock()
    is done too late.
   =20
    After tcp_v4_syn_recv_sock(), the child socket is already visible
    from TCP ehash table and other cpus might use it.

    [ ... ]

    Link: https://patch.msgid.link/20260217161205.2079883-1-edumazet@google=
.com

> diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connec=
tion_sock.h
> index c0deaafebfdc0..41e7ab58b211f 100644
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
>  	u16	    net_header_len;
>  	u16	    sockaddr_len;
>  	int	    (*setsockopt)(struct sock *sk, int level, int optname,

[Severity: Low]
Does adding the opt_child_init parameter here require updating the DCCP
subsystem as well?

Looking at net/dccp/ipv4.c:dccp_v4_request_recv_sock() and
net/dccp/ipv6.c:dccp_v6_request_recv_sock(), their signatures still appear
to use 6 arguments, which would cause a build breakage when assigned to
icsk_af_ops->syn_recv_sock. Similarly, the caller dccp_check_req() in
net/dccp/minisocks.c appears to pass 6 arguments.

[Severity: High]
This isn't a bug introduced by this patch, but does the exact ehash
insertion race condition patched here in TCP remain unfixed in DCCP for
IPv4-mapped IPv6 sockets?

In net/dccp/ipv4.c:dccp_v4_request_recv_sock(), the child socket is inserted
into the ehash table:

	*own_req =3D inet_ehash_nolisten(newsk, req_to_sk(req_unhash), NULL);

But the child socket is initialized later in
net/dccp/ipv6.c:dccp_v6_request_recv_sock():

		newdp6 =3D (struct dccp6_sock *)newsk;
		newinet =3D inet_sk(newsk);
		newinet->pinet6 =3D &newdp6->inet6;
		newnp =3D inet6_sk(newsk);
		memcpy(newnp, np, sizeof(struct ipv6_pinfo));

This exposes the incompletely initialized DCCP child socket to concurrent
access while pinet6 still points to the listener.

[ ... ]

> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index 5afe5e57c89b5..550d64babb94e 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
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

[Severity: Critical]
This is a pre-existing issue, but does placing opt_child_init() here leave
the error paths vulnerable to use-after-free and data corruption of the
listener socket?

If an error like a routing failure occurs earlier in tcp_v4_syn_recv_sock()
before opt_child_init() is called:

	if (!dst) {
		dst =3D inet_csk_route_child_sock(sk, newsk, req);
		if (!dst)
			goto put_and_exit;

The error path destroys the child socket:

put_and_exit:
	newinet->inet_opt =3D NULL;
	inet_csk_prepare_forced_close(newsk);
	tcp_done(newsk);
	goto exit;

Since newinet->pinet6 still points to the listener's ipv6_pinfo at this
point, would destroying the child socket free and corrupt the listener's
state? Should the opt_child_init() callback be moved earlier, immediately
after tcp_create_openreq_child()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903174016.6898=
39-1-florian.fainelli@broadcom.com?part=3D1
