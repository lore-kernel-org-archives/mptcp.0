Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE2A1A601
	for <mptcp@lists.linux.dev>; Mon, 31 Oct 2022 23:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667259901; x=1698795901;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=J21Y+D6i6foF0Lo9xGloNwpqCKNWyTr5n7GoAj92whA=;
  b=k0xMot30/xoGPCZDq1AdSHQTsnIF/eCL+fWJPhvUyFyRqSSmdJeLrshd
   Yps/uVeHjLl42J95Yryl0Vx9Ej1+QExWmLwKOKFbBH2Keimt18jynOfB/
   02K0o5OBYaRGupKQNmaAt4JDqAmhonJMbE7zaCzix0PJ9ZZFXEWG0plH3
   NylusYBhXvoy0Y14VAkzHXm2/yOC8gmhv6iJt59P2yalvri8ZQzLZMyR6
   tHk7TWZXm5M8CKwV3HLq1CQIqRHdwXXTyJUloCfMembESJ4UtnCAjmvaW
   T6l9dwafgQ0s8S4+4ikRk4Qdb5DvKJehAKjR4sqorgtRMKIZzlnoVH+dE
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="395339192"
X-IronPort-AV: E=Sophos;i="5.95,229,1661842800"; 
   d="scan'208";a="395339192"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 16:45:00 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="633704452"
X-IronPort-AV: E=Sophos;i="5.95,229,1661842800"; 
   d="scan'208";a="633704452"
Received: from jblosfi-mobl1.amr.corp.intel.com ([10.255.229.117])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 16:45:00 -0700
Date: Mon, 31 Oct 2022 16:44:59 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v16 01/15] mptcp: refactor push_pending
 logic
In-Reply-To: <894aeffed6f89d1f9bd6e1fe459226aaacc0c5ca.1666771065.git.geliang.tang@suse.com>
Message-ID: <9b235299-dd21-28c9-8ffb-40e1e7e8e72e@linux.intel.com>
References: <cover.1666771065.git.geliang.tang@suse.com> <894aeffed6f89d1f9bd6e1fe459226aaacc0c5ca.1666771065.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 26 Oct 2022, Geliang Tang wrote:

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
> While first_pending isn't empty:
> 	Call the scheduler (selects subflow and msk->snd_burst)
> 	Update subflow locks (push/release/acquire as needed)
> 	For each pending dfrag:
> 		While sends succeed:
> 			Send the dfrag data with mptcp_sendmsg_frag()
> 			Update already_sent, snd_nxt, snd_burst
> 		Update msk->first_pending
> 		Break if required by msk->snd_burst / etc
> 	Push/release on final subflow
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
> mptcp_subflow_get_send(), check them in __subflow_push_pending() in
> the inner "for each pending dfrag" loop.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/protocol.c | 154 ++++++++++++++++++++++---------------------
> 1 file changed, 80 insertions(+), 74 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 3cf44b5ef937..71a6f08cc87b 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1426,14 +1426,6 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
> 		       sk_stream_memory_free(msk->first) ? msk->first : NULL;
> 	}
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
> @@ -1537,57 +1529,83 @@ void mptcp_check_and_set_pending(struct sock *sk)
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
> +	return err;
> +}
> +
> +void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> +{
> +	struct sock *prev_ssk = NULL, *ssk = NULL;
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct mptcp_sendmsg_info info = {
> +		.flags = flags,
> +	};
> +	int ret = 0;
> +
> +	while (mptcp_send_head(sk)) {
> +		prev_ssk = ssk;
> +		ssk = mptcp_subflow_get_send(msk);
> +
> +		/* First check. If the ssk has changed since
> +		 * the last round, release prev_ssk
> +		 */
> +		if (ssk != prev_ssk && prev_ssk)
> +			mptcp_push_release(prev_ssk, &info);
> +		if (!ssk)
> +			goto out;
> +
> +		/* Need to lock the new subflow only if different
> +		 * from the previous one, otherwise we are still
> +		 * helding the relevant lock
> +		 */
> +		if (ssk != prev_ssk)
> +			lock_sock(ssk);
> +
> +		ret = __subflow_push_pending(sk, ssk, &info);
> +		if (ret <= 0) {
> +			if (ret == -EAGAIN)
> +				continue;
> +			mptcp_push_release(ssk, &info);
> +			goto out;
> +		}
> 	}
>
> 	/* at this point we held the socket lock for the last subflow we used */
> @@ -1598,7 +1616,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> 	/* ensure the rtx timer is running */
> 	if (!mptcp_timer_pending(sk))
> 		mptcp_reset_timer(sk);
> -	if (do_check_data_fin)
> +	if (ret > 0)
> 		__mptcp_check_send_data_fin(sk);
> }
>
> @@ -1608,49 +1626,37 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
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
> +				continue;
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
> +	if (ret > 0) {

Hi Geliang -

I think this patch is very close to working like the existing code. I 
think the one line above is an issue, though. It only does a tcp_push() if 
the final call to __subflow_push_pending() returned a positive value. 
Earlier passes through the loop might have succeeded, which would require 
running this block of code.

> 		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
> 			 info.size_goal);
> 		if (!mptcp_timer_pending(sk))
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
