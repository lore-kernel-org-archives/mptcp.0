Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBCF3C14
	for <mptcp@lists.linux.dev>; Tue, 11 Oct 2022 15:19:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1665501580; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=ZfLHRzKVwoR/BPe2qS9mMr8Fp88NldEz7lZbL4b3JejgSxDTnu1koPoiLe+ey8I8H3mvinpSAZmUsYkcekL+scK3xSq72bQJ0/L/sz/gUT1rGiJtEZ2gf276BRtUPDjxFU5oSWe3ZGsuoUuPGku0WRfTgeGOIr5B/XSEloyZq/Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1665501580; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=M16WexpJbCRR6B1sC3KKNbfcZr5YrwRMuIP2D9eHD14=; 
	b=SqzrKT26IWQkeIGs8eeQ74vTzum8sjDhcGnh5mryaycLWUzz5xfYOuc13KJVkPTAkMUtXan0O6yEYFt4JE30qLuxUgAtr5t14Y+eAWJLDGuBnGzVRPPQS2NF+17l5lbTdlsKlh6heaceqWv2ib9+15mr/ii/ybgfbZ/BFsWKvic=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1665501580;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=M16WexpJbCRR6B1sC3KKNbfcZr5YrwRMuIP2D9eHD14=;
	b=fNyiOizJ7lKbI7zDFLCPZXZNCQMXI+l5MrRFG0MRS+Y6xAax3HU9tbrnGqQrFe6B
	J8mg+FP3t6JVp4wbVEs1p4ycIYT6Aamlvpe9gKtjvs6WGmUZqTJlOek9Po+VByu5vs4
	PVv2iNw6hyDRy00FvI8Gze+HKsMDkrQ4A0Hu0Lmo=
Received: from [10.8.0.6] (vps-940813d4.vps.ovh.net [198.244.188.50]) by mx.zoho.eu
	with SMTPS id 1665501578204776.97100766788; Tue, 11 Oct 2022 17:19:38 +0200 (CEST)
Message-ID: <863b21c1-5bac-56ec-f87c-a2758097ac9c@shytyi.net>
Date: Tue, 11 Oct 2022 17:19:37 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [RFC PATCH mptcp-next v14 3/5] mptcp: add
 subflow_v(4,6)_send_synack()
Content-Language: fr
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <20221010221809.1792-1-dmytro@shytyi.net>
 <20221010221809.1792-4-dmytro@shytyi.net>
 <59d36d644485854a5d11054410c2801aed21ab59.camel@redhat.com>
From: Dmytro Shytyi <dmytro@shytyi.net>
In-Reply-To: <59d36d644485854a5d11054410c2801aed21ab59.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Hello Paolo,

On 10/11/2022 5:04 PM, Paolo Abeni wrote:
> On Mon, 2022-10-10 at 22:18 +0000, Dmytro Shytyi wrote:
>> In this patch we add skb to the msk, dequeue it from sk, remove TSs and
>> do skb mapping.
>>
>> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
>> ---
>>   net/mptcp/fastopen.c | 78 ++++++++++++++++++++++++++++++++++++++++++++
>>   net/mptcp/protocol.c |  2 +-
>>   net/mptcp/protocol.h |  3 ++
>>   net/mptcp/subflow.c  | 42 ++++++++++++++++++++++++
>>   4 files changed, 124 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
>> index d6fb45e6be4f..f9ed409fdfb7 100644
>> --- a/net/mptcp/fastopen.c
>> +++ b/net/mptcp/fastopen.c
>> @@ -4,6 +4,84 @@
>>   
>>   #include "protocol.h"
>>   
>> +struct mptcp_skb_cb {
>> +	u64 map_seq;
>> +	u64 end_seq;
>> +	u32 offset;
>> +	u8  has_rxtstamp:1;
>> +};
>> +
>> +#define MPTCP_SKB_CB(__skb)	((struct mptcp_skb_cb *)&((__skb)->cb[0]))
> No need to duplicate the above definition, just move them from
> protocol.c into protocol.h


I agree.

