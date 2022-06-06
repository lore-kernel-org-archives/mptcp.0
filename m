Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247DB4C63
	for <mptcp@lists.linux.dev>; Mon,  6 Jun 2022 23:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654559113; x=1686095113;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=eByEkUNd1Jjea6neXZ7FtCa3b1oawZTuaVXLTjjY2so=;
  b=bu2WvgmYlzKGZxXLwXZHjV/XCmt+AyuEYnOkQyjEWlHnR1LWor8Ak50h
   x5K8qcQYqUDatiEts9hqynSH2IheUx7QT3aPcS9ZYk6cr4HJLs/XDrOmf
   WsX1fUxj4qMiHHW+vZ8cVx6UB7Tq1uhAPW1uWPcg36eONO2mxlxNHJKhp
   Ckb1jAvYkhBlNCCkVcHTCz3a7egE+fz9k+YTunIfu6KoB/92sADve3Ayz
   CgPJgdY8CwCFj0kdQA6rWsT83lCZ6atsC3dpO8yEM9Gjx+n7desgME7Nc
   xNxB2dsOFEEDsEDMioM3V9fqSVu8vbG1/sq+5EyipQUhyv0D3y4yo3NKT
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="337851845"
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="337851845"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 16:45:12 -0700
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="608959917"
Received: from mgudaram-mobl1.amr.corp.intel.com ([10.209.43.78])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 16:45:12 -0700
Date: Mon, 6 Jun 2022 16:45:12 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v5 1/7] Squash to "mptcp: add get_subflow
 wrappers"
In-Reply-To: <ab89a19923717d2b6b65619e7bcc96b63261aa19.1654526068.git.geliang.tang@suse.com>
Message-ID: <4e7b3a93-237f-91cb-86a2-76d86dcbb47b@linux.intel.com>
References: <cover.1654526068.git.geliang.tang@suse.com> <ab89a19923717d2b6b65619e7bcc96b63261aa19.1654526068.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 6 Jun 2022, Geliang Tang wrote:

> '''
> mptcp: add sched_get_send wrapper
>
> This patch defines a wrapper named mptcp_sched_get_send(), invoke
> mptcp_subflow_get_send() or get_subflow() of msk->sched in it.
>
> Set the subflow pointers array in struct mptcp_sched_data before invoking
> get_subflow(), then it can be used in get_subflow() in the BPF contexts.
>
> Move sock_owned_by_me() and the fallback check code from
> mptcp_subflow_get_send() into this wrapper.
> '''
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/protocol.c | 15 +++++++----
> net/mptcp/protocol.h |  4 +--
> net/mptcp/sched.c    | 60 ++++++++++++--------------------------------
> 3 files changed, 27 insertions(+), 52 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index d6aef4b13b8a..8d93df73a9e3 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1567,7 +1567,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> 			int ret = 0;
>
> 			prev_ssk = ssk;
> -			ssk = mptcp_sched_get_send(msk);
> +			ssk = mptcp_subflow_get_send(msk);
>
> 			/* First check. If the ssk has changed since
> 			 * the last round, release prev_ssk
> @@ -1634,7 +1634,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
> 			 * check for a different subflow usage only after
> 			 * spooling the first chunk of data
> 			 */
> -			xmit_ssk = first ? ssk : mptcp_sched_get_send(mptcp_sk(sk));
> +			xmit_ssk = first ? ssk : mptcp_subflow_get_send(mptcp_sk(sk));
> 			if (!xmit_ssk)
> 				goto out;
> 			if (xmit_ssk != ssk) {
> @@ -2195,12 +2195,17 @@ static void mptcp_timeout_timer(struct timer_list *t)
>  *
>  * A backup subflow is returned only if that is the only kind available.
>  */
> -struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
> +static struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
> {
> 	struct sock *backup = NULL, *pick = NULL;
> 	struct mptcp_subflow_context *subflow;
> 	int min_stale_count = INT_MAX;
>
> +	sock_owned_by_me((const struct sock *)msk);
> +
> +	if (__mptcp_check_fallback(msk))
> +		return NULL;
> +
> 	mptcp_for_each_subflow(msk, subflow) {
> 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
>
> @@ -2453,7 +2458,7 @@ static void __mptcp_retrans(struct sock *sk)
> 	mptcp_clean_una_wakeup(sk);
>
> 	/* first check ssk: need to kick "stale" logic */
> -	ssk = mptcp_sched_get_retrans(msk);
> +	ssk = mptcp_subflow_get_retrans(msk);
> 	dfrag = mptcp_rtx_head(sk);
> 	if (!dfrag) {
> 		if (mptcp_data_fin_enabled(msk)) {
> @@ -3107,7 +3112,7 @@ void __mptcp_check_push(struct sock *sk, struct sock *ssk)
> 		return;
>
> 	if (!sock_owned_by_user(sk)) {
> -		struct sock *xmit_ssk = mptcp_sched_get_send(mptcp_sk(sk));
> +		struct sock *xmit_ssk = mptcp_subflow_get_send(mptcp_sk(sk));
>
> 		if (xmit_ssk == ssk)
> 			__mptcp_subflow_push_pending(sk, ssk);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index d406b5afbee4..0fb2970a7a2d 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -632,9 +632,7 @@ void mptcp_release_sched(struct mptcp_sock *msk);
> void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
> 				 bool scheduled);
> struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
> -struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
> -struct sock *mptcp_sched_get_send(struct mptcp_sock *msk);
> -struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk);
> +struct sock *mptcp_sched_get_send(struct mptcp_sock *msk, int *err);
>
> static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *subflow)
> {
> diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
> index 8858e1fc8b74..a0585182a2b1 100644
> --- a/net/mptcp/sched.c
> +++ b/net/mptcp/sched.c
> @@ -117,63 +117,35 @@ static int mptcp_sched_data_init(struct mptcp_sock *msk, bool reinject,
> 	return 0;
> }
>
> -struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
> +struct sock *mptcp_sched_get_send(struct mptcp_sock *msk, int *err)
> {
> 	struct mptcp_sched_data data;
> 	struct sock *ssk = NULL;
> -	int i;
>
> +	*err = -EINVAL;
> 	sock_owned_by_me((struct sock *)msk);
>
> 	/* the following check is moved out of mptcp_subflow_get_send */
> 	if (__mptcp_check_fallback(msk)) {
> -		if (!msk->first)
> -			return NULL;
> -		return sk_stream_memory_free(msk->first) ? msk->first : NULL;
> -	}
> -
> -	if (!msk->sched)
> -		return mptcp_subflow_get_send(msk);
> -
> -	mptcp_sched_data_init(msk, false, &data);
> -	msk->sched->get_subflow(msk, &data);
> -
> -	for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
> -		if (data.contexts[i] && READ_ONCE(data.contexts[i]->scheduled)) {
> -			ssk = data.contexts[i]->tcp_sock;
> -			msk->last_snd = ssk;
> -			break;
> +		if (msk->first && sk_stream_memory_free(msk->first)) {
> +			mptcp_subflow_set_scheduled(mptcp_subflow_ctx(msk->first), true);
> +			*err = 0;
> +			return msk->first;
> 		}
> -	}
> -
> -	return ssk;
> -}
> -
> -struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk)
> -{
> -	struct mptcp_sched_data data;
> -	struct sock *ssk = NULL;
> -	int i;
> -
> -	sock_owned_by_me((const struct sock *)msk);
> -
> -	/* the following check is moved out of mptcp_subflow_get_retrans */
> -	if (__mptcp_check_fallback(msk))
> 		return NULL;
> +	}
>
> -	if (!msk->sched)
> -		return mptcp_subflow_get_retrans(msk);
> +	if (!msk->sched) {
> +		ssk = mptcp_subflow_get_send(msk);
> +		if (!ssk)
> +			return NULL;
> +		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
> +		*err = 0;
> +		return ssk;
> +	}
>
> -	mptcp_sched_data_init(msk, true, &data);
> +	mptcp_sched_data_init(msk, false, &data);
> 	msk->sched->get_subflow(msk, &data);

Need to add *err = 0 here.

>
> -	for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
> -		if (data.contexts[i] && READ_ONCE(data.contexts[i]->scheduled)) {
> -			ssk = data.contexts[i]->tcp_sock;
> -			msk->last_snd = ssk;
> -			break;
> -		}
> -	}
> -
> 	return ssk;
> }
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
