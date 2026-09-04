Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0CA1BC2A
	for <mptcp@lists.linux.dev>; Fri,  4 Sep 2026 00:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788480055; cv=none; b=GPz8BTXQ4h6x1NgKh9Um7faqnmO9ckRE/UDeT7IY7CSBQ1Nbjoiw+N4YOzX4wqsevII0hnm2St6s5wpggN4H4t61hUCpZbu+OzZyNxMafMy4vRnR/lX/pG0+O7BdOwTFzhdTx83j2Mc7EShmC6zaqk62D+9mKevqxGZMzZKBAfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788480055; c=relaxed/simple;
	bh=kD0WXqObgXoGK3Cg/IP/ss11DkmyqDnE2NZaGHFNLjU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eTNz0yHgbPMoOXT+FupJ1nx441YSE1Uej5M4B7oiMaLclOZ3y/8m4k/EJoyX1jbv5SgTNEv7f+crpS77cq9IWdmQc6pxmAimNokPM9AZnrAzNsbbXFQyx5bH6Os4pC6Wrk7pl7DXCOZbMTdEr7J0X6GjZMvBRbG5lpaqvISkzNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfBTbI9C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfBTbI9C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC971F000E9;
	Fri,  4 Sep 2026 00:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788480053;
	bh=2abV21T1koDbfl0VBUf8JvtLy54x1NG93SY+TnomFks=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UfBTbI9Caj8exnqgjjvbMLafm9hPAECMh+kX0VsIGBw5zVda0xESeW4dbFUEia6E+
	 0eAFa/p77Gjknj6WLeQ3KWJcNNCHL+uRJlnaSMFnoYt/QQwcbOHdDlqtPU49e5sTfc
	 fZL0InLWxHd2+JVvVEgL9iBbQNF69map9Y6ukOqvQE5OMEjFrEtPbAI6BZQFxYxpCB
	 SdSmDSLBypO/077It5lO3k42sLsPF//41gm+aM9OxWMFW+tpZCtPqWsqwrsGOVuLRY
	 opLejbuV4iVQshKI0DDNv+GKcEEfKGvopHNk5Hw4LO+FtcDq42MHZGgoPFko5P0/sv
	 YlFjpiUu7dnAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH stable 5.10.y] tcp: fix potential race in
 tcp_v6_syn_recv_sock()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Florian Fainelli" <florian.fainelli@broadcom.com>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260903000029.3508006-1-florian.fainelli@broadcom.com>
References: <20260903000029.3508006-1-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 00:00:52 +0000
Message-Id: <20260904000053.8DC971F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Low] The patch adds a 7th argument `opt_child_init` to the `syn_recv_soc=
k` callback but fails to update the DCCP subsystem, leading to compilation =
errors.

Pre-existing issues:
- [Critical] This problem wasn't introduced by this patch, but the error pa=
th in tcp_v4_syn_recv_sock() frees the listening socket's IPv6 options via =
a stale pinet6 pointer.
- [High] This problem wasn't introduced by this patch, but the exact data r=
ace condition fixed for TCP IPv6-mapped sockets was left unfixed for DCCP I=
Pv6-mapped sockets.
--

commit 9fb42b0dda20f2c1f24b669590d7c23a325895a3
Author: Eric Dumazet <edumazet@google.com>

tcp: fix potential race in tcp_v6_syn_recv_sock()
   =20
Code in tcp_v6_syn_recv_sock() after the call to tcp_v4_syn_recv_sock()
is done too late. After tcp_v4_syn_recv_sock(), the child socket is already
visible from TCP ehash table and other cpus might use it. Move the
problematic code in tcp_v6_mapped_child_init() and call this new helper
from tcp_v4_syn_recv_sock() before the ehash insertion.

Link: https://patch.msgid.link/20260217161205.2079883-1-edumazet@google.com

> diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connec=
tion_sock.h
> index cfb66f5a50766..ba99da8eedb75 100644
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
>  	u16	    net_header_len;
>  	u16	    net_frag_header_len;
>  	u16	    sockaddr_len;

[Severity: Low]
Does the DCCP subsystem need to be updated for this new 7th argument?

The syn_recv_sock callback signature now requires 7 arguments, but it looks
like dccp_v4_request_recv_sock() and dccp_v6_request_recv_sock() might
still be using 6 arguments, and dccp_check_req() in net/dccp/minisocks.c
might be missing the 7th argument in its call. Could this cause a build
failure when CONFIG_IP_DCCP is enabled due to an arity mismatch?

[Severity: High]
This is a pre-existing issue, but does DCCP have the same race condition for
IPv6-mapped sockets that this patch fixes for TCP?

Looking at dccp_v6_request_recv_sock() in net/dccp/ipv6.c:

dccp_v6_request_recv_sock() {
    newsk =3D dccp_v4_request_recv_sock(sk, skb, req, dst, ...);
    if (newsk =3D=3D NULL)
        return NULL;
   =20
    newdp6 =3D (struct dccp6_sock *)newsk;
    newinet =3D inet_sk(newsk);
    newinet->pinet6 =3D &newdp6->inet6;
    newnp =3D inet6_sk(newsk);
    memcpy(newnp, np, sizeof(struct ipv6_pinfo));
    ...
}

It appears that dccp_v4_request_recv_sock() publishes the child socket to
the ehash table before dccp_v6_request_recv_sock() initializes its pinet6
pointer. Can a concurrent thread looking up the ehash table access the
partially initialized DCCP socket?

> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index 855cca214a021..f1e10db3d6253 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c

[ ... ]

> @@ -1591,6 +1593,10 @@ struct sock *tcp_v4_syn_recv_sock(const struct soc=
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
This isn't a bug introduced by this patch, but does placing the
opt_child_init() callback here leave a window for a use-after-free on the
listener's IPv6 options in the error path?

When an IPv4 SYN packet is received on an IPv6-mapped TCP listener,
tcp_create_openreq_child() bitwise-copies the listener's memory into the
new socket, meaning newinet->pinet6 points to the listener's ipv6_pinfo.

If routing fails before reaching this new callback, such as when processing
an unroutable spoofed source IP:

tcp_v4_syn_recv_sock() {
    newsk =3D tcp_create_openreq_child(sk, req, skb);
    ...
    if (!dst) {
        dst =3D inet_csk_route_child_sock(sk, newsk, req);
        if (!dst)
            goto put_and_exit;
    }
    ...
    if (opt_child_init)
        opt_child_init(newsk, sk);
    ...
put_and_exit:
    newinet->inet_opt =3D NULL;
    inet_csk_prepare_forced_close(newsk);
    tcp_done(newsk);
    ...
}

The error path put_and_exit will call tcp_done(newsk) and destroy the
child socket. Since opt_child_init() hasn't reassigned pinet6 yet, won't
the child socket's destructor free the listener's IPv6 options (pktoptions,
rxpmtu, opt) while the listener is still actively using them?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903000029.3508=
006-1-florian.fainelli@broadcom.com?part=3D1
