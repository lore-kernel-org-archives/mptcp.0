Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEDC3C14
	for <mptcp@lists.linux.dev>; Tue, 11 Oct 2022 15:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1665500672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LiZErzAi2MciMwr60BFSINg/NUnSZ7jh/y+MV/+mh88=;
	b=DTcViLUJ9mASpH6q/F68cU6xxDgIZYsFzZ0JW5jHPBZ6Oiogypueb9VWOmiCuxQrEQWIjJ
	oRHbixsYQI4MZBU0MyCAwTxApqzWFslPhkW0XbG6YSl207Nj9RWoo3RPAn//27o9YoaVJH
	Ay35LqEWWvHPBinU5RkZ11YZq5HRCnU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-88-QO0wfzQQMFmt_NguxpooIg-1; Tue, 11 Oct 2022 11:04:23 -0400
X-MC-Unique: QO0wfzQQMFmt_NguxpooIg-1
Received: by mail-wr1-f71.google.com with SMTP id s30-20020adfa29e000000b002302b9671feso1981082wra.20
        for <mptcp@lists.linux.dev>; Tue, 11 Oct 2022 08:04:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LiZErzAi2MciMwr60BFSINg/NUnSZ7jh/y+MV/+mh88=;
        b=GHbCHcNPDCF1ukq/yd8WhyA+owJnMo+gHGYyziSEioO9nySc43GMfuCRPLzqREmyaS
         cEigXpU9khB5ucKSa+qzkC1HsZKYHBm4zWI2BSFZJ5Q10YFkXOS65VCVqAXq1cjqhxO0
         bpYDAJNs/thQAQrO4DUSDaH3ZxPGl79i4JqSMmy4vdhyTCtuyVCCBRFJXyjbtSUtZsWY
         9Akr6W/q6ZyHmmfC6R4Etm2wlLaR3pB+LPIqO9rXbNl85OMFLmyzTUROM7PZucz6/FgB
         G0PeX6AXs/pTnHespzDXHYYcRlqK0TxukyjmcUa2NKFRctky3QG4/wkE6yFEI7DAVqke
         bhRg==
X-Gm-Message-State: ACrzQf03Fo2GLPtDt1e2zQB4CgQ6idjRnw6QuE29uV8b12iKXzKKPOKz
	qi1e4OSmZzGoKL6DJxTm+zJqwHbELtfKapT+3z9d0B6HhYNKgF/ya6ecmWNDpICjl20YV9CRZZA
	re3FIcxc61WFJ5qc=
X-Received: by 2002:a05:6000:1d8d:b0:22e:6371:65b6 with SMTP id bk13-20020a0560001d8d00b0022e637165b6mr15619359wrb.657.1665500661440;
        Tue, 11 Oct 2022 08:04:21 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM45xwMqbiLf+snSlkX4iKgw50Zw0/yyU36dkyZtPzus1WMD86ceFNOkXQ/6UZcIpYMZ2bMMAQ==
X-Received: by 2002:a05:6000:1d8d:b0:22e:6371:65b6 with SMTP id bk13-20020a0560001d8d00b0022e637165b6mr15619319wrb.657.1665500660989;
        Tue, 11 Oct 2022 08:04:20 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-103-235.dyn.eolo.it. [146.241.103.235])
        by smtp.gmail.com with ESMTPSA id l9-20020adfe589000000b0022e6178bd84sm11411376wrm.8.2022.10.11.08.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 08:04:20 -0700 (PDT)
Message-ID: <59d36d644485854a5d11054410c2801aed21ab59.camel@redhat.com>
Subject: Re: [RFC PATCH mptcp-next v14 3/5] mptcp: add
 subflow_v(4,6)_send_synack()
From: Paolo Abeni <pabeni@redhat.com>
To: Dmytro Shytyi <dmytro@shytyi.net>, mptcp@lists.linux.dev
Date: Tue, 11 Oct 2022 17:04:19 +0200
In-Reply-To: <20221010221809.1792-4-dmytro@shytyi.net>
References: <20221010221809.1792-1-dmytro@shytyi.net>
	 <20221010221809.1792-4-dmytro@shytyi.net>
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

On Mon, 2022-10-10 at 22:18 +0000, Dmytro Shytyi wrote:
> In this patch we add skb to the msk, dequeue it from sk, remove TSs and
> do skb mapping.
> 
> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
> ---
>  net/mptcp/fastopen.c | 78 ++++++++++++++++++++++++++++++++++++++++++++
>  net/mptcp/protocol.c |  2 +-
>  net/mptcp/protocol.h |  3 ++
>  net/mptcp/subflow.c  | 42 ++++++++++++++++++++++++
>  4 files changed, 124 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
> index d6fb45e6be4f..f9ed409fdfb7 100644
> --- a/net/mptcp/fastopen.c
> +++ b/net/mptcp/fastopen.c
> @@ -4,6 +4,84 @@
>  
>  #include "protocol.h"
>  
> +struct mptcp_skb_cb {
> +	u64 map_seq;
> +	u64 end_seq;
> +	u32 offset;
> +	u8  has_rxtstamp:1;
> +};
> +
> +#define MPTCP_SKB_CB(__skb)	((struct mptcp_skb_cb *)&((__skb)->cb[0]))

No need to duplicate the above definition, just move them from
protocol.c into protocol.h

