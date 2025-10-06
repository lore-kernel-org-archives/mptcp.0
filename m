Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F481400C
	for <mptcp@lists.linux.dev>; Mon,  6 Oct 2025 05:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759727351; cv=none; b=MKdQ4VoPtGB6Nos7jbqYMjZbUFUOlenlHShWSUDsBqmg0tA5uz1d1FZV+xH2ixWZOqG/n0eG9flh5VlkbLNtW8JNQTab9FQw05QKeGQKTs0U/A9TzvoD8ztZUZmLBNmju/2uimUov0valIJveo/O1P7VV9tE6cSg2QdxGvViOkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759727351; c=relaxed/simple;
	bh=d2CnKlOVchoCYK2oI4BNb/ec/OjM+yVBVImLitUmpkA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pOjBFhq6iv5xp7MvRusce1ySY7s3Alct+RLSDXy9F+w/FnlH2Ixlv8nAnri6RHroTol4pY9bHGWZx0AMrMcmX7vQAOTZg4K5+vqcK/i3kPZkhtxb+z0gf9sQq20cEEJRjsrB57OSRFrbIQmJq4VuC3vprOR/5MMeXVd8KbXstXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FA09sE0V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FA09sE0V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F49C4CEF5;
	Mon,  6 Oct 2025 05:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759727350;
	bh=d2CnKlOVchoCYK2oI4BNb/ec/OjM+yVBVImLitUmpkA=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=FA09sE0VyR5R1ZKaLcM651KqcOrlaDGW7/sA8RpSRTgtCXM8+lgXRVliwadfmakl6
	 99s1XjvI/eZGWWfJS9x0xR+tRL3gb78T6EGXVAZ14qi05sh+txGJpnJFRpNs0acFY2
	 NoxMZ7htQ6bbK4cWylK/9+c7MFnmp0IR70mNzs6oA0oARgRJ5OWWWSV3xo27h2sCZr
	 QOBU6mgiONJ/AgwcQzspwJFyNK5zbrkoGy2JztbEj7NsxwMwlxRe7XvkN4rZfbzo0J
	 LnPO461ZL/1jql7ClAQgYSxTIdOl1fG6QGjtq2NyrO/6ARze9T2/VUMrVInbzFdnek
	 zVns8hPCGYY0Q==
Message-ID: <72adcc32729a469f1306c1b594bdbb3ab0860e14.camel@kernel.org>
Subject: Re: [PATCH v4 mptcp-next 8/8] mptcp: leverage the backlog for RX
 packet processing
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Date: Mon, 06 Oct 2025 13:09:07 +0800
In-Reply-To: <da7973943502b910bd205954bbc15a1d12dd366c.1759499837.git.pabeni@redhat.com>
References: <cover.1759499837.git.pabeni@redhat.com>
	 <da7973943502b910bd205954bbc15a1d12dd366c.1759499837.git.pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Paolo,

