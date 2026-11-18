Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794963944;
	b=HOF52fAenomVe4+DGZhf2LZRs0pCxL+icDywcRBl89cAh5WqtofPpExUbgdXEKSuLwOt
	 reHlaajGzwnZp0ljoI8kygcTCW0sEWS+Wvs+qTbFkhx1L4/JNjRTuopBEWJoeSbP2MeG4
	 PQ1S8/cHa9KqM65lcaI5VaOjXOMcmbO3BFFubj6IxDKOZMPwm5KH8Bs2SPMCkqsRNIiJm
	 wqv+CV8k4YB/gaxz6UuQhNioLjRogQ8oaH2u9S9lB3ng4CM4lqZ3d7KzUrKjoB7Uxj65g
	 FgqvCB44CEwxsjPuUwop8sXnFcDsg+l07bj8mBj2dZEL6JZnBQ3j+JfM0p1pFcdX3fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794963944;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=P4Kn+i6D1FPGGtlpv5uIeQdqAWgdY51pjRmHjqGXlS4=;
	b=fvivzBy1FH95ijnxbBLNiBt2t5Q8vv0c76rWUZ90/W/GESrILFU6qtX+WVYsMosaUThq
	 H1u3wmcOwSgE2zCEHC64m3p48J4dZZNv1foLzKtYFhVyIPCpAihKNbug+vNWFfdmZkOXV
	 mwfqxBNMYUXdQ9NgjkRldCVZ8hLTPhfujRIG4bEDzMyPUfsszDwbIMvjMtEPymcwoHMvU
	 57KBoCrmp+5aZ1ttwMmttna5YbyxD9mqMya1QgimgXGrf3WgFhMXfpRf7v2DQEMBxC5lY
	 h14xV+KNl3nx93mDcNU11f+uk46YHGLTWhwW1vzwycT+o1ENO6F2aHveNpMJGOZPivA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mKH+DLp4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6610606A31C
	for <mptcp@lists.linux.dev>; Wed, 18 Nov 2026 01:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mKH+DLp4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6621F000C4;
	Wed, 18 Nov 2026 01:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794963944;
	bh=P4Kn+i6D1FPGGtlpv5uIeQdqAWgdY51pjRmHjqGXlS4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mKH+DLp45+kp/2jWY9aE9RJqAedTB7ruNKhQta9zWrg7pFzHDB4s+trCMVlF9XOHV
	 gAoYAjxuHx3vReeiid5Mhg9IbJDyfvGhaIYxyVIuYzaPGO7PSLfNt7PPX/7rkfCaPj
	 g84A+Al0bIxMioMjI6ZhMPKjV1ILzpOr571obgVUhXkuljOACw51gJgkyRLUki/YCi
	 kg+9XQJ33l4cK9eg3ZNVdLfsgTI5qQjjTj9koFqOa2oOkNRp1COwTcCdT69MBJLrG2
	 5Q0Q2zMA4DvYA6SlNo6Qw2Z4yQH/mmnM8j8gRheE7VuhYYFoJFbG6aUjkQllQkmdJF
	 e51+WQD1bs/3Q==
Subject: Re: [PATCH mptcp-net v8 1/7] mptcp: fix TFO SIOCINQ overflow in
 mptcp_inq_hint
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Wed, 18 Nov 2026 01:05:43 +0000
Message-ID: <179496394384.3133.8877510786925164911@kernel.org>
In-Reply-To: <2aa50a4b4f9ed4833a91e791918e02ec206876e0.1794826541.git.geliang@kernel.org>
References: <2aa50a4b4f9ed4833a91e791918e02ec206876e0.1794826541.git.geliang@kernel.org>
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

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This is a regression the patch introduces in
  net/mptcp/protocol.c:mptcp_inq_hint().
- [Medium] The commit message says the new code "ensures SIOCINQ reports
  N+1 when N bytes are unread with DATA_FIN pending, matching TCP…

--

mptcp: fix TFO SIOCINQ overflow in mptcp_inq_hint

