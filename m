Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9617C
	for <mptcp@lists.linux.dev>; Wed, 21 Sep 2022 04:15:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1663733732; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=WEJhvO2K2zVqN2K40TRmJ5yncXQYF/J/o2e50HvXIFc0FHKh+ahl+Nuqzpz5j+R9wdxkIr9S/UhU2VEFxgLY1g9B0gNvmwle/Yu3oFyxGdcgfALM5JHVwj04/MKFmVocqWS8Y5xnV+RyuqRKg58kDlIaKWXOh5RNWYp5T4DlGzo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1663733732; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=ByW+n0CBSKlHKGzqbZYlRGezgMzz8VJ1NBIS1iELQkE=; 
	b=NNyZV28ryHIqJMO9EbsEMV8NSoi/PWFq4q2nvdHS4//zdoqp0nr6DGeiaPvhHMOuh9ndZs+ulmGzAEv10s4+nipuK2fBZ6QTJwz7r/W10Adques8miHLB7S1N3xN+/90b6xg86IfP4d2dC4OdIEFAUjotE9QzxpHgP5sBH8G3n4=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663733732;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=ByW+n0CBSKlHKGzqbZYlRGezgMzz8VJ1NBIS1iELQkE=;
	b=NMCYAEOzJRIVSBoF7NUIZ8/JhpouWIYzk/2Oz+t2SdBaLtKsfBQPeH0wWOJYkHCA
	QHN9T3X4z1v4Jyrjj2afSQcOMekZ3aHaQsvzolTJH+aN/peQUXp0lqT2f2wnUsLHhn0
	bLj9Bt0ar7boscvOGbvq/JC0fPijhbv2njAIxdtM=
Received: from [192.168.1.25] (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1663733729336831.3102962442802; Wed, 21 Sep 2022 06:15:29 +0200 (CEST)
Message-ID: <0242b217-df38-39ba-9c19-995d01ab4919@shytyi.net>
Date: Wed, 21 Sep 2022 06:15:28 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC PATCH mptcp-next v8 4/7] mptfo variables for msk, options.
 Fix loop retrans
Content-Language: fr
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <20220920125243.2880-1-dmytro@shytyi.net>
 <20220920125243.2880-5-dmytro@shytyi.net>
 <a4d7a03d006a9379111cb2193bd2d73d072429b9.camel@redhat.com>
From: Dmytro Shytyi <dmytro@shytyi.net>
In-Reply-To: <a4d7a03d006a9379111cb2193bd2d73d072429b9.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External


On 9/20/2022 4:56 PM, Paolo Abeni wrote:
> On Tue, 2022-09-20 at 14:52 +0200, Dmytro Shytyi wrote:
>> Introduce mptfo variables for msk and options.
>> Also fix the infinite retransmissions in the end of second session.
> I think the above sentence belongs more the changelog than to the
> commit message itself.

Fixed in v9.


