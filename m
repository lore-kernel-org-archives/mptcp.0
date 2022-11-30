Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A8BD51B
	for <mptcp@lists.linux.dev>; Wed, 30 Nov 2022 23:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669851812; x=1701387812;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=NWrOeJCdvO5NikgL5gZHfOSsz7guo1HtZobnsap2Kh8=;
  b=RFxqhg2lKMBcgzbXDhTY3/U82SVQXZsygxrM0dc+X9rtWdGeBfSS2xoO
   +VyooeRRBuZVoIyhpzZW9n37Epq36D9LXtDyUMO+b8eWRghD0EhvO/g4c
   JJvjHAOI12KUgzk0Lf4VFYj2eb/jOjDC3FH5t1ojGAeGNoQ7YBd70CYG0
   ApfzoYh/JkhR4uV0d8zvX9yjkAVhTN1+GIHbwQyLcxVZyR96kzilNgIRA
   Ugo0EfvgGdBKLa74GyFPbfYVH9kJUWmKEiJ66X2s0hZcwt3cXw/BABZmq
   Liqz+YibChT++tPfgg4qFA9BV6epR50HtE0l7ZX5/gkjD6spIYJ55N9jW
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="295901666"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="295901666"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 15:43:31 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="733179092"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="733179092"
Received: from cman-mobl2.amr.corp.intel.com ([10.212.228.45])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 15:43:31 -0800
Date: Wed, 30 Nov 2022 15:43:31 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v21 5/7] mptcp: add mptcp_update_dfrags
In-Reply-To: <82e851ded78f7d563e6676c3e087b0470cbe451f.1669605531.git.geliang.tang@suse.com>
Message-ID: <23a60176-cd4b-c684-225a-8c6b803816a8@linux.intel.com>
References: <cover.1669605531.git.geliang.tang@suse.com> <82e851ded78f7d563e6676c3e087b0470cbe451f.1669605531.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 28 Nov 2022, Geliang Tang wrote:

> Add a new helper mptcp_next_frag() to get the next dfrag of the given
> dfrag.
>
> Add new members first and last in struct mptcp_sendmsg_info, to point
> to the first and last sent dfrag in the dfrags iteration loop in
> __subflow_push_pending().
>
> Invoke the new helper mptcp_update_dfrags() to iterate the dfrags from
> info->first to info->last to update already_sent of every dfrag to 0
> in the redundant sends retrans path.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/protocol.c | 28 ++++++++++++++++++++++++++++
> net/mptcp/protocol.h | 13 ++++++++++---
> 2 files changed, 38 insertions(+), 3 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 3fcd6af96721..23116b0840ad 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -992,6 +992,12 @@ static void __mptcp_clean_una(struct sock *sk)
> 		msk->snd_una = READ_ONCE(msk->snd_nxt);
>
> 	snd_una = msk->snd_una;
> +	/* Fix this:
> +	 * ------------[ cut here ]------------
> +	 * WARNING: CPU: 6 PID: 3007 at net/mptcp/protocol.c:1003 __mptcp_clean_una+0x243/0x2b0
> +	 */
> +	if (msk->first_pending)
> +		goto out;

Is this triggered by WARN_ON_ONCE(!msk->recovery)?


I looked at my v20 comment on this patch again, and I could have been 
clearer about the issues with modifying dfrag->already_sent:

When called from __mptcp_push_pending() (with the msk lock held), dfrags 
can be modified more freely because the call to __mptcp_clean_una() is 
deferred using msk->cb_flags.

The tricky part is handling dfrag updates when using 
__mptcp_subflow_push_pending(). On this code path, the msk lock is not 
held continuously when doing a redundant send on multiple subflows. This 
means __mptcp_clean_una() can run between each subflow send. When this 
happens, if dfrag->already_sent == 0 then __mptcp_clean_una() doesn't know 
what to do.

I think it's important to find a way to do redundant sends with 
__mptcp_subflow_push_pending() without having to change 
dfrag->already_sent. After the data is sent for the first time and the msk 
lock is released, dfrag->already_sent should not be set back to 0 so 
__mptcp_clean_una() can work correctly if a DATA_ACK arrives.

