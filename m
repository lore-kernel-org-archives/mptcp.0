Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6234221883E
	for <mptcp@lists.linux.dev>; Sun, 13 Sep 2026 10:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789296004; cv=none; b=PW4RcWmg3rZNaCbasKr3lv2kyrb60qkrJjvx8Pmr3sDxVSRwoXSN2u2aOU71i3PFTFUUspkHe8EQOTHSBYs6WIbrBzuPTidSqjgAwySFSI9FYy9/vArJR+y8Py22ah2YDz7a0TXXxQBMEE8oXkLJ6O/yhYnCFnavIoq1Wcc5Ak8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789296004; c=relaxed/simple;
	bh=EnN7yELlDB8cOTQoKPUAo5vMRTbL/GhUbE28HHTNdoQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U+5Jxx4FF+DKxyE9H00iR1maqh643naClD9veVOWegfGJ2YB1CoGAMXIf19xsxtyTpKgE3iTou8FQJb+b5eaIbFfN5sSiHC9IDAyhOfJh5jwHWs6CKBDEiW5iyI0SspFR4jmnVwOQmKQ08FBZASGZxlZcq7ryaSMjGLyB3SWiUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dai8UG++; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dai8UG++"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4DE31F000FF;
	Sun, 13 Sep 2026 10:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789296003;
	bh=Qbfk4ML74PgW6Ihfrg4Xg97EQI+VAj3dzrs4mS/feRg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dai8UG++uxsBJzZzhrKL00tAIgOtlVORAhhLuV16u7wd5a6ebM/IBLVQEyqPME6wV
	 cifl0/K+djXsT9xxrt//mU2HVuSXqshJSN8I0sRFEEPWMqfEmPf2raZtJrIrCGOmVR
	 kQNbqzutYt3p8aWWUoAWyTPKHgOm7HAGud3xHzHzgy5YmYCIFzPue80qBWIlZ/2DyO
	 w5paSdOquqrY0796e3wzgMwgjlr92EAoSqSjvdX+EkXXlMLx7bLdtR38BzMeGOmSQw
	 cCPP9qw7O9p2iYp+myA1+r15wlRoqETd62TMOjjQc7+TdHE8cMRt1/085uSK0UfKys
	 1VSvgqEkwq+FQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v5 09/16] mptcp: implement read_skb for
 sockmap stream verdict
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
In-Reply-To: <08dd128a702b7b1d7023d64aea1b94907a981ed9.1789294365.git.tanggeliang@kylinos.cn>
References: <cover.1789294365.git.tanggeliang@kylinos.cn>
 <08dd128a702b7b1d7023d64aea1b94907a981ed9.1789294365.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 10:40:02 +0000
Message-Id: <20260913104002.D4DE31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] mptcp_read_skb ignores MPTCP_SKB_CB(skb)->offset, passing already-=
consumed or overlapping data to the BPF verdict program.
- [High] mptcp_read_skb delegates SKB consumption to the BPF framework, but=
 the framework's cleanup routine (tcp_eat_skb) ignores MPTCP sockets, causi=
ng a permanent receive window stall.
--

commit 6e8107704d63a143d654e959c9d367d27969a1b4
Author: Geliang Tang <geliang@kernel.org>

mptcp: implement read_skb for sockmap stream verdict

This commit implements the read_skb callback for MPTCP stream operations,
allowing MPTCP sockets to function with BPF sockmap stream verdict programs.
It adds mptcp_read_skb() which peeks, unlinks, and hands skbs to the
receive actor.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -4801,6 +4801,31 @@ static ssize_t mptcp_splice_read(struct socket *so=
ck, loff_t *ppos,
> +static int mptcp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
> +{
> +	struct sk_buff *skb;
> +	int copied =3D 0;
> +
> +	if (sk->sk_state =3D=3D TCP_LISTEN)
> +		return -ENOTCONN;
> +
> +	while ((skb =3D skb_peek(&sk->sk_receive_queue)) !=3D NULL) {
> +		int used;
> +
> +		__skb_unlink(skb, &sk->sk_receive_queue);
> +		WARN_ON_ONCE(!skb_set_owner_sk_safe(skb, sk));
> +		used =3D recv_actor(sk, skb);

[Severity: High]
Does this expose stale or overlapping data to the BPF stream verdict progra=
m?

It looks like the SKB is handed off to the BPF framework without first
pulling or accounting for MPTCP_SKB_CB(skb)->offset. If the SKB has a
non-zero offset (e.g., due to overlapping sequences handled by MPTCP),
passing it directly to recv_actor() without calling skb_pull() or adjusting
skb->data could allow the verdict program to read and redirect bytes that
precede the valid payload.

[Severity: High]
Will this cause a permanent receive window stall for MPTCP sockets?

When the BPF verdict is SK_REDIRECT or SK_DROP, the framework calls
tcp_eat_skb() to advance sequences and update the receive window. However,
tcp_eat_skb() checks sk_is_tcp():

net/ipv4/tcp_bpf.c:tcp_eat_skb() {
    if (!skb || !skb->len || !sk_is_tcp(sk))
        return;
    ...
}

Since sk_is_tcp() returns false for MPTCP sockets (IPPROTO_MPTCP),
tcp_eat_skb() will return early. This means the consumed bytes are never
advanced and mptcp_cleanup_rbuf() is never invoked, which appears to cause
the MPTCP receive window to permanently close.

> +		if (used < 0) {
> +			if (!copied)
> +				copied =3D used;
> +			break;
> +		}
> +		copied +=3D used;
> +	}
> +
> +	return copied;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789294365.gi=
t.tanggeliang@kylinos.cn?part=3D9
