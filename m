Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C462C81
	for <mptcp@lists.linux.dev>; Sat, 23 Oct 2021 01:19:48 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10145"; a="292885649"
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="292885649"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 18:19:47 -0700
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="535293520"
Received: from gmonroy-mobl3.amr.corp.intel.com ([10.254.64.84])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 18:19:46 -0700
Date: Fri, 22 Oct 2021 18:19:44 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-next] mptcp: enforce HoL-blocking estimation
In-Reply-To: <22cda018a37459d99683e572e35ac61bbc43fcae.1634900440.git.pabeni@redhat.com>
Message-ID: <6e3468c2-8e61-a05b-8cd1-4656e9217fcc@linux.intel.com>
References: <22cda018a37459d99683e572e35ac61bbc43fcae.1634900440.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 22 Oct 2021, Paolo Abeni wrote:

> The MPTCP packet scheduler has sub-optimal behavior with asymmetric
> subflows: if the faster subflow-level cwin is closed, the packet
> scheduler can enqueue "too much" data on a slower subflow.
>
> When all the data on the faster subflow is acked, if the mptcp-level
> cwin is closed, and link utilization becomes suboptimal.
>
> The solution is implementing blest-like[1] HoL-blocking estimation,
> transmitting only on the subflow with the shorter estimated time to
> flush the queued memory. If such subflows cwin is closed, we wait
> even if other subflows are available.
>
> This is quite simpler than the original blest implementation, as we
> leverage the pacing rate provided by the TCP socket. To get a more
> accurate estimation for the subflow linger-time, we maintain a
> per-subflow weighted average of such info.
>
> Additionally drop magic numbers usage in favor of newly defined
> macros.
>
> [1] http://dl.ifip.org/db/conf/networking/networking2016/1570234725.pdf
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> notes:
> - this apparently solves for good issue/137, with > 200 iterations with
> no failures
> - still to be investigated the impact on high-speed links, if any
> ---
> net/mptcp/protocol.c | 58 ++++++++++++++++++++++++++++++--------------
> net/mptcp/protocol.h |  1 +
> 2 files changed, 41 insertions(+), 18 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 7803b0dbb1be..cc9d32cb7bc7 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1395,20 +1395,24 @@ bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
> 	return __mptcp_subflow_active(subflow);
> }
>
> +#define SSK_MODE_ACTIVE	0
> +#define SSK_MODE_BACKUP	1
> +#define SSK_MODE_MAX	2
> +
> /* implement the mptcp packet scheduler;
>  * returns the subflow that will transmit the next DSS
>  * additionally updates the rtx timeout
>  */
> static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
> {
> -	struct subflow_send_info send_info[2];
> +	struct subflow_send_info send_info[SSK_MODE_MAX];
> 	struct mptcp_subflow_context *subflow;
> 	struct sock *sk = (struct sock *)msk;
> +	u32 pace, burst, wmem;
> 	int i, nr_active = 0;
> 	struct sock *ssk;
> 	long tout = 0;
> 	u64 ratio;
> -	u32 pace;
>
> 	sock_owned_by_me(sk);
>
> @@ -1427,10 +1431,11 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
> 	}
>
> 	/* pick the subflow with the lower wmem/wspace ratio */
> -	for (i = 0; i < 2; ++i) {
> +	for (i = 0; i < SSK_MODE_MAX; ++i) {
> 		send_info[i].ssk = NULL;
> 		send_info[i].ratio = -1;
> 	}
> +
> 	mptcp_for_each_subflow(msk, subflow) {
> 		trace_mptcp_subflow_get_send(subflow);
> 		ssk =  mptcp_subflow_tcp_sock(subflow);
> @@ -1439,12 +1444,13 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
>
> 		tout = max(tout, mptcp_timeout_from_subflow(subflow));
> 		nr_active += !subflow->backup;
> -		if (!sk_stream_memory_free(subflow->tcp_sock) || !tcp_sk(ssk)->snd_wnd)
> -			continue;
> -
> -		pace = READ_ONCE(ssk->sk_pacing_rate);
> -		if (!pace)
> -			continue;
> +		pace = subflow->avg_pacing_rate;
> +		if (unlikely(!pace)) {
> +			/* init pacing rate from socket */
> +			pace = subflow->avg_pacing_rate = READ_ONCE(ssk->sk_pacing_rate);

Checkpatch complains about the double assignment. I did do a double-take 
to confirm that it didn't look like a '==' typo, and slightly lean toward 
keeping it checkpatch-clean.

> +			if (!pace)
> +				continue;
> +		}
>
> 		ratio = div_u64((u64)READ_ONCE(ssk->sk_wmem_queued) << 32,
> 				pace);
> @@ -1457,16 +1463,32 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
>
> 	/* pick the best backup if no other subflow is active */
> 	if (!nr_active)
> -		send_info[0].ssk = send_info[1].ssk;
> -
> -	if (send_info[0].ssk) {
> -		msk->last_snd = send_info[0].ssk;
> -		msk->snd_burst = min_t(int, MPTCP_SEND_BURST_SIZE,
> -				       tcp_sk(msk->last_snd)->snd_wnd);
> -		return msk->last_snd;
> -	}
> +		send_info[SSK_MODE_ACTIVE].ssk = send_info[SSK_MODE_BACKUP].ssk;
> +
> +	/* According to the blest algorithm, to avoid HoL blocking for the
> +	 * faster flow, we need to:
> +	 * - estimate the faster flow linger time
> +	 * - use the above to estimate the amount of byte transferred
> +	 *   by the faster flow
> +	 * - check that the amount of queued data is greter than the above,
> +	 *   otherwise do not use the picked, slower, subflow
> +	 * We select the subflow with the shorter estimated time to flush
> +	 * the queued mem, which basically ensure the above. We just need
> +	 * to check that subflow has a non empty cwin.
> +	 */
> +	ssk = send_info[SSK_MODE_ACTIVE].ssk;
> +	if (!ssk || !sk_stream_memory_free(ssk) || !tcp_sk(ssk)->snd_wnd)
> +		return NULL;
>
> -	return NULL;
> +	burst = min_t(int, MPTCP_SEND_BURST_SIZE, tcp_sk(ssk)->snd_wnd);
> +	wmem = READ_ONCE(ssk->sk_wmem_queued);
> +	subflow = mptcp_subflow_ctx(ssk);
> +	subflow->avg_pacing_rate = div_u64((u64)subflow->avg_pacing_rate * wmem +
> +					   READ_ONCE(ssk->sk_pacing_rate) * burst,
> +					   burst + wmem);

I see how this gives a smoothed-out version of the pacing rate, using 
avg_pacing_rate for the bytes already sent on this subflow (wmem) and 
ssk->sk_pacing_rate for the bytes that will probably be sent now.

Is this a *better* estimation of the flow speed than the plain 
ssk->sk_pacing_rate? If there is a change in speed, it will be slow to 
respond to throughput changes. I think you could remove avg_pacing_rate 
modifications and include the expected burst length in the calculation 
earlier (in the mptcp_for_each_subflow() loop) to implement the blest-like 
behavior. Maybe rename subflow_send_info.ratio to 
subflow_send_info.time_to_flush.

What do you think?

> + msk->last_snd = ssk; + msk->snd_burst = burst; + return ssk; }
>
> static void mptcp_push_release(struct sock *ssk, struct mptcp_sendmsg_info *info)
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 67a61ac48b20..46691acdea24 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -391,6 +391,7 @@ DECLARE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
> /* MPTCP subflow context */
> struct mptcp_subflow_context {
> 	struct	list_head node;/* conn_list of subflows */
> +	unsigned long avg_pacing_rate; /* protected by msk socket lock */
> 	u64	local_key;
> 	u64	remote_key;
> 	u64	idsn;
> -- 
> 2.26.3
>
>
>

--
Mat Martineau
Intel
