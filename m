Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794739989;
	b=E46YKHwzOVUhUQ2toOspwjr0xX/VuvpwnjJ4g2a34CTHho37WsmcFIb6kB3CZYDVpKkw
	 ZaEQ1siGSq5yxuszbAcrxdwXSwDvFrpJQj32PhaKx6EwIXZuPwtaELNGm27zZrmmGzKk6
	 bJMVyBalVAUJXtM+x/GnYvVz+/j/HOILOJps0fnhZSljAUpWkJkH53BoMQKaHAv6xq88e
	 rYNme1ZgW+LOMfCnT4I2KOnHhM5I64Odvu+LVSoYvZwSIhdGOKgG9AV639yz6tjTx7aw2
	 RAk9oYcY5uOhXsurrpZ3+xdBB1Ttnkg3ItTOniNCoe9TGbzwrWJNJG+ZvQEFJjbcngQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794739989;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=4wWDIdD4tY+qEU1lijgsWe4B83goYpWKqcvjkesrhWM=;
	b=tTLsuvp6yksaaYVdc4eNLOB5BjfWWr06O3PJdw5d8urGHnON3mGHlNl20eloasV9plAE
	 SWBwGSYAwEziR9Ifr8HPlqdpC31lgK5TL5A3z5lIbmVf/ALjimzcBhqtyrYcvcVd7rB1n
	 33L0K1yW21Jv4tdwGxuty2Jhi5gcVN1dTQLa7/uEKaQxw9Al4Gr22Ot815X29OmSS1D5Y
	 vzaGX4kHE1IROVcXR+hNjE9KgBVzzPofwszOwsU1l4kKVSCx+G5RSQKUNvjc7W1sL91UH
	 ZDkRKZitdgt3F1jR7qkbHGYZwk7CqmpE/oj3p5KocTrEE9965eL/5Bi+gBJPqW2nGew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mTsSPfoz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9688A606A31E
	for <mptcp@lists.linux.dev>; Sun, 15 Nov 2026 10:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mTsSPfoz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A4A1F000CA;
	Sun, 15 Nov 2026 10:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794739989;
	bh=4wWDIdD4tY+qEU1lijgsWe4B83goYpWKqcvjkesrhWM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mTsSPfozSgpDDwIFcXxSRnd/LdQySmmnNcj/02tBYWOQZMD/DxqYS+muaWNNk8CvS
	 GEJPLbSHUbrC7xK8oCXdUEfZMJJEJ1wNHYORu8gNw1Q7QPCz5ZpvndK9yMHfFqnNYT
	 SwnczwHiPsKO6+EE9St7s7S5ul5ew/6d4Y5ZusEMe8z0h2p0X4W9PXZ5tQlPh1doP/
	 QNM9ewktvf8kr5S1DYbpzdetUmAsvCTUKMRtfWQyEQNUTBU/0s0QXl3f9l04aSO/wr
	 ST086bS8FC5kkPy+ddE6NLrVDTHSJ/OYVL04hK0QISYYVJjD2GMh3/D5mDxSX32BIG
	 9gEhA4Lp7GN2Q==
Subject: Re: [PATCH mptcp-net 19/34] mptcp: do not fallback while old data is
 in flight
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc:
 mptcp@lists.linux.dev, mason@kernel.org, pabeni@redhat.com, kuba@kernel.org
Date: Sun, 15 Nov 2026 10:53:08 +0000
Message-ID: <179473998880.488855.2776646486976592128@kernel.org>
In-Reply-To: <20261113-mptcp-cmason-fixes-v1-19-9205b77e9a2f@kernel.org>
References: <20261113-mptcp-cmason-fixes-v1-19-9205b77e9a2f@kernel.org>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch blocks only the local host's own fallback while old
  data is in flight.

--

mptcp: do not fallback while old data is in flight

This commit aims to stop an MPTCP connection from falling back to TCP
while a zero window probe or reinjected data is queued or in flight. It
tracks such data with a new old_data_pending bit and old_data_end
sequence, and makes mptcp_try_fallback() fail while the bit is set. It
also delays the infinite mapping, and skips data below snd_nxt after a
fallback.

[ ... ]

> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 3be60da129241..75d4c2f82501c 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h

[ ... ]

> @@ -1330,6 +1332,11 @@ static inline bool mptcp_try_fallback(struct sock *ssk, int fb_mib)
>  	struct mptcp_sock *msk;
>  
>  	msk = mptcp_sk(sk);
> +
> +	/* queued old data would be sent without mapping after a fallback */
> +	if (subflow->old_data_pending && !__mptcp_check_fallback(msk))
> +		return false;
> +

[Severity: High]
This check only stops a fallback by the host that queued the old data.
Can the receiver still fall back on its own and deliver the old bytes
twice?

Suppose a middlebox strips the DSS from the segment that carries the
reinjected data or the probe. The receiver then goes through:

subflow_check_data_avail()
    get_mapping_status() returns MAPPING_NODSS
    mptcp_try_fallback(ssk, MPTCP_MIB_DSSFALLBACK)

On the receiver, subflow->old_data_pending only tracks data the receiver
sent itself, so it is 0. msk->allow_infinite_fallback is also still true
on a single-subflow connection. The fallback succeeds, and the copied
bytes are delivered as new stream data.

On the sender, mptcp_incoming_options() only ever clears the bit:

    if (unlikely(subflow->old_data_pending) &&
        !(mp_opt.use_map && !mp_opt.data_len) &&
        !before(TCP_SKB_CB(skb)->ack_seq, subflow->old_data_end))
        subflow->old_data_pending = 0;

Nothing reacts when old_data_end is TCP-acked by segments that carry no
MPTCP option. In a one-way transfer the sender never calls
mptcp_try_fallback(). So each later probe or MPTCP-level retransmission
would again be delivered as new data.

Isn't this the same "recv() can return data twice" case described in the
commit message, just with the peer falling back first?

Later patches in the series narrow this:

  - "mptcp: stop resending data to a peer that fell back" resets the
    subflow in mptcp_sendmsg_frag() when more old data is due and the
    earlier old data was acked without MPTCP options.
  - "mptcp: reset when the DSS disappears after a DATA_ACK" makes
    MAPPING_NODSS fatal in subflow_nodss_is_fatal(), but only when
    subflow->dss_confirmed is set.

dss_confirmed is only set when a DATA_ACK acknowledges data the receiver
sent itself. So at the end of the series, in a one-way transfer, the
receiver still falls back on a stripped reinjection or retransmission. It
then maps those bytes as new data with dsn_base + SSN - 1.

That means some data is still delivered twice before the sender resets:

  - the first MPTCP-level retransmitted batch;
  - all reinjected data after a failed MP_JOIN;
  - the real copy of a byte that was sent behind a stripped probe.

The later commit messages seem to admit this: "This limits the repeats,
but does not prevent the first one" and "This also closes the case
above, but only for a receiver whose data has been acknowledged."

Could the receiver side be covered too? If not, could the commit message
say that a fallback started by the peer is still possible?

>  	if (!__mptcp_try_fallback(msk, fb_mib))
>  		return false;
>  	if (READ_ONCE(msk->snd_data_fin_enable) && !(ssk->sk_shutdown & SEND_SHUTDOWN)) {

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f%40kernel.org
