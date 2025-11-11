Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E2E158545
	for <mptcp@lists.linux.dev>; Tue, 11 Nov 2025 01:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762826168; cv=none; b=N5gNR26eBjcLHw5qtNCdMCPh/KP0cDZ2oRy6pRmG/FxmMGvZePNO6l4ci3DoK+K1kf3Keigg6Y6gNUc6/ZfDq78g9dH8BjgMTWZp6AopUrSGx6r29H2gqM0/PW65a76n1q7FkUpnJDiSS3GWyIbryMspfnYN7fCTkiP9d31/D3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762826168; c=relaxed/simple;
	bh=taRLavDkR0mZz/MP88ryLPTCR63x3S5r9+xzR973laY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OSeVzWpZV135SKXUBiCXN213TF/UQebB0oI5ijWtZQwQdyrJjBwoq6QUjOWff1pLtxAAJzfcANrGKJXXfsWnZ9pSLWj4xR+3pbhX6umRwxMHf0Ohcmli3HaraAxkC15FJ5eul4wiphijjsyim8GMhVO5trra7yOjB/N11x1R3o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1P7XaIG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1P7XaIG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E79C116D0;
	Tue, 11 Nov 2025 01:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762826164;
	bh=taRLavDkR0mZz/MP88ryLPTCR63x3S5r9+xzR973laY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=m1P7XaIGAGcz06tx4vC7lSfyFKPwAmfv+OF07nlHrBaraEuhD0i1PvzK+P9lI1k0Y
	 doctXDU2D6PjV8Ty31GfzaJyJUkwtD1W6BcIpeuaG0dA4EAJmd9Y3WsuxIf4N51M2A
	 Z1tNhP4jJUEhXl4PtBN6YExdok1v9ALQjqgpFUFQmZ5r1as05fAKmapoFMnXxZrIVl
	 a2aAGKXOTLabmIt7T1wzENaZkOJHmZKyD7CbQnzQiYs65yI+szsUil3vKe60J9enDT
	 bxz7ULul2L7+NlR++l6FzzD4LXnnGFNLgAGkwg6RhAqGQF3hQrd8GZgCCFNk0y1MyS
	 QR7+AyBgwoqaw==
Date: Mon, 10 Nov 2025 17:56:03 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v3 mptcp-next 6/7] mptcp: better mptcp-level RTT
 estimator
In-Reply-To: <2e404a1c673c812819ac5b6f12d57d23625c1e71.1762504059.git.pabeni@redhat.com>
Message-ID: <fc066efe-5656-4561-1a69-b290215743c2@kernel.org>
References: <cover.1762504059.git.pabeni@redhat.com> <2e404a1c673c812819ac5b6f12d57d23625c1e71.1762504059.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 7 Nov 2025, Paolo Abeni wrote:

> The current MPTCP-level RTT estimator has several issues. On high speed
> links, the MPTCP-level receive buffer auto-tuning happens with a frequency
> well above the TCP-level's one. That in turn can cause excessive/unneeded
> receive buffer increase.
>
> On such links, the initial rtt_us value is considerably higher
> than the actual delay, and the current mptcp_rcv_space_adjust() updates
> msk->rcvq_space.rtt_us with a period equal to the such field previous
> value. If the initial rtt_us is 40ms, its first update will happen after
> 40ms, even if the subflows see actual RTT orders of magnitude lower.
>
> Additionally, setting the msk rtt to the maximum among all the subflows
> RTTs makes DRS constantly overshooting the rcvbuf size when a subflow has
> considerable higher latency than the other(s).
>
> Finally, during unidirectional bulk transfers with multiple active
> subflows, the TCP-level RTT estimator occasionally sees considerably higher
> value than the real link delay, i.e. when the packet scheduler reacts to
> an incoming ack on given subflow pushing data on a different subflow.
>
> Address the issue with a more accurate RTT estimation strategy: the
> MPTCP-level RTT is set to the minimum of all the subflows, in a rcv-win
> based interval, feeding data into the MPTCP-receive buffer.
>
> Use some care to avoid updating msk and ssk level fields too often and
> to avoid 'too high' samples.
>
> Fixes: a6b118febbab ("mptcp: add receive buffer auto-tuning")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v1 -> v2:
>  - do not use explicit reset flags - do rcv win based decision instead
>  - discard 0 rtt_us samples from subflows
>  - discard samples on non empty rx queue
>  - discard "too high" samples, see the code comments WRT the whys