> +
> +void subflow_fastopen_send_synack_set_params(struct mptcp_subflow_context *subflow,
> +					     struct request_sock *req)
> +{
> +	struct tcp_request_sock *treq = tcp_rsk(req);
> +	struct sock *ssk = subflow->tcp_sock;
> +	struct sock *sk = subflow->conn;
> +	struct mptcp_sock *msk;
> +	struct sk_buff *skb;
> +	struct tcp_sock *tp;
> +	u32 offset;
> +
> +	msk = mptcp_sk(sk);
> +	tp = tcp_sk(ssk);
> +
> +	/* mark subflow/msk as "mptfo" */
> +	msk->is_mptfo = 1;
> +
> +	skb = skb_peek(&ssk->sk_receive_queue);
> +
> +	/* dequeue the skb from sk receive queue */
> +	__skb_unlink(skb, &ssk->sk_receive_queue);
> +	skb_ext_reset(skb);
> +	skb_orphan(skb);
> +
> +	/* set the skb mapping */
> +	tp->copied_seq += tp->rcv_nxt - treq->rcv_isn - 1;
> +	subflow->map_seq = mptcp_subflow_get_mapped_dsn(subflow);
> +	subflow->ssn_offset = tp->copied_seq - 1;
> +
> +	/* innitialize MPTCP_CB */

s/innitialize/initialize/

> +	offset = tp->copied_seq - TCP_SKB_CB(skb)->seq;
> +	MPTCP_SKB_CB(skb)->map_seq = mptcp_subflow_get_mapped_dsn(subflow);
> +	MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq +
> +				     (skb->len - offset);
> +	MPTCP_SKB_CB(skb)->offset = offset;
> +	MPTCP_SKB_CB(skb)->has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
> +
> +	mptcp_data_lock(sk);
> +
> +	mptcp_set_owner_r(skb, sk);
> +	__skb_queue_tail(&msk->receive_queue, skb);
> +
> +	(sk)->sk_data_ready(sk);
> +
> +	mptcp_data_unlock(sk);
> +}
> +
> +void __mptcp_pre_connect(struct mptcp_sock *msk, struct sock *ssk,
> +			 struct msghdr *msg, size_t size)
> +{
> +	struct tcp_sock *tp;
> +	struct sk_buff *skb;
> +	struct ubuf_info *uarg;
> +
> +	lock_sock(ssk);
> +
> +	tp = tcp_sk(ssk);
> +
> +	skb = tcp_write_queue_tail(ssk);
> +	uarg = msg_zerocopy_realloc(ssk, size, skb_zcopy(skb));
> +	tp->fastopen_req = kzalloc(sizeof(*tp->fastopen_req),
> +				   ssk->sk_allocation);
> +	tp->fastopen_req->data = msg;
> +	tp->fastopen_req->size = size;
> +	tp->fastopen_req->uarg = uarg;
> +
> +	release_sock(ssk);
> +}

It looks like __mptcp_pre_connect() is unused, right? if so please drop
it.

> +
>  void mptcp_gen_msk_ackseq_fastopen(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
>  				   struct mptcp_options_received mp_opt)
>  {
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index b06f9bbe0e0a..a7571cae2807 100644
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
> index 41276788626b..257a3a62a71b 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -844,6 +844,9 @@ bool mptcp_userspace_pm_active(const struct mptcp_sock *msk);
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
> index 07dd23d0fe04..0fbc45eb7bec 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -307,7 +307,47 @@ static struct dst_entry *subflow_v4_route_req(const struct sock *sk,
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
> +	/* clear tstamp_ok, as needed depending on cookie */
> +	if (foc && foc->len > -1)
> +		ireq->tstamp_ok = 0;
> +
> +	if (synack_type == TCP_SYNACK_FASTOPEN)
> +		subflow_fastopen_send_synack_set_params(subflow, req);
> +
> +	return tcp_request_sock_ipv4_ops.send_synack(sk, dst, fl, req, foc, synack_type, syn_skb);
> +}
> +
>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> +static int subflow_v6_send_synack(const struct sock *sk, struct dst_entry *dst,
> +				  struct flowi *fl,
> +				  struct request_sock *req,
> +				  struct tcp_fastopen_cookie *foc,
> +				  enum tcp_synack_type synack_type,
> +				  struct sk_buff *syn_skb)
> +{
> +	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
> +	struct inet_request_sock *ireq = inet_rsk(req);
> +
> +	/* clear tstamp_ok, as needed depending on cookie */
> +	if (foc && foc->len > -1)
> +		ireq->tstamp_ok = 0;
> +
> +	if (synack_type == TCP_SYNACK_FASTOPEN)
> +		subflow_fastopen_send_synack_set_params(subflow, req);
> +
> +	return tcp_request_sock_ipv6_ops.send_synack(sk, dst, fl, req, foc, synack_type, syn_skb);
> +}
> +
>  static struct dst_entry *subflow_v6_route_req(const struct sock *sk,
>  					      struct sk_buff *skb,
>  					      struct flowi *fl,
> @@ -1920,6 +1960,7 @@ void __init mptcp_subflow_init(void)
>  
>  	subflow_request_sock_ipv4_ops = tcp_request_sock_ipv4_ops;
>  	subflow_request_sock_ipv4_ops.route_req = subflow_v4_route_req;
> +	subflow_request_sock_ipv4_ops.send_synack = subflow_v4_send_synack;
>  
>  	subflow_specific = ipv4_specific;
>  	subflow_specific.conn_request = subflow_v4_conn_request;
> @@ -1933,6 +1974,7 @@ void __init mptcp_subflow_init(void)
>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
>  	subflow_request_sock_ipv6_ops = tcp_request_sock_ipv6_ops;
>  	subflow_request_sock_ipv6_ops.route_req = subflow_v6_route_req;
> +	subflow_request_sock_ipv6_ops.send_synack = subflow_v6_send_synack;
>  
>  	subflow_v6_specific = ipv6_specific;
>  	subflow_v6_specific.conn_request = subflow_v6_conn_request;

