Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C08C3D6E
	for <mptcp@lists.linux.dev>; Fri, 29 Jul 2022 23:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659135770; x=1690671770;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=HR1ITaf/kKxCNdKfmtXA7X1HxynBjxPM2tjhEj+ef40=;
  b=N7IFFZ1PtCdJvmMPP/Y3H61Mw5koD7MGuWwujw5uwljlBYzGv5N0Lx9f
   iiXsaX3M+IIen0vAXQhOzaV5cR1dCnBrOEsElTtFXJh3S8q02HO2MBdU/
   V4AfU8/eB2meksAzMOgqzbkvW1Gig7xKL3+BtYgVmR9LuPot9K+dLr5Wh
   DrYs0gHZrEDrDudW3qzug0RwuIL4KNVyq1zX+Z8xYmpTkzLmD+ecaLJm7
   ygEygRkX1dFcOr+q4/2VNry8OJ/54WD7qNKHhJqBxSLqR/B3NORVssrPl
   KhV9683qSKO5SrHbqVggx443qnE2NUTzEAv3IOR7LVwzJyk3mlmEjZlzY
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="314672067"
X-IronPort-AV: E=Sophos;i="5.93,202,1654585200"; 
   d="scan'208";a="314672067"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 16:02:49 -0700
X-IronPort-AV: E=Sophos;i="5.93,202,1654585200"; 
   d="scan'208";a="660422749"
Received: from jmborger-mobl.amr.corp.intel.com ([10.209.59.73])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 16:02:49 -0700
Date: Fri, 29 Jul 2022 16:02:49 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v2 mptcp-next 3/4] mptcp: move msk input path under full
 msk socket lock
In-Reply-To: <24af8221d74f9923858c926d4acb7d81e37dd4d2.1659117128.git.pabeni@redhat.com>
Message-ID: <f38c787-a76b-3236-814e-aa9493e4676f@linux.intel.com>
References: <cover.1659117128.git.pabeni@redhat.com> <24af8221d74f9923858c926d4acb7d81e37dd4d2.1659117128.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 29 Jul 2022, Paolo Abeni wrote:

> After commit c2e6048fa1cf ("mptcp: fix race in release_cb") it's
> pretty straight forward move the whole MPTCP rx path under the socket
> lock leveraging the release_cb.
>
> We can drop a bunch of spin_lock pairs in the receive functions, use
> a single receive queue and invoke __mptcp_move_skbs only when subflows
> ask for it.
>
> This will allow more cleanup in the next patch.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/protocol.c | 78 +++++++++++++++++++-------------------------
> net/mptcp/protocol.h |  2 +-
> 2 files changed, 35 insertions(+), 45 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 17e2dbe43639..b7982b578c86 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -795,7 +795,7 @@ static bool move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
> 	return moved > 0;
> }
>
> -void mptcp_data_ready(struct sock *sk, struct sock *ssk)
> +void __mptcp_data_ready(struct sock *sk, struct sock *ssk)

While a normal build works fine, the CI is complaining about this line in 
the "make W=1 C=1" build. The function is only used in this file, so 
adding 'static' would make 'sparse' happy.

- Mat