Hi Paolo -

Thanks for the explanation in the v2 discussion, and for the commit 
message update here - those both helped clarify what's changing.

> ---
> include/trace/events/mptcp.h |  2 +-
> net/mptcp/protocol.c         | 74 ++++++++++++++++++++++--------------
> net/mptcp/protocol.h         |  7 +++-
> 3 files changed, 53 insertions(+), 30 deletions(-)
>
> diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
> index 0f24ec65cea6..d30d2a6a8b42 100644
> --- a/include/trace/events/mptcp.h
> +++ b/include/trace/events/mptcp.h
> @@ -218,7 +218,7 @@ TRACE_EVENT(mptcp_rcvbuf_grow,
> 		__be32 *p32;
>
> 		__entry->time = time;
> -		__entry->rtt_us = msk->rcvq_space.rtt_us >> 3;
> +		__entry->rtt_us = msk->rcv_rtt_est.rtt_us >> 3;
> 		__entry->copied = msk->rcvq_space.copied;
> 		__entry->inq = mptcp_inq_hint(sk);
> 		__entry->space = msk->rcvq_space.space;
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 97c4f1ee25e0..3d0990c58c02 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -868,6 +868,42 @@ static bool move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
> 	return moved;
> }
>
> +static void mptcp_rcv_rtt_update(struct mptcp_sock *msk,
> +				 struct mptcp_subflow_context *subflow)
> +{
> +	const struct tcp_sock *tp = tcp_sk(subflow->tcp_sock);
> +	u32 rtt_us = tp->rcv_rtt_est.rtt_us;
> +	u8 sr = tp->scaling_ratio;
> +
> +	/* MPTCP can react to incoming acks pushing data on different subflows,
> +	 * causing apparent high RTT: ignore large samples; also do the update
> +	 * only on RTT changes
> +	 */
> +	if (tp->rcv_rtt_est.seq == subflow->prev_rtt_seq ||
> +	    (subflow->prev_rtt_us && (rtt_us >> 1) > subflow->prev_rtt_us))
> +		return;

If the subflow rtt increases and stays high, is there any provision to 
adapt to that?

> +
> +	/* Similar to plain TCP, only consider samples with empty RX queue. */
> +	if (!rtt_us || mptcp_data_avail(msk))
> +		return;
> +
> +	/* Refresh the RTT after a full win per subflow */
> +	subflow->prev_rtt_us = rtt_us;
> +	subflow->prev_rtt_seq = tp->rcv_rtt_est.seq;
> +	if (after(subflow->map_seq, msk->rcv_rtt_est.seq)) {
> +		msk->rcv_rtt_est.seq = subflow->map_seq +
> +				       tp->rcv_wnd * msk->pm.extra_subflows;
> +		msk->rcv_rtt_est.rtt_us = rtt_us;
> +		msk->scaling_ratio = sr;
> +		return;

Ok - so the rtt of the active subflow (whichever subflow happens to be 
receiving the data that triggers the refresh) will rewrite the msk-level 
rtt. It could be one of the higher-rtt subflows, but the code just below 
will quickly reduce the msk rtt as data arrives on those subflows. High 
rtts are filtered above so it shouldn't be too drastic. Are there any 
consequences to occasional small jumps in rtt?

> +	}
> +
> +	if (rtt_us < msk->rcv_rtt_est.rtt_us)
> +		msk->rcv_rtt_est.rtt_us = rtt_us;
> +	if (sr < msk->scaling_ratio)
> +		msk->scaling_ratio = sr;
> +}
> +
> void mptcp_data_ready(struct sock *sk, struct sock *ssk)
> {
> 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
> @@ -881,6 +917,7 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
> 		return;
>
> 	mptcp_data_lock(sk);
> +	mptcp_rcv_rtt_update(msk, subflow);
> 	if (!sock_owned_by_user(sk)) {
> 		/* Wake-up the reader only for in-sequence data */
> 		if (move_skbs_to_msk(msk, ssk) && mptcp_epollin_ready(sk))
> @@ -2058,6 +2095,7 @@ static void mptcp_rcv_space_init(struct mptcp_sock *msk)
> 	msk->rcvspace_init = 1;
>
> 	mptcp_data_lock(sk);
> +	msk->rcv_rtt_est.seq = atomic64_read(&msk->rcv_wnd_sent);
> 	__mptcp_sync_rcvspace(sk);
>
> 	/* Paranoid check: at least one subflow pushed data to the msk. */
> @@ -2076,9 +2114,8 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)

It's not in the diff context here, but there's a comment at the beginning 
of the mptcp_rcv_space_adjust() function that still refers to the "highest 
rtt estimate".

> {
> 	struct mptcp_subflow_context *subflow;
> 	struct sock *sk = (struct sock *)msk;
> -	u8 scaling_ratio = U8_MAX;
> -	u32 time, advmss = 1;
> -	u64 rtt_us, mstamp;
> +	u32 rtt_us, time;
> +	u64 mstamp;
>
> 	msk_owned_by_me(msk);
>
> @@ -2093,29 +2130,8 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
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
> +	rtt_us = READ_ONCE(msk->rcv_rtt_est.rtt_us);
> +	if (rtt_us == U32_MAX || time < (rtt_us >> 3))
> 		return;
>
> 	if (msk->rcvq_space.copied <= msk->rcvq_space.space)
> @@ -2954,7 +2970,8 @@ static void __mptcp_init_sock(struct sock *sk)
> 	msk->scaling_ratio = TCP_DEFAULT_SCALING_RATIO;
> 	msk->backlog_len = 0;
> 	msk->rcvq_space.copied = 0;
> -	msk->rcvq_space.rtt_us = 0;
> +	msk->rcv_rtt_est.rtt_us = U32_MAX;
> +	msk->scaling_ratio = U8_MAX;
>
> 	WRITE_ONCE(msk->first, NULL);
> 	inet_csk(sk)->icsk_sync_mss = mptcp_sync_mss;
> @@ -3399,7 +3416,8 @@ static int mptcp_disconnect(struct sock *sk, int flags)
> 	msk->bytes_retrans = 0;
> 	msk->rcvspace_init = 0;
> 	msk->rcvq_space.copied = 0;
> -	msk->rcvq_space.rtt_us = 0;
> +	msk->scaling_ratio = U8_MAX;
> +	msk->rcv_rtt_est.rtt_us = U32_MAX;
>
> 	/* for fallback's sake */
> 	WRITE_ONCE(msk->ack_seq, 0);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index adc0851bad69..051f21b06d33 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -340,11 +340,14 @@ struct mptcp_sock {
> 				 */
> 	struct mptcp_pm_data	pm;
> 	struct mptcp_sched_ops	*sched;
> +	struct {
> +		u32	rtt_us;		/* Minimum RTT of subflows */
> +		u64	seq;		/* Refresh RTT after this seq */
> +	} rcv_rtt_est;
> 	struct {
> 		int	space;	/* bytes copied in last measurement window */
> 		int	copied; /* bytes copied in this measurement window */
> 		u64	time;	/* start time of measurement window */
> -		u64	rtt_us; /* last maximum rtt of subflows */
> 	} rcvq_space;
> 	u8		scaling_ratio;
> 	bool		allow_subflows;
> @@ -523,6 +526,8 @@ struct mptcp_subflow_context {
> 	u32	map_data_len;
> 	__wsum	map_data_csum;
> 	u32	map_csum_len;
> +	u32	prev_rtt_us;
> +	u32	prev_rtt_seq;
> 	u32	request_mptcp : 1,  /* send MP_CAPABLE */
> 		request_join : 1,   /* send MP_JOIN */
> 		request_bkup : 1,
> -- 
> 2.51.0
>
>
>
