Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795592671;
	b=Fs4BO5VB8bZ7rSTQKjrlgM/5m+DFt5X1jDPFMAvGzN7v86zpsbolMiksXOFr1XQNDOwd
	 jHwl/WK/3azpIc0b7faxktpo/ZUc2mU8czxY61y/qTuoec9kgQ8be3F0wqqrg55jcgQrB
	 4Qycc86dyPt1Mwrr6N4gWNhe8bQpwl3r43cTIQLmKGa0gv3bPZFjjIsrjzRRMEp/7EYbg
	 bIfuCkM2FuiZJcDBr+zeKyRpX4+veHtTseXJRTh2nIRdexYBItrTiPGi2D7iCYbZ648yb
	 6m3vHNe2oxmjSWy/0dpvrnoD+oBmPwCJQulkfd23JJJngRe6K7D75J3I7kVWmQxRw5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795592671;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kXfwnoesV7OxqjmmVyKi1hSlmlO6K5UsvC42GvD37w4=;
	b=Hgpj5iKtCCmxctbMb/sgYgI0lmPVm3444qSo9KCNcWhwfjYzI8NczOZA3gFQVXVncg6H
	 f3kaNQS/ZzQd+/9gTZggmqBYUyvWm9LK1g3/JnYjIJWA6Jl5SdbKQwGfaiHtTQRq+mQxz
	 02cx9Nu3VsKC9zct2OYYwT+2JSW7R+u3fiRkmK8OeXmR9TjoqkbN0ijDQ4oe9EY9YxU20
	 ZYtc5u7LgSmQjJDK3EvgMZlgoCB4oYV1I3VoXvusJgK4O5iYdu4PevxShMO/C8H6GC7Qr
	 i1Rtgf6ZdYnrSIqMxKBnYt0Eq48Fy8nSXK3sEVFGn2LiJuFJbpbQy0yOTshxPnL/DYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fsbrgvap;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65F8606A31E
	for <mptcp@lists.linux.dev>; Wed, 25 Nov 2026 07:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fsbrgvap
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E461F000D0;
	Wed, 25 Nov 2026 07:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795592671;
	bh=kXfwnoesV7OxqjmmVyKi1hSlmlO6K5UsvC42GvD37w4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=fsbrgvapAMkJTSKvxli/DcCQwAFyQPOOaFO1W4iDAp9erZooo6+MXb2Wr2WzvGgsh
	 xOWhIcFE0mcD9dKNnm267BiG3/6q3Jl9yPOG+HqdM0uGrtdrX5M9fkKtKxSkPQYGO7
	 h7CSxW9EAnngyRwvFGGgtDJ0c9mAVUPFBufdmOpvlWwWFX1zxzzq2TsZk9OvXyF70I
	 zr+SEm7X3WYfZMIJeF545ZvAK7zA06HF9ap4J80iYUa566YviUcbKAIlC/LtniZMYC
	 2WAa9YywHX7n9OP88UCv2HRIZl/SAEVebzgohi1DYxOOQ/lVDffAQZhc0rLEAkSm1G
	 hMFdSe1A8/E0w==
Message-ID: <sashiko-outbox-232823@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v9 4/7] mptcp: handle SO_ZEROCOPY in
 setsockopt
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <aaf330d9dbfe6e4f8b15542106d5e687e719a8cf.1795591278.git.tanggeliang@kylinos.cn>
References: <cover.1795591278.git.tanggeliang@kylinos.cn>
 <aaf330d9dbfe6e4f8b15542106d5e687e719a8cf.1795591278.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 07:44:30 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] mptcp: 0-length skb queued in mptcp_sendmsg_frag() on
  zerocopy wmem failure
--

commit c40bf75d2e840f9a30a3c937060e37a47f1aa32c
Author: Geliang Tang <geliang@kernel.org>

mptcp: handle SO_ZEROCOPY in setsockopt

This commit enables SO_ZEROCOPY in MPTCP setsockopt by setting
SOCK_ZEROCOPY on the MPTCP socket and propagating it to all subflows.

> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index 922f6ae5c80cb..3391f7a9d9834 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -184,6 +184,31 @@ static int mptcp_setsockopt_sol_socket_tstamp(struct=
 mptcp_sock *msk, int optnam
>  	return 0;
>  }
> =20
> +static int mptcp_setsockopt_sol_socket_zerocopy(struct mptcp_sock *msk, =
int val)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	struct sock *sk =3D (struct sock *)msk;
> +
> +	if (val !=3D 0 && val !=3D 1)
> +		return -EINVAL;
> +
> +	lock_sock(sk);
> +	sock_valbool_flag(sk, SOCK_ZEROCOPY, val);

[Severity: Medium]
Can enabling SOCK_ZEROCOPY cause mptcp_sendmsg_frag() to leave a 0-length
skb on ssk->sk_write_queue when tcp_wmem_schedule() returns 0?

With SOCK_ZEROCOPY set, mptcp_sendmsg() queues mptcp_data_frag entries
with dfrag->ubuf set.  When __subflow_push_pending() pushes such a
fragment under subflow wmem pressure, mptcp_sendmsg_frag() skips the
avail <=3D 0 check but still overwrites copy with avail:

net/mptcp/protocol.c:mptcp_sendmsg_frag() {
    ...
	avail =3D tcp_wmem_schedule(ssk, copy);
	if (!dfrag->ubuf && avail <=3D 0) {
		tcp_remove_empty_skb(ssk);
		return -ENOMEM;
	}
	copy =3D avail;
    ...
}

When tcp_wmem_schedule() returns 0 on a newly allocated skb, execution
continues with copy =3D=3D 0, attaches a 0-byte page fragment and a
dfrag->ubuf reference via skb_zcopy_set(), and leaves the empty skb
(end_seq =3D=3D seq) on ssk->sk_write_queue.  Once a non-coalescing skb is
queued behind it, tcp_write_xmit() stalls at tcp_send_head(ssk), wedging
transmission on the subflow and holding the ubuf reference until the
subflow is closed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795591278.gi=
t.tanggeliang@kylinos.cn?part=3D4
