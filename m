Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FED194
	for <mptcp@lists.linux.dev>; Tue,  6 Dec 2022 01:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670290644; x=1701826644;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=0ro1/ykGul10/TrHJiH+cZvLaUInTqQ5qoaR/8c7Hp0=;
  b=f+M5UpYQn3JPA+9q0fNfmsKLxqetgObluS5I7m+YzDTpSXhXAQXYD71L
   oC3HtJm6xcfjNBGh8LmrTN3g8QowMz+V9efB9pL/OscJ5KNE3aRJmSg0I
   wOytcI3LDr1ju8qZfmMPluMgnzcZxei84k9nNNUvisRMela03opwEPOTb
   1f4W9/ddbse0zrYGCV9jhyskhVAPdP9aeX+62iJpaqsh+FgPRMxWZWmJS
   EO7xY3Vu6DRD1yTKcmIooRZvV3VsGkqsxjGxjaEXbTE6svHIosQPUvmiG
   ogtIwEi1i5KuDptx9N/VJ6Tj8qKeL7V5493tv0LUgTc1viw+VXqw+TBDi
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="318370653"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="318370653"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 17:37:24 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="820407045"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="820407045"
Received: from psjohns1-mobl.amr.corp.intel.com ([10.209.67.116])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 17:37:23 -0800
Date: Mon, 5 Dec 2022 17:37:23 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 2/2] mptcp: retrans for redundant sends
In-Reply-To: <b302a1c5caefc522b8721d099c6a353487fa5c40.1670243225.git.geliang.tang@suse.com>
Message-ID: <9b671ec9-4b5e-bdbc-b54e-e78bf0867cf3@linux.intel.com>
References: <cover.1670243225.git.geliang.tang@suse.com> <b302a1c5caefc522b8721d099c6a353487fa5c40.1670243225.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 5 Dec 2022, Geliang Tang wrote:

> Redundant sends need to work more like the MPTCP retransmit code path.
> When the scheduler selects multiple subflows, the first subflow to send
> is a "normal" transmit, and any other subflows would act like a retransmit
> when accessing the dfrags.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/protocol.c | 42 +++++++++++++++++++++++++++++++++++++++---
> net/mptcp/protocol.h |  1 +
> 2 files changed, 40 insertions(+), 3 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index ea2e48a74772..545b29c0e01c 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -997,6 +997,8 @@ static void __mptcp_clean_una(struct sock *sk)
> 			break;
>
> 		if (unlikely(dfrag == msk->first_pending)) {
> +			if (msk->retrans_redundant)
> +				break;
> 			/* in recovery mode can see ack after the current snd head */
> 			if (WARN_ON_ONCE(!msk->recovery))
> 				break;
> @@ -1013,6 +1015,8 @@ static void __mptcp_clean_una(struct sock *sk)
>
> 		/* prevent wrap around in recovery mode */
> 		if (unlikely(delta > dfrag->already_sent)) {
> +			if (msk->retrans_redundant)
> +				goto out;
> 			if (WARN_ON_ONCE(!msk->recovery))
> 				goto out;
> 			if (WARN_ON_ONCE(delta > dfrag->data_len))
> @@ -1473,7 +1477,8 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
>
> static void mptcp_push_release(struct sock *ssk, struct mptcp_sendmsg_info *info)
> {
> -	tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle, info->size_goal);
> +	if (info->mss_now)
> +		tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle, info->size_goal);
> 	release_sock(ssk);
> }
>
> @@ -1555,14 +1560,19 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> 	struct sock *prev_ssk = NULL, *ssk = NULL;
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> 	struct mptcp_subflow_context *subflow;
> +	struct mptcp_data_frag *head = NULL;
> 	struct mptcp_sendmsg_info info = {
> 				.flags = flags,
> 	};
> 	bool do_check_data_fin = false;
> 	int push_count = 1;
>
> +	head = mptcp_send_head(sk);
> +	if (!head)
> +		goto out;
> +
> 	while (mptcp_send_head(sk) && (push_count > 0)) {
> -		int ret = 0;
> +		int ret = 0, i = 0;
>
> 		if (mptcp_sched_get_send(msk))
> 			goto out;
> @@ -1571,6 +1581,14 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
>
> 		mptcp_for_each_subflow(msk, subflow) {
> 			if (READ_ONCE(subflow->scheduled)) {
> +				if (i > 0) {
> +					if (!test_and_set_bit(MPTCP_WORK_RTX, &msk->flags))
> +						mptcp_schedule_work(sk);
> +					WRITE_ONCE(msk->first_pending, head);
> +					msk->retrans_redundant = true;
> +					goto out;
> +				}
> +

Hi Geliang -

On this code path, the msk lock is not released between subflow sends, so 
I don't think it's necessary to use the retrans_redundant approach for 
__mptcp_push_pending().

Did you find that the retrans_redundant path was needed in both 
__mptcp_push_pending() and __mptcp_subflow_push_pending()?

> 				prev_ssk = ssk;
> 				ssk = mptcp_subflow_tcp_sock(subflow);
>
> @@ -1598,6 +1616,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> 						push_count--;
> 					continue;
> 				}
> +				i++;
> 				do_check_data_fin = true;
> 				msk->last_snd = ssk;
> 				mptcp_subflow_set_scheduled(subflow, false);
> @@ -1621,16 +1640,21 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
> {
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> 	struct mptcp_subflow_context *subflow;
> +	struct mptcp_data_frag *head = NULL;
> 	struct mptcp_sendmsg_info info = {
> 		.data_lock_held = true,
> 	};
> 	bool push = true;
> 	int copied = 0;
>
> +	head = mptcp_send_head(sk);
> +	if (!head)
> +		goto out;
> +
> 	info.flags = 0;
> 	while (mptcp_send_head(sk) && push) {
> 		bool delegate = false;
> -		int ret = 0;
> +		int ret = 0, i = 0;
>
> 		/* check for a different subflow usage only after
> 		 * spooling the first chunk of data
> @@ -1652,6 +1676,14 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
> 			if (READ_ONCE(subflow->scheduled)) {
> 				struct sock *xmit_ssk = mptcp_subflow_tcp_sock(subflow);
>
> +				if (i > 0) {
> +					if (!test_and_set_bit(MPTCP_WORK_RTX, &msk->flags))
> +						mptcp_schedule_work(sk);
> +					WRITE_ONCE(msk->first_pending, head);
> +					msk->retrans_redundant = true;
> +					goto out;
> +				}
> +

I need to look at this in some more detail, but my initial impression is 
that redundant sends will need to avoid the worker thread and instead 
add calls to the retrans code through MPTCP_DELEGATE_SEND.


- Mat

> 				if (xmit_ssk != ssk) {
> 					/* Only delegate to one subflow recently,
> 					 * TODO: chain delegated calls for more subflows.
> @@ -1660,6 +1692,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
> 						goto out;
> 					mptcp_subflow_delegate(subflow,
> 							       MPTCP_DELEGATE_SEND);
> +					i++;
> 					msk->last_snd = ssk;
> 					mptcp_subflow_set_scheduled(subflow, false);
> 					delegate = true;
> @@ -1672,6 +1705,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
> 					push = false;
> 					continue;
> 				}
> +				i++;
> 				copied += ret;
> 				msk->last_snd = ssk;
> 				mptcp_subflow_set_scheduled(subflow, false);
> @@ -2593,6 +2627,7 @@ static void __mptcp_retrans(struct sock *sk)
> 		}
> 	}
> 	dfrag->already_sent = max(dfrag->already_sent, len);
> +	msk->retrans_redundant = false;
>
> reset_timer:
> 	mptcp_check_and_set_pending(sk);
> @@ -2724,6 +2759,7 @@ static int __mptcp_init_sock(struct sock *sk)
> 	WRITE_ONCE(msk->csum_enabled, mptcp_is_checksum_enabled(sock_net(sk)));
> 	WRITE_ONCE(msk->allow_infinite_fallback, true);
> 	msk->recovery = false;
> +	msk->retrans_redundant = false;
>
> 	mptcp_pm_data_init(msk);
>
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index adfb758a842f..e6bebde2f3ab 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -290,6 +290,7 @@ struct mptcp_sock {
> 	bool		use_64bit_ack; /* Set when we received a 64-bit DSN */
> 	bool		csum_enabled;
> 	bool		allow_infinite_fallback;
> +	bool		retrans_redundant;
> 	u8		mpc_endpoint_id;
> 	u8		recvmsg_inq:1,
> 			cork:1,
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
