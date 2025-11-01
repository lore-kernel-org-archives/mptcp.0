Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DD5635
	for <mptcp@lists.linux.dev>; Sat,  1 Nov 2025 00:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761955469; cv=none; b=Kfq6e7++AhtcIgmGipT+GwoesW6mgF031O9sCwkWRMFIZJnxyPVHWsAayMVFcef8vkHtOT+ywvqkJzONDpDoc7/cWsEotky7B+YqiWAaopbg/shXKsqYocX8sgWqT06rHGBh1YJnNayB2dyP8u4UHMRhWBhqHduEoVG27Lz42b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761955469; c=relaxed/simple;
	bh=irIUs1e+IeY4GfBUWlkpZ/J3u6M6J6A1VPYQJHR+cNM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rR7WDbGtNbXc8K+kZlHk8mWe6vEB1AAfuLAlp/oPmylgeIIQqmNbRoiulW7ThUO5g30kMWaq/w/Rc9A6yJXtzaJC4rY5WF6govHAHuhTujZzcSGRdKz9IdEre8C+03r3vkcnfaMEQF5ZinWq4FNA3o4/T2fcM3kvytaJJWMRqCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KaNpZTfD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KaNpZTfD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C06D9C4CEE7;
	Sat,  1 Nov 2025 00:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761955468;
	bh=irIUs1e+IeY4GfBUWlkpZ/J3u6M6J6A1VPYQJHR+cNM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=KaNpZTfDUlcyuK3NQhYW04Vflmv17f1FmNXnY4VhuxsIQepZLJALlX1eyzq4GxSP2
	 s0PUpePzn48VB7FRPmGlazSFPhiDbo9gHBF+MHjmKRb08jJV2y2onfZSZcKcZmtar3
	 x9oa/MnHSV0uTbBQwiHnAZqTr088SZv+pkk9yticGWGlGlRIKYypUlkxHIwSXIDhcG
	 +VW8i3ol+FlzFBToUpNi8YI+BbafrvccaGkclneKShaehHX34RROHVwSUk1ytUbkfi
	 3mfiAItFpZ9Ki18XCxSq239AHU+1u6Wi6oL2lRSZ1jwIAiw6oHUvglUQ2burEcatkG
	 Se2RUSV1xqXXw==
Date: Fri, 31 Oct 2025 17:04:27 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev, geliang@kernel.org
Subject: Re: [PATCH RESENT v7 mptcp-next 4/4] mptcp: leverage the backlog
 for RX packet processing
In-Reply-To: <08f8e227a749a28a88ce245fa36870173e32c54f.1761576117.git.pabeni@redhat.com>
Message-ID: <6fb0d5aa-8140-505d-c40f-1dc40fff352f@kernel.org>
References: <cover.1761576117.git.pabeni@redhat.com> <08f8e227a749a28a88ce245fa36870173e32c54f.1761576117.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 27 Oct 2025, Paolo Abeni wrote:

> When the msk socket is owned or the msk receive buffer is full,
> move the incoming skbs in a msk level backlog list. This avoid
> traversing the joined subflows and acquiring the subflow level
> socket lock at reception time, improving the RX performances.
>
> When processing the backlog, use the fwd alloc memory borrowed from
> the incoming subflow. skbs exceeding the msk receive space are
> not dropped; instead they are kept into the backlog until the receive
> buffer is freed. Dropping packets already acked at the TCP level is
> explicitly discouraged by the RFC and would corrupt the data stream
> for fallback sockets.
>
> Special care is needed to avoid adding skbs to the backlog of a closed
> msk and to avoid leaving dangling references into the backlog
> at subflow closing time.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v6 -> v7:
>  - do not limit the overall backlog spooling loop, it's hard to do it
>    right and the pre backlog code did not care for the similar existing
>    loop
>
> v5 -> v6:
>  - do backlog len update asap to advise the correct window.
>  - explicitly bound backlog processing loop to the maximum BL len
>
> v4 -> v5:
>  - consolidate ssk rcvbuf accunting in __mptcp_move_skb(), remove
>    some code duplication
>  - return soon in __mptcp_add_backlog() when dropping skbs due to
>    the msk closed. This avoid later UaF
> ---
> net/mptcp/protocol.c | 121 ++++++++++++++++++++++++-------------------
> net/mptcp/protocol.h |   1 -
> 2 files changed, 68 insertions(+), 54 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 4c62de93e132..f93f973a4ffb 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -683,7 +683,7 @@ static void __mptcp_add_backlog(struct sock *sk,
> }
>
> static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
> -					   struct sock *ssk)
> +					   struct sock *ssk, bool own_msk)
> {
> 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
> 	struct sock *sk = (struct sock *)msk;
> @@ -699,9 +699,6 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
> 		struct sk_buff *skb;
> 		bool fin;
>
> -		if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
> -			break;
> -
> 		/* try to move as much data as available */
> 		map_remaining = subflow->map_data_len -
> 				mptcp_subflow_get_map_offset(subflow);
> @@ -729,7 +726,7 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
>
> 			mptcp_init_skb(ssk, skb, offset, len);
>
> -			if (true) {
> +			if (own_msk && sk_rmem_alloc_get(sk) < sk->sk_rcvbuf) {
> 				mptcp_subflow_lend_fwdmem(subflow, skb);
> 				ret |= __mptcp_move_skb(sk, skb);
> 			} else {
> @@ -853,7 +850,7 @@ static bool move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
> 	struct sock *sk = (struct sock *)msk;
> 	bool moved;
>
> -	moved = __mptcp_move_skbs_from_subflow(msk, ssk);
> +	moved = __mptcp_move_skbs_from_subflow(msk, ssk, true);
> 	__mptcp_ofo_queue(msk);
> 	if (unlikely(ssk->sk_err))
> 		__mptcp_subflow_error_report(sk, ssk);
> @@ -886,7 +883,7 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
> 		if (move_skbs_to_msk(msk, ssk) && mptcp_epollin_ready(sk))
> 			sk->sk_data_ready(sk);
> 	} else {
> -		__set_bit(MPTCP_DEQUEUE, &mptcp_sk(sk)->cb_flags);
> +		__mptcp_move_skbs_from_subflow(msk, ssk, false);
> 	}
> 	mptcp_data_unlock(sk);
> }
> @@ -2126,60 +2123,74 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
> 	msk->rcvq_space.time = mstamp;
> }
>
> -static struct mptcp_subflow_context *
> -__mptcp_first_ready_from(struct mptcp_sock *msk,
> -			 struct mptcp_subflow_context *subflow)
> +static bool __mptcp_move_skbs(struct sock *sk, struct list_head *skbs, u32 *delta)
> {
> -	struct mptcp_subflow_context *start_subflow = subflow;
> +	struct sk_buff *skb = list_first_entry(skbs, struct sk_buff, list);
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +	bool moved = false;
> +
> +	*delta = 0;
> +	while (1) {
> +		/* If the msk recvbuf is full stop, don't drop */
> +		if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
> +			break;
> +
> +		prefetch(skb->next);
> +		list_del(&skb->list);
> +		*delta += skb->truesize;
> +
> +		moved |= __mptcp_move_skb(sk, skb);
> +		if (list_empty(skbs))
> +			break;
>
> -	while (!READ_ONCE(subflow->data_avail)) {
> -		subflow = mptcp_next_subflow(msk, subflow);
> -		if (subflow == start_subflow)
> -			return NULL;
> +		skb = list_first_entry(skbs, struct sk_buff, list);
> 	}
> -	return subflow;
> +
> +	__mptcp_ofo_queue(msk);
> +	if (moved)
> +		mptcp_check_data_fin((struct sock *)msk);
> +	return moved;
> }
>
> -static bool __mptcp_move_skbs(struct sock *sk)
> +static bool mptcp_can_spool_backlog(struct sock *sk, struct list_head *skbs)
> {
> -	struct mptcp_subflow_context *subflow;
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> -	bool ret = false;
>
> -	if (list_empty(&msk->conn_list))
> +	/* Don't spool the backlog if the rcvbuf is full. */
> +	if (list_empty(&msk->backlog_list) ||
> +	    sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
> 		return false;
>
> -	subflow = list_first_entry(&msk->conn_list,
> -				   struct mptcp_subflow_context, node);
> -	for (;;) {
> -		struct sock *ssk;
> -		bool slowpath;
> +	INIT_LIST_HEAD(skbs);
> +	list_splice_init(&msk->backlog_list, skbs);
> +	return true;
> +}
>
> -		/*
> -		 * As an optimization avoid traversing the subflows list
> -		 * and ev. acquiring the subflow socket lock before baling out
> -		 */
> -		if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
> -			break;
> +static void mptcp_backlog_spooled(struct sock *sk, u32 moved,
> +				  struct list_head *skbs)
> +{
> +	struct mptcp_sock *msk = mptcp_sk(sk);
>
> -		subflow = __mptcp_first_ready_from(msk, subflow);
> -		if (!subflow)
> -			break;
> +	WRITE_ONCE(msk->backlog_len, msk->backlog_len - moved);
> +	list_splice(skbs, &msk->backlog_list);
> +}
>
> -		ssk = mptcp_subflow_tcp_sock(subflow);
> -		slowpath = lock_sock_fast(ssk);
> -		ret = __mptcp_move_skbs_from_subflow(msk, ssk) || ret;
> -		if (unlikely(ssk->sk_err))
> -			__mptcp_error_report(sk);
> -		unlock_sock_fast(ssk, slowpath);
> +static bool mptcp_move_skbs(struct sock *sk)
> +{
> +	struct list_head skbs;
> +	bool enqueued = false;
> +	u32 moved;
>
> -		subflow = mptcp_next_subflow(msk, subflow);
> -	}
> +	mptcp_data_lock(sk);
> +	while (mptcp_can_spool_backlog(sk, &skbs)) {
> +		mptcp_data_unlock(sk);
> +		enqueued |= __mptcp_move_skbs(sk, &skbs, &moved);
>
> -	__mptcp_ofo_queue(msk);
> -	if (ret)
> -		mptcp_check_data_fin((struct sock *)msk);
> -	return ret;
> +		mptcp_data_lock(sk);
> +		mptcp_backlog_spooled(sk, moved, &skbs);
> +	}
> +	mptcp_data_unlock(sk);
> +	return enqueued;
> }
>
> static unsigned int mptcp_inq_hint(const struct sock *sk)
> @@ -2245,7 +2256,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>
> 		copied += bytes_read;
>
> -		if (skb_queue_empty(&sk->sk_receive_queue) && __mptcp_move_skbs(sk))
> +		if (!list_empty(&msk->backlog_list) && mptcp_move_skbs(sk))
> 			continue;
>
> 		/* only the MPTCP socket status is relevant here. The exit
> @@ -3530,8 +3541,7 @@ void __mptcp_check_push(struct sock *sk, struct sock *ssk)
>
> #define MPTCP_FLAGS_PROCESS_CTX_NEED (BIT(MPTCP_PUSH_PENDING) | \
> 				      BIT(MPTCP_RETRANSMIT) | \
> -				      BIT(MPTCP_FLUSH_JOIN_LIST) | \
> -				      BIT(MPTCP_DEQUEUE))
> +				      BIT(MPTCP_FLUSH_JOIN_LIST))
>
> /* processes deferred events and flush wmem */
> static void mptcp_release_cb(struct sock *sk)
> @@ -3541,9 +3551,12 @@ static void mptcp_release_cb(struct sock *sk)
>
> 	for (;;) {
> 		unsigned long flags = (msk->cb_flags & MPTCP_FLAGS_PROCESS_CTX_NEED);
> -		struct list_head join_list;
> +		struct list_head join_list, skbs;
> +		bool spool_bl;
> +		u32 moved;
>
> -		if (!flags)
> +		spool_bl = mptcp_can_spool_backlog(sk, &skbs);
> +		if (!flags && !spool_bl)
> 			break;
>
> 		INIT_LIST_HEAD(&join_list);
> @@ -3565,7 +3578,7 @@ static void mptcp_release_cb(struct sock *sk)
> 			__mptcp_push_pending(sk, 0);
> 		if (flags & BIT(MPTCP_RETRANSMIT))
> 			__mptcp_retrans(sk);
> -		if ((flags & BIT(MPTCP_DEQUEUE)) && __mptcp_move_skbs(sk)) {
> +		if (spool_bl && __mptcp_move_skbs(sk, &skbs, &moved)) {
> 			/* notify ack seq update */
> 			mptcp_cleanup_rbuf(msk, 0);
> 			sk->sk_data_ready(sk);
> @@ -3573,6 +3586,8 @@ static void mptcp_release_cb(struct sock *sk)
>
> 		cond_resched();
> 		spin_lock_bh(&sk->sk_lock.slock);
> +		if (spool_bl)
> +			mptcp_backlog_spooled(sk, moved, &skbs);

Hi Paolo -

Given the discussion in v5, to address the "wild producer" scenario this 
loop can keep track of total_moved and exit the loop when that gets too 
large.

The question is what the total limit would be - available rcvbuf when 
entering the loop, or some multiple of that?

- Mat

> 	}
>
> 	if (__test_and_clear_bit(MPTCP_CLEAN_UNA, &msk->cb_flags))
> @@ -3805,7 +3820,7 @@ static int mptcp_ioctl(struct sock *sk, int cmd, int *karg)
> 			return -EINVAL;
>
> 		lock_sock(sk);
> -		if (__mptcp_move_skbs(sk))
> +		if (mptcp_move_skbs(sk))
> 			mptcp_cleanup_rbuf(msk, 0);
> 		*karg = mptcp_inq_hint(sk);
> 		release_sock(sk);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index cf82aefb5513..8e0f780e9210 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -124,7 +124,6 @@
> #define MPTCP_FLUSH_JOIN_LIST	5
> #define MPTCP_SYNC_STATE	6
> #define MPTCP_SYNC_SNDBUF	7
> -#define MPTCP_DEQUEUE		8
>
> struct mptcp_skb_cb {
> 	u64 map_seq;
> -- 
> 2.51.0
>
>