>> +
>> +void subflow_fastopen_send_synack_set_params(struct mptcp_subflow_context *subflow,
>> +					     struct request_sock *req)
>> +{
>> +	struct tcp_request_sock *treq = tcp_rsk(req);
>> +	struct sock *ssk = subflow->tcp_sock;
>> +	struct sock *sk = subflow->conn;
>> +	struct mptcp_sock *msk;
>> +	struct sk_buff *skb;
>> +	struct tcp_sock *tp;
>> +	u32 offset;
>> +
>> +	msk = mptcp_sk(sk);
>> +	tp = tcp_sk(ssk);
>> +
>> +	/* mark subflow/msk as "mptfo" */
>> +	msk->is_mptfo = 1;
>> +
>> +	skb = skb_peek(&ssk->sk_receive_queue);
>> +
>> +	/* dequeue the skb from sk receive queue */
>> +	__skb_unlink(skb, &ssk->sk_receive_queue);
>> +	skb_ext_reset(skb);
>> +	skb_orphan(skb);
>> +
>> +	/* set the skb mapping */
>> +	tp->copied_seq += tp->rcv_nxt - treq->rcv_isn - 1;
>> +	subflow->map_seq = mptcp_subflow_get_mapped_dsn(subflow);
>> +	subflow->ssn_offset = tp->copied_seq - 1;
>> +
>> +	/* innitialize MPTCP_CB */
> s/innitialize/initialize/
Ooops. Indeed.
>> +	offset = tp->copied_seq - TCP_SKB_CB(skb)->seq;
>> +	MPTCP_SKB_CB(skb)->map_seq = mptcp_subflow_get_mapped_dsn(subflow);
>> +	MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq +
>> +				     (skb->len - offset);
>> +	MPTCP_SKB_CB(skb)->offset = offset;
>> +	MPTCP_SKB_CB(skb)->has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
>> +
>> +	mptcp_data_lock(sk);
>> +
>> +	mptcp_set_owner_r(skb, sk);
>> +	__skb_queue_tail(&msk->receive_queue, skb);
>> +
>> +	(sk)->sk_data_ready(sk);
>> +
>> +	mptcp_data_unlock(sk);
>> +}
>> +
>> +void __mptcp_pre_connect(struct mptcp_sock *msk, struct sock *ssk,
>> +			 struct msghdr *msg, size_t size)
>> +{
>> +	struct tcp_sock *tp;
>> +	struct sk_buff *skb;
>> +	struct ubuf_info *uarg;
>> +
>> +	lock_sock(ssk);
>> +
>> +	tp = tcp_sk(ssk);
>> +
>> +	skb = tcp_write_queue_tail(ssk);
>> +	uarg = msg_zerocopy_realloc(ssk, size, skb_zcopy(skb));
>> +	tp->fastopen_req = kzalloc(sizeof(*tp->fastopen_req),
>> +				   ssk->sk_allocation);
>> +	tp->fastopen_req->data = msg;
>> +	tp->fastopen_req->size = size;
>> +	tp->fastopen_req->uarg = uarg;
>> +
>> +	release_sock(ssk);
>> +}
> It looks like __mptcp_pre_connect() is unused, right? if so please drop
> it.

Yeah, it is trailling from previous patches. I already fixed that locally.

Thanks!

