Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F6B27A91D
	for <mptcp@lists.linux.dev>; Mon, 24 Aug 2026 07:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787556769; cv=none; b=ZzENng96pyGGXvi3h9kOqfrW73eFXh2cOxwrfHNICEFw2HTXloeYa7atucJfYIYWM9AdeijjxK5x1r4XGCjeTe1sVR4tu/d6xMm8DHnoxS4fuui+5WOmAng6Z+y461jKxx9ZYPxcGVfcqV9zMraNUoVOVWqa09HtzZtR1OZ9rxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787556769; c=relaxed/simple;
	bh=8/A0e4o0k7RvBEWkhvcO7iUtOuQZmM6vQLlnaqWZrw8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h7hVlCsig6YgYsKidIcn5D8txcBMgdAjFT95sj7YivxPqo7RnnO72IiZsqvkJ3xFIJgzkRsT8uCjXyjbDNHcFhi2fk8TAww58OinCdRztYqOWjktZB403e/hR7pNvm4ZM3BDZwFmgXu1wItYd9v0GNQ9q6NHRo073bH+/IIp0vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AunC09y3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AunC09y3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB871F000E9;
	Mon, 24 Aug 2026 07:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787556767;
	bh=TVkjkiwOUH55+uxez8uRVaQhlGVG05VaG4Gc/mT8OuQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AunC09y3htnip7ZBDPaR4MI67WUjhc1CY4qUDkJ8lvR9octim5QvgoZtKSu0ftmf4
	 ULXuW4iALKeLjaqyLvD8oDauS6C1mwbdn21UPrIl6DWKbZpKeVfky2SM5Srgsv1FpP
	 6Hnc7L94fGY5bHyGQvqnSZCJaP6O3t/133Vgs6YzZDbTNskTBtm5IOK0IxPGEUCrNS
	 4RS0QiKQJdFYaJIdCB1DqP4Vrau+gzMPFLfTQOTvkSVGdzud+2tu8G2R4gUGzhfbMG
	 TAZ9bLVzbS6dyJGXYLNH7nV44/SqCS6vQn/HVX15P3ITfLE7rpRyyLbUmgLpuEDGZO
	 QHTc124p7phXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v4 4/5] mptcp: implement psock_update_sk_prot
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
In-Reply-To: <7b7000bec51e276ef4cdb575f02ac5913656b325.1787554581.git.tanggeliang@kylinos.cn>
References: <cover.1787554581.git.tanggeliang@kylinos.cn>
 <7b7000bec51e276ef4cdb575f02ac5913656b325.1787554581.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 07:32:47 +0000
Message-Id: <20260824073247.AAB871F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Infinite kernel loop in `sock_map_close` and `sock_map_destroy=
` when a listening MPTCP socket in a sockmap accepts a new connection.
- [High] Missing `recvmsg` override for MPTCP BPF sockets causes packets re=
directed via SK_PASS or SK_REDIRECT to be permanently leaked.
- [Medium] Attaching a `msg_parser` (`sk_msg`) program to an MPTCP socket s=
ilently succeeds but is never executed due to missing `sendmsg` override.
--

--- Patch [4]: [PATCH mptcp-next v4 4/5] mptcp: implement psock_update_sk_p=
rot ---
commit b125c7aa25aed0ed03598733bc75a385728067e7
Author: Geliang Tang <geliang@kernel.org>
Subject: mptcp: implement psock_update_sk_prot

This patch adds basic MPTCP support for BPF sockmap by implementing the
psock_update_sk_prot callback. This enables MPTCP sockets to be added to
sockmap and supports the sk_skb stream_verdict redirect path.

Link: https://lore.kernel.org/oe-kbuild-all/202512261144.DxrvwMS3-lkp@intel=
.com/
Link: https://github.com/multipath-tcp/mptcp_net-next/issues/521

> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> index 82b0ad25f7001..df41f72603c0f 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c

[ ... ]

> +static void mptcp_bpf_rebuild_protos(struct proto prot[MPTCP_BPF_NUM_CFG=
S],
> +				     struct proto *base)
> +{
> +	prot[MPTCP_BPF_BASE]			=3D *base;
> +	prot[MPTCP_BPF_BASE].destroy		=3D sock_map_destroy;
> +	prot[MPTCP_BPF_BASE].close		=3D sock_map_close;

[Severity: Critical]
Does accepting a connection on a listening MPTCP socket in a sockmap lead to
an infinite loop here?

When an incoming connection is accepted, the socket is cloned and the child
socket inherits mptcp_bpf_prots. Because sk_user_data (the psock) is cleared
for the child socket, sock_map_close() will find a NULL psock and attempt to
call the original sk_prot->close.

Since MPTCP lacks an equivalent to tcp_bpf_clone() to restore the original
protocol on cloned sockets, sk_prot->close resolves back to sock_map_close()
itself, triggering an infinite goto retry loop.

> +	prot[MPTCP_BPF_BASE].sock_is_readable	=3D sk_msg_is_readable;
> +
> +	prot[MPTCP_BPF_TX]			=3D prot[MPTCP_BPF_BASE];
> +	prot[MPTCP_BPF_RX]			=3D prot[MPTCP_BPF_BASE];
> +	prot[MPTCP_BPF_TXRX]			=3D prot[MPTCP_BPF_BASE];
> +}

[Severity: High]
Does this cause redirected packets to be permanently leaked?

If a stream_verdict program returns SK_PASS (the default behavior to allow
packets) or another BPF program redirects to this MPTCP socket via
SK_REDIRECT, the data is placed into the BPF ingress_msg queue.

Because this patch explicitly does not override recvmsg(), mptcp_recvmsg()
only reads from sk_receive_queue and never checks the BPF ingress queues.
The data appears to be permanently blackholed, and since mptcp_poll() checks
only MPTCP-level data, EPOLLIN is broken as well.

[ ... ]

> +int mptcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock,
> +			   bool restore)
> +{
> +	int family =3D sk->sk_family =3D=3D AF_INET6 ? MPTCP_BPF_IPV6 :
> +						 MPTCP_BPF_IPV4;
> +	int config =3D psock->progs.msg_parser   ? MPTCP_BPF_TX   :
> +						 MPTCP_BPF_BASE;

[Severity: Medium]
Should attaching a msg_parser program return an error like -EOPNOTSUPP
instead of silently succeeding?

If a msg_parser program is attached, the configuration is set to MPTCP_BPF_=
TX.
However, mptcp_bpf_rebuild_protos() maps MPTCP_BPF_TX back to MPTCP_BPF_BAS=
E,
which does not override sendmsg(). As a result, the attachment succeeds but
outgoing packets will bypass the BPF program entirely.

> +
> +	if (psock->progs.stream_verdict || psock->progs.skb_verdict)
> +		config =3D (config =3D=3D MPTCP_BPF_TX) ? MPTCP_BPF_TXRX :
> +						    MPTCP_BPF_RX;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787554581.gi=
t.tanggeliang@kylinos.cn?part=3D4
