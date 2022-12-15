Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8CA17C3
	for <mptcp@lists.linux.dev>; Thu, 15 Dec 2022 01:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671068835; x=1702604835;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Mp+ZNa0BwG/Id+dacSH1MDywPJ0mjMTi59Ur+8yj4wc=;
  b=QA5HZfxMwsFNF2eKUCk+ELfuJjEJLQ+aHRxsJN4Jxc/WWhuV98GE1zGo
   MaaXBx/KEOPCFfRwicWddQ1tPgFBzhu8N0YjwF9GurCtSKaguDua/k9iX
   zfO6NMtoikqaEGMSTnXooTbpCvJ2fjG77QrxHAgFuG1K+2xoKK1V2Zyeq
   406ZS7Md6VpRkLbVxk0XDabe4EENXUSZNMVV+LV8uhMeNMSTEw9WWRTfP
   IgErYnD49xZKc4LfpsSWnlA3qpw/eQQtOHMhwy7iJ2ee1qdBKW4M+xV7K
   qGfPCq5k2bicBAYIjtytdED8Q4VAJ37uUgiOichXyL6VBq238sY4EyivU
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="301970064"
X-IronPort-AV: E=Sophos;i="5.96,246,1665471600"; 
   d="scan'208";a="301970064"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 17:47:14 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="978026650"
X-IronPort-AV: E=Sophos;i="5.96,246,1665471600"; 
   d="scan'208";a="978026650"
Received: from rbcranda-mobl1.amr.corp.intel.com ([10.212.154.86])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 17:47:12 -0800
Date: Wed, 14 Dec 2022 17:47:12 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v4 2/2] mptcp: retrans for redundant sends
In-Reply-To: <aa989fcaf2c6471ce82d59fffd0d09c78191ba2e.1670724098.git.geliang.tang@suse.com>
Message-ID: <86277516-113d-53cf-aded-10e3224f59e9@linux.intel.com>
References: <cover.1670724098.git.geliang.tang@suse.com> <aa989fcaf2c6471ce82d59fffd0d09c78191ba2e.1670724098.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Sun, 11 Dec 2022, Geliang Tang wrote:

