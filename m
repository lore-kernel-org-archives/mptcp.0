Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316DE7462
	for <mptcp@lists.linux.dev>; Tue, 20 Sep 2022 15:02:07 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id m3so4226142eda.12
        for <mptcp@lists.linux.dev>; Tue, 20 Sep 2022 08:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=oEgJhIp7jN2UWqt3EOtA9/hSx8GhzimSZp4Mq+PtxCM=;
        b=fnHy36X3OkXIrBWGwU+iXsgRdG+fjee4E/LVOn+tAA6f91rwVI0VdxFIDiVDEftAHj
         1dfkCROWxr/YLjUsoEEvZzUpoD6UUKhXrfIT9HbcmoIHb44FhYMg5bM7nah2wy5Jvb/q
         EYUb4SYT3KeclHWxLZFqcurPUcovIX0O0+IsFfRnU6IQWneDY0ms9L2hbZddaZAzTjtU
         Snqas0oA3nIY5SMNb+LJ+eTkFGSM8y5cxi80jJF6BpLUmQ/6ovY8eeGgR/do6hOxao6J
         NyLY8rZflvkMxGl2qx0sEBeEZeDKwafNgGu696RphCslX83UptsRTJuad1gAqoajuwpa
         KVng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=oEgJhIp7jN2UWqt3EOtA9/hSx8GhzimSZp4Mq+PtxCM=;
        b=ODdMssCDMjSY/mwlUQL5M83M23K1QNgke47oUuP3ZoOv9U2HsZ3rQHjzYcIgPOA7yz
         /I6dka/y3Fy//VtYZ3CMto6va4RkjopC7cKHQhQdu917lHSCNM9+TKuMBbd1XS25xzYt
         jWhhk6YFqDfDxuarV+GM5QETIWrYo7tu3L7/lVdT7Vk5JwLCUnk5hB9jSFHzY7XggG4V
         SSeps2CTWDeuiAQvmPU4kVGmsGnqqWmUH2rwowo8e1CT3xV0LxMMgKc2phzpojv0yL/a
         JAPvlxeAchTSy54oCzPfp9YSALJnOtdMyfrqUDZibA27X8eQyhXJOig+sG7eAs/hs3Kq
         Hw0w==
X-Gm-Message-State: ACrzQf12tY60XhD/HA5Ssvacbr1olRnb+qKZ01yyXbYqFAmYTqCsY2A1
	HKj7cBBOG8BnlATyl6wAYRGf05mxwogl73XG
X-Google-Smtp-Source: AMsMyM4+e4jj5VCCaz/U66zJlgCj8D6EMuxJTjpsbXFmfai417myDpByMrlkflN9yadIN88YoosHeA==
X-Received: by 2002:a05:6402:e9b:b0:454:351c:c222 with SMTP id h27-20020a0564020e9b00b00454351cc222mr7578094eda.216.1663686126094;
        Tue, 20 Sep 2022 08:02:06 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:e5ca:f250:ef0:bd18? ([2a02:578:8593:1200:e5ca:f250:ef0:bd18])
        by smtp.gmail.com with ESMTPSA id u12-20020a50d50c000000b0043bbb3535d6sm165859edi.66.2022.09.20.08.02.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 08:02:05 -0700 (PDT)
Message-ID: <9f63a04a-7213-0757-2475-d09e74cdc54f@tessares.net>
Date: Tue, 20 Sep 2022 17:02:04 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC PATCH mptcp-next v8 3/7] reuse tcp_sendmsg_fastopen()
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, Dmytro Shytyi <dmytro@shytyi.net>,
 mptcp@lists.linux.dev
References: <20220920125243.2880-1-dmytro@shytyi.net>
 <20220920125243.2880-4-dmytro@shytyi.net>
 <5bebaee5b0a6b183603d8c8428a01750b41df515.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <5bebaee5b0a6b183603d8c8428a01750b41df515.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Dmytro,

