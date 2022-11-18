Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CC5A492
	for <mptcp@lists.linux.dev>; Fri, 18 Nov 2022 22:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668809052; x=1700345052;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=FuNorXYMbHAui+UKGw/MSIP+CjhDKLDtHZG+l5lnI4w=;
  b=PtWp6k0aZIZX4MnKSntFjcQ6rA4dkEQDZRmPe0aGgPvtxaY8KxaDxvdD
   olrTCEJLP5e7ZXpdIFKj8+xSIv3Rvo8BWjBLmrHk+6JBjCmxLmZQx9fZK
   YKk0fYNsaNhVQnq5NKRuGeF7j4qZDUd3XwzPwGCoFWxnLQagngVik3V8H
   DU0O/2r35ykfcPmJPFSwB23DJrf4QrBz+/I0hta+pYjBqAML+k7/4XqRn
   MYqBtfaqlS5lbSnkBFK1fbXmnToBav71fgTrLJaj1BQpr+WfMOK0WL1P/
   6TtOOQ8MJLDtSMG29xJvbTWoz7qt42b3fzCVaXtGTt+mYXCHz7dDWFgF6
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="377511094"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="377511094"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 14:04:11 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="703896618"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="703896618"
Received: from kwells1-mobl1.amr.corp.intel.com ([10.212.140.181])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 14:04:11 -0800
Date: Fri, 18 Nov 2022 14:04:11 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v20 2/7] mptcp: use get_send wrapper
In-Reply-To: <5ebe73a0638e916ffe03b9354bc0dfb1c6027224.1668598782.git.geliang.tang@suse.com>
Message-ID: <4fd1db78-4c30-fa9e-e281-3979b2ad58f1@linux.intel.com>
References: <cover.1668598782.git.geliang.tang@suse.com> <5ebe73a0638e916ffe03b9354bc0dfb1c6027224.1668598782.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 16 Nov 2022, Geliang Tang wrote:

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
> net/mptcp/protocol.c | 119 ++++++++++++++++++++++++++-----------------
> net/mptcp/sched.c    |  13 +++++
> 2 files changed, 84 insertions(+), 48 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 6531df5ef4dc..f3720923b22d 100644
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
> @@ -1563,47 +1554,58 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> {
> 	struct sock *prev_ssk = NULL, *ssk = NULL;
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct mptcp_subflow_context *subflow;
> 	struct mptcp_sendmsg_info info = {
> 				.flags = flags,
> 	};
> 	bool do_check_data_fin = false;
> +	int err = 0;
>
> -	while (mptcp_send_head(sk)) {
> +	while (mptcp_send_head(sk) && !err) {

This "!err" will quit the loop if any subflow encounters an error, so if 
an iteration of this loop has two subflows successfully send, and one 
fails, then this will exit.

Isn't it better to continue looping unless *all* scheduled subflows fail?

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

The above two statements could be combined to only check ssk != prev_ssk 
once:

if (ssk != prev_ssk) {
 	/* First check. If the ssk ... */
 	if (prev_ssk)
 		mptcp_push_release(prev_ssk, &info);

 	/* Need to lock ... */
 	lock_sock(ssk);
}


> +
> +				ret = __subflow_push_pending(sk, ssk, &info);
> +				if (ret <= 0) {
> +					if (ret != -EAGAIN ||
> +					    inet_sk_state_load(ssk) == TCP_FIN_WAIT1 ||
> +					    inet_sk_state_load(ssk) == TCP_FIN_WAIT2 ||
> +					    inet_sk_state_load(ssk) == TCP_CLOSE)

Each call to inet_sk_state_load() uses smp_load_acquire(), so the sk state 
should be loaded only once and then compared to multiple values (or use 
the "1 << sk_state" technique, like in mptcp_pending_data_fin_ack()).

> +						err = 1;
> +					continue;
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
> @@ -1614,33 +1616,54 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool first)
> {
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct mptcp_subflow_context *subflow;
> 	struct mptcp_sendmsg_info info = {
> 		.data_lock_held = true,
> 	};
> -	struct sock *xmit_ssk;
> -	int copied = 0;
> +	int copied = 0, err = 0;

I suggest making 'err' a bool, so it's obvious it's not an integer error 
code (like -EAGAIN, etc).

>
> 	info.flags = 0;
> -	while (mptcp_send_head(sk)) {
> +	while (mptcp_send_head(sk) && !err) {
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
> +					mptcp_subflow_delegate(subflow,
> +							       MPTCP_DELEGATE_SEND);
> +					msk->last_snd = ssk;
> +					mptcp_subflow_set_scheduled(subflow, false);
> +					goto out;
> +				}
> +
> +				ret = __subflow_push_pending(sk, ssk, &info);
> +				if (ret <= 0) {
> +					err = 1;
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
> index f51f9cf20b6e..923c07296ff3 100644
> --- a/net/mptcp/sched.c
> +++ b/net/mptcp/sched.c
> @@ -119,11 +119,24 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
> 	struct mptcp_sched_data data;
> 	struct sock *ssk = NULL;
>
> +	sock_owned_by_me((const struct sock *)msk);
> +
> 	mptcp_for_each_subflow(msk, subflow) {
> 		if (READ_ONCE(subflow->scheduled))
> 			return 0;
> 	}
>
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

Better to check fallback before the subflow->scheduled bits, right? It's 
not expected for subflow->scheduled to be set on the single subflow 
present in a connection that has gone through fallback, but it's better to 
be safe by reordering these chunks of code.


> 	if (!msk->sched) {
> 		ssk = mptcp_subflow_get_send(msk);
> 		if (!ssk)
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
