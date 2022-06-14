Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2AE1376
	for <mptcp@lists.linux.dev>; Tue, 14 Jun 2022 00:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655166831; x=1686702831;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Lc06E4xAdlAjXhdQLVOin6nlJNthBr0CVLzISIzqlS8=;
  b=RUv0nLvHZb0QIskgXkW5g9K0a08Y01fxzmE4Q1KS0njzmSnjpQIVfVjK
   Pc45M6S5hUPWRkgEUJhjmEag9KujzmhqOeqWkkCeKx421RO1rBzlCQQ6u
   /0k9IfzkSueZSGAtummvdUlH4thwKYoaPWvRoAsd0kFMFmjaNEzJhO8Hc
   9+MzbixNMIr+iZMOBcG4N2Pcy3eaZ1URX4SYbEofIb/QlEYG4+YOt5ZQG
   nmo/vVEIE2wn74rPGeZwgbIXHnUQV4c2mDBzJ339nuRO1iv2BwryXDRKL
   O/hBmCtPCalSX2EFBFpdpPwaCgVF098UjfrhqPn5ZhamOGYsUTT5ETuIe
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="258901912"
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="258901912"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 17:33:50 -0700
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="558072360"
Received: from jfgiesbe-mobl.amr.corp.intel.com ([10.209.95.28])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 17:33:50 -0700
Date: Mon, 13 Jun 2022 17:33:50 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v6 5/9] mptcp: redundant subflows retrans
 support
In-Reply-To: <6dbc73c8c56b540167488f9fd3f58e6417ab5620.1654865847.git.geliang.tang@suse.com>
Message-ID: <af4a1771-d62-88b9-82e8-d16fa5eae833@linux.intel.com>
References: <cover.1654865847.git.geliang.tang@suse.com> <6dbc73c8c56b540167488f9fd3f58e6417ab5620.1654865847.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 10 Jun 2022, Geliang Tang wrote:

> This patch adds the redundant subflows support for __mptcp_retrans(). In
> it, use sched_get_retrans() wrapper instead of mptcp_subflow_get_retrans().
>
> Iterate each subflow of msk, check the scheduled flag to test if it is
> picked by the scheduler. If so, use it to send data.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/protocol.c | 49 +++++++++++++++++++++++++++++---------------
> 1 file changed, 32 insertions(+), 17 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 3bb3445c1eaf..14d3637d1e88 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2490,16 +2490,14 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
> static void __mptcp_retrans(struct sock *sk)
> {
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct mptcp_subflow_context *subflow;
> 	struct mptcp_sendmsg_info info = {};
> 	struct mptcp_data_frag *dfrag;
> 	size_t copied = 0;
> 	struct sock *ssk;
> -	int ret;
>
> 	mptcp_clean_una_wakeup(sk);
>
> -	/* first check ssk: need to kick "stale" logic */
> -	ssk = mptcp_subflow_get_retrans(msk);
> 	dfrag = mptcp_rtx_head(sk);
> 	if (!dfrag) {
> 		if (mptcp_data_fin_enabled(msk)) {
> @@ -2518,32 +2516,49 @@ static void __mptcp_retrans(struct sock *sk)
> 		goto reset_timer;
> 	}
>
> -	if (!ssk)
> -		goto reset_timer;
> -
> -	lock_sock(ssk);
> -
> 	/* limit retransmission to the bytes already sent on some subflows */
> 	info.sent = 0;
> 	info.limit = READ_ONCE(msk->csum_enabled) ? dfrag->data_len : dfrag->already_sent;
> 	while (info.sent < info.limit) {
> -		ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
> -		if (ret <= 0)
> -			break;
> +		int ret = 0, max = 0, err;
> +
> +		err = mptcp_sched_get_retrans(msk);

The existing code calls the scheduler once and then loops to send data on 
the selected subflow.

I think the redundant scheduler can still work like that: call the 
scheduler once, then try to retransmit on each of the scheduled subflows. 
If we can reduce the number of calls to the scheduler, and also call 
mptcp_sendmsg_frag() multiple times on each subflow without releasing the 
lock, that's much more efficient.

> +		if (err)
> +			goto reset_timer;
> +
> +		mptcp_for_each_subflow(msk, subflow) {
> +			if (READ_ONCE(subflow->scheduled)) {
> +				ssk = mptcp_subflow_tcp_sock(subflow);
> +				if (!ssk)
> +					goto reset_timer;
>
> +				lock_sock(ssk);
> +
> +				ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
> +				if (ret <= 0)
> +					break;
> +
> +				if (ret > max)
> +					max = ret;
> +
> +				tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
> +					 info.size_goal);
> +
> +				release_sock(ssk);
> +
> +				msk->last_snd = ssk;
> +				mptcp_subflow_set_scheduled(subflow, false);
> +			}
> +		}
> 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RETRANSSEGS);
> -		copied += ret;
> -		info.sent += ret;
> +		copied += max;
> +		info.sent += max;
> 	}
> 	if (copied) {
> 		dfrag->already_sent = max(dfrag->already_sent, info.sent);
> -		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
> -			 info.size_goal);
> 		WRITE_ONCE(msk->allow_infinite_fallback, false);
> 	}
>
> -	release_sock(ssk);
> -
> reset_timer:
> 	mptcp_check_and_set_pending(sk);
>
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
