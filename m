Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6DB7C
	for <mptcp@lists.linux.dev>; Tue,  7 Jun 2022 00:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654562802; x=1686098802;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=o2vSbz65uRQS7IADVZwztn47aD1Zb9djCelpjrQH4ms=;
  b=bp67INHBkfk3lcUNsnuoSPwuYiPIVYkQQ4FaY20TOyTswsbHplyYrQyV
   ijgA6Laf8D2AzJ5nnt09mbUhKkxmdxBf7CIs9l2nvLILhiZ0HtyoUqANO
   UILpFzOW9AFIUhODqt2ji4d33hFkWC5+17yX1UqyAhB4C5XDGxT2XMOjr
   MwW2uw9B4/C4GDfPvKsPhs4WTXAxD+YSe4d663K4aCzdDYkuzZRzWLyy4
   /Sqm0N+rTOQWfFhm1DevcOxpxRBzu5FL171FsfpTMNiT86lQ1ZK8/7cKC
   il3S7aI8RhAtIHnT5dyuhbhutb+tYLWtonQ+ESMO3GelZyvjQA/m4ghfA
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="276945901"
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="276945901"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 17:46:42 -0700
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="758795158"
Received: from mgudaram-mobl1.amr.corp.intel.com ([10.209.43.78])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 17:46:42 -0700
Date: Mon, 6 Jun 2022 17:46:42 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v5 2/7] mptcp: redundant subflows push
 pending
In-Reply-To: <c456d88a1c0e71ecf5849f1dbd93524422c818a0.1654526068.git.geliang.tang@suse.com>
Message-ID: <b3a9c42-2573-a083-b28b-34738eac7fd9@linux.intel.com>
References: <cover.1654526068.git.geliang.tang@suse.com> <c456d88a1c0e71ecf5849f1dbd93524422c818a0.1654526068.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 6 Jun 2022, Geliang Tang wrote:

> This patch adds the redundant subflows support for __mptcp_push_pending().
> Use mptcp_sched_get_send() wrapper instead of mptcp_subflow_get_send()
> in it.
>
> Check the subflow scheduled flags to test which subflow or subflows are
> picked by the scheduler, use them to send data.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/protocol.c | 63 ++++++++++++++++++++++----------------------
> net/mptcp/subflow.c  |  1 -
> 2 files changed, 32 insertions(+), 32 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 8d93df73a9e3..8bf48387f9d8 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1551,58 +1551,59 @@ void mptcp_check_and_set_pending(struct sock *sk)
>
> void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> {
> -	struct sock *prev_ssk = NULL, *ssk = NULL;
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct mptcp_subflow_context *subflow;
> 	struct mptcp_sendmsg_info info = {
> -				.flags = flags,
> +		.flags = flags,
> 	};
> 	struct mptcp_data_frag *dfrag;
> -	int len, copied = 0;
> +	int len, copied = 0, err = 0;
> +	struct sock *ssk = NULL;
>
> 	while ((dfrag = mptcp_send_head(sk))) {
> 		info.sent = dfrag->already_sent;
> 		info.limit = dfrag->data_len;
> 		len = dfrag->data_len - dfrag->already_sent;
> 		while (len > 0) {
> -			int ret = 0;
> +			int ret = 0, max = 0;
>
> -			prev_ssk = ssk;

Removing prev_ssk and the optimizations related to it will affect the 
performance of non-redundant schedulers (which is most of them). It forces 
a separate lock and tcp_push call for every dfrag. The optimization is 
important to keep, but using it with a redundant scheduler means changing 
this transmit loop.

There are some options for how to handle redundant schedulers and 
optimization:

1. Only optimize non-redundant schedulers. Redundant schedulers will 
require lock/tcp_push/unlock for each scheduled subflow.

2. Change the transmit loop to instead call the scheduler first, and then 
send multiple fragments on each scheduled subflow.


Option 2 would need more information from the scheduler I think: for 
example, the number of bytes to schedule. Instead of just the 'scheduled' 
flag, the subflow context could store more information about the range of 
sequence numbers to send.

Another approach could be to use something like the current code to send 
as much data as possible on the first selected subflow, then for redundant 
subflows use the retransmit code to send data again.


There's a lot of complexity here: changing the (re)transmit and scheduler 
loops, modifying the BPF API, keeping or improving existing performance. I 
think it's worth talking about at the meeting again.


- Mat

> -			ssk = mptcp_subflow_get_send(msk);
> -
> -			/* First check. If the ssk has changed since
> -			 * the last round, release prev_ssk
> -			 */
> -			if (ssk != prev_ssk && prev_ssk)
> -				mptcp_push_release(prev_ssk, &info);
> -			if (!ssk)
> +			mptcp_sched_get_send(msk, &err);
> +			if (err)
> 				goto out;
>
> -			/* Need to lock the new subflow only if different
> -			 * from the previous one, otherwise we are still
> -			 * helding the relevant lock
> -			 */
> -			if (ssk != prev_ssk)
> -				lock_sock(ssk);
> +			mptcp_for_each_subflow(msk, subflow) {
> +				if (READ_ONCE(subflow->scheduled)) {
> +					ssk = mptcp_subflow_tcp_sock(subflow);
> +					if (!ssk)
> +						goto out;
>
> -			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
> -			if (ret <= 0) {
> -				mptcp_push_release(ssk, &info);
> -				goto out;
> +					lock_sock(ssk);
> +
> +					ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
> +					if (ret <= 0) {
> +						mptcp_push_release(ssk, &info);
> +						goto out;
> +					}
> +
> +					if (ret > max)
> +						max = ret;
> +
> +					mptcp_push_release(ssk, &info);
> +
> +					msk->last_snd = ssk;
> +					mptcp_subflow_set_scheduled(subflow, false);
> +				}
> 			}
>
> -			info.sent += ret;
> -			copied += ret;
> -			len -= ret;
> +			info.sent += max;
> +			copied += max;
> +			len -= max;
>
> -			mptcp_update_post_push(msk, dfrag, ret);
> +			mptcp_update_post_push(msk, dfrag, max);
> 		}
> 		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
> 	}
>
> -	/* at this point we held the socket lock for the last subflow we used */
> -	if (ssk)
> -		mptcp_push_release(ssk, &info);
> -
> out:
> 	/* ensure the rtx timer is running */
> 	if (!mptcp_timer_pending(sk))
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 8841e8cd9ad8..e7864a413192 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -881,7 +881,6 @@ static bool validate_mapping(struct sock *ssk, struct sk_buff *skb)
> 				  subflow->map_data_len))) {
> 		/* Mapping does covers past subflow data, invalid */
> 		dbg_bad_map(subflow, ssn);
> -		return false;
> 	}
> 	return true;
> }
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
