Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793741884;
	b=5IhDQiXF14919KXjnsIQ2GQ0Hv7I63x6ld5dy9f9hK1IXSyL7NhzsM8W/fdvELc4VpJ6
	 z/BwQ8TEv+IaSTQJ5BZgvPckT/WPjDmBXL8DVIQitN3WHDWUaV+G2xqyvYviMiuUaHhlR
	 wojutnu2z1y/ncrZ9EtEA5gQQ89YG0ui0zQ0tITDIoCJ5iZJ/PPhLHvRwCVTlJLhA00f9
	 t9NJIDpqjKJvikZvpKZCA5ifvTkaNfjV1vv2eQJtH/dduoZhj6IserFvBZWkCAmMs5xSZ
	 CDYkgkOPlOlilFu+bVMn3XgBkuwZMIeL6ACsgIz5GU8P8i1bmcfJzLLheZLZWXyRlcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793741884;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=et4jFj+lepmfD4AHQKMWafbOpDrJ6bouMC1wng41lQ4=;
	b=TmjIlTdWFEesIzXBu8eeuDHuFh299UKLjkZ3Xf/nRKSkxlky2FzUFVaJ4/PnjsUGVZ8j
	 z2RAzWhGz4ySPsi91bKM28PUMuICZccbyKcaUVwHaBzDu/Ka1CeMBmBgxChDgyw95PT4H
	 bQcf8ajn99CM/yvCm0g9t4NLE0301xo/Gvg+ZbwAXirJhA4STzsfNSrAUp9ZgHCiSSPhb
	 LvfybR+f1BUFjmhsKDqaNiMd0L6FzSVHCKwEkTyJOxlL3GZFOFJcJlptAcLM161qlunU/
	 Ij5RDKSGja+2qbFR77bEmJ84pa6THsdsUgpZruD2X3+yPdxr7lawnba/lQrRul/L5mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KfJezgtP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56457606A32C;
	Tue,  3 Nov 2026 21:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KfJezgtP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED56B1F000C1;
	Tue,  3 Nov 2026 21:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793741884;
	bh=et4jFj+lepmfD4AHQKMWafbOpDrJ6bouMC1wng41lQ4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KfJezgtPeJuhdphudtslfqfLb5Hj1S4cf34NMIx8XJLv2ZXVgiIFzMiT7s1WL4mco
	 8s9UjPUifC69RcESghSDGjKDcGEJ3cyZThSPnFJn2LHU9O15gELOTtWfok35lHeRfe
	 PFOMSfiOIi59Ug5/v2x0pQDYrYJTIeSkgxV8WNMrhHsI2L5rhUrcO1KpPOzgvyUn/N
	 K08MCds7UqE9IlGONzne6uFN7KvznmFyTchVqTPqvv6wuYpCrU9YD/vqMZPXr0eYLv
	 ubMmqC+B7KAZP2au7uOSjJhZ6itCXevTw82/TscMzNmX4SzNQU42Ka5oTvC52+OwJS
	 ltY4VhUK+6ygg==
Subject:
 Re: [PATCH bpf v2 09/15] bpf, sockmap: Check the TCP state in recvmsg()
From: netdev-bot+sashiko@kernel.org
To: alexei.starovoitov@gmail.com
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 john.fastabend@gmail.com, jakub@cloudflare.com, jiayuan.chen@linux.dev,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, kuniyu@google.com, willemb@google.com, matttbe@kernel.org,
 mptcp@lists.linux.dev, mason@kernel.org, josef@toxicpanda.com
Date: Tue, 03 Nov 2026 21:38:02 +0000
Message-ID: <179374188255.488855.9131092470801455035@kernel.org>
In-Reply-To: <20261102072112.4160195-10-alexei.starovoitov@gmail.com>
References: <20261102072112.4160195-10-alexei.starovoitov@gmail.com>
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

- [Low] Concern (commit message accuracy): the concern says the commit
  message wrongly claims icsk_ack.rcv_mss "can be 0 in TCP_CLOSE",…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but psock data
  from an old connection still advances tp->copied_seq of the next…

--

bpf, sockmap: Check the TCP state in recvmsg()

