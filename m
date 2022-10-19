Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427615C87
	for <mptcp@lists.linux.dev>; Wed, 19 Oct 2022 23:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666222223; x=1697758223;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=reIHjIZYep4c71ONiVTtmrEIQaFpusVBXeP6U93DD40=;
  b=a8dbBX4JL5hW/RRmqFkzUitBvKQ/4G1DCHU+RujxL0Wn+6gmsAKMAf7D
   +qUtJPz9CxJ0dLxq1hm0rqrPrppEOjz7NAmKjk0rWjTt1VncjHLswHuZ8
   e3o1YAULBxwuCeOI0uUchfHfr1B3yHrdzcCKWhqGT5NttKBgk5GyG8pW3
   bywGl64nIKeVs5dEfhfSkiJmZIRz9QRDeRbVAuT9hxo4pdzfLg/iwVY84
   JtAhCPUGRNoZ0ikS4GMpUGGxMAijGRRFoC3z9EWQV4Ohjm4rw1mzf1ccm
   bhbmyQRX2Q3HtzenExsHnO2cOgJExugc23UaN7yWdGZGMrxbMnpTHhl+Y
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="286951612"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="286951612"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 16:30:22 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="804542733"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="804542733"
Received: from mk6ht25xq5mac.sea.intel.com ([10.241.111.152])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 16:30:22 -0700
Date: Wed, 19 Oct 2022 16:30:22 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v14 1/7] mptcp: refactor push_pending logic
In-Reply-To: <1f31ba545d3585823aec4ea43686dd8d89237ebc.1666185947.git.geliang.tang@suse.com>
Message-ID: <8c8877ea-3395-1bfb-3f46-3a5df5e4ab11@linux.intel.com>
References: <cover.1666185947.git.geliang.tang@suse.com> <1f31ba545d3585823aec4ea43686dd8d89237ebc.1666185947.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 19 Oct 2022, Geliang Tang wrote:

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

Hi Geliang -

Thanks for the changes here. I need to run some tests before signing off 
but this patch looks good so far.


- Mat


> ---
> net/mptcp/protocol.c | 154 ++++++++++++++++++++++---------------------
> 1 file changed, 80 insertions(+), 74 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index ddeb8b36a677..67450378cb97 100644
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
> @@ -1528,57 +1520,83 @@ void mptcp_check_and_set_pending(struct sock *sk)
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
> @@ -1589,7 +1607,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> 	/* ensure the rtx timer is running */
> 	if (!mptcp_timer_pending(sk))
> 		mptcp_reset_timer(sk);
> -	if (do_check_data_fin)
> +	if (ret > 0)
> 		__mptcp_check_send_data_fin(sk);
> }
>
> @@ -1599,49 +1617,37 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
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
