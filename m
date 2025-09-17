Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392A0285073
	for <mptcp@lists.linux.dev>; Wed, 17 Sep 2025 10:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758103657; cv=none; b=HOdZAp1mMy8g+xg7rxvwjX9ar2xe/xOQfZ+ea8FPAHV2CMbu1U2I7MvHg41VX28mF2e3VXHK0TpLpuZHIjH95X1Zo8Eo6IH5M7XZBg6GeaHZvizsQi5yczmHYWqm5McGXv48yHsbfc8hlohT+dXkFPIlHEt4a+ydlRlM6QVxYpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758103657; c=relaxed/simple;
	bh=1HnzwC/r+xrBnReM+qmxCSm/85y+NeFYJ9+P0iD/p0g=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tYQbp4pY9do+FBP0fhD47VAjyEd66YKzeo1DcE9IBWsJuNIh8CNpksgRVnrNN1iv1UVTzpPaRlvH6VL7Hkj3YMkKXEfleE9HDIqQP//cMvwuAFgikxrrUi8fQZY9Lv4OBsyaNNyyYvHvd760+q3FSAa2P1/N/ZaN09SqbaWYDUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2IybveO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2IybveO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE0CC4CEF0;
	Wed, 17 Sep 2025 10:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758103656;
	bh=1HnzwC/r+xrBnReM+qmxCSm/85y+NeFYJ9+P0iD/p0g=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=B2IybveOK9plAWFJ1XLQuQVQvWSc4L/YTx0eG6br0fkFcAP4MHeZu3JjuV68ezKTa
	 SgrhjsfqRiClbiL+s3qAh8k3UNR2xUJsAvzVzwlLInUXO0q+joKzD+MBH/lHuuVHCc
	 qlbrG55TfEWgMbRCT67fdWLMoaJysVQJPMxvHdzgI01HwPz4NFxWuhxu6e40ggeQRp
	 0Z7RWVvP2eEV9wxbwjePoikjxVhm7tp2Cq/1AH0OQbmBNozTi54VsqZUzWwBkGY7jJ
	 cisiE4NOVet/ItF4s/kSRFnwLFApbvL/33bY2HvcUgOMosYStcGh11D54qs966JYMZ
	 s0EbmpjM2nDlQ==
Message-ID: <8e688f56dcd264805bac777f1612241f6b2eb836.camel@kernel.org>
Subject: Re: [MPTCP next 09/12] mptcp: leverage the sk backlog for RX packet
 processing.
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Date: Wed, 17 Sep 2025 18:07:33 +0800
In-Reply-To: <aa6e34c45c507061a316f29d075f050cbbbdbe2d.1758039775.git.pabeni@redhat.com>
References: <cover.1758039775.git.pabeni@redhat.com>
	 <aa6e34c45c507061a316f29d075f050cbbbdbe2d.1758039775.git.pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Paolo,

On Tue, 2025-09-16 at 18:27 +0200, Paolo Abeni wrote:
> This streamline the RX path implementation and improves the RX
> performances by reducing the subflow-level locking and the amount of
> work done under the msk socket lock; the implementation mirror
> closely
> the TCP backlog processing.
> 
> Note that MPTCP needs now to traverse the existing subflow looking
> for
> data that was left there due to the msk receive buffer full, only
> after
> that recvmsg completely empties the receive queue.

This patch breaks my "implement mptcp read_sock v11" test case in
patchwork, and I haven't figured out the reason yet.

Thanks,
-Geliang

> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/mptcp/protocol.c | 107 ++++++++++++++++++++++++++++++-----------
> --
>  net/mptcp/protocol.h |   2 +-
>  2 files changed, 75 insertions(+), 34 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 251760183118a..9c3baed948d1d 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -357,10 +357,31 @@ static void mptcp_init_skb(struct sock *ssk,
>  	skb_dst_drop(skb);
>  }
>  
> -static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sk_buff
> *skb)
> +static void __mptcp_add_backlog(struct sock *sk, struct sock *ssk,
> +				struct sk_buff *skb)
> +{
> +	struct sk_buff *tail = sk->sk_backlog.tail;
> +	bool fragstolen;
> +	int delta;
> +
> +	if (tail && MPTCP_SKB_CB(skb)->map_seq ==
> MPTCP_SKB_CB(tail)->end_seq) {
> +		delta = __mptcp_try_coalesce(sk, tail, skb,
> &fragstolen);
> +		if (delta) {
> +			sk->sk_backlog.len += delta;
> +			kfree_skb_partial(skb, fragstolen);
> +			return;
> +		}
> +	}
> +
> +	/* mptcp checks the limit before adding the skb to the
> backlog */
> +	__sk_add_backlog(sk, skb);
> +	sk->sk_backlog.len += skb->truesize;
> +}
> +
> +static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
>  {
>  	u64 copy_len = MPTCP_SKB_CB(skb)->end_seq -
> MPTCP_SKB_CB(skb)->map_seq;
> -	struct sock *sk = (struct sock *)msk;
> +	struct mptcp_sock *msk = mptcp_sk(sk);
>  	struct sk_buff *tail;
>  
>  	/* try to fetch required memory from subflow */
> @@ -632,7 +653,7 @@ static void mptcp_dss_corruption(struct
> mptcp_sock *msk, struct sock *ssk)
>  }
>  
>  static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
> -					   struct sock *ssk)
> +					   struct sock *ssk, bool
> own_msk)
>  {
>  	struct mptcp_subflow_context *subflow =
> mptcp_subflow_ctx(ssk);
>  	struct sock *sk = (struct sock *)msk;
> @@ -643,12 +664,13 @@ static bool
> __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
>  	pr_debug("msk=%p ssk=%p\n", msk, ssk);
>  	tp = tcp_sk(ssk);
>  	do {
> +		int mem = own_msk ? sk_rmem_alloc_get(sk) : sk-
> >sk_backlog.len;
>  		u32 map_remaining, offset;
>  		u32 seq = tp->copied_seq;
>  		struct sk_buff *skb;
>  		bool fin;
>  
> -		if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
> +		if (mem > READ_ONCE(sk->sk_rcvbuf))
>  			break;
>  
>  		/* try to move as much data as available */
> @@ -678,7 +700,11 @@ static bool
> __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
>  
>  			mptcp_init_skb(ssk, subflow, skb, offset,
> len);
>  			skb_orphan(skb);
> -			ret = __mptcp_move_skb(msk, skb) || ret;
> +
> +			if (own_msk)
> +				ret |= __mptcp_move_skb(sk, skb);
> +			else
> +				__mptcp_add_backlog(sk, ssk, skb);
>  			seq += len;
>  
>  			if (unlikely(map_remaining < len)) {
> @@ -699,7 +725,7 @@ static bool __mptcp_move_skbs_from_subflow(struct
> mptcp_sock *msk,
>  
>  	} while (more_data_avail);
>  
> -	if (ret)
> +	if (ret && own_msk)
>  		msk->last_data_recv = tcp_jiffies32;
>  	return ret;
>  }
> @@ -797,7 +823,7 @@ static bool move_skbs_to_msk(struct mptcp_sock
> *msk, struct sock *ssk)
>  	struct sock *sk = (struct sock *)msk;
>  	bool moved;
>  
> -	moved = __mptcp_move_skbs_from_subflow(msk, ssk);
> +	moved = __mptcp_move_skbs_from_subflow(msk, ssk, true);
>  	__mptcp_ofo_queue(msk);
>  	if (unlikely(ssk->sk_err))
>  		__mptcp_subflow_error_report(sk, ssk);
> @@ -812,18 +838,10 @@ static bool move_skbs_to_msk(struct mptcp_sock
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
> @@ -833,13 +851,33 @@ void mptcp_data_ready(struct sock *sk, struct
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
> +		if (unlikely(ssk->sk_err))
> +			__set_bit(MPTCP_ERROR_REPORT,  &msk-
> >cb_flags);
> +	}
>  	mptcp_data_unlock(sk);
>  }
>  
> +static int mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
> +{
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +
> +	if (__mptcp_move_skb(sk, skb)) {
> +		msk->last_data_recv = tcp_jiffies32;
> +		__mptcp_ofo_queue(msk);
> +		/* notify ack seq update */
> +		mptcp_cleanup_rbuf(msk, 0);
> +		mptcp_check_data_fin(sk);
> +		sk->sk_data_ready(sk);
> +	}
> +	return 0;
> +}
> +
>  static void mptcp_subflow_joined(struct mptcp_sock *msk, struct sock
> *ssk)
>  {
>  	mptcp_subflow_ctx(ssk)->map_seq = READ_ONCE(msk->ack_seq);
> @@ -2085,7 +2123,7 @@ static bool __mptcp_move_skbs(struct sock *sk)
>  
>  		ssk = mptcp_subflow_tcp_sock(subflow);
>  		slowpath = lock_sock_fast(ssk);
> -		ret = __mptcp_move_skbs_from_subflow(msk, ssk) ||
> ret;
> +		ret = __mptcp_move_skbs_from_subflow(msk, ssk, true)
> || ret;
>  		if (unlikely(ssk->sk_err))
>  			__mptcp_error_report(sk);
>  		unlock_sock_fast(ssk, slowpath);
> @@ -2159,8 +2197,12 @@ static int mptcp_recvmsg(struct sock *sk,
> struct msghdr *msg, size_t len,
>  
>  		copied += bytes_read;
>  
> -		if (skb_queue_empty(&sk->sk_receive_queue) &&
> __mptcp_move_skbs(sk))
> -			continue;
> +		if (skb_queue_empty(&sk->sk_receive_queue)) {
> +			__sk_flush_backlog(sk);
> +			if (!skb_queue_empty(&sk->sk_receive_queue)
> ||
> +			    __mptcp_move_skbs(sk))
> +				continue;
> +		}
>  
>  		/* only the MPTCP socket status is relevant here.
> The exit
>  		 * conditions mirror closely tcp_recvmsg()
> @@ -2508,7 +2550,6 @@ static void __mptcp_close_subflow(struct sock
> *sk)
>  
>  		mptcp_close_ssk(sk, ssk, subflow);
>  	}
> -
>  }
>  
>  static bool mptcp_close_tout_expired(const struct sock *sk)
> @@ -3092,6 +3133,13 @@ bool __mptcp_close(struct sock *sk, long
> timeout)
>  	pr_debug("msk=%p state=%d\n", sk, sk->sk_state);
>  	mptcp_pm_connection_closed(msk);
>  
> +	/* process the backlog; note that it never destroies the msk
> */
> +	local_bh_disable();
> +	bh_lock_sock(sk);
> +	__release_sock(sk);
> +	bh_unlock_sock(sk);
> +	local_bh_enable();
> +
>  	if (sk->sk_state == TCP_CLOSE) {
>  		__mptcp_destroy_sock(sk);
>  		do_cancel_work = true;
> @@ -3392,8 +3440,7 @@ void __mptcp_check_push(struct sock *sk, struct
> sock *ssk)
>  
>  #define MPTCP_FLAGS_PROCESS_CTX_NEED (BIT(MPTCP_PUSH_PENDING) | \
>  				      BIT(MPTCP_RETRANSMIT) | \
> -				      BIT(MPTCP_FLUSH_JOIN_LIST) | \
> -				      BIT(MPTCP_DEQUEUE))
> +				      BIT(MPTCP_FLUSH_JOIN_LIST))
>  
>  /* processes deferred events and flush wmem */
>  static void mptcp_release_cb(struct sock *sk)
> @@ -3427,11 +3474,6 @@ static void mptcp_release_cb(struct sock *sk)
>  			__mptcp_push_pending(sk, 0);
>  		if (flags & BIT(MPTCP_RETRANSMIT))
>  			__mptcp_retrans(sk);
> -		if ((flags & BIT(MPTCP_DEQUEUE)) &&
> __mptcp_move_skbs(sk)) {
> -			/* notify ack seq update */
> -			mptcp_cleanup_rbuf(msk, 0);
> -			sk->sk_data_ready(sk);
> -		}
>  
>  		cond_resched();
>  		spin_lock_bh(&sk->sk_lock.slock);
> @@ -3668,8 +3710,6 @@ static int mptcp_ioctl(struct sock *sk, int
> cmd, int *karg)
>  			return -EINVAL;
>  
>  		lock_sock(sk);
> -		if (__mptcp_move_skbs(sk))
> -			mptcp_cleanup_rbuf(msk, 0);
>  		*karg = mptcp_inq_hint(sk);
>  		release_sock(sk);
>  		break;
> @@ -3781,6 +3821,7 @@ static struct proto mptcp_prot = {
>  	.sendmsg	= mptcp_sendmsg,
>  	.ioctl		= mptcp_ioctl,
>  	.recvmsg	= mptcp_recvmsg,
> +	.backlog_rcv	= mptcp_move_skb,
>  	.release_cb	= mptcp_release_cb,
>  	.hash		= mptcp_hash,
>  	.unhash		= mptcp_unhash,
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 128baea5b496e..a6e775d6412e5 100644
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
> @@ -407,6 +406,7 @@ static inline int mptcp_space_from_win(const
> struct sock *sk, int win)
>  static inline int __mptcp_space(const struct sock *sk)
>  {
>  	return mptcp_win_from_space(sk, READ_ONCE(sk->sk_rcvbuf) -
> +				    READ_ONCE(sk->sk_backlog.len) -
>  				    sk_rmem_alloc_get(sk));
>  }
>  
