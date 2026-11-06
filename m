Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793994801;
	b=ZiQyepvvvVn2xvefC+w1My95pcNaTnrhmBHy5AaKnY6saYZq3pcIhWpZedWzsDOjNgxm
	 qOmv10usKSqrfSW09/Ffgm30G9d1pU+GzqWwsjWcdO2FpGYQQTbnR6uk25zRpiXiYF48N
	 FUIW29epOWdnOJa1VgjTIwxSBWxOPm3pgwFqvv/hPyVO6ROOJY/Mx+dUjve8fY6kG6HLa
	 jZMlE6oN+3z2FsAGT6aJegEYUP9nxToyPnW2ju5wzsMktCfQw3OsRAzytTkvTHexshBtk
	 1alcmFelLhiDokL6h9qJaRRH803KEfBTjFVHrYNue4KX3bngrDal9/zJFM/uRfrYOhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793994801;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PgzLC6zq6SGycR3W2sR3JTz0Yi8U+dYq5qhvOQWu1ao=;
	b=hAVPVYDgYiokq80HyM9+2SVU04mqLNukt6vJX6A01qtVsroaVagWgmEAKaJ2NZuO3i/k
	 gZBL6wTbAJw92uk+s4rvjWJ8XaI6LJzzgJunBDP2YqShNTswEyscu0xy8DKznE9CQp2Ke
	 vRcHx3xWPDat7iqR+K8rL3QfhlF526hWYFJ4tTUuo7UqzgRQ0Pl492ofU/BBalhm7mP7F
	 IJpHsUTQyntQv0iPBPa5Kp9GfDOMKE8yp7Nq00ol1EmzdZkVsikNAWG9dpP4IS2yv9fiO
	 5xr72KGXtDkbu9SGZSTNQrel6rgpRuiSKAq+d61wtOrTxtuPQ1/Nn6iopejvs8NK74Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eiudMY3e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F9D606A32F
	for <mptcp@lists.linux.dev>; Fri,  6 Nov 2026 19:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eiudMY3e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F471F00902;
	Fri,  6 Nov 2026 19:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793994800;
	bh=PgzLC6zq6SGycR3W2sR3JTz0Yi8U+dYq5qhvOQWu1ao=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eiudMY3eE7b4kpPlRvAWQmEXh3cszHE+agfRhGuKZkQ9bWN/23Vj5eiFSYiUQRqCs
	 8tedFg+C+SkcNEp/wqewalT5HlyN71KCjeNF+ycK7GMpFPnhJ6NCmNDDol+iVT76zz
	 n60aNmsskmSqwsBLIkIqSAgiuLwMwJmi8sfdjWXqceyVxaQ4gwI+/41l7NsO53TYg9
	 nqSW6WBcoH4G5ukdjiuZvdYl7d74Ciqole9BaTcy55B/r84eTUFd+oTvotqhMspYx8
	 67ARV5opL83h5Ng+GXYHIH6vC9HUEHHX/rvyuZxxoRuXjt2XkLl82dsjkf0B5nZp+3
	 ELttUwDhZ+u4g==
Subject: Re: [PATCH mptcp-next v6 4/7] mptcp: implement peek_len for proto_ops
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, kuba@kernel.org
Date: Fri, 06 Nov 2026 19:53:19 +0000
Message-ID: <179399479958.488855.5313761673616598380@kernel.org>
In-Reply-To: <0033cad94cccd9808f0f7eae563bf6d27f414205.1793860134.git.tanggeliang@kylinos.cn>
References: <0033cad94cccd9808f0f7eae563bf6d27f414205.1793860134.git.tanggeliang@kylinos.cn>
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

- [Low] The commit message for "mptcp: implement peek_len for proto_ops"
  gets several of its TCP and mptcp_inq_hint() comparisons wrong.
- [Low] The commit message says the patch 'prepares for upcoming kTLS and
  sockmap support', but kTLS never calls sock->ops->peek_len.

--

mptcp: implement peek_len for proto_ops

This adds mptcp_inq(), which returns the readable bytes at the MPTCP level
based on mptcp_data_avail(). It is wired up through a new mptcp_peek_len()
callback, set as .peek_len in both mptcp_stream_ops and
mptcp_v6_stream_ops.