>> +
>>   void mptcp_gen_msk_ackseq_fastopen(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
>>   				   struct mptcp_options_received mp_opt)
>>   {
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index b06f9bbe0e0a..a7571cae2807 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -200,7 +200,7 @@ static void mptcp_rfree(struct sk_buff *skb)
>>   	mptcp_rmem_uncharge(sk, len);
>>   }
>>   
>> -static void mptcp_set_owner_r(struct sk_buff *skb, struct sock *sk)
>> +void mptcp_set_owner_r(struct sk_buff *skb, struct sock *sk)
>>   {
>>   	skb_orphan(skb);
>>   	skb->sk = sk;
>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>> index 41276788626b..257a3a62a71b 100644
>> --- a/net/mptcp/protocol.h
>> +++ b/net/mptcp/protocol.h
>> @@ -844,6 +844,9 @@ bool mptcp_userspace_pm_active(const struct mptcp_sock *msk);
>>   // Fast Open Mechanism functions begin
>>   void mptcp_gen_msk_ackseq_fastopen(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
>>   				   struct mptcp_options_received mp_opt);
>> +void mptcp_set_owner_r(struct sk_buff *skb, struct sock *sk);
>> +void subflow_fastopen_send_synack_set_params(struct mptcp_subflow_context *subflow,
>> +					     struct request_sock *req);
>>   // Fast Open Mechanism functions end
>>   
>>   static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)
>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>> index 07dd23d0fe04..0fbc45eb7bec 100644
>> --- a/net/mptcp/subflow.c
>> +++ b/net/mptcp/subflow.c
>> @@ -307,7 +307,47 @@ static struct dst_entry *subflow_v4_route_req(const struct sock *sk,
>>   	return NULL;
>>   }
>>   
>> +static int subflow_v4_send_synack(const struct sock *sk, struct dst_entry *dst,
>> +				  struct flowi *fl,
>> +				  struct request_sock *req,
>> +				  struct tcp_fastopen_cookie *foc,
>> +				  enum tcp_synack_type synack_type,
>> +				  struct sk_buff *syn_skb)
>> +{
>> +	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
>> +	struct inet_request_sock *ireq = inet_rsk(req);
>> +
>> +	/* clear tstamp_ok, as needed depending on cookie */
>> +	if (foc && foc->len > -1)
>> +		ireq->tstamp_ok = 0;
>> +
>> +	if (synack_type == TCP_SYNACK_FASTOPEN)
>> +		subflow_fastopen_send_synack_set_params(subflow, req);
>> +
>> +	return tcp_request_sock_ipv4_ops.send_synack(sk, dst, fl, req, foc, synack_type, syn_skb);
>> +}
>> +
>>   #if IS_ENABLED(CONFIG_MPTCP_IPV6)
>> +static int subflow_v6_send_synack(const struct sock *sk, struct dst_entry *dst,
>> +				  struct flowi *fl,
>> +				  struct request_sock *req,
>> +				  struct tcp_fastopen_cookie *foc,
>> +				  enum tcp_synack_type synack_type,
>> +				  struct sk_buff *syn_skb)
>> +{
>> +	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
>> +	struct inet_request_sock *ireq = inet_rsk(req);
>> +
>> +	/* clear tstamp_ok, as needed depending on cookie */
>> +	if (foc && foc->len > -1)
>> +		ireq->tstamp_ok = 0;
>> +
>> +	if (synack_type == TCP_SYNACK_FASTOPEN)
>> +		subflow_fastopen_send_synack_set_params(subflow, req);
>> +
>> +	return tcp_request_sock_ipv6_ops.send_synack(sk, dst, fl, req, foc, synack_type, syn_skb);
>> +}
>> +
>>   static struct dst_entry *subflow_v6_route_req(const struct sock *sk,
>>   					      struct sk_buff *skb,
>>   					      struct flowi *fl,
>> @@ -1920,6 +1960,7 @@ void __init mptcp_subflow_init(void)
>>   
>>   	subflow_request_sock_ipv4_ops = tcp_request_sock_ipv4_ops;
>>   	subflow_request_sock_ipv4_ops.route_req = subflow_v4_route_req;
>> +	subflow_request_sock_ipv4_ops.send_synack = subflow_v4_send_synack;
>>   
>>   	subflow_specific = ipv4_specific;
>>   	subflow_specific.conn_request = subflow_v4_conn_request;
>> @@ -1933,6 +1974,7 @@ void __init mptcp_subflow_init(void)
>>   #if IS_ENABLED(CONFIG_MPTCP_IPV6)
>>   	subflow_request_sock_ipv6_ops = tcp_request_sock_ipv6_ops;
>>   	subflow_request_sock_ipv6_ops.route_req = subflow_v6_route_req;
>> +	subflow_request_sock_ipv6_ops.send_synack = subflow_v6_send_synack;
>>   
>>   	subflow_v6_specific = ipv6_specific;
>>   	subflow_v6_specific.conn_request = subflow_v6_conn_request;
>
