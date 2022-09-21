Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888018440
	for <mptcp@lists.linux.dev>; Wed, 21 Sep 2022 18:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1663783253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZPKlgekFEQztq3jWHJYWWgMpY+QLswWOly3hcpv5Hko=;
	b=PTpS5FpVUFv6GRz6T2raX8j+THwszFMTXxAKovBaJxG7a2+kVHZcpB7FGoPk/5uYMWuIz2
	GbXNGMdO7tT2TvzQGtxUyqBvcZhzRP0eMnYvQ3INaEOiI4ynAPP4M++rdcRA9uNN5MtCV7
	CYf1I9RCUc8IPSiMy8+lhmoa95NyJnE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-132-yJhOB_xCN-OkCIz1A00UNg-1; Wed, 21 Sep 2022 14:00:52 -0400
X-MC-Unique: yJhOB_xCN-OkCIz1A00UNg-1
Received: by mail-qt1-f197.google.com with SMTP id cb22-20020a05622a1f9600b0035bb51792d2so4699146qtb.5
        for <mptcp@lists.linux.dev>; Wed, 21 Sep 2022 11:00:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date;
        bh=ZPKlgekFEQztq3jWHJYWWgMpY+QLswWOly3hcpv5Hko=;
        b=6DUKSs3cFX0MDYndP+t+ArvmV8bdqqwq+jHG4pK8bCcEFfsoRyWXhMYKEwWAqRJtiK
         +WiKjo3Hw4zSsEBTVUQwR/b2F1+bUbiQp9msdjR+Z0G/pEjLDRJ3WgIrQrMv7RUVrnj9
         Exmh510tq0RmmyFQrrczZtWebVrOFki3v7KbgVRV39WjCT35biwNSM5nwoJGTHqyrIzR
         4ODyiWRWaoERPeCL9p57cIPd90wKSy/qzZKA4MLAV+0AXVicnZseapmlh8tiKFFvGNLT
         3Ff55D8oTA7xEtoHtbh9tJJXquuQR4OG3e6NKGV8qEN/M95jMrZSIMY5Y+poPzmFvZdq
         uOIA==
X-Gm-Message-State: ACrzQf2/5mz6z8pLElbrYXl6Ynfb3SVn15gZrOekBcBXgI6XMaI0KXFo
	pOhc8wGrWBKaFMRPTLQs9yXesoWNPnDQ9SV9YawlbW2msrx1Wgj+YbRJGmcyym+c4VQbL8RtV2p
	ZsXN/9qQhyXZE0K8=
X-Received: by 2002:a05:622a:1388:b0:344:4ff1:dd66 with SMTP id o8-20020a05622a138800b003444ff1dd66mr24155598qtk.135.1663783251163;
        Wed, 21 Sep 2022 11:00:51 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6J64mUVrsWGBGr+gEt938cgG3d7n9HQ7NRsYTQykqHjw/yyRnBUaY/j8xsugzjNifoI2S+mg==
X-Received: by 2002:a05:622a:1388:b0:344:4ff1:dd66 with SMTP id o8-20020a05622a138800b003444ff1dd66mr24155562qtk.135.1663783250798;
        Wed, 21 Sep 2022 11:00:50 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-104-76.dyn.eolo.it. [146.241.104.76])
        by smtp.gmail.com with ESMTPSA id ff14-20020a05622a4d8e00b003445bb107basm2053517qtb.75.2022.09.21.11.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 11:00:50 -0700 (PDT)
Message-ID: <9b128bc8a24d35e3764ef84607ada5758ef55693.camel@redhat.com>
Subject: Re: [RFC PATCH mptcp-next v9 5/6] mptcp: add
 subflow_v(4,6)_send_synack()
From: Paolo Abeni <pabeni@redhat.com>
To: Dmytro Shytyi <dmytro@shytyi.net>, mptcp@lists.linux.dev
Date: Wed, 21 Sep 2022 20:00:48 +0200
In-Reply-To: <20220921125558.19483-6-dmytro@shytyi.net>
References: <20220921125558.19483-1-dmytro@shytyi.net>
	 <20220921125558.19483-6-dmytro@shytyi.net>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2022-09-21 at 14:55 +0200, Dmytro Shytyi wrote:
> In this patch we add skb to the msk, dequeue it from sk, remove TSs and
> do skb mapping.
> 
> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
> ---
>  net/ipv4/tcp_fastopen.c | 19 +++++++----
>  net/mptcp/protocol.c    |  2 +-
>  net/mptcp/protocol.h    |  1 +
>  net/mptcp/subflow.c     | 70 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 85 insertions(+), 7 deletions(-)
> 
> diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
> index 45cc7f1ca296..d6b1380525ea 100644
> --- a/net/ipv4/tcp_fastopen.c
> +++ b/net/ipv4/tcp_fastopen.c
> @@ -356,13 +356,20 @@ struct sock *tcp_try_fastopen(struct sock *sk, struct sk_buff *skb,
>  	if (foc->len == 0) /* Client requests a cookie */
>  		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPFASTOPENCOOKIEREQD);
>  
> -	if (!((tcp_fastopen & TFO_SERVER_ENABLE) &&
> -	      (syn_data || foc->len >= 0) &&
> -	      tcp_fastopen_queue_check(sk))) {
> -		foc->len = -1;
> -		return NULL;
> +	if (sk_is_mptcp(sk)) {
> +		if (((syn_data || foc->len >= 0) &&
> +		     tcp_fastopen_queue_check(sk))) {
> +			foc->len = -1;
> +			return NULL;
> +		}
> +	} else {
> +		if (!((tcp_fastopen & TFO_SERVER_ENABLE) &&
> +		      (syn_data || foc->len >= 0) &&
> +		      tcp_fastopen_queue_check(sk))) {
> +			foc->len = -1;
> +			return NULL;
> +		}
>  	}
> -

Why the above chunk is needed?

>  	if (tcp_fastopen_no_cookie(sk, dst, TFO_SERVER_COOKIE_NOT_REQD))
>  		goto fastopen;
>  
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index d5c502d141b4..6a593be6076b 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -200,7 +200,7 @@ static void mptcp_rfree(struct sk_buff *skb)
>  	mptcp_rmem_uncharge(sk, len);
>  }
>  
> -static void mptcp_set_owner_r(struct sk_buff *skb, struct sock *sk)
> +void mptcp_set_owner_r(struct sk_buff *skb, struct sock *sk)
>  {
>  	skb_orphan(skb);
>  	skb->sk = sk;
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index b9e251848099..58a04144fff0 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -845,6 +845,7 @@ int mptcp_setsockopt_sol_tcp_fastopen(struct mptcp_sock *msk, sockptr_t optval,
>  				      unsigned int optlen);
>  void mptcp_gen_msk_ackseq_fastopen(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
>  				   struct mptcp_options_received mp_opt);
> +void mptcp_set_owner_r(struct sk_buff *skb, struct sock *sk);
>  // Fast Open Mechanism functions end
>  
>  static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 07dd23d0fe04..7deb80c2af69 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -307,6 +307,74 @@ static struct dst_entry *subflow_v4_route_req(const struct sock *sk,
>  	return NULL;
>  }
>  
> +static int subflow_v4_send_synack(const struct sock *sk, struct dst_entry *dst,

If you use 'ssk' instead of 'sk'

> +				  struct flowi *fl,
> +				  struct request_sock *req,
> +				  struct tcp_fastopen_cookie *foc,
> +				  enum tcp_synack_type synack_type,
> +				  struct sk_buff *syn_skb)
> +{
> +	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
> +	struct tcp_request_sock *tcp_r_sock = tcp_rsk(req);
> +	struct sock *socket = mptcp_subflow_ctx(sk)->conn;

than you can use 'sk' here and respect mptcp convection for variable
names.

> +	struct inet_request_sock *ireq = inet_rsk(req);
> +	struct mptcp_sock *msk = mptcp_sk(socket);
> +	struct sock *var_sk = subflow->tcp_sock;

This should be actually equal to ssk

> +	struct tcp_sock *tp = tcp_sk(sk);
> +	struct sk_buff *skb;

All the above variable should be moved under the 'if (synack_type ==
TCP_SYNACK_FASTOPEN) {' branch, as there are used only there.

Additionally if you move all the code in the 'if (synack_type ==
TCP_SYNACK_FASTOPEN)' branch in a separate helper you can later reuse
it in subflow_v6_send_synack()

> +
> +	//<evenutally clear tstamp_ok, as needed depending on cookie size>
> +	//We add ts here as in the "if" below it has no effect.

Please, don't use '//' for comments

> +	if (foc->len > -1) {
> +		ireq->tstamp_ok = 0;
> +	}

No need to add the '{' for a single line 'then' statement; addtionally
I guess you can move the above check under the below if, and you should
check for 'foc != NULL'

> +	if (synack_type == TCP_SYNACK_FASTOPEN) {
> +		// <mark subflow/msk as "mptfo">
> +		msk->is_mptfo = 1;
> +
> +		skb = skb_peek(&var_sk->sk_receive_queue);
> +
> +		//<dequeue the skb from sk receive queue>
> +		__skb_unlink(skb, &var_sk->sk_receive_queue);
> +		skb_ext_reset(skb);
> +		skb_orphan(skb);
> +
> +		//<set the skb mapping>
> +		//Solves: WARNING: at 704 _mptcp_move_skbs_from_subflow+0x5d0/0x651

Please, drop the WARNING reference.

> +		tp->copied_seq += tp->rcv_nxt - tcp_r_sock->rcv_isn - 1;
> +
> +		subflow->map_seq = mptcp_subflow_get_mapped_dsn(subflow);
> +
> +		//Solves: BAD mapping: ssn=0 map_seq=1 map_data_len=3

Same here.

> +		subflow->ssn_offset = tp->copied_seq - 1;
> +
> +		//<acquire the msk data lock>
> +		lock_sock((struct sock *)msk);

the mptcp data lock is acquired with:

		 mptcp_data_lock((struct sock *)msk)

which become
		mptcp_data_lock(sk);

if you apply the mptcp variable name conventions.

I think you additionally need to init the mptcp CB for skb.

I'm not sure what will happen to later skb coming via
__mptcp_move_skb(). You must ensure that they will not be coalesced.
Probably correctly initializing the mptcp CB should ensure the above.

> +
> +		//<move skb into msk receive queue>
> +		mptcp_set_owner_r(skb, (struct sock *)msk);
> +		__skb_queue_tail(&msk->receive_queue, skb);
> +		atomic64_set(&msk->rcv_wnd_sent, mptcp_subflow_get_mapped_dsn(subflow));
> +
> +		//<call msk data_ready>
> +		((struct sock *)msk)->sk_data_ready((struct sock *)msk);

or just:
		sk->sk_data_ready(sk); 

(when respecting the mptcp variables name conventions)

> +
> +		//<release the msk data lock>
> +		release_sock((struct sock *)msk);
> +	}
> +	return tcp_request_sock_ipv4_ops.send_synack(sk, dst, fl, req, foc, synack_type, syn_skb);
> +}
> +
> +static int subflow_v6_send_synack(const struct sock *sk, struct dst_entry *dst,
> +				  struct flowi *fl,
> +				  struct request_sock *req,
> +				  struct tcp_fastopen_cookie *foc,
> +				  enum tcp_synack_type synack_type,
> +				  struct sk_buff *syn_skb)
> +{

This is not enough, you need to do the same things as under the 'if
(synack_type == TCP_SYNACK_FASTOPEN) {' conditional in
subflow_v4_send_synack()

> +	return tcp_request_sock_ipv6_ops.send_synack(sk, dst, fl, req, foc, synack_type, syn_skb);
> +}
> +
>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
>  static struct dst_entry *subflow_v6_route_req(const struct sock *sk,
>  					      struct sk_buff *skb,
> @@ -1920,6 +1988,7 @@ void __init mptcp_subflow_init(void)
>  
>  	subflow_request_sock_ipv4_ops = tcp_request_sock_ipv4_ops;
>  	subflow_request_sock_ipv4_ops.route_req = subflow_v4_route_req;
> +	subflow_request_sock_ipv4_ops.send_synack = subflow_v4_send_synack;
>  
>  	subflow_specific = ipv4_specific;
>  	subflow_specific.conn_request = subflow_v4_conn_request;
> @@ -1933,6 +2002,7 @@ void __init mptcp_subflow_init(void)
>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
>  	subflow_request_sock_ipv6_ops = tcp_request_sock_ipv6_ops;
>  	subflow_request_sock_ipv6_ops.route_req = subflow_v6_route_req;
> +	subflow_request_sock_ipv6_ops.send_synack = subflow_v6_send_synack;
>  
>  	subflow_v6_specific = ipv6_specific;
>  	subflow_v6_specific.conn_request = subflow_v6_conn_request;

