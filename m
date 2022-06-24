Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0170A7C
	for <mptcp@lists.linux.dev>; Fri, 24 Jun 2022 01:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656033605; x=1687569605;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=i9IowktddDPlm6uLMWEKaHKP4crHoIVYMXyU1BAEQa8=;
  b=OymvgypcU/yXiNYyscNkb7B61plUtl6RpZD+IR1M2JJSCfXJvzwWB97n
   kwPE8jasHh1t6Cjzq0x+9/OC4fDxr9fpTYOXoWNBxTjXxojkivcpVKRhV
   BBzedT3ySZlziS1h6tTghdgaUjKNGdsGtjrc97c/YffyH/0qhzgWwpp2v
   Tvq0eBAFOaIvMHrc6XRocJuBxHizYBZ2XiFCKJ4ip7BkDKOrBq1adFQbD
   syhHs6ES3+mvaNVs4lphoCZ+u45aXLdAYbr1Y5rSxvDSzAQDrbFXhOfAe
   UsETZu/+KdT4Toe7tY40i0nrw8+B0SAuXNnakO97AGat8R0acDqgnsD5R
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="280934773"
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="280934773"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 18:20:04 -0700
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="691302054"
Received: from jngertso-mobl1.amr.corp.intel.com ([10.212.159.56])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 18:20:04 -0700
Date: Thu, 23 Jun 2022 18:20:03 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v9 3/6] mptcp: redundant subflows push
 pending
In-Reply-To: <7845ef0db19df1d87225b22911dea3947792c711.1655995770.git.geliang.tang@suse.com>
Message-ID: <45ab37e4-f01b-92db-2365-469acbf3949@linux.intel.com>
References: <cover.1655995770.git.geliang.tang@suse.com> <7845ef0db19df1d87225b22911dea3947792c711.1655995770.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 23 Jun 2022, Geliang Tang wrote:

> This patch adds the redundant subflows support for __mptcp_push_pending().
> Use mptcp_sched_get_send() wrapper instead of mptcp_subflow_get_send()
> in it.
>
> Check the subflow scheduled flags to test which subflow or subflows are
> picked by the scheduler, use them to send data.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/protocol.c | 98 ++++++++++++++++++++++++++------------------
> 1 file changed, 57 insertions(+), 41 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 6e44786e01fd..d09b01f1dc29 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1516,63 +1516,79 @@ void mptcp_check_and_set_pending(struct sock *sk)
>
> void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> {
> -	struct sock *prev_ssk = NULL, *ssk = NULL;
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> -	struct mptcp_sendmsg_info info = {
> -				.flags = flags,
> -	};
> +	struct mptcp_subflow_context *subflow;
> 	struct mptcp_data_frag *dfrag;
> -	int len, copied = 0;
> +	int len, max = 0;
>
> -	while ((dfrag = mptcp_send_head(sk))) {
> -		info.sent = dfrag->already_sent;
> -		info.limit = dfrag->data_len;
> -		len = dfrag->data_len - dfrag->already_sent;
> -		while (len > 0) {
> -			int ret = 0;
> +	if (!mptcp_sched_get_send(msk))
> +		goto out;
>
> -			prev_ssk = ssk;
> -			ssk = mptcp_subflow_get_send(msk);
> +	dfrag = mptcp_send_head(sk);

I think the looping structure in v7 was closer to what is needed.

Each subflow needs to be able to send from multiple dfrags if they are 
able to.

> +	if (!dfrag)
> +		goto out;
>
> -			/* First check. If the ssk has changed since
> -			 * the last round, release prev_ssk
> -			 */
> -			if (ssk != prev_ssk && prev_ssk)
> -				mptcp_push_release(prev_ssk, &info);
> -			if (!ssk)
> -				goto out;
> +	mptcp_for_each_subflow(msk, subflow) {
> +		if (READ_ONCE(subflow->scheduled)) {
> +			struct sock *prev_ssk = NULL, *ssk = NULL;
> +			struct mptcp_sendmsg_info info = {
> +				.flags = flags,
> +			};
> +			int copied = 0;
>
> -			/* Need to lock the new subflow only if different
> -			 * from the previous one, otherwise we are still
> -			 * helding the relevant lock
> -			 */
> -			if (ssk != prev_ssk)
> -				lock_sock(ssk);


There still needs to be a loop here (like in v7) that allows multiple 
calls to mptcp_sendmsg_frag(). Each subflow *starts* sending at the 
initial dfrag, but can send any amount of data from the available list of 
dfrags. If msk->first_pending has not been updated until after all 
subflows are done, that can be used as the starting point for each 
subflow.


> +			info.sent = dfrag->already_sent;
> +			info.limit = dfrag->data_len;
> +			len = dfrag->data_len - dfrag->already_sent;
> +			while (len > 0) {
> +				int ret = 0;
>
> -			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
> -			if (ret <= 0) {
> -				mptcp_push_release(ssk, &info);
> -				goto out;
> -			}
> +				prev_ssk = ssk;
> +				ssk = mptcp_subflow_tcp_sock(subflow);
>
> -			info.sent += ret;
> -			copied += ret;
> -			len -= ret;
> +				/* First check. If the ssk has changed since
> +				 * the last round, release prev_ssk
> +				 */
> +				if (ssk != prev_ssk && prev_ssk)
> +					mptcp_push_release(prev_ssk, &info);
> +				if (!ssk)
> +					goto out;
> +
> +				/* Need to lock the new subflow only if different
> +				 * from the previous one, otherwise we are still
> +				 * helding the relevant lock
> +				 */
> +				if (ssk != prev_ssk)
> +					lock_sock(ssk);
> +
> +				ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
> +				if (ret <= 0) {
> +					mptcp_push_release(ssk, &info);
> +					goto out;
> +				}
> +
> +				info.sent += ret;
> +				copied += ret;
> +				len -= ret;
> +			}
> +			max = max(copied, max);

Would be good to use a variable name other than "max" so it doesn't match 
the macro name here.

>
> -			mptcp_update_post_push(msk, dfrag, ret);
> +			/* at this point we held the socket lock for the last subflow we used */
> +			if (ssk) {
> +				mptcp_push_release(ssk, &info);
> +				msk->last_snd = ssk;
> +				mptcp_subflow_set_scheduled(subflow, false);
> +			}
> 		}
> -		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
> 	}
> -
> -	/* at this point we held the socket lock for the last subflow we used */
> -	if (ssk)
> -		mptcp_push_release(ssk, &info);
> +	if (max)
> +		mptcp_update_post_push(msk, dfrag, max);
> +	WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));

With the notes above on supporting multiple dfrags, 
mptcp_update_post_push() also will need to be more complicated. It will 
have to update all dfrags that were sent.

>
> out:
> 	/* ensure the rtx timer is running */
> 	if (!mptcp_timer_pending(sk))
> 		mptcp_reset_timer(sk);
> -	if (copied)
> +	if (max)
> 		__mptcp_check_send_data_fin(sk);
> }
>
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
