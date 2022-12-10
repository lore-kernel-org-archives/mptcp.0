Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67778A42
	for <mptcp@lists.linux.dev>; Sat, 10 Dec 2022 01:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670635155; x=1702171155;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=YmSSI1tWk+sp3NZhd7Mmqzgs9Mzc6+5UQOXf+p4LR+Q=;
  b=nuD+XbJ+MmAfvAoeo/OYwRztl5sos6hiDkwd4Llz1tIvFx7KlvKI9WCt
   98mBxEf7qoTAo1owFx+mUW0I2SJKVPRKejz8I4ziuRw+oqKU0QZrN5FBZ
   2zPdgxaz80SEITKASG2+3xGqzuAlgsA1n81F0QsDMW3jqqdHbHdspJc+R
   DEtdq1SXj5payKA4sa6987tfNV3xBdFQVUaK2s3PBJgq7Zppth1A9dZAm
   tHsuDmdQKeTlCdYtGMBFm1aXqiUshXWv7ztCyHq268IOEQiLQRgSonatI
   kXUcM2CznnR2pm/dhZiXlVSvS7B8J0UkcebMjFtrp6uM2354oPqEGCQNm
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="315219262"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="315219262"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 17:19:14 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="736392956"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="736392956"
Received: from blionber-mobl.amr.corp.intel.com ([10.209.9.207])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 17:19:14 -0800
Date: Fri, 9 Dec 2022 17:19:14 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v23 2/5] mptcp: use get_send wrapper
In-Reply-To: <e55f8878f42b242e3ef22eef5536ea7e64d81f7e.1670332660.git.geliang.tang@suse.com>
Message-ID: <b16d6fbf-3b37-6c7a-c7a9-6edb7bd8b6ae@linux.intel.com>
References: <cover.1670332660.git.geliang.tang@suse.com> <e55f8878f42b242e3ef22eef5536ea7e64d81f7e.1670332660.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 6 Dec 2022, Geliang Tang wrote:

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
> net/mptcp/protocol.c | 126 +++++++++++++++++++++++++++----------------
> net/mptcp/sched.c    |  13 +++++
> 2 files changed, 93 insertions(+), 46 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 3d55a02c3f50..d5de01bae61c 100644
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
> @@ -1614,33 +1619,62 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool first)
> {
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct mptcp_subflow_context *subflow;
> 	struct mptcp_sendmsg_info info = {
> 		.data_lock_held = true,
> 	};
> 	struct sock *xmit_ssk;
> +	bool push = true;

Hi Geliang,

I suggest naming this variable 'keep_pushing'.

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

Since only the 'ssk' subflow can send right now, I think it makes sense to 
check the scheduled bit on that subflow first to see if data can be sent 
immediately. Then clear subflow->scheduled on the ssk and check the 
remaining subflows in the for_each_subflow loop below.


> +		mptcp_for_each_subflow(msk, subflow) {
> +			if (READ_ONCE(subflow->scheduled)) {
> +				mptcp_subflow_set_scheduled(subflow, false);
> +
> +				xmit_ssk = mptcp_subflow_tcp_sock(subflow);
> +				if (xmit_ssk != ssk) {
> +					/* Only delegate to one subflow recently
> +					 */
> +					if (delegate)
> +						goto out;
> +					mptcp_subflow_delegate(subflow,
> +							       MPTCP_DELEGATE_SEND);
> +					msk->last_snd = ssk;
> +					delegate = true;

Why is this flag set here, and checked on the next iteration? It will 
clear the scheduled bit on the next scheduled subflow without sending 
anything.

Does it work to remove the 'delegate' variable and "goto out;" here 
instead?

- Mat

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
