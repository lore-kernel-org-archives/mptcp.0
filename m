Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795533996;
	b=n6rG9sZp1hY1zyTzM1DS269CXwTlk/TV+6BIHtaQagAZ8n4zHBFU6dMpAzAKvNS828nL
	 h2uHD/FqbKCDpt5GTZ7wMS5rELyKo6PJ2HbznVdYPs9Lhj8eO6JtZkduA4f8zzGVK64oT
	 YvBjb4WReTjBMbX2DCKM6A0zZUeSolTNghEtUImKyB7YqgprVjjcNEdAZ/cQL0Z2/thX0
	 7Hhdaux0nvn2GmoXjOeBsCG+CbySoCnmLyDQj5+rNJ1NldkBRqDajHzeKrscBvLmX7wPN
	 wWOXE5xMuXujSTGCbm8lKfa9fmVJ0AO8+9GKwbOMa2mg/t/IwZg0XyVrphMbUj51S4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795533996;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=dc09RbyhU63uAJv5RptQF2PtVuJdEhFWF3v8IlTJen8=;
	b=BKmv+lZBAEWbzXKUVe+x0UQzoXj787PA/qUZSQHp2tSJGrMSJwk8yjp97x1CMv8UvKtA
	 RWwd7qPLg0b8j+WSH6rMiMtXJZXYVb/KUo1hu7KTr7bs+OT1Ihg9DMI9x3C/IsdEqsaLd
	 CPY43cMMm5LG7Vy8Ac0g3Bno6EdfL5YiY7h4OzNr0TpDLi1e6P2rrJHMf6Txs/xUgTYlG
	 moil/wRVfu8lJg0tYp1ZPyw4ppiIDtq1QW/AOAXldOS95IAcB3SrAi9zfT+NWdr1eH6i+
	 a4SayeRdUI0Wxvl65pVBTfU17aEiIXGDX7zvdSMJjd1tD1I4sfk3f0Yh1MrzwD5Eg9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B4U7f4q1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B63606A32A
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 15:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B4U7f4q1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A691F000C0;
	Tue, 24 Nov 2026 15:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795533995;
	bh=dc09RbyhU63uAJv5RptQF2PtVuJdEhFWF3v8IlTJen8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=B4U7f4q1turcBCpbx2AJnffwB6pdp5xhs7vu92XHtgHBBhEQbzJgl1groNccoTKng
	 EAsgS+730tNXtRG/r4khocI8kBuNVS7suaYntVfqO3IpklbCz+/rWkFs0iMU1dbbdw
	 98FUZ7A1g81P2KfZPDGyJNJZAzUtnTGPwDECLMQbkOxyU+AGbASxvVAartblfNSUtU
	 zb/d9VSXVSU8J1P1b0faqCXezyX75V40CQy7AtO/KyVMbYwOIOl9nNEvpG0uVsSJbO
	 9fOIxPsrXZSH1sBq0gWgVcE6MpoeexqAmwheCoAj2wJkGUsP0CpqA9adXsDvAcLURL
	 j85SPqRb7qk7g==
Subject: Re: [PATCH mptcp-net v3 3/4] mptcp: fix TFO SIOCINQ overflow in
 mptcp_inq_hint
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Tue, 24 Nov 2026 15:26:35 +0000
Message-ID: <179553399520.3133.15503954558196190617@kernel.org>
In-Reply-To: <d0fb9716397cd64ea82aa674e8314a7225a26ceb.1795396910.git.tanggeliang@kylinos.cn>
References: <d0fb9716397cd64ea82aa674e8314a7225a26ceb.1795396910.git.tanggeliang@kylinos.cn>
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

- [Low] mptcp_inq_hint() (net/mptcp/protocol.c:2384-2398) now adds a
  phantom FIN byte when no FIN or DATA_FIN was ever received.

--

mptcp: fix TFO SIOCINQ overflow in mptcp_inq_hint

