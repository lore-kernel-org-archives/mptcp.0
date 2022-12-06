Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1182517C3
	for <mptcp@lists.linux.dev>; Tue,  6 Dec 2022 01:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670288974; x=1701824974;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=dPiwIu0YbN+RCTh7+JKG78lG/gJ/IsAI5UhG1g6h0q8=;
  b=d8nWFAvZeLECCAXrUOlqaBG8lzh0Xy5oPsFKCC7Yhj6ifRM0fuy5XQYX
   VYwjBZUmWS8XdDj3gCiESn4Vdt1GYGH+NE9Xcee3kUjwVetn8DPwv1U6N
   2QcEdHw4tFJhHrJh0PLVarPRoh2A5Rrv3jEY1GzBWNQ1jP+hZ/bsjqrbY
   v7m0PXgCAYiz2UlDq08pyQ3lA0BxcF4JO0oBt7u6C2F9+P/KLEqAakJ7m
   JFfGsdyK1dmVixdY/Z72wYI15RgjgUMu66tOVKFTStRG2/u7tG/9j0fEp
   d54Ye+HCog+A+b9J8BX/Rf+BtKDXpjb1DlfKvdtC+s1VBF4k+9bx1X+qy
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="304124577"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="304124577"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 17:09:33 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="788294765"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="788294765"
Received: from psjohns1-mobl.amr.corp.intel.com ([10.209.67.116])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 17:09:32 -0800
Date: Mon, 5 Dec 2022 17:09:32 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v22 2/5] mptcp: use get_send wrapper
In-Reply-To: <052d8257378ae7fae5e913f2c3a4007eaef1a856.1669987293.git.geliang.tang@suse.com>
Message-ID: <c3ced640-9520-3dac-8888-daa8f54576ec@linux.intel.com>
References: <cover.1669987293.git.geliang.tang@suse.com> <052d8257378ae7fae5e913f2c3a4007eaef1a856.1669987293.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 2 Dec 2022, Geliang Tang wrote:

