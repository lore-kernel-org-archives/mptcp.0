Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB2C478847
	for <mptcp@lists.linux.dev>; Wed, 29 Jul 2026 11:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785325778; cv=none; b=b/yCSymG57lSsHR0/PxqX2xWooMg0w6bc0uYyTvInIsNtHRNCc4ZkVbRu8uebPgd1FPeeUf0PZbsSCjU8IC+uzIP3fUHB05u3NlYMM2zwcOJh6E1I9fjEDg9ElN2u30HSMATfuuAl3GDER8/QMZUGX2sMk6h6G6stMsxGuDKgT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785325778; c=relaxed/simple;
	bh=6a6yPCjjJZ7bLKdwrn1J3Rmx9yWKGY8gtSQjovFFKo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i2xxtC+98jH37aTuAYj7gvxnEabyvCHQ5P7DGNnRaMpxYPFSFCN7aIOO3bZzxnRII21K55QpBaH+syEavbkl+tVX4P34DnMdCsmnI9D0E/EUKGlIarV8o3C0F05kULGs+T+1PDTMszFJ3pWbeaex5+L5Kv3Oug3S5quQ3rT/ync=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8jJtQVp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8jJtQVp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB0E1F000E9;
	Wed, 29 Jul 2026 11:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785325776;
	bh=0qB6OkLiCqIbbtSb6Yl7JL+0gborLHwkSwB7shrQ1s0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=F8jJtQVpt+yETPgBz1+bSrHyzQm1WYB/M0m3nDak0GDQi2QYDW3hS7NhvB5MiQK6b
	 nl54GEtm44QYYHc6FBOx2jF7mcnlYf1u7SBFiBzmMsqt6seZ8RSvPopL82GzWdZUmA
	 psN7m6mKGun3D5RPxHMND15b1z2v6pRP4M5xlxHQArP+IWPuvWPLelIoOH63L4w7Vs
	 50o/9q8pIS99JrG+j2/v91fE52KjEm7J3aY+EgiD86CzWDOWpZlA/RTChxGb+RHfsV
	 WTixvfJF9Ty1bV0JF2pwpRseJQ/NRdS83Rec1MA83Y9+s7vSu5jxWgo7PyCqegBPqf
	 32VI84fx4R2ew==
Message-ID: <085c3192-1adc-4016-ab27-a0c053a2f2c1@kernel.org>
Date: Wed, 29 Jul 2026 13:49:34 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 1/3] mptcp: sched: penalise a slow subflow by
 halving its cwnd
Content-Language: fr
To: Shardul Bankar <shardul.b@mpiricsoftware.com>
Cc: shardulsb08@gmail.com, MPTCP Linux <mptcp@lists.linux.dev>
References: <20260726-mptcp_penalise_send-v1-0-84485e0e995b@mpiricsoftware.com>
 <20260726-mptcp_penalise_send-v1-1-84485e0e995b@mpiricsoftware.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260726-mptcp_penalise_send-v1-1-84485e0e995b@mpiricsoftware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Shardul,

