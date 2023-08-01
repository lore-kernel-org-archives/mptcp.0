Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8411E531
	for <mptcp@lists.linux.dev>; Tue,  1 Aug 2023 10:34:44 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-51d95aed33aso7264977a12.3
        for <mptcp@lists.linux.dev>; Tue, 01 Aug 2023 03:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1690886082; x=1691490882;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EB/zwjrhe6Mbb/oL2aKt/yp6eSJzhgFioUoOzuBwpqU=;
        b=QllG/vISbcWx90yNfL/ZY7Wcjv4ELEgjIFl/kZzkWvSBekiLrJXB9ycXXDKn+gMYh5
         DKImeQQYKiEJwmI+ayw0uT02O4OnYSKqR44RullNDO+BiSwEfdfNRaglfHFBRJ6o86L1
         ybBbeIRBAL71eH4Yb9IPhXWY/nzr1XO0zAgVeyqMeUxBfGk/ZBGqoG2n/LDB5ssUo5Ty
         e5HeXFSZe4ei0lpqQHIUMaWRg6EKmlvrcYYLrEmpPGuriF9nVrNcZi5zcKww9glY2Gw4
         U2n0RUd7LpCF7Pi6yEPlmaLqm5jLGh/hKfncZQPXbJ04OA/XLEfAFR50VgS0GMPKpt2T
         IJJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690886082; x=1691490882;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EB/zwjrhe6Mbb/oL2aKt/yp6eSJzhgFioUoOzuBwpqU=;
        b=TQagRIM1b5oOU4zycDoUHLdwk/4aAXGMiwRHbME96ViKXbKckoZMnlsaKGbyU/S3DR
         Xg3uTyzYkV9f3HQ5ncl1o34sv2mW5vnn6DM6OHI8j2QXUtjmeGWwCLd5elzkFaLVGOX/
         2l8IIVnbDJ0SBaK+qYj6vHlsmuzdAcNf/eNk6ONdfJ28tzyv8177ezJlAvCnPYw1KTsp
         JLSUr4jt7TyaQ0C0r0upCfQWHBVoIp8c/pM2mMLA67TwlKEU4SMX7ysF9+h0+2G+fjt3
         u5+VWE2HJ9mFvvCZ63YY0bM6f0K5a0YLmIVDlc654BsQJXxBnCPAaGRy111k8tj/rKnN
         NyzA==
X-Gm-Message-State: ABy/qLbOpDfkmnJCwzER8di3Y01tI/QCVTfXJjUrEDJyi6PuN7SfMnSD
	KOFDvXbXH6BDEP6uDQS86GT+OwzuT3g3kB+YK6OrMdzG
X-Google-Smtp-Source: APBJJlFGPx9OTPcFK7yYAbjsm8xg/AsZwcoKjUSYgRkjjagHVHliPLMXd9rE96EdUU5tOZkL9dpJ/g==
X-Received: by 2002:aa7:cf97:0:b0:522:afec:3ca5 with SMTP id z23-20020aa7cf97000000b00522afec3ca5mr2044122edx.28.1690886082597;
        Tue, 01 Aug 2023 03:34:42 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:37df:70bd:4b59:9c74? ([2a02:578:8593:1200:37df:70bd:4b59:9c74])
        by smtp.gmail.com with ESMTPSA id ba4-20020a0564021ac400b00522572f323dsm6630428edb.16.2023.08.01.03.34.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 03:34:42 -0700 (PDT)
