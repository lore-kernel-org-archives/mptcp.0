Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7976A1363
	for <mptcp@lists.linux.dev>; Sat, 30 Apr 2022 00:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651277018; x=1682813018;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=YHvSdBT0JzcjBuXtnFjysOFWwj+hNFm1YwCM+pJFBZw=;
  b=Bqjyd19/3YpRTTGKj0uLFXmEcBaaDvd4p8xqIqRvd5+Em54Og7KN61ZF
   /RscKjWKhy1tsQowVNl7xOcy8Id6d9CAAPRBsw41pmq8bIkArdFZ8A/QL
   UietL4CouJIAHY1+F9LnADRVzcB0jtWdk0eT5NfG2lgHZ/aV16f0tNNcY
   7UqREOt7qe8jG7zjOP4uYE4Z3AUfDTMoEA+L2msLrLmf1Z17CdgmsZ8Is
   YNDFFM9cOOb6KSdl1LHmiftzSid8W9sUDWZzl0XuyRfhaFyM8zwZURtmC
   aDgdN5LHYIyZ5Jb8lqZhUw1eyiiTNcWPMrVUt93yDz9mZVj19JYLlvZrm
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="266350921"
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="266350921"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 17:03:38 -0700
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="630291499"
Received: from mdbellow-mobl.amr.corp.intel.com ([10.209.122.4])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 17:03:37 -0700
Date: Fri, 29 Apr 2022 17:03:37 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v17 4/8] mptcp: add get_subflow wrappers
In-Reply-To: <4244e3e9db5b34b5c7ea5809933aed847bc2d523.1651123078.git.geliang.tang@suse.com>
Message-ID: <d372729c-01b-35d3-e41-2e2db4f66bd@linux.intel.com>
References: <cover.1651123078.git.geliang.tang@suse.com> <4244e3e9db5b34b5c7ea5809933aed847bc2d523.1651123078.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 28 Apr 2022, Geliang Tang wrote:

> This patch defines two new wrappers mptcp_sched_get_send() and
> mptcp_sched_get_retrans(), invoke get_subflow() of msk->sched
> in them. Use them instead of using mptcp_subflow_get_send() or
> mptcp_subflow_get_retrans() directly.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/protocol.c | 25 ++++++-------------------
> net/mptcp/protocol.h | 42 ++++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 48 insertions(+), 19 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index f599b702415e..5243c58789a4 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1427,7 +1427,7 @@ bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
>  * returns the subflow that will transmit the next DSS
>  * additionally updates the rtx timeout
>  */
> -static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
> +struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
> {
> 	struct subflow_send_info send_info[SSK_MODE_MAX];
> 	struct mptcp_subflow_context *subflow;
> @@ -1438,14 +1438,6 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
> 	u64 linger_time;
> 	long tout = 0;
>
> -	sock_owned_by_me(sk);
> -
> -	if (__mptcp_check_fallback(msk)) {
> -		if (!msk->first)
> -			return NULL;
> -		return sk_stream_memory_free(msk->first) ? msk->first : NULL;
> -	}
> -
> 	/* re-use last subflow, if the burst allow that */
> 	if (msk->last_snd && msk->snd_burst > 0 &&
> 	    sk_stream_memory_free(msk->last_snd) &&
> @@ -1575,7 +1567,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> 			int ret = 0;
>
> 			prev_ssk = ssk;
> -			ssk = mptcp_subflow_get_send(msk);
> +			ssk = mptcp_sched_get_send(msk);
>
> 			/* First check. If the ssk has changed since
> 			 * the last round, release prev_ssk
> @@ -1644,7 +1636,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
> 			 * check for a different subflow usage only after
> 			 * spooling the first chunk of data
> 			 */
> -			xmit_ssk = first ? ssk : mptcp_subflow_get_send(mptcp_sk(sk));
> +			xmit_ssk = first ? ssk : mptcp_sched_get_send(mptcp_sk(sk));
> 			if (!xmit_ssk)
> 				goto out;
> 			if (xmit_ssk != ssk) {
> @@ -2218,17 +2210,12 @@ static void mptcp_timeout_timer(struct timer_list *t)
>  *
>  * A backup subflow is returned only if that is the only kind available.
>  */
> -static struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
> +struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
> {
> 	struct sock *backup = NULL, *pick = NULL;
> 	struct mptcp_subflow_context *subflow;
> 	int min_stale_count = INT_MAX;
>
> -	sock_owned_by_me((const struct sock *)msk);
> -
> -	if (__mptcp_check_fallback(msk))
> -		return NULL;
> -
> 	mptcp_for_each_subflow(msk, subflow) {
> 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
>
> @@ -2481,7 +2468,7 @@ static void __mptcp_retrans(struct sock *sk)
> 	mptcp_clean_una_wakeup(sk);
>
> 	/* first check ssk: need to kick "stale" logic */
> -	ssk = mptcp_subflow_get_retrans(msk);
> +	ssk = mptcp_sched_get_retrans(msk);
> 	dfrag = mptcp_rtx_head(sk);
> 	if (!dfrag) {
> 		if (mptcp_data_fin_enabled(msk)) {
> @@ -3146,7 +3133,7 @@ void __mptcp_check_push(struct sock *sk, struct sock *ssk)
> 		return;
>
> 	if (!sock_owned_by_user(sk)) {
> -		struct sock *xmit_ssk = mptcp_subflow_get_send(mptcp_sk(sk));
> +		struct sock *xmit_ssk = mptcp_sched_get_send(mptcp_sk(sk));
>
> 		if (xmit_ssk == ssk)
> 			__mptcp_subflow_push_pending(sk, ssk);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 723141a888f4..0da2a91ad197 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -988,4 +988,46 @@ mptcp_token_join_cookie_init_state(struct mptcp_subflow_request_sock *subflow_re
> static inline void mptcp_join_cookie_init(void) {}
> #endif
>
> +struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
> +struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
> +
> +static inline struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
> +{
> +	struct mptcp_sched_data data;
> +
> +	sock_owned_by_me((struct sock *)msk);
> +
> +	/* the following check is moved out of mptcp_subflow_get_send */
> +	if (__mptcp_check_fallback(msk)) {
> +		if (!msk->first)
> +			return NULL;
> +		return sk_stream_memory_free(msk->first) ? msk->first : NULL;
> +	}
> +
> +	if (!msk->sched)
> +		return mptcp_subflow_get_send(msk);
> +

I think it would be good to zero out the mptcp_sched_data here so we 
aren't passing random data to the BPF code from uninitialized stack 
memory. Probably good to create a helper function that you can use here 
and in mptcp_sched_get_retrans(), and then modify the helper when adding 
struct members in "mptcp: add subflows array in mptcp_sched_data".

- Mat

> +	msk->sched->get_subflow(msk, false, &data);
> +
> +	return data.sock;
> +}
> +
> +static inline struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk)
> +{
> +	struct mptcp_sched_data data;
> +
> +	sock_owned_by_me((const struct sock *)msk);
> +
> +	/* the following check is moved out of mptcp_subflow_get_retrans */
> +	if (__mptcp_check_fallback(msk))
> +		return NULL;
> +
> +	if (!msk->sched)
> +		return mptcp_subflow_get_retrans(msk);
> +
> +	msk->sched->get_subflow(msk, true, &data);
> +
> +	return data.sock;
> +}
> +
> #endif /* __MPTCP_PROTOCOL_H */
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