On 26/07/2026 07:55, Shardul Bankar wrote:
> Issue #345: a poorly-performing but usable subflow (high latency, loss,
> bufferbloat) can soak up connection resources and cause head-of-line
> blocking of the aggregate stream. Give the default packet scheduler a way
> to send less than such a subflow's full congestion window.
> 
> Once a subflow has been picked for transmission, flag it for penalisation
> when:
> - its smoothed delivery rate (avg_pacing_rate) is below half that of the
>   fastest path, keying on rate, not RTT, so a slow-but-high-throughput
>   path is left alone;
> - the fastest path is cwnd-limited (saturated), so shifting load off the
>   slow path is worthwhile;
> - the subflow is in TCP_CA_Open, so its cwnd is not already being reduced
>   by loss recovery;
> - it has not been penalised in the last RTT.
> 
> The reduction halves tcp_snd_cwnd (floor 2) and ssthresh if cwnd
> is past it. It is applied in the push path under the subflow socket lock,
> which protects snd_cwnd (the scheduler runs under the msk lock). The
> congestion control grows the window back, ACK-clocked; that regrowth is
> the built-in probe, so no explicit MPTCP-side probing is needed.
> 
> Co-developed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
> ---
>  net/mptcp/protocol.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++++---
>  net/mptcp/protocol.h |  2 ++
>  2 files changed, 67 insertions(+), 3 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 954e20bb27de..d31bcb9ad894 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1556,6 +1556,44 @@ bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
>  #define SSK_MODE_BACKUP	1
>  #define SSK_MODE_MAX	2
>  
> +/* Penalise a subflow whose delivery (pacing) rate is below the fraction
> + * 1 / MPTCP_PENALISE_RATE_RATIO of the fastest path's rate. Keying on rate,
> + * not RTT, throttles only a path whose throughput contribution is small
> + * relative to the head-of-line cost it imposes, and leaves a merely
> + * higher-latency but high-throughput path alone.

Could you reduce the size of the comments, please? I understood that LLM
tends to leave long comments, but too long is not always good:
explanations can go in the commit message, or be understood by reading
the conditions (or that's a sign the code should be improved). Ideally,
comments should not be needed when reading the code, or limited to one,
with some exceptions for complex cases.

Here for example, I think you could limit the comment to one line:

/* Penalise subflows with pacing rate < this fraction of the fastest path */

> + */
> +#define MPTCP_PENALISE_RATE_RATIO	2
> +
> +/* Rate-limit the penalty to at most once per subflow RTT, so the congestion
> + * control can grow the window back between reductions.
> + */
> +static bool mptcp_penalise_throttle_ok(struct mptcp_subflow_context *subflow)
> +{
> +	struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +	u32 rtt = usecs_to_jiffies(tcp_sk(ssk)->srtt_us >> 3);
> +
> +	return tcp_jiffies32 - subflow->last_penalise >= max_t(u32, rtt, 1);
> +}
> +
> +/* Halve the congestion window (and ssthresh, if cwnd is past it) of a subflow
> + * the scheduler flagged. Runs in the push path under the subflow socket lock,
> + * which protects snd_cwnd. The congestion control grows the window back,
> + * ACK-clocked, and that regrowth is the built-in probe, so no explicit probing
> + * is needed.
> + */

Same here: I think what is important to mention is that it is under
subflow socket lock, and you can move the comment about the CC growing
the window back below: no explicit probing required then.

