Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A963FC0
	for <mptcp@lists.linux.dev>; Mon,  6 Sep 2021 07:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1630912420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CMne/NJ7RWygzAMznmYvJvWmACzfevDPkta1tvQ1VEU=;
	b=BEbD4nHJkuCaYgH7AEGcTq6Ug7Pxq55nv76ylLydpjU7HfRKn5Y3oMoPuQ80ApZ+gOj/Gp
	8SBYQM5KpMQo62JGaIuNqieY4iwqrIExaoeLe3rUUkHobnsD30BUHsRHaciqN/pqIR4Lsb
	qax2hxltomeEK4aaMHdn8sBmXYF7aTU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-Xb1zg3ctN5yz9kqNjxUKKQ-1; Mon, 06 Sep 2021 03:13:36 -0400
X-MC-Unique: Xb1zg3ctN5yz9kqNjxUKKQ-1
Received: by mail-wm1-f70.google.com with SMTP id c2-20020a7bc8420000b0290238db573ab7so3536491wml.5
        for <mptcp@lists.linux.dev>; Mon, 06 Sep 2021 00:13:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=CMne/NJ7RWygzAMznmYvJvWmACzfevDPkta1tvQ1VEU=;
        b=jHU6rVWSHAmwU2UsSQTl26DatoO6N+M2tF6qkbeFEjYQBkGeRtOhCXZ4Noc40PW2cX
         tRDe2QPNjB3TXPGJLc7f8RznKfp0E8kByfF4HTzb2l8U8LJhx+IeGqolcd+QXuzmtpQy
         Z8W+GRkGrWkeiMMgM/wvUZJXat0NlEpRLYmgqkIReBZRGcv+za4Fs9nhQx59pxHgAgd9
         JOSzpASCZxs6GsyjmF5BMqf6ULxpGVoI3xk8LLcyGMvsujoOCgfUSL69UeZVgUQ7KdkD
         7BV9Kzlu4GYeSHz9A2SohAlXJQWdZIVkDbnD4kAn085z+WqTcsmVc+9eb7OXVBkT49LR
         f6LQ==
X-Gm-Message-State: AOAM533JhnKidBFcPkmXparZrRUTs0lhIaobtvsgust2HcRi9n6/vsKF
	Fht6tlbJ7ZLfE3PK3LuMU9AifwVzaRm7MUEE/Vt10HX5KqZQO+VCjaZXzZxc7j9d9dSOvMWaPjg
	VePuW2RnmR2bYmRQ=
X-Received: by 2002:a5d:40c9:: with SMTP id b9mr11466375wrq.212.1630912415465;
        Mon, 06 Sep 2021 00:13:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKru1RUzcUJzg8Yc6MCUnis6FTIIBJpQPhTCX0WIrZqs+X5Q2HXmQjQLhX+tKMWFTPh0CzdQ==
X-Received: by 2002:a5d:40c9:: with SMTP id b9mr11466359wrq.212.1630912415283;
        Mon, 06 Sep 2021 00:13:35 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-233-185.dyn.eolo.it. [146.241.233.185])
        by smtp.gmail.com with ESMTPSA id k16sm7043486wrx.87.2021.09.06.00.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 00:13:35 -0700 (PDT)
Message-ID: <6e2d8b28b9410aa9f656a86896f6622efe8e74d9.camel@redhat.com>
Subject: Re: [mptcp-next 1/2] mptcp: remove tx_pending_data
From: Paolo Abeni <pabeni@redhat.com>
To: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Date: Mon, 06 Sep 2021 09:13:34 +0200
In-Reply-To: <20210906060614.25217-2-fw@strlen.de>
References: <20210906060614.25217-1-fw@strlen.de>
	 <20210906060614.25217-2-fw@strlen.de>
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

On Mon, 2021-09-06 at 08:06 +0200, Florian Westphal wrote:
> The update on recovery is not correct.
> 
> msk->tx_pending_data += msk->snd_nxt - rtx_head->data_seq;
> 
> will update tx_pending_data multiple times when a subflow is declared
> stale while earlier recovery is still in progress.
> This means that tx_pending_data will still be positive even after
> all data as has been transmitted.
> 
> Rather than fix it, remove this field: there are no consumers.

Yup, I kept it around just to eventually dumping it someday via e.g.
the diag interface...

> The outstanding data byte count can be computed either via
> 
>  "msk->write_seq - rtx_head->data_seq" or
>  "msk->write_seq - msk->snd_una".
> 
> The latter is more recent/accurate estimate as rtx_head adjustment
> is deferred until mptcp lock can be acquired.

... but the latter will suffice for that goal so...
> 
> Signed-off-by: Florian Westphal <fw@strlen.de>

Acked-by: Paolo Abeni <pabeni@redhat.com>

:)
> ---
>  net/mptcp/protocol.c | 4 ----
>  net/mptcp/protocol.h | 1 -
>  2 files changed, 5 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 2a525c7ae920..c0e0ee4cb24f 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1531,7 +1531,6 @@ static void mptcp_update_post_push(struct mptcp_sock *msk,
>  	dfrag->already_sent += sent;
>  
>  	msk->snd_burst -= sent;
> -	msk->tx_pending_data -= sent;
>  
>  	snd_nxt_new += dfrag->already_sent;
>  
> @@ -1761,7 +1760,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>  		frag_truesize += psize;
>  		pfrag->offset += frag_truesize;
>  		WRITE_ONCE(msk->write_seq, msk->write_seq + psize);
> -		msk->tx_pending_data += psize;
>  
>  		/* charge data on mptcp pending queue to the msk socket
>  		 * Note: we charge such data both to sk and ssk
> @@ -2254,7 +2252,6 @@ bool __mptcp_retransmit_pending_data(struct sock *sk)
>  	mptcp_data_unlock(sk);
>  
>  	msk->first_pending = rtx_head;
> -	msk->tx_pending_data += msk->snd_nxt - rtx_head->data_seq;
>  	msk->snd_burst = 0;
>  
>  	/* be sure to clear the "sent status" on all re-injected fragments */
> @@ -2525,7 +2522,6 @@ static int __mptcp_init_sock(struct sock *sk)
>  	msk->first_pending = NULL;
>  	msk->wmem_reserved = 0;
>  	WRITE_ONCE(msk->rmem_released, 0);
> -	msk->tx_pending_data = 0;
>  	msk->timer_ival = TCP_RTO_MIN;
>  
>  	msk->first = NULL;
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 99a23fff7b03..8416810afa8e 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -254,7 +254,6 @@ struct mptcp_sock {
>  	struct sk_buff  *ooo_last_skb;
>  	struct rb_root  out_of_order_queue;
>  	struct sk_buff_head receive_queue;
> -	int		tx_pending_data;
>  	struct list_head conn_list;
>  	struct list_head rtx_queue;
>  	struct mptcp_data_frag *first_pending;

