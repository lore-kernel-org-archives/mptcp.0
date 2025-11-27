Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4F72163B2
	for <mptcp@lists.linux.dev>; Thu, 27 Nov 2025 02:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764209971; cv=none; b=cfCANubXtKUU+zKBY3PRx0DWSGamlI5lbMBrntPghlbrHJE90fUWPzd7f4RGOeu6gsz01OUcAEdgJJrbKnnEOYqIyImVIzJaVNfNmNNcabsM5liP2yGKoRIByw9TSxC3uwUkBY7/XlBXyikEGxB9R6MoyWA/YPOSWb+Srw5enx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764209971; c=relaxed/simple;
	bh=wJ4wfzytw8SMN58569Ba/iAZ19fA4pvTuD4q+oXwzJ8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jd8GtZUl15M8GCUZp8uuPQgcDcS9KHjTMcQsIGQuS9AogioaWq08KQvboSM1UP4ziOZvoLuoHAhx8q46mKrnNMyNpvDBp6GXN5mH/QIX4GaKNwF8THKQ7G558/6pLlyzKJLaJzjebd+IPblARFfsMsZR8PNUA71P7kWL0okA/mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LjJBlUty; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjJBlUty"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14503C116B1;
	Thu, 27 Nov 2025 02:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764209971;
	bh=wJ4wfzytw8SMN58569Ba/iAZ19fA4pvTuD4q+oXwzJ8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=LjJBlUtyfqOq4urbet9DlYmOE9dd/Rj2u62+0cyfg7/Fi39oCOrAJZumKgJ0Muve9
	 pD6rffsSJc3JHkRXO0QAZvlr3T4onWnFV4Hc+Y4NRYKCVkq+CBEUMUXE22xyeB4Dvr
	 CD32Ny0+zOFt8Liqk7+5OHSF97Ms8rN0g1cY+QqyOl6r9+787USeFcrZHKgwn5gbyA
	 NAWugAmqLUZBMZ4Er3BHDq/1WcCGN04Nn9FFlEFCWX34gx28lHXoQ9GfKUS7GWOpCr
	 bBzChf5afnYGl6tEJncqsEi/QdywWLKAdAqNEN1snej9ZiFJsj98j0Kvj4cIiM+uUp
	 7BC8u+xl6Gg4A==
Date: Wed, 26 Nov 2025 18:19:30 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, Matthieu Baerts <matttbe@kernel.org>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v7 mptcp-next 5/6] mptcp: better mptcp-level RTT
 estimator
In-Reply-To: <6ffc28b03d35f1b5698ff9ed6b22bd3e82fc81be.1763625391.git.pabeni@redhat.com>
Message-ID: <1d606ce4-8921-56c0-c78a-b05c8ebef798@kernel.org>
References: <cover.1763625391.git.pabeni@redhat.com> <6ffc28b03d35f1b5698ff9ed6b22bd3e82fc81be.1763625391.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 20 Nov 2025, Paolo Abeni wrote:

> The current MPTCP-level RTT estimator has several issues. On high speed
> links, the MPTCP-level receive buffer auto-tuning happens with a frequency
> well above the TCP-level's one. That in turn can cause excessive/unneeded
> receive buffer increase.
>

Thanks for the revisions Paolo, this definitely addresses my concerns 
about rtt values getting "stuck".

Am I understanding correctly: the msk-level rtt estimate doesn't have 
a direct effect on the size of the autotuned receive buffer, it just 
changes how often it's updated?

It seems like this new algorithm will do a good job of protecting against 
high-rtt outliers and effects from inactive subflows. It might have 
low-rtt outliers, is that a problem at all? Or is the occasional early 
update ok?

I think it would be a good idea to put the series into the export branch 
so we can get some test coverage - but would still like to hear your 
thoughts on the low-rtt outlier question!

Reviewed-by: Mat Martineau <martineau@kernel.org>


