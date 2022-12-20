Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F8D10E6
	for <mptcp@lists.linux.dev>; Tue, 20 Dec 2022 01:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671500642; x=1703036642;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=YXwqMNxdfu89kAu5epjXG1yAe2b8pSzX5T4mib0rm44=;
  b=jqPdjg4gDQSHtZ3b7FEBIY/z5w+Arb5RwfXqRD4E/wxzkutoRDBfr0nx
   km14LxnU2SEuNhzQ/A2OAQdJ2IPEXyFf6abmVumEO/ifaYLuQMP/0DY5y
   GynPPa2Tx1cbkEXdeAwLfiAZh0U8lbbny7GYolmE6w8pHVaU93bPMEjn5
   jvvL2gUjWqu/3kllcR5c6OFJVXXNkYBRABPM2weSNDlEQSths3SNhScNt
   402u/fwNpTQDzKIvts+naDdMCsmuMZ/GNuv7QtZaL71cJIrQbCDKoqbd5
   1hsc4/zB7n1WFQ8HXd8X+2pvJuvvT4o6yJXzajxJ/znWUpirWvlex7gdM
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="346600628"
X-IronPort-AV: E=Sophos;i="5.96,258,1665471600"; 
   d="scan'208";a="346600628"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 17:44:01 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="683239925"
X-IronPort-AV: E=Sophos;i="5.96,258,1665471600"; 
   d="scan'208";a="683239925"
Received: from wootaekl-mobl1.amr.corp.intel.com ([10.212.220.86])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 17:44:01 -0800
Date: Mon, 19 Dec 2022 17:44:01 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v25 2/5] mptcp: use get_send wrapper
In-Reply-To: <e11e982980cc6a19fdb59d7101403f3546c3fff9.1671107241.git.geliang.tang@suse.com>
Message-ID: <d7334863-f3a9-4b0e-fcb0-55409f09abbf@linux.intel.com>
References: <cover.1671107241.git.geliang.tang@suse.com> <e11e982980cc6a19fdb59d7101403f3546c3fff9.1671107241.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 15 Dec 2022, Geliang Tang wrote:

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
> net/mptcp/protocol.c | 117 ++++++++++++++++++++++++++-----------------
> net/mptcp/sched.c    |  13 +++++
> 2 files changed, 85 insertions(+), 45 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 14c69a519898..57967438e70f 100644
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
> @@ -1566,43 +1557,57 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> 				.flags = flags,
> 	};
> 	bool do_check_data_fin = false;
> +	int push_count = 1;
>
> -	while (mptcp_send_head(sk)) {
> +	while (mptcp_send_head(sk) && (push_count > 0)) {
> +		struct mptcp_subflow_context *subflow;
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
> @@ -1616,30 +1621,52 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
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
> +		struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
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
> +			mptcp_subflow_set_scheduled(subflow, false);
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
> +		if (READ_ONCE(subflow->scheduled)) {
> +			mptcp_subflow_set_scheduled(subflow, false);
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
> +				xmit_ssk = mptcp_subflow_tcp_sock(subflow);
> +				if (xmit_ssk != ssk) {
> +					mptcp_subflow_delegate(subflow,
> +							       MPTCP_DELEGATE_SEND);
> +					msk->last_snd = xmit_ssk;

Hi Geliang/Matthieu -

Following up to my earlier replay about this series, this is the line to 
delete (the assignment to msk->last_snd).

Similar to the removal of subflow_set_scheduled(subflow, false) in this 
block of code, the subflow hasn't been used to send yet so last_snd 
shouldn't be updated. It will get changed when __subflow_push_pending() is 
called later.

- Mat

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
