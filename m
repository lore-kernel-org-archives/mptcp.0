Received: from m12-11.163.com (m12-11.163.com [220.181.12.11])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7097B70
	for <mptcp@lists.linux.dev>; Thu, 10 Jun 2021 03:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=43f2V
	GAdTB7CN92yvk++/sIBH4BNVrXgBgdY2EL5xRE=; b=IehsmyjRZbYwb/B6HR9iw
	1lwnqzYRDo1Y8Ny77YLuBI8Z3o9rRosJO5gGK7rqqDLHxnzzfppD9Y03OftqrtGl
	ziVq3+UXMXAjUiEwQ5WnSFdNifef6UYe21tDQk70q1zDuHhya6/g4j03Z58z/cgV
	LHJHmPci0TKmGbN6IE2NYQ=
Received: from [192.168.16.78] (unknown [110.86.5.93])
	by smtp7 (Coremail) with SMTP id C8CowADX5Jz6h8FgKI7FhA--.147S2;
	Thu, 10 Jun 2021 11:33:16 +0800 (CST)
Subject: Re: [PATCH 3/3] mptcp: fix syncookie process if mptcp can not_accept
 new subflow
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Florian Westphal <fw@strlen.de>
References: <1034de3d-5528-ea65-6deb-8a67955f1042@163.com>
 <b0a8abf413fa78323f58be466015d665a1bc6f84.camel@redhat.com>
From: Jianguo Wu <wujianguo106@163.com>
Message-ID: <d37acdc6-7559-f15a-cac8-270af86c541b@163.com>
Date: Thu, 10 Jun 2021 11:33:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <b0a8abf413fa78323f58be466015d665a1bc6f84.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:C8CowADX5Jz6h8FgKI7FhA--.147S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXr43KrWkWrW7WFW3Wr47twb_yoW5KF45pF
	48tr47trn5JFyxGFySvF4UXr1Sq3yFyr43JrW5ta43Arn8urn3GryrKr1a9FW7CFs5Ca4F
	vr4Iq3WqvF1j9aDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jgwIDUUUUU=
X-Originating-IP: [110.86.5.93]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/xtbB+AStkF2MZMzGBgAAs4

Hi Paolo,

On 2021/6/9 22:18, Paolo Abeni wrote:
> Hello,
> 
> On Wed, 2021-06-09 at 18:39 +0800, Jianguo Wu wrote:
>> From: Jianguo Wu <wujianguo@chinatelecom.cn>
>>
>> Lots of "TCP: tcp_fin: Impossible, sk->sk_state=7" in client side when doing stress testing.
>> There are at least two cases may trigger this warning:
>> 1. mptcp is in syncookie, and server recv MP_JOIN SYN request, in subflow_check_req(),
>>    the mptcp_can_accept_new_subflow() return false, so subflow_init_req_cookie_join_save()
>>    isn't called, i.e. not store the data present in the MP_JOIN syn request and the random
>>    nonce in hash table - join_entries[], but still send synack. When recv 3rd-ack,
>>    mptcp_token_join_cookie_init_state() will return false, and 3rd-ack is dropped, then if mptcp
>>    conn is closed by client, client will send a DATA_FIN and a MPTCP FIN, the DATA_FIN doesn't have
>>    MP_CAPABLE or MP_JOIN, so mptcp_subflow_init_cookie_req() will return 0, and pass the cookie check,
>>    MP_JOIN request is fallback to normal TCP. Server will send a TCP FIN if closed, in client side,
>>    when process TCP FIN, it will do reset, the code path is:
>>      tcp_data_queue()->mptcp_incoming_options()->check_fully_established()->mptcp_subflow_reset().
>>    mptcp_subflow_reset() will set sock state to TCP_CLOSE, so tcp_fin will hit TCP_CLOSE, and print the warning.
>> 2. mptcp is in syncookie, and server recv 3rd-ack, in mptcp_subflow_init_cookie_req(), mptcp_can_accept_new_subflow()
>>    return false, and subflow_req->mp_join is not set to 1, so in subflow_syn_recv_sock() will not reset the MP_JOIN
>>    subflow, but fallback to normal TCP, and then the same thing happens when server will send a TCP FIN if closed.
> 
> Minor nit: each line in the commit message should not be longer than 72
> chars.
> 

Ok, I will be more carefully with this.

>> For case1, subflow_check_req() return -EPERM, then tcp_conn_request() will drop MP_JOIN SYN.
>> For case2, let subflow_syn_recv_sock() do mptcp_can_accept_new_subflow() check, and do fatal fallback, send reset.
> 
> Possibly worthy 2 separate patches.
> 
> pktdrill test cases would help.
> 
> I still have to wrap my mind on the above, still I have a relevant
> comment, see below...
> 
>> And do sanity check in tcp_data_queue().
>>
>> Fixes: 9466a1ccebbe("mptcp: enable JOIN requests even if cookies are in use")
>> Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
>> ---
>>  net/ipv4/tcp_input.c | 7 ++++++-
>>  net/mptcp/subflow.c  | 6 +++---
>>  2 files changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
>> index 7d5e59f..537f24a 100644
>> --- a/net/ipv4/tcp_input.c
>> +++ b/net/ipv4/tcp_input.c
>> @@ -4941,8 +4941,13 @@ static void tcp_data_queue(struct sock *sk, struct sk_buff *skb)
>>  	bool fragstolen;
>>  	int eaten;
>>
>> -	if (sk_is_mptcp(sk))
>> +	if (sk_is_mptcp(sk)) {
>>  		mptcp_incoming_options(sk, skb);
>> +		if (sk->sk_state == TCP_CLOSE) {
>> +			__kfree_skb(skb);
>> +			return;
>> +		}
>> +	}
> 
> _if_ I read correctly the commit message, this is needed to avoid
> processing FIN packets on
> when check_fully_established()/check_fully_established() causes a
> subflow reset.
> 

Yes

> I think we can handle the above in the MPTCP code - in
> check_fully_established() -  setting:
> 
> 	TCP_SKB_CB(skb)->end_seq = TCP_SKB_CB(skb)->seq;
> 

I will use this.

> so that the following check will drop the pkt:
> 
>>  	if (TCP_SKB_CB(skb)->seq == TCP_SKB_CB(skb)->end_seq) {
>>  		__kfree_skb(skb);
>>
> 
> /P
> 

