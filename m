Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7147E1FBA
	for <mptcp@lists.linux.dev>; Sat,  1 Oct 2022 02:59:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1664593193; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=TLW42uCYRcHZY/FbhbK47AzMRyHc0QvhTtcIdT493gJPCd89uB3JqFevdI1qw+tRNlKWW9a3IZRp5S2ot6z71IsaXoYfUjxP3we4g13KkiL7TIKj+HNac9+Ek3VdeUpmBBaLj+n64HNQzDxJx5ZlCkRFjkFcI5raCBTmEB9+06Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1664593193; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=eFIb7oahQK34+DF0shUdnpIQjddQ6PXDATqCpWjfBE8=; 
	b=E1HRCjDlaYgALWSria0d9rCMeppxs2jKuzEWdHxdeTKciN7M+GRXvZH/5L4hA+9HDyqp0IOb2g6tC3M4f2vRuS5w46aRCU+ykG0B3EZRMVYdaW2dj7d4hazQGpAbW1qF1PaH7dWIweUv00yE+TKPWVKN1OmjNC0G86Mam8PiUtU=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1664593193;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=eFIb7oahQK34+DF0shUdnpIQjddQ6PXDATqCpWjfBE8=;
	b=WZ2dBXSD++kP+hCVZZMLrzmfdAE4351HglGH+2ylIp6HGT2sr985s5vcaIyqmi/0
	3NV3bRjx6qhNT3lzQoMAzEOEyX3grwWE3D9BdBky7doRLh5qZBFf8o6VLUBSII817KW
	rD9tTvlAlEerXc86fiDe6/a8UE3vZgMP3sbf8Ir8=
Received: from [192.168.1.25] (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1664593191009150.76361800986547; Sat, 1 Oct 2022 04:59:51 +0200 (CEST)
Message-ID: <a7011025-39ae-a2cc-2f31-14cc9b22d431@shytyi.net>
Date: Sat, 1 Oct 2022 04:59:50 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC PATCH mptcp-next v12 3/7] mptcp: add
 subflow_v(4,6)_send_synack()
Content-Language: fr
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <20220927225341.14165-1-dmytro@shytyi.net>
 <20220927225341.14165-4-dmytro@shytyi.net>
 <3bd2e2ed85386ea1716ff12d54704dc160733be2.camel@redhat.com>
From: Dmytro Shytyi <dmytro@shytyi.net>
In-Reply-To: <3bd2e2ed85386ea1716ff12d54704dc160733be2.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Hello,

