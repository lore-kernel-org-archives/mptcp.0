Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C18A492
	for <mptcp@lists.linux.dev>; Fri, 18 Nov 2022 22:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668809103; x=1700345103;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=gcOYYM8rbmkWYUg6Wz88Zw+hpZC6qwVASwoxORmYLHk=;
  b=TirtSfZoD5Pg0MMghB5E1LFpr534FBh+33OJ3PJGcCscsz/FF+/k4ZRQ
   n4d1sPGpTx4kpR1l6qAhDSo9C07weQ+wLhf7hmiUM+GALf/cuJcoxAMor
   bzc61sGfqIOVgr+1rhiYjCInyD+RiHZw5BGu4eFJxxeYXg0I3vI0x9ymv
   L2QFKGJ8lyVNCqeKvtgqpCSBQlXroxuK+gJ++1+Umn6i+5MTg/IaRs+Tj
   pI9xtikOvweW/EfsIzyp0i4sfTaPMnCCK7w6ct8wJhmATOAfLqdVi3LWZ
   NMOTv35lgIUGSl4sbxLH3geUohm+tRRw831Bh0hQ+dMcSEczWXwV+n/qk
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="375391101"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="375391101"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 14:05:02 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="969426760"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="969426760"
Received: from kwells1-mobl1.amr.corp.intel.com ([10.212.140.181])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 14:05:02 -0800
Date: Fri, 18 Nov 2022 14:05:01 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v20 3/7] mptcp: use get_retrans wrapper
In-Reply-To: <50e0da978b8ee4d3a6880eaf843c6697192d43f6.1668598782.git.geliang.tang@suse.com>
Message-ID: <87d65560-81e5-5c74-104a-d6a5cca7edcf@linux.intel.com>
References: <cover.1668598782.git.geliang.tang@suse.com> <50e0da978b8ee4d3a6880eaf843c6697192d43f6.1668598782.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 16 Nov 2022, Geliang Tang wrote:

> This patch adds the multiple subflows support for __mptcp_retrans(). Use
> get_retrans() wrapper instead of mptcp_subflow_get_retrans() in it.
>
> Check the subflow scheduled flags to test which subflow or subflows are
> picked by the scheduler, use them to send data.
>
> Move sock_owned_by_me() check and fallback check into get_retrans()
> wrapper from mptcp_subflow_get_retrans().
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/protocol.c | 67 ++++++++++++++++++++++++++------------------
> net/mptcp/sched.c    |  6 ++++
> 2 files changed, 45 insertions(+), 28 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index f3720923b22d..b8265badbe29 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2242,11 +2242,6 @@ struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
> 	struct mptcp_subflow_context *subflow;
> 	int min_stale_count = INT_MAX;
>
> -	sock_owned_by_me((const struct sock *)msk);
> -
> -	if (__mptcp_check_fallback(msk))
> -		return NULL;
> -
> 	mptcp_for_each_subflow(msk, subflow) {
> 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
>
> @@ -2521,16 +2516,17 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
> static void __mptcp_retrans(struct sock *sk)
> {
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct mptcp_subflow_context *subflow;
> 	struct mptcp_sendmsg_info info = {};
> 	struct mptcp_data_frag *dfrag;
> -	size_t copied = 0;
> 	struct sock *ssk;
> -	int ret;
> +	int ret, err;
> +	u16 len = 0;
>
> 	mptcp_clean_una_wakeup(sk);
>
> 	/* first check ssk: need to kick "stale" logic */
> -	ssk = mptcp_subflow_get_retrans(msk);
> +	err = mptcp_sched_get_retrans(msk);
> 	dfrag = mptcp_rtx_head(sk);
> 	if (!dfrag) {
> 		if (mptcp_data_fin_enabled(msk)) {
> @@ -2549,31 +2545,46 @@ static void __mptcp_retrans(struct sock *sk)
> 		goto reset_timer;
> 	}
>
> -	if (!ssk)
> +	if (err)
> 		goto reset_timer;
>
> -	lock_sock(ssk);
> +	mptcp_for_each_subflow(msk, subflow) {
> +		if (READ_ONCE(subflow->scheduled)) {
> +			u16 copied = 0;
>
> -	/* limit retransmission to the bytes already sent on some subflows */
> -	info.sent = 0;
> -	info.limit = READ_ONCE(msk->csum_enabled) ? dfrag->data_len : dfrag->already_sent;
> -	while (info.sent < info.limit) {
> -		ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
> -		if (ret <= 0)
> -			break;
> +			ssk = mptcp_subflow_tcp_sock(subflow);
> +			if (!ssk)
> +				goto reset_timer;
>
> -		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RETRANSSEGS);
> -		copied += ret;
> -		info.sent += ret;
> -	}
> -	if (copied) {
> -		dfrag->already_sent = max(dfrag->already_sent, info.sent);
> -		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
> -			 info.size_goal);
> -		WRITE_ONCE(msk->allow_infinite_fallback, false);
> -	}
> +			lock_sock(ssk);
>
> -	release_sock(ssk);
> +			/* limit retransmission to the bytes already sent on some subflows */
> +			info.sent = 0;
> +			info.limit = READ_ONCE(msk->csum_enabled) ? dfrag->data_len :
> +								    dfrag->already_sent;
> +			while (info.sent < info.limit) {
> +				ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
> +				if (ret <= 0)
> +					break;
> +
> +				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RETRANSSEGS);
> +				copied += ret;
> +				info.sent += ret;
> +			}
> +			if (copied) {
> +				len = max(copied, len);
> +				tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
> +					 info.size_goal);
> +				WRITE_ONCE(msk->allow_infinite_fallback, false);
> +			}
> +
> +			release_sock(ssk);
> +
> +			msk->last_snd = ssk;
> +			mptcp_subflow_set_scheduled(subflow, false);
> +		}
> +	}
> +	dfrag->already_sent = max(dfrag->already_sent, len);
>
> reset_timer:
> 	mptcp_check_and_set_pending(sk);
> diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
> index 923c07296ff3..edddd7cceada 100644
> --- a/net/mptcp/sched.c
> +++ b/net/mptcp/sched.c
> @@ -156,11 +156,17 @@ int mptcp_sched_get_retrans(struct mptcp_sock *msk)
> 	struct mptcp_sched_data data;
> 	struct sock *ssk = NULL;
>
> +	sock_owned_by_me((const struct sock *)msk);
> +
> 	mptcp_for_each_subflow(msk, subflow) {
> 		if (READ_ONCE(subflow->scheduled))
> 			return 0;
> 	}
>
> +	/* the following check is moved out of mptcp_subflow_get_retrans */
> +	if (__mptcp_check_fallback(msk))
> +		return -EINVAL;
> +

Like the previous patch, I think this fits better before the 
mptcp_for_each_subflow().

> 	if (!msk->sched) {
> 		ssk = mptcp_subflow_get_retrans(msk);
> 		if (!ssk)
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
