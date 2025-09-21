Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC279182B7
	for <mptcp@lists.linux.dev>; Sun, 21 Sep 2025 00:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758414527; cv=none; b=GSJ8pBnf5BQRbXSjTdt9QSljId9bUw5sPLoTtt/DHQtnvEeCvTAGHlyFQs8j9T7qnSVj0dZf5usNDXGAOQ7tFZj9/wKN2g0h4y/DO64dKFyKrVa7Po+CR408tBpWMt2AM6U5UGKTTNXpMR9+psJWyoemYLwyQR50RShQa3E3y1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758414527; c=relaxed/simple;
	bh=Om7Is12s5cj6pWF2yBeiZkd2+XGPqJ4O/EWM3KJ65ww=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mcz7MlIhU2G6tjDGROoaBOzhhV3Xj/cqWae3CdjLkil9XusEVQ1D6udI0NASHj0ufxC3sKDjIVgA3kV6wo0Gtv1j8sIk/bPgOQiudkMLlCSmWrC3U7zwt5hhqJBvVRlxfyGl8ljtd6/dVEYvc3TI4M1gbhk1WFO44GDOyC8Ucxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPubJi0d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPubJi0d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB3FC4CEEB;
	Sun, 21 Sep 2025 00:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758414527;
	bh=Om7Is12s5cj6pWF2yBeiZkd2+XGPqJ4O/EWM3KJ65ww=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=nPubJi0dYjanLt0gDSFGainq9lzTx0hXE77FE6NWxidUVrhLGhrzfG2hiB55oeK/G
	 ki0innY0aisriHLSqnaka1SNezoh/h+UxkmaVkwUgCV6ESjD5Zc4jIQsJ+0R1+299N
	 VtbYqY6RzAj5R3SwmWRNglcw+THBTITHmtzv7Wq8jLNq7EdhvZ//wnHC4SR3YgslnR
	 4wkxb0if2TF2wtfu5ZDPm+rFYCxj0rl7/MDxgd3Z6/4hDh8koTfHpWIe2ixa3PwLTq
	 Sj45A+Vi7K6FNZdUEINDv/lRLSEuE76TiBVIOm2lUuWc/XD+A0IKV+0oIPcBTuxXoF
	 vYm+0D86z4NPg==
Message-ID: <445b1c4c47db49d0a3f6eb8eba1d6fac8ea92665.camel@kernel.org>
Subject: Re: [MPTCP next v3 12/12] mptcp: borrow forward memory from subflow
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Date: Sun, 21 Sep 2025 08:28:45 +0800
In-Reply-To: <34ad291e860dfa1bc1c7d5fe3cc5a07820bec571.1758296923.git.pabeni@redhat.com>
References: <cover.1758296923.git.pabeni@redhat.com>
	 <34ad291e860dfa1bc1c7d5fe3cc5a07820bec571.1758296923.git.pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 2025-09-19 at 17:53 +0200, Paolo Abeni wrote:
> In the MPTCP receive path, we release the subflow allocated
> fwd memory just to allocate it again shortly after for the msk.
> 
> That could increases the failures chances, especially during
> backlog processing, when other actions could consume the just
> released memory before the msk socket has a chance to do the
> rcv allocation.
> 
> Replace the skb_orphan() call with an open-coded variant that
> explicitly borrows, with a PAGE_SIZE granularity, the fwd memory
> from the subflow socket instead of releasing it. During backlog
> processing the borrowed memory is accounted at release_cb time.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

LGTM!

Reviewed-by: Geliang Tang <geliang@kernel.org>
Tested-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> ---
> v1 -> v2:
>   - rebased
>   - explain why skb_orphan is removed
> ---
>  net/mptcp/protocol.c | 27 +++++++++++++++++++++------
>  net/mptcp/protocol.h |  1 +
>  2 files changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 2a025c0c4ca0c..7db5adb43d41b 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -338,11 +338,12 @@ static void mptcp_data_queue_ofo(struct
> mptcp_sock *msk, struct sk_buff *skb)
>  		mptcp_rcvbuf_grow(sk);
>  }
>  
> -static void mptcp_init_skb(struct sock *ssk,
> -			   struct sk_buff *skb, int offset, int
> copy_len)
> +static int mptcp_init_skb(struct sock *ssk,
> +			  struct sk_buff *skb, int offset, int
> copy_len)
>  {
>  	const struct mptcp_subflow_context *subflow =
> mptcp_subflow_ctx(ssk);
>  	bool has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
> +	int borrowed;
>  
>  	/* the skb map_seq accounts for the skb offset:
>  	 * mptcp_subflow_get_mapped_dsn() is based on the current
> tp->copied_seq
> @@ -358,6 +359,15 @@ static void mptcp_init_skb(struct sock *ssk,
>  
>  	skb_ext_reset(skb);
>  	skb_dst_drop(skb);
> +
> +	/* "borrow" the fwd memory from the subflow, instead of
> reclaiming it */
> +	skb->destructor = NULL;
> +	skb->sk = NULL;
> +	atomic_sub(skb->truesize, &ssk->sk_rmem_alloc);
> +	borrowed = ssk->sk_forward_alloc -
> sk_unused_reserved_mem(ssk);
> +	borrowed &= ~(PAGE_SIZE - 1);
> +	sk_forward_alloc_add(ssk, skb->truesize - borrowed);
> +	return borrowed;
>  }
>  
>  static void __mptcp_add_backlog(struct sock *sk, struct sock *ssk,
> @@ -717,14 +727,17 @@ static bool
> __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
>  
>  		if (offset < skb->len) {
>  			size_t len = skb->len - offset;
> +			int bmem;
>  
> -			mptcp_init_skb(ssk, skb, offset, len);
> -			skb_orphan(skb);
> +			bmem = mptcp_init_skb(ssk, skb, offset,
> len);
>  
> -			if (own_msk)
> +			if (own_msk) {
> +				sk_forward_alloc_add(sk, bmem);
>  				ret |= __mptcp_move_skb(sk, skb);
> -			else
> +			} else {
> +				msk->borrowed_fwd_mem += bmem;
>  				__mptcp_add_backlog(sk, ssk, skb);
> +			}
>  			seq += len;
>  
>  			if (unlikely(map_remaining < len)) {
> @@ -3514,6 +3527,8 @@ static void mptcp_release_cb(struct sock *sk)
>  		if (__test_and_clear_bit(MPTCP_SYNC_SNDBUF, &msk-
> >cb_flags))
>  			__mptcp_sync_sndbuf(sk);
>  	}
> +	sk_forward_alloc_add(sk, msk->borrowed_fwd_mem);
> +	msk->borrowed_fwd_mem = 0;
>  }
>  
>  /* MP_JOIN client subflow must wait for 4th ack before sending any
> data:
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index a295ce11774ea..ff87dd9a0da5a 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -298,6 +298,7 @@ struct mptcp_sock {
>  	u32		last_data_sent;
>  	u32		last_data_recv;
>  	u32		last_ack_recv;
> +	int		borrowed_fwd_mem;
>  	unsigned long	timer_ival;
>  	u32		token;
>  	unsigned long	flags;