> +static void mptcp_penalise_cwnd(struct sock *ssk)
> +{
> +	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
> +	struct tcp_sock *tp = tcp_sk(ssk);
> +	u32 cwnd = tcp_snd_cwnd(tp);
> +
> +	subflow->penalise = false;

You probably need to check inet_csk(ssk)->icsk_ca_state == TCP_CA_Open
again here, under the subflow socket lock, just in case it has been
modified in between.

> +	subflow->last_penalise = tcp_jiffies32;
> +	tcp_snd_cwnd_set(tp, max_t(u32, cwnd >> 1, 2));
> +	if (cwnd >= tp->snd_ssthresh)
> +		tp->snd_ssthresh = max_t(u32, tp->snd_ssthresh >> 1, 2);
> +}
> +
>  /* implement the mptcp packet scheduler;
>   * returns the subflow that will transmit the next DSS
>   * additionally updates the rtx timeout
> @@ -1565,9 +1603,9 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
>  	struct subflow_send_info send_info[SSK_MODE_MAX];
>  	struct mptcp_subflow_context *subflow;
>  	struct sock *sk = (struct sock *)msk;
> -	u32 pace, burst, wmem;
> +	u32 pace, burst, wmem, max_pace = 0;

Sashiko is (rightly I think) mentioning that the size of these variables
are wrong. I guess a separate fix is needed to change "pace" to
"unsigned long" is required. "max_pace" will get this type too then.

>  	int i, nr_active = 0;
> -	struct sock *ssk;
> +	struct sock *ssk, *fastest = NULL;
>  	u64 linger_time;
>  	long tout = 0;
>  
> @@ -1596,6 +1634,14 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
>  				continue;
>  		}
>  
> +		/* track the fastest path by delivery rate; the penalty below
> +		 * throttles paths that are slow relative to it.
> +		 */
> +		if (pace > max_pace) {
> +			max_pace = pace;
> +			fastest = ssk;
> +		}
> +
>  		linger_time = div_u64((u64)READ_ONCE(ssk->sk_wmem_queued) << 32, pace);
>  		if (linger_time < send_info[backup].linger_time) {
>  			send_info[backup].ssk = ssk;
> @@ -1623,12 +1669,25 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
>  	if (!ssk || !sk_stream_memory_free(ssk))
>  		return NULL;
>  
> +	/* Flag the chosen subflow for cwnd halving (applied in the push path)
> +	 * when its delivery rate is a small fraction of the fastest path's and
> +	 * that fast path is saturated (cwnd-limited), so moving load off the
> +	 * slow path is worthwhile. Only penalise a path in TCP_CA_Open, one
> +	 * whose cwnd is not already being shrunk by loss recovery, and at most
> +	 * once per RTT.
> +	 */

Same here. Maybe a comment is not needed, or limited?

> +	subflow = mptcp_subflow_ctx(ssk);
> +	subflow->penalise = fastest && ssk != fastest &&
> +			    (u64)subflow->avg_pacing_rate * MPTCP_PENALISE_RATE_RATIO < max_pace &&

(or divide max_pace once before?)

> +			    inet_csk(ssk)->icsk_ca_state == TCP_CA_Open &&
> +			    tcp_is_cwnd_limited(fastest) &&
> +			    mptcp_penalise_throttle_ok(subflow);
> +
>  	burst = min(MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - msk->snd_nxt);
>  	wmem = READ_ONCE(ssk->sk_wmem_queued);
>  	if (!burst)
>  		return ssk;
>  
> -	subflow = mptcp_subflow_ctx(ssk);
>  	subflow->avg_pacing_rate = div_u64((u64)subflow->avg_pacing_rate * wmem +
>  					   READ_ONCE(ssk->sk_pacing_rate) * burst,

(here as well, it looks like there is an existing bug, and a cast to u64
is probably needed for 32-bit system, as pointed by Sashiko)

>  					   burst + wmem);
> @@ -1685,6 +1744,9 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
>  	struct mptcp_data_frag *dfrag;
>  	int len, copied = 0, err = 0;
>  
> +	if (mptcp_subflow_ctx(ssk)->penalise)
> +		mptcp_penalise_cwnd(ssk);
> +
>  	while ((dfrag = mptcp_send_head(sk))) {
>  		info->sent = dfrag->already_sent;
>  		info->limit = dfrag->data_len;
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index da40c6f3705f..2bf801292563 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -587,6 +587,7 @@ struct mptcp_subflow_context {
>  		__unused : 8;
>  	bool	data_avail;
>  	bool	scheduled;
> +	bool	penalise;	    /* scheduler flagged this subflow for cwnd halving */

(If you don't need to read this locklessly, then you can probably use
one unused bit.)

>  	bool	pm_listener;	    /* a listener managed by the kernel PM? */
>  	bool	fully_established;  /* path validated */
>  	u32	lent_mem_frag;
> @@ -606,6 +607,7 @@ struct mptcp_subflow_context {
>  	u8	stale_count;
>  
>  	u32	subflow_id;
> +	u32	last_penalise;	    /* tcp_jiffies32 of the last cwnd penalty */
>  
>  	long	delegated_status;
>  	unsigned long	fail_tout;
> 

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

