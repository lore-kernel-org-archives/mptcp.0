Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794963947;
	b=FuPUKCqlndOGUUAUsi11YCItI7Rjpuy4KXlAvvrTZOxfYpJm+1CaiXaeuURaoT2FAKtD
	 SCdfZ894CEbSnZkrLPaE9cIkVT4AsPwSJW4gQxBa9HU+afRiDeAxwqT0MtF/RXRc0+PBG
	 wf3V9nhBpQjp15CEQ+jmwxtwwibceou57+Gz/w7N2MKjYG/za8t6VR5bKoyhbc6KGdAp/
	 GlNYKF8GatYEgSB1SuJl0xuGOD8xn2DkwiyZi7NAjwTEGeMkVW0641q8YLM4bd/7kg1C0
	 5UhCaPeBTP8zwUmtPG3n1wGMyt3b24Ra7szIVQwVtzfRyBEN2cy5o5U+CH+v1JVeHpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794963947;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=5UMruVWXJtXhhsASd0xTwxA8k9CedJTw+YW5Iru8yZk=;
	b=GpSWTJr0sPboZ097hrwtepVfR7Q9X4Vs0AxJWTLpw9ufdhdjfYbKVuRQ4qxrSAJM3ChG
	 buolz7L8aXJU9YR3uqQ5GCqGP+ztcwndSMldwh6tAhbOEUfvRPUMo3NHtr/BSHFsfJN6h
	 tw5VYB+2NHvYA0WsELSkkw/D7sIKdH79IcLoLa612XpM6X9dw4vQ1M0GKtFJd6dkuuDL8
	 AF1MOQSZ5p+Bi5dL5oKUOySXaXZQQizaiM1yQBmC8Tgj/kxjBdrzz9v2JJ2GrStrgx79e
	 c8I9TLu5nKWO27EOAEXjRWAxS5/ht+Ccojl9y4FWPYqILM/ypX6tmRqBoW1HWEcKbow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IpkFC0Uh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1B8606A31C
	for <mptcp@lists.linux.dev>; Wed, 18 Nov 2026 01:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IpkFC0Uh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B65721F000C7;
	Wed, 18 Nov 2026 01:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794963946;
	bh=5UMruVWXJtXhhsASd0xTwxA8k9CedJTw+YW5Iru8yZk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IpkFC0UhSQo6WM4wX++oky66XafAW0QNJ5aoIgFidTUqPei55K1GDLbm6eXTgajEk
	 nW0OYxiFXpIZxTFBCDDvXgiIe+IDnEe1BOXnhRA3AeANHs8IzuHAJvBNMojPjKC2Hr
	 d4RoLQ84WHnf1JPuXMN7YUWemMQNWVTyU4ZXoWLnbrdL6ymdT+f3Jz0TONV9FXmQ8Y
	 k8oiKEftxgspKCOv9GdbRQ5F9JYLzdD1EUYaM5F2HoVqGF2RnMGFIxg3XMmeeABZAP
	 KuWCxo2JoSWnkoMahG/JtFCkG9Czynjv0t/SbJcjnGeDOY0qBXHxvptQ/w6sl90xbP
	 Kg65TDLzwV6rg==
Subject: Re: [PATCH mptcp-next v8 4/7] mptcp: add sendmsg_locked to proto_ops
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Wed, 18 Nov 2026 01:05:46 +0000
Message-ID: <179496394632.3133.4263841148082085477@kernel.org>
In-Reply-To: <2d180799564c49dc62ab876fbcb358670ece3a29.1794826541.git.geliang@kernel.org>
References: <2d180799564c49dc62ab876fbcb358670ece3a29.1794826541.git.geliang@kernel.org>
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
  `mptcp_stream_ops` and `mptcp_v6_stream_ops`, but no in-tree caller…
- [Low] The commit author is 'Geliang Tang <geliang@kernel.org>', but the
  only Signed-off-by is 'Geliang Tang <tanggeliang@kylinos.cn>'.

--

mptcp: add sendmsg_locked to proto_ops

This commit splits mptcp_sendmsg() into mptcp_sendmsg_locked(), which
expects the caller to hold the msk socket lock, and a small
mptcp_sendmsg() wrapper that takes the lock. It also sets
mptcp_sendmsg_locked() as the .sendmsg_locked hook in both
mptcp_stream_ops and mptcp_v6_stream_ops.

> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

[Severity: Low]
This isn't a bug, but the author is Geliang Tang <geliang@kernel.org>,
while the only sign-off uses tanggeliang@kylinos.cn. checkpatch.pl reports
this as FROM_SIGN_OFF_MISMATCH.

Could a Signed-off-by for the author address be added, or the author
address be changed to match?

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index a0ad28f5a3851..83abdf39c4e54 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -4832,6 +4842,7 @@ static const struct proto_ops mptcp_stream_ops = {
>  	.read_sock	   = mptcp_read_sock,
>  	.splice_read	   = mptcp_splice_read,
>  	.peek_len	   = mptcp_peek_len,
> +	.sendmsg_locked	   = mptcp_sendmsg_locked,
>  };

[Severity: Low]
Is there an in-tree caller that can reach this hook for an MPTCP socket?

The only generic caller of proto_ops->sendmsg_locked seems to be
sendmsg_locked() in net/core/skbuff.c. It is reached only through
__skb_send_sock(), from skb_send_sock_locked() and
skb_send_sock_locked_with_flags(). Only espintcp and ovpn call those
helpers.

ovpn_socket_attach() in drivers/net/ovpn/socket.c rejects any protocol
other than UDP and TCP:

	if (sock->sk->sk_protocol == IPPROTO_UDP)
		return ovpn_udp_socket_attach(ovpn_sock, sock, peer->ovpn);
	else if (sock->sk->sk_protocol == IPPROTO_TCP)
		return ovpn_tcp_socket_attach(ovpn_sock, peer);

	return -EOPNOTSUPP;

espintcp needs the TCP ULP, and mptcp_setsockopt_sol_tcp() in
net/mptcp/sockopt.c refuses it:

	case TCP_ULP:
		return -EOPNOTSUPP;

As the commit message itself says, kTLS and sockmap still call
tcp_sendmsg_locked() directly.

The commit message also says:

    However, certain upper layers need to call the sendmsg method while
    the socket lock is already held.

Which upper layer does this refer to? I could not find anything in this
patch or in the rest of the series (app-limited tracking, the
mptcp_check_readable update, selftests) that calls .sendmsg_locked on an
msk. So the new entry here, and the matching one in mptcp_v6_stream_ops,
look unused.

Could the commit message name the intended consumer? Alternatively, could
this patch be merged together with the series that adds that consumer?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1794826541.git.geliang%40kernel.org
