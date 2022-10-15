Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E07E363
	for <mptcp@lists.linux.dev>; Sat, 15 Oct 2022 00:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665792692; x=1697328692;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=NXQXmBqKmzlnn9dEOV59w4OJtEyvGf03qLBjM2ofZE8=;
  b=LY/IVblN5dLGcNwCnXYuiaQL0CJrX8igcMBLB/tWaQMYRFoOXpzeqPid
   BdBe0iNtsrKE3vdplND38j9hfhxFWXE+STj9ENp/4Deg2jXy3m7ztJiwg
   5QdBwwz8zosvnYzyRcOYaEAEAZmtu6pYomPDRSxsTyP+9ijiyx8MayUwb
   sPkjP/g6uqEf5B7l3+K2lRB/+jj4psD1Yws7+mBF36gs6TdM5Y6EQl+r/
   IBrtS3H8ivYmh6vDNVUVODWsrTvrhIoJwHcmRyb7eY6z37wmhBLHPSjL1
   /QbFz9a7r1OUcm86gmLJN5lfwCtSw35GSVWscT+0umcRjAao6uszRNA4k
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="303114036"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="303114036"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 17:11:31 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="622697879"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="622697879"
Received: from mcunning-mobl1.amr.corp.intel.com ([10.212.193.28])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 17:11:31 -0700
Date: Fri, 14 Oct 2022 17:11:31 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v8 06/15] mptcp: refactor push_pending logic
In-Reply-To: <6536ea94e85d6a35da64268649b78fc82256bcce.1665753926.git.geliang.tang@suse.com>
Message-ID: <729538fd-2ad2-c3cc-17b6-aa6dd9fb5959@linux.intel.com>
References: <cover.1665753926.git.geliang.tang@suse.com> <6536ea94e85d6a35da64268649b78fc82256bcce.1665753926.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 14 Oct 2022, Geliang Tang wrote:

