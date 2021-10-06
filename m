Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780322C81
	for <mptcp@lists.linux.dev>; Wed,  6 Oct 2021 09:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1633513337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ky5qOVTGS7EtTPS+nb6umIkQEB/EVrVCYc3zQ7JcGeM=;
	b=Spe9EL/MwxhmCDVCFTq095pYdNHu6Kah6IODRczcyG++CyqL+zNwpinKtqdZ0p926fN8c2
	k1//bI2fkvqu+aPe/zA8zcIkB06hbPu6IRl9TCJuRnV+ziYfrZUlFWNcyScd9OwvIt2UBr
	2yOGDbPDD+lVBQBjIwklM9XQIC3Ms4w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-2YZ2GO7ANOaimxaE721_aQ-1; Wed, 06 Oct 2021 05:42:16 -0400
X-MC-Unique: 2YZ2GO7ANOaimxaE721_aQ-1
Received: by mail-wr1-f71.google.com with SMTP id f11-20020adfc98b000000b0015fedc2a8d4so1561379wrh.0
        for <mptcp@lists.linux.dev>; Wed, 06 Oct 2021 02:42:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ky5qOVTGS7EtTPS+nb6umIkQEB/EVrVCYc3zQ7JcGeM=;
        b=TvqfXPhMpljmp6Liwa/anLMi8xzDezuhsQDXPjPpcWU5o4SH9QB5c6yPZDlKrmX1JQ
         CJ+IyINwn7hh3312zKKFgEH/OpfowU6BjTLyT8mCg5M/+Wl6v7TvDcvtBMU+2vB44KFx
         XCBo2xQTjmAF/HKi4hc/8PTfvDZk2u1jVYWQvLM1o9bGJc9prGCwLE9Yt2sGOreuEItb
         hKv6dv2P2pFL9f5pqw0jAycBi86zXC+/loKF/7j/FR1GTUfvIQtVEVOC3LvtbgusnFJK
         oJGhmwTBnlXM1h4/uf36MFcNw9ZpabV7wa7yB+X5BAb3NQUwPatUtraXnlDO1wuwh1xk
         Gmvw==
X-Gm-Message-State: AOAM533xMCOy2c6VFcUKJontNRkulOqnh2VrQicMZOdf4sjroArg3zmY
	v5sSke71t/vC+YIV6meafMGG/5uW6O4Lu6ENcYIi3iPvujw7XKPZ1EbOZJ3EYH+liz8I+iY90m8
	4dn3cxHkgOQqhvIQ=
X-Received: by 2002:adf:9bd3:: with SMTP id e19mr28120884wrc.167.1633513334731;
        Wed, 06 Oct 2021 02:42:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVMF06WrzaebUmvmWmGK4a832iHi/VEF2hNEkqBTXz1xSeTQ2j9aQ50peAQ/KsH7f8xqTpJg==
X-Received: by 2002:adf:9bd3:: with SMTP id e19mr28120857wrc.167.1633513334418;
        Wed, 06 Oct 2021 02:42:14 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-225-183.dyn.eolo.it. [146.241.225.183])
        by smtp.gmail.com with ESMTPSA id z20sm1003722wmi.42.2021.10.06.02.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 02:42:14 -0700 (PDT)
Message-ID: <c78758976b42df08ee2cf283f1ccf514e31c44a2.camel@redhat.com>
Subject: Re: [RFC PATCH] mptcp: allocate fwd memory separatelly on the rx
 and tx path
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev, fwestpha@redhat.com
Date: Wed, 06 Oct 2021 11:42:12 +0200
In-Reply-To: <816f3a90-28ed-35ca-4056-8585f39e81@linux.intel.com>
References: <cf3710062ecac93e469306b3ed59a70688d36620.1633451893.git.pabeni@redhat.com>
	 <816f3a90-28ed-35ca-4056-8585f39e81@linux.intel.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2021-10-05 at 16:07 -0700, Mat Martineau wrote:
> On Tue, 5 Oct 2021, Paolo Abeni wrote:
> 
> > All the mptcp receive path is protected by the msk socket
> > spinlock. As consequence, the tx path has to play a few to allocate
> > the forward memory without acquiring the spinlock multile times, making
> > the overall TX path quite complex.
> > 
> > This patch tries to clean-up a bit the tx path, using completely
> > separated fwd memory allocation, for the rx and the tx path.
> > 
> 
> Overall, it does seem like a cleaner approach than the existing 
> wmem_reserved code. Do you think the existing code is related to any 
> current bugs or performance issues?

None that I know, so far. But I fear (I'm almost quite sure) that the
current wmem_reserved is prone to problems with memory pressure and
could perform badly on some scenarios. Overall the 'wmem_reserved'
looks like the ugliest spot we currently have in the mptcp
implementation.

I "feel" that an approach like this one should be more roboust in the
long term.

> > The forward memory allocated in the rx path is now accounted in
> > msk->rmem_fwd_alloc and is (still) protected by the msk socket spinlock.
> > 
> > To cope with the above we provied a few MPTCP-specific variant for
> > the helpers to charge, uncharge, reclaim and free the forward
> > memory in the receive path.
> > 
> > msk->sk_forward_alloc now accounts only the forward memory for the tx path,
> > we can the plain core sock helper to manipulate it and drop quite a bit
> > of complexity.
> > 
> > On memory pressure reclaim both rx and tx fwd memory.
> > 
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > Note: this would additionally require a core change to properly fetch
> > the forward allocated memory in inet_sk_diag_fill(). I think a new
> > 'struct proto' ops would do:
> > 
> > struct proto {
> > 	// ...
> > 	int (*forward_alloc)(const struct sock *sk);
> > 	// ...
> > };
> > 
> > static inline sk_forward_alloc(const struct sock *sk)
> > {
> > 	if (!sk->sk_prot.forward_alloc)
> > 		return sk->sk_forward_alloc;
> > 	return sk->sk_prot.forward_alloc(sk);
> > }
> 
> Seems ok to me to handle the diag info this way, hope upstream reviewers 
> agree!

:)

