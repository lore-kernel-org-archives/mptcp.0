Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47F7EB27
	for <mptcp@lists.linux.dev>; Tue,  6 Dec 2022 01:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670289055; x=1701825055;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=2QZ6NUMq3hdLF0NE/8cjpJTzLmmuHLKtPzWtkBO7FYs=;
  b=ZfsKCL9WLJqVC9FIbzTs0liMnq/fnOZ07nrrR7LZ7++3JSiL5AQYGdIk
   6ivrFmzXkhlECs9+8NC5Sm5kRG8zl+HFUBWtkDisCZf0Lkigr6TwfTiuj
   +L/DxYh1QDR3u1pkEJF/MLJTJhK7lCJtK0BLTbEYd6HBbJ5x2EzESAtnL
   pxsGCwDlT5yUaDpHMWmM76A8UPdqU6HWgTQSHuMRlGeiCJq0uIiDSHdL0
   V3RahjSn4/889+JLHTJ4LW1Rk+rljrxhu4LGrwHqqVVD9qQM9w1EDTUwJ
   5a14/O8Wnm0MPzrVgLGKsKK/K6VzV9LPzkGtS3IEj0Umv2xrcDXkzxVSu
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="318365434"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="318365434"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 17:10:40 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="752424878"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="752424878"
Received: from psjohns1-mobl.amr.corp.intel.com ([10.209.67.116])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 17:10:40 -0800
Date: Mon, 5 Dec 2022 17:10:40 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v22 3/5] mptcp: use get_retrans wrapper
In-Reply-To: <9aabc1cc8a9bbdbcdd887904f1ebbdcc5161bdab.1669987293.git.geliang.tang@suse.com>
Message-ID: <f7378392-670f-e312-7b0d-146de7242dbf@linux.intel.com>
References: <cover.1669987293.git.geliang.tang@suse.com> <9aabc1cc8a9bbdbcdd887904f1ebbdcc5161bdab.1669987293.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 2 Dec 2022, Geliang Tang wrote:

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
> index cef6086c7f40..7d7048b0774f 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2254,11 +2254,6 @@ struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
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
> @@ -2528,16 +2523,17 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
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
> @@ -2556,31 +2552,46 @@ static void __mptcp_retrans(struct sock *sk)
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

Like patch 2, the scheduled bit should always be cleared (on success and 
on error).

- Mat

> +		}
> +	}
> +	dfrag->already_sent = max(dfrag->already_sent, len);
>
> reset_timer:
> 	mptcp_check_and_set_pending(sk);
> diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
> index 18518a81afb3..c55f2f1cb7ac 100644
> --- a/net/mptcp/sched.c
> +++ b/net/mptcp/sched.c
> @@ -156,6 +156,12 @@ int mptcp_sched_get_retrans(struct mptcp_sock *msk)
> 	struct mptcp_subflow_context *subflow;
> 	struct mptcp_sched_data data;
>
> +	sock_owned_by_me((const struct sock *)msk);
> +
> +	/* the following check is moved out of mptcp_subflow_get_retrans */
> +	if (__mptcp_check_fallback(msk))
> +		return -EINVAL;
> +
> 	mptcp_for_each_subflow(msk, subflow) {
> 		if (READ_ONCE(subflow->scheduled))
> 			return 0;
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
