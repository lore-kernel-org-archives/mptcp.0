Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24E2393DFB
	for <mptcp@lists.linux.dev>; Mon, 24 Aug 2026 07:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787556679; cv=none; b=t/sdgQ2/3P0FDUAi4gVKegPP3sLQZV1T0MnDX35yMR8O0FFRxeH7LnVS9oD9B3mK1fzxfb2No/igA+5coHjrwczSIH4chAmIDNEDaqVYYoU1Y1kx3YXaQvCsSetOHlN+pV8J+bHl/4LFAuv08SBNgRrBiJUcM1HgZ1D31tp+HO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787556679; c=relaxed/simple;
	bh=mGXThdZHENSdeecwbJ4Ka+Aa6CwyatCO17h0YS8mF3o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CmYHV3vWOJop4ASsN5mJ7h3/FOYUHX5WVq7CeQyjNlA3P+luWjetl4tSuNNHNL++JFLUtaDb1mQuKRc9xHC0DU3eUkKpwtT436oBMVfG1A9102EFezGy9ZNau4BQyZ3QyxkpgzP8xspLIl2S+zU/ObPgJl9wZGw6iIfBFdJP+ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZdY4J7C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZdY4J7C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E662A1F000E9;
	Mon, 24 Aug 2026 07:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787556677;
	bh=yddPD/RkHmW45RUZ3yNjCsE01bniJjVp7kGfFmGqaqA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oZdY4J7CkJC9h1Nc+c9x3L63OOXi5OFrT1a5p9dH0h8aQlXXG5ajv4QzW01SD+hfC
	 qGNUy5eSZf++ZZ21XUy49D8bA3EKKHt44Y37cw4Wgb+AuzN4weZ2KLK9b9xbbcspT+
	 zIYTTlR6LObPp3OzvfrAF3edOnK0bazRnIUaEWo5EOpU3PXtpFy1DIuGtpJz5/TmTN
	 ygDN14qMasIAgEbj+ZmRHjRuOQlOQ1dm2xwby88RPd5IiQv6KTbK8ckcHyvdtmTD4E
	 8Qvsp0WY7egtyhKrdrOuEVR3teVFcluPtWbxHIQ4b729pQo78tiPS4a2abCZCoejB/
	 qUb99AR33ZANQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v4 3/5] mptcp: implement read_skb for sockmap
 stream verdict
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
In-Reply-To: <e785dea9d7ecfff7d8d49862833930cc742df5a4.1787554581.git.tanggeliang@kylinos.cn>
References: <cover.1787554581.git.tanggeliang@kylinos.cn>
 <e785dea9d7ecfff7d8d49862833930cc742df5a4.1787554581.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 07:31:16 +0000
Message-Id: <20260824073116.E662A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Calling skb_pull() with an unvalidated offset on potentially n=
on-linear SKBs causes a kernel BUG() panic.
- [High] Data consumed by the BPF stream verdict program does not trigger M=
PTCP receive window updates or buffer auto-tuning.
- [High] Error paths drop SKBs without advancing consumption state, leading=
 to receive window leaks and deadlocks.
--

--- Patch [3]: [PATCH mptcp-next v4 3/5] mptcp: implement read_skb for sock=
map stream verdict ---
commit b365e36f46ed4c92c3a7c83b8b32cf1113c12bbf
Author: Geliang Tang <geliang@kernel.org>
mptcp: implement read_skb for sockmap stream verdict

This commit adds mptcp_read_skb() to allow BPF sockmap stream verdict
programs to process MPTCP sockets. It peeks skbs from the receive queue,
adjusts offsets with skb_pull(), unlinks them, and passes them to the BPF
program while updating the bytes_consumed counter.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 265a07e73a529..c1e26c6e5c17b 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -4780,6 +4780,36 @@ static ssize_t mptcp_splice_read(struct socket *so=
ck, loff_t *ppos,
>  	return ret;
>  }
> =20
> +static int mptcp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
> +{
> +	struct mptcp_sock *msk =3D mptcp_sk(sk);
> +	struct sk_buff *skb;
> +	int copied =3D 0;
> +	u32 offset;
> +
> +	if (sk->sk_state =3D=3D TCP_LISTEN)
> +		return -ENOTCONN;
> +
> +	while ((skb =3D mptcp_recv_skb(sk, &offset)) !=3D NULL) {
> +		int used;
> +
> +		if (offset)
> +			skb_pull(skb, offset);

[Severity: Critical]
Does this risk a kernel panic? If the socket buffer in the receive queue is
non-linear (such as from GRO on the TCP subflow or page frags), and the
offset is greater than the linear part of the buffer (skb_headlen), calling
skb_pull() without first linearizing it can cause length underflows.

If skb->len drops below skb->data_len, it will trigger the BUG_ON() in
skb_pull_inline().

Should pskb_may_pull() be used here to ensure the bytes are in the linear
region first?

> +
> +		__skb_unlink(skb, &sk->sk_receive_queue);
> +		WARN_ON_ONCE(!skb_set_owner_sk_safe(skb, sk));
> +		used =3D recv_actor(sk, skb);
> +		if (used < 0) {
> +			if (!copied)
> +				copied =3D used;
> +			break;
> +		}

[Severity: High]
If the recv_actor returns an error and drops the buffer, this breaks the
loop without adding the dropped bytes to bytes_consumed.

Since tcp_eat_skb() is a no-op for MPTCP sockets, does this leave
bytes_consumed permanently out of sync with bytes_received? This might lead
to a permanent loss of receive window capacity and eventual connection
stalls.

> +		copied +=3D used;
> +		msk->bytes_consumed +=3D used;

[Severity: High]
Should this update also trigger receive window updates and buffer
auto-tuning?

After advancing bytes_consumed, omitting calls to mptcp_cleanup_rbuf() and
mptcp_rcv_space_adjust() means MPTCP will not proactively send window update
ACKs when the window opens.

The sender might eventually stall and rely on slow zero window probes to
discover the new window.

> +	}
> +	return copied;
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787554581.gi=
t.tanggeliang@kylinos.cn?part=3D3
