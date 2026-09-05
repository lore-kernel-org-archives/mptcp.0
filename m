Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69963876B7
	for <mptcp@lists.linux.dev>; Sat,  5 Sep 2026 18:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788633338; cv=none; b=MSS5paB/+0PF2ZwK57BjAEAsTpfbLBbcKmtiiS2v1P9B2lWGE26eD9vRuhkaE0YpwfzpzbNnbCTZ9GerFMy83gX1eV39zq8Y3ZRlBafe1PFdwr5hdLnztzE/sdxGOPZyb0An33ykSC5m/vSeIwyG+M+ktzvTxwmko4BbLAO881c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788633338; c=relaxed/simple;
	bh=zJUHNfgzOE6ZhmbjsXjB3USm7yMjz9NG4q6AhhpOnQU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hbQaDWWPC1ZgkGUrXBCzZNPs26atp23dnnbWBXJlaox7sE3CodmDNp4qg8COUXD+s+A7A5/usTSorW4oViCRF2OlSnB2xzq0GlMZsDTpr4QKa/uneTdrKG70nX6vB3br1KLLi0QyOzs8QNG3h1RbeNTGv68JRxV2N+oBHXUw4DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BskXxgho; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BskXxgho"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2713D1F00A3E;
	Sat,  5 Sep 2026 18:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788633332;
	bh=1ImDpd4OMPtWYjQGrKjP7l5SBwttP+0CwZZggqdlcqQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BskXxghowdaL8jR4FMuPfPrrJrgYqN40hUOOamQzpiZVbEAxqsCF6AordejWo2Qi7
	 1cSk5S0Gbnfc90HPy1MSTr5BCqAIjhjjb9muTUntEzVwfMqOWyfQbkR/yL8xHAw3yf
	 OSJo8/SDXX2dPfHjKZ3StNkqCPZiajcrQukJhS6y0B9aiGtf7+t/+hdzNgy0hV0CmT
	 JrpiHQnIdjLDDvbogv/Av5wLmfh9bOBWEK9inQvvKi9P3MftXIxZ9sdbyW+h8wgTne
	 iG0rGc/YO0TM8NVYH0ypU2s98xQ1UIdxEYcpJeiQFOm9EHjb6TBj6bAGAvDTI7/LPz
	 PrhoqtXzUEwbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH stable 5.10 v2] tcp: fix potential race in
 tcp_v6_syn_recv_sock()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Florian Fainelli" <florian.fainelli@broadcom.com>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260904183500.3841094-1-florian.fainelli@broadcom.com>
References: <20260904183500.3841094-1-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 18:35:31 +0000
Message-Id: <20260905183532.2713D1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The backport failed to implement the semantic fix for DCCP v6-=
mapped sockets, leaving them vulnerable to the exact race condition patched=
 in TCP.
- [Critical] Routing failure error paths in `tcp_v4_syn_recv_sock` and `dcc=
p_v4_request_recv_sock` cause a Use-After-Free of the listener's IPv6 optio=
ns for IPv6-mapped connections.
--

commit 17f9bf2cd985844a777166a25415341fdcf87b54
Author: Eric Dumazet <edumazet@google.com>
tcp: fix potential race in tcp_v6_syn_recv_sock()

This commit addresses a race condition where a newly created TCP child sock=
et
becomes globally visible in the ehash table before its IPv6 fields are prop=
erly
initialized. It introduces an opt_child_init callback to perform the setup
earlier in tcp_v4_syn_recv_sock(). The patch also extends the callback mech=
anism
to other subsystems like DCCP to resolve similar issues there.

Link: https://patch.msgid.link/20260217161205.2079883-1-edumazet@google.com

> diff --git a/net/dccp/ipv4.c b/net/dccp/ipv4.c
> index b0b6e6a4784e5..86042ef2f5f13 100644
> --- a/net/dccp/ipv4.c
> +++ b/net/dccp/ipv4.c
> @@ -395,7 +395,9 @@ struct sock *dccp_v4_request_recv_sock(const struct s=
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

[Severity: Critical]
This is a pre-existing issue, but does adding the opt_child_init parameter
here without actually calling it inside dccp_v4_request_recv_sock() leave
the DCCP v6-mapped sockets vulnerable to the exact same race condition being
fixed in TCP?

The child socket is inserted into the ehash table with its pinet6 pointer
aliasing the listener's ipv6_pinfo. If another CPU accesses the socket
before initialization completes, can this lead to data corruption or a
use-after-free?

> diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
> index 78ee1b5acf1f1..5cc46957b0d29 100644
> --- a/net/dccp/ipv6.c
> +++ b/net/dccp/ipv6.c
[ ... ]
> @@ -413,7 +415,8 @@ static struct sock *dccp_v6_request_recv_sock(const s=
truct sock *sk,
>  		 *	v6 mapped
>  		 */
>  		newsk =3D dccp_v4_request_recv_sock(sk, skb, req, dst,
> -						  req_unhash, own_req);
> +						  req_unhash, own_req,
> +						  opt_child_init);
>  		if (newsk =3D=3D NULL)
>  			return NULL;

[Severity: Critical]
This is a pre-existing issue, but because opt_child_init is ignored in
dccp_v4_request_recv_sock(), the manual reassignment of pinet6 that happens
after this call returns still occurs too late.

Since dccp_v4_request_recv_sock() makes the socket globally visible before
returning, doesn't this leave the regression completely unfixed for DCCP?

> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index 595dcc3afac5c..e922c10a1caf6 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
[ ... ]
> @@ -1557,6 +1559,10 @@ struct sock *tcp_v4_syn_recv_sock(const struct soc=
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
This isn't a bug introduced by this patch, but if inet_csk_route_child_sock=
()
fails earlier in tcp_v4_syn_recv_sock(), the code jumps to the put_and_exit
label and bypasses this new opt_child_init call entirely.

At the put_and_exit label, tcp_done() is called on the child socket, which
then invokes inet6_destroy_sock(). Since newinet->pinet6 was never reassign=
ed
by opt_child_init, it still incorrectly aliases the listener socket's memor=
y:

inet6_destroy_sock()
    ...
    skb =3D xchg(&np->pktoptions, NULL);
    kfree_skb(skb);

    skb =3D xchg(&np->rxpmtu, NULL);
    kfree_skb(skb);

Does this erroneous state cause inet6_destroy_sock() to free the active
listener socket's pktoptions, rxpmtu, and opt structures, leading to a
use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904183500.3841=
094-1-florian.fainelli@broadcom.com?part=3D1
