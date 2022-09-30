Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EDB1105
	for <mptcp@lists.linux.dev>; Fri, 30 Sep 2022 00:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664498670; x=1696034670;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=dAKRf/JUSVCsPd9Cmz+N0Kf6vl8TQ/3mj5S8Nx5uRAg=;
  b=V3sG2KliLOZcSZ81Mf5MfqLZofGc91hL/nAdNjd3OM0R6Z0HaFD1EdkR
   yjxT0kleHO1kbinwuaxPRLEWZ43xTAwac3PftSdNj3Xc8YrhWVIfENw7M
   MO13IhrRgBGXwBR4K+iiLm5ubCVyqOUck1OC/lDynndA+ZBL3Fo8sHjNM
   ABph2SqEf0tIdMv4Y6qJwMuVjGOQhSX6L+PnGt0etU9eQe009n7nUbIDn
   XV4aytSmRtAWaZ7bImdyalOY07qn06ds6vg7+8DVX+qVlhVb7kuD8veg/
   1N8kKdO6g5rNbrOHktP8jPjHje5AE6lSHtpPp1m+CJhfb7mphCzQRgjwT
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="281776801"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="281776801"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 17:44:30 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="653342853"
X-IronPort-AV: E=Sophos;i="5.93,357,1654585200"; 
   d="scan'208";a="653342853"
Received: from kisungle-mobl.amr.corp.intel.com ([10.209.49.82])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 17:44:29 -0700
Date: Thu, 29 Sep 2022 17:44:29 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 1/4] mptcp: update __mptcp_push_pending
In-Reply-To: <67d506626dfb793b3fc14380f1aff35e67fc6397.1664463491.git.geliang.tang@suse.com>
Message-ID: <e35178d8-1f2e-c50e-293e-bec8a9bddaf3@linux.intel.com>
References: <cover.1664463491.git.geliang.tang@suse.com> <67d506626dfb793b3fc14380f1aff35e67fc6397.1664463491.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 29 Sep 2022, Geliang Tang wrote:

> To support redundant package schedulers more easily, this patch moves the
> packet scheduler out of the dfrags loop in __mptcp_push_pending(), invoke
> mptcp_sched_get_send() only once. And update the socket locks
> correspondingly.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/protocol.c | 50 ++++++++++++++++++--------------------------
> 1 file changed, 20 insertions(+), 30 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 7ca21915b3d1..37a252a3f05b 100644
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

With msk->last_snd not used here any more, it seems like it can be 
removed.

> 	/* pick the subflow with the lower wmem/wspace ratio */
> 	for (i = 0; i < SSK_MODE_MAX; ++i) {
> 		send_info[i].ssk = NULL;
> @@ -1530,15 +1522,21 @@ void mptcp_check_and_set_pending(struct sock *sk)
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
> +	ssk = mptcp_sched_get_send(msk);
> +	if (!ssk)
> +		goto out;
> +
> +	lock_sock(ssk);
> +
> 	while ((dfrag = mptcp_send_head(sk))) {
> 		info.sent = dfrag->already_sent;
> 		info.limit = dfrag->data_len;
> @@ -1546,24 +1544,6 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> 		while (len > 0) {
> 			int ret = 0;
>
> -			prev_ssk = ssk;
> -			ssk = mptcp_sched_get_send(msk);
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
> 			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
> 			if (ret <= 0) {
> 				if (ret == -EAGAIN)
> @@ -1579,11 +1559,21 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> 			mptcp_update_post_push(msk, dfrag, ret);
> 		}
> 		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
> +
> +		if (msk->snd_burst > 0 &&
> +		    sk_stream_memory_free(ssk) &&
> +		    mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
> +			mptcp_set_timeout(sk);
> +		} else {
> +			break;
> +		}
> 	}
>
> -	/* at this point we held the socket lock for the last subflow we used */
> -	if (ssk)
> -		mptcp_push_release(ssk, &info);
> +	if (do_check_data_fin) {
> +		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
> +			 info.size_goal);
> +	}
> +	release_sock(ssk);
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
