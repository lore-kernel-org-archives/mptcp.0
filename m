Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793994801;
	b=Sc9TqPoIs7iSEtfD8u3UHISr19Z2cVKhrD8xM/YSTG7v8Ud7D5OqMl8/hpK3As5yzOMa
	 kIETXD6hBwKwq0BRVwfbR+cRTZ/1guU0ekGuUA9cB7Z4Xz6z1IyzK5QWv2M7+ZcBGKd2X
	 PDJV/1sPDY/NCpF9iYbRFei4B+wKSO+XmPi++0SPxelj44/k7xrJaaOKgs6RKEKOPqiES
	 7fFpb8SBQy2S0bXb9tHDDTIi4q9qHZbj698FLbIGl1oJ7Cwq5MhCpbLdPsrmH8Tsnkm3Q
	 HNcg7qtHUdIJ6y/Vq5k0oC/fpjcKv/WWEDarq6dVc+LZOiKvYfJG/ZAgd0vgZDWFK4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793994801;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=1dD2OABn+pIJLTdVGLP5v7zbcLhBMPEHFXYZ2pk4tjs=;
	b=XQ9eaIDVvVcrJ6W3txFsFUeSCLJwvP/eZ5GNt/8IWEzAdKgNr5wR5Ea/LdDysQTcNQHv
	 igThkRfXyARwW7q/cB8Qo+ofoYhdSlw7Hj/OChqXgfTF3htt6PaWgPppmonubrNCPVRgD
	 jOKvgdlw8u3Dpasd67SFvg+xdYE8tjBUPQP1OlI4jh0X4FbHnOkhEa/GCBscOI8Ae3h62
	 RrKyeq6sq3f/bbdjSuNcyeV7UOBgDgAfB6plUPZnW/6tCfu1eaGeDeyDHv0mTSx0ZHsa2
	 Bjb6khePsmBF8DI5vYa9YQx3ERVcnh24JqJt/njsuRtS0AOlDQ6+ZhM0Hpuamcoc0Tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EheyS3Px;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D16E606A329
	for <mptcp@lists.linux.dev>; Fri,  6 Nov 2026 19:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EheyS3Px
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE4B41F0089F;
	Fri,  6 Nov 2026 19:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793994801;
	bh=1dD2OABn+pIJLTdVGLP5v7zbcLhBMPEHFXYZ2pk4tjs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EheyS3PxOph99tJO8oLIRYvrr4k2QhW1QMvZ/QBLouy8hAHigQ2R6+efgXxK9u6HB
	 D+JPbhNOKmQOFp6LeFiEZeNl5NiMqaHiiDc7Gim5wZxZeGeopJuOJr8e30C8yUfI4D
	 9Ixc0BnTIp1yfJQ7cpzmh0e25AtKKJ9IfiMHi89LeMOYWaX2uX9gCyvzohjrefCqNx
	 77rlNU/qrk5OsJ742VcfBzqvtg92ZKBR9glT1NxL2lFFF73gaDUWrvLo7u7WVY0S0w
	 upcA5Dy4eqK886pqr1bWvbSQ53casZod1pRydxxEmTlJX7zPSjGgGf1Rg43NpnruEq
	 D7Y7cKo7pq2VQ==
Subject: Re: [PATCH mptcp-next v6 5/7] mptcp: add sendmsg_locked to proto_ops
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, kuba@kernel.org
Date: Fri, 06 Nov 2026 19:53:20 +0000
Message-ID: <179399480041.488855.9625278415975346158@kernel.org>
In-Reply-To: <591f2c2e1046f4a0537734a6c0db4d360a876010.1793860134.git.tanggeliang@kylinos.cn>
References: <591f2c2e1046f4a0537734a6c0db4d360a876010.1793860134.git.tanggeliang@kylinos.cn>
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

- [Low] This patch adds `.sendmsg_locked = mptcp_sendmsg_locked` to
  `mptcp_stream_ops` and `mptcp_v6_stream_ops`, but nothing in the tree,…
- [Low] The commit author is "Geliang Tang <geliang@kernel.org>", but the
  only Signed-off-by is "Geliang Tang <tanggeliang@kylinos.cn>".

--

mptcp: add sendmsg_locked to proto_ops

This splits mptcp_sendmsg() into two functions. mptcp_sendmsg_locked()
expects the caller to already hold the msk socket lock, and a small
mptcp_sendmsg() wrapper takes the lock. The locked variant is exposed as
.sendmsg_locked in mptcp_stream_ops and mptcp_v6_stream_ops, as
preparation for kTLS and sockmap support.

> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

[Severity: Low]
This isn't a bug, but the commit author is
"Geliang Tang <geliang@kernel.org>" and the only Signed-off-by uses
<tanggeliang@kylinos.cn>. checkpatch reports this as
FROM_SIGN_OFF_MISMATCH.

Was an in-body From: line lost when the patch was applied? Or is a
sign-off from the author address missing?

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index aed25c901e4b1..b9c7b0bb6f742 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -4834,6 +4844,7 @@ static const struct proto_ops mptcp_stream_ops = {
>  	.read_sock	   = mptcp_read_sock,
>  	.splice_read	   = mptcp_splice_read,
>  	.peek_len	   = mptcp_peek_len,
> +	.sendmsg_locked	   = mptcp_sendmsg_locked,
>  };

[Severity: Low]
Can any path reach this op, or the same entry in mptcp_v6_stream_ops,
for an MPTCP socket?

The only generic user of proto_ops->sendmsg_locked is the static
sendmsg_locked() helper in net/core/skbuff.c. That helper is reached
only through skb_send_sock_locked() and
skb_send_sock_locked_with_flags(). Neither of their two callers can run
on an MPTCP socket:

- net/xfrm/espintcp.c is a TCP ULP, and mptcp_setsockopt_sol_tcp()
  rejects TCP_ULP:

	case TCP_ULP:
		return -EOPNOTSUPP;

- drivers/net/ovpn/tcp.c only attaches when
  sk_protocol == IPPROTO_TCP.

The commit message says this prepares for kTLS and sockmap. Neither of
them uses proto_ops->sendmsg_locked. tls_push_sg() in
net/tls/tls_main.c, tcp_bpf in net/ipv4/tcp_bpf.c, and espintcp all
call tcp_sendmsg_locked() directly:

	ret = tcp_sendmsg_locked(sk, &msg, size);

Would kTLS and sockmap each still need a separate refactor before this
hook is used? The later patches in the series ("mptcp: track
app-limited state in mptcp_sendmsg" and "selftests: mptcp: sockopt:
check app_limited") don't add a caller either. The op is still unused
at the end of the series.

The op also behaves differently from the TCP op it mirrors.
mptcp_sendmsg_locked() keeps the inherited flag mask:

	msg->msg_flags &= MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
			  MSG_FASTOPEN | MSG_EOR;

This mask drops MSG_SPLICE_PAGES. tcp_sendmsg_locked() honours that
flag, and the expected locked callers, __skb_send_sock() and
tls_push_sg(), set it. Data is still copied correctly.

Should the commit message mention this difference?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793860134.git.tanggeliang%40kylinos.cn
