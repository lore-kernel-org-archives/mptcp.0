Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3029192
	for <mptcp@lists.linux.dev>; Wed, 14 Dec 2022 23:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671062247; x=1702598247;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=YL/xxugvCrbk1OaHlA4J9aYr5huhLwRo/I+27f6a1sk=;
  b=I1gdFupEf/tet6bSm8BtHzO86rCQZqi6/DeaCdIpyqdvpjK51+CcYirM
   SKrEs6tScnO76IYZyUcuNF6yn6TquuMRBz+5GyuigWPT6oXD/1i8ZwSs2
   zeQPxwVDpxBEO7mzssKyYRh7kU74nnSx8BFsWRlrXb5zdfBjiqu+EYcpP
   H2wa+lfv9cdxgm7q09YtjhnAkK1v3gyB3EPxWNVLmM0RO1qWrLvx5Paki
   CPeG3TMQdvHKiqPcRrgutpRa7KIR/iRoRD8be4FYmNWZDvaEV8mBpkZGU
   vzsF3IO2wKl2SrG3Su0ZP2LQR8O+slOOYEO51hRJ5GO7EQIQG+q7J+Pam
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="317255550"
X-IronPort-AV: E=Sophos;i="5.96,245,1665471600"; 
   d="scan'208";a="317255550"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 15:57:26 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="823466263"
X-IronPort-AV: E=Sophos;i="5.96,245,1665471600"; 
   d="scan'208";a="823466263"
Received: from rbcranda-mobl1.amr.corp.intel.com ([10.212.154.86])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 15:57:26 -0800
Date: Wed, 14 Dec 2022 15:57:26 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v24 2/5] mptcp: use get_send wrapper
In-Reply-To: <514a6af8db312705865fcf9c33c817f264fbd495.1670723836.git.geliang.tang@suse.com>
Message-ID: <c3e83595-afa6-239b-da8a-fd6c7b675c4e@linux.intel.com>
References: <cover.1670723836.git.geliang.tang@suse.com> <514a6af8db312705865fcf9c33c817f264fbd495.1670723836.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Sun, 11 Dec 2022, Geliang Tang wrote:

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
> net/mptcp/protocol.c | 120 +++++++++++++++++++++++++++----------------
> net/mptcp/sched.c    |  13 +++++
> 2 files changed, 88 insertions(+), 45 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 14c69a519898..1c095fa37b6b 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1407,15 +1407,6 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
> 	u64 linger_time;
> 	long tout = 0;
>
> -	msk_owned_by_me(msk);
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
> @@ -1562,47 +1553,61 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
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
> +				mptcp_subflow_set_scheduled(subflow, false);
>
> -		ret = __subflow_push_pending(sk, ssk, &info);
> -		if (ret <= 0) {
> -			if (ret == -EAGAIN)
> -				continue;
> -			mptcp_push_release(ssk, &info);
> -			goto out;
> +				prev_ssk = ssk;
> +				ssk = mptcp_subflow_tcp_sock(subflow);
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
> @@ -1613,33 +1618,58 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool first)
> {
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct mptcp_subflow_context *subflow;
> 	struct mptcp_sendmsg_info info = {
> 		.data_lock_held = true,
> 	};
> +	bool keep_pushing = true;
> 	struct sock *xmit_ssk;
> 	int copied = 0;
>
> 	info.flags = 0;
> -	while (mptcp_send_head(sk)) {
> +	while (mptcp_send_head(sk) && keep_pushing) {
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
> +		if (first) {

Hi Geliang -

I think there should be a call to

mptcp_subflow_set_scheduled(subflow, false);

here. Explanation below.

> +			ret = __subflow_push_pending(sk, ssk, &info);
> +			first = false;
> +			if (ret <= 0)
> +				break;
> +			copied += ret;
> +			msk->last_snd = ssk;
> +			continue;
> +		}
> +
> +		if (mptcp_sched_get_send(msk))
> 			goto out;
> +
> +		subflow = mptcp_subflow_ctx(ssk);
> +		if (READ_ONCE(subflow->scheduled)) {
> +			mptcp_subflow_set_scheduled(subflow, false);
> +
> +			ret = __subflow_push_pending(sk, ssk, &info);
> +			if (ret <= 0)
> +				keep_pushing = false;
> +			copied += ret;
> +			msk->last_snd = ssk;
> 		}
>
> -		ret = __subflow_push_pending(sk, ssk, &info);
> -		first = false;
> -		if (ret <= 0)
> -			break;
> -		copied += ret;
> +		mptcp_for_each_subflow(msk, subflow) {
> +			if (READ_ONCE(subflow->scheduled)) {
> +				mptcp_subflow_set_scheduled(subflow, false);
> +

I took another look at how delegated sends work, and there is no guarantee 
that 'subflow' will send data after mptcp_subflow_delegate(subflow, 
MPTCP_DELEGATE_SEND) is called. Review mptcp_subflow_process_delegated(): 
if the msk is owned-by-user, then the MPTCP_PUSH_PENDING flag is used and 
mptcp_release_cb() calls __mptcp_push_pending() later without any subflow 
information.

If subflow->scheduled is cleared here, then this subflow will not be used 
to send data in that MPTCP_PUSH_PENDING path.

It would be better to remove the mptcp_subflow_set_scheduled() here and 
it will either be handled by the new call above (if the msk is unlocked 
when mptcp_subflow_process_delegated() runs) or __mptcp_push_pending() 
will re-check all the schedule bits later (if the msk is locked).

- Mat

> +				xmit_ssk = mptcp_subflow_tcp_sock(subflow);
> +				if (xmit_ssk != ssk) {
> +					mptcp_subflow_delegate(subflow,
> +							       MPTCP_DELEGATE_SEND);
> +					msk->last_snd = xmit_ssk;
> +					keep_pushing = false;
> +				}
> +			}
> +		}
> 	}
>
> out:
> diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
> index c4006f142f10..6428323d8c7f 100644
> --- a/net/mptcp/sched.c
> +++ b/net/mptcp/sched.c
> @@ -118,6 +118,19 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
> 	struct mptcp_subflow_context *subflow;
> 	struct mptcp_sched_data data;
>
> +	msk_owned_by_me(msk);
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