> On such links, the initial rtt_us value is considerably higher
> than the actual delay, and the current mptcp_rcv_space_adjust() updates
> msk->rcvq_space.rtt_us with a period equal to the such field previous
> value. If the initial rtt_us is 40ms, its first update will happen after
> 40ms, even if the subflows see actual RTT orders of magnitude lower.
>
> Additionally:
> - setting the msk rtt to the maximum among all the subflows RTTs makes DRS
> constantly overshooting the rcvbuf size when a subflow has considerable
> higher latency than the other(s).
>
> - during unidirectional bulk transfers with multiple active subflows, the
> TCP-level RTT estimator occasionally sees considerably higher value than
> the real link delay, i.e. when the packet scheduler reacts to an incoming
> ack on given subflow pushing data on a different subflow.
>
> - currently inactive but still open subflows (i.e. switched to backup mode)
> are always considered when computing the msk-level rtt.
>
> Address the all the issues above with a more accurate RTT estimation
> strategy: the MPTCP-level RTT is set to the minimum of all the subflows
> actually feeding data into the MPTCP receive buffer, using a small sliding
> window.
>
> While at it, also use EWMA to compute the msk-level scaling_ratio, to that
> mptcp can avoid traversing the subflow list is mptcp_rcv_space_adjust().
>
> Use some care to avoid updating msk and ssk level fields too often.
>
> Fixes: a6b118febbab ("mptcp: add receive buffer auto-tuning")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v4 -> v5:
>  - avoid filtering out too high value, use sliding window instead
>
> v3 -> v4:
>  - really refresh msk rtt after a full win per subflow (off-by-one in prev
>    revision)
>  - sync mptcp_rcv_space_adjust() comment with the new code
>
> v1 -> v2:
>  - do not use explicit reset flags - do rcv win based decision instead
>  - discard 0 rtt_us samples from subflows
>  - discard samples on non empty rx queue
>  - discard "too high" samples, see the code comments WRT the whys
> ---
> include/trace/events/mptcp.h |  2 +-
> net/mptcp/protocol.c         | 63 ++++++++++++++++++++----------------
> net/mptcp/protocol.h         | 38 +++++++++++++++++++++-
> 3 files changed, 73 insertions(+), 30 deletions(-)
>
> diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
> index 269d949b2025..04521acba483 100644
> --- a/include/trace/events/mptcp.h
> +++ b/include/trace/events/mptcp.h
> @@ -219,7 +219,7 @@ TRACE_EVENT(mptcp_rcvbuf_grow,
> 		__be32 *p32;
>
> 		__entry->time = time;
> -		__entry->rtt_us = msk->rcvq_space.rtt_us >> 3;
> +		__entry->rtt_us = mptcp_rtt_us_est(msk) >> 3;
> 		__entry->copied = msk->rcvq_space.copied;
> 		__entry->inq = mptcp_inq_hint(sk);
> 		__entry->space = msk->rcvq_space.space;
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 40c90d841237..5dde016a108d 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -880,6 +880,32 @@ static bool move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
> 	return moved;
> }
>
> +static void mptcp_rcv_rtt_update(struct mptcp_sock *msk,
> +				 struct mptcp_subflow_context *subflow)
> +{
> +	const struct tcp_sock *tp = tcp_sk(subflow->tcp_sock);
> +	u32 rtt_us = tp->rcv_rtt_est.rtt_us;
> +	int id;
> +
> +	/* Update once per subflow per rcvwnd to avoid touching the msk
> +	 * too often.
> +	 */
> +	if (!rtt_us || tp->rcv_rtt_est.seq == subflow->prev_rtt_seq)
> +		return;
> +
> +	subflow->prev_rtt_seq = tp->rcv_rtt_est.seq;
> +
> +	/* Pairs with READ_ONCE() in mptcp_rtt_us_est(). */
> +	id = msk->rcv_rtt_est.next_sample;
> +	WRITE_ONCE(msk->rcv_rtt_est.samples[id], rtt_us);
> +	if (++msk->rcv_rtt_est.next_sample == MPTCP_RTT_SAMPLES)
> +		msk->rcv_rtt_est.next_sample = 0;
> +
> +	/* EWMA among the incoming subflows */
> +	msk->scaling_ratio = ((msk->scaling_ratio << 3) - msk->scaling_ratio +
> +			     tp->scaling_ratio) >> 3;
> +}
> +
> void mptcp_data_ready(struct sock *sk, struct sock *ssk)
> {
> 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
> @@ -893,6 +919,7 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
> 		return;
>
> 	mptcp_data_lock(sk);
> +	mptcp_rcv_rtt_update(msk, subflow);
> 	if (!sock_owned_by_user(sk)) {
> 		/* Wake-up the reader only for in-sequence data */
> 		if (move_skbs_to_msk(msk, ssk) && mptcp_epollin_ready(sk))
> @@ -2067,7 +2094,6 @@ static void mptcp_rcv_space_init(struct mptcp_sock *msk, const struct sock *ssk)
>
> 	msk->rcvspace_init = 1;
> 	msk->rcvq_space.copied = 0;
> -	msk->rcvq_space.rtt_us = 0;
>
> 	/* initial rcv_space offering made to peer */
> 	msk->rcvq_space.space = min_t(u32, tp->rcv_wnd,
> @@ -2078,15 +2104,15 @@ static void mptcp_rcv_space_init(struct mptcp_sock *msk, const struct sock *ssk)
>
> /* receive buffer autotuning.  See tcp_rcv_space_adjust for more information.
>  *
> - * Only difference: Use highest rtt estimate of the subflows in use.
> + * Only difference: Use lowest rtt estimate of the subflows in use, see
> + * mptcp_rcv_rtt_update() and mptcp_rtt_us_est().
>  */
> static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
> {
> 	struct mptcp_subflow_context *subflow;
> 	struct sock *sk = (struct sock *)msk;
> -	u8 scaling_ratio = U8_MAX;
> -	u32 time, advmss = 1;
> -	u64 rtt_us, mstamp;
> +	u32 time, rtt_us;
> +	u64 mstamp;
>
> 	msk_owned_by_me(msk);
>
> @@ -2101,29 +2127,8 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
> 	mstamp = mptcp_stamp();
> 	time = tcp_stamp_us_delta(mstamp, READ_ONCE(msk->rcvq_space.time));
>
> -	rtt_us = msk->rcvq_space.rtt_us;
> -	if (rtt_us && time < (rtt_us >> 3))
> -		return;
> -
> -	rtt_us = 0;
> -	mptcp_for_each_subflow(msk, subflow) {
> -		const struct tcp_sock *tp;
> -		u64 sf_rtt_us;
> -		u32 sf_advmss;
> -
> -		tp = tcp_sk(mptcp_subflow_tcp_sock(subflow));
> -
> -		sf_rtt_us = READ_ONCE(tp->rcv_rtt_est.rtt_us);
> -		sf_advmss = READ_ONCE(tp->advmss);
> -
> -		rtt_us = max(sf_rtt_us, rtt_us);
> -		advmss = max(sf_advmss, advmss);
> -		scaling_ratio = min(tp->scaling_ratio, scaling_ratio);
> -	}
> -
> -	msk->rcvq_space.rtt_us = rtt_us;
> -	msk->scaling_ratio = scaling_ratio;
> -	if (time < (rtt_us >> 3) || rtt_us == 0)
> +	rtt_us = mptcp_rtt_us_est(msk);
> +	if (rtt_us == U32_MAX || time < (rtt_us >> 3))
> 		return;
>
> 	if (msk->rcvq_space.copied <= msk->rcvq_space.space)
> @@ -2969,6 +2974,7 @@ static void __mptcp_init_sock(struct sock *sk)
> 	msk->timer_ival = TCP_RTO_MIN;
> 	msk->scaling_ratio = TCP_DEFAULT_SCALING_RATIO;
> 	msk->backlog_len = 0;
> +	mptcp_init_rtt_est(msk);
>
> 	WRITE_ONCE(msk->first, NULL);
> 	inet_csk(sk)->icsk_sync_mss = mptcp_sync_mss;
> @@ -3412,6 +3418,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
> 	msk->bytes_sent = 0;
> 	msk->bytes_retrans = 0;
> 	msk->rcvspace_init = 0;
> +	mptcp_init_rtt_est(msk);
>
> 	/* for fallback's sake */
> 	WRITE_ONCE(msk->ack_seq, 0);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index ee0dbd6dbacf..b392d7855928 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -269,6 +269,13 @@ struct mptcp_data_frag {
> 	struct page *page;
> };
>
> +/* Arbitrary compromise between as low as possible to react timely to subflow
> + * close event and as big as possible to avoid being fouled by biased large
> + * samples due to peer sending data on a different subflow WRT to the incoming
> + * ack.
> + */
> +#define MPTCP_RTT_SAMPLES	5
> +
> /* MPTCP connection sock */
> struct mptcp_sock {
> 	/* inet_connection_sock must be the first member */
> @@ -340,11 +347,17 @@ struct mptcp_sock {
> 				 */
> 	struct mptcp_pm_data	pm;
> 	struct mptcp_sched_ops	*sched;
> +
> +	/* Most recent rtt_us observed by in use incoming subflows. */
> +	struct {
> +		u32	samples[MPTCP_RTT_SAMPLES];
> +		u32	next_sample;
> +	} rcv_rtt_est;
> +
> 	struct {
> 		int	space;	/* bytes copied in last measurement window */
> 		int	copied; /* bytes copied in this measurement window */
> 		u64	time;	/* start time of measurement window */
> -		u64	rtt_us; /* last maximum rtt of subflows */
> 	} rcvq_space;
> 	u8		scaling_ratio;
> 	bool		allow_subflows;
> @@ -422,6 +435,27 @@ static inline struct mptcp_data_frag *mptcp_send_head(const struct sock *sk)
> 	return msk->first_pending;
> }
>
> +static inline void mptcp_init_rtt_est(struct mptcp_sock *msk)
> +{
> +	int i;
> +
> +	for (i = 0; i < MPTCP_RTT_SAMPLES; ++i)
> +		msk->rcv_rtt_est.samples[i] = U32_MAX;
> +	msk->rcv_rtt_est.next_sample = 0;
> +	msk->scaling_ratio = TCP_DEFAULT_SCALING_RATIO;
> +}
> +
> +static inline u32 mptcp_rtt_us_est(const struct mptcp_sock *msk)
> +{
> +	u32 rtt_us = msk->rcv_rtt_est.samples[0];
> +	int i;
> +
> +	/* Lockless access of collected samples. */
> +	for (i = 1; i < MPTCP_RTT_SAMPLES; ++i)
> +		rtt_us = min(rtt_us, READ_ONCE(msk->rcv_rtt_est.samples[i]));
> +	return rtt_us;
> +}
> +
> static inline struct mptcp_data_frag *mptcp_send_next(struct sock *sk)
> {
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> @@ -523,6 +557,8 @@ struct mptcp_subflow_context {
> 	u32	map_data_len;
> 	__wsum	map_data_csum;
> 	u32	map_csum_len;
> +	u32	prev_rtt_us;
> +	u32	prev_rtt_seq;
> 	u32	request_mptcp : 1,  /* send MP_CAPABLE */
> 		request_join : 1,   /* send MP_JOIN */
> 		request_bkup : 1,
> -- 
> 2.51.1
>
>
