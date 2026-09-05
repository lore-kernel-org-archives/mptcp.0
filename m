Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8981B49EC5F
	for <mptcp@lists.linux.dev>; Sat,  5 Sep 2026 18:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788633321; cv=none; b=DIgQJXz+tcIk52GgMyudXRUYnmQdQBzy7S6tIH/8GRqz7aS94ksC2RdHVqsY8AkL/I7hfy9isbbU7ylSPUlAfSH027TFOphvkDtQRAJxgMZr1oEOAlc4VKvRaVSYWgkFDCllf7Ss2+UeU4paESYTD1BA5bg43qUmRObyuJ4yJoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788633321; c=relaxed/simple;
	bh=5ciQSml9QzvQ/R1jRMmAOI1mg7+7MjkwulQ5wG9qO+8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n8IMDdqI6YhwzeVSOgEeJ5rjeU6zIkTbTxST2dG72hDB9W+IQsIPUpaTc+CmhUvMuHKY9y6Nf9u7FhpIqDcpOkfBCq+gZDn7uJVU/DQKBXSLHkls+hL1u6rNekwMpUc21CM2WfBJkEdylc8ktHPC0nW76o/I7EIGRS2gO1JU0Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=av/Jli6R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="av/Jli6R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F2E51F00A3A;
	Sat,  5 Sep 2026 18:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788633320;
	bh=GVqYSDJxFnpnMopERfSQWVfSaJ/1MP3t1/BKjYh41dw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=av/Jli6RxmTlt/noVV1DrU5K907weDM28vjm5gKR+9hVpaQ8d14ziGfjXK3cQTtU/
	 dfDt8S+Z8DG2/RMSnrEXlfhr2aLBivSWENxT5B3ZVGD82D3zs50/Y1hNKhXb9lxWwL
	 80jYX3Tz8YiNOzx8LYxoPu92geaRSqflB+RSdPo/xxvxbVI2KbWlAiNCNsfo7b2R71
	 hAXbJWHGVz3qnV0fSojY/qDV/n27XoMfbvvwIAoUdujtpUKIsy0BQOVxBG9Whj/oBL
	 WUsEov2ThLGd7iXzQhYkSvHH7pxChRMFS4aNUuZUvYX8G4O1qNvr44kp3mfuhTqRyN
	 /qThLyDzRJjVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH stable 6.6 v2] tcp: fix potential race in
 tcp_v6_syn_recv_sock()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Florian Fainelli" <florian.fainelli@broadcom.com>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260904183500.3841094-5-florian.fainelli@broadcom.com>
References: <20260904183500.3841094-1-florian.fainelli@broadcom.com>
 <20260904183500.3841094-5-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 18:35:19 +0000
Message-Id: <20260905183520.1F2E51F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Error path in `tcp_v4_syn_recv_sock()` causes use-after-free o=
n the listener's IPv6 options because `opt_child_init` is called too late.
- [High] DCCP subsystem remains vulnerable to the ehash race condition due =
to ignored `opt_child_init` parameter.
--

commit 1e6feae0d891ac553cbb34cbf3b1a75258a4cc5c
Author: Eric Dumazet <edumazet@google.com>

tcp: fix potential race in tcp_v6_syn_recv_sock()

Code in tcp_v6_syn_recv_sock() after the call to tcp_v4_syn_recv_sock()
is done too late.

After tcp_v4_syn_recv_sock(), the child socket is already visible
from TCP ehash table and other cpus might use it.

Since newinet->pinet6 is still pointing to the listener ipv6_pinfo
bad things can happen as syzbot found.

Move the problematic code in tcp_v6_mapped_child_init()
and call this new helper from tcp_v4_syn_recv_sock() before
the ehash insertion.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+937b5bbb6a815b3e5d0b@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/69949275.050a0220.2eeac1.0145.GAE@go=
ogle.com/
Link: https://patch.msgid.link/20260217161205.2079883-1-edumazet@google.com

[ ... ]

> diff --git a/net/dccp/ipv4.c b/net/dccp/ipv4.c
> index 69453b936bd55..a55dfd414448c 100644
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

[Severity: High]
This is a pre-existing issue, but does adding the opt_child_init parameter =
here
without actually executing it leave the DCCP subsystem vulnerable to the eh=
ash=20
race condition?

The parameter is added to the signature of dccp_v4_request_recv_sock(), but=
 it
doesn't appear to be called before the socket is inserted into the ehash ta=
ble.

[ ... ]

> diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
> index c693a570682fb..d1c8bc339fe2d 100644
> --- a/net/dccp/ipv6.c
> +++ b/net/dccp/ipv6.c
> @@ -429,7 +431,8 @@ static struct sock *dccp_v6_request_recv_sock(const s=
truct sock *sk,
>  		 *	v6 mapped
>  		 */
>  		newsk =3D dccp_v4_request_recv_sock(sk, skb, req, dst,
> -						  req_unhash, own_req);
> +						  req_unhash, own_req,
> +						  opt_child_init);
>  		if (newsk =3D=3D NULL)
>  			return NULL;
> =20

[Severity: High]
This is a pre-existing issue, but since dccp_v4_request_recv_sock() ignores=
 the
opt_child_init callback and hashes the socket, doesn't this leave the race
window open?

The v6 mapped child socket is made visible to concurrent threads before its
pinet6 pointer is repointed to its own memory here, exposing the uninitiali=
zed
or aliased pinet6 pointer to concurrent access.

[ ... ]

> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index 4167e8a48b60a..f7bc1ad695135 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -1613,6 +1615,10 @@ struct sock *tcp_v4_syn_recv_sock(const struct soc=
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

[Severity: Critical]
This is a pre-existing issue, but is opt_child_init() called too late here,
potentially causing a regression with a use-after-free on the listener's IP=
v6
options?

Looking at tcp_v4_syn_recv_sock(), there is a route lookup earlier in the
function that can fail:

	if (!dst) {
		dst =3D inet_csk_route_child_sock(sk, newsk, req);
		if (!dst)
			goto put_and_exit;
	}

If the route lookup fails, execution jumps to the put_and_exit error path
before opt_child_init() is called.=20

The error path destroys the child socket:

put_and_exit:
	newinet->inet_opt =3D NULL;
	inet_csk_prepare_forced_close(newsk);
	tcp_done(newsk);
	goto exit;

Since the child socket's pinet6 still aliases the listener's ipv6_pinfo,
won't inet6_destroy_sock() free the active listener's IPv6 options? Placing
opt_child_init() before the routing check would fix this by NULLing the chi=
ld's
options pointers early.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904183500.3841=
094-5-florian.fainelli@broadcom.com?part=3D1
