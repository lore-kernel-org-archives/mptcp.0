Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147D4362
	for <mptcp@lists.linux.dev>; Tue,  1 Nov 2022 00:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667262401; x=1698798401;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=cyvreVQRSuKaosfhJcYkjLcPMKk3yi5U6ttL24wUCi0=;
  b=kA7JTTcZeBoQ+fiTH/GM9n9vcjVw17imyT9GJP3A4FlWP1eQ0gq0zLFh
   RgtUzgHI/h4HmuICh51rZz0lTDmZHc7k3b2OcryFcePRxFBtvjmM/sp50
   LpB97x9vKyuVr0nxp+ZtrwyuOaKtLVce2PhGu4Hn0aZBKYRA5Z2QweEye
   xnqr/aWDab3Ufzc5x/nEH8sTsfO0u8dFyndGob9rTQqGV8dpFtnbMjFl5
   bqLxjbUvtQsgqDf39dWrENbFw+gThW2OA04T6BYunpG2e8MqN4yWZClfk
   iO5+Ney4SuaporGn3ViNJrPFqQo4ZMNfxHGsS9E5FNpXLY2Vaiewrj4Da
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="371111492"
X-IronPort-AV: E=Sophos;i="5.95,229,1661842800"; 
   d="scan'208";a="371111492"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 17:26:40 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="878924877"
X-IronPort-AV: E=Sophos;i="5.95,229,1661842800"; 
   d="scan'208";a="878924877"
Received: from jblosfi-mobl1.amr.corp.intel.com ([10.255.229.117])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 17:26:40 -0700
Date: Mon, 31 Oct 2022 17:26:39 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v16 10/15] mptcp: use get_send wrapper
In-Reply-To: <e9983543fbdefba28a426a4015966be804ba0477.1666771065.git.geliang.tang@suse.com>
Message-ID: <1df91e3d-5cfb-ecbb-197c-001ef3746e20@linux.intel.com>
References: <cover.1666771065.git.geliang.tang@suse.com> <e9983543fbdefba28a426a4015966be804ba0477.1666771065.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 26 Oct 2022, Geliang Tang wrote:

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

Hi Geliang -

I think the commit message should mention that this commit allows the 
scheduler to set the subflow->scheduled bit in multiple subflows, but it 
does not allow for sending redundant data. Multiple scheduled subflows 
will send sequential data on each subflow (correct?).



> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/protocol.c | 113 +++++++++++++++++++++++++------------------
> net/mptcp/protocol.h |   2 +
> net/mptcp/sched.c    |  31 ++++++++++++
> 3 files changed, 99 insertions(+), 47 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 1f64abb94cc8..277f1de31e65 100644
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
> @@ -1572,36 +1563,42 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> {
> 	struct sock *prev_ssk = NULL, *ssk = NULL;
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct mptcp_subflow_context *subflow;
> 	struct mptcp_sendmsg_info info = {
> 		.flags = flags,
> 	};
> 	int ret = 0;
>
> -	while (mptcp_send_head(sk)) {
> -		prev_ssk = ssk;
> -		ssk = mptcp_subflow_get_send(msk);
> -
> -		/* First check. If the ssk has changed since
> -		 * the last round, release prev_ssk
> -		 */
> -		if (ssk != prev_ssk && prev_ssk)
> -			mptcp_push_release(prev_ssk, &info);
> -		if (!ssk)
> -			goto out;
> +again:
> +	while (mptcp_send_head(sk) && !mptcp_sched_get_send(msk)) {
> +		mptcp_for_each_subflow(msk, subflow) {
> +			if (READ_ONCE(subflow->scheduled)) {
> +				prev_ssk = ssk;
> +				ssk = mptcp_subflow_tcp_sock(subflow);
>
> -		/* Need to lock the new subflow only if different
> -		 * from the previous one, otherwise we are still
> -		 * helding the relevant lock
> -		 */
> -		if (ssk != prev_ssk)
> -			lock_sock(ssk);
> +				/* First check. If the ssk has changed since
> +				 * the last round, release prev_ssk
> +				 */
> +				if (ssk != prev_ssk && prev_ssk)
> +					mptcp_push_release(prev_ssk, &info);
>
> -		ret = __subflow_push_pending(sk, ssk, &info);
> -		if (ret <= 0) {
> -			if (ret == -EAGAIN)
> -				continue;
> -			mptcp_push_release(ssk, &info);
> -			goto out;
> +				/* Need to lock the new subflow only if different
> +				 * from the previous one, otherwise we are still
> +				 * helding the relevant lock
> +				 */
> +				if (ssk != prev_ssk)
> +					lock_sock(ssk);
> +
> +				ret = __subflow_push_pending(sk, ssk, &info);
> +				if (ret <= 0) {
> +					if (ret == -EAGAIN)
> +						goto again;
> +					mptcp_push_release(ssk, &info);
> +					goto out;

If there was an error sending on this subflow, I think this code path 
should "continue" so the other scheduled subflows get a chance to send. 
This also makes sure the subflow->enabled flag is cleared on every 
scheduled subflow before this loop is done.

There's still a check to run __mptcp_check_send_data_fin() at the end of 
this function. That should run if any subflow returned a positive value 
from __subflow_push_pending(), not just the last subflow in the loop.

> +				}
> +				msk->last_snd = ssk;
> +				mptcp_subflow_set_scheduled(subflow, false);
> +			}
> 		}
> 	}
>
> @@ -1620,32 +1617,54 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool first)
> {
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct mptcp_subflow_context *subflow;
> 	struct mptcp_sendmsg_info info = {
> 		.data_lock_held = true,
> 	};
> -	struct sock *xmit_ssk;
> 	int ret = 0;
>
> 	info.flags = 0;
> +again:
> 	while (mptcp_send_head(sk)) {
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
> +			if (ret <= 0) {
> +				if (ret == -EAGAIN)
> +					goto again;
> +				break;
> +			}
> +			msk->last_snd = ssk;
> +			continue;
> 		}
>
> -		ret = __subflow_push_pending(sk, ssk, &info);
> -		first = false;
> -		if (ret <= 0) {
> -			if (ret == -EAGAIN)
> -				continue;
> -			break;
> +		if (mptcp_sched_get_send(msk))
> +			goto out;
> +
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
> +					if (ret == -EAGAIN)
> +						goto again;
> +					goto out;
> +				}
> +				msk->last_snd = ssk;
> +				mptcp_subflow_set_scheduled(subflow, false);
> +			}
> 		}
> 	}

I don't think this __mptcp_subflow_push_pending() code path fully handles 
the case where subflow->enabled is set on multiple subflows. 
If __mptcp_push_pending() runs on a separate thread, it can find 
subflow->enabled already set in some subflows. With the code in this 
revision of the patch series, the subflow->enabled flags in each subflow 
would just get overwritten by the new call to mptcp_sched_get_send().

It seems to me that __mptcp_push_pending() should check the existing 
subflow->enabled flags (or a new msk-level flag?) to make sure the 
previous scheduled sends have finished. This will also better prepare for 
the redundant send patches.

- Mat


>
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 285abbad833f..cb8ea1eadbae 100644
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
> index 0d7c73e9562e..063f5005b2db 100644
> --- a/net/mptcp/sched.c
> +++ b/net/mptcp/sched.c
> @@ -112,3 +112,34 @@ void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
> 	for (; i < MPTCP_SUBFLOWS_MAX; i++)
> 		data->contexts[i] = NULL;
> }
> +
> +int mptcp_sched_get_send(struct mptcp_sock *msk)
> +{
> +	struct mptcp_sched_data data;
> +	struct sock *ssk = NULL;
> +
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
