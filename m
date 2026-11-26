Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795735795;
	b=1PXrn/LYbB5PhG62OsWrZ5V2FVevyNYJ12jbDWqMtTHBpde/fvEmSqdmj/87tY+rqeir
	 0RR6CmWKw1GNC6vouTWMHnBwfviV604GeN0Y8/pcn5FeWRVjBFkEfLIIj9Xv3kZ7BsTpv
	 Pm8s/Pp35K689Q6I9QxSTZwRgxqUL7kD2mxSo91w0V4SOHy/A1Ih79qAf7ZCkBMp8UCxS
	 l6A2tZAqMvMJF3p9ce1/xU+p0dYniMyrBgOgdQ2Z28N0itz2YAAyScGYADhHC7noYrYj9
	 RqIi2DvEO07Za1cAdeAgV4VKQ30P72hcOaiOYAymbk51e2rAoPlsKN1vCrbN8alfPqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795735795;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=elaJlETvQ/s1WTOiTlZ2vZXAmN2IQz5RkG9b1uLNoV0=;
	b=ylF3BBbo6bZ3ALokp4z3eRT7HDDIBgnUHUw6q9gSq3N/8er/PgD28ceNOty5ZHxTntTc
	 jUY1g6xJONSHDKZ1biBJaVVA7muuE+bwUHmeRxp4SXrOT5uy/SQb1KrvFBqBGXAbLjv/d
	 HfioxaTQ7dCf3KwBwuTxcVqJ5VvriVn/7cKy3LLKT2eiIwv0V/x2pxd2mdN7XXRjfPwpw
	 PMAMcKhDja2Le/R2X8++RvC4lJXRoe9tIFuOFuCQ6ZYHfp4Po1OJsLvsZKxft4vM9+1ow
	 xTyTKF43rhbX6lWJcwn5DeR6rf2nuYQNyU9JcouajzOCzO5Gr2LajStWwZWsEgBHJ7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XYpAYT1a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C59C606A31C
	for <mptcp@lists.linux.dev>; Thu, 26 Nov 2026 23:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XYpAYT1a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A0001F00929;
	Thu, 26 Nov 2026 23:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795735795;
	bh=elaJlETvQ/s1WTOiTlZ2vZXAmN2IQz5RkG9b1uLNoV0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XYpAYT1aCWuTqdCVsbWjo97ZCRwsfwkcAuL+nNEgyAWNWBdqL183ZSpGi2TURBJwM
	 bBLioHmPEn/EdccgvryONEA5rFgtxOEVa1at3IL5v0SHq8Q/o2PtzDWWsm5G/vp8V6
	 kBIiw/eQe9RA3HBZeZ47fPJHJ41uYBZr32w9Sn9pQyuWIZOjAvdz+4gM+aOAqNswAJ
	 0Fd7ZZEYaz53Y+5zkbooXDoN2dkEblAg+WKR2rAg/F23t8Nbwqske5OUgJ1xsoLMMk
	 bzhbGL2fptyzZoHypYZ5PS1IgqlNUJv+w5wIuGau5Uk8ID/mKy2FrsbVsoSNLrZNXl
	 sQ5ELeZxWgD8A==
Subject: Re: [PATCH mptcp-net v3 40/50] mptcp: send the DATA_ACK after moving
 the backlog
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Thu, 26 Nov 2026 23:29:54 +0000
Message-ID: <179573579467.3133.15201406203716765653@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-40-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-40-416c0920c73f@kernel.org>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The fix tries only one subflow, the one recorded from the last
  backlog skb with a non-NULL skb->sk, and gives up if that subflow…
- [Low] The new mptcp_subflow_schedule_ack()
  (net/mptcp/protocol.c:2421-2428) calls tcp_send_delayed_ack(ssk) on a…

--

mptcp: send the DATA_ACK after moving the backlog

