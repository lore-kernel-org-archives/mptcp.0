Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9573470
	for <mptcp@lists.linux.dev>; Fri, 21 May 2021 16:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1621613958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rs1k6vM9xAvRqEJQTK6uUtVvP12gfDStwd1CYC7zi0Y=;
	b=O/1Ibn2LBVjoC9zy+XREIAoTiExWJ0dhTP3xPYI59M/jUFSFrEaL2FpihJSGKrlngk6fjP
	6BTjI7+XHSBkW/erRfWLDkHUN6dpyNL3I2TI0LhHkjRZN7QNmixrhaaP4HpJLXaZ0ZFyV7
	5JrLCThz1ur185lZwFe05FiPEMeXA8w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-k0d0_8iUM2ui8AyYFG1f9g-1; Fri, 21 May 2021 12:19:16 -0400
X-MC-Unique: k0d0_8iUM2ui8AyYFG1f9g-1
Received: by mail-wr1-f69.google.com with SMTP id t5-20020adfb7c50000b029010dd0bb24cfso9655452wre.2
        for <mptcp@lists.linux.dev>; Fri, 21 May 2021 09:19:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=rs1k6vM9xAvRqEJQTK6uUtVvP12gfDStwd1CYC7zi0Y=;
        b=UWHu1E8sxUBpANb/rT2giWwcOlBOJRIEGNWJNxfB/QGjGukKTy4l0V9unuzg7L9rsd
         DU2ZPtVsHNeWZsE5QtGwn5j5hqeMsVV+3nq9r2pGpfD0a4DiR6jPJONIlGXaQQ1kqjB2
         F2gEMkrqZzLrfymnm/mycZRapAqrUW/6CTs3kdk7u3CvyaDROj11ETipVr/nQjoKQ6is
         ESFhqJCmlkLDmwCfIe5GkzI0paSCrU5dTKhADhRGvd1axzoop6b2IbvQZSZg3KRuD+7S
         ypEC4OBk1psc03zpIIMGBx7zmouN5efGfFV4INupoq5vYUs0mjf1xDauu+LJjGAVbeUf
         S2ig==
X-Gm-Message-State: AOAM532goXwrMgBFvr1mAKT+Kjww6O3V/2HUdkRMELOmY+r0auZKxCgQ
	4EmrATsqFZNwqcfVwlLvtu4Xvw8PlkGBbX9i8yAysjXsAt0fjsOQxaumYuJQvMI32UxQg4MFDZO
	H9TcjOHeQeGcU+SC94s28p49fXE+wvisoQ8QnYqrJ41tLKTsWYQhU5gfAsq5qMb/7
X-Received: by 2002:a1c:2704:: with SMTP id n4mr9742772wmn.147.1621613955606;
        Fri, 21 May 2021 09:19:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1r7/EkTZdq7a+wzpYnunuAOGrMF9bmvam2vsWkDahBJh9AuyGQpxfdcZst0Bal8NMFmV1SA==
X-Received: by 2002:a1c:2704:: with SMTP id n4mr9742738wmn.147.1621613955207;
        Fri, 21 May 2021 09:19:15 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-117-55.dyn.eolo.it. [146.241.117.55])
        by smtp.gmail.com with ESMTPSA id n13sm2681342wrg.75.2021.05.21.09.19.14
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 09:19:14 -0700 (PDT)
Message-ID: <52d5aa83a8c304e4346b5a43cc5cd8858c6db1bd.camel@redhat.com>
Subject: Re: [PATCH mptcp-next] mptcp: drop tx skb cache
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Date: Fri, 21 May 2021 18:19:14 +0200
In-Reply-To: <f3cf8531c9215fb77194e332a1aae5e954dbd2ea.1621592920.git.pabeni@redhat.com>
References: <f3cf8531c9215fb77194e332a1aae5e954dbd2ea.1621592920.git.pabeni@redhat.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
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

