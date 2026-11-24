Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795482329;
	b=a93mnaEr3NrioYivzGIlQlQDpSv+1kHw2CWaK6/K6cpAO5JgsPSkaYZV+/DiQ79QpkSJ
	 yQLhuhRQ64Rr9J7AfOGNwTlWbLjLyV8HALQpkRq6RrjGIfPb63rPXoBEj2lx87gBt4BBB
	 iSNTzbI7d2FecxTUBdcDz6BuCwMTtZV4Ii4gKsM2TDm//56LLnLR4yj5tVwlIMhDVDLGX
	 vKgZUcN652xwHeu0Zv3rXM40hxt7hket+PwJxXqxFvnmdj4yWMXzy7js4rDQJyyfZsgIU
	 Yz0e9yb9ziywfhkikCova1RIBphisQh2G8TBZBptEz5qDvMUzzj/N9QArckWdXDTq9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795482329;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=8UwysR+VwpEbQicXVbm9MlL7BO3AC6BqGqw3cKmCrXk=;
	b=fT4yLrawMxs136JilBORibe3tS7VriFmI21ZuZtk+1dwA0ceotG3V0gGdhUYtf/RR++O
	 obL5IB5nBQVGPCVb1wU5B/YBtK6yEffg5QpzcfTaB5W/UL62THedbgdDGAnyeZs4/r3O9
	 FjG2Guc+d9r/HsxanT2vMezbWWIAs7COP0DKhjgE+0cGjuh5q+sBkLdZc3MSVeAGtLd80
	 ZUE+tmc+gxHU/ZbiSNmcLnfrylbvXxUJyEn/ghXq3gO+eUtN09/2s6OrhUe/TW+hGxquI
	 LCCob8ykLtnv8Efd51bgU0eOaWVutdl8y2XwZoBlMQ0nj3THhKbRNYv9B12TWtbQ4vA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B3vzQRPW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89708606A31E
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 01:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B3vzQRPW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 056781F000E1;
	Tue, 24 Nov 2026 01:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795482329;
	bh=8UwysR+VwpEbQicXVbm9MlL7BO3AC6BqGqw3cKmCrXk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=B3vzQRPWMlyKfjSVmUX8OVJk8HbjtVYuOuVg3XmyFoiGtBA4Bh+POGxBJS532amye
	 5bKzQIvO16g8dRRMJm4AacUkPv0plmNAjyNhjiUBAyF+tOerCL3fpd+7NVXMIoc4Uq
	 uFpvcWTHZUoZGSJLTA9YvG+l3Ygxm//hJU3MfCvLLRMYzvg0TOzZlI3veMrckbya08
	 dMsuTobOiAscShyWsbCs/qm3M6CxerOfhmvt2JB5o5edAsQ4POd32B/8juKyqeydgm
	 ce0isLFfKfHTva6Iaqum/6Gxwo74hNIgoQe0AOiRyiknAUxEzMzCUuFfQNkmHUDSRb
	 hs5X60/04G/9w==
Subject: Re: [PATCH mptcp-net v2 3/4] mptcp: fix TFO SIOCINQ overflow in
 mptcp_inq_hint
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Tue, 24 Nov 2026 01:05:28 +0000
Message-ID: <179548232859.3133.11411610594175565373@kernel.org>
In-Reply-To: <692168c4f75bdb59bc8a9ec9ed116674747c3898.1795348666.git.tanggeliang@kylinos.cn>
References: <692168c4f75bdb59bc8a9ec9ed116674747c3898.1795348666.git.tanggeliang@kylinos.cn>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The FIN-byte guard in mptcp_inq_hint() (net/mptcp/protocol.c)
  is wrong.

--

mptcp: fix TFO SIOCINQ overflow in mptcp_inq_hint

This patch changes mptcp_inq_hint() to compute the available bytes with
mptcp_data_avail(), instead of ack_seq minus the head skb's map_seq. The old
calculation overflowed on passive TFO connections. The patch also moves the
DATA_FIN sequence check into a new mptcp_data_fin() helper, adds one byte
for the FIN, and resets rcv_data_fin_seq in mptcp_disconnect().

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 259a16068afad..7ef37f978f5b1 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -558,6 +558,21 @@ static void mptcp_check_data_fin_ack(struct sock *sk)
>  	}
>  }
>  
> +static bool mptcp_data_fin(const struct mptcp_sock *msk, u64 *seq)
> +{
> +	u64 rcv_data_fin_seq;
> +
> +	smp_rmb(); /* pair with smp_wmb() in mptcp_update_rcv_data_fin() */
> +	rcv_data_fin_seq = READ_ONCE(msk->rcv_data_fin_seq);
> +	if (!before64(READ_ONCE(msk->ack_seq), rcv_data_fin_seq)) {
> +		if (seq)
> +			*seq = rcv_data_fin_seq;
> +
> +		return true;
> +	}
> +	return false;
> +}
> +

