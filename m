Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BA4EA2
	for <mptcp@lists.linux.dev>; Wed, 28 Sep 2022 09:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1664357034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Jbwxj2z2TMKOFoeVwDnhQQ7n5UnXta97/3fA3yuD+s=;
	b=ZfyyhC6Q1jdO0LlMri4C1TcFatD2zqsKzo/Q18R1B/EsvLc1c/R9UNfNpGrJXEdOaZhHLZ
	dmXEB8j/ikH2XZI1av8iUmvX2r4OdSIwDu34Q3DRR1OOGfRYOGj7oVQOC0YpD63TsVSq7L
	ZaOYeK4bf+ZZgkNX9+07SU+n82A7YV0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-518-Qiq8K5NOOZKU6jQL1wa6oQ-1; Wed, 28 Sep 2022 05:23:53 -0400
X-MC-Unique: Qiq8K5NOOZKU6jQL1wa6oQ-1
Received: by mail-wm1-f72.google.com with SMTP id k38-20020a05600c1ca600b003b49a809168so876126wms.5
        for <mptcp@lists.linux.dev>; Wed, 28 Sep 2022 02:23:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date;
        bh=3Jbwxj2z2TMKOFoeVwDnhQQ7n5UnXta97/3fA3yuD+s=;
        b=j3vnt5lvmJWgQY7EqS9OJCe/wA363SEvZG5KRxGevLXKsNWqFMo57maEVj98ZlYSnb
         JYHHsaUNmYK57FxXb734uZJY7ezkEdrNdaFGQ7kw98UCoTSFTPh5XfXPQMfh2Cc2LLEj
         O3PpNJ9H4Whcxeek98bI8apmYZ97Ogo5792kHI9lksThpakLWxqT9Eg7snHM0GvXRt3f
         7uIrAU5cZe/8VpiVRfg6vCKhAzO/Xke9bD9dFpZoVLW6FxjqW6CxERXk6p0/aAEvfKRQ
         fMdGBsZr1cPssUS6NQUGlOwda25rt/3OUODIWn+NH9LjUIt3h3zbRBQubtX4snAVcb6w
         T4rw==
X-Gm-Message-State: ACrzQf2RhaRctPMfPITKQKTmupddrwfotTdDhEC/0XnW5ar1NW9yHNW8
	bHNPq/2ZZTCHo6t+OwkVC2ZSOoOz3JxSnidmseF/H27f8qwYAe04Y3xnxIjtAxr3lYGjKuxUbmb
	UWAPIi8J8Regm6MI=
X-Received: by 2002:a5d:6052:0:b0:22a:2ee9:4377 with SMTP id j18-20020a5d6052000000b0022a2ee94377mr19567773wrt.449.1664357032308;
        Wed, 28 Sep 2022 02:23:52 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM65buSQn+JpjpajC5bfp3VeUvy1ApNJZVV4ZdVod7Y0Thvg7G5cqzRS2Vghlkx8M2HpPAfl2g==
X-Received: by 2002:a5d:6052:0:b0:22a:2ee9:4377 with SMTP id j18-20020a5d6052000000b0022a2ee94377mr19567758wrt.449.1664357031972;
        Wed, 28 Sep 2022 02:23:51 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-104-40.dyn.eolo.it. [146.241.104.40])
        by smtp.gmail.com with ESMTPSA id w6-20020adfd4c6000000b00223b8168b15sm3705935wrk.66.2022.09.28.02.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 02:23:51 -0700 (PDT)
Message-ID: <3bd2e2ed85386ea1716ff12d54704dc160733be2.camel@redhat.com>
Subject: Re: [RFC PATCH mptcp-next v12 3/7] mptcp: add
 subflow_v(4,6)_send_synack()
From: Paolo Abeni <pabeni@redhat.com>
To: Dmytro Shytyi <dmytro@shytyi.net>, mptcp@lists.linux.dev
Date: Wed, 28 Sep 2022 11:23:50 +0200
In-Reply-To: <20220927225341.14165-4-dmytro@shytyi.net>
References: <20220927225341.14165-1-dmytro@shytyi.net>
	 <20220927225341.14165-4-dmytro@shytyi.net>
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

On Tue, 2022-09-27 at 22:53 +0000, Dmytro Shytyi wrote:
> In this patch we add skb to the msk, dequeue it from sk, remove TSs and
> do skb mapping.
> 
> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
> ---
>  net/ipv4/tcp_fastopen.c | 19 ++++++++++++------
>  net/mptcp/fastopen.c    | 43 +++++++++++++++++++++++++++++++++++++++++
>  net/mptcp/protocol.c    |  2 +-
>  net/mptcp/protocol.h    |  3 +++
>  net/mptcp/subflow.c     | 42 ++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 102 insertions(+), 7 deletions(-)
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

This should really not be needed; with a proper setup, sock_net(sk)-
>ipv4.sysctl_tcp_fastopen/tcp_fastopen should already be
TFO_SERVER_ENABLE at this point. You can double check that with the
'perf' tool adding a probe on the relevant LoC dumping the sysctl value
(or with a possibly easier way but required a rebuild, with a temporary
printk)