On Fri, 2021-05-21 at 12:30 +0200, Paolo Abeni wrote:
> The mentioned cache was introduced to reduce the number of skb
> allocation in atomic context, but the required complexity is
> excessive.
> 
> This change remove the mentioned cache.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> formally submitting this one. I keept a VM running self-tests for ~24h
> with no issues
> ---
>  net/mptcp/protocol.c | 89 ++------------------------------------------
>  1 file changed, 4 insertions(+), 85 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 446acfb85493..1114a914d845 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -903,22 +903,14 @@ static bool mptcp_frag_can_collapse_to(const struct mptcp_sock *msk,
>  		df->data_seq + df->data_len == msk->write_seq;
>  }
>  
> -static int mptcp_wmem_with_overhead(struct sock *sk, int size)
> +static int mptcp_wmem_with_overhead(int size)
>  {
> -	struct mptcp_sock *msk = mptcp_sk(sk);
> -	int ret, skbs;
> -
> -	ret = size + ((sizeof(struct mptcp_data_frag) * size) >> PAGE_SHIFT);
> -	skbs = (msk->tx_pending_data + size) / msk->size_goal_cache;
> -	if (skbs < msk->skb_tx_cache.qlen)
> -		return ret;
> -
> -	return ret + (skbs - msk->skb_tx_cache.qlen) * SKB_TRUESIZE(MAX_TCP_HEADER);
> +	return size + ((sizeof(struct mptcp_data_frag) * size) >> PAGE_SHIFT);
>  }
>  
>  static void __mptcp_wmem_reserve(struct sock *sk, int size)
>  {
> -	int amount = mptcp_wmem_with_overhead(sk, size);
> +	int amount = mptcp_wmem_with_overhead(size);
>  	struct mptcp_sock *msk = mptcp_sk(sk);
>  
>  	WARN_ON_ONCE(msk->wmem_reserved);
> @@ -1213,49 +1205,8 @@ static struct sk_buff *__mptcp_do_alloc_tx_skb(struct sock *sk, gfp_t gfp)
>  	return NULL;
>  }
>  
> -static bool mptcp_tx_cache_refill(struct sock *sk, int size,
> -				  struct sk_buff_head *skbs, int *total_ts)
> -{
> -	struct mptcp_sock *msk = mptcp_sk(sk);
> -	struct sk_buff *skb;
> -	int space_needed;
> -
> -	if (unlikely(tcp_under_memory_pressure(sk))) {
> -		mptcp_mem_reclaim_partial(sk);
> -
> -		/* under pressure pre-allocate at most a single skb */
> -		if (msk->skb_tx_cache.qlen)
> -			return true;
> -		space_needed = msk->size_goal_cache;
> -	} else {
> -		space_needed = msk->tx_pending_data + size -
> -			       msk->skb_tx_cache.qlen * msk->size_goal_cache;
> -	}
> -
> -	while (space_needed > 0) {
> -		skb = __mptcp_do_alloc_tx_skb(sk, sk->sk_allocation);
> -		if (unlikely(!skb)) {
> -			/* under memory pressure, try to pass the caller a
> -			 * single skb to allow forward progress
> -			 */
> -			while (skbs->qlen > 1) {
> -				skb = __skb_dequeue_tail(skbs);
> -				*total_ts -= skb->truesize;
> -				__kfree_skb(skb);
> -			}
> -			return skbs->qlen > 0;
> -		}
> -
> -		*total_ts += skb->truesize;
> -		__skb_queue_tail(skbs, skb);
> -		space_needed -= msk->size_goal_cache;
> -	}
> -	return true;
> -}
> -
>  static bool __mptcp_alloc_tx_skb(struct sock *sk, struct sock *ssk, gfp_t gfp)
>  {
> -	struct mptcp_sock *msk = mptcp_sk(sk);
>  	struct sk_buff *skb;
>  
>  	if (ssk->sk_tx_skb_cache) {
> @@ -1266,22 +1217,6 @@ static bool __mptcp_alloc_tx_skb(struct sock *sk, struct sock *ssk, gfp_t gfp)
>  		return true;
>  	}
>  
> -	skb = skb_peek(&msk->skb_tx_cache);
> -	if (skb) {
> -		if (likely(sk_wmem_schedule(ssk, skb->truesize))) {
> -			skb = __skb_dequeue(&msk->skb_tx_cache);
> -			if (WARN_ON_ONCE(!skb))
> -				return false;
> -
> -			mptcp_wmem_uncharge(sk, skb->truesize);
> -			ssk->sk_tx_skb_cache = skb;
> -			return true;
> -		}
> -
> -		/* over memory limit, no point to try to allocate a new skb */
> -		return false;
> -	}
> -
>  	skb = __mptcp_do_alloc_tx_skb(sk, gfp);
>  	if (!skb)
>  		return false;
> @@ -1297,7 +1232,6 @@ static bool __mptcp_alloc_tx_skb(struct sock *sk, struct sock *ssk, gfp_t gfp)
>  static bool mptcp_must_reclaim_memory(struct sock *sk, struct sock *ssk)
>  {
>  	return !ssk->sk_tx_skb_cache &&
> -	       !skb_peek(&mptcp_sk(sk)->skb_tx_cache) &&
>  	       tcp_under_memory_pressure(sk);
>  }
>  
> @@ -1340,7 +1274,6 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
>  	/* compute send limit */
>  	info->mss_now = tcp_send_mss(ssk, &info->size_goal, info->flags);
>  	avail_size = info->size_goal;
> -	msk->size_goal_cache = info->size_goal;
>  	skb = tcp_write_queue_tail(ssk);
>  	if (skb) {
>  		/* Limit the write to the size available in the
> @@ -1689,7 +1622,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>  	while (msg_data_left(msg)) {
>  		int total_ts, frag_truesize = 0;
>  		struct mptcp_data_frag *dfrag;
> -		struct sk_buff_head skbs;
>  		bool dfrag_collapsed;
>  		size_t psize, offset;
>  
> @@ -1722,16 +1654,10 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>  		psize = pfrag->size - offset;
>  		psize = min_t(size_t, psize, msg_data_left(msg));
>  		total_ts = psize + frag_truesize;
> -		__skb_queue_head_init(&skbs);
> -		if (!mptcp_tx_cache_refill(sk, psize, &skbs, &total_ts))
> -			goto wait_for_memory;
>  
> -		if (!mptcp_wmem_alloc(sk, total_ts)) {
> -			__skb_queue_purge(&skbs);
> +		if (!mptcp_wmem_alloc(sk, total_ts))
>  			goto wait_for_memory;
> -		}
>  
> -		skb_queue_splice_tail(&skbs, &msk->skb_tx_cache);
>  		if (copy_page_from_iter(dfrag->page, offset, psize,
>  					&msg->msg_iter) != psize) {
>  			mptcp_wmem_uncharge(sk, psize + frag_truesize);
> @@ -2460,13 +2386,11 @@ static int __mptcp_init_sock(struct sock *sk)
>  	INIT_LIST_HEAD(&msk->rtx_queue);
>  	INIT_WORK(&msk->work, mptcp_worker);
>  	__skb_queue_head_init(&msk->receive_queue);
> -	__skb_queue_head_init(&msk->skb_tx_cache);

whoops, I forgot to remove the 'skb_tx_cache' field from the msk.

v2 is coming...

/P