This commit changes mptcp_inq_hint() to take the readable byte count from
mptcp_data_avail() instead of ack_seq minus the map_seq of the head skb.
The old calculation overflowed to INT_MAX on passive TFO connections. The
commit also adds one byte to the hint when RCV_SHUTDOWN is set or the
socket is in TCP_CLOSE.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 50de5cedfd0fb..574eba9989a8d 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2404,22 +2404,15 @@ static bool mptcp_move_skbs(struct sock *sk)
>  static unsigned int mptcp_inq_hint(const struct sock *sk)
>  {
>  	const struct mptcp_sock *msk = mptcp_sk(sk);
> -	const struct sk_buff *skb;
> +	u64 hint_val = mptcp_data_avail(msk);
>  
> -	skb = skb_peek(&sk->sk_receive_queue);
> -	if (skb) {
> -		u64 hint_val = READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
> -
> -		if (hint_val >= INT_MAX)
> -			return INT_MAX;
> -
> -		return (unsigned int)hint_val;
> -	}
> +	if (hint_val >= INT_MAX)
> +		return INT_MAX;
>  
>  	if (sk->sk_state == TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN))
> -		return 1;
> +		hint_val += 1;

[Severity: Medium]
Does RCV_SHUTDOWN here always mean that a DATA_FIN is pending? The commit
message treats the two as the same thing. However, the +1 is now added on
top of a non-zero mptcp_data_avail() whenever RCV_SHUTDOWN or TCP_CLOSE is
set, even if no DATA_FIN ever used up a sequence number.

Before this patch, with a non-empty receive queue the hint was
ack_seq - head->map_seq. That is exactly the N unread bytes, because
__mptcp_recvmsg_mskq() advances map_seq on partial reads:

    MPTCP_SKB_CB(skb)->map_seq += count;

The value only became N+1 after mptcp_check_data_fin() accounted for a
real DATA_FIN:

    WRITE_ONCE(msk->ack_seq, msk->ack_seq + 1);

The old "return 1" only ran when the queue was empty.

There seem to be two cases where the new code reports N+1 and the old code
reported N.

The first is a local shutdown(fd, SHUT_RD). inet_shutdown() sets
RCV_SHUTDOWN, but mptcp_shutdown() only handles SEND_SHUTDOWN, so no
DATA_FIN exists.

The second is an MP_FASTCLOSE from the peer, handled in
mptcp_check_fastclose():

    mptcp_set_state(sk, TCP_CLOSE);
    WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK);

This path does not touch ack_seq and does not purge sk_receive_queue.

The inflated value then reaches userspace through mptcp_ioctl(SIOCINQ) and
through the TCP_CM_INQ cmsg in mptcp_recvmsg(). It also feeds the
"copied -= mptcp_inq_hint(sk)" step in mptcp_rcv_space_adjust().

For comparison, tcp_inq() and tcp_inq_hint() only count a FIN that was
actually received (SOCK_DONE is set by tcp_fin()). tcp_inq_hint() also
only forces 1 when inq is 0.

Could the FIN byte be added only when a DATA_FIN was actually accounted
for, or only when mptcp_data_avail() returns 0? As far as I can tell,
mptcp_inq_hint() stays unchanged through the end of the series.

[Severity: Medium]
The commit message says:

  This ensures SIOCINQ reports N+1 when N bytes are unread with DATA_FIN
  pending, matching TCP behavior where FIN consumes a sequence number.

Is that right for SIOCINQ? On TCP, SIOCINQ goes through
tcp_ioctl()->tcp_inq(), which subtracts the FIN byte:

		answ = tp->rcv_nxt - tp->copied_seq;

		/* Subtract 1, if FIN was received */
		if (answ && sock_flag(sk, SOCK_DONE))
			answ--;

So TCP reports N while a FIN is pending and 0 at EOF. Only TCP_CM_INQ, via
tcp_inq_hint(), counts the FIN.

mptcp_ioctl(SIOCINQ) returns mptcp_inq_hint(), the same helper that
TCP_CM_INQ uses. As a result, FIONREAD on an MPTCP socket returns N+1 after
a DATA_FIN and 1 after EOF, where TCP returns N and 0.

The old ack_seq based calculation already produced N+1, and 1 at EOF.
This patch, though, rewrites the helper and makes the +1 explicit based on
the TCP parity claim above.

A later patch in the series ("mptcp: implement peek_len for proto_ops")
adds mptcp_inq(), which returns mptcp_data_avail() without the FIN.
However, SIOCINQ still calls mptcp_inq_hint() at the end of the series.

Should mptcp_ioctl() use a helper that leaves out the FIN, as tcp_inq()
does for TCP?

The FIONREAD check in process_one_client() in
tools/testing/selftests/net/mptcp/mptcp_inq.c only runs before the peer
sends its DATA_FIN, so this case does not seem to be covered by the
selftest.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1794826541.git.geliang%40kernel.org