> -
>  	if (tcp_fastopen_no_cookie(sk, dst, TFO_SERVER_COOKIE_NOT_REQD))
>  		goto fastopen;
>  
> diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
> index d6fb45e6be4f..1d824a4d9606 100644
> --- a/net/mptcp/fastopen.c
> +++ b/net/mptcp/fastopen.c
> @@ -17,3 +17,46 @@ void mptcp_gen_msk_ackseq_fastopen(struct mptcp_sock *msk, struct mptcp_subflow_
>  	pr_debug("ack_seq=%llu sndr_key=%llu", msk->ack_seq, mp_opt.sndr_key);
>  	atomic64_set(&msk->rcv_wnd_sent, ack_seq);
>  }
> +
> +void subflow_fastopen_send_synack_set_params(struct mptcp_subflow_context *subflow,
> +					     struct request_sock *req)
> +{
> +	struct tcp_request_sock *tcp_r_sock = tcp_rsk(req);

The conventional name for a tcp_request_sock variable is 'treq'

> +	struct sock *ssk = subflow->tcp_sock;
> +	struct sock *sk = subflow->conn;
> +	struct mptcp_sock *msk;
> +	struct sk_buff *skb;
> +	struct tcp_sock *tp;
> +
> +	msk = mptcp_sk(sk);
> +	tp = tcp_sk(ssk);
> +
> +	/* <mark subflow/msk as "mptfo"> */

Please remove the '<' '>' from the comments, here and below.

> +	msk->is_mptfo = 1;
> +
> +	skb = skb_peek(&ssk->sk_receive_queue);
> +
> +	/* <dequeue the skb from sk receive queue> */
> +	__skb_unlink(skb, &ssk->sk_receive_queue);
> +	skb_ext_reset(skb);
> +	skb_orphan(skb);
> +
> +	/* <set the skb mapping> */
> +	tp->copied_seq += tp->rcv_nxt - tcp_r_sock->rcv_isn - 1;
> +	subflow->map_seq = mptcp_subflow_get_mapped_dsn(subflow);
> +	subflow->ssn_offset = tp->copied_seq - 1;
> +
> +	/* <acquire the msk data lock> */

the above comment and the next 3 are really not needed.

> +	mptcp_data_lock(sk);
> +
> +	/* <move skb into msk receive queue> */
> +	mptcp_set_owner_r(skb, sk);
> +	__skb_queue_tail(&msk->receive_queue, skb);
> +	atomic64_set(&msk->rcv_wnd_sent, mptcp_subflow_get_mapped_dsn(subflow));

I think the above statement is not needed here? we already have it in
mptcp_gen_msk_ackseq_fastopen() in the previous patch?

Instead I think we need to initialize the MPTCP_CB for skb, to avoid
random coalescing from later skbs.

> +
> +	/* <call msk data_ready> */
> +	(sk)->sk_data_ready(sk);
> +
> +	/* <release the msk data lock> */
> +	mptcp_data_unlock(sk);
> +}
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 0db50712bad7..7e63b414011c 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -206,7 +206,7 @@ static void mptcp_rfree(struct sk_buff *skb)
>  	mptcp_rmem_uncharge(sk, len);
>  }
>  
> -static void mptcp_set_owner_r(struct sk_buff *skb, struct sock *sk)
> +void mptcp_set_owner_r(struct sk_buff *skb, struct sock *sk)
>  {
>  	skb_orphan(skb);
>  	skb->sk = sk;
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index a9708a2eb2bc..9c46e802a73a 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -842,6 +842,9 @@ bool mptcp_userspace_pm_active(const struct mptcp_sock *msk);
>  // Fast Open Mechanism functions begin
>  void mptcp_gen_msk_ackseq_fastopen(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
>  				   struct mptcp_options_received mp_opt);
> +void mptcp_set_owner_r(struct sk_buff *skb, struct sock *sk);
> +void subflow_fastopen_send_synack_set_params(struct mptcp_subflow_context *subflow,
> +					     struct request_sock *req);
>  // Fast Open Mechanism functions end
>  
>  static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 07dd23d0fe04..c48143bff114 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -307,6 +307,46 @@ static struct dst_entry *subflow_v4_route_req(const struct sock *sk,
>  	return NULL;
>  }
>  
> +static int subflow_v4_send_synack(const struct sock *sk, struct dst_entry *dst,
> +				  struct flowi *fl,
> +				  struct request_sock *req,
> +				  struct tcp_fastopen_cookie *foc,
> +				  enum tcp_synack_type synack_type,
> +				  struct sk_buff *syn_skb)
> +{
> +	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
> +	struct inet_request_sock *ireq = inet_rsk(req);
> +
> +	/* <evenutally clear tstamp_ok, as needed depending on cookie size> */
> +	if (foc)
> +		ireq->tstamp_ok = 0;

I guess you really need to check the cookie size, too? If the cookie
size is small enough, stripping the timestamp should not be needed.
Also you can move the above 2 lines in
subflow_fastopen_send_synack_set_params()

Cheers,

Paolo

