Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793134544;
	b=VeTR8Kx5xCUN5bPLRv4vMh2cc5/A6pD/jXUV5/hNsy+6plZbmLHCXt6R5JFHDBS9KmaS
	 P34r+djzlkq2UPT1rByFgLgNJUS9bJExiHIvDPDuQUsgYgYHrGee6tKPsUqxvqiHB+Idw
	 RQoX/2q5VdIycrZo/AkKCtcEc+RK2HRtb6MJQ5Lld1+Gvxsf+NDPt3tta0GZovvdZG8hE
	 0FkI0+UUOykI8uu2OWTgCn6WnsvTlRRgwaHLVm0hUVouR2h8/NEXKUd1RH7B1MT2ypmrC
	 2r+5HAWAw/7P2eqQu2QtvRDnQNgsy3nerfQSfDaj5kWpewLj8S1Iu6KDB2SMyeaJJBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793134544;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=R2+8eki5uoeOjnNBz5RIi1B9NZshMITSkypWthqGJl0=;
	b=bfevjzO3Q7HXIt6g9/sLVddLRYT4TgPsRdNkA25Oq8XvY2B184InWsX5YkWpHKTAixac
	 cqImArGFNyj7q301akubU51Pbjy8EX1enSTF1UfWkFI8oeMQCHMDgu9zNcFiCApuyb7VK
	 CEm7TV+ew5DwcRtPVYmIn7x/i66RsNZN+69Q0Q6FAJWEXO4U431fQ5Fxu6bbUO6n7Y9pD
	 4WIBCCwe/DgHIW7P3r4SoEfl72oSqo6ejEacVI1bOPjICui0p5fAoRvhxj2Ucm7av+IIb
	 TnLUAo4x9pGkFy7NakP+eDfKBXhU0MVovM5XkTkPWJ7R1P1Wz8ApL8nu+URz+C59IZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lUTAyfyB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEAC606A31A
	for <mptcp@lists.linux.dev>; Tue, 27 Oct 2026 20:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lUTAyfyB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A8DA1F01825;
	Tue, 27 Oct 2026 20:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793134543;
	bh=R2+8eki5uoeOjnNBz5RIi1B9NZshMITSkypWthqGJl0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lUTAyfyBsDeEFQV8tjnjr7FtU1UTl1V/+2bX1Mp99HUtK1uRoD1tauH0fppvY+nZt
	 4f6vucqrg9e6Tcwh8+h6L2zvoFFp5N4QUPDmwD0eOsNk5CrbQwR1dEetOvIFQM0v94
	 2rhUF2Q44LNTnINklU19AzuwsP9HBE+DSYQpLe3+A4Weo5SOcZweBWHZgxjsOusfBP
	 zHNwS0kN0AFnbzm51c8mAHffWQnT7BUKgFEuhMNtNL4ci8ptBnu37kys3g5HedFyv8
	 bqt7lHL0RxQHGFzk99t60azTDG2Ldr88pEeq3CQEMYazZzJ1DSXgk7za/krWSzMFdh
	 9GFYzjWLS6ZAg==
Subject: Re: [PATCH mptcp-next 4/6] mptcp: add sendmsg_locked to proto_ops
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, kuba@kernel.org
Date: Tue, 27 Oct 2026 20:55:42 +0000
Message-ID: <179313454275.3132.8860698770809524538@kernel.org>
In-Reply-To: =?utf-8?q?=3C949a4262ea959da66bcb9fbac72b23f0eecf2879=2E1792999?=
 =?utf-8?q?988=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
References: =?utf-8?q?=3C949a4262ea959da66bcb9fbac72b23f0eecf2879=2E17929999?=
 =?utf-8?q?88=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
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
  `mptcp_stream_ops` (net/mptcp/protocol.c:4865) and…
- [Low] `mptcp_sendmsg_locked()` behaves differently from the other
  `proto_ops->sendmsg_locked` implementer, `tcp_sendmsg_locked()`.
- [Low] `mptcp_sendmsg_locked()` is now exposed as a generic
  `proto_ops->sendmsg_locked` callback with no `msk_owned_by_me()`…

--

mptcp: add sendmsg_locked to proto_ops