> > ---
> > net/mptcp/protocol.c | 219 ++++++++++++++++++-------------------------
> > net/mptcp/protocol.h |  15 +--
> > 2 files changed, 90 insertions(+), 144 deletions(-)
> > 
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 21716392e754..1d26462a1daf 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -126,6 +126,11 @@ static void mptcp_drop(struct sock *sk, struct sk_buff *skb)
> > 	__kfree_skb(skb);
> > }
> > 
> > +static void mptcp_rmem_charge(struct sock *sk, int size)
> > +{
> > +	mptcp_sk(sk)->rmem_fwd_alloc -= size;
> > +}
> > +
> > static bool mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
> > 			       struct sk_buff *from)
> > {
> > @@ -142,7 +147,7 @@ static bool mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
> > 	MPTCP_SKB_CB(to)->end_seq = MPTCP_SKB_CB(from)->end_seq;
> > 	kfree_skb_partial(from, fragstolen);
> > 	atomic_add(delta, &sk->sk_rmem_alloc);
> > -	sk_mem_charge(sk, delta);
> > +	mptcp_rmem_charge(sk, delta);
> > 	return true;
> > }
> > 
> > @@ -155,6 +160,50 @@ static bool mptcp_ooo_try_coalesce(struct mptcp_sock *msk, struct sk_buff *to,
> > 	return mptcp_try_coalesce((struct sock *)msk, to, from);
> > }
> > 
> > +void __mptcp_rmem_reclaim(struct sock *sk, int amount)
> > +{
> > +	amount >>= SK_MEM_QUANTUM_SHIFT;
> > +	mptcp_sk(sk)->rmem_fwd_alloc -= amount << SK_MEM_QUANTUM_SHIFT;
> > +	__sk_mem_reduce_allocated(sk, amount);
> > +}
> > +
> > +static void mptcp_rmem_uncharge(struct sock *sk, int size)
> > +{
> > +	struct mptcp_sock *msk = mptcp_sk(sk);
> > +	int reclaimable;
> > +
> > +	msk->rmem_fwd_alloc += size;
> > +	reclaimable = msk->rmem_fwd_alloc - sk_unused_reserved_mem(sk);
> 
> I was going to ask if this patch takes in to account the recent 
> SO_RESERVE_MEM patchset's changes to sk_forward_alloc handling, but these 
> changes mirror those in sk_mem_reclaim() so it seems the answer is "yes".

Indeed!

> > +
> > +	/* Avoid a possible overflow.
> > +	 * TCP send queues can make this happen, if sk_mem_reclaim()
> > +	 * is not called and more than 2 GBytes are released at once.
> > +	 *
> > +	 * If we reach 2 MBytes, reclaim 1 MBytes right now, there is
> > +	* no need to hold that much forward allocation anyway.
> > +	*/
> 
> Minor indent issue in the above comment.
> 
> > +	if (unlikely(reclaimable >= 1 << 21))
> > +		__mptcp_rmem_reclaim(sk, (1 << 20));
> 
> I realize these "1 << 21" and "1 << 20" values are copied from 
> sk_mem_uncharge(). Should they be changed in both files to symbolic values 
> defined in sock.h, to help keep the values matched if someone decides to 
> adjust them in the future?

I'll define some macro for that.

> > +}
> > +
> > +static void mptcp_rfree(struct sk_buff *skb)
> > +{
> > +	unsigned int len = skb->truesize;
> > +	struct sock *sk = skb->sk;
> > +
> > +	atomic_sub(len, &sk->sk_rmem_alloc);
> > +	mptcp_rmem_uncharge(sk, len);
> > +}
> > +
> > +static void mptcp_set_owner_r(struct sk_buff *skb, struct sock *sk)
> > +{
> > +	skb_orphan(skb);
> > +	skb->sk = sk;
> > +	skb->destructor = mptcp_rfree;
> > +	atomic_add(skb->truesize, &sk->sk_rmem_alloc);
> > +	mptcp_rmem_charge(sk, skb->truesize);
> > +}
> > +
> > /* "inspired" by tcp_data_queue_ofo(), main differences:
> >  * - use mptcp seqs
> >  * - don't cope with sacks
> > @@ -267,7 +316,29 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
> > 
> > end:
> > 	skb_condense(skb);
> > -	skb_set_owner_r(skb, sk);
> > +	mptcp_set_owner_r(skb, sk);
> > +}
> > +
> > +static bool mptcp_rmem_schedule(struct sock *sk, struct sock *ssk, int size)
> > +{
> > +	struct mptcp_sock *msk = mptcp_sk(sk);
> > +	int amt, amount;
> > +
> > +	if (size < msk->rmem_fwd_alloc)
> > +		return true;;
> > +
> > +	amt = sk_mem_pages(size);
> > +	amount = amt << SK_MEM_QUANTUM_SHIFT;
> > +	msk->rmem_fwd_alloc += amount;
> > +	if (!__sk_mem_raise_allocated(sk, size, amt, SK_MEM_RECV)) {
> > +		if (ssk->sk_forward_alloc < amount) {
> > +			msk->rmem_fwd_alloc -= amount;
> > +			return false;
> > +		}
> > +
> > +		ssk->sk_forward_alloc -= amount;
> > +	}
> > +	return true;
> > }
> > 
> > static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
> > @@ -285,15 +356,8 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
> > 	skb_orphan(skb);
> > 
> > 	/* try to fetch required memory from subflow */
> > -	if (!sk_rmem_schedule(sk, skb, skb->truesize)) {
> > -		int amount = sk_mem_pages(skb->truesize) << SK_MEM_QUANTUM_SHIFT;
> > -
> > -		if (ssk->sk_forward_alloc < amount)
> > -			goto drop;
> > -
> > -		ssk->sk_forward_alloc -= amount;
> > -		sk->sk_forward_alloc += amount;
> > -	}
> > +	if (!mptcp_rmem_schedule(sk, ssk, skb->truesize))
> > +		goto drop;
> > 
> > 	has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
> > 
> > @@ -313,7 +377,7 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
> > 		if (tail && mptcp_try_coalesce(sk, tail, skb))
> > 			return true;
> > 
> > -		skb_set_owner_r(skb, sk);
> > +		mptcp_set_owner_r(skb, sk);
> > 		__skb_queue_tail(&sk->sk_receive_queue, skb);
> > 		return true;
> > 	} else if (after64(MPTCP_SKB_CB(skb)->map_seq, msk->ack_seq)) {
> > @@ -908,122 +972,20 @@ static bool mptcp_frag_can_collapse_to(const struct mptcp_sock *msk,
> > 		df->data_seq + df->data_len == msk->write_seq;
> > }
> > 
> > -static int mptcp_wmem_with_overhead(int size)
> > -{
> > -	return size + ((sizeof(struct mptcp_data_frag) * size) >> PAGE_SHIFT);
> > -}
> > -
> > -static void __mptcp_wmem_reserve(struct sock *sk, int size)
> > -{
> > -	int amount = mptcp_wmem_with_overhead(size);
> > -	struct mptcp_sock *msk = mptcp_sk(sk);
> > -
> > -	WARN_ON_ONCE(msk->wmem_reserved);
> > -	if (WARN_ON_ONCE(amount < 0))
> > -		amount = 0;
> > -
> > -	if (amount <= sk->sk_forward_alloc)
> > -		goto reserve;
> > -
> > -	/* under memory pressure try to reserve at most a single page
> > -	 * otherwise try to reserve the full estimate and fallback
> > -	 * to a single page before entering the error path
> > -	 */
> > -	if ((tcp_under_memory_pressure(sk) && amount > PAGE_SIZE) ||
> > -	    !sk_wmem_schedule(sk, amount)) {
> > -		if (amount <= PAGE_SIZE)
> > -			goto nomem;
> > -
> > -		amount = PAGE_SIZE;
> > -		if (!sk_wmem_schedule(sk, amount))
> > -			goto nomem;
> > -	}
> > -
> > -reserve:
> > -	msk->wmem_reserved = amount;
> > -	sk->sk_forward_alloc -= amount;
> > -	return;
> > -
> > -nomem:
> > -	/* we will wait for memory on next allocation */
> > -	msk->wmem_reserved = -1;
> > -}
> > -
> > -static void __mptcp_update_wmem(struct sock *sk)
> > +static void __mptcp_mem_reclaim_partial(struct sock *sk)
> > {
> > -	struct mptcp_sock *msk = mptcp_sk(sk);
> > +	int reclaimable = mptcp_sk(sk)->rmem_fwd_alloc - sk_unused_reserved_mem(sk);
> > 
> > 	lockdep_assert_held_once(&sk->sk_lock.slock);
> > 
> > -	if (!msk->wmem_reserved)
> > -		return;
> > -
> > -	if (msk->wmem_reserved < 0)
> > -		msk->wmem_reserved = 0;
> > -	if (msk->wmem_reserved > 0) {
> > -		sk->sk_forward_alloc += msk->wmem_reserved;
> > -		msk->wmem_reserved = 0;
> > -	}
> > -}
> > -
> > -static bool mptcp_wmem_alloc(struct sock *sk, int size)
> > -{
> > -	struct mptcp_sock *msk = mptcp_sk(sk);
> > -
> > -	/* check for pre-existing error condition */
> > -	if (msk->wmem_reserved < 0)
> > -		return false;
> > -
> > -	if (msk->wmem_reserved >= size)
> > -		goto account;
> > -
> > -	mptcp_data_lock(sk);
> > -	if (!sk_wmem_schedule(sk, size)) {
> > -		mptcp_data_unlock(sk);
> > -		return false;
> > -	}
> > -
> > -	sk->sk_forward_alloc -= size;
> > -	msk->wmem_reserved += size;
> > -	mptcp_data_unlock(sk);
> > -
> > -account:
> > -	msk->wmem_reserved -= size;
> > -	return true;
> > -}
> > -
> > -static void mptcp_wmem_uncharge(struct sock *sk, int size)
> > -{
> > -	struct mptcp_sock *msk = mptcp_sk(sk);
> > -
> > -	if (msk->wmem_reserved < 0)
> > -		msk->wmem_reserved = 0;
> > -	msk->wmem_reserved += size;
> > -}
> > -
> > -static void __mptcp_mem_reclaim_partial(struct sock *sk)
> > -{
> > -	lockdep_assert_held_once(&sk->sk_lock.slock);
> > -	__mptcp_update_wmem(sk);
> > +	__mptcp_rmem_reclaim(sk, reclaimable - 1);
> > 	sk_mem_reclaim_partial(sk);
> > }
> > 
> > static void mptcp_mem_reclaim_partial(struct sock *sk)
> > {
> > -	struct mptcp_sock *msk = mptcp_sk(sk);
> > -
> > -	/* if we are experiencing a transint allocation error,
> > -	 * the forward allocation memory has been already
> > -	 * released
> > -	 */
> > -	if (msk->wmem_reserved < 0)
> > -		return;
> > -
> > 	mptcp_data_lock(sk);
> > -	sk->sk_forward_alloc += msk->wmem_reserved;
> > -	sk_mem_reclaim_partial(sk);
> > -	msk->wmem_reserved = sk->sk_forward_alloc;
> > -	sk->sk_forward_alloc = 0;
> > +	__mptcp_mem_reclaim_partial(sk);
> > 	mptcp_data_unlock(sk);
> > }
> > 
> > @@ -1664,7 +1626,6 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
> > 	/* __mptcp_alloc_tx_skb could have released some wmem and we are
> > 	 * not going to flush it via release_sock()
> > 	 */
> > -	__mptcp_update_wmem(sk);
> > 	if (copied) {
> > 		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
> > 			 info.size_goal);
> > @@ -1701,7 +1662,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
> > 	/* silently ignore everything else */
> > 	msg->msg_flags &= MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL;
> > 
> > -	mptcp_lock_sock(sk, __mptcp_wmem_reserve(sk, min_t(size_t, 1 << 20, len)));
> > +	lock_sock(sk);
> > 
> > 	timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
> > 
> > @@ -1749,17 +1710,17 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
> > 		psize = min_t(size_t, psize, msg_data_left(msg));
> > 		total_ts = psize + frag_truesize;
> > 
> > -		if (!mptcp_wmem_alloc(sk, total_ts))
> > +		if (!sk_wmem_schedule(sk, total_ts))
> > 			goto wait_for_memory;
> > 
> > 		if (copy_page_from_iter(dfrag->page, offset, psize,
> > 					&msg->msg_iter) != psize) {
> > -			mptcp_wmem_uncharge(sk, psize + frag_truesize);
> > 			ret = -EFAULT;
> > 			goto out;
> > 		}
> > 
> > 		/* data successfully copied into the write queue */
> > +		sk->sk_forward_alloc -= total_ts;
> > 		copied += psize;
> > 		dfrag->data_len += psize;
> > 		frag_truesize += psize;
> > @@ -1956,7 +1917,7 @@ static void __mptcp_update_rmem(struct sock *sk)
> > 		return;
> > 
> > 	atomic_sub(msk->rmem_released, &sk->sk_rmem_alloc);
> > -	sk_mem_uncharge(sk, msk->rmem_released);
> > +	mptcp_rmem_uncharge(sk, msk->rmem_released);
> > 	WRITE_ONCE(msk->rmem_released, 0);
> > }
> > 
> > @@ -2024,7 +1985,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
> > 	if (unlikely(flags & MSG_ERRQUEUE))
> > 		return inet_recv_error(sk, msg, len, addr_len);
> > 
> > -	mptcp_lock_sock(sk, __mptcp_splice_receive_queue(sk));
> > +	lock_sock(sk);
> > 	if (unlikely(sk->sk_state == TCP_LISTEN)) {
> > 		copied = -ENOTCONN;
> > 		goto out_err;
> > @@ -2504,7 +2465,6 @@ static int __mptcp_init_sock(struct sock *sk)
> > 	__skb_queue_head_init(&msk->receive_queue);
> > 	msk->out_of_order_queue = RB_ROOT;
> > 	msk->first_pending = NULL;
> > -	msk->wmem_reserved = 0;
> 
> msk->rmem_fwd_alloc init needs to be added, right?

Right. Not sure with self-tests did not show any issues ??!

Thanks!

Paolo