> This patch adds the multiple subflows support for __mptcp_push_pending
> and __mptcp_subflow_push_pending. Use get_send() wrapper instead of
> mptcp_subflow_get_send() in them.
>
> Check the subflow scheduled flags to test which subflow or subflows are
> picked by the scheduler, use them to send data.
>
> Move sock_owned_by_me() check and fallback check into get_send() wrapper
> from mptcp_subflow_get_send().
>
> This commit allows the scheduler to set the subflow->scheduled bit in
> multiple subflows, but it does not allow for sending redundant data.
> Multiple scheduled subflows will send sequential data on each subflow.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/protocol.c | 129 +++++++++++++++++++++++++++----------------
> net/mptcp/sched.c    |  13 +++++
> 2 files changed, 95 insertions(+), 47 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index d8ad68dd504a..cef6086c7f40 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1408,15 +1408,6 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
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
> @@ -1563,47 +1554,61 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> {
> 	struct sock *prev_ssk = NULL, *ssk = NULL;
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct mptcp_subflow_context *subflow;
> 	struct mptcp_sendmsg_info info = {
> 				.flags = flags,
> 	};
> 	bool do_check_data_fin = false;
> +	int push_count = 1;
>
> -	while (mptcp_send_head(sk)) {
> +	while (mptcp_send_head(sk) && (push_count > 0)) {

Hi Geliang -

Thanks, this is the correct logic (I had a typo in my suggested code for 
this).

> 		int ret = 0;
>
> -		prev_ssk = ssk;
> -		ssk = mptcp_subflow_get_send(msk);
> +		if (mptcp_sched_get_send(msk))
> +			break;
>
> -		/* First check. If the ssk has changed since
> -		 * the last round, release prev_ssk
> -		 */
> -		if (ssk != prev_ssk && prev_ssk)
> -			mptcp_push_release(prev_ssk, &info);
> -		if (!ssk)
> -			goto out;
> +		push_count = 0;
>
> -		/* Need to lock the new subflow only if different
> -		 * from the previous one, otherwise we are still
> -		 * helding the relevant lock
> -		 */
> -		if (ssk != prev_ssk)
> -			lock_sock(ssk);
> +		mptcp_for_each_subflow(msk, subflow) {
> +			if (READ_ONCE(subflow->scheduled)) {
> +				prev_ssk = ssk;
> +				ssk = mptcp_subflow_tcp_sock(subflow);
>
> -		ret = __subflow_push_pending(sk, ssk, &info);
> -		if (ret <= 0) {
> -			if (ret == -EAGAIN)
> -				continue;
> -			mptcp_push_release(ssk, &info);
> -			goto out;
> +				if (ssk != prev_ssk) {
> +					/* First check. If the ssk has changed since
> +					 * the last round, release prev_ssk
> +					 */
> +					if (prev_ssk)
> +						mptcp_push_release(prev_ssk, &info);
> +
> +					/* Need to lock the new subflow only if different
> +					 * from the previous one, otherwise we are still
> +					 * helding the relevant lock
> +					 */
> +					lock_sock(ssk);
> +				}
> +
> +				push_count++;
> +
> +				ret = __subflow_push_pending(sk, ssk, &info);
> +				if (ret <= 0) {
> +					if (ret != -EAGAIN ||
> +					    (1 << ssk->sk_state) &
> +					     (TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2 | TCPF_CLOSE))
> +						push_count--;
> +					continue;
> +				}
> +				do_check_data_fin = true;
> +				msk->last_snd = ssk;
> +				mptcp_subflow_set_scheduled(subflow, false);

I missed this before: the subflow->scheduled flag should be cleared on the 
error path too. If it's only cleared on success there could be problems 
with the __mptcp_subflow_push_pending() code path in later patches.

- Mat

> +			}
> 		}
> -		do_check_data_fin = true;
> 	}
>
> 	/* at this point we held the socket lock for the last subflow we used */
> 	if (ssk)
> 		mptcp_push_release(ssk, &info);
>
> -out:
> 	/* ensure the rtx timer is running */
> 	if (!mptcp_timer_pending(sk))
> 		mptcp_reset_timer(sk);
> @@ -1614,33 +1619,63 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool first)
> {
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct mptcp_subflow_context *subflow;
> 	struct mptcp_sendmsg_info info = {
> 		.data_lock_held = true,
> 	};
> -	struct sock *xmit_ssk;
> +	bool push = true;
> 	int copied = 0;
>
> 	info.flags = 0;
> -	while (mptcp_send_head(sk)) {
> +	while (mptcp_send_head(sk) && push) {
> +		bool delegate = false;
> 		int ret = 0;
>
> 		/* check for a different subflow usage only after
> 		 * spooling the first chunk of data
> 		 */
> -		xmit_ssk = first ? ssk : mptcp_subflow_get_send(msk);
> -		if (!xmit_ssk)
> -			goto out;
> -		if (xmit_ssk != ssk) {
> -			mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk),
> -					       MPTCP_DELEGATE_SEND);
> -			goto out;
> +		if (first) {
> +			ret = __subflow_push_pending(sk, ssk, &info);
> +			first = false;
> +			if (ret <= 0)
> +				break;
> +			copied += ret;
> +			msk->last_snd = ssk;
> +			continue;
> 		}
>
> -		ret = __subflow_push_pending(sk, ssk, &info);
> -		first = false;
> -		if (ret <= 0)
> -			break;
> -		copied += ret;
> +		if (mptcp_sched_get_send(msk))
> +			goto out;
> +
> +		mptcp_for_each_subflow(msk, subflow) {
> +			if (READ_ONCE(subflow->scheduled)) {
> +				struct sock *xmit_ssk = mptcp_subflow_tcp_sock(subflow);
> +
> +				if (xmit_ssk != ssk) {
> +					/* Only delegate to one subflow recently,
> +					 * TODO: chain delegated calls for more subflows.
> +					 */
> +					if (delegate)
> +						goto out;
> +					mptcp_subflow_delegate(subflow,
> +							       MPTCP_DELEGATE_SEND);
> +					msk->last_snd = ssk;
> +					mptcp_subflow_set_scheduled(subflow, false);
> +					delegate = true;
> +					push = false;
> +					continue;
> +				}
> +
> +				ret = __subflow_push_pending(sk, ssk, &info);
> +				if (ret <= 0) {
> +					push = false;
> +					continue;
> +				}
> +				copied += ret;
> +				msk->last_snd = ssk;
> +				mptcp_subflow_set_scheduled(subflow, false);
> +			}
> +		}
> 	}
>
> out:
> diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
> index c4006f142f10..18518a81afb3 100644
> --- a/net/mptcp/sched.c
> +++ b/net/mptcp/sched.c
> @@ -118,6 +118,19 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
> 	struct mptcp_subflow_context *subflow;
> 	struct mptcp_sched_data data;
>
> +	sock_owned_by_me((const struct sock *)msk);
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
> 	mptcp_for_each_subflow(msk, subflow) {
> 		if (READ_ONCE(subflow->scheduled))
> 			return 0;
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