This patch changes mptcp_inq_hint() to compute the available bytes as
bytes_received - bytes_consumed instead of ack_seq minus the head skb's
map_seq. That avoids a bogus INT_MAX hint on passive TFO connections. It
also adds a mptcp_data_fin() helper, adds a FIN byte under certain
conditions, and resets rcv_data_fin_seq in mptcp_disconnect().

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index e827b4fe8354a..8292e0db0b00a 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -2378,22 +2384,17 @@ static bool mptcp_move_skbs(struct sock *sk)
>  static unsigned int mptcp_inq_hint(const struct sock *sk)
>  {
>  	const struct mptcp_sock *msk = mptcp_sk(sk);
> -	const struct sk_buff *skb;
> +	u64 hint_val = mptcp_data_avail(msk);
>  
> -	skb = skb_peek(&sk->sk_receive_queue);
> -	if (skb) {
> -		u64 hint_val = READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
> +	if (hint_val >= INT_MAX)
> +		return INT_MAX;
>  
> -		if (hint_val >= INT_MAX)
> -			return INT_MAX;
> +	if (((sk->sk_state == TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN)) &&
> +	     !READ_ONCE(msk->rcv_fastclose)) ||
> +	    (READ_ONCE(msk->rcv_data_fin) && mptcp_data_fin(msk, NULL)))
> +		hint_val += 1;

[Severity: Low]
Can this add a FIN byte when no FIN or DATA_FIN was ever received?

The first half of the condition looks only at local socket state. It now
adds 1 on top of unread data, where the old code only returned 1 when
the queue was empty.

One way to hit this is a local shutdown(fd, SHUT_RD) with data still
queued. inet_shutdown() sets RCV_SHUTDOWN:

net/ipv4/af_inet.c:inet_shutdown() {
    ...
	WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | how);
    ...
}

and mptcp_shutdown() only handles SEND_SHUTDOWN:

static void mptcp_shutdown(struct sock *sk, int how)
{
	...
	if ((how & SEND_SHUTDOWN) && mptcp_close_state(sk))
		__mptcp_wr_shutdown(sk);
}

bytes_received, bytes_consumed and ack_seq are left as they were, so with
D unread bytes the hint becomes D + 1.

Another way is a TCP RST on a fallen-back msk. In that case
__mptcp_subflow_error_report() moves the msk to TCP_CLOSE without setting
rcv_fastclose or purging the receive queue:

	if (ssk_state == TCP_CLOSE && !sock_flag(sk, SOCK_DEAD))
		mptcp_set_state(sk, ssk_state);
	WRITE_ONCE(sk->sk_err, -err);

Before this patch, a non-empty queue gave ack_seq - map_seq. ack_seq only
includes the FIN byte after mptcp_check_data_fin() advances it for a real
DATA_FIN, so neither case above reported the extra byte.

For comparison, tcp_inq_hint() only forces the extra byte when the queue
is empty and a FIN was actually received:

	if (inq == 0 && sock_flag(sk, SOCK_DONE))
		inq = 1;

A fallen-back MPTCP socket would therefore report a different TCP_CM_INQ
value than plain TCP in the same situation.

The later commit "mptcp: add mptcp_inq() for SIOCINQ" moves
SIOCINQ/FIONREAD to a new mptcp_inq() that leaves out the FIN byte, so
the SIOCINQ side goes away there. The TCP_CM_INQ cmsg in mptcp_recvmsg()
still calls mptcp_inq_hint(), and so does the autotuning measurement in
mptcp_rcv_space_adjust():

	copied -= mptcp_inq_hint(sk);

Both would still see the extra byte.

The changelog describes the +1 rule, but it doesn't say that the rule
now applies with data queued and no FIN received. Should the
TCP_CLOSE/RCV_SHUTDOWN branch only apply when mptcp_data_avail() is
zero, to match the old behaviour and tcp_inq_hint()?

>  
> -		return (unsigned int)hint_val;
> -	}
> -
> -	if (sk->sk_state == TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN))
> -		return 1;
> -
> -	return 0;
> +	return (unsigned int)hint_val;
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1795396910.git.tanggeliang%40kylinos.cn