> Add mptcp_inq() to compute readable bytes at the MPTCP level using
> mptcp_data_avail() (bytes_received - bytes_consumed). This aligns with
> TCP's design where tcp_inq() is used by peek_len and tcp_inq_hint() is
> used by SIOCINQ.
>
> Like tcp_inq(), mptcp_inq() returns 0 during handshake (TCPF_SYN_SENT/
> TCPF_SYN_RECV), INT_MAX when avail >= INT_MAX, otherwise the actual byte
> count. Unlike mptcp_inq_hint() (which mirrors tcp_inq_hint()), this helper
> does not include the EOF hint (returning 1 when socket is closed with no
> data) because peek_len is used by upper layers like strp that only need
> the data length, not connection state information. It also does not drain
> the backlog before reading counters, as peek_len provides a heuristic
> value for rate limiting rather than an exact count for userspace queries.

[Severity: Low]
Are the comparisons to TCP and mptcp_inq_hint() here accurate?

On the TCP side, SIOCINQ in tcp_ioctl() calls tcp_inq(), which is the same
helper tcp_peek_len() uses:

net/ipv4/tcp.c:tcp_ioctl() {
    ...
		slow = lock_sock_fast(sk);
		answ = tcp_inq(sk);
		unlock_sock_fast(sk, slow);
    ...
}

int tcp_peek_len(struct socket *sock)
{
	return tcp_inq(sock->sk);
}

tcp_inq_hint() is only used for msg_inq / TCP_CM_INQ in tcp_recvmsg() and
for zc.inq in the zerocopy receive path. So TCP uses one helper for both
peek_len and SIOCINQ. With this patch, MPTCP uses mptcp_inq_hint() for
SIOCINQ and mptcp_inq() for peek_len, which does not match TCP.

Also, tcp_inq() has no INT_MAX clamp. It subtracts 1 when a FIN has been
received and handles urgent data, and mptcp_inq() does neither:

include/net/tcp.h:tcp_inq() {
    ...
		answ = tp->rcv_nxt - tp->copied_seq;

		/* Subtract 1, if FIN was received */
		if (answ && sock_flag(sk, SOCK_DONE))
			answ--;
	} else {
		answ = tp->urg_seq - tp->copied_seq;
	}
    ...
}

On the backlog point, mptcp_inq_hint() does not drain the backlog either.
That happens in its caller, mptcp_ioctl():

net/mptcp/protocol.c:mptcp_ioctl() {
    ...
		lock_sock(sk);
		if (mptcp_move_skbs(sk))
			mptcp_cleanup_rbuf(msk, 0);
		*karg = mptcp_inq_hint(sk);
    ...
}

Last, strparser does not seem to use peek_len for rate limiting.
strp_data_ready() and strp_recv() compare it against the bytes still
missing from the current message:

net/strparser/strparser.c:strp_data_ready() {
    ...
	if (strp->need_bytes) {
		if (strp_peek_len(strp) < strp->need_bytes)
			return;
	}
    ...
}

This checks whether the whole message is already queued, and decides
whether to set need_bytes and wait.

Could the commit message be reworded to describe these points accurately?

> This prepares for upcoming kTLS and sockmap support.

[Severity: Low]
Does this patch actually help kTLS?

The only caller of sock->ops->peek_len seems to be strp_peek_len() in
net/strparser/strparser.c, which sockmap and KCM use:

static inline int strp_peek_len(struct strparser *strp)
{
	struct socket *sock = strp->sk->sk_socket;

	return sock->ops->peek_len(sock);
}

The kTLS receive and device offload paths call tcp_inq() directly on the
socket, not through peek_len. For example:

net/tls/tls_strp.c:tls_strp_read_sock() {
    ...
	inq = tcp_inq(strp->sk);
	if (inq < 1)
		return 0;
    ...
}

There are similar direct tcp_inq() calls in tls_strp_check_queue_ok(),
tls_sw.c and tls_device.c. They are unchanged at the end of this series.

On an MPTCP msk, those tcp_inq() calls would read tcp_sock fields
(rcv_nxt, copied_seq, urg_data) from a struct mptcp_sock. Also,
mptcp_inq() is static, so later kTLS work cannot reuse it without further
changes.

Should the commit message mention only sockmap/strparser, since the new
.peek_len hook is not reached by kTLS?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793860134.git.tanggeliang%40kylinos.cn
