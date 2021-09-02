Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C86A3FC1
	for <mptcp@lists.linux.dev>; Thu,  2 Sep 2021 15:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1630594825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iGC9L5aT1lS5lYgASiTQ+EYI4pG+4XlKs2qybPK/QOs=;
	b=hCDh66/HiBm76WdRVqex8f9O/qzEJtgfqLLpSqph/k8AHZU+ob46khTrRtveFM+X6nHk3S
	D7oqZSvKxn/pHbi1vM0cM0Jd40TCYztEIPprjFEOqNEKVx7JOei5c+I44UxiZpQoruEcqu
	SZHKlDVfIxLbs63NHTFARjB4NDxStCo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-oIQmO-HIP12g048400yW9w-1; Thu, 02 Sep 2021 11:00:24 -0400
X-MC-Unique: oIQmO-HIP12g048400yW9w-1
Received: by mail-wr1-f72.google.com with SMTP id h1-20020adffd41000000b0015931e17ccfso630911wrs.18
        for <mptcp@lists.linux.dev>; Thu, 02 Sep 2021 08:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=iGC9L5aT1lS5lYgASiTQ+EYI4pG+4XlKs2qybPK/QOs=;
        b=OC7BUDYOBnTgpGKmWZgRdgQLBH1xI62d7Z8y+JXDQsThIjgii9KaduC85CGNN4doeX
         Cwj+Mkan+gLbIvDTxHwOJ6S5BRArAyHrLe1xOzXSHSQAM1TUi04vLX+JD2ZGH7DQd5/B
         EiSEwBZ6TjIdyDho1UN9jGwqU8yxVJw1UNIIvqQKplkSJjtCBMXKFesiFvk4kb0eddev
         oZ5cEOIyWrKZd/uZ7QnAVmSz1ORIRcO2h6fN/83QBrAEA3ebhC8FKLgVdeOD2MhiwfAi
         PJ1EjgY5dsVCLuLItM5LdJ4iEC5sKPRvwZTph8fMeTzjSSf1+qshO26d6ppASIiz6eHt
         56Rg==
X-Gm-Message-State: AOAM531puf+fh6o/Vg1AINW7qJQNDGc739zWoubFwXjrV12lVroI1+su
	sBbZUl3th3LbeT8PB6rMnDL+sQnVmGBoSGII2OalhIpqtePQJqLr2LcH0dQwj1FMtjJDhTvL3f5
	y+D5vN17JP3A+v6CK7YKqMn6La1plmcjcWGkE8Oa+Nv6xKkFFAm5TgerdZuMsqfCo
X-Received: by 2002:adf:e645:: with SMTP id b5mr4249738wrn.34.1630594823004;
        Thu, 02 Sep 2021 08:00:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/C3jVkoZSwhR7IWXH9BL392UrgblHYazZBETgJkSf087BjgoOAevNDrkXfhFg8mS1B/M3bA==
X-Received: by 2002:adf:e645:: with SMTP id b5mr4249690wrn.34.1630594822719;
        Thu, 02 Sep 2021 08:00:22 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-233-185.dyn.eolo.it. [146.241.233.185])
        by smtp.gmail.com with ESMTPSA id k16sm2058596wrh.24.2021.09.02.08.00.22
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 08:00:22 -0700 (PDT)
Message-ID: <ea1f947cc9661d26b25c3c4e8f5d5698352d91aa.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 2/4] mptcp: stop relaying on tcp_tx_skb_cache.
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Date: Thu, 02 Sep 2021 17:00:21 +0200
In-Reply-To: <77a77e43a30e0338a1b7a0c811b8e6451862eb02.1630591985.git.pabeni@redhat.com>
References: <cover.1630591985.git.pabeni@redhat.com>
	 <77a77e43a30e0338a1b7a0c811b8e6451862eb02.1630591985.git.pabeni@redhat.com>
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

