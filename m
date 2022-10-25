Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5042B7479
	for <mptcp@lists.linux.dev>; Tue, 25 Oct 2022 16:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666716953; x=1698252953;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=rpwMIaLLOhCA8EO+KDi//bbUa4W8ZSinqcLDFSkmius=;
  b=SBkZynX719v1+HxAIGM5jDlA+GZGWr2ze5WXbMrEn0iTOdlfsgFnPIMU
   gDienr0rkGg46U25rkUYSXaxI1K4i0ZWdZ0m/OUw/N6VcjYOgGzzs42pz
   gQlDtn1OdBt/qukwINymthDQ4x8vowGHPFDqfNz62+M/2KZmDdSKrG1ME
   rrsB9EPEmFMfDlGXHJiu/6NR3lfS9FIhzfoixm4DiGQ3wMm7cZdyDCvlF
   kOX0FC6RYasXXvoZw40+SRViifp5XNeJ10JlgusSxM81J2HzPsW4MxHzS
   Q69D8xsXfb7mrwv/OSyhhi0XehCwTZbukFFbfW1aKFJ8i8o8oRRaeu1YU
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="394045953"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="394045953"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 09:55:52 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="662875911"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="662875911"
Received: from snijjar-mobl.amr.corp.intel.com ([10.251.5.252])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 09:55:52 -0700
Date: Tue, 25 Oct 2022 09:55:52 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2] Revert "mptcp: add get_subflow wrappers"
 - fix divide error in mptcp_subflow_get_send
In-Reply-To: <95f77f38e54f9564608e844f507701c04745475b.1666668425.git.geliang.tang@suse.com>
Message-ID: <9b40e76e-c0da-6369-3ce7-92ab35c742bd@linux.intel.com>
References: <95f77f38e54f9564608e844f507701c04745475b.1666668425.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 25 Oct 2022, Geliang Tang wrote:

> This reverts commit 8ae8437eb930b887219dc50b159322f6f9331bfb.
>

Yeah, this seems like the best thing to do for now. Thanks!

(Not marked as RvB since the patch will be dropped from topgit rather than 
adding a revert commit. Marked as "queued" in patchwork.)

- Mat

