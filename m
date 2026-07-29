Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DAF3CDBD3
	for <mptcp@lists.linux.dev>; Wed, 29 Jul 2026 11:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785325792; cv=none; b=osjnRaXdCxi403G0GutZAyUvDEwUMrMES06i/TJUK+YkNWQyqbV/IogQ1KD2EAj6ggteH4Df5V4AxBrWqdHgMXSo92X+8n4zq1mXysicThSWvY5UnxnobUc2gzzJwRAUrpyy2FI4YXNCL7YQYLmJn9Hd/QP8ZpXXJ+7SXEPpdjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785325792; c=relaxed/simple;
	bh=rXpNLKRgeIkaNRVWkTLuvJ8eNsyCogLEs+859pwERjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IVO24kQ/ifVr3/RT+UJqngXvTXwONWFFXot9MUPKMpfCkPB8XNI/VQ3bnami3EiFy5cX4XiatgOYkoSoO0s98ji3amJGfRnafhelLhpyvQ/M+6qSngL9T8wgD4vCoSKywiolD7QhZJZhntW6vR4XaCnsYiO73xW95elFMWDvoVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCK/lxnc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCK/lxnc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9FE1F000E9;
	Wed, 29 Jul 2026 11:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785325791;
	bh=YxZhHPtlksPwk83MM/zgyR/kCOg2UqXpkTzJ3zW3K68=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=RCK/lxncOc46r6g5igvw7LQ8H29HhOxmqMnW3yMdAN1sJChJEtqfV3llTmrPvJoO4
	 uCoOA+6vRhkkb/iUPPaM60Wtti9MyD4fH36QFO8BwbVW6B9oW+BxePtW09LMD1TXs+
	 oJPjfjzbKFfSBIK2yGVFYXVyjrDpbi3GANliKUUCIazMoMt72N1chqdZ+udCrHk3yi
	 k9RifVBl3oGxchrFV9z3eFwmCqUrQqKJAnCkOKMQ1ozPZGI12X9PdqBvBySaTiHcaM
	 7M3HjZuAhU5mh9zmHPOHPN0H3V1ExjklIwgAoKHPEgjv6CNi4AuR7Rbxga/2/4i1oK
	 8uwkd+wUV6ZPA==
Message-ID: <39a6ac82-7044-4f57-8a89-84b729491d78@kernel.org>
Date: Wed, 29 Jul 2026 13:49:48 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 2/3] mptcp: sched: do not penalise when
 receive-window-limited
Content-Language: fr
To: Shardul Bankar <shardul.b@mpiricsoftware.com>
Cc: shardulsb08@gmail.com, MPTCP Linux <mptcp@lists.linux.dev>
References: <20260726-mptcp_penalise_send-v1-0-84485e0e995b@mpiricsoftware.com>
 <20260726-mptcp_penalise_send-v1-2-84485e0e995b@mpiricsoftware.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260726-mptcp_penalise_send-v1-2-84485e0e995b@mpiricsoftware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Shardul,

On 26/07/2026 07:55, Shardul Bankar wrote:
> The penalty in the previous patch shifts load off a slow subflow onto the
> fastest one, which only helps if the fastest path can absorb it. When the
> connection is receive-window-limited (the receiver's advertised window,
> not our congestion window, is the bottleneck), the fastest path is capped
> by that shared window too and cannot send more, so halving the slow path's
> cwnd just sheds its throughput. In a receive-window-limited transfer this
> was measured roughly 2x slower than baseline.
> 
> Gate on the application's queued data fitting within the send window:
> penalise only while write_seq <= wnd_end. If the application has queued
> past the window edge the receive window is the binding constraint, so skip
> the penalty. Both write_seq (application demand) and wnd_end (peer window)
> are standing values and neither is derived from cwnd, so the test is not
> biased by the scheduler sampling just after an ACK opened the window, nor
> made circular by the window itself suppressing cwnd.
> 
> Co-developed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
> ---
>  net/mptcp/protocol.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index d31bcb9ad894..7cbc5aa17e22 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1575,6 +1575,23 @@ static bool mptcp_penalise_throttle_ok(struct mptcp_subflow_context *subflow)
>  	return tcp_jiffies32 - subflow->last_penalise >= max_t(u32, rtt, 1);
>  }
>  
> +/* Only penalise when the connection is not receive-window-limited: all the
> + * data the application has queued fits within the current send window
> + * (write_seq <= wnd_end). If it has queued past the window edge, the peer's
> + * receive window (not our congestion window) is the bottleneck: the fast
> + * path is capped by that shared window too and cannot use capacity freed from
> + * the slow path, so penalising would only shed the slow path's throughput.
> + *
> + * write_seq (application demand) and wnd_end (peer-advertised window) are both
> + * standing values and neither is derived from cwnd, so unlike the instantaneous
> + * window headroom this is not biased by the scheduler sampling just after an
> + * ACK opened the window, nor circular when the window is what suppresses cwnd.

(a bit too long, some text can probably be moved to the commit message
if not there already → but also, I guess this commit will be squashed in
the previous one at the end)

> + */
> +static bool mptcp_penalise_send_window_ok(const struct mptcp_sock *msk)
> +{
> +	return msk->write_seq <= mptcp_wnd_end(msk);

It looks like you are doing something similar to tcp_snd_wnd_test(), no?

I guess you should at least use after64/before64. Here we don't have the
skb, that might change later if the MPTCP scheduler API is modified, but
that can be an optimisation for later.

You could name the helper mptcp_snd_wnd_test(), and mention it is
inspired by the TCP version, but without checking the packet len (for
the moment).

Other than that, this Sashiko's comment is interesting:

> Does this heuristic correctly identify receive-window bottlenecks without
> unintentionally disabling the penalty for congestion-limited bulk transfers?
> Because write_seq is limited by the socket send buffer (sk_sndbuf) rather
> than the congestion window, an application performing a bulk transfer with a
> large send buffer can easily queue data past the peer's advertised receive
> window.
> If the connection is heavily congestion-limited, the fast path is saturated
> and the slow path should still be penalized to reduce head-of-line blocking.
> However, since write_seq > mptcp_wnd_end(msk) in this scenario, it seems
> this check will incorrectly assume the connection is receive-window limited
> and skip the penalty.

By chance, did you already validate this case?

> +}
> +
>  /* Halve the congestion window (and ssthresh, if cwnd is past it) of a subflow
>   * the scheduler flagged. Runs in the push path under the subflow socket lock,
>   * which protects snd_cwnd. The congestion control grows the window back,
> @@ -1681,6 +1698,7 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
>  			    (u64)subflow->avg_pacing_rate * MPTCP_PENALISE_RATE_RATIO < max_pace &&
>  			    inet_csk(ssk)->icsk_ca_state == TCP_CA_Open &&
>  			    tcp_is_cwnd_limited(fastest) &&
> +			    mptcp_penalise_send_window_ok(msk) &&
>  			    mptcp_penalise_throttle_ok(subflow);
>  
>  	burst = min(MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - msk->snd_nxt);
> 

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

