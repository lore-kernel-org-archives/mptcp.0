Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8977C
	for <mptcp@lists.linux.dev>; Wed, 21 Sep 2022 04:20:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1663734016; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Ix5KEz7mxBxSRrOkD58BClDjKXTbeczA4C8Nrbnvct0SLYUuFAQ1+H2ZUfXnng8ec6R1eE1IpQfxll2ftMo7xK7XpluKJ317i8EGdd570TtHC6LJJO7msYapi9WpXJYQfOA2hodF1h6/R1GcdK6SHdGN9hspcuyFcowyIVWD5Ds=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1663734016; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=EFCbLUEh7i+5KrNu5/NShqXW/M6Sao5E53s/HW7NmhE=; 
	b=ID/dqRv/D48oqK4i8jIfV+O+sqoAJkBdzwEKbTcc9LhUKU+8zgcUjbarxyF+Zy3CjGN2D8jTZx07L8Nd/MrKuYhnqLJR47y47Tt4k4SJzrYH5RyYdJqMg0NDjXwcjQRdRn2mFBQtokhuzMQRrl8SGP9d/4KqJWVxj9uRU8KVJOU=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663734016;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=EFCbLUEh7i+5KrNu5/NShqXW/M6Sao5E53s/HW7NmhE=;
	b=ZGQ2h80p9tErZsbWUiRUR3YbSQmSQhoVDJ4mWJQfO1JCA99Av3RH8rrgpMPaDGGl
	9eh/RD+Hja73HKxPzIJJ10HxXZrTJyzI9nNeNNnp20Yz72uSvPIolpznBgo/2kJKCJg
	s83GkXz0vqTogtGxwLHN7AATQoLbVOVPv4RFr6Gc=
Received: from [192.168.1.25] (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1663734014940676.8465004934068; Wed, 21 Sep 2022 06:20:14 +0200 (CEST)
Message-ID: <809542cd-6f1b-fe2e-e3e3-f667bcd02a90@shytyi.net>
Date: Wed, 21 Sep 2022 06:20:13 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC PATCH mptcp-next v8 3/7] reuse tcp_sendmsg_fastopen()
Content-Language: fr
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <20220920125243.2880-1-dmytro@shytyi.net>
 <20220920125243.2880-4-dmytro@shytyi.net>
 <5bebaee5b0a6b183603d8c8428a01750b41df515.camel@redhat.com>
From: Dmytro Shytyi <dmytro@shytyi.net>
In-Reply-To: <5bebaee5b0a6b183603d8c8428a01750b41df515.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External


On 9/20/2022 4:36 PM, Paolo Abeni wrote:
> On Tue, 2022-09-20 at 14:52 +0200, Dmytro Shytyi wrote:
>> In the following patches we will reuse modified tcp_sendmsg_fastopen().
>> We call it from mptcp_sendmsg().
>>
>> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
>> ---
>>   include/net/tcp.h    |  3 +++
>>   net/ipv4/tcp.c       | 18 +++++++++++++-----
>>   net/mptcp/protocol.c | 11 +++++++++--
>>   3 files changed, 25 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/net/tcp.h b/include/net/tcp.h
>> index 735e957f7f4b..a7d49e42470a 100644
>> --- a/include/net/tcp.h
>> +++ b/include/net/tcp.h
>> @@ -1754,6 +1754,9 @@ struct sock *tcp_try_fastopen(struct sock *sk, struct sk_buff *skb,
>>   			      struct request_sock *req,
>>   			      struct tcp_fastopen_cookie *foc,
>>   			      const struct dst_entry *dst);
>> +int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
>> +			 int *copied, size_t size,
>> +			 struct ubuf_info *uarg);
>>   void tcp_fastopen_init_key_once(struct net *net);
>>   bool tcp_fastopen_cookie_check(struct sock *sk, u16 *mss,
>>   			     struct tcp_fastopen_cookie *cookie);
>> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
>> index 9251c99d3cfd..d10a3cdae220 100644
>> --- a/net/ipv4/tcp.c
>> +++ b/net/ipv4/tcp.c
>> @@ -280,6 +280,9 @@
>>   #include <asm/ioctls.h>
>>   #include <net/busy_poll.h>
>>   
>> +#include <net/mptcp.h>
>> +#include "../mptcp/protocol.h"
>> +
>>   /* Track pending CMSGs. */
>>   enum {
>>   	TCP_CMSG_INQ = 1,
>> @@ -1162,9 +1165,9 @@ void tcp_free_fastopen_req(struct tcp_sock *tp)
>>   	}
>>   }
>>   
>> -static int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
>> -				int *copied, size_t size,
>> -				struct ubuf_info *uarg)
>> +int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
>> +			 int *copied, size_t size,
>> +			 struct ubuf_info *uarg)
>>   {
>>   	struct tcp_sock *tp = tcp_sk(sk);
>>   	struct inet_sock *inet = inet_sk(sk);
>> @@ -1197,8 +1200,13 @@ static int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
>>   		}
>>   	}
>>   	flags = (msg->msg_flags & MSG_DONTWAIT) ? O_NONBLOCK : 0;
>> -	err = __inet_stream_connect(sk->sk_socket, uaddr,
>> -				    msg->msg_namelen, flags, 1);
>> +	if (!sk_is_mptcp(sk))
>> +		err = __inet_stream_connect(sk->sk_socket, uaddr,
>> +					    msg->msg_namelen, flags, 1);
>> +	else
>> +		err = mptcp_stream_connect(sk->sk_socket, uaddr,
>> +					   msg->msg_namelen, msg->msg_flags);
>
> I guess the goal of the above change is let mptcp_stream_connect()
> update the msk socket status, is that correct?
>
> However there are a few problems with lock: you must acquite the
> subflow socket lock before calling tcp_sendmsg_fastopen() - or will see
> subflow state corruption - but that in turn will cause a deadlock as
>   mptcp_stream_connect() acquires the msk socket lock and then the
> subflow socket lock.
>
> I think it's better leave the tcp_sendmsg_fastopen() body unchanged...


In v9 I still modify the tcp_sendmsg_fastopen() a little bit with adding 
some locks.

>> +
>>   	/* fastopen_req could already be freed in __inet_stream_connect
>>   	 * if the connection times out or gets rst
>>   	 */
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index 470045793181..8cf307e4e59c 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -1673,9 +1673,16 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>>   	long timeo;
>>   
>>   	/* we don't support FASTOPEN yet */
>> -	if (msg->msg_flags & MSG_FASTOPEN)
>> -		return -EOPNOTSUPP;
>> +	if (msg->msg_flags & MSG_FASTOPEN) {
>> +		struct socket *ssock = __mptcp_nmpc_socket(msk);
> ... acquire the subflow socket lock here...
Some locks are acquired in v9.
>>   
>> +		if (ssock) {
>> +			int copied_syn_fastopen = 0;
>> +
>> +			ret = tcp_sendmsg_fastopen(ssock->sk, msg, &copied_syn_fastopen, len, NULL);
>> +			copied += copied_syn_fastopen;
>> +		}
> ... and additionally handle the sock state update here. Possibly you
> can encapsulate all the fastopen code in a new function - say
> __mptcp_sendmsg_fastopen(), as it will be called under the msk socket
> lock.
>
>
> Side note: you should enter the fastopen branch even when
> inet_sk(ssock->sk)->defer_connect is set

I tried to add this (defer_connect) in v9, but didn't check if it works.


> Cheers,
>
> Paolo

Best,

Dmytro.