One way to solve this is to have the scheduler set sequence numbers to 
limit the payload sent on the scheduled subflows. Right now, the scheduler 
tells the MPTCP core which subflows to send on, but does not have any 
limit on how much data to send. If you replaced msk->snd_burst with 
msk->sched_seq_start and msk->sched_seq_end and have the scheduler set 
those values for the current scheduled transmits, that could be used 
instead of dfrag->already_sent. If a DATA_ACK has already cleared the 
received and acknowledged dfrags, then the redundant sends on the 
__mptcp_subflow_push_pending() code path don't even need to transmit the 
data.

What do you think? I am very open to better ideas too!

Thanks,

Mat



> 	list_for_each_entry_safe(dfrag, dtmp, &msk->rtx_queue, list) {
> 		if (after64(dfrag->data_seq + dfrag->data_len, snd_una))
> 			break;
> @@ -1112,6 +1118,7 @@ struct mptcp_sendmsg_info {
> 	u16 sent;
> 	unsigned int flags;
> 	bool data_lock_held;
> +	struct mptcp_data_frag *first, *last;
> };
>
> static int mptcp_check_allowed_size(const struct mptcp_sock *msk, struct sock *ssk,
> @@ -1502,6 +1509,23 @@ static void mptcp_update_post_push(struct mptcp_sock *msk,
> 		msk->snd_nxt = snd_nxt_new;
> }
>
> +static void mptcp_update_dfrags(struct sock *sk, struct mptcp_sendmsg_info *info)
> +{
> +	struct mptcp_data_frag *dfrag = info->first;
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +
> +	if (!dfrag)
> +		return;
> +
> +	do {
> +		dfrag->already_sent = 0;
> +		if (dfrag == info->last)
> +			break;
> +	} while ((dfrag = mptcp_next_frag(sk, dfrag)));
> +
> +	WRITE_ONCE(msk->first_pending, info->first);
> +}
> +
> void mptcp_check_and_set_pending(struct sock *sk)
> {
> 	if (mptcp_send_head(sk))
> @@ -1515,10 +1539,12 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
> 	struct mptcp_data_frag *dfrag;
> 	int len, copied = 0, err = 0;
>
> +	info->first = mptcp_send_head(sk);
> 	while ((dfrag = mptcp_send_head(sk))) {
> 		info->sent = dfrag->already_sent;
> 		info->limit = dfrag->data_len;
> 		len = dfrag->data_len - dfrag->already_sent;
> +		info->last = dfrag;
> 		while (len > 0) {
> 			int ret = 0;
>
> @@ -1572,6 +1598,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> 				if (i > 0) {
> 					if (!test_and_set_bit(MPTCP_WORK_RTX, &msk->flags))
> 						mptcp_schedule_work(sk);
> +					mptcp_update_dfrags(sk, &info);
> 					goto out;
> 				}
>
> @@ -1657,6 +1684,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
> 				if (i > 0) {
> 					if (!test_and_set_bit(MPTCP_WORK_RTX, &msk->flags))
> 						mptcp_schedule_work(sk);
> +					mptcp_update_dfrags(sk, &info);
> 					goto out;
> 				}
>
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index adfb758a842f..782dcfd55429 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -358,16 +358,23 @@ static inline struct mptcp_data_frag *mptcp_send_head(const struct sock *sk)
> 	return READ_ONCE(msk->first_pending);
> }
>
> -static inline struct mptcp_data_frag *mptcp_send_next(struct sock *sk)
> +static inline struct mptcp_data_frag *mptcp_next_frag(const struct sock *sk,
> +						      struct mptcp_data_frag *cur)
> {
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> -	struct mptcp_data_frag *cur;
>
> -	cur = msk->first_pending;
> +	if (!cur)
> +		return NULL;
> +
> 	return list_is_last(&cur->list, &msk->rtx_queue) ? NULL :
> 						     list_next_entry(cur, list);
> }
>
> +static inline struct mptcp_data_frag *mptcp_send_next(const struct sock *sk)
> +{
> +	return mptcp_next_frag(sk, mptcp_send_head(sk));
> +}
> +
> static inline struct mptcp_data_frag *mptcp_pending_tail(const struct sock *sk)
> {
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
