Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795735792;
	b=L+BaIUb82ohj50vHsO7wPYyF5lppnxAw/CuiCv4w44DFQ8nAwZ0/u4kbdwLq+DmOFmZX
	 KjRty1xBklzJqArm1hgDmSHl4pKADavI/JfQ76B+aALaazHwXSXoBOPOZMpGMfit3ODmX
	 AnoW2/o5I4DvO6PmyHrEewnYaDStWLNZiKSrIiAP0DbSVAV3Nab9cQygxQczHs1rcHM1E
	 uxqfJmR8fOSxprRSGFCGKreSLEh/RdWOcEDC4Yj51nxvQ2aCIawVBr+iVR4h27VKnteAq
	 DgUZkmRtDzqpMu+JSEnUWVhkWUC5pClmGojHX1UW3mqN8h20G+t5o+D1xkaYm4XbBJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795735792;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=d88Sg/ZWXtAMcfuXgLDkbJSj0CuJQF+yrMoP+c+kfOA=;
	b=uRyOXpJ3O40gHATBvHJZg6sBcJuC4PhzXhHVtZmic4bfme1+j8UTfBxTNdSlyYwKKZ4e
	 1DgxHBWRyLMvzdS8RN1PmVlJn48LcYqIWo2cDFcIRxl8z1KrhEA6E8E48RxLLrvUuPwZ7
	 vZUyvKL8+SNBtGRS1ttjOJW7jVruMJasu3DjbccUzUhmDH3cASf82qdVV3p6HtEApvpQ/
	 jGdPEWAlHB5pFwVjQjJXbJhYqRMG+weiPivxCyryZS37j3r1TFje101O41bwYCCPRjFNh
	 Gf5i7IBRHNXMh6pLrk+D36/MCO+EdxC363VeAhR5H7i8NJil/sGS8oTqHlLbq7CH5QQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H19VZVJc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CBF606A31C
	for <mptcp@lists.linux.dev>; Thu, 26 Nov 2026 23:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H19VZVJc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30941F0089B;
	Thu, 26 Nov 2026 23:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795735791;
	bh=d88Sg/ZWXtAMcfuXgLDkbJSj0CuJQF+yrMoP+c+kfOA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=H19VZVJcVvnpH+yPjEkAmdZxVH+iOoWKBdTwnoxBPPapUYFB3y0+wD7onf3kr47xK
	 BlrNB1OwZddrRvJmv+9FaZm2ummyseRiz1MlF9a+SQCew7cASwiBvhS03kNX2FdD9b
	 uO5wgTiT68tukbwhfQdt42aqgnPTWeDWUNLJA/2C6dRFnOW3HlS6K3MnJIGXU9x+kh
	 L1Snli//6CXStXwv8D3gjoRcdmmvMyGtBe+QCYIgA4ROHxiwMEcKOi8bWg/U5Y+TNa
	 mCYC8oP9ca5+rc76io8R98p5mk61OPLO2sDCf0MpWZof6vR3MfGRkDh5U2B8B63x0V
	 Xj8cd0LNOo7QQ==
Subject: Re: [PATCH mptcp-net v3 29/50] mptcp: don't resend data acked without
 MPTCP opts
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Thu, 26 Nov 2026 23:29:51 +0000
Message-ID: <179573579122.3133.15496285352485527171@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-29-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-29-416c0920c73f@kernel.org>
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

