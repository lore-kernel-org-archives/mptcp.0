Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56159364
	for <mptcp@lists.linux.dev>; Wed,  5 Oct 2022 00:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664929425; x=1696465425;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=W+1NySwXAes4LOzL+KCSjHlJLpm0xqUZ8Rzn5HNxtS8=;
  b=P/k5IML0TGJd1oZ7gyG8jXFQR6iBOVwon0nYkZznaV2FyQDx/uA/x7Ew
   w7ZIB3ZQga42DHpaWXZv8/fShpg/mmTf4ykLGWxoZYlZfjvVp9Sb17Nos
   mSKzPjtNFMpdczCxi08GEeg3rg5HAh1rcJOGXhmuckJp6yzl4pcuVlJA4
   huVB2osSR6DSaB7RB3PNzTUMKR7/Y9QLGid8ReyTWHJSk/fj5IWHJmA9i
   5IBh3iimqphKPmBwsFrdXpD7pfU7Dbz5vFOa6wAkNnoSM47cjzYp8Z7dm
   6MC+/HeuZj8ldD5RJftxbfEKT+L9HqZLL9MX5VzasLi1W6/Qu/VYlKENB
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="300658039"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="300658039"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 17:23:44 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="799331745"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="799331745"
Received: from jessicat-mobl.amr.corp.intel.com ([10.209.12.163])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 17:23:44 -0700
Date: Tue, 4 Oct 2022 17:23:42 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v4 04/11] mptcp: refactor push_pending logic
In-Reply-To: <c37e1bfc52a855cfe861a5e97cafbd02b3395601.1664720538.git.geliang.tang@suse.com>
Message-ID: <820be04a-9e9b-3df0-fa9e-4a7ff1d6a514@linux.intel.com>
References: <cover.1664720538.git.geliang.tang@suse.com> <c37e1bfc52a855cfe861a5e97cafbd02b3395601.1664720538.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Sun, 2 Oct 2022, Geliang Tang wrote:

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
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/protocol.c | 76 +++++++++++++++++---------------------------
> 1 file changed, 30 insertions(+), 46 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 785c52b738cf..296b7135e9cf 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1519,67 +1519,51 @@ void mptcp_check_and_set_pending(struct sock *sk)
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
> +						continue;
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
> -				mptcp_push_release(ssk, &info);
> +			if (msk->snd_burst <= 0 ||
> +			    !sk_stream_memory_free(ssk) ||
> +			    !mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
> 				goto out;

When a burst is over, the scheduler needs to be called again. So rather 
than jumping out of both loops, this should repeat the outer while loop.

It also looks like there are code paths where mptcp_push_release() is not 
called, so the ssk is never unlocked. That should be fixed so this patch 
does not break git bisection.

- Mat

> 			}
> -
> -			do_check_data_fin = true;
> -			info.sent += ret;
> -			len -= ret;
> -
> -			mptcp_update_post_push(msk, dfrag, ret);
> -		}
> -		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
> -
> -		if (msk->snd_burst <= 0 ||
> -		    !sk_stream_memory_free(ssk) ||
> -		    !mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
> -			goto out;
> +			mptcp_set_timeout(sk);
> 		}
> -		mptcp_set_timeout(sk);
> -	}
>
> -	/* at this point we held the socket lock for the last subflow we used */
> -	if (ssk)
> 		mptcp_push_release(ssk, &info);
> +	}
>
> out:
> 	/* ensure the rtx timer is running */
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