On 20/09/2022 16:36, Paolo Abeni wrote:
> On Tue, 2022-09-20 at 14:52 +0200, Dmytro Shytyi wrote:
>> In the following patches we will reuse modified tcp_sendmsg_fastopen().
>> We call it from mptcp_sendmsg().
>>
>> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
>> ---
>>  include/net/tcp.h    |  3 +++
>>  net/ipv4/tcp.c       | 18 +++++++++++++-----
>>  net/mptcp/protocol.c | 11 +++++++++--
>>  3 files changed, 25 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/net/tcp.h b/include/net/tcp.h
>> index 735e957f7f4b..a7d49e42470a 100644
>> --- a/include/net/tcp.h
>> +++ b/include/net/tcp.h
>> @@ -1754,6 +1754,9 @@ struct sock *tcp_try_fastopen(struct sock *sk, struct sk_buff *skb,
>>  			      struct request_sock *req,
>>  			      struct tcp_fastopen_cookie *foc,
>>  			      const struct dst_entry *dst);
>> +int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
>> +			 int *copied, size_t size,
>> +			 struct ubuf_info *uarg);
>>  void tcp_fastopen_init_key_once(struct net *net);
>>  bool tcp_fastopen_cookie_check(struct sock *sk, u16 *mss,
>>  			     struct tcp_fastopen_cookie *cookie);
>> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
>> index 9251c99d3cfd..d10a3cdae220 100644
>> --- a/net/ipv4/tcp.c
>> +++ b/net/ipv4/tcp.c
>> @@ -280,6 +280,9 @@
>>  #include <asm/ioctls.h>
>>  #include <net/busy_poll.h>
>>  
>> +#include <net/mptcp.h>
>> +#include "../mptcp/protocol.h"
>> +
>>  /* Track pending CMSGs. */
>>  enum {
>>  	TCP_CMSG_INQ = 1,
>> @@ -1162,9 +1165,9 @@ void tcp_free_fastopen_req(struct tcp_sock *tp)
>>  	}
>>  }
>>  
>> -static int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
>> -				int *copied, size_t size,
>> -				struct ubuf_info *uarg)
>> +int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
>> +			 int *copied, size_t size,
>> +			 struct ubuf_info *uarg)
>>  {
>>  	struct tcp_sock *tp = tcp_sk(sk);
>>  	struct inet_sock *inet = inet_sk(sk);
>> @@ -1197,8 +1200,13 @@ static int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
>>  		}
>>  	}
>>  	flags = (msg->msg_flags & MSG_DONTWAIT) ? O_NONBLOCK : 0;
>> -	err = __inet_stream_connect(sk->sk_socket, uaddr,
>> -				    msg->msg_namelen, flags, 1);
>> +	if (!sk_is_mptcp(sk))
>> +		err = __inet_stream_connect(sk->sk_socket, uaddr,
>> +					    msg->msg_namelen, flags, 1);
>> +	else
>> +		err = mptcp_stream_connect(sk->sk_socket, uaddr,
>> +					   msg->msg_namelen, msg->msg_flags);
> 
> 
> I guess the goal of the above change is let mptcp_stream_connect()
> update the msk socket status, is that correct?
> 
> However there are a few problems with lock: you must acquite the
> subflow socket lock before calling tcp_sendmsg_fastopen() - or will see
> subflow state corruption - but that in turn will cause a deadlock as 
>  mptcp_stream_connect() acquires the msk socket lock and then the
> subflow socket lock.
> 
> I think it's better leave the tcp_sendmsg_fastopen() body unchanged...
> 
>> +
>>  	/* fastopen_req could already be freed in __inet_stream_connect
>>  	 * if the connection times out or gets rst
>>  	 */
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index 470045793181..8cf307e4e59c 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -1673,9 +1673,16 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>>  	long timeo;
>>  
>>  	/* we don't support FASTOPEN yet */
>> -	if (msg->msg_flags & MSG_FASTOPEN)
>> -		return -EOPNOTSUPP;
>> +	if (msg->msg_flags & MSG_FASTOPEN) {
>> +		struct socket *ssock = __mptcp_nmpc_socket(msk);
> 
> ... acquire the subflow socket lock here...
> 
>>  
>> +		if (ssock) {
>> +			int copied_syn_fastopen = 0;
>> +
>> +			ret = tcp_sendmsg_fastopen(ssock->sk, msg, &copied_syn_fastopen, len, NULL);
>> +			copied += copied_syn_fastopen;
>> +		}
> 
> ... and additionally handle the sock state update here. Possibly you
> can encapsulate all the fastopen code in a new function - say
> __mptcp_sendmsg_fastopen(), as it will be called under the msk socket
> lock.
> 
> 
> Side note: you should enter the fastopen branch even when 
> inet_sk(ssock->sk)->defer_connect is set

I think we should better discuss about that at the next meeting because
all items you are asking here is what Benjamin did in [1]:

https://patchwork.kernel.org/project/mptcp/patch/20220908133829.3410092-4-benjamin.hesmans@tessares.net/

The work from Dmytro helped Benjamin to start looking at that and
propose another approach. Before the meeting, we can look at creating a
series focussed on the sending part taking patches from both Benjamin
and Dmytro using Benjamin's approach if that's OK. Of course both Dmytro
and Benjamin will be credited to have worked on that.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
