Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5777E
	for <mptcp@lists.linux.dev>; Tue, 20 Dec 2022 02:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671503479; x=1703039479;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=w0/403JJh7gBNigDUYIXEq9fICXWbOsZbwAUe/4Xqd8=;
  b=cd7O3rfdKq5wvRj1p1Kni9c+I+HxtI+wEdYWkOaEO+D7EbsPNvxHoJQX
   gaMnUIlHjWTAAJIesio+MYE2Ypu/AJs7yqZfF15BsTxGBZT4IieOWbERd
   mCT0xt7ut+UQoBIyautunaSdgryOIcRbtlLziGfQJv7L4TrQ+hboIXtXZ
   jXmdUfd40O+cub3d2GyzR+J/aD8nN4WgfdfTpoUsXQhRTcb36ontmo++4
   XMXU4aJR17hHIj395qo01gJZfVhOlzDaXxZabVirkZVCjOkUZA6isdsOc
   5YcCadR1X0dAdjJPrpep5SmA4HE3G54+EKtXohIpcN+JFfN8EOXyWcrWL
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="320682642"
X-IronPort-AV: E=Sophos;i="5.96,258,1665471600"; 
   d="scan'208";a="320682642"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 18:31:19 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="644252324"
X-IronPort-AV: E=Sophos;i="5.96,258,1665471600"; 
   d="scan'208";a="644252324"
Received: from wootaekl-mobl1.amr.corp.intel.com ([10.212.220.86])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 18:31:18 -0800
Date: Mon, 19 Dec 2022 18:31:18 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v4 2/2] mptcp: retrans for redundant sends
In-Reply-To: <20221219131731.GA4625@localhost.localdomain>
Message-ID: <81fe57df-ec24-1b8d-3a92-b542afbce771@linux.intel.com>
References: <cover.1670724098.git.geliang.tang@suse.com> <aa989fcaf2c6471ce82d59fffd0d09c78191ba2e.1670724098.git.geliang.tang@suse.com> <86277516-113d-53cf-aded-10e3224f59e9@linux.intel.com> <20221219131731.GA4625@localhost.localdomain>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 19 Dec 2022, Geliang Tang wrote:

> On Wed, Dec 14, 2022 at 05:47:12PM -0800, Mat Martineau wrote:
>> On Sun, 11 Dec 2022, Geliang Tang wrote:
>>
>>> Redundant sends need to work more like the MPTCP retransmit code path.
>>> When the scheduler selects multiple subflows, the first subflow to send
>>> is a "normal" transmit, and any other subflows would act like a retransmit
>>> when accessing the dfrags.
>>>
>>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
>>> ---
>>> net/mptcp/protocol.c | 45 ++++++++++++++++++++++++++++++++++++++++----
>>> 1 file changed, 41 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>> index 2342b9469181..4c07add44b02 100644
>>> --- a/net/mptcp/protocol.c
>>> +++ b/net/mptcp/protocol.c
>>> @@ -45,6 +45,7 @@ static struct percpu_counter mptcp_sockets_allocated ____cacheline_aligned_in_sm
>>>
>>> static void __mptcp_destroy_sock(struct sock *sk);
>>> static void __mptcp_check_send_data_fin(struct sock *sk);
>>> +static void __mptcp_retrans(struct sock *sk);
>>>
>>> DEFINE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
>>> static struct net_device mptcp_napi_dev;
>>> @@ -997,7 +998,7 @@ static void __mptcp_clean_una(struct sock *sk)
>>>
>>> 		if (unlikely(dfrag == msk->first_pending)) {
>>> 			/* in recovery mode can see ack after the current snd head */
>>> -			if (WARN_ON_ONCE(!msk->recovery))
>>> +			if (!msk->recovery)
>>> 				break;
>>>
>>> 			WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
>>> @@ -1012,7 +1013,7 @@ static void __mptcp_clean_una(struct sock *sk)
>>>
>>> 		/* prevent wrap around in recovery mode */
>>> 		if (unlikely(delta > dfrag->already_sent)) {
>>> -			if (WARN_ON_ONCE(!msk->recovery))
>>> +			if (!msk->recovery)
>>> 				goto out;
>>> 			if (WARN_ON_ONCE(delta > dfrag->data_len))
>>> 				goto out;
>>> @@ -1111,6 +1112,7 @@ struct mptcp_sendmsg_info {
>>> 	u16 sent;
>>> 	unsigned int flags;
>>> 	bool data_lock_held;
>>> +	struct mptcp_data_frag *last;
>>> };
>>>
>>> static int mptcp_check_allowed_size(const struct mptcp_sock *msk, struct sock *ssk,
>>> @@ -1526,6 +1528,7 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
>>> 		info->sent = dfrag->already_sent;
>>> 		info->limit = dfrag->data_len;
>>> 		len = dfrag->data_len - dfrag->already_sent;
>>> +		info->last = dfrag;
>>> 		while (len > 0) {
>>> 			int ret = 0;
>>>
>>> @@ -1562,14 +1565,19 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
>>> 	struct sock *prev_ssk = NULL, *ssk = NULL;
>>> 	struct mptcp_sock *msk = mptcp_sk(sk);
>>> 	struct mptcp_subflow_context *subflow;
>>> +	struct mptcp_data_frag *head, *dfrag;
>>> 	struct mptcp_sendmsg_info info = {
>>> 				.flags = flags,
>>> 	};
>>> 	bool do_check_data_fin = false;
>>> 	int push_count = 1;
>>>
>>> +	head = mptcp_send_head(sk);
>>> +	if (!head)
>>> +		goto out;
>>> +
>>> 	while (mptcp_send_head(sk) && (push_count > 0)) {
>>> -		int ret = 0;
>>> +		int ret = 0, i = 0;
>>>
>>> 		if (mptcp_sched_get_send(msk))
>>> 			break;
>>> @@ -1578,6 +1586,19 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
>>>
>>> 		mptcp_for_each_subflow(msk, subflow) {
>>> 			if (READ_ONCE(subflow->scheduled)) {
>>> +				if (i > 0) {
>>> +					WRITE_ONCE(msk->first_pending, head);
>>> +					mptcp_push_release(ssk, &info, do_check_data_fin);
>>> +
>>> +					while ((dfrag = mptcp_send_head(sk))) {
>>> +						__mptcp_retrans(sk);
>>> +						if (dfrag == info.last)
>>> +							break;
>>> +						WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
>>> +					}
>>> +					goto out;
>>> +				}
>>> +
>>> 				mptcp_subflow_set_scheduled(subflow, false);
>>>
>>> 				prev_ssk = ssk;
>>> @@ -1605,6 +1626,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
>>> 						push_count--;
>>> 					continue;
>>> 				}
>>> +				i++;
>>> 				do_check_data_fin = true;
>>> 				msk->last_snd = ssk;
>>> 			}
>>> @@ -1614,6 +1636,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
>>> 	/* at this point we held the socket lock for the last subflow we used */
>>> 	mptcp_push_release(ssk, &info, do_check_data_fin);
>>>
>>> +out:
>>> 	/* ensure the rtx timer is running */
>>> 	if (!mptcp_timer_pending(sk))
>>> 		mptcp_reset_timer(sk);
>>> @@ -1628,13 +1651,18 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
>>> 	struct mptcp_sendmsg_info info = {
>>> 		.data_lock_held = true,
>>> 	};
>>> +	struct mptcp_data_frag *head;
>>> 	bool keep_pushing = true;
>>> 	struct sock *xmit_ssk;
>>> 	int copied = 0;
>>>
>>> +	head = mptcp_send_head(sk);
>>> +	if (!head)
>>> +		goto out;
>>> +
>>> 	info.flags = 0;
>>> 	while (mptcp_send_head(sk) && keep_pushing) {
>>> -		int ret = 0;
>>> +		int ret = 0, i = 0;
>>>
>>> 		/* check for a different subflow usage only after
>>> 		 * spooling the first chunk of data
>>> @@ -1659,18 +1687,27 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
>>> 			ret = __subflow_push_pending(sk, ssk, &info);
>>> 			if (ret <= 0)
>>> 				keep_pushing = false;
>>> +			i++;
>>> 			copied += ret;
>>> 			msk->last_snd = ssk;
>>> 		}
>>>
>>> 		mptcp_for_each_subflow(msk, subflow) {
>>> 			if (READ_ONCE(subflow->scheduled)) {
>>> +				if (i > 0) {
>>> +					WRITE_ONCE(msk->first_pending, head);
>>> +					if (!test_and_set_bit(MPTCP_WORK_RTX, &msk->flags))
>>> +						mptcp_schedule_work(sk);
>>
>> Hi Geliang -
>>
>> It's not going to perform well enough to use the work queue for redundant
>> sends.
>>
>> MPTCP_WORK_RTX works ok for retransmissions because that is expected to be
>> infrequent. A redundant scheduler would be sending everything on multiple
>> subflows.
>>
>> The retransmission code has some ideas for making redundant sends work, but
>> redundant sending is different:
>>
>> 1. I think the scheduler will need to store some sequence numbers at the msk
>> level so the same data is sent on different subflows, even on the
>> __mptcp_subflow_push_pending() code path. This is a change for regular (not
>> redundant) schedulers too, and lets the schedulers select which subflows to
>> send on AND what data to send.
>
> Sorry, Mat, I didn't get this idea yet. Please give me more details
> about it. We should add sched_seq_start and sched_seq_end in struct
> mptcp_sock, right?

Right.

> These sequence numbers should be set in the BPF
> context by the users, so we need to add sched_seq_start and
> sched_seq_end in struct mptcp_sched_data too. Something likes:
>
>        for (int i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
>                if (!data->contexts[i])
>                        break;
>
>                mptcp_subflow_set_scheduled(data->contexts[i], true);
> 		data->sched_seq_start = SN;
> 		data->sched_seq_end = SN + LEN;
>        }
>
> How can the users know what sequence number (SN) to write from? The
> sequence number is generated in the kernel?
>

You're right, the users don't know that information - the wrappers (like 
mptcp_sched_get_send()) would have to get sched_seq_start from the 
msk->first_pending dfrag (dfrag->data_seq + dfrag->already_sent).

It would also be useful to have the wrapper set sched_seq_end using 
dfrag->data_len before calling the scheduler function (BPF or in-kernel), 
so the scheduler knows the maximum length for the segment. sched_seq_end 
would need to be validated to be between sched_seq_start and the end of 
the dfrag.

> We can use (msk->sched_seq_end - msk->sched_seq_start) to replace
> "msk->snd_burst", but I still don't know how to check these sequence
> numbers in __mptcp_subflow_push_pending().

It looks like the dfrags have the info needed? In addition, sched_seq_end 
can be used when setting info->limit in __subflow_push_pending() to limit 
how much data mptcp_sendmsg_frag() will attempt to send.


I hope that fills in the details you need to move ahead - if you have more 
questions I'm happy to answer or continue revising the design.


- Mat

>
>>
>> 2. The redundant send code should not behave exactly like retransmit. For
>> example, don't call mptcp_sched_get_retrans() or use the retransmit MIB
>> counters. Maybe it's simpler to have a separate function rather than add a
>> bunch of conditionals to __mptcp_retrans()?
>>
>> 3. When using the __mptcp_subflow_push_pending() code path, the
>> MPTCP_DELEGATE_SEND technique should be used repeatedly until all
>> redundantly scheduled subflows have sent their data.
>>
>>
>> I'll check with other community members at the meeting tomorrow to see if
>> some other ideas come up.
>>
>>
>>> +					goto out;
>>> +				}
>>> +
>>> 				mptcp_subflow_set_scheduled(subflow, false);
>>>
>>> 				xmit_ssk = mptcp_subflow_tcp_sock(subflow);
>>> 				if (xmit_ssk != ssk) {
>>> 					mptcp_subflow_delegate(subflow,
>>> 							       MPTCP_DELEGATE_SEND);
>>> +					i++;
>>> 					msk->last_snd = xmit_ssk;
>>> 					keep_pushing = false;
>>> 				}
>>> --
>>> 2.35.3
>>>
>>>
>>>
>>
>> Thanks,
>>
>> --
>> Mat Martineau
>> Intel
>

--
Mat Martineau
Intel
