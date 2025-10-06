Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC6124E4BD
	for <mptcp@lists.linux.dev>; Mon,  6 Oct 2025 07:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759737124; cv=none; b=J1lSnbWmYq8Pq9Qw1xvqJk3wdR6VYkGmWfUDnAVc3lFwNbbQAkzXnYraTovJSCK0JlafQdmQ6mSJXj92TLReURmATt9tkdCY41R9UI7H31gwM4haf9Xcg8tY8zN3G4C7zNS9blpiij9E5K4grGJOimgfE4d+UYRMt9ikfXrp9ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759737124; c=relaxed/simple;
	bh=RRJJz/AUDyi8yyIZWUHJNTmtwsb6/sULvhZj+ZPW6Ko=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ivbqNm1NRydN/wcOHncPxQxmxlA2j+cvia2tZQXssQ6Mib8N36Yywmf3eLFRLIv6x1idnPf2SunK4F5mgRqA/9OJ3Ifz1fYQD1fHuDlhtpMgjVJo/FXegOxgqtCXNjf9Soc2GUYalThapeFQIUEI+F1Jx9DwlJB7FtbL/Av5yC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BHEhseE8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BHEhseE8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759737120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bjmEHOI79hU2vTepo2nPay3BWlmjVtrTT68ve0tbsl8=;
	b=BHEhseE8qyp4LKbqlmhLtnylzWeA0K9urrbHaeX+R03UrWoLw5YzJLO4h6l6h09SKPvuTH
	SFtb7IBUL5ie219Ski2M4Ym07qDZXdIpztTsRiS5Lxp6iTQlrlnaizl3SWxLK3L8O3Lkl3
	UMF7RirQaaDDz+Q17fXbuSWHQzKdx9I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-6Y-q7g3QPL-Ek5_iMdGqlg-1; Mon, 06 Oct 2025 03:51:59 -0400
X-MC-Unique: 6Y-q7g3QPL-Ek5_iMdGqlg-1
X-Mimecast-MFC-AGG-ID: 6Y-q7g3QPL-Ek5_iMdGqlg_1759737118
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e36f9c651so24502935e9.3
        for <mptcp@lists.linux.dev>; Mon, 06 Oct 2025 00:51:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759737118; x=1760341918;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bjmEHOI79hU2vTepo2nPay3BWlmjVtrTT68ve0tbsl8=;
        b=qS4/ejeJS/bLlWO07OENpuqYUnv0LjCiibN6wYXK0/n/dzr5oiem3CVHndYxUB6Q/T
         d4OFf6Dqi8KTgD/nUFVTDYG8BFJTIX/kjYsabefPqApX2cWdD+VFPiPUT2x7BCseqYGO
         UVVfIDrf8QcBgHHWihCo9UMVizRjA+GgbkP1qxfOHJ4yQteFD4+8Jfk7F6VVUPMZzGdC
         dQ0qXmjt9+n2TBCcyB/bOmZbJ+XXqi7p9T8Tw335ZVZptYAaGCJh9MCnAPeu4tQEL8rR
         OlUKytRLS9sIZ5hZTHy6FKNXk3Ndj7YY8g+vELavjNiJlXYtAtzzvMBvEs/PHPBw4xhk
         sNPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrEbTDDZuc0+x4479WVi2lOj1Cyzi8KRzQIBLxrTGaOrH43HH4oXSVaWfOYv7TX22TI78RBw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx576HzJU84WNpUEd9bwqr6VZJ/hmaC3MqDFh6St6MAbPiMwEJ0
	8/MZ/+o4RhQcGqp5TJbMO5gbZ1CUxNzF08/v+WD5HkCZEVUJR/GA+1zUD3rp8z2sbyJe0DW5eDF
	sdGfdBj33DVgn6x3sLh5iIjBG3O1A2BQGwcasnYI9tQ7EGPOlL8WB3gnMOj+KoJ4L
