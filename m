Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792430440;
	b=fI9nMB0tvXtbsAXIFMOFONGWABFsZXOWqpq4DrB6w1MUirY+A796GDvcmvrjLKPLpJTo
	 buEKZLRz72Yxhctn97k8+9Aotg3mPHERZUn4+vd6Yl3Ve+mDy1wwSZ08cuOjQXct8nfQm
	 qBTIS3yzxhA5yzwbw9FypZcUcPBgj0tRPc6jVWiYxbzgPDPNeAhdvQRV7fe4Vd2xPzGlV
	 qwaz2zsIyoJBhwI8RaZLmqD2+CpcCpTWqvrCtt2mmJF6PHvfDC9I8WXHYcbHafffRhuFh
	 8CK8yTlodUeYMPoB1GhfxyF03EilWJFKZfT9JYm+yPNy/6+9SYbKQ3Q1pH1yovlOogQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792430440;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/S7HgCUA6eDGEuE3U+oF3TwOHfKtf34xLn9IR46T7z8=;
	b=fEr75CZ2k6KwFWDT78JL83iywio9dGafHb18TC1PYUhobpZv/BTHSHF1zFkyWBarW1pm
	 mvDbxbOlcBIjoJxB3k3hgCPY/8ibXcBCdZ94hv08pPG/eoWeGDx73Lmg+Ve4y43bId0HH
	 e6jF2iPz0fxUyhgUOFf/SrH/SMMTjfYnJQLsgUF+0XI3Cz6dIQBlz9FDy9wTKR2zvrdC2
	 YGEM5rRzm3CBNDHP6miHMVvnOhqBaJZ0Ph0JnEH5ysVxqFpOsZtMArwfRzZjQCEbdQb8W
	 G1D6awh47n/27FymH0TKswTNuJIfG71YCk78vLWLRZNDn8yBBQeH1OoxUH7VKAW6Vpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zmxq9DE9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA16606A31E
	for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 17:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zmxq9DE9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510C61F000C4;
	Mon, 19 Oct 2026 17:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792430439;
	bh=/S7HgCUA6eDGEuE3U+oF3TwOHfKtf34xLn9IR46T7z8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Zmxq9DE9P96RgCrcxm3s2C67H8CsWKnLU6jduMVh72ji5Iu0+PXviPXt8NX4omX/6
	 mW4gDdvk3v1WkrP46bGTUTYA5lxd6iRZuz3dhkevqGyPfU1WDP4BZV/riPOfoNtdph
	 aft5ldX7Q0KiCJWyYRKKRLjXbv0nqeknn0eiShao1sJ3tGRPGBR6A3dlHgpBCBrbN0
	 RkhZYWr7aewPJ7HUnO9OG7IRnuN4N6H0JOmV83VX274tfmdax9iFbm7gZbNdn08WrV
	 K3Li1jTP0dTBDAPr+R7fA+WKS7Cl7vqNGWTI6MehLGMzl09GuE8hyBqdygy8yGNnuN
	 itIJwSg5OUoLQ==
Message-ID: <sashiko-outbox-178012@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-net 1/2] mptcp: pm: in-kernel: fullmesh: skip
 closed subflows
Reply-To: sashiko-reviews@lists.linux.dev
To: "Abdul Wasey" <w453y.me@gmail.com>, mptcp@lists.linux.dev
In-Reply-To: <20261019170751.200446-2-w453y.me@gmail.com>
References: <20261019170751.200446-1-w453y.me@gmail.com>
 <20261019170751.200446-2-w453y.me@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 17:20:38 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] mptcp: fill_remote_addresses_fullmesh() misses disconnected init=
ial subflow
--

commit 4834733b36c6118707c74ccafb4f5dae74a92bbf
Author: Abdul Wasey <w453y.me@gmail.com>

mptcp: pm: in-kernel: fullmesh: skip closed subflows

This commit updates fill_remote_addresses_fullmesh() to skip subflows that
have subflow->closing set when marking remote IDs as unavailable and when
selecting remote addresses for fullmesh endpoints. This aims to avoid
relying on closed subflows kept in conn_list, such as the initial subflow.

> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> index 1a77508132354..b7d7520a3290a 100644
> --- a/net/mptcp/pm_kernel.c
> +++ b/net/mptcp/pm_kernel.c
> @@ -216,11 +216,19 @@ fill_remote_addresses_fullmesh(struct mptcp_sock *m=
sk,
>  	 * already created by incoming ADD_ADDR
>  	 */
>  	bitmap_zero(unavail_id, MPTCP_PM_MAX_ADDR_ID + 1);
> -	mptcp_for_each_subflow(msk, subflow)
> +	mptcp_for_each_subflow(msk, subflow) {
> +		/* The initial subflow stays in the list once closed */
> +		if (subflow->closing)
> +			continue;
> +
>  		if (READ_ONCE(subflow->local_id) =3D=3D local->id)
>  			__set_bit(subflow->remote_id, unavail_id);
> +	}
> =20
>  	mptcp_for_each_subflow(msk, subflow) {
> +		if (subflow->closing)
> +			continue;
> +
>  		ssk =3D mptcp_subflow_tcp_sock(subflow);
>  		mptcp_remote_address((struct sock_common *)ssk, &addrs[i]);
>  		addrs[i].id =3D READ_ONCE(subflow->remote_id);

[Severity: Medium]
Is checking subflow->closing sufficient to skip the initial subflow after it
has been disconnected via tcp_disconnect()?

When the initial subflow is closed via __mptcp_close_ssk(), subflow->closing
is set to 1, the subflow remains in conn_list, and
__mptcp_subflow_disconnect() is called. Whenever ssk->sk_state is TCP_CLOSE
(or fastclosing is set), __mptcp_subflow_disconnect() disconnects the socket
and resets the subflow context:

net/mptcp/protocol.c:__mptcp_subflow_disconnect() {
	if (((1 << ssk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN)) ||
	    fastclosing) {
		WARN_ON_ONCE(tcp_disconnect(ssk, 0));
		mptcp_subflow_ctx_reset(subflow);
	}
}

Because subflow->closing and subflow->remote_id are inside the reset
struct_group, mptcp_subflow_ctx_reset() zeroes both of them back to 0 and
sets local_id to -1:

net/mptcp/protocol.h:mptcp_subflow_ctx_reset() {
	memset(&subflow->reset, 0, sizeof(subflow->reset));
	subflow->request_mptcp =3D 1;
	WRITE_ONCE(subflow->local_id, -1);
}

(This is also why mptcp_close_ssk() checks READ_ONCE(subflow->local_id) < 0
in addition to subflow->close_event_done to detect an already disconnected
initial subflow.)

Additionally, if a subflow transitions to TCP_CLOSE (for example via peer R=
ST
or timeout), subflow->closing is not set until __mptcp_close_subflow() runs,
which in mptcp_worker() executes after mptcp_pm_worker().

When fill_remote_addresses_fullmesh() runs after the initial subflow has be=
en
disconnected and reset, won't subflow->closing be 0, causing the second loop
to read the zeroed remote address and port (skc_dport =3D=3D 0) from msk->f=
irst,
mark remote_id 0 as unavailable in unavail_id (skipping subsequent active
subflows with remote_id 0), increment msk->pm.extra_subflows, and pass port=
 0
to __mptcp_subflow_connect()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019170751.2004=
46-1-w453y.me@gmail.com?part=3D1