> {
> 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
>
> @@ -807,10 +807,17 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
> 		return;
>
> 	/* Wake-up the reader only for in-sequence data */
> -	mptcp_data_lock(sk);
> 	if (move_skbs_to_msk(mptcp_sk(sk), ssk))
> 		sk->sk_data_ready(sk);
> +}
>
> +void mptcp_data_ready(struct sock *sk, struct sock *ssk)
> +{
> +	mptcp_data_lock(sk);
> +	if (!sock_owned_by_user(sk))
> +		__mptcp_data_ready(sk, ssk);
> +	else
> +		__set_bit(MPTCP_DEQUEUE, &mptcp_sk(sk)->cb_flags);
> 	mptcp_data_unlock(sk);
> }
>
> @@ -1768,16 +1775,22 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
> 	return copied ? : ret;
> }
>
> -static int __mptcp_recvmsg_mskq(struct mptcp_sock *msk,
> +static bool __mptcp_move_skbs(struct sock *sk);
> +
> +static int __mptcp_recvmsg_mskq(struct sock *sk,
> 				struct msghdr *msg,
> 				size_t len, int flags,
> 				struct scm_timestamping_internal *tss,
> 				int *cmsg_flags)
> {
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> 	struct sk_buff *skb, *tmp;
> 	int copied = 0;
>
> -	skb_queue_walk_safe(&msk->receive_queue, skb, tmp) {
> +	if (skb_queue_empty(&sk->sk_receive_queue) && !__mptcp_move_skbs(sk))
> +		return 0;
> +
> +	skb_queue_walk_safe(&sk->sk_receive_queue, skb, tmp) {
> 		u32 offset = MPTCP_SKB_CB(skb)->offset;
> 		u32 data_len = skb->len - offset;
> 		u32 count = min_t(size_t, len - copied, data_len);
> @@ -1811,7 +1824,7 @@ static int __mptcp_recvmsg_mskq(struct mptcp_sock *msk,
> 			/* we will bulk release the skb memory later */
> 			skb->destructor = NULL;
> 			WRITE_ONCE(msk->rmem_released, msk->rmem_released + skb->truesize);
> -			__skb_unlink(skb, &msk->receive_queue);
> +			__skb_unlink(skb, &sk->sk_receive_queue);
> 			__kfree_skb(skb);
> 		}
>
> @@ -1932,16 +1945,9 @@ static void __mptcp_update_rmem(struct sock *sk)
> 	WRITE_ONCE(msk->rmem_released, 0);
> }
>
> -static void __mptcp_splice_receive_queue(struct sock *sk)
> +static bool __mptcp_move_skbs(struct sock *sk)
> {
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> -
> -	skb_queue_splice_tail_init(&sk->sk_receive_queue, &msk->receive_queue);
> -}
> -
> -static bool __mptcp_move_skbs(struct mptcp_sock *msk)
> -{
> -	struct sock *sk = (struct sock *)msk;
> 	unsigned int moved = 0;
> 	bool ret, done;
>
> @@ -1949,37 +1955,29 @@ static bool __mptcp_move_skbs(struct mptcp_sock *msk)
> 		struct sock *ssk = mptcp_subflow_recv_lookup(msk);
> 		bool slowpath;
>
> -		/* we can have data pending in the subflows only if the msk
> -		 * receive buffer was full at subflow_data_ready() time,
> -		 * that is an unlikely slow path.
> -		 */
> -		if (likely(!ssk))
> +		if (unlikely(!ssk))
> 			break;
>
> 		slowpath = lock_sock_fast(ssk);
> -		mptcp_data_lock(sk);
> 		__mptcp_update_rmem(sk);
> 		done = __mptcp_move_skbs_from_subflow(msk, ssk, &moved);
> -		mptcp_data_unlock(sk);
>
> 		if (unlikely(ssk->sk_err))
> 			__mptcp_error_report(sk);
> 		unlock_sock_fast(ssk, slowpath);
> 	} while (!done);
>
> -	/* acquire the data lock only if some input data is pending */
> 	ret = moved > 0;
> 	if (!RB_EMPTY_ROOT(&msk->out_of_order_queue) ||
> -	    !skb_queue_empty_lockless(&sk->sk_receive_queue)) {
> -		mptcp_data_lock(sk);
> +	    !skb_queue_empty(&sk->sk_receive_queue)) {
> 		__mptcp_update_rmem(sk);
> 		ret |= __mptcp_ofo_queue(msk);
> -		__mptcp_splice_receive_queue(sk);
> -		mptcp_data_unlock(sk);
> 	}
> -	if (ret)
> +	if (ret) {
> +		mptcp_cleanup_rbuf(msk);
> 		mptcp_check_data_fin((struct sock *)msk);
> -	return !skb_queue_empty(&msk->receive_queue);
> +	}
> +	return ret;
> }
>
> static unsigned int mptcp_inq_hint(const struct sock *sk)
> @@ -1987,7 +1985,7 @@ static unsigned int mptcp_inq_hint(const struct sock *sk)
> 	const struct mptcp_sock *msk = mptcp_sk(sk);
> 	const struct sk_buff *skb;
>
> -	skb = skb_peek(&msk->receive_queue);
> +	skb = skb_peek(&sk->sk_receive_queue);
> 	if (skb) {
> 		u64 hint_val = msk->ack_seq - MPTCP_SKB_CB(skb)->map_seq;
>
> @@ -2033,7 +2031,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
> 	while (copied < len) {
> 		int bytes_read;
>
> -		bytes_read = __mptcp_recvmsg_mskq(msk, msg, len - copied, flags, &tss, &cmsg_flags);
> +		bytes_read = __mptcp_recvmsg_mskq(sk, msg, len - copied, flags, &tss, &cmsg_flags);
> 		if (unlikely(bytes_read < 0)) {
> 			if (!copied)
> 				copied = bytes_read;
> @@ -2045,9 +2043,6 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
> 		/* be sure to advertise window change */
> 		mptcp_cleanup_rbuf(msk);
>
> -		if (skb_queue_empty(&msk->receive_queue) && __mptcp_move_skbs(msk))
> -			continue;
> -
> 		/* only the master socket status is relevant here. The exit
> 		 * conditions mirror closely tcp_recvmsg()
> 		 */
> @@ -2074,7 +2069,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
> 				/* race breaker: the shutdown could be after the
> 				 * previous receive queue check
> 				 */
> -				if (__mptcp_move_skbs(msk))
> +				if (__mptcp_move_skbs(sk))
> 					continue;
> 				break;
> 			}
> @@ -2111,9 +2106,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
> 		}
> 	}
>
> -	pr_debug("msk=%p rx queue empty=%d:%d copied=%d",
> -		 msk, skb_queue_empty_lockless(&sk->sk_receive_queue),
> -		 skb_queue_empty(&msk->receive_queue), copied);
> +	pr_debug("msk=%p rx queue empty=%d copied=%d",
> +		 msk, skb_queue_empty(&sk->sk_receive_queue), copied);
> 	if (!(flags & MSG_PEEK))
> 		mptcp_rcv_space_adjust(msk, copied);
>
> @@ -2566,7 +2560,6 @@ static int __mptcp_init_sock(struct sock *sk)
> 	INIT_LIST_HEAD(&msk->join_list);
> 	INIT_LIST_HEAD(&msk->rtx_queue);
> 	INIT_WORK(&msk->work, mptcp_worker);
> -	__skb_queue_head_init(&msk->receive_queue);
> 	msk->out_of_order_queue = RB_ROOT;
> 	msk->first_pending = NULL;
> 	msk->rmem_fwd_alloc = 0;
> @@ -3048,12 +3041,8 @@ void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
> 	mptcp_for_each_subflow_safe(msk, subflow, tmp)
> 		__mptcp_close_ssk(sk, mptcp_subflow_tcp_sock(subflow), subflow, flags);
>
> -	/* move to sk_receive_queue, sk_stream_kill_queues will purge it */
> -	mptcp_data_lock(sk);
> -	skb_queue_splice_tail_init(&msk->receive_queue, &sk->sk_receive_queue);
> 	__skb_queue_purge(&sk->sk_receive_queue);
> 	skb_rbtree_purge(&msk->out_of_order_queue);
> -	mptcp_data_unlock(sk);
>
> 	/* move all the rx fwd alloc into the sk_mem_reclaim_final in
> 	 * inet_sock_destruct() will dispose it
> @@ -3135,6 +3124,8 @@ static void mptcp_release_cb(struct sock *sk)
> 			__mptcp_flush_join_list(sk);
> 		if (flags & BIT(MPTCP_PUSH_PENDING))
> 			__mptcp_push_pending(sk, 0);
> +		if ((flags & BIT(MPTCP_DEQUEUE)) && __mptcp_move_skbs(sk))
> +			sk->sk_data_ready(sk);
> 		if (flags & BIT(MPTCP_RETRANSMIT))
> 			__mptcp_retrans(sk);
>
> @@ -3383,7 +3374,7 @@ static int mptcp_ioctl(struct sock *sk, int cmd, unsigned long arg)
> 			return -EINVAL;
>
> 		lock_sock(sk);
> -		__mptcp_move_skbs(msk);
> +		__mptcp_move_skbs(sk);
> 		answ = mptcp_inq_hint(sk);
> 		release_sock(sk);
> 		break;
> @@ -3619,8 +3610,7 @@ static __poll_t mptcp_check_readable(struct mptcp_sock *msk)
> 	/* Concurrent splices from sk_receive_queue into receive_queue will
> 	 * always show at least one non-empty queue when checked in this order.
> 	 */
> -	if (skb_queue_empty_lockless(&((struct sock *)msk)->sk_receive_queue) &&
> -	    skb_queue_empty_lockless(&msk->receive_queue))
> +	if (skb_queue_empty_lockless(&((struct sock *)msk)->sk_receive_queue))
> 		return 0;
>
> 	return EPOLLIN | EPOLLRDNORM;
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 1e603f28f1db..f12a6e80171d 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -125,6 +125,7 @@
> #define MPTCP_FLUSH_JOIN_LIST	5
> #define MPTCP_CONNECTED		6
> #define MPTCP_RESET_SCHEDULER	7
> +#define MPTCP_DEQUEUE		8
>
> static inline bool before64(__u64 seq1, __u64 seq2)
> {
> @@ -288,7 +289,6 @@ struct mptcp_sock {
> 	struct work_struct work;
> 	struct sk_buff  *ooo_last_skb;
> 	struct rb_root  out_of_order_queue;
> -	struct sk_buff_head receive_queue;
> 	struct list_head conn_list;
> 	struct list_head rtx_queue;
> 	struct mptcp_data_frag *first_pending;
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