[ ... ]

> @@ -2364,22 +2370,18 @@ static bool mptcp_move_skbs(struct sock *sk)
>  static unsigned int mptcp_inq_hint(const struct sock *sk)
>  {
>  	const struct mptcp_sock *msk = mptcp_sk(sk);
> -	const struct sk_buff *skb;
> -
> -	skb = skb_peek(&sk->sk_receive_queue);
> -	if (skb) {
> -		u64 hint_val = READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
> +	u64 hint_val = mptcp_data_avail(msk);
>  
> -		if (hint_val >= INT_MAX)
> -			return INT_MAX;
> +	if (hint_val >= INT_MAX)
> +		return INT_MAX;
>  
> -		return (unsigned int)hint_val;
> +	if (READ_ONCE(msk->rcv_data_fin) ||
> +	    sk->sk_state == TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN)) {
> +		if (mptcp_data_fin(msk, NULL))
> +			hint_val += 1;
>  	}
>  
> -	if (sk->sk_state == TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN))
> -		return 1;
> -
> -	return 0;
> +	return (unsigned int)hint_val;
>  }

[Severity: Medium]
Can the TCP_CLOSE and RCV_SHUTDOWN arms of this condition add a FIN byte
that was never received?

The only function that writes a real value to rcv_data_fin_seq is
mptcp_update_rcv_data_fin() in net/mptcp/options.c. It sets the field
together with rcv_data_fin:

	WRITE_ONCE(msk->rcv_data_fin_seq,
		   mptcp_expand_seq(READ_ONCE(msk->ack_seq), data_fin_seq, use_64bit));
	smp_wmb(); /* ensure rcv_data_fin_seq is visible before rcv_data_fin */
	WRITE_ONCE(msk->rcv_data_fin, 1);

The msk can reach TCP_CLOSE or RCV_SHUTDOWN without any DATA_FIN. One
example is mptcp_check_fastclose() after the peer sends MP_FASTCLOSE:

	mptcp_set_state(sk, TCP_CLOSE);
	WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK);

A subflow reset or error propagation, or a local shutdown(SHUT_RD), leads
to the same state.

In these cases rcv_data_fin_seq is still 0, so mptcp_data_fin() evaluates
!before64(ack_seq, 0). That reduces to (s64)ack_seq >= 0.

subflow_set_remote_key() sets msk->ack_seq to subflow->iasn, which is
derived from a hash of the peer's key. The result therefore looks random
per connection. Fallback connections start with ack_seq at 0, so for them
the check is always true.

There seem to be two possible outcomes:

  - top bit of ack_seq clear: N queued bytes are reported as N + 1
  - top bit set: an empty queue in TCP_CLOSE or RCV_SHUTDOWN reports 0,
    where the old code returned 1

The commit message says:

    The FIN byte (+1) is guarded by checking rcv_data_fin, TCP_CLOSE, or
    RCV_SHUTDOWN before calling mptcp_data_fin().

Only the rcv_data_fin arm seems to guarantee that rcv_data_fin_seq holds a
valid value.

The new reset in mptcp_disconnect() has the same problem:

	WRITE_ONCE(msk->rcv_data_fin_seq, 0);

0 doesn't work as a "no FIN" marker here, because the comparison is
modular against ack_seq.

The TCP_CLOSE and RCV_SHUTDOWN arms also skip the rcv_data_fin read that
the smp_rmb() in mptcp_data_fin() is meant to pair with. Subflow context
writes rcv_data_fin_seq without holding the msk lock. A concurrent or torn
(on 32-bit) value could therefore feed the same comparison.

This still seems to be present at the end of the series. The later patch
"mptcp: add mptcp_inq() for SIOCINQ" moves SIOCINQ to mptcp_inq(). However,
mptcp_inq_hint() still feeds the TCP_CM_INQ cmsg in mptcp_recvmsg():

	unsigned int inq = mptcp_inq_hint(sk);

It also feeds the receive buffer autotuning in mptcp_rcv_space_adjust():

	copied -= mptcp_inq_hint(sk);

Should the +1 only be added when rcv_data_fin is set?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1795348666.git.tanggeliang%40kylinos.cn
