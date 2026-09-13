Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3575239E9C8
	for <mptcp@lists.linux.dev>; Sun, 13 Sep 2026 10:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789296529; cv=none; b=r35Dk3zUAdbm+m3MT7ZPUS0RMev8+C3H7fKBViHNrZ7/Il3emFWjvLK7TZS23oV4BVThs8m+SGnPEpo2W7dzmKJGB5GctUG6eME4jpU7HS0Sy75rNe81ynaFzrxBulQ1XgNA6pnK7V8Z3SIbdPDeGKypdDQoOFBJpUxpp7P47TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789296529; c=relaxed/simple;
	bh=jjayAZl/I7emEegDpCXSs9jkEkao/ONt8EjDH9ad8fk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=URiMCJRXIZUZkxGnAB6yB29IHl49coauI9KGtef9cP3CkgyT/7dYugSHwtPXGszDogwZS/V8aOEsY/Jn4bqRXChDybow9g6shR1lZqekF9QMK6HRsRVxqpBAhOjQlIaU4AHfOS/mrsvRlcfc6alaj9oSDDk7ErfCpQ8tTq32XdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XtgJp8Kf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtgJp8Kf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF1B91F000FF;
	Sun, 13 Sep 2026 10:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789296528;
	bh=tQ43yWfNqcFgDk4E3WkOOA+addZ39OZun3nC69m1KNw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XtgJp8Kfn3jp2TigSd1LWALc5k/k0CPIDDZpbTUDjQ0jmarrFbBdgIEve1Hex2CTe
	 1PoRlNyfXuYd9ZAWlMfXCOW7fQFfgcHm+DET3A43NWjB6KdgiwUh5zWuGOZKM2ujyC
	 UcjbTmB5AqyA6pKKG7UU4JzkxqJj8TWExY1xs1RYOfIYRZZCBt7/RBVOJeFhbERMOx
	 oE7eKRy7dj7SxmL7nyc968a70otiCR0G4Q2Gzk7B6p49ELP7yPB+EyZ6uwlp1n0VSg
	 vatbd/YiMNQ/Lj9e/1jG55dautr0eNq3YsTvlF2VNwqUzbfC1QEVZ9Nt46/ESEj0R8
	 Vm6C9pRGlZLCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v5 13/16] mptcp: add sk_is_msk() helper and
 use it in sockmap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
In-Reply-To: <29ec7b3fc7febc1c8946add34f859c8253d9714f.1789294365.git.tanggeliang@kylinos.cn>
References: <cover.1789294365.git.tanggeliang@kylinos.cn>
 <29ec7b3fc7febc1c8946add34f859c8253d9714f.1789294365.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 10:48:47 +0000
Message-Id: <20260913104847.EF1B91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Dereferencing a NULL function pointer (`sock->ops->peek_len`) when=
 an MPTCP socket is attached to a sockmap or stream parser, causing a kerne=
l panic.
- [High] MPTCP sockets are whitelisted for sockmap and stream parser operat=
ions without implementing the necessary BPF protocol hooks, leading to conn=
ection stalls, memory exhaustion, or dead code.
--

commit 2158e08c7c84a4a26fae56ddc0a38db5585b51c3
Author: Geliang Tang <geliang@kernel.org>

mptcp: add sk_is_msk() helper and use it in sockmap

This commit introduces the sk_is_msk() helper to identify MPTCP sockets.
It modifies sock_map.c to treat MPTCP sockets identically to TCP sockets
for stream parser linking, redirect checks, and state validation.

> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index 3e3e85e3bd54e..e9e0b676aa1ca 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -303,7 +303,7 @@ static int sock_map_link(struct bpf_map *map, struct =
sock *sk)
> =20
>  	write_lock_bh(&sk->sk_callback_lock);
>  	if (stream_parser && stream_verdict && !psock->saved_data_ready) {
> -		if (sk_is_tcp(sk))
> +		if (sk_is_tcp(sk) || sk_is_msk(sk))
>  			ret =3D sk_psock_init_strp(sk, psock);

[Severity: High]
Does this code expose MPTCP sockets to a NULL pointer dereference?

By enabling stream parser initialization for MPTCP sockets here, we
override the socket operations and expose the stream parser paths.
However, MPTCP sockets do not implement the .peek_len operation
in mptcp_stream_ops.

When an MPTCP socket is attached to a sockmap, its ioctl is overridden
to tcp_bpf_ioctl(), which unconditionally calls it:

net/ipv4/tcp_bpf.c:tcp_bpf_ioctl() {
    ...
    *karg +=3D sk->sk_socket->ops->peek_len(sk->sk_socket);
    ...
}

Similarly, the stream parser unconditionally calls it when parsing:

net/strparser/strparser.c:strp_peek_len() {
    ...
    return sock->ops->peek_len(sock);
}

Can an unprivileged user trigger a kernel panic by adding an MPTCP socket
to a sockmap and invoking ioctl(SIOCINQ) or receiving partial data?

[Severity: High]
Does this code also cause connection stalls and potential memory exhaustion
by whitelisting MPTCP for sockmap without implementing the required BPF
protocol hooks?

When an MPTCP socket is attached and processing SKBs, mptcp_read_skb()
unlinks the SKB for BPF verdict processing but entirely skips MPTCP's
internal consumption accounting (msk->bytes_consumed). This causes
mptcp_data_avail() to always return > 0, leading to mptcp_poll() busy-loopi=
ng
with EPOLLIN at 100% CPU.

Additionally, when a stream parser is attached, sk_psock_init_strp()
skips overriding read_sock for MPTCP:

net/core/skmsg.c:sk_psock_init_strp() {
    ...
    if (sk_is_tcp(sk)) {
        psock->strp.cb.read_sock =3D tcp_bpf_strp_read_sock;
    ...
}

This forces a fallback to mptcp_read_sock(), which improperly uncharges the
SKB memory from the socket and ACKs the sender while the parser clones the
uncharged data into psock->ingress_msg. This bypasses socket memory limits,
allowing an attacker to stream infinite data and exhaust kernel memory.

Finally, MPTCP fails to provide a custom recvmsg parser for the BPF
configurations in mptcp_bpf_rebuild_protos(), falling back to mapping
mptcp_bpf_recvmsg directly to __tcp_bpf_recvmsg. This completely breaks
sequence tracking when SKB verdicts route data to the psock.

>  		else
>  			ret =3D -EOPNOTSUPP;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789294365.gi=
t.tanggeliang@kylinos.cn?part=3D13
