Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794963946;
	b=MPm1S6QUyk29uZqeVXTuXtzN0hxRo5RQvTUnCDF4z1YabT+FZO7qwjeqrA451y12KHT/
	 A7ktgrTir6NE2fWzaIYyNiFUPfdUcCULPsRkMjbwM9AN/hWYXTdBCkA2QsVdnQqCKjM6e
	 ooCW+EL+Pa82UvZVSJaZvFu71F8XDoxb3ZYUxp/a/7+kbOYLl1sjXh2qbld9pFVQzUbz3
	 80nlTfjOCkczv11IADCoa6SDcTUJg4cYsq/+BVbNs1iiVM74J9b4M5AZ+L7Jfm+zuwlRF
	 cTQ+F/rq6GoT3boRt5Dm/uGbx8Pb20dwLz491IE6dexXdiehSssFJoz9FnGn2SDY05Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794963946;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=uhAiREtGIH/iR4IX6JKi+W/CAy37Yqb8AVLq76n6WkY=;
	b=u2jZRK7JBui/3J1hSvy0ZIZzSYm0fPDTzJvap8jVc33381GT0m9r6EeBgcpgSUdiFNG3
	 rmaZ5tFAplcpe6mZrPBZ9Faby1vLBUddEgGc0o/u5goCN7gaupH0Uszl0X/Oh0rT6mc3V
	 psdNG72cWBfY8F/Ui4E0ETbW1GPy90+XSooYKTWvtsQ5OHd5yy/MZ9qMeV4RoqhZEzV5M
	 gTOrj9x524Zs8+SDJZhK1llHvVlMGEucgDf05JssrhqE5sf/SDhx86BSh/2F+2XkEHTAa
	 G+FHOBCrwLluvi1oqaOKq/V7b8+HoeDcgWG7vEGTTNUDH1Gcl3Jtz1+nj5EHj9XFt9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="UgF/0+Tl";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4893F606A31C
	for <mptcp@lists.linux.dev>; Wed, 18 Nov 2026 01:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UgF/0+Tl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12181F000C4;
	Wed, 18 Nov 2026 01:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794963946;
	bh=uhAiREtGIH/iR4IX6JKi+W/CAy37Yqb8AVLq76n6WkY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UgF/0+TlUqY4CUqUhzSHsoIKfQ3y9Eco575dTR+sV2T3rw7hIgi/W/POdRB6uJwDO
	 1hU4qxwmfvUtZnBR+7PrlBPDvb/c2aUdjCS87Xi828eJbDa5UeZAKsuv07ZI8M1NdL
	 sbVpLfDAU6tntYNz2S9s/X0tLRwCW1D276TiBE3/1EoUBolbdeCkYNITAsQkUrAGFT
	 G6Ed7Dc0igQ6U02Kcgs906SgGAdfGH85x2/n+Pnw1btnFYdZqlqFdlR8g8iWLd7tlP
	 84fcTp0iddd7A+jaOU3GWQS7ox/FgQ6VNQtWdnmnA03XQB6c4TxnJIvbCoPDPPCzwl
	 bzrcAy07tGVeg==
Subject: Re: [PATCH mptcp-next v8 3/7] mptcp: implement peek_len for proto_ops
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Wed, 18 Nov 2026 01:05:45 +0000
Message-ID: <179496394553.3133.12238622788939082283@kernel.org>
In-Reply-To: <0ecc320bbed2cf5713fd0e23c71bbb7127370a70.1794826541.git.geliang@kernel.org>
References: <0ecc320bbed2cf5713fd0e23c71bbb7127370a70.1794826541.git.geliang@kernel.org>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The new mptcp_peek_len() (net/mptcp/protocol.c), wired into
  mptcp_stream_ops and mptcp_v6_stream_ops, has no caller that can reach…

--

mptcp: implement peek_len for proto_ops

This adds mptcp_inq(), which uses mptcp_data_avail() to report how many
bytes can be read at the MPTCP level. It also wires mptcp_inq() into a new
mptcp_peek_len() callback. That callback is set as .peek_len in both
mptcp_stream_ops and mptcp_v6_stream_ops, to prepare for kTLS and sockmap
support.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 574eba9989a8d..a0ad28f5a3851 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -4789,6 +4789,26 @@ static ssize_t mptcp_splice_read(struct socket *sock, loff_t *ppos,
>  	return ret;
>  }
>  
> +static int mptcp_inq(struct sock *sk)
> +{

[ ... ]

> +}
> +
> +static int mptcp_peek_len(struct socket *sock)
> +{
> +	return mptcp_inq(sock->sk);
> +}

[Severity: Low]
Can anything call mptcp_peek_len() on an MPTCP socket, either at this
commit or later in the series?

I can only find two users of ->peek_len. One is strp_peek_len() in
net/strparser/strparser.c, called from strp_recv() and strp_data_ready().
The other is drivers/vhost/net.c, and vhost-net only accepts AF_PACKET or
tap sockets through get_raw_socket() and get_tap_socket().

The strparser users don't seem to accept MPTCP sockets. sock_map_link()
only sets up the strparser for TCP:

net/core/sock_map.c:sock_map_link() {
    ...
	if (stream_parser && stream_verdict && !psock->saved_data_ready) {
		if (sk_is_tcp(sk))
			ret = sk_psock_init_strp(sk, psock);
		else
			ret = -EOPNOTSUPP;
    ...
}

sk_is_tcp() requires sk_protocol == IPPROTO_TCP. kcm_attach() also
rejects any csk->sk_protocol other than IPPROTO_TCP.

The commit message says:

    This prepares for upcoming kTLS and sockmap support.

Is the kTLS part accurate? kTLS receive doesn't use net/strparser. It has
its own parser in net/tls/tls_strp.c, which calls tcp_inq(), tcp_sk() and
tcp_read_sock() directly on strp->sk and never calls sock->ops->peek_len:

net/tls/tls_strp.c:tls_strp_read_sock() {
    ...
	inq = tcp_inq(strp->sk);
	if (inq < 1)
		return 0;
    ...
}

The commit message also uses a consumer that isn't in this series to
justify some specific choices: no EOF hint, no backlog drain, and
returning 0 in TCP_SYN_SENT/TCP_SYN_RECV.

None of the later patches in the series seem to add a caller either. That
covers "mptcp: add sendmsg_locked to proto_ops", "mptcp: track app-limited
state in mptcp_sendmsg", "mptcp: update mptcp_check_readable" and the
selftests.

Could this patch be merged together with its first user? Those choices
could then be checked against how the callback is actually used.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1794826541.git.geliang%40kernel.org
