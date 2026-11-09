Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794186924;
	b=BcLeMf7QnTQncdfSqPplzj5aIQfsnupjWf8Hu+5wa798fNMJLopXZcZHEMlitSCNvjZ4
	 p3ZHP8FlbY+V6uSGEfigucFVKmnD+cJoMX+0cUvTtLFOhfeDuqIDOQ4jpGmTbVPvrT7w7
	 4uhg3EUASyQhmDN2eRORBsxddvH/XDUa0W+YWaIJEbuuSv4wa/ZLvudASsc/HSfQ4jaCq
	 NW2CdmLx2MW7UO+mFSzIBOwI/O4w+Hz4os/+Aw4lajW3DNr+rGdTayeeRygW9HV0ffjPM
	 RW1TOFs2iRkCSxDd6NkFqA7UQkCfjSH7Neco9bjPR90Wc1xNOTOl/3ErnfDaDTryPnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794186924;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=iOJ/1qMuI/JPUWv+VJFkW6mNhzR9rPaDxSQ8CP9MMak=;
	b=Axh4P+LSFWPmMUK/Ea4sPl3/09luAcO8WEBLsppV9JDZ1m2jNatGRI2CcGhLPsI0i914
	 kddcNR3Zf6MyhOznXMbk9H2JKRNGAzZDbkZj3XOFfpMYTYReMq3DNqYUOMLEOj8cQyYke
	 w9QkgJYNx6iIwYz6wvtODKAe6SgUdJHQ8C8DtyNCMCvOZ6n2lEZOkLH+B0hFrimRtneyh
	 SZj1kz7d+EHWAr0Rvp3w0GwuVjWjZrewXxHEzKBbpPE+EVTPpyT8DtDssPx3yk9y3l8Zq
	 /g+1fOU0w9aDBXKGKWowW7YM3FNZDPnYLun8k6fADFNZjN6YnaphKZwMJqJCU4j/J0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PQTG7iLD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F9A606A31C
	for <mptcp@lists.linux.dev>; Mon,  9 Nov 2026 01:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PQTG7iLD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82CB41F0089F;
	Mon,  9 Nov 2026 01:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794186923;
	bh=iOJ/1qMuI/JPUWv+VJFkW6mNhzR9rPaDxSQ8CP9MMak=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PQTG7iLDAMR296bjOu6qMk9S5H9HhV2gMTDgrFCjJZP8CSshAz/Elm54Xr7C2GSZQ
	 CrqB7ifuGuSlg+TX7W4WlbyokFci3oC6sk2kn7aw+5cB+3QqtCiNtWFYi7MWFYoMR0
	 f2P3XwnHBw8UPE1Z1XLQHw/Y7v598jbPt5AEAdSaGIzNZm1pmiJNpOAX19hpz7Wfya
	 0+ucJ2wRuh9NZZgy35afnbB4ANWKcQ5wJiM5cItWh1NEQ8UzR1DArqyadfzLdYYKFl
	 Dcvxu8IuHOCjeyfbK6oS9DdWLgQaV80qsIj3zGHjjJffToKlX1ba6VDTq4MWdKjeV2
	 r4il15BgkK+mg==
Subject: Re: [PATCH mptcp-next v7 4/7] mptcp: add sendmsg_locked to proto_ops
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, yangang@kylinos.cn, kuba@kernel.org
Date: Mon, 09 Nov 2026 01:15:23 +0000
Message-ID: <179418692307.488855.18330572263711701686@kernel.org>
In-Reply-To: <cec6cd455afe93513be5c82d51974efc6aed867f.1794053683.git.tanggeliang@kylinos.cn>
References: <cec6cd455afe93513be5c82d51974efc6aed867f.1794053683.git.tanggeliang@kylinos.cn>
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

- [Low] The patch adds `.sendmsg_locked = mptcp_sendmsg_locked` to
  `mptcp_stream_ops` (net/mptcp/protocol.c:4846) and…

--

mptcp: add sendmsg_locked to proto_ops

This splits mptcp_sendmsg() into mptcp_sendmsg_locked(), which expects
the caller to already hold the msk socket lock and asserts this with
msk_owned_by_me(), and a small wrapper that takes and releases the lock.
The locked variant is then exposed as .sendmsg_locked in both
mptcp_stream_ops and mptcp_v6_stream_ops.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 585730c30da1f..8ea06167b05d6 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -4833,6 +4843,7 @@ static const struct proto_ops mptcp_stream_ops = {
>  	.read_sock	   = mptcp_read_sock,
>  	.splice_read	   = mptcp_splice_read,
>  	.peek_len	   = mptcp_peek_len,
> +	.sendmsg_locked	   = mptcp_sendmsg_locked,
>  };

[Severity: Low]
Is there an in-tree path that can reach this op on an MPTCP socket?

The only code that dispatches proto_ops->sendmsg_locked seems to be the
static helper in net/core/skbuff.c. Only skb_send_sock_locked() and
skb_send_sock_locked_with_flags() use it:

net/core/skbuff.c:sendmsg_locked() {
    ...
	if (!sock->ops->sendmsg_locked)
		return sock_no_sendmsg_locked(sk, msg, size);

	return sock->ops->sendmsg_locked(sk, msg, size);
}

Neither of the two in-tree users of those helpers looks like it can be
attached to an msk.

espintcp in net/xfrm/espintcp.c is a TCP ULP, and
mptcp_setsockopt_sol_tcp() rejects TCP_ULP:

	case TCP_ULP:
		return -EOPNOTSUPP;

ovpn_socket_attach() in drivers/net/ovpn/socket.c only accepts UDP and
TCP sockets:

	if (sock->sk->sk_protocol == IPPROTO_UDP)
		return ovpn_udp_socket_attach(ovpn_sock, sock, peer->ovpn);
	else if (sock->sk->sk_protocol == IPPROTO_TCP)
		return ovpn_tcp_socket_attach(ovpn_sock, peer);

	return -EOPNOTSUPP;

The commit message also says that kTLS (net/tls/tls_main.c) and sockmap
(net/ipv4/tcp_bpf.c) call tcp_sendmsg_locked() directly and need
"additional changes". As far as I can tell, no patch up to and including
"mptcp: update mptcp_check_readable" makes those changes or adds another
caller.

So mptcp_sendmsg_locked() cannot currently be reached through proto_ops.
That leaves its semantics without a user or a test to check them against.
One example is masking out MSG_SPLICE_PAGES, even though __skb_send_sock()
always sets that flag for frag pages.

Could the .sendmsg_locked registration move to the patch that adds its
first caller?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1794053683.git.tanggeliang%40kylinos.cn