X-Gm-Gg: ASbGncvTC6fOm5S/RtZ9dTPzn4DdB1GO0eMTQdi/6bWKqKdn/XKHtE+MJHPQicIWblC
	dAlaqspmuaSwUmp9n72ohOpruzWu0sWLlPnCs1XWP4dzw9WFLI2/+6K+Y00OcGYvGVtWnRybOFP
	vSWG9+RcAwR85+UGy5FGNuVJ6aTCWLB1bpH4+C9idyzpPM3Sy3V54YbhJrq8byiwte40MgMHA/q
	uyeO0GwbTYfNYQWXTyqhSnDuhGabF9Ts4NH5wCi9VWr02WK9NkzSfyczu3Px0R7SeEwyNtsUprf
	9h6kxYBzb0ntOY1q0lP86NWgcouA/LmSM+ASnbXxst2pR3GGJFgYs0IAy+oUEUTUT14Ah/J+1OP
	kfKIVKCbhBVhvKSewgA==
X-Received: by 2002:a05:600c:310c:b0:46e:3550:9390 with SMTP id 5b1f17b1804b1-46e71145860mr71370495e9.20.1759737117826;
        Mon, 06 Oct 2025 00:51:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEV3aeD/kz7bYk7cmNKWvYKig5KbWYs3ucBsEUr8vQoJdjHr4IvBZRpyGLKS3loY80O40q6pA==
X-Received: by 2002:a05:600c:310c:b0:46e:3550:9390 with SMTP id 5b1f17b1804b1-46e71145860mr71370365e9.20.1759737117354;
        Mon, 06 Oct 2025 00:51:57 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f4ab0sm19590475f8f.52.2025.10.06.00.51.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 00:51:56 -0700 (PDT)