This patch splits mptcp_sendmsg() into two parts. The new
mptcp_sendmsg_locked() expects the caller to already hold the msk socket
lock, and a small mptcp_sendmsg() wrapper takes the lock and calls it. The
locked variant is then exposed as .sendmsg_locked in both mptcp_stream_ops
and mptcp_v6_stream_ops.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 71a0a28b0d3c9..8aad55e0cce79 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2039,7 +2039,7 @@ static void mptcp_rps_record_subflows(const struct mptcp_sock *msk)
>  	}
>  }
>  
> -static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
> +static int mptcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t len)
>  {
>  	struct mptcp_sock *msk = mptcp_sk(sk);

[Severity: Low]
This is now a generic proto_ops callback. Would it make sense to add a
msk_owned_by_me() assertion here, plus a comment saying what callers must
guarantee? Other helpers in protocol.c that depend on the msk lock already
assert ownership.

The function can sleep. sk_stream_wait_connect() and
sk_stream_wait_memory() drop and re-take the msk lock through
sk_wait_event(). __mptcp_push_pending() also takes the subflow lock for
each scheduled subflow, even when MSG_DONTWAIT is set:

net/mptcp/protocol.c:__mptcp_push_pending() {
    ...
				if (ssk != prev_ssk) {
					...
					lock_sock(ssk);
				}
    ...
}

So, unlike tcp_sendmsg_locked(), this can't be called from BH context. A
caller that already holds a subflow lock would also deadlock in
lock_sock(ssk).

For comparison, the existing skb_send_sock_locked() user espintcp reaches
the TCP implementation under bh_lock_sock:

esp_output_tcp_finish()
  espintcp_push_skb()
    espintcp_push_msgs()
      skb_send_sock_locked()

Today no in-tree caller can reach this function for an MPTCP socket, and
tcp_sendmsg_locked() has no ownership assertion either. This becomes
relevant once a consumer such as kTLS over MPTCP lands.

> @@ -2051,8 +2051,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>  	msg->msg_flags &= MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
>  			  MSG_FASTOPEN | MSG_EOR;

[Severity: Low]
This isn't a bug, but this masking makes mptcp_sendmsg_locked() behave
differently from tcp_sendmsg_locked(), the other implementer of the same
ops slot.

The masking changes the caller's msg->msg_flags in place and clears
MSG_SPLICE_PAGES. __skb_send_sock() always sets MSG_SPLICE_PAGES for page
frags, so on MPTCP those frags would be copied with do_copy_data_nocache()
rather than spliced. tcp_sendmsg_locked() reads the flags without changing
them and honours the flag:

net/ipv4/tcp.c:tcp_sendmsg_locked() {
    ...
	} else if (unlikely(msg->msg_flags & MSG_SPLICE_PAGES) && size) {
		if (sk->sk_route_caps & NETIF_F_SG)
			zc = MSG_SPLICE_PAGES;
    ...
}

__skb_send_sock() also assumes that only TCP sockets implement
sendmsg_locked:

	int more_hint = sk_is_tcp(sk) ? MSG_MORE : 0;

sk_is_tcp() is false for an MPTCP socket, so MPTCP would never receive the
MSG_MORE hint.

The copied data is still correct. mptcp_sendmsg() already did this masking
before this patch, and today this path can't be reached for MPTCP sockets.

Is this difference intended now that the function is exported as a generic
sendmsg_locked implementation?

[ ... ]

> @@ -4854,6 +4862,7 @@ static const struct proto_ops mptcp_stream_ops = {
>  	.read_sock	   = mptcp_read_sock,
>  	.splice_read	   = mptcp_splice_read,
>  	.peek_len	   = mptcp_peek_len,
> +	.sendmsg_locked	   = mptcp_sendmsg_locked,
>  };

[Severity: Low]
Is there anything that calls this callback for an MPTCP socket? The commit
message says:

    However, certain upper layers need to call the sendmsg method while the
    socket lock is already held.

but it doesn't say which layers.

The only generic dispatcher of ->sendmsg_locked is the static
sendmsg_locked() in net/core/skbuff.c. It is reached through
skb_send_sock_locked() and skb_send_sock_locked_with_flags(), which have
two users.

The first is espintcp, which is a TCP ULP. mptcp_setsockopt_sol_tcp()
rejects TCP_ULP:

	case TCP_ULP:
		return -EOPNOTSUPP;

The second is ovpn, which only accepts sockets whose sk_protocol is
IPPROTO_TCP or IPPROTO_UDP. MPTCP sockets use IPPROTO_MPTCP.

The other senders that run with the lock held (kTLS tls_push_sg(),
tcp_bpf, espintcp and siw) call tcp_sendmsg_locked() directly and never
look at sock->ops. So even a kTLS consumer wouldn't pick up this op
without further changes. I also couldn't find a consumer added later in
the series.

Unlike the sibling commit "mptcp: implement peek_len for proto_ops", this
commit message doesn't describe the change as preparatory. The same applies
to the identical mptcp_v6_stream_ops entry.

Could the commit message name the intended user, or could this patch go in
together with the change that uses it?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1792999988.git.tanggeliang%40kylinos.cn
