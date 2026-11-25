Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795612149;
	b=mBBLtqF+2ThubGYBtBvtwaSqH9xoZrpjgi3mq8keXj5p9N4QfbIqKYe4UyXH0djUYwZV
	 2vClk5oqgGcDmVF+CVe/gwRzahNf2e6Zc4aku/wfAQXl2BsXFkL9TwJGn8ZJ4NOyMGE9d
	 aGys4XyfTfGLMF9FAcGjufs4rpQ6B0j8upmpolmfxJXN3d9EnqktkxeIN4cO9ClH/qjLS
	 KRLSm2FlBc3cbWOdaKQDDHHTRXnOsqOz0JWnM54gXKpqd2b1bqVl/M9jzduxTjSnlrjh6
	 2pkoXTHtH5Vxf8f84+5aWVrZ5uID/TMtYK6t+L0U2A7GjH5wkCsXejGYNA9i/LTzV+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795612149;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=P2CI3omyDspma2vJvXkUINUb035EDn0PEqafPwJibLY=;
	b=wNC0YvmFsc6kxe8iPCKEcJ4y9nbOerUUbNV/anHT6J6EoQnUCW4QUgmhnUOYfkcfDpqs
	 MnR+8X5TaVQQmvyOTgu97TVTybpI353G33qOi9lSJsaGXs/JWKZKTwWDd+pzMUe+Pl4yv
	 vIiRxvfsLHQ/XJkYkgo5Vm4ldK2iIWbjQXYS90llvFz0eG/l9NfNYe+40bMSAKh6Ga1QH
	 ZE6NmVor0f8RWE01+YimIakWLmlyvZkHnheLhwIrFabsR4ZEl+WtvutwlYVcLV3DNa8tu
	 GwpKWxikvhwAAT7rKhMLan0Vm5VuV5a9L4kiI4nWTupkr8Sb1ayAmPEhqbIQPW9zLMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d0WBqVQ1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6859606A329;
	Wed, 25 Nov 2026 13:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d0WBqVQ1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99CE91F000C6;
	Wed, 25 Nov 2026 13:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795612148;
	bh=P2CI3omyDspma2vJvXkUINUb035EDn0PEqafPwJibLY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d0WBqVQ1HHLVMoRPdDFDxGhWdISvCO+vahOWtvkaJ/jnG/NPFsmwqXN8opwPUS8wY
	 Ta4J2lcy0PyU3RulhCVaTGFFjmxuieEFllQ6EnqR5NSENriuNcla8KlzbNSg1NpFmm
	 kL7yDY4xqtEr1I92FTcgGYWiQeJf7YrT+vgMuZaK0noGNoQtArZTzTDPOZZ7pOp8Yp
	 ZIxbpz6SMTdpWTW9A6t4gNXoVIbVv/N7rWv093dUKTUNJVb6jZWIVsci3PCzWVPACg
	 iiIcc8fjotLt91IyqKotLe0607815evowKdNFgZYRuVoxZ9jHwA2CvRe0H4CodFy9C
	 xiMnm+Di6RbkQ==
Message-ID: <sashiko-outbox-233462@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v1 5/6] tcp: avoid a stack canary in
 tcp_rcv_established()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xuanqiang Luo" <xuanqiang.luo@linux.dev>
Cc: bpf@vger.kernel.org, mptcp@lists.linux.dev
In-Reply-To: <20261124130631.1886963-6-xuanqiang.luo@linux.dev>
References: <20261124130631.1886963-1-xuanqiang.luo@linux.dev>
 <20261124130631.1886963-6-xuanqiang.luo@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 13:09:08 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] tcp: post-FIN segments queued in tcp_rcv_state_process() and
  tcp_data_queue() [1]
--

commit a4b62910075d79274253c31ee8181da76c593e87
Author: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

tcp: avoid a stack canary in tcp_rcv_established()

This commit changes tcp_try_coalesce(), tcp_ooo_try_coalesce() and
tcp_queue_rcv() to return an enum tcp_eaten by value instead of taking a
boolean pointer for fragstolen, avoiding a stack canary in
tcp_rcv_established() and tcp_data_queue().

> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 801c76744ed8a..3d0a8b7e883e4 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c

[ ... ]

> @@ -5756,7 +5761,7 @@ static void tcp_data_queue(struct sock *sk, struct =
sk_buff *skb)
>  			sk_forced_mem_schedule(sk, skb->truesize);
>  		}
> =20
> -		eaten =3D tcp_queue_rcv(sk, skb, &fragstolen);
> +		eaten =3D tcp_queue_rcv(sk, skb);
>  		if (skb->len)
>  			tcp_event_data_recv(sk, skb);
>  		if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN)

[Severity: High]
This problem wasn't introduced by this patch, but can a peer queue
post-FIN payload onto sk->sk_receive_queue and advance tp->rcv_nxt after
EOF [1]?

After an in-order FIN has been processed, RCV_SHUTDOWN is set and
tp->rcv_nxt has advanced past the FIN sequence number.  If a socket in
TCP_CLOSE_WAIT, TCP_CLOSING, or TCP_LAST_ACK with a non-zero receive
window receives a segment with seq =3D=3D tp->rcv_nxt - 1, 1 byte of payloa=
d,
and TCPHDR_FIN set (end_seq =3D=3D tp->rcv_nxt + 1), both checks in
tcp_rcv_state_process() are bypassed:

net/ipv4/tcp_input.c:tcp_rcv_state_process() {
    ...
	case TCP_CLOSE_WAIT:
	case TCP_CLOSING:
	case TCP_LAST_ACK:
		if (!before(TCP_SKB_CB(skb)->seq, tp->rcv_nxt)) {
			...
			break;
		}
		fallthrough;
	case TCP_FIN_WAIT1:
	case TCP_FIN_WAIT2:
		if (sk->sk_shutdown & RCV_SHUTDOWN) {
			if (TCP_SKB_CB(skb)->end_seq !=3D TCP_SKB_CB(skb)->seq &&
			    after(TCP_SKB_CB(skb)->end_seq - th->fin, tp->rcv_nxt)) {
				NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTONDATA);
				tcp_reset(sk, skb);
				return SKB_DROP_REASON_TCP_ABORT_ON_DATA;
			}
		}
		fallthrough;
	case TCP_ESTABLISHED:
		tcp_data_queue(sk, skb);
    ...
}

Subtracting th->fin from end_seq yields tp->rcv_nxt, so the RCV_SHUTDOWN
check does not reset the connection and calls tcp_data_queue().  Because
seq < tp->rcv_nxt < end_seq, tcp_data_queue() treats the packet as a
partial overlap and jumps to queue_and_out, where tcp_queue_rcv() queues
the post-FIN data and advances tp->rcv_nxt.

This corrupts tcp_inq() unread byte accounting after EOF and
desynchronizes tp->copied_seq from kTLS record consumption in
tcp_read_done(), which stops at the first skb carrying TCPHDR_FIN while
tls_strp_check_queue_ok() accepts multi-skb records across FIN boundaries.

[1] https://sashiko.dev/#/bug/linux-ddef83cf-eb5a-48d6-b4ef-687a557a5260

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124130631.1886=
963-1-xuanqiang.luo@linux.dev?part=3D5
