Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9667C
	for <mptcp@lists.linux.dev>; Wed, 21 Sep 2022 04:10:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1663733391; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=MGWg/L4Lr3OGHRY5vfZKeTxBbXQOSmIPiPFXLPl0tItv2E8IE55dExV4Yx1hBMnmQ0fDpqyRVK2cPFRorBVw2/l+ogqqBLtEDhL/H93K/3cRWBYTGfCM8acKGqze3JHaDZx01974WQFTcLGIbzW6kfqR+Ounargqto/Kgj5pBKo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1663733391; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=V/I/yLII7Ytx97f4rr9bcuAJmysaBde/crLgGDIEByk=; 
	b=MzQciwCI9P/QLBBxhAPVIFd2X3M10WFh1MsybM0YNJvx4l+LZyvutI28yewm6x9Yq5Rt/D6JY+BxLp6YWEfnxKVpIO2dxIwVkTKDuGBiLcVa0CIVzS5qJKSQgND7nt/Q8eXr8iPF0DAFN4OtVMtUv9oix8NfKhV6h4TW0xckeqo=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663733391;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=V/I/yLII7Ytx97f4rr9bcuAJmysaBde/crLgGDIEByk=;
	b=a7+OZKhokObm5HFhr4RH28/jkaEEMOG9h5un7p9tXSftu0Jo6WJ3feM4SX6nrukW
	M1Pzo+2hjuaZ691zx1SPUMXR/QDtxWqam5e+MRiq3G4S/xmv/KtcN3p0+nMihQJYZ4Q
	iQWe1wkHmc6uCKWNpgGSvxb01FraFwcjVlP8EnS8=
Received: from [192.168.1.25] (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1663733389826574.6976538687214; Wed, 21 Sep 2022 06:09:49 +0200 (CEST)
Message-ID: <2658a04c-a7e9-ef5c-d741-b13ee71a9d8f@shytyi.net>
Date: Wed, 21 Sep 2022 06:09:48 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC PATCH mptcp-next v8 6/7] add skb to mskq in
 tcp_fastopen_add_skb()
Content-Language: fr
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <20220920125243.2880-1-dmytro@shytyi.net>
 <20220920125243.2880-7-dmytro@shytyi.net>
 <f486773706f78c6ea780dfed5e97bbedf4fcee70.camel@redhat.com>
From: Dmytro Shytyi <dmytro@shytyi.net>
In-Reply-To: <f486773706f78c6ea780dfed5e97bbedf4fcee70.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Thank you Paolo for this interesting comment with great approach.

Version 9 of mptfo is coming with implemented and working 
"subflow_v4_send_synack()"


