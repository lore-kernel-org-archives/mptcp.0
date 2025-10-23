Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A9E28D82F
	for <mptcp@lists.linux.dev>; Thu, 23 Oct 2025 06:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761201486; cv=none; b=SlzKIRGo57uVkEXy63qfTlOrzYQlP6HjoqwaEk0h92fhFh7YjxxjgaGE/OEfB8iLqckDzrs/0VaAVkzXbRMEeZv19h9mAjSyQ13y1cSbOXlJXgaUlYL1egUv8vD927adtkGK6wuvC7+xYUR3YVvc8YIuZIJNDtFisTk8npX4o6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761201486; c=relaxed/simple;
	bh=oFkwwyIzZMT05j4dCqfEGTNJu6aD7xRZtjSzYs9Y2c8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L/9EoNCfpJimjzbEsKObdV6cRb4q0h7IVLOM+UHr5FBpJ8ldXW42Ed2vT0xLO3F1aCK1DIKFWtC8A3QmhsFMq7qhGT5QnKexWNX9/iwnHIgZrZFweIvBw/yTv9s9I7q1ZZnFBvxQ6aZwT3tKH2uUwlm35QkkU6jEEl+p4CaIfoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUw/Kcpg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUw/Kcpg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE502C4CEE7;
	Thu, 23 Oct 2025 06:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761201484;
	bh=oFkwwyIzZMT05j4dCqfEGTNJu6aD7xRZtjSzYs9Y2c8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=GUw/Kcpgie7mamGqGGP1cJ2MdZyaYMom4f2xd2ReAnQqIcFl2x4oexPAxBI5VLYtR
	 tcCCNIs6F70wcUoNadd4/3ZP8R0OPZaZE2mytqj172AOcA0RWEbmBnn3wjl3DA3DZQ
	 e8p64xQYfBLUWBLafh8vKmUpy/7w1ERZHBuc+nkzhI1DyyHeYYbdxoMwHJoA30eykE
	 Ct0c6Ite0gJoL7XlFBdUbwi+OBcOoNjhRlCIbOrXaLssZfZwDMLSmQcepkPmwxY3+U
	 MEIePAE+D+cma0dPC8yissa26BnPm665EujY73xrH7+pSSdvNX9otes6va4EYD5Tdt
	 5B7DtUBw4fqHA==
Message-ID: <cb11c7174af3fc8e185748fb4169f0b8eba25ee6.camel@kernel.org>
Subject: Re: [PATCH v6 mptcp-next 02/11] mptcp: borrow forward memory from
 subflow
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>
Date: Thu, 23 Oct 2025 14:38:01 +0800
In-Reply-To: <bca701062e618dd595ba395fce0f71ae6a26981c.1761142784.git.pabeni@redhat.com>
References: <cover.1761142784.git.pabeni@redhat.com>
	 <bca701062e618dd595ba395fce0f71ae6a26981c.1761142784.git.pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2025-10-22 at 16:31 +0200, Paolo Abeni wrote:
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
> ---
> v1 -> v2:
>   - rebased
>   - explain why skb_orphan is removed
> ---
>  net/mptcp/protocol.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 804227736638e3..372ae2d9fd229e 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -337,11 +337,12 @@ static void mptcp_data_queue_ofo(struct
> mptcp_sock *msk, struct sk_buff *skb)
>  		mptcp_rcvbuf_grow(sk);
>  }
>  
> -static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb,
> int offset,
> -			   int copy_len)
> +static int mptcp_init_skb(struct sock *ssk,
> +			  struct sk_buff *skb, int offset, int
> copy_len)

nit:

int mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
                   int copy_len)

is better.

>  {
>  	const struct mptcp_subflow_context *subflow =
> mptcp_subflow_ctx(ssk);
>  	bool has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
> +	int borrowed;
>  
>  	/* the skb map_seq accounts for the skb offset:
>  	 * mptcp_subflow_get_mapped_dsn() is based on the current
> tp->copied_seq
> @@ -357,6 +358,13 @@ static void mptcp_init_skb(struct sock *ssk,
> struct sk_buff *skb, int offset,
>  
>  	skb_ext_reset(skb);
>  	skb_dst_drop(skb);
> +
> +	/* "borrow" the fwd memory from the subflow, instead of
> reclaiming it */
> +	skb->destructor = NULL;
> +	borrowed = ssk->sk_forward_alloc -
> sk_unused_reserved_mem(ssk);
> +	borrowed &= ~(PAGE_SIZE - 1);
> +	sk_forward_alloc_add(ssk, skb->truesize - borrowed);
> +	return borrowed;
>  }
>  
>  static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
> @@ -690,9 +698,12 @@ static bool
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
> +			skb->sk = NULL;
> +			sk_forward_alloc_add(sk, bmem);
> +			atomic_sub(skb->truesize, &ssk-
> >sk_rmem_alloc);
>  			ret = __mptcp_move_skb(sk, skb) || ret;
>  			seq += len;
>  