> Redundant sends need to work more like the MPTCP retransmit code path.
> When the scheduler selects multiple subflows, the first subflow to send
> is a "normal" transmit, and any other subflows would act like a retransmit
> when accessing the dfrags.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/protocol.c | 45 ++++++++++++++++++++++++++++++++++++++++----
> 1 file changed, 41 insertions(+), 4 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 2342b9469181..4c07add44b02 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -45,6 +45,7 @@ static struct percpu_counter mptcp_sockets_allocated ____cacheline_aligned_in_sm
>
> static void __mptcp_destroy_sock(struct sock *sk);
> static void __mptcp_check_send_data_fin(struct sock *sk);
> +static void __mptcp_retrans(struct sock *sk);
>
> DEFINE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
> static struct net_device mptcp_napi_dev;
> @@ -997,7 +998,7 @@ static void __mptcp_clean_una(struct sock *sk)
>
> 		if (unlikely(dfrag == msk->first_pending)) {
> 			/* in recovery mode can see ack after the current snd head */
> -			if (WARN_ON_ONCE(!msk->recovery))
> +			if (!msk->recovery)
> 				break;
>
> 			WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
> @@ -1012,7 +1013,7 @@ static void __mptcp_clean_una(struct sock *sk)
>
> 		/* prevent wrap around in recovery mode */
> 		if (unlikely(delta > dfrag->already_sent)) {
> -			if (WARN_ON_ONCE(!msk->recovery))
> +			if (!msk->recovery)
> 				goto out;
> 			if (WARN_ON_ONCE(delta > dfrag->data_len))
> 				goto out;
> @@ -1111,6 +1112,7 @@ struct mptcp_sendmsg_info {
> 	u16 sent;
> 	unsigned int flags;
> 	bool data_lock_held;
> +	struct mptcp_data_frag *last;
> };
>
> static int mptcp_check_allowed_size(const struct mptcp_sock *msk, struct sock *ssk,
> @@ -1526,6 +1528,7 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
> 		info->sent = dfrag->already_sent;
> 		info->limit = dfrag->data_len;
> 		len = dfrag->data_len - dfrag->already_sent;
> +		info->last = dfrag;
> 		while (len > 0) {
> 			int ret = 0;
>
> @@ -1562,14 +1565,19 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> 	struct sock *prev_ssk = NULL, *ssk = NULL;
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> 	struct mptcp_subflow_context *subflow;
> +	struct mptcp_data_frag *head, *dfrag;
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
> 			break;
> @@ -1578,6 +1586,19 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
>
> 		mptcp_for_each_subflow(msk, subflow) {
> 			if (READ_ONCE(subflow->scheduled)) {
> +				if (i > 0) {
> +					WRITE_ONCE(msk->first_pending, head);
> +					mptcp_push_release(ssk, &info, do_check_data_fin);
> +
> +					while ((dfrag = mptcp_send_head(sk))) {
> +						__mptcp_retrans(sk);
> +						if (dfrag == info.last)
> +							break;
> +						WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
> +					}
> +					goto out;
> +				}
> +
> 				mptcp_subflow_set_scheduled(subflow, false);
>
> 				prev_ssk = ssk;
> @@ -1605,6 +1626,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> 						push_count--;
> 					continue;
> 				}
> +				i++;
> 				do_check_data_fin = true;
> 				msk->last_snd = ssk;
> 			}
> @@ -1614,6 +1636,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> 	/* at this point we held the socket lock for the last subflow we used */
> 	mptcp_push_release(ssk, &info, do_check_data_fin);
>
> +out:
> 	/* ensure the rtx timer is running */
> 	if (!mptcp_timer_pending(sk))
> 		mptcp_reset_timer(sk);
> @@ -1628,13 +1651,18 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
> 	struct mptcp_sendmsg_info info = {
> 		.data_lock_held = true,
> 	};
> +	struct mptcp_data_frag *head;
> 	bool keep_pushing = true;
> 	struct sock *xmit_ssk;
> 	int copied = 0;
>
> +	head = mptcp_send_head(sk);
> +	if (!head)
> +		goto out;
> +
> 	info.flags = 0;
> 	while (mptcp_send_head(sk) && keep_pushing) {
> -		int ret = 0;
> +		int ret = 0, i = 0;
>
> 		/* check for a different subflow usage only after
> 		 * spooling the first chunk of data
> @@ -1659,18 +1687,27 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
> 			ret = __subflow_push_pending(sk, ssk, &info);
> 			if (ret <= 0)
> 				keep_pushing = false;
> +			i++;
> 			copied += ret;
> 			msk->last_snd = ssk;
> 		}
>
> 		mptcp_for_each_subflow(msk, subflow) {
> 			if (READ_ONCE(subflow->scheduled)) {
> +				if (i > 0) {
> +					WRITE_ONCE(msk->first_pending, head);
> +					if (!test_and_set_bit(MPTCP_WORK_RTX, &msk->flags))
> +						mptcp_schedule_work(sk);

Hi Geliang -

It's not going to perform well enough to use the work queue for redundant 
sends.

MPTCP_WORK_RTX works ok for retransmissions because that is expected to be 
infrequent. A redundant scheduler would be sending everything on multiple 
subflows.

The retransmission code has some ideas for making redundant sends work, 
but redundant sending is different:

1. I think the scheduler will need to store some sequence numbers at the 
msk level so the same data is sent on different subflows, even on the 
__mptcp_subflow_push_pending() code path. This is a change for regular 
(not redundant) schedulers too, and lets the schedulers select which 
subflows to send on AND what data to send.

2. The redundant send code should not behave exactly like retransmit. For 
example, don't call mptcp_sched_get_retrans() or use the retransmit MIB 
counters. Maybe it's simpler to have a separate function rather than add a 
bunch of conditionals to __mptcp_retrans()?

3. When using the __mptcp_subflow_push_pending() code path, the 
MPTCP_DELEGATE_SEND technique should be used repeatedly until all 
redundantly scheduled subflows have sent their data.


I'll check with other community members at the meeting tomorrow to see 
if some other ideas come up.


> +					goto out;
> +				}
> +
> 				mptcp_subflow_set_scheduled(subflow, false);
>
> 				xmit_ssk = mptcp_subflow_tcp_sock(subflow);
> 				if (xmit_ssk != ssk) {
> 					mptcp_subflow_delegate(subflow,
> 							       MPTCP_DELEGATE_SEND);
> +					i++;
> 					msk->last_snd = xmit_ssk;
> 					keep_pushing = false;
> 				}
> -- 
> 2.35.3
>
>
>

Thanks,

--
Mat Martineau
Intel