On 9/20/2022 6:02 PM, Paolo Abeni wrote:
> On Tue, 2022-09-20 at 14:52 +0200, Dmytro Shytyi wrote:
>> In the following patches we add skb to msk->receive_queue in the MPTCP
>> fastopen context.
>>
>> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
>> ---
>>   include/net/tcp.h       |  2 +-
>>   net/ipv4/tcp_fastopen.c | 55 +++++++++++++++++++++++++++++++++++------
>>   net/ipv4/tcp_input.c    | 11 +++++++--
>>   net/mptcp/protocol.c    |  4 +--
>>   net/mptcp/protocol.h    |  2 ++
>>   5 files changed, 62 insertions(+), 12 deletions(-)
>>
>> diff --git a/include/net/tcp.h b/include/net/tcp.h
>> index a7d49e42470a..6456f90ed9ed 100644
>> --- a/include/net/tcp.h
>> +++ b/include/net/tcp.h
>> @@ -1749,7 +1749,7 @@ int tcp_fastopen_reset_cipher(struct net *net, struct sock *sk,
>>   			      void *primary_key, void *backup_key);
>>   int tcp_fastopen_get_cipher(struct net *net, struct inet_connection_sock *icsk,
>>   			    u64 *key);
>> -void tcp_fastopen_add_skb(struct sock *sk, struct sk_buff *skb);
>> +void tcp_fastopen_add_skb(struct sock *sk, struct sk_buff *skb, struct request_sock *req);
>>   struct sock *tcp_try_fastopen(struct sock *sk, struct sk_buff *skb,
>>   			      struct request_sock *req,
>>   			      struct tcp_fastopen_cookie *foc,
>> diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
>> index 45cc7f1ca296..566706172828 100644
>> --- a/net/ipv4/tcp_fastopen.c
>> +++ b/net/ipv4/tcp_fastopen.c
>> @@ -3,6 +3,7 @@
>>   #include <linux/tcp.h>
>>   #include <linux/rcupdate.h>
>>   #include <net/tcp.h>
>> +#include "../mptcp/protocol.h"
>>   
>>   void tcp_fastopen_init_key_once(struct net *net)
>>   {
>> @@ -166,8 +167,12 @@ static void tcp_fastopen_cookie_gen(struct sock *sk,
>>   /* If an incoming SYN or SYNACK frame contains a payload and/or FIN,
>>    * queue this additional data / FIN.
>>    */
>> -void tcp_fastopen_add_skb(struct sock *sk, struct sk_buff *skb)
>> +void tcp_fastopen_add_skb(struct sock *sk, struct sk_buff *skb, struct request_sock *req)
>>   {
>> +	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
>> +	struct tcp_request_sock *tcp_r_sock = tcp_rsk(req);
>> +	struct sock *socket = mptcp_subflow_ctx(sk)->conn;
>> +	struct mptcp_sock *msk = mptcp_sk(socket);
>>   	struct tcp_sock *tp = tcp_sk(sk);
>>   
>>   	if (TCP_SKB_CB(skb)->end_seq == tp->rcv_nxt)
>> @@ -194,7 +199,34 @@ void tcp_fastopen_add_skb(struct sock *sk, struct sk_buff *skb)
>>   	TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_SYN;
>>   
>>   	tp->rcv_nxt = TCP_SKB_CB(skb)->end_seq;
>> +
>> +	if (req && tp->syn_fastopen && sk_is_mptcp(sk))
>> +		tcp_r_sock = tcp_rsk(req);
>> +	else
>> +		goto add_skb_to_sk;
>> +
>> +	msk->is_mptfo = 1;
>> +
>> +	//Solves: WARNING: at 704 _mptcp_move_skbs_from_subflow+0x5d0/0x651
>> +	tp->copied_seq += tp->rcv_nxt - tcp_r_sock->rcv_isn - 1;
>> +
>> +	subflow->map_seq = mptcp_subflow_get_mapped_dsn(subflow);
>> +
>> +	//Solves: BAD mapping: ssn=0 map_seq=1 map_data_len=3
>> +	subflow->ssn_offset = tp->copied_seq - 1;
>> +
>> +	skb_orphan(skb);
>> +	skb->sk = socket;
>> +	skb->destructor = mptcp_rfree;
>> +	atomic_add(skb->truesize, &socket->sk_rmem_alloc);
>> +	msk->rmem_fwd_alloc -= skb->truesize;
>> +
>> +	__skb_queue_tail(&msk->receive_queue, skb);
>> +	atomic64_set(&msk->rcv_wnd_sent, mptcp_subflow_get_mapped_dsn(subflow));
>> +	goto avoid_add_skb_to_sk;
> AFAICS the above:
>
> - mark the passive socket as an TFO one.
> - set the mapping the DSS mapping for the TFO syn data
> - bypass the usual MPTCP receive path
>
> I think we can do all the above elsewhere, with no need to touch the
> tcp code in an IMHO cleaner way, something alike the following (mostly
> pseudo code, only ipv4 example, the ipv6 part should be added, too):
>
> ---
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index c7d49fb6e7bd..4e23fa9f0083 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -307,6 +307,28 @@ static struct dst_entry *subflow_v4_route_req(const struct sock *sk,
>   	return NULL;
>   }
>   
> +static int subflow_v4_send_synack(const struct sock *sk, struct dst_entry *dst,
> +				  struct flowi *fl,
> +				  struct request_sock *req,
> +				  struct tcp_fastopen_cookie *foc,
> +				  enum tcp_synack_type synack_type,
> +				  struct sk_buff *syn_skb)
> +{
> +	if (synack_type == TCP_SYNACK_FASTOPEN) {
> +		struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
> +
> +		<mark subflow/msk as "mptfo">
> +		<evenutally clear tstamp_ok, as needed depending on cookie size>
> +		<dequeue the skb from sk receive queue>
> +		<set the skb mapping>
> +		<acquire the msk data lock>
> +		<move skb into msk receive queue>
> +		<call msk data_ready>
> +		<release the msk data lock>
> +	}
> +	return tcp_request_sock_ipv4_ops.send_synack(sk, dst, fl, req, foc, synack_type, syn_skb);
> +}
> +
>   #if IS_ENABLED(CONFIG_MPTCP_IPV6)
>   static struct dst_entry *subflow_v6_route_req(const struct sock *sk,
>   					      struct sk_buff *skb,
> @@ -1939,6 +1960,7 @@ void __init mptcp_subflow_init(void)
>   
>   	subflow_request_sock_ipv4_ops = tcp_request_sock_ipv4_ops;
>   	subflow_request_sock_ipv4_ops.route_req = subflow_v4_route_req;
> +	subflow_request_sock_ipv4_ops.send_synack = subflow_v4_send_synack;
>   
>   	subflow_specific = ipv4_specific;
>   	subflow_specific.conn_request = subflow_v4_conn_request;
>
>
>
>