Message-ID: <5312c1fe-c12b-466f-9b60-ca89242aeebe@redhat.com>
Date: Mon, 6 Oct 2025 09:51:55 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 mptcp-next 8/8] mptcp: leverage the backlog for RX
 packet processing
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
References: <cover.1759499837.git.pabeni@redhat.com>
 <da7973943502b910bd205954bbc15a1d12dd366c.1759499837.git.pabeni@redhat.com>
 <72adcc32729a469f1306c1b594bdbb3ab0860e14.camel@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <72adcc32729a469f1306c1b594bdbb3ab0860e14.camel@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6F09KsBVNsqYZQKsNzW4-So4FiR9wvUxWi_XKkRizw0_1759737118
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/6/25 7:09 AM, Geliang Tang wrote:
> On Fri, 2025-10-03 at 16:01 +0200, Paolo Abeni wrote:
>> When the msk socket is owned or the msk receive buffer is full,
>> move the incoming skbs in a msk level backlog list. This avoid
>> traversing the joined subflows and acquiring the subflow level
>> socket lock at reception time, improving the RX performances.
>>
>> The skbs in the backlog keep using the incoming subflow receive
>> space,
>> to allow backpressure on the subflow flow control, and when
>> processing the
>> backlog, skbs exceeding the msk receive space are not dropped and
>> re-inserted into backlog processing, as dropping packets already
>> acked
>> at the TCP level, is explicitly discouraged by the RFC and would
>> corrupt
>> the data stream for fallback sockets.
>>
>> As a drawback, special care is needed to avoid adding skbs to the
>> backlog
>> of a closed msk, and to avoid leaving dangling references into the
>> backlog
>> at subflow closing time.
>>
>> Note that we can't use sk_backlog, as such list is processed before
>> release_cb() and the latter can release and re-acquire the msk level
>> socket spin lock. That would cause msk-level OoO that in turn are
>> fatal in case of fallback.
>>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>>  net/mptcp/protocol.c | 204 ++++++++++++++++++++++++++++-------------
>> --
>>  net/mptcp/protocol.h |   5 +-
>>  2 files changed, 136 insertions(+), 73 deletions(-)
>>
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index e354f16f4a79f..1fcdb26b8e0a0 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -654,8 +654,35 @@ static void mptcp_dss_corruption(struct
>> mptcp_sock *msk, struct sock *ssk)
>>  	}
>>  }
>>  
>> +static void __mptcp_add_backlog(struct sock *sk, struct sk_buff
>> *skb)
>> +{
>> +	struct mptcp_sock *msk = mptcp_sk(sk);
>> +	struct sk_buff *tail = NULL;
>> +	bool fragstolen;
>> +	int delta;
>> +
>> +	if (unlikely(sk->sk_state == TCP_CLOSE))
>> +		kfree_skb_reason(skb, SKB_DROP_REASON_SOCKET_CLOSE);
>> +
>> +	/* Try to coalesce with the last skb in our backlog */
>> +	if (!list_empty(&msk->backlog_list))
>> +		tail = list_last_entry(&msk->backlog_list, struct
>> sk_buff, list);
>> +
>> +	if (tail && MPTCP_SKB_CB(skb)->map_seq ==
>> MPTCP_SKB_CB(tail)->end_seq &&
>> +	    skb->sk == tail->sk &&
>> +	    __mptcp_try_coalesce(sk, tail, skb, &fragstolen,
>> &delta)) {
>> +		atomic_sub(skb->truesize - delta, &skb->sk-
>>> sk_rmem_alloc);
>> +		kfree_skb_partial(skb, fragstolen);
>> +		WRITE_ONCE(msk->backlog_len, msk->backlog_len +
>> delta);
>> +		return;
>> +	}
>> +
>> +	list_add_tail(&skb->list, &msk->backlog_list);
>> +	WRITE_ONCE(msk->backlog_len, msk->backlog_len + skb-
>>> truesize);
>> +}
>> +
>>  static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
>> -					   struct sock *ssk)
>> +					   struct sock *ssk, bool
>> own_msk)
>>  {
>>  	struct mptcp_subflow_context *subflow =
>> mptcp_subflow_ctx(ssk);
>>  	struct sock *sk = (struct sock *)msk;
>> @@ -671,9 +698,6 @@ static bool __mptcp_move_skbs_from_subflow(struct
>> mptcp_sock *msk,
>>  		struct sk_buff *skb;
>>  		bool fin;
>>  
>> -		if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
>> -			break;
>> -
>>  		/* try to move as much data as available */
>>  		map_remaining = subflow->map_data_len -
>>  				mptcp_subflow_get_map_offset(subflow
>> );
>> @@ -701,10 +725,18 @@ static bool
>> __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
>>  			int bmem;
>>  
>>  			bmem = mptcp_init_skb(ssk, skb, offset,
>> len);
>> -			skb->sk = NULL;
>> -			sk_forward_alloc_add(sk, bmem);
>> -			atomic_sub(skb->truesize, &ssk-
>>> sk_rmem_alloc);
>> -			ret = __mptcp_move_skb(sk, skb) || ret;
>> +			if (own_msk)
>> +				sk_forward_alloc_add(sk, bmem);
>> +			else
>> +				msk->borrowed_mem += bmem;
>> +
>> +			if (own_msk && sk_rmem_alloc_get(sk) < sk-
>>> sk_rcvbuf) {
>> +				skb->sk = NULL;
>> +				atomic_sub(skb->truesize, &ssk-
>>> sk_rmem_alloc);
>> +				ret |= __mptcp_move_skb(sk, skb);
>> +			} else {
>> +				__mptcp_add_backlog(sk, skb);
>> +			}
>>  			seq += len;
>>  
>>  			if (unlikely(map_remaining < len)) {
>> @@ -823,7 +855,7 @@ static bool move_skbs_to_msk(struct mptcp_sock
>> *msk, struct sock *ssk)
>>  	struct sock *sk = (struct sock *)msk;
>>  	bool moved;
>>  
>> -	moved = __mptcp_move_skbs_from_subflow(msk, ssk);
>> +	moved = __mptcp_move_skbs_from_subflow(msk, ssk, true);
>>  	__mptcp_ofo_queue(msk);
>>  	if (unlikely(ssk->sk_err))
>>  		__mptcp_subflow_error_report(sk, ssk);
>> @@ -838,18 +870,10 @@ static bool move_skbs_to_msk(struct mptcp_sock
>> *msk, struct sock *ssk)
>>  	return moved;
>>  }
>>  
>> -static void __mptcp_data_ready(struct sock *sk, struct sock *ssk)
>> -{
>> -	struct mptcp_sock *msk = mptcp_sk(sk);
>> -
>> -	/* Wake-up the reader only for in-sequence data */
>> -	if (move_skbs_to_msk(msk, ssk) && mptcp_epollin_ready(sk))
>> -		sk->sk_data_ready(sk);
>> -}
>> -
>>  void mptcp_data_ready(struct sock *sk, struct sock *ssk)
>>  {
>>  	struct mptcp_subflow_context *subflow =
>> mptcp_subflow_ctx(ssk);
>> +	struct mptcp_sock *msk = mptcp_sk(sk);
>>  
>>  	/* The peer can send data while we are shutting down this
>>  	 * subflow at msk destruction time, but we must avoid
>> enqueuing
>> @@ -859,10 +883,13 @@ void mptcp_data_ready(struct sock *sk, struct
>> sock *ssk)
>>  		return;
>>  
>>  	mptcp_data_lock(sk);
>> -	if (!sock_owned_by_user(sk))
>> -		__mptcp_data_ready(sk, ssk);
>> -	else
>> -		__set_bit(MPTCP_DEQUEUE, &mptcp_sk(sk)->cb_flags);
>> +	if (!sock_owned_by_user(sk)) {
>> +		/* Wake-up the reader only for in-sequence data */
>> +		if (move_skbs_to_msk(msk, ssk) &&
>> mptcp_epollin_ready(sk))
>> +			sk->sk_data_ready(sk);
>> +	} else {
>> +		__mptcp_move_skbs_from_subflow(msk, ssk, false);
>> +	}
>>  	mptcp_data_unlock(sk);
>>  }
>>  
>> @@ -2096,60 +2123,61 @@ static void mptcp_rcv_space_adjust(struct
>> mptcp_sock *msk, int copied)
>>  	msk->rcvq_space.time = mstamp;
>>  }
>>  
>> -static struct mptcp_subflow_context *
>> -__mptcp_first_ready_from(struct mptcp_sock *msk,
>> -			 struct mptcp_subflow_context *subflow)
>> +static bool __mptcp_move_skbs(struct sock *sk, struct list_head
>> *skbs, u32 *delta)
>>  {
>> -	struct mptcp_subflow_context *start_subflow = subflow;
>> -
>> -	while (!READ_ONCE(subflow->data_avail)) {
>> -		subflow = mptcp_next_subflow(msk, subflow);
>> -		if (subflow == start_subflow)
>> -			return NULL;
>> -	}
>> -	return subflow;
>> -}
>> -
>> -static bool __mptcp_move_skbs(struct sock *sk)
>> -{
>> -	struct mptcp_subflow_context *subflow;
>> +	struct sk_buff *skb = list_first_entry(skbs, struct sk_buff,
>> list);
>>  	struct mptcp_sock *msk = mptcp_sk(sk);
>> -	bool ret = false;
>> -
>> -	if (list_empty(&msk->conn_list))
>> -		return false;
>> -
>> -	subflow = list_first_entry(&msk->conn_list,
>> -				   struct mptcp_subflow_context,
>> node);
>> -	for (;;) {
>> -		struct sock *ssk;
>> -		bool slowpath;
>> +	bool moved = false;
>>  
>> -		/*
>> -		 * As an optimization avoid traversing the subflows
>> list
>> -		 * and ev. acquiring the subflow socket lock before
>> baling out
>> -		 */
>> +	while (1) {
>> +		/* If the msk recvbuf is full stop, don't drop */
>>  		if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
>>  			break;
>>  
>> -		subflow = __mptcp_first_ready_from(msk, subflow);
>> -		if (!subflow)
>> -			break;
>> +		prefetch(skb->next);
>> +		list_del(&skb->list);
>> +		*delta += skb->truesize;
>>  
>> -		ssk = mptcp_subflow_tcp_sock(subflow);
>> -		slowpath = lock_sock_fast(ssk);
>> -		ret = __mptcp_move_skbs_from_subflow(msk, ssk) ||
>> ret;
>> -		if (unlikely(ssk->sk_err))
>> -			__mptcp_error_report(sk);
>> -		unlock_sock_fast(ssk, slowpath);
>> +		/* Release the memory allocated on the incoming
>> subflow before
>> +		 * moving it to the msk
>> +		 */
>> +		atomic_sub(skb->truesize, &skb->sk->sk_rmem_alloc);
>> +		skb->sk = NULL;
>> +		moved |= __mptcp_move_skb(sk, skb);
>> +		if (list_empty(skbs))
>> +			break;
>>  
>> -		subflow = mptcp_next_subflow(msk, subflow);
>> +		skb = list_first_entry(skbs, struct sk_buff, list);
>>  	}
>>  
>>  	__mptcp_ofo_queue(msk);
>> -	if (ret)
>> +	if (moved)
>>  		mptcp_check_data_fin((struct sock *)msk);
>> -	return ret;
>> +	return moved;
>> +}
>> +
>> +static bool mptcp_move_skbs(struct sock *sk)
>> +{
>> +	struct mptcp_sock *msk = mptcp_sk(sk);
>> +	bool moved = false;
>> +	LIST_HEAD(skbs);
>> +	u32 delta = 0;
>> +
>> +	mptcp_data_lock(sk);
>> +	while (!list_empty(&msk->backlog_list)) {
>> +		list_splice_init(&msk->backlog_list, &skbs);
>> +		mptcp_data_unlock(sk);
>> +		moved |= __mptcp_move_skbs(sk, &skbs, &delta);
>> +
>> +		mptcp_data_lock(sk);
>> +		if (!list_empty(&skbs)) {
>> +			list_splice(&skbs, &msk->backlog_list);
>> +			break;
>> +		}
>> +	}
>> +	WRITE_ONCE(msk->backlog_len, msk->backlog_len - delta);
>> +	mptcp_data_unlock(sk);
>> +	return moved;
>>  }
>>  
>>  static unsigned int mptcp_inq_hint(const struct sock *sk)
>> @@ -2215,7 +2243,7 @@ static int mptcp_recvmsg(struct sock *sk,
>> struct msghdr *msg, size_t len,
>>  
>>  		copied += bytes_read;
>>  
>> -		if (skb_queue_empty(&sk->sk_receive_queue) &&
>> __mptcp_move_skbs(sk))
>> +		if (!list_empty(&msk->backlog_list) &&
>> mptcp_move_skbs(sk))
>>  			continue;
>>  
>>  		/* only the MPTCP socket status is relevant here.
>> The exit
>> @@ -2520,6 +2548,9 @@ static void __mptcp_close_ssk(struct sock *sk,
>> struct sock *ssk,
>>  void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
>>  		     struct mptcp_subflow_context *subflow)
>>  {
>> +	struct mptcp_sock *msk = mptcp_sk(sk);
>> +	struct sk_buff *skb;
>> +
>>  	/* The first subflow can already be closed and still in the
>> list */
>>  	if (subflow->close_event_done)
>>  		return;
>> @@ -2529,6 +2560,18 @@ void mptcp_close_ssk(struct sock *sk, struct
>> sock *ssk,
>>  	if (sk->sk_state == TCP_ESTABLISHED)
>>  		mptcp_event(MPTCP_EVENT_SUB_CLOSED, mptcp_sk(sk),
>> ssk, GFP_KERNEL);
>>  
>> +	/* Remove any reference from the backlog to this ssk,
>> accounting the
>> +	 * related skb directly to the main socket
>> +	 */
>> +	list_for_each_entry(skb, &msk->backlog_list, list) {
>> +		if (skb->sk != ssk)
>> +			continue;
>> +
>> +		atomic_sub(skb->truesize, &skb->sk->sk_rmem_alloc);
>> +		atomic_add(skb->truesize, &sk->sk_rmem_alloc);
>> +		skb->sk = sk;
>> +	}
>> +
>>  	/* subflow aborted before reaching the fully_established
>> status
>>  	 * attempt the creation of the next subflow
>>  	 */
>> @@ -2761,8 +2804,11 @@ static void mptcp_do_fastclose(struct sock
>> *sk)
>>  {
>>  	struct mptcp_subflow_context *subflow, *tmp;
>>  	struct mptcp_sock *msk = mptcp_sk(sk);
>> +	struct sk_buff *skb;
>>  
>>  	mptcp_set_state(sk, TCP_CLOSE);
>> +	list_for_each_entry(skb, &msk->backlog_list, list)
>> +		kfree_skb_reason(skb, SKB_DROP_REASON_SOCKET_CLOSE);
>>  	mptcp_for_each_subflow_safe(msk, subflow, tmp)
>>  		__mptcp_close_ssk(sk,
>> mptcp_subflow_tcp_sock(subflow),
>>  				  subflow, MPTCP_CF_FASTCLOSE);
>> @@ -2820,6 +2866,7 @@ static void __mptcp_init_sock(struct sock *sk)
>>  	INIT_LIST_HEAD(&msk->conn_list);
>>  	INIT_LIST_HEAD(&msk->join_list);
>>  	INIT_LIST_HEAD(&msk->rtx_queue);
>> +	INIT_LIST_HEAD(&msk->backlog_list);
>>  	INIT_WORK(&msk->work, mptcp_worker);
>>  	msk->out_of_order_queue = RB_ROOT;
>>  	msk->first_pending = NULL;
>> @@ -3199,9 +3246,13 @@ static void mptcp_destroy_common(struct
>> mptcp_sock *msk, unsigned int flags)
>>  {
>>  	struct mptcp_subflow_context *subflow, *tmp;
>>  	struct sock *sk = (struct sock *)msk;
>> +	struct sk_buff *skb;
>>  
>>  	__mptcp_clear_xmit(sk);
>>  
>> +	list_for_each_entry(skb, &msk->backlog_list, list)
>> +		kfree_skb_reason(skb, SKB_DROP_REASON_SOCKET_CLOSE);
>> +
> 
> I encountered this error while testing the splice test:
> 
> [ 6708.714803] BUG: KFENCE: use-after-free read in mptcp_destroy_common
> (net/mptcp/protocol.c:3233 (discriminator 4))  
> [ 6708.714803] 
> [ 6708.714848] Use-after-free read at 0x000000007fc00f9c (in kfence-
> #253):
> 
> Holding the msk data lock while traversing the backlog_list can fix
> this error:
> 
>         mptcp_data_lock(sk);
>         list_for_each_entry(skb, &msk->backlog_list, list)
>                 kfree_skb_reason(skb, SKB_DROP_REASON_SOCKET_CLOSE);
>         mptcp_data_unlock(sk);
> 
> Similarly, I have also added the holding of the msk data lock in
> mptcp_do_fastclose().
> 
> I would like to ask if this modification is acceptable. If it works, I
> can send a squash-to patch for this.

Thank you for the feedback!

Indeed the current mptcp_destroy_common() impl is quite broken. Beyond
the missing spinlock, there is double free caused by missing removal
from backlog list.

I have a new review ready that should address the above and a few more
issues reported by the CI.  I'll share it soon!

Thanks,

Paolo