- [Low] In net/mptcp/protocol.c, mptcp_sendmsg_frag() (lines 1566-1568)
  used to reset the subflow under `before64(data_seq, msk->snd_nxt) &&…
- [Low] For a passive MP_JOIN, MPTCP_JOINED is only set by
  mptcp_subflow_joined(), called from __mptcp_finish_join().

--

mptcp: don't resend data acked without MPTCP opts

This patch adds opt_ack_seq, a per-subflow field that tracks the highest
TCP ack_seq received with MPTCP options. Data acked without MPTCP options
now makes the subflow reset instead of being resent at the MPTCP level.
The check only applies until a new MPTCP_JOINED msk flag gets set, which
happens once an MP_JOIN subflow has been established.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 61cc4ae2a7b81..f3dd15293bc8c 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1090,6 +1090,9 @@ static void mptcp_subflow_joined(struct mptcp_sock *msk, struct sock *ssk)
>  {
>  	mptcp_subflow_ctx(ssk)->map_seq = READ_ONCE(msk->ack_seq);
>  	msk->allow_infinite_fallback = false;
> +	/* an active join is added once fully established, see options.c */
> +	if (!mptcp_subflow_ctx(ssk)->request_join)
> +		set_bit(MPTCP_JOINED, &msk->flags);
>  	mptcp_event(MPTCP_EVENT_SUB_ESTABLISHED, msk, ssk, GFP_ATOMIC);
>  }

[Severity: Low]
For a passive MP_JOIN, is this the only place where MPTCP_JOINED gets set?
If the user owns the msk when the third ACK arrives, mptcp_finish_join()
only queues the subflow:

net/mptcp/protocol.c:mptcp_finish_join() {
    ...
	} else {
		sock_hold(ssk);
		list_add_tail(&subflow->node, &msk->join_list);
		__set_bit(MPTCP_FLUSH_JOIN_LIST, &msk->cb_flags);
    ...
}

mptcp_subflow_joined() then runs only later, through
mptcp_release_cb()->__mptcp_flush_join_list().

Until then, code running under the same ownership can still call
mptcp_sendmsg_frag() on the first subflow while MPTCP_JOINED is clear.
Two examples are mptcp_worker()->__mptcp_retrans() and a zero window probe
from the sendmsg path.

Suppose the peer already considers the join established and leaves out a
Data ACK that does not advance on the first subflow. The commit message
says RFC 8684 section 3.3.2 allows this after a join. tcp_ack() then moves
snd_una, but opt_ack_seq does not move.

Would mptcp_sendmsg_frag() then reset the first subflow with
MPTCP_RST_EMIDDLEBOX and increment MPTCP_MIB_FALLBACKFAILED, even though a
join has already been accepted?

The window is narrow. It needs the msk lock to be held across a round
trip, and a non-Linux peer that leaves out non-advancing Data ACKs only
after a join. mptcp_release_cb() flushes the join list before it handles
PUSH_PENDING and RETRANSMIT, so the release path itself looks correctly
ordered.

[ ... ]

> @@ -1557,10 +1560,12 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
>  		copy = 1;
>  	}
>  
> -	/* old data acked without MPTCP opts: the peer may have fallen back */
> +	/* data acked without MPTCP opts: the peer may have fallen back, only
> +	 * possible before a join, see RFC 8684
> +	 */
>  	if (unlikely(before64(data_seq, msk->snd_nxt) &&
> -		     subflow->old_data_pending &&
> -		     !before(tcp_sk(ssk)->snd_una, subflow->old_data_end))) {
> +		     !test_bit(MPTCP_JOINED, &msk->flags) &&
> +		     after(tcp_sk(ssk)->snd_una, subflow->opt_ack_seq))) {

[Severity: Low]
This isn't a bug, but could the commit message say that this also changes
what the previous commit added in "mptcp: stop resending data to a peer
that fell back"?

The old condition reset the subflow for data that had already been resent
and was then acked without MPTCP options. It did this whether or not any
join had happened.

This patch drops the old_data_pending term and gates the whole check on
MPTCP_JOINED. After an MP_JOIN subflow is established, that reset no
longer happens, and the data is resent again.

The commit message says:

    Only before any MP_JOIN subflow has been established
    ...
    Two other new tests check that this data is still resent after a join,

It doesn't say that the reset for data that was already resent is now
also skipped after a join. The code itself looks fine; this is only about
the description.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261124-mptcp-cmason-fixes-v3-0-416c0920c73f%40kernel.org
