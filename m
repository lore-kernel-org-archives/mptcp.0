Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C2B33C4
	for <mptcp@lists.linux.dev>; Tue, 24 Jan 2023 16:31:03 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id q10-20020a1cf30a000000b003db0edfdb74so1193970wmq.1
        for <mptcp@lists.linux.dev>; Tue, 24 Jan 2023 08:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pMen4TX8dJiQrTgsr9O/rPS+iZi5AFgwNkHnikbYooc=;
        b=5n/uDbsycSNdnVb6VDeJECooWsMUKF1FHRh2lL4BX3gpLTGVMDLSnSoJ2ZmgKSfPro
         ILfByQ+RDBZiBW0jCjoLmS7cDyj2aLTHk+a9Qu0CJEMLgkD59nchM7Wwu3mM+KMcG/l8
         +zd/QCBsikx74xRQOAA2g2gETNWeENv9Nt3bmezoKUK6FXSgfHWjZ0I7BrRrnHipsYw0
         k/mWYYSSUbAaOnY5ins4Mc0xjZMtETg7K2vTp55T/qlWXWjNP5FYciT6P5eb1/e4tssQ
         NDi2aiM6tBKbVOlIUv1TIXC9BliwDFhOxEVRuaocIPTH8r4RaPqAL5zi522xkJnwnjiJ
         zD/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pMen4TX8dJiQrTgsr9O/rPS+iZi5AFgwNkHnikbYooc=;
        b=Xu2bJOHmyX/69FW5RlE+NCgEZ5A7jebZlnIHbEQxlJ7PioCEfPUysDbtqsGqGCy/CO
         DiUE4wVGBslVh67Hk1vCLz96KAloAKz1NNWhVObXh7jbiUSDoe7eW5Zh5lUa8v+KxP1R
         UNR7kgPiTEqqiCIuS1vqAeQHlAhcN38gyQvpNYPOWT0FhiispNSdh6WVwNt+QQoYhQaE
         nZ/+wbXPCWltb+ltWAgFW28rKNN8h+lSeswCr+CA+OFa6gdga3e1KaC/Lh01Y83CLePo
         CWrlQluMVqgKXpTD4F+Mv9fLE/libQto+Q6cO1H9X4OxfPMM/kf0uEwf9/ZRECNQ+307
         Tqtw==
X-Gm-Message-State: AO0yUKUWIJN2S/AM+sKRK7widfSdv8kHjPnyyRS8ZCGxIcaBw+lxs5j7
	38yl3qzdrzw646J2Dw8njIzQZQ==
X-Google-Smtp-Source: AK7set/YCobfWWu6GzQ39brVT7xP+ueeAAPZOn40zI7Y5sRCb2tgW2RXcYHIJKdBQa8KkpD9GaXmFA==
X-Received: by 2002:a05:600c:4f53:b0:3dc:1298:69b8 with SMTP id m19-20020a05600c4f5300b003dc129869b8mr2982201wmq.4.1674577861429;
        Tue, 24 Jan 2023 08:31:01 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:e6e1:b6fe:4f49:c5d? ([2a02:578:8593:1200:e6e1:b6fe:4f49:c5d])
        by smtp.gmail.com with ESMTPSA id g22-20020a05600c309600b003c6b70a4d69sm2319010wmn.42.2023.01.24.08.31.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 08:31:01 -0800 (PST)
Message-ID: <09a5cdbf-de41-ea88-6f93-f09709c09631@tessares.net>
Date: Tue, 24 Jan 2023 17:31:00 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH mptcp-next v2 08/13] mptcp: move first subflow allocation
 at mpc access time
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1673940640.git.pabeni@redhat.com>
 <badc4b131ab094bb806971a019807538abd6ccd5.1673940640.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <badc4b131ab094bb806971a019807538abd6ccd5.1673940640.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 17/01/2023 08:36, Paolo Abeni wrote:
> In the long run this will simplify the mptcp code and will
> allow for more consistent behavior. Move the first subflow
> allocation out of the sock->init ops into the __mptcp_nmpc_socket()
> helper.
> 
> Since the first subflow creation can now happen after the first
> setsockopt() we additionally need to invoke mptcp_sockopt_sync()
> on it.

Thank you for this improvement! I have some questions below if you don't
mind :)

(...)

> @@ -116,6 +104,31 @@ static int __mptcp_socket_create(struct mptcp_sock *msk)
>  	return 0;
>  }
>  
> +/* Returns the first subflow socket if available and the MPC
> + * handshake is not started yet.
> + */
> +struct socket *__mptcp_nmpc_socket(struct mptcp_sock *msk)
> +{
> +	struct sock *sk = (struct sock *)msk;
> +	int ret;
> +
> +	if (!((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN)))
> +		return ERR_PTR(-EINVAL);
> +
> +	if (!msk->subflow) {
> +		if (msk->first)
> +			return ERR_PTR(-EINVAL);
> +
> +		ret = __mptcp_socket_create(msk);
> +		if (ret)
> +			return ERR_PTR(ret);
> +
> +		mptcp_sockopt_sync(msk, msk->first);

Do you think the function should be renamed? Maybe not but it looks
strange to me to create the socket and do the sync here with this name.
Maybe it is just me but with this name, I would expect it just to
returns the first subflow or NULL, but not create a socket if not, no?

Mainly to make it clear a "[gs]etsockopt()" before the MPC will create a
new socket.

> +	}
> +
> +	return msk->subflow;
> +}
> +
>  static void mptcp_drop(struct sock *sk, struct sk_buff *skb)
>  {
>  	sk_drops_add(sk, skb);
> @@ -1699,6 +1712,7 @@ static int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
>  {
>  	unsigned int saved_flags = msg->msg_flags;
>  	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct socket *ssock;
>  	struct sock *ssk;
>  	int ret;
>  
> @@ -1708,8 +1722,11 @@ static int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
>  	 * Since the defer_connect flag is cleared after the first succsful
>  	 * fastopen attempt, no need to check for additional subflow status.
>  	 */
> -	if (msg->msg_flags & MSG_FASTOPEN && !__mptcp_nmpc_socket(msk))
> -		return -EINVAL;
> +	if (msg->msg_flags & MSG_FASTOPEN) {
> +		ssock = __mptcp_nmpc_socket(msk);
> +		if (IS_ERR(ssock))
> +			return PTR_ERR(ssock);> +	}

Here 'ssock' could be declared in this 'if' section: I guess it doesn't
really matter but out of curiosity, what's the code style to apply here?
Fine where it is or moved only where needed?

>  	if (!msk->first)
>  		return -EINVAL;
>  
> @@ -2768,10 +2785,6 @@ static int mptcp_init_sock(struct sock *sk)
>  	if (unlikely(!net->mib.mptcp_statistics) && !mptcp_mib_alloc(net))
>  		return -ENOMEM;
>  
> -	ret = __mptcp_socket_create(mptcp_sk(sk));
> -	if (ret)
> -		return ret;
> -
>  	ret = mptcp_init_sched(mptcp_sk(sk),
>  			       mptcp_sched_find(mptcp_get_scheduler(net)));
>  	if (ret)
> @@ -3592,8 +3605,8 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
>  	int err = -EINVAL;
>  
>  	ssock = __mptcp_nmpc_socket(msk);
> -	if (!ssock)
> -		return -EINVAL;
> +	if (IS_ERR(ssock))
> +		return PTR_ERR(ssock);
>  
>  	mptcp_token_destroy(msk);
>  	inet_sk_state_store(sk, TCP_SYN_SENT);
> @@ -3681,8 +3694,8 @@ static int mptcp_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
>  
>  	lock_sock(sock->sk);
>  	ssock = __mptcp_nmpc_socket(msk);
> -	if (!ssock) {
> -		err = -EINVAL;
> +	if (IS_ERR(ssock)) {
> +		err = PTR_ERR(ssock);
>  		goto unlock;
>  	}
>  
> @@ -3718,8 +3731,8 @@ static int mptcp_listen(struct socket *sock, int backlog)
>  
>  	lock_sock(sk);
>  	ssock = __mptcp_nmpc_socket(msk);
> -	if (!ssock) {
> -		err = -EINVAL;
> +	if (IS_ERR(ssock)) {
> +		err = PTR_ERR(ssock);
>  		goto unlock;
>  	}
>  
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 5f1a30959b5c..3a055438c65e 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -632,7 +632,7 @@ void __mptcp_subflow_send_ack(struct sock *ssk);
>  void mptcp_subflow_reset(struct sock *ssk);
>  void mptcp_subflow_queue_clean(struct sock *sk, struct sock *ssk);
>  void mptcp_sock_graft(struct sock *sk, struct socket *parent);
> -struct socket *__mptcp_nmpc_socket(const struct mptcp_sock *msk);
> +struct socket *__mptcp_nmpc_socket(struct mptcp_sock *msk);
>  bool __mptcp_close(struct sock *sk, long timeout);
>  void mptcp_cancel_work(struct sock *sk);
>  void mptcp_set_owner_r(struct sk_buff *skb, struct sock *sk);
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index 8a9656248b0f..9bddae9c5c58 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -301,9 +301,9 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
>  	case SO_BINDTOIFINDEX:
>  		lock_sock(sk);
>  		ssock = __mptcp_nmpc_socket(msk);
> -		if (!ssock) {
> +		if (IS_ERR(ssock)) {
>  			release_sock(sk);
> -			return -EINVAL;
> +			return PTR_ERR(ssock);
>  		}
>  
>  		ret = sock_setsockopt(ssock, SOL_SOCKET, optname, optval, optlen);
> @@ -396,9 +396,9 @@ static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
>  	case IPV6_FREEBIND:
>  		lock_sock(sk);
>  		ssock = __mptcp_nmpc_socket(msk);
> -		if (!ssock) {
> +		if (IS_ERR(ssock)) {
>  			release_sock(sk);
> -			return -EINVAL;
> +			return PTR_ERR(ssock);
>  		}
>  
>  		ret = tcp_setsockopt(ssock->sk, SOL_IPV6, optname, optval, optlen);
> @@ -693,9 +693,9 @@ static int mptcp_setsockopt_sol_ip_set_transparent(struct mptcp_sock *msk, int o
>  	lock_sock(sk);
>  
>  	ssock = __mptcp_nmpc_socket(msk);
> -	if (!ssock) {
> +	if (IS_ERR(ssock)) {
>  		release_sock(sk);
> -		return -EINVAL;
> +		return PTR_ERR(ssock);
>  	}
>  
>  	issk = inet_sk(ssock->sk);
> @@ -762,13 +762,15 @@ static int mptcp_setsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
>  {
>  	struct sock *sk = (struct sock *)msk;
>  	struct socket *sock;
> -	int ret = -EINVAL;
> +	int ret;
>  
>  	/* Limit to first subflow, before the connection establishment */
>  	lock_sock(sk);
>  	sock = __mptcp_nmpc_socket(msk);
> -	if (!sock)
> +	if (IS_ERR(sock)) {
> +		ret = PTR_ERR(sock);
>  		goto unlock;
> +	}

Just to be sure: here and above the error with __mptcp_nmpc_socket()
should not happen most of the time: only when we reach some limits, e.g.
mem, etc., right?

So it is fine to potentially return a different error than before (and
potentially different than what TCP what doing), is it correct?

>  
>  	ret = tcp_setsockopt(sock->sk, level, optname, optval, optlen);
>  
> @@ -872,7 +874,7 @@ static int mptcp_getsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
>  	}
>  
>  	ssock = __mptcp_nmpc_socket(msk);
> -	if (!ssock)
> +	if (IS_ERR(ssock))
>  		goto out;
>  
>  	ret = tcp_getsockopt(ssock->sk, level, optname, optval, optlen);

Why here you don't assign the error that is returned? (Maybe a comment
should be added?)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