> To support redundant package schedulers more easily, this patch refactors
> __mptcp_push_pending() logic from:
>
> For each dfrag:
> 	While sends succeed:
> 		Call the scheduler (selects subflow and msk->snd_burst)
> 		Update subflow locks (push/release/acquire as needed)
> 		Send the dfrag data with mptcp_sendmsg_frag()
> 		Update already_sent, snd_nxt, snd_burst
> 	Update msk->first_pending
> Push/release on final subflow
>
> ->
>
> While the scheduler selects one subflow:
> 	Lock the subflow
> 	For each pending dfrag:
> 		While sends succeed:
> 			Send the dfrag data with mptcp_sendmsg_frag()
> 			Update already_sent, snd_nxt, snd_burst
> 		Update msk->first_pending
> 		Break if required by msk->snd_burst / etc
> 	Push and release the subflow
>
> Refactors __mptcp_subflow_push_pending logic from:
>
> For each dfrag:
> 	While sends succeed:
> 		Call the scheduler (selects subflow and msk->snd_burst)
> 		Send the dfrag data with mptcp_subflow_delegate(), break
> 		Send the dfrag data with mptcp_sendmsg_frag()
> 		Update dfrag->already_sent, msk->snd_nxt, msk->snd_burst
> 	Update msk->first_pending
>
> ->
>
> While first_pending isn't empty:
> 	Call the scheduler (selects subflow and msk->snd_burst)
> 	Send the dfrag data with mptcp_subflow_delegate(), break
> 	Send the dfrag data with mptcp_sendmsg_frag()
> 	For each pending dfrag:
> 		While sends succeed:
> 			Send the dfrag data with mptcp_sendmsg_frag()
> 			Update already_sent, snd_nxt, snd_burst
> 		Update msk->first_pending
> 		Break if required by msk->snd_burst / etc
>
> Move the duplicate code from __mptcp_push_pending() and
> __mptcp_subflow_push_pending() into a new helper function, named
> __subflow_push_pending(). Simplify __mptcp_push_pending() and
> __mptcp_subflow_push_pending() by invoking this helper.
>
> Also move the burst check conditions out of the function
> mptcp_subflow_get_send(), check them in __mptcp_push_pending() and
> __mptcp_subflow_push_pending() in the inner "for each pending dfrag"
> loop.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/protocol.c | 160 +++++++++++++++++++------------------------
> 1 file changed, 72 insertions(+), 88 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index e95a49e5bc89..c3a4e0148c4a 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1427,14 +1427,6 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk,
> 		       sk_stream_memory_free(msk->first) ? msk->first : NULL;
> 	}
>
> -	/* re-use last subflow, if the burst allow that */
> -	if (msk->last_snd && data->snd_burst > 0 &&
> -	    sk_stream_memory_free(msk->last_snd) &&
> -	    mptcp_subflow_active(mptcp_subflow_ctx(msk->last_snd))) {
> -		mptcp_set_timeout(sk);
> -		return msk->last_snd;
> -	}
> -
> 	/* pick the subflow with the lower wmem/wspace ratio */
> 	for (i = 0; i < SSK_MODE_MAX; ++i) {
> 		send_info[i].ssk = NULL;
> @@ -1501,12 +1493,6 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk,
> 	return ssk;
> }
>
> -static void mptcp_push_release(struct sock *ssk, struct mptcp_sendmsg_info *info)
> -{
> -	tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle, info->size_goal);
> -	release_sock(ssk);
> -}
> -
> static void mptcp_update_post_push(struct mptcp_sock *msk,
> 				   struct mptcp_data_frag *dfrag,
> 				   u32 sent)
> @@ -1536,70 +1522,83 @@ void mptcp_check_and_set_pending(struct sock *sk)
> 		mptcp_sk(sk)->push_pending |= BIT(MPTCP_PUSH_PENDING);
> }
>
> -void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> +static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
> +				  struct mptcp_sendmsg_info *info,
> +				  struct mptcp_sched_data *data)
> {
> -	struct sock *prev_ssk = NULL, *ssk = NULL;
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> -	struct mptcp_sched_data data = { 0 };
> -	struct mptcp_sendmsg_info info = {
> -				.flags = flags,
> -	};
> -	bool do_check_data_fin = false;
> 	struct mptcp_data_frag *dfrag;
> -	int len;
> +	int len, copied = 0, err = 0;
>
> 	while ((dfrag = mptcp_send_head(sk))) {
> -		info.sent = dfrag->already_sent;
> -		info.limit = dfrag->data_len;
> +		info->sent = dfrag->already_sent;
> +		info->limit = dfrag->data_len;
> 		len = dfrag->data_len - dfrag->already_sent;
> 		while (len > 0) {
> 			int ret = 0;
>
> -			prev_ssk = ssk;
> -			ssk = mptcp_subflow_get_send(msk, &data);
> -
> -			/* First check. If the ssk has changed since
> -			 * the last round, release prev_ssk
> -			 */
> -			if (ssk != prev_ssk && prev_ssk)
> -				mptcp_push_release(prev_ssk, &info);
> -			if (!ssk)
> -				goto out;
> -
> -			/* Need to lock the new subflow only if different
> -			 * from the previous one, otherwise we are still
> -			 * helding the relevant lock
> -			 */
> -			if (ssk != prev_ssk)
> -				lock_sock(ssk);
> -
> -			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
> +			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, info);
> 			if (ret <= 0) {
> -				if (ret == -EAGAIN)
> -					continue;
> -				mptcp_push_release(ssk, &info);
> +				err = copied ? : ret;
> 				goto out;
> 			}
>
> -			do_check_data_fin = true;
> -			info.sent += ret;
> +			info->sent += ret;
> +			copied += ret;
> 			len -= ret;
> -			data.snd_burst -= ret;
> +			data->snd_burst -= ret;
>
> 			mptcp_update_post_push(msk, dfrag, ret);
> 		}
> 		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
> +
> +		if (data->snd_burst <= 0 ||
> +		    !sk_stream_memory_free(ssk) ||
> +		    !mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
> +			err = copied ? : -EAGAIN;
> +			goto out;
> +		}
> +		mptcp_set_timeout(sk);
> +	}
> +	err = copied;
> +
> +out:
> +	if (copied) {
> +		tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle,
> +			 info->size_goal);
> 	}
>
> -	/* at this point we held the socket lock for the last subflow we used */
> -	if (ssk)
> -		mptcp_push_release(ssk, &info);
> +	return err;
> +}
> +
> +void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> +{
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct mptcp_sched_data data = { 0 };
> +	struct mptcp_sendmsg_info info = {
> +				.flags = flags,
> +	};
> +	struct sock *ssk;
> +	int ret = 0;
> +
> +again:
> +	while (mptcp_send_head(sk) && (ssk = mptcp_subflow_get_send(msk, &data))) {
> +		lock_sock(ssk);
> +		ret = __subflow_push_pending(sk, ssk, &info, &data);
> +		release_sock(ssk);
> +
> +		if (ret <= 0) {
> +			if (ret == -EAGAIN)
> +				goto again;
> +			goto out;
> +		}
> +	}
>
> out:
> 	/* ensure the rtx timer is running */
> 	if (!mptcp_timer_pending(sk))
> 		mptcp_reset_timer(sk);
> -	if (do_check_data_fin)
> +	if (ret > 0)
> 		__mptcp_check_send_data_fin(sk);
> }
>
> @@ -1610,52 +1609,37 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
> 	struct mptcp_sendmsg_info info = {
> 		.data_lock_held = true,
> 	};
> -	struct mptcp_data_frag *dfrag;
> 	struct sock *xmit_ssk;
> -	int len, copied = 0;
> +	int ret = 0;
>
> 	info.flags = 0;
> -	while ((dfrag = mptcp_send_head(sk))) {
> -		info.sent = dfrag->already_sent;
> -		info.limit = dfrag->data_len;
> -		len = dfrag->data_len - dfrag->already_sent;
> -		while (len > 0) {
> -			int ret = 0;
> -
> -			/* check for a different subflow usage only after
> -			 * spooling the first chunk of data
> -			 */
> -			xmit_ssk = first ? ssk : mptcp_subflow_get_send(msk, &data);
> -			if (!xmit_ssk)
> -				goto out;
> -			if (xmit_ssk != ssk) {
> -				mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk),
> -						       MPTCP_DELEGATE_SEND);
> -				goto out;
> -			}
> -
> -			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
> -			if (ret <= 0)
> -				goto out;
> -
> -			info.sent += ret;
> -			copied += ret;
> -			len -= ret;
> -			data.snd_burst -= ret;
> -			first = false;
> +again:
> +	while (mptcp_send_head(sk)) {
> +		/* check for a different subflow usage only after
> +		 * spooling the first chunk of data
> +		 */
> +		xmit_ssk = first ? ssk : mptcp_subflow_get_send(msk, &data);
> +		if (!xmit_ssk)
> +			goto out;
> +		if (xmit_ssk != ssk) {
> +			mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk),
> +					       MPTCP_DELEGATE_SEND);
> +			goto out;
> +		}
>
> -			mptcp_update_post_push(msk, dfrag, ret);
> +		ret = __subflow_push_pending(sk, ssk, &info, &data);

I think there should still be a "first = false;" before the loop runs 
again so that the scheduler will get called on the next iteration. This 
will help avoid a tight loop if EAGAIN is returned on the line above.

- Mat

> +		if (ret <= 0) {
> +			if (ret == -EAGAIN)
> +				goto again;
> +			break;
> 		}
> -		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
> 	}
>
> out:
> 	/* __mptcp_alloc_tx_skb could have released some wmem and we are
> 	 * not going to flush it via release_sock()
> 	 */
> -	if (copied) {
> -		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
> -			 info.size_goal);
> +	if (ret > 0) {
> 		if (!mptcp_timer_pending(sk))
> 			mptcp_reset_timer(sk);
>
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