On Thu, 2021-09-02 at 16:20 +0200, Paolo Abeni wrote:
> We want to revert the skb TX cache, but MPTCP is currently
> using it unconditionally.
> 
> Rework the MPTCP tx code, so that tcp_tx_skb_cache is not
> needed anymore: do the whole coalescing check, skb allocation
> skb initialization/update inside mptcp_sendmsg_frag(), quite
> alike the current TCP code.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/mptcp/protocol.c | 131 +++++++++++++++++++++++++------------------
>  1 file changed, 76 insertions(+), 55 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index faf6e7000d18..98fdb0ebd68d 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1224,6 +1224,7 @@ static struct sk_buff *__mptcp_do_alloc_tx_skb(struct sock *sk, gfp_t gfp)
>  		if (likely(__mptcp_add_ext(skb, gfp))) {
>  			skb_reserve(skb, MAX_TCP_HEADER);
>  			skb->reserved_tailroom = skb->end - skb->tail;
> +			INIT_LIST_HEAD(&skb->tcp_tsorted_anchor);
>  			return skb;
>  		}
>  		__kfree_skb(skb);
> @@ -1233,31 +1234,23 @@ static struct sk_buff *__mptcp_do_alloc_tx_skb(struct sock *sk, gfp_t gfp)
>  	return NULL;
>  }
>  
> -static bool __mptcp_alloc_tx_skb(struct sock *sk, struct sock *ssk, gfp_t gfp)
> +static struct sk_buff *__mptcp_alloc_tx_skb(struct sock *sk, struct sock *ssk, gfp_t gfp)
>  {
>  	struct sk_buff *skb;
>  
> -	if (ssk->sk_tx_skb_cache) {
> -		skb = ssk->sk_tx_skb_cache;
> -		if (unlikely(!skb_ext_find(skb, SKB_EXT_MPTCP) &&
> -			     !__mptcp_add_ext(skb, gfp)))
> -			return false;
> -		return true;
> -	}
> -
>  	skb = __mptcp_do_alloc_tx_skb(sk, gfp);
>  	if (!skb)
> -		return false;
> +		return NULL;
>  
>  	if (likely(sk_wmem_schedule(ssk, skb->truesize))) {
> -		ssk->sk_tx_skb_cache = skb;
> -		return true;
> +		skb_entail(ssk, skb);
> +		return skb;
>  	}
>  	kfree_skb(skb);
> -	return false;
> +	return NULL;
>  }
>  
> -static bool mptcp_alloc_tx_skb(struct sock *sk, struct sock *ssk, bool data_lock_held)
> +static struct sk_buff *mptcp_alloc_tx_skb(struct sock *sk, struct sock *ssk, bool data_lock_held)
>  {
>  	gfp_t gfp = data_lock_held ? GFP_ATOMIC : sk->sk_allocation;
>  
> @@ -1287,23 +1280,29 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
>  			      struct mptcp_sendmsg_info *info)
>  {
>  	u64 data_seq = dfrag->data_seq + info->sent;
> +	int offset = dfrag->offset + info->sent;
>  	struct mptcp_sock *msk = mptcp_sk(sk);
>  	bool zero_window_probe = false;
>  	struct mptcp_ext *mpext = NULL;
> -	struct sk_buff *skb, *tail;
> -	bool must_collapse = false;
> -	int size_bias = 0;
> -	int avail_size;
> -	size_t ret = 0;
> +	bool can_coalesce = false;
> +	bool reuse_skb = true;
> +	struct sk_buff *skb;
> +	size_t copy;
> +	int i = 0;
>  
>  	pr_debug("msk=%p ssk=%p sending dfrag at seq=%llu len=%u already sent=%u",
>  		 msk, ssk, dfrag->data_seq, dfrag->data_len, info->sent);
>  
> +	if (WARN_ON_ONCE(info->sent > info->limit ||
> +			 info->limit > dfrag->data_len))
> +		return 0;
> +
>  	/* compute send limit */
>  	info->mss_now = tcp_send_mss(ssk, &info->size_goal, info->flags);
> -	avail_size = info->size_goal;
> +	copy = info->size_goal;
> +
>  	skb = tcp_write_queue_tail(ssk);
> -	if (skb) {
> +	if (skb && (copy > skb->len)) {
>  		/* Limit the write to the size available in the
>  		 * current skb, if any, so that we create at most a new skb.
>  		 * Explicitly tells TCP internals to avoid collapsing on later
> @@ -1316,53 +1315,75 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
>  			goto alloc_skb;
>  		}
>  
> -		must_collapse = (info->size_goal - skb->len > 0) &&
> -				(skb_shinfo(skb)->nr_frags < sysctl_max_skb_frags);
> -		if (must_collapse) {
> -			size_bias = skb->len;
> -			avail_size = info->size_goal - skb->len;
> +		i = skb_shinfo(skb)->nr_frags;
> +		can_coalesce = skb_can_coalesce(skb, i, dfrag->page, offset);
> +		if (!can_coalesce && i >= sysctl_max_skb_frags) {
> +			tcp_mark_push(tcp_sk(ssk), skb);
> +			goto alloc_skb;
>  		}
> -	}
>  
> +		copy -= skb->len;
> +	} else {
>  alloc_skb:
> -	if (!must_collapse && !ssk->sk_tx_skb_cache &&
> -	    !mptcp_alloc_tx_skb(sk, ssk, info->data_lock_held))
> -		return 0;
> +		skb = mptcp_alloc_tx_skb(sk, ssk, info->data_lock_held);
> +		if (!skb)
> +			return -ENOMEM;
> +
> +		reuse_skb = false;

Uhm... looks like I need to fetch again 'skb_shinfo(skb)->nr_frags'
here. That could be possibly the cause of the OoB I'm observing. Will
send a v2 soon after some more testing.

/P

