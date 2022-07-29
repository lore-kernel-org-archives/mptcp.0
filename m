Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4BA3D6E
	for <mptcp@lists.linux.dev>; Fri, 29 Jul 2022 23:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659136594; x=1690672594;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=q8O/YnRHhzZQP2Zqq0cK/rXomW5b1AkXai47dlbpWqs=;
  b=J3IYMyKmZLbvsdlabuuxA62Ml1+YZwHHUyKXvm7TEz9EnWhKw5kMpehQ
   PcxnqoWyKTVUl+7vHRm8jqF14uOWE6PZW5FQd86stgKx/ejhaHU6TltjD
   T3s+UNNvlVNswSnCvG7KqCmIU/+rlBPmLKQZLMvvTo3aj0xEdoIBTamID
   irsgHK3f1CzdJJVJZpP9+gJ37fWLEDeYGjo3CBPPkv3fc71jFx4alklMb
   ebsXIL7M+H7F6jqyx/cZ7Y5K+BJsqzwavCjt04j4zUCZ63NOoDUpFb8jN
   4JSVn7xt8xPm+VhWRkPfkKPfApFW32DyIDLivnC3Sd18SmS0f/xJqeiMy
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="289634187"
X-IronPort-AV: E=Sophos;i="5.93,202,1654585200"; 
   d="scan'208";a="289634187"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 16:16:33 -0700
X-IronPort-AV: E=Sophos;i="5.93,202,1654585200"; 
   d="scan'208";a="660427527"
Received: from jmborger-mobl.amr.corp.intel.com ([10.209.59.73])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 16:16:33 -0700
Date: Fri, 29 Jul 2022 16:16:33 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v2 mptcp-next 4/4] mptcp: use common helper for rmem
 memory accounting
In-Reply-To: <a5a451ed4421993380b46e8b546b228a66001212.1659117128.git.pabeni@redhat.com>
Message-ID: <e4991ead-b640-263c-33b2-b43a5a1f6c90@linux.intel.com>
References: <cover.1659117128.git.pabeni@redhat.com> <a5a451ed4421993380b46e8b546b228a66001212.1659117128.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 29 Jul 2022, Paolo Abeni wrote:

> After the previous patch, updating sk_forward_memory is cheap and
> we can drop a lot of complexity from the MPTCP memory acconting,
> using the common helper for that.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/protocol.c | 112 ++++---------------------------------------
> net/mptcp/protocol.h |   4 +-
> 2 files changed, 9 insertions(+), 107 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index b7982b578c86..f6ff130f39c1 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -131,11 +131,6 @@ static void mptcp_drop(struct sock *sk, struct sk_buff *skb)
> 	__kfree_skb(skb);
> }
>
> -static void mptcp_rmem_charge(struct sock *sk, int size)
> -{
> -	mptcp_sk(sk)->rmem_fwd_alloc -= size;
> -}
> -
> static bool mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
> 			       struct sk_buff *from)
> {
> @@ -152,7 +147,7 @@ static bool mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
> 	MPTCP_SKB_CB(to)->end_seq = MPTCP_SKB_CB(from)->end_seq;
> 	kfree_skb_partial(from, fragstolen);
> 	atomic_add(delta, &sk->sk_rmem_alloc);
> -	mptcp_rmem_charge(sk, delta);
> +	sk->sk_forward_alloc -= delta;
> 	return true;
> }
>
> @@ -165,44 +160,6 @@ static bool mptcp_ooo_try_coalesce(struct mptcp_sock *msk, struct sk_buff *to,
> 	return mptcp_try_coalesce((struct sock *)msk, to, from);
> }
>
> -static void __mptcp_rmem_reclaim(struct sock *sk, int amount)
> -{
> -	amount >>= PAGE_SHIFT;
> -	mptcp_sk(sk)->rmem_fwd_alloc -= amount << PAGE_SHIFT;
> -	__sk_mem_reduce_allocated(sk, amount);
> -}
> -
> -static void mptcp_rmem_uncharge(struct sock *sk, int size)
> -{
> -	struct mptcp_sock *msk = mptcp_sk(sk);
> -	int reclaimable;
> -
> -	msk->rmem_fwd_alloc += size;
> -	reclaimable = msk->rmem_fwd_alloc - sk_unused_reserved_mem(sk);
> -
> -	/* see sk_mem_uncharge() for the rationale behind the following schema */
> -	if (unlikely(reclaimable >= PAGE_SIZE))
> -		__mptcp_rmem_reclaim(sk, reclaimable);
> -}
> -
> -static void mptcp_rfree(struct sk_buff *skb)
> -{
> -	unsigned int len = skb->truesize;
> -	struct sock *sk = skb->sk;
> -
> -	atomic_sub(len, &sk->sk_rmem_alloc);
> -	mptcp_rmem_uncharge(sk, len);
> -}
> -
> -static void mptcp_set_owner_r(struct sk_buff *skb, struct sock *sk)
> -{
> -	skb_orphan(skb);
> -	skb->sk = sk;
> -	skb->destructor = mptcp_rfree;
> -	atomic_add(skb->truesize, &sk->sk_rmem_alloc);
> -	mptcp_rmem_charge(sk, skb->truesize);
> -}
> -
> /* "inspired" by tcp_data_queue_ofo(), main differences:
>  * - use mptcp seqs
>  * - don't cope with sacks
> @@ -315,25 +272,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
>
> end:
> 	skb_condense(skb);
> -	mptcp_set_owner_r(skb, sk);
> -}
> -
> -static bool mptcp_rmem_schedule(struct sock *sk, struct sock *ssk, int size)
> -{
> -	struct mptcp_sock *msk = mptcp_sk(sk);
> -	int amt, amount;
> -
> -	if (size <= msk->rmem_fwd_alloc)
> -		return true;
> -
> -	size -= msk->rmem_fwd_alloc;
> -	amt = sk_mem_pages(size);
> -	amount = amt << PAGE_SHIFT;
> -	if (!__sk_mem_raise_allocated(sk, size, amt, SK_MEM_RECV))
> -		return false;
> -
> -	msk->rmem_fwd_alloc += amount;
> -	return true;
> +	skb_set_owner_r(skb, sk);
> }
>
> static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
> @@ -350,8 +289,7 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
> 	skb_ext_reset(skb);
> 	skb_orphan(skb);
>
> -	/* try to fetch required memory from subflow */
> -	if (!mptcp_rmem_schedule(sk, ssk, skb->truesize))
> +	if (!sk_rmem_schedule(sk, skb, skb->truesize))
> 		goto drop;
>
> 	has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
> @@ -372,7 +310,7 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
> 		if (tail && mptcp_try_coalesce(sk, tail, skb))
> 			return true;
>
> -		mptcp_set_owner_r(skb, sk);
> +		skb_set_owner_r(skb, sk);
> 		__skb_queue_tail(&sk->sk_receive_queue, skb);
> 		return true;
> 	} else if (after64(MPTCP_SKB_CB(skb)->map_seq, msk->ack_seq)) {
> @@ -1783,7 +1721,6 @@ static int __mptcp_recvmsg_mskq(struct sock *sk,
> 				struct scm_timestamping_internal *tss,
> 				int *cmsg_flags)
> {
> -	struct mptcp_sock *msk = mptcp_sk(sk);
> 	struct sk_buff *skb, *tmp;
> 	int copied = 0;
>
> @@ -1821,9 +1758,10 @@ static int __mptcp_recvmsg_mskq(struct sock *sk,
> 		}
>
> 		if (!(flags & MSG_PEEK)) {
> -			/* we will bulk release the skb memory later */
> +			/* avoid the indirect call, we know the destructor is sock_wfree */
> 			skb->destructor = NULL;
> -			WRITE_ONCE(msk->rmem_released, msk->rmem_released + skb->truesize);
> +			atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
> +			sk_mem_uncharge(sk, skb->truesize);
> 			__skb_unlink(skb, &sk->sk_receive_queue);
> 			__kfree_skb(skb);
> 		}
> @@ -1933,18 +1871,6 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
> 	msk->rcvq_space.time = mstamp;
> }
>
> -static void __mptcp_update_rmem(struct sock *sk)
> -{
> -	struct mptcp_sock *msk = mptcp_sk(sk);
> -
> -	if (!msk->rmem_released)
> -		return;
> -
> -	atomic_sub(msk->rmem_released, &sk->sk_rmem_alloc);
> -	mptcp_rmem_uncharge(sk, msk->rmem_released);
> -	WRITE_ONCE(msk->rmem_released, 0);
> -}
> -
> static bool __mptcp_move_skbs(struct sock *sk)
> {
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> @@ -1959,7 +1885,6 @@ static bool __mptcp_move_skbs(struct sock *sk)
> 			break;
>
> 		slowpath = lock_sock_fast(ssk);
> -		__mptcp_update_rmem(sk);
> 		done = __mptcp_move_skbs_from_subflow(msk, ssk, &moved);
>
> 		if (unlikely(ssk->sk_err))
> @@ -1968,11 +1893,7 @@ static bool __mptcp_move_skbs(struct sock *sk)
> 	} while (!done);
>
> 	ret = moved > 0;
> -	if (!RB_EMPTY_ROOT(&msk->out_of_order_queue) ||
> -	    !skb_queue_empty(&sk->sk_receive_queue)) {
> -		__mptcp_update_rmem(sk);
> -		ret |= __mptcp_ofo_queue(msk);
> -	}
> +	ret |= __mptcp_ofo_queue(msk);
> 	if (ret) {
> 		mptcp_cleanup_rbuf(msk);
> 		mptcp_check_data_fin((struct sock *)msk);
> @@ -2562,8 +2483,6 @@ static int __mptcp_init_sock(struct sock *sk)
> 	INIT_WORK(&msk->work, mptcp_worker);
> 	msk->out_of_order_queue = RB_ROOT;
> 	msk->first_pending = NULL;
> -	msk->rmem_fwd_alloc = 0;
> -	WRITE_ONCE(msk->rmem_released, 0);
> 	msk->timer_ival = TCP_RTO_MIN;
>
> 	msk->first = NULL;
> @@ -2775,8 +2694,6 @@ static void __mptcp_destroy_sock(struct sock *sk)
>
> 	sk->sk_prot->destroy(sk);
>
> -	WARN_ON_ONCE(msk->rmem_fwd_alloc);
> -	WARN_ON_ONCE(msk->rmem_released);
> 	sk_stream_kill_queues(sk);
> 	xfrm_sk_free_policy(sk);
>
> @@ -3044,11 +2961,6 @@ void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
> 	__skb_queue_purge(&sk->sk_receive_queue);
> 	skb_rbtree_purge(&msk->out_of_order_queue);
>
> -	/* move all the rx fwd alloc into the sk_mem_reclaim_final in
> -	 * inet_sock_destruct() will dispose it
> -	 */
> -	sk->sk_forward_alloc += msk->rmem_fwd_alloc;
> -	msk->rmem_fwd_alloc = 0;
> 	mptcp_token_destroy(msk);
> 	mptcp_pm_free_anno_list(msk);
> 	mptcp_free_local_addr_list(msk);
> @@ -3146,8 +3058,6 @@ static void mptcp_release_cb(struct sock *sk)
> 		if (__test_and_clear_bit(MPTCP_RESET_SCHEDULER, &msk->cb_flags))
> 			msk->last_snd = NULL;
> 	}
> -
> -	__mptcp_update_rmem(sk);
> }
>
> /* MP_JOIN client subflow must wait for 4th ack before sending any data:
> @@ -3328,11 +3238,6 @@ static void mptcp_shutdown(struct sock *sk, int how)
> 		__mptcp_wr_shutdown(sk);
> }
>
> -static int mptcp_forward_alloc_get(const struct sock *sk)
> -{
> -	return sk->sk_forward_alloc + mptcp_sk(sk)->rmem_fwd_alloc;
> -}
> -
> static int mptcp_ioctl_outq(const struct mptcp_sock *msk, u64 v)
> {
> 	const struct sock *sk = (void *)msk;
> @@ -3413,7 +3318,6 @@ static struct proto mptcp_prot = {
> 	.hash		= mptcp_hash,
> 	.unhash		= mptcp_unhash,
> 	.get_port	= mptcp_get_port,
> -	.forward_alloc_get	= mptcp_forward_alloc_get,

Since MPTCP is (or "was") the only user of forward_alloc_get... seems like 
another patch should be added to rip out all the forward_alloc_get stuff?

This is mostly a matter of reverting

292e6077b040 ("net: introduce sk_forward_alloc_get()")
and
6c302e799a0d ("net: forward_alloc_get depends on CONFIG_MPTCP")

(although the 2nd has a minor conflict)


Overall, the series tests fine and removes a lot of complexity, just 
these minor comments to address. Thanks!

- Mat

> 	.sockets_allocated	= &mptcp_sockets_allocated,
>
> 	.memory_allocated	= &tcp_memory_allocated,
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index f12a6e80171d..d4a267cb7663 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -258,7 +258,6 @@ struct mptcp_sock {
> 	u64		ack_seq;
> 	atomic64_t	rcv_wnd_sent;
> 	u64		rcv_data_fin_seq;
> -	int		rmem_fwd_alloc;
> 	struct sock	*last_snd;
> 	int		snd_burst;
> 	u64		recovery_snd_nxt;	/* in recovery mode accept up to this seq;
> @@ -269,7 +268,6 @@ struct mptcp_sock {
> 	u64		wnd_end;
> 	unsigned long	timer_ival;
> 	u32		token;
> -	int		rmem_released;
> 	unsigned long	flags;
> 	unsigned long	cb_flags;
> 	unsigned long	push_pending;
> @@ -332,7 +330,7 @@ static inline struct mptcp_sock *mptcp_sk(const struct sock *sk)
>  */
> static inline int __mptcp_rmem(const struct sock *sk)
> {
> -	return atomic_read(&sk->sk_rmem_alloc) - READ_ONCE(mptcp_sk(sk)->rmem_released);
> +	return atomic_read(&sk->sk_rmem_alloc);
> }
>
> static inline int __mptcp_receive_window(const struct mptcp_sock *msk)
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