On Fri, 2025-10-03 at 16:01 +0200, Paolo Abeni wrote:
> When the msk socket is owned or the msk receive buffer is full,
> move the incoming skbs in a msk level backlog list. This avoid
> traversing the joined subflows and acquiring the subflow level
> socket lock at reception time, improving the RX performances.
> 
> The skbs in the backlog keep using the incoming subflow receive
> space,
> to allow backpressure on the subflow flow control, and when
> processing the
> backlog, skbs exceeding the msk receive space are not dropped and
> re-inserted into backlog processing, as dropping packets already
> acked
> at the TCP level, is explicitly discouraged by the RFC and would
> corrupt
> the data stream for fallback sockets.
> 
> As a drawback, special care is needed to avoid adding skbs to the
> backlog
> of a closed msk, and to avoid leaving dangling references into the
> backlog
> at subflow closing time.
> 
> Note that we can't use sk_backlog, as such list is processed before
> release_cb() and the latter can release and re-acquire the msk level
> socket spin lock. That would cause msk-level OoO that in turn are
> fatal in case of fallback.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/mptcp/protocol.c | 204 ++++++++++++++++++++++++++++-------------
> --
>  net/mptcp/protocol.h |   5 +-
>  2 files changed, 136 insertions(+), 73 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index e354f16f4a79f..1fcdb26b8e0a0 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -654,8 +654,35 @@ static void mptcp_dss_corruption(struct
> mptcp_sock *msk, struct sock *ssk)
>  	}
>  }
>  
> +static void __mptcp_add_backlog(struct sock *sk, struct sk_buff
> *skb)
> +{
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct sk_buff *tail = NULL;
> +	bool fragstolen;
> +	int delta;
> +
> +	if (unlikely(sk->sk_state == TCP_CLOSE))
> +		kfree_skb_reason(skb, SKB_DROP_REASON_SOCKET_CLOSE);
> +
> +	/* Try to coalesce with the last skb in our backlog */
> +	if (!list_empty(&msk->backlog_list))
> +		tail = list_last_entry(&msk->backlog_list, struct
> sk_buff, list);
> +
> +	if (tail && MPTCP_SKB_CB(skb)->map_seq ==
> MPTCP_SKB_CB(tail)->end_seq &&
> +	    skb->sk == tail->sk &&
> +	    __mptcp_try_coalesce(sk, tail, skb, &fragstolen,
> &delta)) {
> +		atomic_sub(skb->truesize - delta, &skb->sk-
> >sk_rmem_alloc);
> +		kfree_skb_partial(skb, fragstolen);
> +		WRITE_ONCE(msk->backlog_len, msk->backlog_len +
> delta);
> +		return;
> +	}
> +
> +	list_add_tail(&skb->list, &msk->backlog_list);
> +	WRITE_ONCE(msk->backlog_len, msk->backlog_len + skb-
> >truesize);
> +}
> +
>  static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
> -					   struct sock *ssk)
> +					   struct sock *ssk, bool
> own_msk)
>  {
>  	struct mptcp_subflow_context *subflow =
> mptcp_subflow_ctx(ssk);
>  	struct sock *sk = (struct sock *)msk;
> @@ -671,9 +698,6 @@ static bool __mptcp_move_skbs_from_subflow(struct
> mptcp_sock *msk,
>  		struct sk_buff *skb;
>  		bool fin;
>  
> -		if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
> -			break;
> -
>  		/* try to move as much data as available */
>  		map_remaining = subflow->map_data_len -
>  				mptcp_subflow_get_map_offset(subflow
> );
> @@ -701,10 +725,18 @@ static bool
> __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
>  			int bmem;
>  
>  			bmem = mptcp_init_skb(ssk, skb, offset,
> len);
> -			skb->sk = NULL;
> -			sk_forward_alloc_add(sk, bmem);
> -			atomic_sub(skb->truesize, &ssk-
> >sk_rmem_alloc);
> -			ret = __mptcp_move_skb(sk, skb) || ret;
> +			if (own_msk)
> +				sk_forward_alloc_add(sk, bmem);
> +			else
> +				msk->borrowed_mem += bmem;
> +
> +			if (own_msk && sk_rmem_alloc_get(sk) < sk-
> >sk_rcvbuf) {
> +				skb->sk = NULL;
> +				atomic_sub(skb->truesize, &ssk-
> >sk_rmem_alloc);
> +				ret |= __mptcp_move_skb(sk, skb);
> +			} else {
> +				__mptcp_add_backlog(sk, skb);
> +			}
>  			seq += len;
>  
>  			if (unlikely(map_remaining < len)) {
> @@ -823,7 +855,7 @@ static bool move_skbs_to_msk(struct mptcp_sock
> *msk, struct sock *ssk)
>  	struct sock *sk = (struct sock *)msk;
>  	bool moved;
>  
> -	moved = __mptcp_move_skbs_from_subflow(msk, ssk);
> +	moved = __mptcp_move_skbs_from_subflow(msk, ssk, true);
>  	__mptcp_ofo_queue(msk);
>  	if (unlikely(ssk->sk_err))
>  		__mptcp_subflow_error_report(sk, ssk);
> @@ -838,18 +870,10 @@ static bool move_skbs_to_msk(struct mptcp_sock
> *msk, struct sock *ssk)
>  	return moved;
>  }
>  
> -static void __mptcp_data_ready(struct sock *sk, struct sock *ssk)
> -{
> -	struct mptcp_sock *msk = mptcp_sk(sk);
> -
> -	/* Wake-up the reader only for in-sequence data */
> -	if (move_skbs_to_msk(msk, ssk) && mptcp_epollin_ready(sk))
> -		sk->sk_data_ready(sk);
> -}
> -
>  void mptcp_data_ready(struct sock *sk, struct sock *ssk)
>  {
>  	struct mptcp_subflow_context *subflow =
> mptcp_subflow_ctx(ssk);
> +	struct mptcp_sock *msk = mptcp_sk(sk);
>  
>  	/* The peer can send data while we are shutting down this
>  	 * subflow at msk destruction time, but we must avoid
> enqueuing
> @@ -859,10 +883,13 @@ void mptcp_data_ready(struct sock *sk, struct
> sock *ssk)
>  		return;
>  
>  	mptcp_data_lock(sk);
> -	if (!sock_owned_by_user(sk))
> -		__mptcp_data_ready(sk, ssk);
> -	else
> -		__set_bit(MPTCP_DEQUEUE, &mptcp_sk(sk)->cb_flags);
> +	if (!sock_owned_by_user(sk)) {
> +		/* Wake-up the reader only for in-sequence data */
> +		if (move_skbs_to_msk(msk, ssk) &&
> mptcp_epollin_ready(sk))
> +			sk->sk_data_ready(sk);
> +	} else {
> +		__mptcp_move_skbs_from_subflow(msk, ssk, false);
> +	}
>  	mptcp_data_unlock(sk);
>  }
>  
> @@ -2096,60 +2123,61 @@ static void mptcp_rcv_space_adjust(struct
> mptcp_sock *msk, int copied)
>  	msk->rcvq_space.time = mstamp;
>  }
>  
> -static struct mptcp_subflow_context *
> -__mptcp_first_ready_from(struct mptcp_sock *msk,
> -			 struct mptcp_subflow_context *subflow)
> +static bool __mptcp_move_skbs(struct sock *sk, struct list_head
> *skbs, u32 *delta)
>  {
> -	struct mptcp_subflow_context *start_subflow = subflow;
> -
> -	while (!READ_ONCE(subflow->data_avail)) {
> -		subflow = mptcp_next_subflow(msk, subflow);
> -		if (subflow == start_subflow)
> -			return NULL;
> -	}
> -	return subflow;
> -}
> -
> -static bool __mptcp_move_skbs(struct sock *sk)
> -{
> -	struct mptcp_subflow_context *subflow;
> +	struct sk_buff *skb = list_first_entry(skbs, struct sk_buff,
> list);
>  	struct mptcp_sock *msk = mptcp_sk(sk);
> -	bool ret = false;
> -
> -	if (list_empty(&msk->conn_list))
> -		return false;
> -
> -	subflow = list_first_entry(&msk->conn_list,
> -				   struct mptcp_subflow_context,
> node);
> -	for (;;) {
> -		struct sock *ssk;
> -		bool slowpath;
> +	bool moved = false;
>  
> -		/*
> -		 * As an optimization avoid traversing the subflows
> list
> -		 * and ev. acquiring the subflow socket lock before
> baling out
> -		 */
> +	while (1) {
> +		/* If the msk recvbuf is full stop, don't drop */
>  		if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
>  			break;
>  
> -		subflow = __mptcp_first_ready_from(msk, subflow);
> -		if (!subflow)
> -			break;
> +		prefetch(skb->next);
> +		list_del(&skb->list);
> +		*delta += skb->truesize;
>  
> -		ssk = mptcp_subflow_tcp_sock(subflow);
> -		slowpath = lock_sock_fast(ssk);
> -		ret = __mptcp_move_skbs_from_subflow(msk, ssk) ||
> ret;
> -		if (unlikely(ssk->sk_err))
> -			__mptcp_error_report(sk);
> -		unlock_sock_fast(ssk, slowpath);
> +		/* Release the memory allocated on the incoming
> subflow before
> +		 * moving it to the msk
> +		 */
> +		atomic_sub(skb->truesize, &skb->sk->sk_rmem_alloc);
> +		skb->sk = NULL;
> +		moved |= __mptcp_move_skb(sk, skb);
> +		if (list_empty(skbs))
> +			break;
>  
> -		subflow = mptcp_next_subflow(msk, subflow);
> +		skb = list_first_entry(skbs, struct sk_buff, list);
>  	}
>  
>  	__mptcp_ofo_queue(msk);
> -	if (ret)
> +	if (moved)
>  		mptcp_check_data_fin((struct sock *)msk);
> -	return ret;
> +	return moved;
> +}
> +
> +static bool mptcp_move_skbs(struct sock *sk)
> +{
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +	bool moved = false;
> +	LIST_HEAD(skbs);
> +	u32 delta = 0;
> +
> +	mptcp_data_lock(sk);
> +	while (!list_empty(&msk->backlog_list)) {
> +		list_splice_init(&msk->backlog_list, &skbs);
> +		mptcp_data_unlock(sk);
> +		moved |= __mptcp_move_skbs(sk, &skbs, &delta);
> +
> +		mptcp_data_lock(sk);
> +		if (!list_empty(&skbs)) {
> +			list_splice(&skbs, &msk->backlog_list);
> +			break;
> +		}
> +	}
> +	WRITE_ONCE(msk->backlog_len, msk->backlog_len - delta);
> +	mptcp_data_unlock(sk);
> +	return moved;
>  }
>  
>  static unsigned int mptcp_inq_hint(const struct sock *sk)
> @@ -2215,7 +2243,7 @@ static int mptcp_recvmsg(struct sock *sk,
> struct msghdr *msg, size_t len,
>  
>  		copied += bytes_read;
>  
> -		if (skb_queue_empty(&sk->sk_receive_queue) &&
> __mptcp_move_skbs(sk))
> +		if (!list_empty(&msk->backlog_list) &&
> mptcp_move_skbs(sk))
>  			continue;
>  
>  		/* only the MPTCP socket status is relevant here.
> The exit
> @@ -2520,6 +2548,9 @@ static void __mptcp_close_ssk(struct sock *sk,
> struct sock *ssk,
>  void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
>  		     struct mptcp_subflow_context *subflow)
>  {
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct sk_buff *skb;
> +
>  	/* The first subflow can already be closed and still in the
> list */
>  	if (subflow->close_event_done)
>  		return;
> @@ -2529,6 +2560,18 @@ void mptcp_close_ssk(struct sock *sk, struct
> sock *ssk,
>  	if (sk->sk_state == TCP_ESTABLISHED)
>  		mptcp_event(MPTCP_EVENT_SUB_CLOSED, mptcp_sk(sk),
> ssk, GFP_KERNEL);
>  
> +	/* Remove any reference from the backlog to this ssk,
> accounting the
> +	 * related skb directly to the main socket
> +	 */
> +	list_for_each_entry(skb, &msk->backlog_list, list) {
> +		if (skb->sk != ssk)
> +			continue;
> +
> +		atomic_sub(skb->truesize, &skb->sk->sk_rmem_alloc);
> +		atomic_add(skb->truesize, &sk->sk_rmem_alloc);
> +		skb->sk = sk;
> +	}
> +
>  	/* subflow aborted before reaching the fully_established
> status
>  	 * attempt the creation of the next subflow
>  	 */
> @@ -2761,8 +2804,11 @@ static void mptcp_do_fastclose(struct sock
> *sk)
>  {
>  	struct mptcp_subflow_context *subflow, *tmp;
>  	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct sk_buff *skb;
>  
>  	mptcp_set_state(sk, TCP_CLOSE);
> +	list_for_each_entry(skb, &msk->backlog_list, list)
> +		kfree_skb_reason(skb, SKB_DROP_REASON_SOCKET_CLOSE);
>  	mptcp_for_each_subflow_safe(msk, subflow, tmp)
>  		__mptcp_close_ssk(sk,
> mptcp_subflow_tcp_sock(subflow),
>  				  subflow, MPTCP_CF_FASTCLOSE);
> @@ -2820,6 +2866,7 @@ static void __mptcp_init_sock(struct sock *sk)
>  	INIT_LIST_HEAD(&msk->conn_list);
>  	INIT_LIST_HEAD(&msk->join_list);
>  	INIT_LIST_HEAD(&msk->rtx_queue);
> +	INIT_LIST_HEAD(&msk->backlog_list);
>  	INIT_WORK(&msk->work, mptcp_worker);
>  	msk->out_of_order_queue = RB_ROOT;
>  	msk->first_pending = NULL;
> @@ -3199,9 +3246,13 @@ static void mptcp_destroy_common(struct
> mptcp_sock *msk, unsigned int flags)
>  {
>  	struct mptcp_subflow_context *subflow, *tmp;
>  	struct sock *sk = (struct sock *)msk;
> +	struct sk_buff *skb;
>  
>  	__mptcp_clear_xmit(sk);
>  
> +	list_for_each_entry(skb, &msk->backlog_list, list)
> +		kfree_skb_reason(skb, SKB_DROP_REASON_SOCKET_CLOSE);
> +

I encountered this error while testing the splice test:

[ 6708.714803] BUG: KFENCE: use-after-free read in mptcp_destroy_common
(net/mptcp/protocol.c:3233 (discriminator 4))  
[ 6708.714803] 
[ 6708.714848] Use-after-free read at 0x000000007fc00f9c (in kfence-
#253):

Holding the msk data lock while traversing the backlog_list can fix
this error:

        mptcp_data_lock(sk);
        list_for_each_entry(skb, &msk->backlog_list, list)
                kfree_skb_reason(skb, SKB_DROP_REASON_SOCKET_CLOSE);
        mptcp_data_unlock(sk);

Similarly, I have also added the holding of the msk data lock in
mptcp_do_fastclose().

I would like to ask if this modification is acceptable. If it works, I
can send a squash-to patch for this.

Thanks,
-Geliang

>  	/* join list will be eventually flushed (with rst) at sock
> lock release time */
>  	mptcp_for_each_subflow_safe(msk, subflow, tmp)
>  		__mptcp_close_ssk(sk,
> mptcp_subflow_tcp_sock(subflow), subflow, flags);
> @@ -3451,23 +3502,29 @@ void __mptcp_check_push(struct sock *sk,
> struct sock *ssk)
>  
>  #define MPTCP_FLAGS_PROCESS_CTX_NEED (BIT(MPTCP_PUSH_PENDING) | \
>  				      BIT(MPTCP_RETRANSMIT) | \
> -				      BIT(MPTCP_FLUSH_JOIN_LIST) | \
> -				      BIT(MPTCP_DEQUEUE))
> +				      BIT(MPTCP_FLUSH_JOIN_LIST))
>  
>  /* processes deferred events and flush wmem */
>  static void mptcp_release_cb(struct sock *sk)
>  	__must_hold(&sk->sk_lock.slock)
>  {
>  	struct mptcp_sock *msk = mptcp_sk(sk);
> +	u32 delta = 0;
>  
>  	for (;;) {
>  		unsigned long flags = (msk->cb_flags &
> MPTCP_FLAGS_PROCESS_CTX_NEED);
> -		struct list_head join_list;
> +		LIST_HEAD(join_list);
> +		LIST_HEAD(skbs);
> +
> +		sk_forward_alloc_add(sk, msk->borrowed_mem);
> +		msk->borrowed_mem = 0;
> +
> +		if (sk_rmem_alloc_get(sk) < sk->sk_rcvbuf)
> +			list_splice_init(&msk->backlog_list, &skbs);
>  
> -		if (!flags)
> +		if (!flags && list_empty(&skbs))
>  			break;
>  
> -		INIT_LIST_HEAD(&join_list);
>  		list_splice_init(&msk->join_list, &join_list);
>  
>  		/* the following actions acquire the subflow socket
> lock
> @@ -3486,7 +3543,8 @@ static void mptcp_release_cb(struct sock *sk)
>  			__mptcp_push_pending(sk, 0);
>  		if (flags & BIT(MPTCP_RETRANSMIT))
>  			__mptcp_retrans(sk);
> -		if ((flags & BIT(MPTCP_DEQUEUE)) &&
> __mptcp_move_skbs(sk)) {
> +		if (!list_empty(&skbs) &&
> +		    __mptcp_move_skbs(sk, &skbs, &delta)) {
>  			/* notify ack seq update */
>  			mptcp_cleanup_rbuf(msk, 0);
>  			sk->sk_data_ready(sk);
> @@ -3494,7 +3552,9 @@ static void mptcp_release_cb(struct sock *sk)
>  
>  		cond_resched();
>  		spin_lock_bh(&sk->sk_lock.slock);
> +		list_splice(&skbs, &msk->backlog_list);
>  	}
> +	WRITE_ONCE(msk->backlog_len, msk->backlog_len - delta);
>  
>  	if (__test_and_clear_bit(MPTCP_CLEAN_UNA, &msk->cb_flags))
>  		__mptcp_clean_una_wakeup(sk);
> @@ -3726,7 +3786,7 @@ static int mptcp_ioctl(struct sock *sk, int
> cmd, int *karg)
>  			return -EINVAL;
>  
>  		lock_sock(sk);
> -		if (__mptcp_move_skbs(sk))
> +		if (mptcp_move_skbs(sk))
>  			mptcp_cleanup_rbuf(msk, 0);
>  		*karg = mptcp_inq_hint(sk);
>  		release_sock(sk);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 46d8432c72ee7..c9c6582b4e1c4 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -124,7 +124,6 @@
>  #define MPTCP_FLUSH_JOIN_LIST	5
>  #define MPTCP_SYNC_STATE	6
>  #define MPTCP_SYNC_SNDBUF	7
> -#define MPTCP_DEQUEUE		8
>  
>  struct mptcp_skb_cb {
>  	u64 map_seq;
> @@ -301,6 +300,7 @@ struct mptcp_sock {
>  	u32		last_ack_recv;
>  	unsigned long	timer_ival;
>  	u32		token;
> +	u32		borrowed_mem;
>  	unsigned long	flags;
>  	unsigned long	cb_flags;
>  	bool		recovery;		/* closing subflow
> write queue reinjected */
> @@ -358,6 +358,8 @@ struct mptcp_sock {
>  					 * allow_infinite_fallback
> and
>  					 * allow_join
>  					 */
> +	struct list_head backlog_list;	/*protected by the data lock
> */
> +	u32		backlog_len;
>  };
>  
>  #define mptcp_data_lock(sk) spin_lock_bh(&(sk)->sk_lock.slock)
> @@ -408,6 +410,7 @@ static inline int mptcp_space_from_win(const
> struct sock *sk, int win)
>  static inline int __mptcp_space(const struct sock *sk)
>  {
>  	return mptcp_win_from_space(sk, READ_ONCE(sk->sk_rcvbuf) -
> +				    READ_ONCE(mptcp_sk(sk)-
> >backlog_len) -
>  				    sk_rmem_alloc_get(sk));
>  }
>  