Message-ID: <2894c643-f883-4f18-9e4e-36c4566c5cab@tessares.net>
Date: Tue, 1 Aug 2023 12:34:41 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net] mptcp: fix disconnect vs accept race
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
References: <68f1f65f9b5542fd200f995844f7ed71bdfbfc30.1690840586.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <68f1f65f9b5542fd200f995844f7ed71bdfbfc30.1690840586.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 01/08/2023 00:25, Paolo Abeni wrote:
> Despite commit 0ad529d9fd2b ("mptcp: fix possible divide by zero in
> recvmsg()"), the mptcp protocol is still prone to a race between
> disconnect() (or shutdown) and accept.
> 
> The root cause is that the mentioned commit checks the msk-level
> flag, but mptcp_stream_accept() does acquire the msk-level lock,
> as it can rely directly on the first subflow lock.
> 
> As reported by Christoph than can lead to a race where an msk
> socket is accepted after that mptcp_subflow_queue_clean() releases
> the listener socket lock and just before it takes destructive
> actions leading to the following splat:

(...)

> Address the issue by temporary removing the pending request socket
> from the accept queue, so that racing accept() can't touch them.
> 
> After depleting the msk - the ssk still exists, as plain TCP sockets,
> re-insert them into the accept queue, so that later inet_csk_listen_stop()
> will complete the tcp socket disposal.

Thank you for working on this fix and sharing this patch!

I just have one question at the end of your patch:

> Fixes: 2a6a870e44dd ("mptcp: stops worker on unaccepted sockets at listener close")
> Reported-by: Christoph Paasch <cpaasch@apple.com>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/423
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> Note: as a net-next follow-up it would be nice to support mptcp socket
> migration, basically duplicating part of the inet_csk_listen_stop() logic

(As you know, I'm always worry when you talk about duplicating code :) )

> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index a7db82eb4eea..1ce9b1a1fb56 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -324,7 +324,6 @@ struct mptcp_sock {
>  	u32		subflow_id;
>  	u32		setsockopt_seq;
>  	char		ca_name[TCP_CA_NAME_MAX];
> -	struct mptcp_sock	*dl_next;
>  };
>  
>  #define mptcp_data_lock(sk) spin_lock_bh(&(sk)->sk_lock.slock)
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index ad7080fabb2f..9bf3c7bc1762 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1793,16 +1793,31 @@ static void subflow_state_change(struct sock *sk)
>  void mptcp_subflow_queue_clean(struct sock *listener_sk, struct sock *listener_ssk)
>  {
>  	struct request_sock_queue *queue = &inet_csk(listener_ssk)->icsk_accept_queue;
> -	struct mptcp_sock *msk, *next, *head = NULL;
> -	struct request_sock *req;
> -	struct sock *sk;
> +	struct request_sock *req, *head, *tail;
> +	struct mptcp_subflow_context *subflow;
> +	struct sock *sk, *ssk;
>  
> -	/* build a list of all unaccepted mptcp sockets */
> +	/* Due to lock dependencies no relevant lock can be acquired under rskq_lock.
> +	 * Splice the req list, so that accept() can not reach the pending ssk after
> +	 * the listener socket is released below.
> +	 */
>  	spin_lock_bh(&queue->rskq_lock);
> -	for (req = queue->rskq_accept_head; req; req = req->dl_next) {
> -		struct mptcp_subflow_context *subflow;
> -		struct sock *ssk = req->sk;
> +	head = queue->rskq_accept_head;
> +	tail = queue->rskq_accept_tail;
> +	queue->rskq_accept_head = NULL;
> +	queue->rskq_accept_tail = NULL;
> +	spin_unlock_bh(&queue->rskq_lock);
> +
> +	if (!head)
> +		return;
>  
> +	/* can't acquire the msk socket lock under the subflow one,
> +	 * or will cause ABBA deadlock
> +	 */
> +	release_sock(listener_ssk);
> +
> +	for (req = head; req; req = req->dl_next) {
> +		ssk = req->sk;
>  		if (!sk_is_mptcp(ssk))
>  			continue;
>  
> @@ -1810,32 +1825,10 @@ void mptcp_subflow_queue_clean(struct sock *listener_sk, struct sock *listener_s
>  		if (!subflow || !subflow->conn)
>  			continue;
>  
> -		/* skip if already in list */
>  		sk = subflow->conn;
> -		msk = mptcp_sk(sk);
> -		if (msk->dl_next || msk == head)
> -			continue;
> -
>  		sock_hold(sk);
> -		msk->dl_next = head;
> -		head = msk;
> -	}
> -	spin_unlock_bh(&queue->rskq_lock);
> -	if (!head)
> -		return;
> -
> -	/* can't acquire the msk socket lock under the subflow one,
> -	 * or will cause ABBA deadlock
> -	 */
> -	release_sock(listener_ssk);
> -
> -	for (msk = head; msk; msk = next) {
> -		sk = (struct sock *)msk;
>  
>  		lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
> -		next = msk->dl_next;
> -		msk->dl_next = NULL;
> -
>  		__mptcp_unaccepted_force_close(sk);
>  		release_sock(sk);
>  
> @@ -1859,6 +1852,13 @@ void mptcp_subflow_queue_clean(struct sock *listener_sk, struct sock *listener_s
>  
>  	/* we are still under the listener msk socket lock */
>  	lock_sock_nested(listener_ssk, SINGLE_DEPTH_NESTING);
> +
> +	/* restore the listener queue, to let the TCP code clean it up */
> +	spin_lock_bh(&queue->rskq_lock);
> +	WARN_ON_ONCE(queue->rskq_accept_head);

What prevent the accept queue to be modified between the moment it has
been "nullified" (at the beginning of this function) and here (at the end)?

I see that both the locks for the queue and the socket have been
released and re-held in between: could this accept queue be modified in
between if we are unlucky?

I'm sure I'm missing something :)

> +	queue->rskq_accept_head = head;
> +	queue->rskq_accept_tail = tail;
> +	spin_unlock_bh(&queue->rskq_lock);
>  }
>  
>  static int subflow_ulp_init(struct sock *sk)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