Data received while the msk is owned by the user goes to the backlog.
The TCP ACKs sent for it carry the old DATA_ACK, so the peer can do a
spurious MPTCP-level retransmission. This patch schedules a delayed ACK
on the subflow of the last skb spooled from the backlog, if no ACK is
already pending there.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 0ff84d9684f13..2f89719e84545 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2417,10 +2417,21 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
>  	msk->rcvq_space.time = mstamp;
>  }
>  
> +/* The ACKs of the data put in the backlog carried the previous DATA_ACK */
> +static void mptcp_subflow_schedule_ack(struct sock *ssk)
> +{
> +	bool slow = lock_sock_fast(ssk);
> +
> +	if (tcp_can_send_ack(ssk) && !inet_csk_ack_scheduled(ssk))
> +		tcp_send_delayed_ack(ssk);

[Severity: Low]
Is the side effect on the subflow's TCP delayed-ACK heuristics intended?

At this point TCP has already ACKed the data, possibly right away, so
the subflow has no new TCP data to acknowledge. tcp_send_delayed_ack()
still sets ICSK_ACK_SCHED | ICSK_ACK_TIMER and arms icsk_delack_timer.

The patch targets the case where the peer has nothing more to send. If
nothing goes out on this subflow within ato, the timer fires and
tcp_delack_timer_handler() treats it as a missed delayed ACK:

net/ipv4/tcp_timer.c:tcp_delack_timer_handler() {
    ...
	if (inet_csk_ack_scheduled(sk)) {
		if (!inet_csk_in_pingpong_mode(sk)) {
			/* Delayed ACK missed: inflate ATO. */
			icsk->icsk_ack.ato = min3((u32)icsk->icsk_ack.ato << 1,
						  icsk->icsk_rto,
						  (u32)TCP_DELACK_MAX);
		} else {
			...
			inet_csk_exit_pingpong_mode(sk);
			icsk->icsk_ack.ato      = TCP_ATO_MIN;
		}
		...
		__NET_INC_STATS(sock_net(sk), LINUX_MIB_DELAYEDACKS);
	}
}

This can happen every time data lands in the msk backlog while the msk
is owned, for example when recvmsg() or the worker overlaps incoming
data. Each time, the subflow's ato can be inflated or pingpong mode can
be exited for a reason that has nothing to do with TCP.
TcpExtDelayedACKs is also incremented.

The commit message only says the DATA_ACK is sent "when the delayed ACK
timer expires". Could it mention these effects? Alternatively, could the
DATA_ACK be sent without going through the TCP delayed-ACK state?

> +	unlock_sock_fast(ssk, slow);
> +}
> +
>  static bool __mptcp_move_skbs(struct sock *sk, struct list_head *skbs, u32 *delta)
>  {
>  	struct sk_buff *skb = list_first_entry(skbs, struct sk_buff, list);
>  	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct sock *ssk = NULL;
>  	bool moved = false;
>  
>  	while (1) {
> @@ -2428,6 +2439,9 @@ static bool __mptcp_move_skbs(struct sock *sk, struct list_head *skbs, u32 *delt
>  		list_del(&skb->list);
>  		*delta += skb->truesize;
>  
> +		/* NULL if the subflow has been closed */
> +		if (skb->sk)
> +			ssk = skb->sk;
>  		moved |= __mptcp_move_skb(sk, skb);
>  		if (list_empty(skbs))
>  			break;
> @@ -2439,6 +2453,9 @@ static bool __mptcp_move_skbs(struct sock *sk, struct list_head *skbs, u32 *delt
>  	if (!moved)
>  		return false;
>  
> +	if (ssk && !__mptcp_check_fallback(msk))
> +		mptcp_subflow_schedule_ack(ssk);

[Severity: Medium]
Only one subflow is tried here. What happens when that subflow cannot
carry the updated DATA_ACK?

In two cases nothing gets scheduled even though msk->ack_seq has moved
forward.

First, a subflow may be closed with MPTCP_CF_PUSH while the msk is
owned, for example by a PM subflow destroy or a worker close. If data
arrived on that subflow before the close, mptcp_cleanup_ssk_backlog()
clears skb->sk on its backlog skbs:

net/mptcp/protocol.c:mptcp_cleanup_ssk_backlog() {
    ...
		atomic_sub(skb->truesize, &skb->sk->sk_rmem_alloc);
		skb->sk = NULL;
    ...
}

If all spooled skbs came from that subflow, ssk stays NULL in
__mptcp_move_skbs() and mptcp_subflow_schedule_ack() is never called.

Second, the last skb's subflow may move to TCP_CLOSE after its data was
queued and before spooling, for example after an RST and before
__mptcp_close_ssk() runs. tcp_can_send_ack(ssk) then returns false
inside mptcp_subflow_schedule_ack(), and nothing is scheduled.

In both cases no other entry in msk->conn_list is tried, even if another
subflow is ESTABLISHED and could carry the connection-level DATA_ACK.

The later mptcp_cleanup_rbuf(msk, 0) from release_cb doesn't seem to
cover this. With copied == 0 it only acts on subflows that already have
an ACK scheduled and more than rcv_mss of unacked data. So the peer
would keep the stale DATA_ACK and could still do the spurious
retransmission this patch is meant to avoid.

The v2 note covers the second case, but the commit message itself
mentions neither case. Would it make sense to fall back to another
subflow in conn_list that can send ACKs?

> +
>  	/* Only the worker can close an orphan, as it must then destroy it */
>  	if (!sock_flag(sk, SOCK_DEAD))
>  		mptcp_check_data_fin(sk);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261124-mptcp-cmason-fixes-v3-0-416c0920c73f%40kernel.org
