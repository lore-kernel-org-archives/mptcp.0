Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC67E372
	for <mptcp@lists.linux.dev>; Fri, 11 Nov 2022 01:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668128677; x=1699664677;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=uWjJaFjTfLedeDwcMzvEJH9VWbG2Gyts0RfkcH8gTLI=;
  b=QabJPjcC7/hrPs05ofiCLHqCLMxKehK2ia48W+4iVM39PzXYEfOuQP8h
   ymmEE4QLaeljZZCAxvGPRiRiHZHok9Ut/K5vB4RU1WvL5XZGayECT8oXX
   8kYVhgeCQwxfWiH6oIjmjj8sHeUjg6uZZW7rgE8/yybSurGZW8vb7GUz0
   eXpp8vpVJ2bNfhvzxyPXGEa4Z3qSQJZI9R0rKX5vGoKM4GcKnqgRBo5YI
   bDUEHSeVCETD6DNlfuYp1knx+8fEvaBOC0y6n/lYbPExcSIlJ5RB5qz4L
   6pg/RMQugROP8LwE02UaulSyiDrtoht6eu4nowjT/Bx8eDel0+g9u7SJj
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="373615899"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="373615899"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 17:04:35 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="762493940"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="762493940"
Received: from ssamaraj-mobl1.amr.corp.intel.com ([10.209.53.250])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 17:04:35 -0800
Date: Thu, 10 Nov 2022 17:04:35 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v18 10/15] mptcp: use get_send wrapper
In-Reply-To: <262f6ec0dfa2ffba15899460df4676dc15d1bd62.1667897099.git.geliang.tang@suse.com>
Message-ID: <d0e481ed-3ce1-7eaf-b6bd-1cc4e00f05eb@linux.intel.com>
References: <cover.1667897099.git.geliang.tang@suse.com> <262f6ec0dfa2ffba15899460df4676dc15d1bd62.1667897099.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 8 Nov 2022, Geliang Tang wrote:

> This patch defines the packet scheduler wrapper mptcp_sched_get_send(),
> invoke data_init() and get_subflow() of msk->sched in it.
>
> Set data->reinject to false in mptcp_sched_get_send(). If msk->sched is
> NULL, use default functions mptcp_subflow_get_send() to send data.
>
> Move sock_owned_by_me() check and fallback check into the wrapper from
> mptcp_subflow_get_send().
>
> Add the multiple subflows support for __mptcp_push_pending() and
> __mptcp_subflow_push_pending(). Use get_send() wrapper instead of
> mptcp_subflow_get_send() in them.
>
> Check the subflow scheduled flags to test which subflow or subflows are
> picked by the scheduler, use them to send data.
>
> This commit allows the scheduler to set the subflow->scheduled bit in
> multiple subflows, but it does not allow for sending redundant data.
> Multiple scheduled subflows will send sequential data on each subflow.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/protocol.c | 131 ++++++++++++++++++++++++++++---------------
> net/mptcp/protocol.h |   2 +
> net/mptcp/sched.c    |  37 ++++++++++++
> 3 files changed, 124 insertions(+), 46 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index d7aaa49c64f4..5bcadb36b99b 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1406,7 +1406,7 @@ bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
>  * returns the subflow that will transmit the next DSS
>  * additionally updates the rtx timeout
>  */
> -static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
> +struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
> {
> 	struct subflow_send_info send_info[SSK_MODE_MAX];
> 	struct mptcp_subflow_context *subflow;
> @@ -1417,15 +1417,6 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
> 	u64 linger_time;
> 	long tout = 0;
>
> -	sock_owned_by_me(sk);
> -
> -	if (__mptcp_check_fallback(msk)) {
> -		if (!msk->first)
> -			return NULL;
> -		return __tcp_can_send(msk->first) &&
> -		       sk_stream_memory_free(msk->first) ? msk->first : NULL;
> -	}
> -
> 	/* pick the subflow with the lower wmem/wspace ratio */
> 	for (i = 0; i < SSK_MODE_MAX; ++i) {
> 		send_info[i].ssk = NULL;
> @@ -1577,42 +1568,58 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> 	};
> 	bool do_check_data_fin = false;
>
> +again:
> 	while (mptcp_send_head(sk)) {
> +		struct mptcp_subflow_context *subflow, *last = NULL;
> 		int ret = 0;
>
> -		prev_ssk = ssk;
> -		ssk = mptcp_subflow_get_send(msk);
> -
> -		/* First check. If the ssk has changed since
> -		 * the last round, release prev_ssk
> -		 */
> -		if (ssk != prev_ssk && prev_ssk)
> -			mptcp_push_release(prev_ssk, &info);
> -		if (!ssk)
> +		if (mptcp_sched_get_send(msk))
> 			goto out;
>
> -		/* Need to lock the new subflow only if different
> -		 * from the previous one, otherwise we are still
> -		 * helding the relevant lock
> -		 */
> -		if (ssk != prev_ssk)
> -			lock_sock(ssk);
> +		mptcp_for_each_subflow(msk, subflow) {
> +			if (READ_ONCE(subflow->scheduled))
> +				last = subflow;
> +		}

Since mptcp_sched_get_send() is always called right before this, the 
subflow->scheduled flags will always be set. Does the new code with 'last' 
work as expected if the mptcp_sched_get_send() call is skipped when an 
existing subflow->scheduled flag is found? That way the old flags will be 
used the first time through this loop.

- Mat

>
> -		ret = __subflow_push_pending(sk, ssk, &info);
> -		if (ret <= 0) {
> -			if (ret == -EAGAIN)
> -				continue;
> -			mptcp_push_release(ssk, &info);
> -			goto out;
> +		mptcp_for_each_subflow(msk, subflow) {
> +			if (READ_ONCE(subflow->scheduled)) {
> +				prev_ssk = ssk;
> +				ssk = mptcp_subflow_tcp_sock(subflow);
> +
> +				/* First check. If the ssk has changed since
> +				 * the last round, release prev_ssk
> +				 */
> +				if (ssk != prev_ssk && prev_ssk)
> +					mptcp_push_release(prev_ssk, &info);
> +
> +				/* Need to lock the new subflow only if different
> +				 * from the previous one, otherwise we are still
> +				 * helding the relevant lock
> +				 */
> +				if (ssk != prev_ssk)
> +					lock_sock(ssk);
> +
> +				ret = __subflow_push_pending(sk, ssk, &info);
> +				if (ret <= 0) {
> +					if (ret == -EAGAIN &&
> +					    inet_sk_state_load(ssk) != TCP_CLOSE)
> +						goto again;
> +					if (last && subflow != last)
> +						continue;
> +					goto out;
> +				}
> +				do_check_data_fin = true;
> +				msk->last_snd = ssk;
> +				mptcp_subflow_set_scheduled(subflow, false);
> +			}
> 		}
> -		do_check_data_fin = true;
> 	}
>
> +out:
> 	/* at this point we held the socket lock for the last subflow we used */
> 	if (ssk)
> 		mptcp_push_release(ssk, &info);
>
> -out:
> 	/* ensure the rtx timer is running */
> 	if (!mptcp_timer_pending(sk))
> 		mptcp_reset_timer(sk);
> @@ -1626,29 +1633,61 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
> 	struct mptcp_sendmsg_info info = {
> 		.data_lock_held = true,
> 	};
> -	struct sock *xmit_ssk;
> 	int ret = 0;
>
> 	info.flags = 0;
> +again:
> 	while (mptcp_send_head(sk)) {
> +		struct mptcp_subflow_context *subflow, *last = NULL;
> +
> 		/* check for a different subflow usage only after
> 		 * spooling the first chunk of data
> 		 */
> -		xmit_ssk = first ? ssk : mptcp_subflow_get_send(msk);
> -		if (!xmit_ssk)
> -			goto out;
> -		if (xmit_ssk != ssk) {
> -			mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk),
> -					       MPTCP_DELEGATE_SEND);
> +		if (first) {
> +			ret = __subflow_push_pending(sk, ssk, &info);
> +			first = false;
> +			if (ret <= 0) {
> +				if (ret == -EAGAIN &&
> +				    inet_sk_state_load(ssk) != TCP_CLOSE)
> +					goto again;
> +				break;
> +			}
> +			msk->last_snd = ssk;
> +			continue;
> +		}
> +
> +		if (mptcp_sched_get_send(msk))
> 			goto out;
> +
> +		mptcp_for_each_subflow(msk, subflow) {
> +			if (READ_ONCE(subflow->scheduled))
> +				last = subflow;
> 		}
>
> -		ret = __subflow_push_pending(sk, ssk, &info);
> -		first = false;
> -		if (ret <= 0) {
> -			if (ret == -EAGAIN)
> -				continue;
> -			break;
> +		mptcp_for_each_subflow(msk, subflow) {
> +			if (READ_ONCE(subflow->scheduled)) {
> +				struct sock *xmit_ssk = mptcp_subflow_tcp_sock(subflow);
> +
> +				if (xmit_ssk != ssk) {
> +					mptcp_subflow_delegate(subflow,
> +							       MPTCP_DELEGATE_SEND);
> +					msk->last_snd = ssk;
> +					mptcp_subflow_set_scheduled(subflow, false);
> +					goto out;
> +				}
> +
> +				ret = __subflow_push_pending(sk, ssk, &info);
> +				if (ret <= 0) {
> +					if (ret == -EAGAIN &&
> +					    inet_sk_state_load(ssk) != TCP_CLOSE)
> +						goto again;
> +					if (last && subflow != last)
> +						continue;
> +					goto out;
> +				}
> +				msk->last_snd = ssk;
> +				mptcp_subflow_set_scheduled(subflow, false);
> +			}
> 		}
> 	}
>
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index e93d64217896..2bc0acf2d659 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -640,6 +640,8 @@ int mptcp_init_sched(struct mptcp_sock *msk,
> void mptcp_release_sched(struct mptcp_sock *msk);
> void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
> 				 bool scheduled);
> +struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
> +int mptcp_sched_get_send(struct mptcp_sock *msk);
>
> static inline bool __tcp_can_send(const struct sock *ssk)
> {
> diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
> index 0d7c73e9562e..bc5d82300863 100644
> --- a/net/mptcp/sched.c
> +++ b/net/mptcp/sched.c
> @@ -112,3 +112,40 @@ void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
> 	for (; i < MPTCP_SUBFLOWS_MAX; i++)
> 		data->contexts[i] = NULL;
> }
> +
> +int mptcp_sched_get_send(struct mptcp_sock *msk)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	struct mptcp_sched_data data;
> +	struct sock *ssk = NULL;
> +
> +	sock_owned_by_me((const struct sock *)msk);
> +
> +	mptcp_for_each_subflow(msk, subflow) {
> +		if (READ_ONCE(subflow->scheduled))
> +			return 0;
> +	}
> +
> +	/* the following check is moved out of mptcp_subflow_get_send */
> +	if (__mptcp_check_fallback(msk)) {
> +		if (msk->first &&
> +		    __tcp_can_send(msk->first) &&
> +		    sk_stream_memory_free(msk->first)) {
> +			mptcp_subflow_set_scheduled(mptcp_subflow_ctx(msk->first), true);
> +			return 0;
> +		}
> +		return -EINVAL;
> +	}
> +
> +	if (!msk->sched) {
> +		ssk = mptcp_subflow_get_send(msk);
> +		if (!ssk)
> +			return -EINVAL;
> +		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
> +		return 0;
> +	}
> +
> +	data.reinject = false;
> +	msk->sched->data_init(msk, &data);
> +	return msk->sched->get_subflow(msk, &data);
> +}
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
