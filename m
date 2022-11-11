Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0247E
	for <mptcp@lists.linux.dev>; Fri, 11 Nov 2022 00:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668125466; x=1699661466;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=EGWXFaTe9onteShpfNVBlmGv95WHM1in0ZiqFMZmHM8=;
  b=BvfamaoOVTJQAlurHEzvh8MOas/73jTRBvr2nfONTi5RUQo8MjFQrc7w
   wPZMCIfGDq1+KptYh/8QgacRysL2W5jt9gXKg1ML9jZqIA/Q08May6mij
   g4sXwyQNUyBFZzwtyL73pBjuXK3WodQxG5qv4y7aSFni4Jum1y3yjLuNj
   +w/gJmQw6lhywwMRw0X7BJ/e0QKU28Xg3kxK0fvvTLszyoWtQJ/bx2oII
   fgKD4AipfKgCycard5dKNRq5LtKz0/jkRgxEZU50yipB0pFpDchlkZSOQ
   D8Re9s3LF9L9WH2rLjgPoeB6z52k+7uz2egTsEwb50nnuuJUDl4ihj3cz
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="313260727"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="313260727"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 16:11:05 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="639819313"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="639819313"
Received: from ssamaraj-mobl1.amr.corp.intel.com ([10.209.53.250])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 16:11:04 -0800
Date: Thu, 10 Nov 2022 16:11:03 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v18 01/15] mptcp: refactor push_pending
 logic
In-Reply-To: <828f9d2e9fa1738463a443140eb8f071e41a6fb9.1667897099.git.geliang.tang@suse.com>
Message-ID: <df6a7543-826a-b995-1a62-dd1b70a3e510@linux.intel.com>
References: <cover.1667897099.git.geliang.tang@suse.com> <828f9d2e9fa1738463a443140eb8f071e41a6fb9.1667897099.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 8 Nov 2022, Geliang Tang wrote:

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
> net/mptcp/protocol.c | 155 +++++++++++++++++++++++--------------------
> 1 file changed, 82 insertions(+), 73 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index ede644556b20..1fb3b46fa427 100644
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
> @@ -1537,57 +1529,86 @@ void mptcp_check_and_set_pending(struct sock *sk)
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
> +				.flags = flags,
> +	};
> +	bool do_check_data_fin = false;
> +
> +	while (mptcp_send_head(sk)) {
> +		int ret = 0;
> +
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
> +		do_check_data_fin = true;
> 	}
>
> 	/* at this point we held the socket lock for the last subflow we used */
> @@ -1608,49 +1629,37 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
> 	struct mptcp_sendmsg_info info = {
> 		.data_lock_held = true,
> 	};
> -	struct mptcp_data_frag *dfrag;
> 	struct sock *xmit_ssk;
> -	int len, copied = 0;

I'm not sure why copied is removed here, it's still useful for knowing 
when a tcp_push() is required at the end of the function. The push needs 
to happen if data has been sent. __subflow_push_pending() can be called 
more than once, and if it returned a positive number on *any* call then 
tcp_push() is required.


Option A: Continue using the 'copied' variable

Option B: Use a bool instead (like "bool do_push;").


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

Option A: "copied += ret;" here

Option B: "do_push = true;"

> 	}
>
> out:
> 	/* __mptcp_alloc_tx_skb could have released some wmem and we are
> 	 * not going to flush it via release_sock()
> 	 */
> -	if (copied) {
> +	if (ret) {

Option A: leave this unchanged

Option B: replace with "if (do_push) {"

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
