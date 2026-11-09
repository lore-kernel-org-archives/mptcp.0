Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794186922;
	b=vDvpbgJYGjN5E23mmYu0ZK9/yZZZ2zCElCeJkFFo1SsXbBQ7Y0OYhegQ5kq5kOFSL/ZM
	 wk6urJhgoOFTU3MDoiHi1u0RpD5CVBFBa32nzvLVjIcef/fFAqtM3GzpTFFUTi3KQYoC3
	 /T2POnbNlfkI8Ciw3Bq0YfZxvMjylDOUDWip60hdiWHb0+sUSqvyJwjy2M/yVntJnv4fg
	 J7VwIDQ34LSfbw+jIeTmsxzocY3FoKSKLFu3OItzAubdQbIO2dVCK6/hMoGhJWDnXMChk
	 ijS4+mVEpfHZYOnJ8n72cfYPXPen4ano5FUH/UFpcuVBztPtXejKRKOFMjmNaJEgH+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794186922;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ZuIUQwT1MCKSZ873RR+VJtLYIPE6upEGvbontEfsrBA=;
	b=LRpBeyqhUKOLgokv4SOWmmuG5tUbleb8SfAW+FZUNzxtM6DeO9jYpjIHtanGv3mScBYf
	 wcpbe94LhrJXFeOTpm3WR91EVufrqgzq9WJYykaefddcNQ6+UUOWduRZ1scwLHTU2C4SE
	 1zIzrc6bUvDtbAEKT4Qa9f0GMBEi5Z3BmvB/Ukflm8xYytn8YZUCI1oEDrngHzoCWbTey
	 TkR9jHecmhVUDnK+ZvoXzIWLB76kUKZ4VK+rYDZrN+4mXcZmcYraQywr9B4RvYNOEMBsw
	 WC6bfo6dZ+aSgpcTrUaGhEKXMZlFvoH3U9eDskh54hyin9PfctHHkazZTwxdH/lA3fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hekLDFOW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC31606A322
	for <mptcp@lists.linux.dev>; Mon,  9 Nov 2026 01:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hekLDFOW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9AE1F0089F;
	Mon,  9 Nov 2026 01:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794186922;
	bh=ZuIUQwT1MCKSZ873RR+VJtLYIPE6upEGvbontEfsrBA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hekLDFOW+wWeSVWA/TIeb4tiUXx08NL2BYjyH9SI0ta6jO4U3sqCNphRhHE3/6+0H
	 nZLH75Da1DRrprgzAarmzHwbglwPBO6rJaqPazZVardh0zPI4ze78PpIl3M6m7dW/H
	 Q50gS+w1xaKRjzkQOv2Rde/nGHvdxtZe84SeIDavUCyqX83WhmFoMPgo6iAaqA9d5e
	 rKItdhDH0WpVMo4A3sPPKjCc8Mceg78Ez80Jl9MC98ypUGN81Q9500annB3+llg/wS
	 MDXyUHi/fjmfKVvpcjTcqaeVoLh03NOZvVMjm/0A/3tjmVPg7xC/0A/qa0HyKnhjy5
	 gwXF3xFHP0ztA==
Subject: Re: [PATCH mptcp-net v7 1/7] mptcp: fix TFO SIOCINQ overflow in
 mptcp_inq_hint
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, yangang@kylinos.cn, kuba@kernel.org
Date: Mon, 09 Nov 2026 01:15:21 +0000
Message-ID: <179418692133.488855.8515356263563798707@kernel.org>
In-Reply-To: <2f671ecca0dbe9268e6ac8b36e24914be91d5749.1794053683.git.tanggeliang@kylinos.cn>
References: <2f671ecca0dbe9268e6ac8b36e24914be91d5749.1794053683.git.tanggeliang@kylinos.cn>
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

- [Medium] In net/mptcp/protocol.c, mptcp_inq_hint() now adds 1 whenever
  RCV_SHUTDOWN is set (`if (sk->sk_shutdown & RCV_SHUTDOWN)…
- [Low] The commit author is `Geliang Tang <geliang@kernel.org>`, but the
  only Signed-off-by is `Geliang Tang <tanggeliang@kylinos.cn>`.

--

mptcp: fix TFO SIOCINQ overflow in mptcp_inq_hint

This commit changes mptcp_inq_hint() to compute the available bytes with
mptcp_data_avail() instead of ack_seq minus the head skb's map_seq. The
goal is to stop reporting INT_MAX on passive TFO connections. It also adds
1 to the result when RCV_SHUTDOWN is set, to account for the DATA_FIN byte.

> Fixes: f03afb3aeb9d ("mptcp: drop __mptcp_fastopen_gen_msk_ackseq()")
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

[Severity: Low]
This isn't a bug, but the Author: line is Geliang Tang <geliang@kernel.org>
while the only Signed-off-by is Geliang Tang <tanggeliang@kylinos.cn>.
checkpatch reports this as FROM_SIGN_OFF_MISMATCH.

Could the author and Signed-off-by identities be made to match?

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 02a4f479d9d8c..421df3af1ef93 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2402,22 +2402,18 @@ static bool mptcp_move_skbs(struct sock *sk)
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
> +	if (sk->sk_shutdown & RCV_SHUTDOWN)
> +		hint_val++;

[Severity: Medium]
Can RCV_SHUTDOWN be relied on here to mean that a DATA_FIN was received?

The commit message says:

  When RCV_SHUTDOWN is set (DATA_FIN received), add 1 to include the FIN
  byte, matching the previous ack_seq - map_seq behavior.

As far as I can tell, mptcp_check_data_fin() is the only path that sets
RCV_SHUTDOWN and also bumps ack_seq for the FIN byte:

net/mptcp/protocol.c:mptcp_check_data_fin() {
    ...
	if (mptcp_pending_data_fin(sk, &rcv_data_fin_seq)) {
		WRITE_ONCE(msk->ack_seq, msk->ack_seq + 1);
		...
		WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | RCV_SHUTDOWN);
    ...
}

At least two other paths seem to set RCV_SHUTDOWN without a DATA_FIN,
while unread data is still sitting in sk_receive_queue.

The first is a local shutdown(fd, SHUT_RD). mptcp_stream_ops.shutdown is
inet_shutdown(), which does sk->sk_shutdown |= how. mptcp_shutdown() only
acts on SEND_SHUTDOWN.

The second is a peer MP_FASTCLOSE, through
mptcp_worker()->mptcp_check_fastclose():

net/mptcp/protocol.c:mptcp_check_fastclose() {
    ...
	mptcp_set_state(sk, TCP_CLOSE);
	WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK);
    ...
}

This path does not purge the msk receive queue.

Suppose N bytes are unread in either case. The old code returned
ack_seq - map_seq = N, because ack_seq was never bumped for a FIN. Won't
the new code return bytes_received - bytes_consumed + 1 = N + 1?

That value reaches userspace through mptcp_ioctl() for SIOCINQ/FIONREAD
and through the TCP_CM_INQ cmsg in mptcp_recvmsg(). It is also subtracted
from rcvq_space.copied in mptcp_rcv_space_adjust().

For comparison, plain TCP bases its FIN adjustment on SOCK_DONE, not on
RCV_SHUTDOWN:

include/net/tcp.h:tcp_inq() {
    ...
		/* Subtract 1, if FIN was received */
		if (answ && sock_flag(sk, SOCK_DONE))
			answ--;
    ...
}

So TCP still reports N after SHUT_RD.

Would it be better to base the +1 on the DATA_FIN actually having been
received, rather than on RCV_SHUTDOWN?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1794053683.git.tanggeliang%40kylinos.cn
