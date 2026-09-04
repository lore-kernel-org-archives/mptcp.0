Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AF11A680C
	for <mptcp@lists.linux.dev>; Fri,  4 Sep 2026 00:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788480058; cv=none; b=Ee1bpid6WiLx7OVzBqx+g/RKwcivW84gbxOsR/gFK8TDBMPZt1pizJ7RPqyxGz+3yPV61szzQ+oxXiAM9hj2JPOodercgSAqcrVj4/QMlR2FFxKLhk38+GKTRXzUAxnDFTGnu/jq5L0t+89HB/y6/2EpcKl4ly9LoM0yuAltCiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788480058; c=relaxed/simple;
	bh=pQutJHQyXudcwH/9sL5ZruFPwb8h2FUMuUrk2MtmdBg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i8K9msoech+N8Ji/eXCW0Qni2rCBMh0wlkwR3q4Rp6Jja1pb30tIR347L6no3lLh/NdwSuh5mbSaAP1Ivf4g3iYwJWjok6UZH4E7B7cZfe4VknEAr4xL4xdsLB/22Hg83t9JFLICQmciAkiTbl6dFDJsR+F0HUzD/eQOFb8bA3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXW4C2PI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXW4C2PI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972111F00A3D;
	Fri,  4 Sep 2026 00:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788480056;
	bh=EWlmxR4QxHkvcUEOmdtUBse7b8hG+vSwbxnpRlm/BKU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AXW4C2PI5of3Npb6oUCJbyzMCusgPAeTrPrD5bRyadYYB0T83c6rBv2bTgoaPWV/E
	 0Bi5neIFB+jLI6nNAUNUIPF1z7YF3V5KZ3PLaPrYwMQz6fZ4sF2u1aRkCHASnO/7iD
	 Sd9WpEY5jfgW8YR5dCIrxzPI4ovuX8NoJCOFSYeL2Qm6lrVHlnNiS4iESL4kBH6eab
	 yw7jNMOnVoiRJY4DhJ8xmp2PhyLZCDpU6E7beEE/8GK+DhgeMoJMxaS9YCC4YrUOBw
	 S6sm/8W4hkNSGTawJg0rIdCkYGXsmxCx8kLnYu5/jBB021Y8ztQFX0z5Is8ojcVM0K
	 r0XHHf6SEispQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH stable 6.1.y] tcp: fix potential race in
 tcp_v6_syn_recv_sock()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Florian Fainelli" <florian.fainelli@broadcom.com>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260903000029.3508006-3-florian.fainelli@broadcom.com>
References: <20260903000029.3508006-1-florian.fainelli@broadcom.com>
 <20260903000029.3508006-3-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 00:00:56 +0000
Message-Id: <20260904000056.972111F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Low] The patch adds a new argument to the `syn_recv_sock` function point=
er in `struct inet_connection_sock_af_ops` but fails to update the DCCP sub=
system, breaking the build when `CONFIG_IP_DCCP` is enabled.

Pre-existing issues:
- [Critical] Use-After-Free and double-free of the listener's IPv6 options =
on routing failure during IPv4-mapped socket creation.
- [High] The DCCP subsystem contains the identical race condition for IPv4-=
mapped IPv6 sockets that this patch intended to fix for TCP.
--

commit 0524a546fd92e10009336d36766fbc7fa6b854ac
Author: Eric Dumazet <edumazet@google.com>

tcp: fix potential race in tcp_v6_syn_recv_sock()

This commit fixes a race condition where a child socket is inserted into
the TCP ehash table before its IPv6-specific fields are fully initialized.
It introduces an opt_child_init callback in the syn_recv_sock af_ops to
allow IPv6 mapped sockets to be initialized before hash insertion.

Link: https://lore.kernel.org/netdev/69949275.050a0220.2eeac1.0145.GAE@goog=
le.com/
Link: https://patch.msgid.link/20260217161205.2079883-1-edumazet@google.com

> diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connec=
tion_sock.h
> index 7649d4901f0c4..3d19420dce511 100644
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
Does this change break the build for the DCCP subsystem?

It looks like dccp_v4_request_recv_sock(), dccp_v6_request_recv_sock(),
and their caller dccp_check_req() in net/dccp/minisocks.c were not updated
to handle this new 7th argument. This would result in compilation errors
when CONFIG_IP_DCCP is enabled.

[Severity: High]
This isn't a bug introduced by this patch, but does the DCCP subsystem
suffer from the same race condition this commit fixes for TCP?

In net/dccp/ipv6.c:dccp_v6_request_recv_sock(), the child socket is created
and inserted into the ehash table by dccp_v4_request_recv_sock() before
its IPv6-specific fields are initialized:

        newsk =3D dccp_v4_request_recv_sock(sk, skb, req, dst,
                                          req_unhash, own_req);
        if (newsk =3D=3D NULL)
                return NULL;

        newdp6 =3D (struct dccp6_sock *)newsk;
        newinet =3D inet_sk(newsk);
        newinet->pinet6 =3D &newdp6->inet6;

Could concurrent threads access uninitialized IPv6 fields via a lookup,
similar to the syzbot crash found in TCP?

[ ... ]

> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index 753a881ce3cdf..ec3b0aa0a6260 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -1565,6 +1567,10 @@ struct sock *tcp_v4_syn_recv_sock(const struct soc=
k *sk, struct sk_buff *skb,
>  	}
>  	sk_setup_caps(newsk, dst);
> =20
> +#if IS_ENABLED(CONFIG_IPV6)
> +	if (opt_child_init)
> +		opt_child_init(newsk, sk);
> +#endif
>  	tcp_ca_openreq_child(newsk, dst);

[Severity: Critical]
This is a pre-existing issue, but does this routing failure path in
tcp_v4_syn_recv_sock() cause a use-after-free of the listener's IPv6
options?

Just above this block in tcp_v4_syn_recv_sock():

        if (!dst) {
                dst =3D inet_csk_route_child_sock(sk, newsk, req);
                if (!dst)
                        goto put_and_exit;
        }

If inet_csk_route_child_sock() fails, the code jumps to put_and_exit and
destroys the child socket. Because opt_child_init() hasn't run yet,
newinet->pinet6 still points to the listener's ipv6_pinfo. The child's
destructor (inet6_destroy_sock) will then free the listener's options,
corrupting the active listener socket.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903000029.3508=
006-3-florian.fainelli@broadcom.com?part=3D1