This commit makes tcp_bpf_recvmsg_parser() call __tcp_cleanup_rbuf() only
when tcp_can_send_ack() returns true. The reason is that psock data can
outlive the connection it arrived on, for example after tcp_disconnect().
tcp_can_send_ack() moves from net/mptcp/protocol.c to include/net/tcp.h so
both users can share it.

> __tcp_select_window() divides by icsk_ack.rcv_mss, which can be 0 in
> TCP_CLOSE.

[Severity: Low]
This isn't a bug, and the statement looks accurate. Still, a reader may
wonder how rcv_mss gets to 0 in TCP_CLOSE, because tcp_disconnect()
explicitly guards against it:

net/ipv4/tcp.c:tcp_disconnect() {
    ...
	inet_csk_delack_init(sk);
	/* Initialize rcv_mss to TCP_MIN_MSS to avoid division by 0
	 * issue in __tcp_select_window()
	 */
	icsk->icsk_ack.rcv_mss = TCP_MIN_MSS;
    ...
}

It seems to happen when a later listen() on the disconnected socket fails.
inet_csk_listen_start() calls inet_csk_delack_init(), which zeroes rcv_mss.
If get_port() or hash() then fails, the socket returns to TCP_CLOSE with
rcv_mss still 0:

net/ipv4/inet_connection_sock.c:inet_csk_listen_start() {
    ...
	inet_csk_delack_init(sk);
    ...
	err = sk->sk_prot->get_port(sk, inet->inet_num);
    ...
	inet_sk_set_state(sk, TCP_CLOSE);
	return err;
}

Would it help to mention this path, and that TCP_LISTEN is covered as
well, in the commit message?

> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index ef2e15de0fe3b..3d703f1517d88 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -343,7 +343,8 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
>  	if (!peek)
>  		WRITE_ONCE(tcp->copied_seq, seq);
>  	tcp_rcv_space_adjust(sk);
> -	if (copied > 0)
> +	/* Data on the psock outlives the connection that it came in on */
> +	if (copied > 0 && tcp_can_send_ack(sk))
>  		__tcp_cleanup_rbuf(sk, copied);

[Severity: High]
This is a pre-existing issue and was not introduced by this patch, but the
new comment points at it. If psock data outlives the connection, do the
copied_seq and tcp_rcv_space_adjust() updates just above the new check
still charge bytes from the old connection to the new one?

SK_PASS data is tagged as self-originated in sk_psock_skb_ingress_self():

	msg->sk = sk;

tcp_read_skb() does not advance copied_seq for these skbs. Instead,
tcp_bpf_recvmsg_parser() adds them later:

	seq += copied_from_self;
    ...
	if (!peek)
		WRITE_ONCE(tcp->copied_seq, seq);

tcp_disconnect() purges sk_receive_queue and sets copied_seq to rcv_nxt.
It leaves psock->ingress_msg alone, and the socket stays in the sockmap.
A later connect() resets copied_seq to the new rcv_nxt.

Here is a possible sequence:

  socket in a sockmap with an sk_skb stream_verdict prog returning SK_PASS
  data is received but not read (D bytes in psock->ingress_msg)
  connect(AF_UNSPEC) -> tcp_disconnect()
  connect() to a new peer, reaches ESTABLISHED
  recvmsg() -> tcp_bpf_recvmsg_parser() reads the D stale bytes

After this, copied_seq is new rcv_nxt + D and stays D bytes ahead for the
rest of the connection.

tcp_rcv_space_adjust() then computes inq = rcv_nxt - copied_seq = -D. That
inflates copied on every measurement and grows sk_rcvbuf and window_clamp
through tcp_rcvbuf_grow() for no reason.

If the socket later leaves the sockmap and falls back to
tcp_recvmsg_locked(), offset = *seq - TCP_SKB_CB(skb)->seq starts at D.
Wouldn't that silently skip the first D bytes of the new connection's
data? Or, when D is not less than skb->len, wouldn't it trigger the
"TCP recvmsg seq # bug 2" WARN in tcp_recvmsg_locked() or the
"cleanup rbuf bug" WARN in tcp_cleanup_rbuf()?

No later patch in the series seems to change how copied_seq is updated
here.

Should data that arrived on an earlier connection be kept out of the
copied_seq update too, and not only out of __tcp_cleanup_rbuf()?

>  
>  unlock:

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261102072112.4160195-1-alexei.starovoitov%40gmail.com
