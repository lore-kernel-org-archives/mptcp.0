Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E991F15AC
	for <mptcp@lists.linux.dev>; Tue, 11 Oct 2022 00:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665448702; x=1696984702;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=k1tLGU0fLujVaHjZ7/IAfwPosl19S5OTgO5/9VcYzIA=;
  b=I+dKfcdC8TTqxRsKowVQgMVHrwkYzI+s+2/co9KupHsqbp1uirPjZbin
   zz4wnBb5MdTpAz0B4XMLTlwlmHJQvhAHYL1DLxK+eeOpQmAJJk36GeWmq
   CNyUx8b96SoBCqRUSc7PPaw5oFWAr40cQiyxiEBbVCnFl6M0BCWVgcwWT
   h0FZ5r55wIY50r09l7cVen9cR3Izop8X98m1oBVKIuw8A6N9zzRepOeyB
   b+fvP7ZUCffqoKnWIvub8Mo48DwHrEq7A1chSb/Yu9dQIzNv4i5f0sEsD
   o+uU3OQPqKkcMrH0noiHNqh6JGF0asGxzJoXyEQCZXjr0C2tijaZIkxZ3
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="301979594"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="301979594"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 17:38:22 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="730761743"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="730761743"
Received: from pnle-mobl.amr.corp.intel.com ([10.212.235.19])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 17:38:22 -0700
Date: Mon, 10 Oct 2022 17:38:21 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v5 03/11] mptcp: refactor push_pending logic
In-Reply-To: <c2a2b84b94b75d02fedd4166d2d1d73297a76bbc.1665058388.git.geliang.tang@suse.com>
Message-ID: <9bd1bda2-2d18-291c-9370-d85e601e5e6d@linux.intel.com>
References: <cover.1665058388.git.geliang.tang@suse.com> <c2a2b84b94b75d02fedd4166d2d1d73297a76bbc.1665058388.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 6 Oct 2022, Geliang Tang wrote:

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
> to:
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
> This patch alse moves the burst check conditions out of the function
> mptcp_subflow_get_send(), check them in __mptcp_push_pending() and
> __mptcp_subflow_push_pending() in the inner "for each pending dfrag"
> loop.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/protocol.c | 86 ++++++++++++++++++++------------------------
> 1 file changed, 39 insertions(+), 47 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 84d33393d24e..bf77defbc546 100644
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
> @@ -1530,60 +1522,53 @@ void mptcp_check_and_set_pending(struct sock *sk)
>
> void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> {
> -	struct sock *prev_ssk = NULL, *ssk = NULL;
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> 	struct mptcp_sendmsg_info info = {
> 				.flags = flags,
> 	};
> 	bool do_check_data_fin = false;
> 	struct mptcp_data_frag *dfrag;
> +	struct sock *ssk;
> 	int len;
>
> -	while ((dfrag = mptcp_send_head(sk))) {
> -		info.sent = dfrag->already_sent;
> -		info.limit = dfrag->data_len;
> -		len = dfrag->data_len - dfrag->already_sent;
> -		while (len > 0) {
> -			int ret = 0;
> -
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
> +again:
> +	while (mptcp_send_head(sk) && (ssk = mptcp_subflow_get_send(msk))) {
> +		lock_sock(ssk);
>
> -			/* Need to lock the new subflow only if different
> -			 * from the previous one, otherwise we are still
> -			 * helding the relevant lock
> -			 */
> -			if (ssk != prev_ssk)
> -				lock_sock(ssk);
> +		while ((dfrag = mptcp_send_head(sk))) {
> +			info.sent = dfrag->already_sent;
> +			info.limit = dfrag->data_len;
> +			len = dfrag->data_len - dfrag->already_sent;
> +			while (len > 0) {
> +				int ret = 0;
> +
> +				ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
> +				if (ret <= 0) {
> +					if (ret == -EAGAIN)
> +						goto again;

ssk is still locked here, so the lock_sock(ssk) could deadlock or leave 
the ssk locked when another is selected by mptcp_subflow_get_send().


- Mat

> +					mptcp_push_release(ssk, &info);
> +					goto out;
> +				}
> +
> +				do_check_data_fin = true;
> +				info.sent += ret;
> +				len -= ret;
> +
> +				mptcp_update_post_push(msk, dfrag, ret);
> +			}
> +			WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
>
> -			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
> -			if (ret <= 0) {
> -				if (ret == -EAGAIN)
> -					continue;
> +			if (msk->snd_burst <= 0 ||
> +			    !sk_stream_memory_free(ssk) ||
> +			    !mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
> 				mptcp_push_release(ssk, &info);
> -				goto out;
> +				goto again;
> 			}
> -
> -			do_check_data_fin = true;
> -			info.sent += ret;
> -			len -= ret;
> -
> -			mptcp_update_post_push(msk, dfrag, ret);
> +			mptcp_set_timeout(sk);
> 		}
> -		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
> -	}
>
> -	/* at this point we held the socket lock for the last subflow we used */
> -	if (ssk)
> 		mptcp_push_release(ssk, &info);
> +	}
>
> out:
> 	/* ensure the rtx timer is running */
> @@ -1636,6 +1621,13 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
> 			mptcp_update_post_push(msk, dfrag, ret);
> 		}
> 		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
> +
> +		if (msk->snd_burst <= 0 ||
> +		    !sk_stream_memory_free(ssk) ||
> +		    !mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
> +			goto out;
> +		}
> +		mptcp_set_timeout(sk);
> 	}
>
> out:
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
