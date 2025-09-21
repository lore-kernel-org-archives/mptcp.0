Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606B2182B7
	for <mptcp@lists.linux.dev>; Sun, 21 Sep 2025 00:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758414427; cv=none; b=T2+Uc6JJHO1DpHlYn0G/PXyedBgdiDFnSEaBITOb8nue8dnPaNTti6u4Q7rIHqRWQdf+CWz72OFVx+EpblmApWczL5vhiOUleHimYpbqnYiim3Bp0xuoB0Zba57vQyPZs1qUCT0SuscCZPc9moDie3eVgp0Gm+EC4Fb6B+DiLw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758414427; c=relaxed/simple;
	bh=muekbdpmogi4zt26O9NySFRYezgDBXu0Kuy2oq8XtHA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Br+zdJoD63p8wOzIUYcCTY9+NDWW2wD6mg3iwvyl7WoJVGczAKiCBKZzY1knve/YeYxTq+rBxsFl5+x0VhPutFvUSFTeUu8kpTwDQmQWwTLpRTri13tnwtNQQI1BbUMrnRZp3d9Hq7rG1rI79JZBIduJFWGi4igrkvvjv1W+EGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1uX+WfH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1uX+WfH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAEE2C4CEEB;
	Sun, 21 Sep 2025 00:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758414426;
	bh=muekbdpmogi4zt26O9NySFRYezgDBXu0Kuy2oq8XtHA=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=X1uX+WfHta9oVf4xqxsFP3ndT+pM4wtoTGdHSWkpe5Vhf6WLi0+/UaNmt/6UcQ6xd
	 mQZS4CZU9LgxiZdAIeGNYnXeaDoB0L1QBF86+iDpvz02VodxmEPfa9r2cBX/lV3U09
	 3cYnli/UoxsE97CHLurfLxKisHH2yAgkzGllMwqIFsTKsPvWbVy4/+gJ0h/w+EeK3H
	 mkfpJ511eFKLhIDNX4orZWiSqgyBItkhBBRDUx/Rl1VuWaQeYVCPNQonxvPZhVpVt4
	 H8agYalNXqjqrr4m4lnHyXJcETpzDIxX1KDbjC/YHUJWPfAqyzsn5q4Cfb9bM8fEBk
	 3784fk129zQ9g==
Message-ID: <c1b378bb0b7bb81756e9ff56235854ea4a563a8b.camel@kernel.org>
Subject: Re: [MPTCP next v3 10/12] mptcp: leverage the sk backlog for RX
 packet processing.
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Date: Sun, 21 Sep 2025 08:27:03 +0800
In-Reply-To: <ad3b1ae70e98e990079fe5bbbe6a7f0b984a1b76.camel@kernel.org>
References: <cover.1758296923.git.pabeni@redhat.com>
		 <5d137f1505b6d41092fcbc50e1ad65c8f0cc9440.1758296923.git.pabeni@redhat.com>
	 <ad3b1ae70e98e990079fe5bbbe6a7f0b984a1b76.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 2025-09-20 at 08:09 +0800, Geliang Tang wrote:
> On Fri, 2025-09-19 at 17:53 +0200, Paolo Abeni wrote:
> > This streamline the RX path implementation and improves the RX
> > performances by reducing the subflow-level locking and the amount
> > of
> > work done under the msk socket lock; the implementation mirror
> > closely
> > the TCP backlog processing.
> > 
> > Note that MPTCP needs now to traverse the existing subflow looking
> > for
> > data that was left there due to the msk receive buffer full, only
> > after
> > that recvmsg completely empties the receive queue.
> > 
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> >  net/mptcp/protocol.c | 103 ++++++++++++++++++++++++++++++---------
> > --
> > --
> >  net/mptcp/protocol.h |   2 +-
> >  2 files changed, 73 insertions(+), 32 deletions(-)
> > 
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index c8b02048126a9..201e6ac5fe631 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -360,6 +360,27 @@ static void mptcp_init_skb(struct sock *ssk,
> >  	skb_dst_drop(skb);
> >  }
> >  
> > +static void __mptcp_add_backlog(struct sock *sk, struct sock *ssk,
> > +				struct sk_buff *skb)
> > +{
> > +	struct sk_buff *tail = sk->sk_backlog.tail;
> > +	bool fragstolen;
> > +	int delta;
> > +
> > +	if (tail && MPTCP_SKB_CB(skb)->map_seq ==
> > MPTCP_SKB_CB(tail)->end_seq) {
> > +		delta = __mptcp_try_coalesce(sk, tail, skb,
> > &fragstolen);
> > +		if (delta) {
> > +			sk->sk_backlog.len += delta;
> > +			kfree_skb_partial(skb, fragstolen);
> > +			return;
> > +		}
> > +	}
> > +
> > +	/* mptcp checks the limit before adding the skb to the
> > backlog */
> > +	__sk_add_backlog(sk, skb);
> > +	sk->sk_backlog.len += skb->truesize;
> > +}
> > +
> >  static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
> >  {
> >  	u64 copy_len = MPTCP_SKB_CB(skb)->end_seq -
> > MPTCP_SKB_CB(skb)->map_seq;
> > @@ -648,7 +669,7 @@ static void mptcp_dss_corruption(struct
> > mptcp_sock *msk, struct sock *ssk)
> >  }
> >  
> >  static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
> > -					   struct sock *ssk)
> > +					   struct sock *ssk, bool
> > own_msk)
> >  {
> >  	struct mptcp_subflow_context *subflow =
> > mptcp_subflow_ctx(ssk);
> >  	struct sock *sk = (struct sock *)msk;
> > @@ -659,12 +680,13 @@ static bool
> > __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
> >  	pr_debug("msk=%p ssk=%p\n", msk, ssk);
> >  	tp = tcp_sk(ssk);
> >  	do {
> > +		int mem = own_msk ? sk_rmem_alloc_get(sk) : sk-
> > > sk_backlog.len;
> >  		u32 map_remaining, offset;
> >  		u32 seq = tp->copied_seq;
> >  		struct sk_buff *skb;
> >  		bool fin;
> >  
> > -		if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
> > +		if (mem > READ_ONCE(sk->sk_rcvbuf))
> >  			break;
> >  
> >  		/* try to move as much data as available */
> > @@ -694,7 +716,11 @@ static bool
> > __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
> >  
> >  			mptcp_init_skb(ssk, skb, offset, len);
> >  			skb_orphan(skb);
> > -			ret = __mptcp_move_skb(sk, skb) || ret;
> > +
> > +			if (own_msk)
> > +				ret |= __mptcp_move_skb(sk, skb);
> > +			else
> > +				__mptcp_add_backlog(sk, ssk, skb);
> >  			seq += len;
> >  
> >  			if (unlikely(map_remaining < len)) {
> > @@ -715,7 +741,7 @@ static bool
> > __mptcp_move_skbs_from_subflow(struct
> > mptcp_sock *msk,
> >  
> >  	} while (more_data_avail);
> >  
> > -	if (ret)
> > +	if (ret && own_msk)
> >  		msk->last_data_recv = tcp_jiffies32;
> >  	return ret;
> >  }
> > @@ -813,7 +839,7 @@ static bool move_skbs_to_msk(struct mptcp_sock
> > *msk, struct sock *ssk)
> >  	struct sock *sk = (struct sock *)msk;
> >  	bool moved;
> >  
> > -	moved = __mptcp_move_skbs_from_subflow(msk, ssk);
> > +	moved = __mptcp_move_skbs_from_subflow(msk, ssk, true);
> >  	__mptcp_ofo_queue(msk);
> >  	if (unlikely(ssk->sk_err))
> >  		__mptcp_subflow_error_report(sk, ssk);
> > @@ -828,18 +854,10 @@ static bool move_skbs_to_msk(struct
> > mptcp_sock
> > *msk, struct sock *ssk)
> >  	return moved;
> >  }
> >  
> > -static void __mptcp_data_ready(struct sock *sk, struct sock *ssk)
> > -{
> > -	struct mptcp_sock *msk = mptcp_sk(sk);
> > -
> > -	/* Wake-up the reader only for in-sequence data */
> > -	if (move_skbs_to_msk(msk, ssk) && mptcp_epollin_ready(sk))
> > -		sk->sk_data_ready(sk);
> > -}
> > -
> >  void mptcp_data_ready(struct sock *sk, struct sock *ssk)
> >  {
> >  	struct mptcp_subflow_context *subflow =
> > mptcp_subflow_ctx(ssk);
> > +	struct mptcp_sock *msk = mptcp_sk(sk);
> >  
> >  	/* The peer can send data while we are shutting down this
> >  	 * subflow at msk destruction time, but we must avoid
> > enqueuing
> > @@ -849,13 +867,33 @@ void mptcp_data_ready(struct sock *sk, struct
> > sock *ssk)
> >  		return;
> >  
> >  	mptcp_data_lock(sk);
> > -	if (!sock_owned_by_user(sk))
> > -		__mptcp_data_ready(sk, ssk);
> > -	else
> > -		__set_bit(MPTCP_DEQUEUE, &mptcp_sk(sk)->cb_flags);
> > +	if (!sock_owned_by_user(sk)) {
> > +		/* Wake-up the reader only for in-sequence data */
> > +		if (move_skbs_to_msk(msk, ssk) &&
> > mptcp_epollin_ready(sk))
> > +			sk->sk_data_ready(sk);
> > +	} else {
> > +		__mptcp_move_skbs_from_subflow(msk, ssk, false);
> > +		if (unlikely(ssk->sk_err))
> > +			__set_bit(MPTCP_ERROR_REPORT,  &msk-
> > > cb_flags);
> > +	}
> >  	mptcp_data_unlock(sk);
> >  }
> >  
> > +static int mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
> > +{
> > +	struct mptcp_sock *msk = mptcp_sk(sk);
> > +
> > +	if (__mptcp_move_skb(sk, skb)) {
> > +		msk->last_data_recv = tcp_jiffies32;
> > +		__mptcp_ofo_queue(msk);
> > +		/* notify ack seq update */
> > +		mptcp_cleanup_rbuf(msk, 0);
> > +		mptcp_check_data_fin(sk);
> > +		sk->sk_data_ready(sk);
> > +	}
> > +	return 0;
> > +}
> > +
> >  static void mptcp_subflow_joined(struct mptcp_sock *msk, struct
> > sock
> > *ssk)
> >  {
> >  	mptcp_subflow_ctx(ssk)->map_seq = READ_ONCE(msk->ack_seq);
> > @@ -2117,7 +2155,7 @@ static bool __mptcp_move_skbs(struct sock
> > *sk)
> >  
> >  		ssk = mptcp_subflow_tcp_sock(subflow);
> >  		slowpath = lock_sock_fast(ssk);
> > -		ret = __mptcp_move_skbs_from_subflow(msk, ssk) ||
> > ret;
> > +		ret = __mptcp_move_skbs_from_subflow(msk, ssk,
> > true)
> > > > ret;
> >  		if (unlikely(ssk->sk_err))
> >  			__mptcp_error_report(sk);
> >  		unlock_sock_fast(ssk, slowpath);
> > @@ -2193,8 +2231,12 @@ static int mptcp_recvmsg(struct sock *sk,
> > struct msghdr *msg, size_t len,
> >  
> >  		copied += bytes_read;
> >  
> > -		if (skb_queue_empty(&sk->sk_receive_queue) &&
> > __mptcp_move_skbs(sk))
> > -			continue;
> > +		if (skb_queue_empty(&sk->sk_receive_queue)) {
> > +			__sk_flush_backlog(sk);
> > +			if (!skb_queue_empty(&sk-
> > >sk_receive_queue)
> > > > 
> > +			    __mptcp_move_skbs(sk))
> > +				continue;
> > +		}
> >  
> >  		/* only the MPTCP socket status is relevant here.
> > The exit
> >  		 * conditions mirror closely tcp_recvmsg()
> > @@ -2542,7 +2584,6 @@ static void __mptcp_close_subflow(struct sock
> > *sk)
> >  
> >  		mptcp_close_ssk(sk, ssk, subflow);
> >  	}
> > -
> 
> Deleting this blank line is unrelated to the current patch. Let's
> make
> the change later when we modify the __mptcp_close_subflow function
> together.
> 
> I need to spend some more time understanding and testing patches 10-
> 12.

Please delete the sentence in the subject of this patch to maintain
consistency with the other patches in the series.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Tested-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> 
> Thanks,
> -Geliang
> 
> >  }
> >  
> >  static bool mptcp_close_tout_expired(const struct sock *sk)
> > @@ -3126,6 +3167,13 @@ bool __mptcp_close(struct sock *sk, long
> > timeout)
> >  	pr_debug("msk=%p state=%d\n", sk, sk->sk_state);
> >  	mptcp_pm_connection_closed(msk);
> >  
> > +	/* process the backlog; note that it never destroies the
> > msk
> > */
> > +	local_bh_disable();
> > +	bh_lock_sock(sk);
> > +	__release_sock(sk);
> > +	bh_unlock_sock(sk);
> > +	local_bh_enable();
> > +
> >  	if (sk->sk_state == TCP_CLOSE) {
> >  		__mptcp_destroy_sock(sk);
> >  		do_cancel_work = true;
> > @@ -3429,8 +3477,7 @@ void __mptcp_check_push(struct sock *sk,
> > struct
> > sock *ssk)
> >  
> >  #define MPTCP_FLAGS_PROCESS_CTX_NEED (BIT(MPTCP_PUSH_PENDING) | \
> >  				      BIT(MPTCP_RETRANSMIT) | \
> > -				      BIT(MPTCP_FLUSH_JOIN_LIST) |
> > \
> > -				      BIT(MPTCP_DEQUEUE))
> > +				      BIT(MPTCP_FLUSH_JOIN_LIST))
> >  
> >  /* processes deferred events and flush wmem */
> >  static void mptcp_release_cb(struct sock *sk)
> > @@ -3464,11 +3511,6 @@ static void mptcp_release_cb(struct sock
> > *sk)
> >  			__mptcp_push_pending(sk, 0);
> >  		if (flags & BIT(MPTCP_RETRANSMIT))
> >  			__mptcp_retrans(sk);
> > -		if ((flags & BIT(MPTCP_DEQUEUE)) &&
> > __mptcp_move_skbs(sk)) {
> > -			/* notify ack seq update */
> > -			mptcp_cleanup_rbuf(msk, 0);
> > -			sk->sk_data_ready(sk);
> > -		}
> >  
> >  		cond_resched();
> >  		spin_lock_bh(&sk->sk_lock.slock);
> > @@ -3704,8 +3746,6 @@ static int mptcp_ioctl(struct sock *sk, int
> > cmd, int *karg)
> >  			return -EINVAL;
> >  
> >  		lock_sock(sk);
> > -		if (__mptcp_move_skbs(sk))
> > -			mptcp_cleanup_rbuf(msk, 0);
> >  		*karg = mptcp_inq_hint(sk);
> >  		release_sock(sk);
> >  		break;
> > @@ -3817,6 +3857,7 @@ static struct proto mptcp_prot = {
> >  	.sendmsg	= mptcp_sendmsg,
> >  	.ioctl		= mptcp_ioctl,
> >  	.recvmsg	= mptcp_recvmsg,
> > +	.backlog_rcv	= mptcp_move_skb,
> >  	.release_cb	= mptcp_release_cb,
> >  	.hash		= mptcp_hash,
> >  	.unhash		= mptcp_unhash,
> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index 6ac58e92a1aa3..7bfd4e0d21a8a 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -124,7 +124,6 @@
> >  #define MPTCP_FLUSH_JOIN_LIST	5
> >  #define MPTCP_SYNC_STATE	6
> >  #define MPTCP_SYNC_SNDBUF	7
> > -#define MPTCP_DEQUEUE		8
> >  
> >  struct mptcp_skb_cb {
> >  	u64 map_seq;
> > @@ -408,6 +407,7 @@ static inline int mptcp_space_from_win(const
> > struct sock *sk, int win)
> >  static inline int __mptcp_space(const struct sock *sk)
> >  {
> >  	return mptcp_win_from_space(sk, READ_ONCE(sk->sk_rcvbuf) -
> > +				    READ_ONCE(sk->sk_backlog.len)
> > -
> >  				    sk_rmem_alloc_get(sk));
> >  }
> >  
