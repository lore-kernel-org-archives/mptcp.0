Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0B1330306
	for <mptcp@lists.linux.dev>; Thu, 13 Nov 2025 09:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763024457; cv=none; b=cAXK0zbZ6W2DumjH4aKWyNg52ogQHu6RfLCTyVlVXFANGALJeDQCavQky+cp+eAvbNfevGANY3w9ECa7kh9QIQhCy3jUP/HWJ6pQ6ah91oESEytToQM6q9a6i8muYKHGGb2aN9c9nbFppnq0UaHFsieh9oTos1HnblcLBNPkCTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763024457; c=relaxed/simple;
	bh=Jc80UQ3X2HKgpqUHZ6f51j/D8WejF8wVoi3oUZvaH5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=B9mdRLRnf4Y3uEtqCs9Rb5TZfqAed3fNkbe53FkK+NOSVUZpg3BVPNv9g1ElP44Ow+DIQtscXBHdqwjT1YxQMNxJYlcsETfP4+8AYBiGREZpviW3llR7kpHdBn9XmIcNktd/+LWoY430XEC1JFvzwzb1yJGSxJmMuAma2h8rG0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dXSq/2LB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXSq/2LB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B3CFC4CEF5;
	Thu, 13 Nov 2025 09:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763024456;
	bh=Jc80UQ3X2HKgpqUHZ6f51j/D8WejF8wVoi3oUZvaH5A=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=dXSq/2LB5fFwG2d9Rmn/k7+bPaHV20qjJWCtZOWRYapwlLuYUCrLn6exZh7Bnx7CU
	 G+2UIT55VMBemOUXn73Kk+q52gx5xNtBSNtZoAcd8PA0QLSXQR6v+PTXlAHEwAdCcV
	 1Pv4ntS5URwLajNVvKRVUS+1HlNjwmNCH+NHo6NoDmEQai7T/m2R39e+fLPbiiNK8Q
	 VZ7WbvVp7XA0y+EFAVgjVyEsK2qHppLhXxICLUtTgWvCbRJssy8ehQB9dUyO4ZoFke
	 wEecVZwCAnl4nhKT9hNy0wutLxCRCJN5w/dBaBxcggQD/hlbv9XjavbsBxYmJWQhTr
	 ecmmuXJQI2J2g==
Message-ID: <5253a2f3-99b0-4ac9-8d17-74c86bea2ef8@kernel.org>
Date: Thu, 13 Nov 2025 10:00:54 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v3 mptcp-net 3/3] Squash-to: "mptcp: leverage the backlog
 for RX packet processing"
Content-Language: en-GB, fr-BE
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1762992570.git.pabeni@redhat.com>
 <ee40999f77d0186abba2a6b21958c1a8c4881c57.1762992570.git.pabeni@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <ee40999f77d0186abba2a6b21958c1a8c4881c57.1762992570.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 13/11/2025 01:10, Paolo Abeni wrote:
> If a subflow receives data before gaining the memcg while the msk
> socket lock is held at accept time, or the PM locks the msk socket
> while still unaccepted and subflows push data to it at the same time,
> the mptcp_graph_subflows() can complete with a non empty backlog.
> 
> The msk will try to borrow such memory, but (some) of the skbs there
> where not memcg charged. When the msk finally will return such accounted
> memory, we should hit the same splat of #597.
> [even if so far I was unable to replicate this scenario]
> 
> This patch tries to address such potential issue by:
> - explicitly keep track of the amount of memory added to the backlog
>   not CG accounted
> - additionally accouting for such memory at accept time
> - preventing any subflow from adding memory to the backlog not CG
>   accounted after the above flush
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/mptcp/protocol.c | 64 +++++++++++++++++++++++++++++++++++++++++---
>  net/mptcp/protocol.h |  1 +
>  2 files changed, 61 insertions(+), 4 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index addd8025d235..abf0edc4b888 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -658,6 +658,7 @@ static void __mptcp_add_backlog(struct sock *sk,
>  {
>  	struct mptcp_sock *msk = mptcp_sk(sk);
>  	struct sk_buff *tail = NULL;
> +	struct sock *ssk = skb->sk;
>  	bool fragstolen;
>  	int delta;
>  
> @@ -671,18 +672,26 @@ static void __mptcp_add_backlog(struct sock *sk,
>  		tail = list_last_entry(&msk->backlog_list, struct sk_buff, list);
>  
>  	if (tail && MPTCP_SKB_CB(skb)->map_seq == MPTCP_SKB_CB(tail)->end_seq &&
> -	    skb->sk == tail->sk &&
> +	    ssk == tail->sk &&
>  	    __mptcp_try_coalesce(sk, tail, skb, &fragstolen, &delta)) {
>  		skb->truesize -= delta;
>  		kfree_skb_partial(skb, fragstolen);
>  		__mptcp_subflow_lend_fwdmem(subflow, delta);
> -		WRITE_ONCE(msk->backlog_len, msk->backlog_len + delta);
> -		return;
> +		goto account;
>  	}
>  
>  	list_add_tail(&skb->list, &msk->backlog_list);
>  	mptcp_subflow_lend_fwdmem(subflow, skb);
> -	WRITE_ONCE(msk->backlog_len, msk->backlog_len + skb->truesize);
> +	delta = skb->truesize;
> +
> +account:
> +	WRITE_ONCE(msk->backlog_len, msk->backlog_len + delta);
> +
> +	/* Possibly not accept()ed yet, keep track of memory not CG
> +	 * accounted, mptcp_grapt_subflows will handle it.

detail: s/grapt/graft

> +	 */
> +	if (!ssk->sk_memcg)
> +		msk->backlog_unaccounted += delta;
>  }
>  
>  static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
> @@ -2154,6 +2163,12 @@ static bool mptcp_can_spool_backlog(struct sock *sk, struct list_head *skbs)
>  {
>  	struct mptcp_sock *msk = mptcp_sk(sk);
>  
> +	/* After CG initialization, subflows should never add skb before
> +	 * gaining the CG themself.
> +	 */
> +	DEBUG_NET_WARN_ON_ONCE(msk->backlog_unaccounted && sk->sk_socket &&
> +			       mem_cgroup_from_sk(sk));
> +
>  	/* Don't spool the backlog if the rcvbuf is full. */
>  	if (list_empty(&msk->backlog_list) ||
>  	    sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
> @@ -4059,6 +4074,22 @@ static void mptcp_graft_subflows(struct sock *sk)
>  	struct mptcp_subflow_context *subflow;
>  	struct mptcp_sock *msk = mptcp_sk(sk);
>  
> +	if (mem_cgroup_sockets_enabled) {
> +		LIST_HEAD(join_list);
> +
> +		/* Subflows joining after __inet_accept() with get the
> +		 * mem CG properly initialized at mptcp_finish_join() time,
> +		 * but subflows pending in join_list need explicit
> +		 * initialization before flushing `backlog_unaccounted`
> +		 * or we can cat unexpeced unaccounted memory later.

detail: s/cat/catch/ or s/cat/get/?

> +		 */
> +		mptcp_data_lock(sk);
> +		list_splice_init(&msk->join_list, &join_list);
> +		mptcp_data_unlock(sk);
> +
> +		__mptcp_flush_join_list(sk, &join_list);
> +	}
> +
>  	mptcp_for_each_subflow(msk, subflow) {
>  		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
>  
> @@ -4070,10 +4101,35 @@ static void mptcp_graft_subflows(struct sock *sk)
>  		if (!ssk->sk_socket)
>  			mptcp_sock_graft(ssk, sk->sk_socket);
>  
> +		if (!mem_cgroup_sk_enabled(sk))

detail: what's the cost of this call? (static key + get)
Do we need to use a local variable to call this helper only once?

> +			goto unlock;
> +
>  		__mptcp_inherit_cgrp_data(sk, ssk);
>  		__mptcp_inherit_memcg(sk, ssk, GFP_KERNEL);
> +
> +unlock:
>  		release_sock(ssk);
>  	}
> +
> +	if (mem_cgroup_sk_enabled(sk)) {
> +		gfp_t gfp = GFP_KERNEL | __GFP_NOFAIL;
> +		int amt;
> +
> +		/* Account the backlog memory; prior accept() is aware of
> +		 * fwd and rmem only
> +		 */
> +		mptcp_data_lock(sk);
> +		amt = sk_mem_pages(sk->sk_forward_alloc +
> +				   msk->backlog_unaccounted +
> +				   atomic_read(&sk->sk_rmem_alloc)) -
> +		      sk_mem_pages(sk->sk_forward_alloc +
> +				   atomic_read(&sk->sk_rmem_alloc));
> +		msk->backlog_unaccounted = 0;
> +		mptcp_data_unlock(sk);
> +
> +		if (amt)
> +			mem_cgroup_sk_charge(sk, amt, gfp);
> +	}
>  }
>  
>  static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 161b704be16b..199f28f3dd5e 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -360,6 +360,7 @@ struct mptcp_sock {
>  
>  	struct list_head backlog_list;	/* protected by the data lock */
>  	u32		backlog_len;
> +	u32		backlog_unaccounted;
>  };
>  
>  #define mptcp_data_lock(sk) spin_lock_bh(&(sk)->sk_lock.slock)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