On 9/28/2022 11:23 AM, Paolo Abeni wrote:
> On Tue, 2022-09-27 at 22:53 +0000, Dmytro Shytyi wrote:
>> In this patch we add skb to the msk, dequeue it from sk, remove TSs and
>> do skb mapping.
>>
>> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
>> ---
>>   net/ipv4/tcp_fastopen.c | 19 ++++++++++++------
>>   net/mptcp/fastopen.c    | 43 +++++++++++++++++++++++++++++++++++++++++
>>   net/mptcp/protocol.c    |  2 +-
>>   net/mptcp/protocol.h    |  3 +++
>>   net/mptcp/subflow.c     | 42 ++++++++++++++++++++++++++++++++++++++++
>>   5 files changed, 102 insertions(+), 7 deletions(-)
>>
>> diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
>> index 45cc7f1ca296..d6b1380525ea 100644
>> --- a/net/ipv4/tcp_fastopen.c
>> +++ b/net/ipv4/tcp_fastopen.c
>> @@ -356,13 +356,20 @@ struct sock *tcp_try_fastopen(struct sock *sk, struct sk_buff *skb,
>>   	if (foc->len == 0) /* Client requests a cookie */
>>   		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPFASTOPENCOOKIEREQD);
>>   
>> -	if (!((tcp_fastopen & TFO_SERVER_ENABLE) &&
>> -	      (syn_data || foc->len >= 0) &&
>> -	      tcp_fastopen_queue_check(sk))) {
>> -		foc->len = -1;
>> -		return NULL;
>> +	if (sk_is_mptcp(sk)) {
>> +		if (((syn_data || foc->len >= 0) &&
>> +		     tcp_fastopen_queue_check(sk))) {
>> +			foc->len = -1;
>> +			return NULL;
>> +		}
>> +	} else {
>> +		if (!((tcp_fastopen & TFO_SERVER_ENABLE) &&
>> +		      (syn_data || foc->len >= 0) &&
>> +		      tcp_fastopen_queue_check(sk))) {
>> +			foc->len = -1;
>> +			return NULL;
>> +		}
>>   	}
> This should really not be needed; with a proper setup, sock_net(sk)-
>> ipv4.sysctl_tcp_fastopen/tcp_fastopen should already be
> TFO_SERVER_ENABLE at this point. You can double check that with the
> 'perf' tool adding a probe on the relevant LoC dumping the sysctl value
> (or with a possibly easier way but required a rebuild, with a temporary
> printk)


In v13 it is ok. No need to add this.

>> -
>>   	if (tcp_fastopen_no_cookie(sk, dst, TFO_SERVER_COOKIE_NOT_REQD))
>>   		goto fastopen;
>>   
>> diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
>> index d6fb45e6be4f..1d824a4d9606 100644
>> --- a/net/mptcp/fastopen.c
>> +++ b/net/mptcp/fastopen.c
>> @@ -17,3 +17,46 @@ void mptcp_gen_msk_ackseq_fastopen(struct mptcp_sock *msk, struct mptcp_subflow_
>>   	pr_debug("ack_seq=%llu sndr_key=%llu", msk->ack_seq, mp_opt.sndr_key);
>>   	atomic64_set(&msk->rcv_wnd_sent, ack_seq);
>>   }
>> +
>> +void subflow_fastopen_send_synack_set_params(struct mptcp_subflow_context *subflow,
>> +					     struct request_sock *req)
>> +{
>> +	struct tcp_request_sock *tcp_r_sock = tcp_rsk(req);
> The conventional name for a tcp_request_sock variable is 'treq'
Fixed in v13.
>> +	struct sock *ssk = subflow->tcp_sock;
>> +	struct sock *sk = subflow->conn;
>> +	struct mptcp_sock *msk;
>> +	struct sk_buff *skb;
>> +	struct tcp_sock *tp;
>> +
>> +	msk = mptcp_sk(sk);
>> +	tp = tcp_sk(ssk);
>> +
>> +	/* <mark subflow/msk as "mptfo"> */
> Please remove the '<' '>' from the comments, here and below.
Fixed in v13
>> +	msk->is_mptfo = 1;
>> +
>> +	skb = skb_peek(&ssk->sk_receive_queue);
>> +
>> +	/* <dequeue the skb from sk receive queue> */
>> +	__skb_unlink(skb, &ssk->sk_receive_queue);
>> +	skb_ext_reset(skb);
>> +	skb_orphan(skb);
>> +
>> +	/* <set the skb mapping> */
>> +	tp->copied_seq += tp->rcv_nxt - tcp_r_sock->rcv_isn - 1;
>> +	subflow->map_seq = mptcp_subflow_get_mapped_dsn(subflow);
>> +	subflow->ssn_offset = tp->copied_seq - 1;
>> +
>> +	/* <acquire the msk data lock> */
> the above comment and the next 3 are really not needed.
Fixed in v13.
>> +	mptcp_data_lock(sk);
>> +
>> +	/* <move skb into msk receive queue> */
>> +	mptcp_set_owner_r(skb, sk);
>> +	__skb_queue_tail(&msk->receive_queue, skb);
>> +	atomic64_set(&msk->rcv_wnd_sent, mptcp_subflow_get_mapped_dsn(subflow));
> I think the above statement is not needed here? we already have it in
> mptcp_gen_msk_ackseq_fastopen() in the previous patch?
fixed in v13.
> Instead I think we need to initialize the MPTCP_CB for skb, to avoid
> random coalescing from later skbs.
Added in v13. Open to any comments on this subject.
>> +
>> +	/* <call msk data_ready> */
>> +	(sk)->sk_data_ready(sk);
>> +
>> +	/* <release the msk data lock> */
>> +	mptcp_data_unlock(sk);
>> +}
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index 0db50712bad7..7e63b414011c 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -206,7 +206,7 @@ static void mptcp_rfree(struct sk_buff *skb)
>>   	mptcp_rmem_uncharge(sk, len);
>>   }
>>   
>> -static void mptcp_set_owner_r(struct sk_buff *skb, struct sock *sk)
>> +void mptcp_set_owner_r(struct sk_buff *skb, struct sock *sk)
>>   {
>>   	skb_orphan(skb);
>>   	skb->sk = sk;
>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>> index a9708a2eb2bc..9c46e802a73a 100644
>> --- a/net/mptcp/protocol.h
>> +++ b/net/mptcp/protocol.h
>> @@ -842,6 +842,9 @@ bool mptcp_userspace_pm_active(const struct mptcp_sock *msk);
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
>> index 07dd23d0fe04..c48143bff114 100644
>> --- a/net/mptcp/subflow.c
>> +++ b/net/mptcp/subflow.c
>> @@ -307,6 +307,46 @@ static struct dst_entry *subflow_v4_route_req(const struct sock *sk,
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
>> +	/* <evenutally clear tstamp_ok, as needed depending on cookie size> */
>> +	if (foc)
>> +		ireq->tstamp_ok = 0;
> I guess you really need to check the cookie size, too? If the cookie
> size is small enough, stripping the timestamp should not be needed.
> Also you can move the above 2 lines in
> subflow_fastopen_send_synack_set_params()


It seems I should not move them into set_params()... As foc check is 
performed outside

If I move the foc check into "if", no metter how I modify it : "foc != 
NULL" or " for != -1", it doesn't affect the TS.

I suppose I observe this behaviour because of "tcp_conn_request()" 
starting from line 7013: tcp_input.c - net/ipv4/tcp_input.c - Linux 
source code (v5.19.10) - Bootlin 
<https://elixir.bootlin.com/linux/latest/source/net/ipv4/tcp_input.c#L7013>


I propably should keep "foc" check outside "if" statement.

> Cheers,
>
> Paolo
>
>
