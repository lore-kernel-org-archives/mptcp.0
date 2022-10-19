Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28631C30
	for <mptcp@lists.linux.dev>; Wed, 19 Oct 2022 00:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666141109; x=1697677109;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=gRbrdbMPOtZMEIODEeTsAhE3bMeBh279Ht30JfZvy4I=;
  b=dZTmX9UkDZejnu36OUZuYT07tAHITB57zPGUKlpDD7K+g9+tNfzyVrz5
   tqJIIqAQLo2Tdw6+xnbYsR6x431Q9pjRLDdA9cflTKHXArxIKw4yJVp2V
   J7+sPnn2FooluDrk5F9VMpFNDRQHO5VK15f9gCQQygvfmWwUXW7RsiOOd
   UOUWR4LgOFq45h8vIGKoL/NTlT9LDz+ihOf7j9Tj6YciNTHfvipYZI5FN
   47d+NR4s4T5pUhaXE+Z/yEza5OrWCr2H4lVsxGOyEWCVstuVzrKMWVncO
   NB8WkbI7l2N9w8aWwOEWhbWFFi4gBtzSCBRQ4XPc5hIAkRlsp9zIhofQn
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="306259944"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="306259944"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 17:58:29 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="662186216"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="662186216"
Received: from dprende1-mobl1.ger.corp.intel.com ([10.209.71.142])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 17:58:28 -0700
Date: Tue, 18 Oct 2022 17:58:27 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v9 4/4] mptcp: refactor push_pending logic
In-Reply-To: <20221018110312.22510-5-geliang.tang@suse.com>
Message-ID: <0ecdfbe8-9581-e127-6732-da9c7ca349e5@linux.intel.com>
References: <20221018110312.22510-1-geliang.tang@suse.com> <20221018110312.22510-5-geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 18 Oct 2022, Geliang Tang wrote:

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
> net/mptcp/protocol.c | 155 +++++++++++++++++++------------------------
> 1 file changed, 70 insertions(+), 85 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index ddeb8b36a677..9b73297f6543 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1417,14 +1417,6 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
> 	u64 linger_time;
> 	long tout = 0;
>
> -	/* re-use last subflow, if the burst allow that */
> -	if (msk->last_snd && msk->snd_burst > 0 &&
> -	    sk_stream_memory_free(msk->last_snd) &&
> -	    mptcp_subflow_active(mptcp_subflow_ctx(msk->last_snd))) {
> -		mptcp_set_timeout(sk);
> -		return msk->last_snd;
> -	}
> -
> 	/* pick the subflow with the lower wmem/wspace ratio */
> 	for (i = 0; i < SSK_MODE_MAX; ++i) {
> 		send_info[i].ssk = NULL;
> @@ -1491,12 +1483,6 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
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
> @@ -1528,68 +1514,80 @@ void mptcp_check_and_set_pending(struct sock *sk)
> 		mptcp_sk(sk)->push_pending |= BIT(MPTCP_PUSH_PENDING);
> }
>
> -void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> +static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
> +				  struct mptcp_sendmsg_info *info)
> {
> -	struct sock *prev_ssk = NULL, *ssk = NULL;
> 	struct mptcp_sock *msk = mptcp_sk(sk);
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
> -			ssk = mptcp_subflow_get_send(msk);
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
>
> 			mptcp_update_post_push(msk, dfrag, ret);
> 		}
> 		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
> +
> +		if (msk->snd_burst <= 0 ||
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
> +	struct mptcp_sendmsg_info info = {
> +				.flags = flags,
> +	};
> +	struct sock *ssk;
> +	int ret = 0;
> +
> +again:
> +	while (mptcp_send_head(sk) && (ssk = mptcp_subflow_get_send(msk))) {
> +		lock_sock(ssk);
> +		ret = __subflow_push_pending(sk, ssk, &info);
> +		release_sock(ssk);

Thanks for reworking this patch set, it's easier to see what's going on 
now.

With this refactoring a long send will push, release, and re-lock the 
subflow for every "burst" (as limited by snd_burst or by the available 
buffer space). That seems like it could add noticeable overhead for 
high-throughput connections, compared to the old code that would defer the 
push & unlock. In earlier reviews I didn't consider this carefully enough: 
I thought that __subflow_push_pending() would usually be able to send all 
the pending dfrags, but I didn't consider sendmsg calls with lots of data 
(more than the burst size).

I think it's possible to keep the push/unlock optimization in 
__mptcp_push_pending() if the tcp_push() is handled outside 
__subflow_push_pending().

Would likely need more information returned from the helper to give the 
caller of __subflow_push_pending() enough information, like:

static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 				  struct mptcp_sendmsg_info *info,
 				  bool *needs_push)

I'll talk to Paolo about this on Thursday too (and he's welcome to chime 
in here :) )

> +
> +		if (ret <= 0) {
> +			if (ret == -EAGAIN)
> +				goto again;

Better to use a 'continue' here.

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
> @@ -1599,51 +1597,38 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
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
> -			xmit_ssk = first ? ssk : mptcp_subflow_get_send(msk);
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
> -			first = false;
> +again:
> +	while (mptcp_send_head(sk)) {
> +		/* check for a different subflow usage only after
> +		 * spooling the first chunk of data
> +		 */
> +		xmit_ssk = first ? ssk : mptcp_subflow_get_send(msk);
> +		if (!xmit_ssk)
> +			goto out;
> +		if (xmit_ssk != ssk) {
> +			mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk),
> +					       MPTCP_DELEGATE_SEND);
> +			goto out;
> +		}
>
> -			mptcp_update_post_push(msk, dfrag, ret);
> +		ret = __subflow_push_pending(sk, ssk, &info);
> +		first = false;
> +		if (ret <= 0) {
> +			if (ret == -EAGAIN)
> +				goto again;

Another place to use 'continue'.

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
