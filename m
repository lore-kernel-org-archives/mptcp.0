Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C8C375
	for <mptcp@lists.linux.dev>; Wed,  5 Oct 2022 00:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664930030; x=1696466030;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=EP40TIxfCdK6EWasNHWVWsZEE8ZiilPQNLBOdYuyTFE=;
  b=iSsAXtdv8QZFrPuzniIU/1iTvkCSo0YRtzCnFpIBiTSTtre4+mdoB+5o
   WEHh45016E75XO0uSDYWhYttoM1t0UcyA7t7be6EsAXWZ31y9URY5jVJv
   N5Xh7wAve1weDbDAjmSTtQQrXY+y7eZJ/Z6I7x5eg9+rc9J0OVT5/MwGa
   TdEOKefoCZjoxuxMjbbCJI15zTyCrqijfc5G1OR2RlmdR0sNOeBfpFUrD
   lO4PZ8idDtB0lN1ZpCnFFDCSm/OgMoe7nbPrBoNmnndmg8vPQj/cxjna+
   l9fCfe4JhlTeCDh18XAgSRXvW0Wa5RiYBs1zApN9ofEylxKJlke+XdAlO
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="389350954"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="389350954"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 17:33:49 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="799334200"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="799334200"
Received: from jessicat-mobl.amr.corp.intel.com ([10.209.12.163])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 17:33:49 -0700
Date: Tue, 4 Oct 2022 17:33:49 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v4 05/11] mptcp: simplify push_pending
In-Reply-To: <b0c832c5f1b3dfaf20a7ade32968c78eaf228482.1664720538.git.geliang.tang@suse.com>
Message-ID: <171d9a6f-9628-4989-677c-9a6ac38a5880@linux.intel.com>
References: <cover.1664720538.git.geliang.tang@suse.com> <b0c832c5f1b3dfaf20a7ade32968c78eaf228482.1664720538.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Sun, 2 Oct 2022, Geliang Tang wrote:

> This patch moves the duplicate code from __mptcp_push_pending() and
> __mptcp_subflow_push_pending() into a new helper function, named
> __subflow_push_pending(). And simplify __mptcp_push_pending() by
> invoking this helper.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/protocol.c | 90 +++++++++++++++++++++++---------------------
> 1 file changed, 48 insertions(+), 42 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 296b7135e9cf..66c97ac06a4e 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1480,12 +1480,6 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
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
> @@ -1517,6 +1511,52 @@ void mptcp_check_and_set_pending(struct sock *sk)
> 		mptcp_sk(sk)->push_pending |= BIT(MPTCP_PUSH_PENDING);
> }
>
> +static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
> +				  struct mptcp_sendmsg_info *info)
> +{
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct mptcp_data_frag *dfrag;
> +	int len, copied = 0;
> +
> +	while ((dfrag = mptcp_send_head(sk))) {
> +		info->sent = dfrag->already_sent;
> +		info->limit = dfrag->data_len;
> +		len = dfrag->data_len - dfrag->already_sent;
> +		while (len > 0) {
> +			int ret = 0;
> +
> +			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, info);
> +			if (ret <= 0) {
> +				if (ret == -EAGAIN)
> +					continue;

In the older code, the scheduler got called again in the -EAGAIN case. 
With this refactored code, this could get in a very tight loop if 
mptcp_sendmsg_frag() returns. I think it's necessary to cleanly finish 
this loop iteration and let the scheduler run again in this -EAGAIN case.

> +				goto out;
> +			}
> +
> +			info->sent += ret;
> +			copied += ret;
> +			len -= ret;
> +
> +			mptcp_update_post_push(msk, dfrag, ret);
> +		}
> +		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
> +
> +		if (msk->snd_burst <= 0 ||
> +		    !sk_stream_memory_free(ssk) ||
> +		    !mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
> +			goto out;
> +		}
> +		mptcp_set_timeout(sk);
> +	}
> +
> +out:
> +	if (copied) {
> +		tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle,
> +			 info->size_goal);
> +	}
> +
> +	return copied;
> +}
> +
> void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> {
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> @@ -1524,48 +1564,14 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> 				.flags = flags,
> 	};
> 	bool do_check_data_fin = false;
> -	struct mptcp_data_frag *dfrag;
> 	struct sock *ssk;
> -	int len;
>
> 	while (mptcp_send_head(sk) && (ssk = mptcp_subflow_get_send(msk))) {
> 		lock_sock(ssk);
> -
> -		while ((dfrag = mptcp_send_head(sk))) {
> -			info.sent = dfrag->already_sent;
> -			info.limit = dfrag->data_len;
> -			len = dfrag->data_len - dfrag->already_sent;
> -			while (len > 0) {
> -				int ret = 0;
> -
> -				ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
> -				if (ret <= 0) {
> -					if (ret == -EAGAIN)
> -						continue;
> -					mptcp_push_release(ssk, &info);
> -					goto out;
> -				}
> -
> -				do_check_data_fin = true;
> -				info.sent += ret;
> -				len -= ret;
> -
> -				mptcp_update_post_push(msk, dfrag, ret);
> -			}
> -			WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
> -
> -			if (msk->snd_burst <= 0 ||
> -			    !sk_stream_memory_free(ssk) ||
> -			    !mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
> -				goto out;
> -			}
> -			mptcp_set_timeout(sk);
> -		}
> -
> -		mptcp_push_release(ssk, &info);
> +		do_check_data_fin = __subflow_push_pending(sk, ssk, &info);

do_check_data_fin is a bool, but __subflow_push_pending() returns an 
int (the number of bytes copied). Looking at the other patches, the int 
value is needed. I suggest assigning the int return value to an int 
variable:

 		copied = __subflow_push_pending(sk, ssk, &info);

and updating the 'if' statement below...

> +		release_sock(ssk);
> 	}
>
> -out:
> 	/* ensure the rtx timer is running */
> 	if (!mptcp_timer_pending(sk))
> 		mptcp_reset_timer(sk);
>	if (do_check_data_fin)
> 		__mptcp_check_send_data_fin(sk);

...like this:

 	if (copied > 0)
  		__mptcp_check_send_data_fin(sk);


Thanks,

--
Mat Martineau
Intel
