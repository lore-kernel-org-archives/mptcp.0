Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA5072
	for <mptcp@lists.linux.dev>; Fri,  3 Sep 2021 17:07:55 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10096"; a="219484039"
X-IronPort-AV: E=Sophos;i="5.85,265,1624345200"; 
   d="scan'208";a="219484039"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 10:07:41 -0700
X-IronPort-AV: E=Sophos;i="5.85,265,1624345200"; 
   d="scan'208";a="692375667"
Received: from gchandr2-mobl.amr.corp.intel.com ([10.209.38.180])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 10:07:40 -0700
Date: Fri, 3 Sep 2021 10:07:40 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v2 mptcp-next 2/4] mptcp: stop relaying on
 tcp_tx_skb_cache.
In-Reply-To: <dc492545d0c671f0e9ad91421eede5b9e2a1765d.camel@redhat.com>
Message-ID: <9a9f40b5-931c-7d62-34af-53871165512@linux.intel.com>
References: <cover.1630595171.git.pabeni@redhat.com>  <ae127a2e3d2fb31e6f1687cb96128d39490f6be0.1630595171.git.pabeni@redhat.com>  <14eebc85-4164-7c1c-dece-9cf3dc9d8d9c@linux.intel.com> <dc492545d0c671f0e9ad91421eede5b9e2a1765d.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 3 Sep 2021, Paolo Abeni wrote:

> On Thu, 2021-09-02 at 17:30 -0700, Mat Martineau wrote:
>> On Thu, 2 Sep 2021, Paolo Abeni wrote:
>>
>>> We want to revert the skb TX cache, but MPTCP is currently
>>> using it unconditionally.
>>>
>>> Rework the MPTCP tx code, so that tcp_tx_skb_cache is not
>>> needed anymore: do the whole coalescing check, skb allocation
>>> skb initialization/update inside mptcp_sendmsg_frag(), quite
>>> alike the current TCP code.
>>>
>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>> ---
>>> v1 -> v2:
>>> - hopefully fix OoB, fetching nr_frags on new skbs
>>> ---
>>> net/mptcp/protocol.c | 132 +++++++++++++++++++++++++------------------
>>> 1 file changed, 77 insertions(+), 55 deletions(-)
>>>
>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>> index faf6e7000d18..101e61bb2a80 100644
>>> --- a/net/mptcp/protocol.c
>>> +++ b/net/mptcp/protocol.c
>>> @@ -1224,6 +1224,7 @@ static struct sk_buff *__mptcp_do_alloc_tx_skb(struct sock *sk, gfp_t gfp)
>>> 		if (likely(__mptcp_add_ext(skb, gfp))) {
>>> 			skb_reserve(skb, MAX_TCP_HEADER);
>>> 			skb->reserved_tailroom = skb->end - skb->tail;
>>> +			INIT_LIST_HEAD(&skb->tcp_tsorted_anchor);
>>
>> Is this related to tx_skb_cache? Looks like it could be a -net fix.
>
> Eheh you nicely noticed the relevant details as usual ;)
>
> No, this is not needed for -net. Before this patch, tcp_tsorted_anchor
> initialization was performed by sk_stream_alloc_skb(), invoked by
> tcp_build_frag(), which we are not reaching anymore now.
>
>>
>>> 			return skb;
>>> 		}
>>> 		__kfree_skb(skb);
>>> @@ -1233,31 +1234,23 @@ static struct sk_buff *__mptcp_do_alloc_tx_skb(struct sock *sk, gfp_t gfp)
>>> 	return NULL;
>>> }
>>>
>>> -static bool __mptcp_alloc_tx_skb(struct sock *sk, struct sock *ssk, gfp_t gfp)
>>> +static struct sk_buff *__mptcp_alloc_tx_skb(struct sock *sk, struct sock *ssk, gfp_t gfp)
>>> {
>>> 	struct sk_buff *skb;
>>>
>>> -	if (ssk->sk_tx_skb_cache) {
>>> -		skb = ssk->sk_tx_skb_cache;
>>> -		if (unlikely(!skb_ext_find(skb, SKB_EXT_MPTCP) &&
>>> -			     !__mptcp_add_ext(skb, gfp)))
>>> -			return false;
>>> -		return true;
>>> -	}
>>> -
>>> 	skb = __mptcp_do_alloc_tx_skb(sk, gfp);
>>> 	if (!skb)
>>> -		return false;
>>> +		return NULL;
>>>
>>> 	if (likely(sk_wmem_schedule(ssk, skb->truesize))) {
>>> -		ssk->sk_tx_skb_cache = skb;
>>> -		return true;
>>> +		skb_entail(ssk, skb);
>>> +		return skb;
>>> 	}
>>> 	kfree_skb(skb);
>>> -	return false;
>>> +	return NULL;
>>> }
>>>
>>> -static bool mptcp_alloc_tx_skb(struct sock *sk, struct sock *ssk, bool data_lock_held)
>>> +static struct sk_buff *mptcp_alloc_tx_skb(struct sock *sk, struct sock *ssk, bool data_lock_held)
>>> {
>>> 	gfp_t gfp = data_lock_held ? GFP_ATOMIC : sk->sk_allocation;
>>>
>>> @@ -1287,23 +1280,29 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
>>> 			      struct mptcp_sendmsg_info *info)
>>> {
>>> 	u64 data_seq = dfrag->data_seq + info->sent;
>>> +	int offset = dfrag->offset + info->sent;
>>> 	struct mptcp_sock *msk = mptcp_sk(sk);
>>> 	bool zero_window_probe = false;
>>> 	struct mptcp_ext *mpext = NULL;
>>> -	struct sk_buff *skb, *tail;
>>> -	bool must_collapse = false;
>>> -	int size_bias = 0;
>>> -	int avail_size;
>>> -	size_t ret = 0;
>>> +	bool can_coalesce = false;
>>> +	bool reuse_skb = true;
>>> +	struct sk_buff *skb;
>>> +	size_t copy;
>>> +	int i;
>>>
>>> 	pr_debug("msk=%p ssk=%p sending dfrag at seq=%llu len=%u already sent=%u",
>>> 		 msk, ssk, dfrag->data_seq, dfrag->data_len, info->sent);
>>>
>>> +	if (WARN_ON_ONCE(info->sent > info->limit ||
>>> +			 info->limit > dfrag->data_len))
>>> +		return 0;
>>> +
>>> 	/* compute send limit */
>>> 	info->mss_now = tcp_send_mss(ssk, &info->size_goal, info->flags);
>>> -	avail_size = info->size_goal;
>>> +	copy = info->size_goal;
>>> +
>>> 	skb = tcp_write_queue_tail(ssk);
>>> -	if (skb) {
>>> +	if (skb && (copy > skb->len)) {
>>> 		/* Limit the write to the size available in the
>>> 		 * current skb, if any, so that we create at most a new skb.
>>> 		 * Explicitly tells TCP internals to avoid collapsing on later
>>> @@ -1316,53 +1315,76 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
>>> 			goto alloc_skb;
>>> 		}
>>>
>>> -		must_collapse = (info->size_goal - skb->len > 0) &&
>>> -				(skb_shinfo(skb)->nr_frags < sysctl_max_skb_frags);
>>> -		if (must_collapse) {
>>> -			size_bias = skb->len;
>>> -			avail_size = info->size_goal - skb->len;
>>> +		i = skb_shinfo(skb)->nr_frags;
>>> +		can_coalesce = skb_can_coalesce(skb, i, dfrag->page, offset);
>>> +		if (!can_coalesce && i >= sysctl_max_skb_frags) {
>>> +			tcp_mark_push(tcp_sk(ssk), skb);
>>> +			goto alloc_skb;
>>> 		}
>>> -	}
>>>
>>> +		copy -= skb->len;
>>> +	} else {
>>> alloc_skb:
>>> -	if (!must_collapse && !ssk->sk_tx_skb_cache &&
>>> -	    !mptcp_alloc_tx_skb(sk, ssk, info->data_lock_held))
>>> -		return 0;
>>> +		skb = mptcp_alloc_tx_skb(sk, ssk, info->data_lock_held);
>>> +		if (!skb)
>>> +			return -ENOMEM;
>>> +
>>> +		i = skb_shinfo(skb)->nr_frags;
>>> +		reuse_skb = false;
>>> +		mpext = skb_ext_find(skb, SKB_EXT_MPTCP);
>>> +	}
>>>
>>> 	/* Zero window and all data acked? Probe. */
>>> -	avail_size = mptcp_check_allowed_size(msk, data_seq, avail_size);
>>> -	if (avail_size == 0) {
>>> +	copy = mptcp_check_allowed_size(msk, data_seq, copy);
>>> +	if (copy == 0) {
>>> 		u64 snd_una = READ_ONCE(msk->snd_una);
>>>
>>> -		if (skb || snd_una != msk->snd_nxt)
>>> +		if (skb || snd_una != msk->snd_nxt) {
>>> +			tcp_remove_empty_skb(ssk, tcp_write_queue_tail(ssk));
>>> 			return 0;
>>> +		}
>>> +
>>> 		zero_window_probe = true;
>>> 		data_seq = snd_una - 1;
>>> -		avail_size = 1;
>>> -	}
>>> +		copy = 1;
>>>
>>> -	if (WARN_ON_ONCE(info->sent > info->limit ||
>>> -			 info->limit > dfrag->data_len))
>>> -		return 0;
>>> +		/* all mptcp-level data is acked, no skbs should be present into the
>>> +		 * ssk write queue
>>> +		 */
>>> +		WARN_ON_ONCE(reuse_skb);
>>> +	}
>>>
>>> -	ret = info->limit - info->sent;
>>> -	tail = tcp_build_frag(ssk, avail_size + size_bias, info->flags,
>>> -			      dfrag->page, dfrag->offset + info->sent, &ret);
>>> -	if (!tail) {
>>> -		tcp_remove_empty_skb(sk, tcp_write_queue_tail(ssk));
>>> +	copy = min_t(size_t, copy, info->limit - info->sent);
>>> +	if (!sk_wmem_schedule(ssk, copy)) {
>>> +		tcp_remove_empty_skb(ssk, tcp_write_queue_tail(ssk));
>>> 		return -ENOMEM;
>>> 	}
>>>
>>> -	/* if the tail skb is still the cached one, collapsing really happened.
>>> -	 */
>>> -	if (skb == tail) {
>>> -		TCP_SKB_CB(tail)->tcp_flags &= ~TCPHDR_PSH;
>>> -		mpext->data_len += ret;
>>> +	if (can_coalesce) {
>>> +		skb_frag_size_add(&skb_shinfo(skb)->frags[i - 1], copy);
>>> +	} else {
>>> +		get_page(dfrag->page);
>>> +		skb_fill_page_desc(skb, i, dfrag->page, offset, copy);
>>> +	}
>>> +
>>> +	skb->len += copy;
>>> +	skb->data_len += copy;
>>> +	skb->truesize += copy;
>>> +	sk_wmem_queued_add(ssk, copy);
>>> +	sk_mem_charge(ssk, copy);
>>> +	skb->ip_summed = CHECKSUM_PARTIAL;
>>> +	WRITE_ONCE(tcp_sk(ssk)->write_seq, tcp_sk(ssk)->write_seq + copy);
>>> +	TCP_SKB_CB(skb)->end_seq += copy;
>>> +	tcp_skb_pcount_set(skb, 0);
>>> +
>>> +	/* on skb reuse we just need to update the DSS len */
>>> +	if (reuse_skb) {
>>> +		TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_PSH;
>>> +		mpext->data_len += copy;
>>
>> Should have the WARN_ON_ONCE(!mpext) before this block - while it
>> shouldn't happen, it's slightly less impossible in the reuse_skb case.
>
> I wondered about it a bit, and I *think* is not needed: we reuse the
> skb only if mpext != NULL, see mptcp_skb_can_collapse_to().
>

I missed that check, you're right that at this point in the code reuse_skb 
== true guarantees that mpext != NULL. Since reuse_skb is only set to 
false in a path where mpext has been successfully allocated, it makes 
sense to drop the WARN_ON_ONCE().

>> I'll start some tests running.

I didn't see any issues in syzkaller overnight, or in a few selftest runs.

--
Mat Martineau
Intel