>> The variable 2nd ack received in struct mptcp_options_received identifies the
>> received ack on the listener side during 3way handshake in mptfo context
>> and miningless alone if used alone. It is further used(checked)
>> in conjunction in the same "if" statement with variable is_mptfo
>> from struct mptcp_sock.
>>
>> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
>> ---
>>   net/mptcp/fastopen.c | 14 ++++++++++++++
>>   net/mptcp/options.c  |  4 ++++
>>   net/mptcp/protocol.h |  6 +++++-
>>   3 files changed, 23 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
>> index 9ef49a2d2ea2..92885e459f93 100644
>> --- a/net/mptcp/fastopen.c
>> +++ b/net/mptcp/fastopen.c
>> @@ -30,3 +30,17 @@ int mptcp_setsockopt_sol_tcp_fastopen(struct mptcp_sock *msk, sockptr_t optval,
>>   
>>   	return ret;
>>   }
>> +
>> +void mptcp_gen_msk_ackseq_fastopen(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
>> +				   struct mptcp_options_received mp_opt)
>> +{
>> +	u64 ack_seq;
>> +
>> +	msk->can_ack = true;
>> +	msk->remote_key = mp_opt.sndr_key;
> likely the above two statements need WRITE_ONCE() annotation.

I have added in v9 WRITE_ONCE() to the above two statements.


> Additionally it's better to add some safeguards here:
> - ssk should be in TCP_SYN_RECV state - to be verified, it's guess and
> I haven't check it yet.
> - msk should be in the same state of the ssk subflow.
>
>> +	mptcp_crypto_key_sha(msk->remote_key, NULL, &ack_seq);
>> +	ack_seq++;
>> +	WRITE_ONCE(msk->ack_seq, ack_seq);
>> +	pr_debug("ack_seq=%llu sndr_key=%llu", msk->ack_seq, mp_opt.sndr_key);
>> +	atomic64_set(&msk->rcv_wnd_sent, ack_seq);
>> +}
>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>> index 30d289044e71..8852a13cfe62 100644
>> --- a/net/mptcp/options.c
>> +++ b/net/mptcp/options.c
>> @@ -91,6 +91,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
>>   			ptr += 8;
>>   		}
>>   		if (opsize >= TCPOLEN_MPTCP_MPC_ACK) {
>> +			mp_opt->hns_2nd_ack_rcvd = 1;
> Not needed, see below...


Removed in v9

>>   			mp_opt->rcvr_key = get_unaligned_be64(ptr);
>>   			ptr += 8;
>>   		}
>> @@ -1124,6 +1125,9 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
>>   		return sk->sk_state != TCP_CLOSE;
>>   
>>   	if (unlikely(mp_opt.suboptions != OPTION_MPTCP_DSS)) {
>> +		if (mp_opt.suboptions & OPTIONS_MPTCP_MPC && mp_opt.hns_2nd_ack_rcvd && msk->is_mptfo)
> You can simply check for:
>
> 		if (mp_opt.suboptions & OPTIONS_MPTCP_MPC_ACK) && msk->is_mptfo)


Removed in v9

>> +			mptcp_gen_msk_ackseq_fastopen(msk, subflow, mp_opt);
>> +
>>   		if ((mp_opt.suboptions & OPTION_MPTCP_FASTCLOSE) &&
>>   		    msk->local_key == mp_opt.rcvr_key) {
>>   			WRITE_ONCE(msk->rcv_fastclose, true);
>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>> index 57596cdfb1f9..3b9a349a7080 100644
>> --- a/net/mptcp/protocol.h
>> +++ b/net/mptcp/protocol.h
>> @@ -155,7 +155,8 @@ struct mptcp_options_received {
>>   		echo:1,
>>   		backup:1,
>>   		deny_join_id0:1,
>> -		__unused:2;
>> +		__unused:1;
>> +	u8	hns_2nd_ack_rcvd:1;
> ... again not needed, see above ;)
Removed in v9
>>   	u8	join_id;
>>   	u64	thmac;
>>   	u8	hmac[MPTCPOPT_HMAC_LEN];
>> @@ -282,6 +283,7 @@ struct mptcp_sock {
>>   	bool		use_64bit_ack; /* Set when we received a 64-bit DSN */
>>   	bool		csum_enabled;
>>   	bool		allow_infinite_fallback;
>> +	bool		is_mptfo;
>>   	u8		mpc_endpoint_id;
>>   	u8		recvmsg_inq:1,
>>   			cork:1,
>> @@ -842,6 +844,8 @@ int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr, int addr_l
>>   // Fast Open Mechanism functions begin
>>   int mptcp_setsockopt_sol_tcp_fastopen(struct mptcp_sock *msk, sockptr_t optval,
>>   				      unsigned int optlen);
>> +void mptcp_gen_msk_ackseq_fastopen(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
>> +				   struct mptcp_options_received mp_opt);
>>   // Fast Open Mechanism functions end
>>   
>>   static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)

Best,

Dmytro.