> The wrapper mptcp_sched_get_send() will be added in the later patch
> "mptcp: use get_send wrapper", and the wrapper mptcp_sched_get_retrans()
> will be added in the later patch "mptcp: use get_retrans wrapper".
>
> Fix this divide error:
>
> ----
> divide error: 0000 [#1] PREEMPT SMP KASAN NOPTI
> CPU: 0 PID: 14336 Comm: syz-executor.6 Not tainted 6.1.0-rc1-00215-g47aa7f23f440 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> RIP: 0010:div_u64_rem include/linux/math64.h:29 [inline]
> RIP: 0010:div_u64 include/linux/math64.h:128 [inline]
> RIP: 0010:mptcp_subflow_get_send+0xa87/0x1200 net/mptcp/protocol.c:1486
> ----
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/314
> Reported-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/protocol.c | 18 ++++++++--
> net/mptcp/protocol.h |  4 ---
> net/mptcp/sched.c    | 82 --------------------------------------------
> 3 files changed, 16 insertions(+), 88 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 2419d7be542b..3cf44b5ef937 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1406,7 +1406,7 @@ bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
>  * returns the subflow that will transmit the next DSS
>  * additionally updates the rtx timeout
>  */
> -struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
> +static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
> {
> 	struct subflow_send_info send_info[SSK_MODE_MAX];
> 	struct mptcp_subflow_context *subflow;
> @@ -1417,6 +1417,15 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
> 	u64 linger_time;
> 	long tout = 0;
>
> +	sock_owned_by_me(sk);
> +
> +	if (__mptcp_check_fallback(msk)) {
> +		if (!msk->first)
> +			return NULL;
> +		return __tcp_can_send(msk->first) &&
> +		       sk_stream_memory_free(msk->first) ? msk->first : NULL;
> +	}
> +
> 	/* re-use last subflow, if the burst allow that */
> 	if (msk->last_snd && msk->snd_burst > 0 &&
> 	    sk_stream_memory_free(msk->last_snd) &&
> @@ -2210,12 +2219,17 @@ static void mptcp_timeout_timer(struct timer_list *t)
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
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 8f48f881adf8..270c187c9001 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -641,10 +641,6 @@ int mptcp_init_sched(struct mptcp_sock *msk,
> void mptcp_release_sched(struct mptcp_sock *msk);
> void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
> 				 bool scheduled);
> -struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
> -struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
> -int mptcp_sched_get_send(struct mptcp_sock *msk);
> -int mptcp_sched_get_retrans(struct mptcp_sock *msk);
>
> static inline bool __tcp_can_send(const struct sock *ssk)
> {
> diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
> index 9b128714055a..d295b92a5789 100644
> --- a/net/mptcp/sched.c
> +++ b/net/mptcp/sched.c
> @@ -93,85 +93,3 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
> {
> 	WRITE_ONCE(subflow->scheduled, scheduled);
> }
> -
> -static int mptcp_sched_data_init(struct mptcp_sock *msk, bool reinject,
> -				 struct mptcp_sched_data *data)
> -{
> -	struct mptcp_subflow_context *subflow;
> -	int i = 0;
> -
> -	data->reinject = reinject;
> -
> -	mptcp_for_each_subflow(msk, subflow) {
> -		if (i == MPTCP_SUBFLOWS_MAX) {
> -			pr_warn_once("too many subflows");
> -			break;
> -		}
> -		mptcp_subflow_set_scheduled(subflow, false);
> -		data->contexts[i++] = subflow;
> -	}
> -
> -	for (; i < MPTCP_SUBFLOWS_MAX; i++)
> -		data->contexts[i] = NULL;
> -
> -	msk->snd_burst = 0;
> -
> -	return 0;
> -}
> -
> -int mptcp_sched_get_send(struct mptcp_sock *msk)
> -{
> -	struct mptcp_sched_data data;
> -	struct sock *ssk = NULL;
> -
> -	sock_owned_by_me((const struct sock *)msk);
> -
> -	/* the following check is moved out of mptcp_subflow_get_send */
> -	if (__mptcp_check_fallback(msk)) {
> -		if (msk->first &&
> -		    __tcp_can_send(msk->first) &&
> -		    sk_stream_memory_free(msk->first)) {
> -			mptcp_subflow_set_scheduled(mptcp_subflow_ctx(msk->first), true);
> -			return 0;
> -		}
> -		return -EINVAL;
> -	}
> -
> -	if (!msk->sched) {
> -		ssk = mptcp_subflow_get_send(msk);
> -		if (!ssk)
> -			return -EINVAL;
> -		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
> -		return 0;
> -	}
> -
> -	mptcp_sched_data_init(msk, false, &data);
> -	msk->sched->get_subflow(msk, &data);
> -
> -	return 0;
> -}
> -
> -int mptcp_sched_get_retrans(struct mptcp_sock *msk)
> -{
> -	struct mptcp_sched_data data;
> -	struct sock *ssk = NULL;
> -
> -	sock_owned_by_me((const struct sock *)msk);
> -
> -	/* the following check is moved out of mptcp_subflow_get_retrans */
> -	if (__mptcp_check_fallback(msk))
> -		return -EINVAL;
> -
> -	if (!msk->sched) {
> -		ssk = mptcp_subflow_get_retrans(msk);
> -		if (!ssk)
> -			return -EINVAL;
> -		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
> -		return 0;
> -	}
> -
> -	mptcp_sched_data_init(msk, true, &data);
> -	msk->sched->get_subflow(msk, &data);
> -
> -	return 0;
> -}
> -- 
> 2.35.3
>
>

--
Mat Martineau
Intel
