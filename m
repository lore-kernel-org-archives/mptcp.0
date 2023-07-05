Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310591FA3
	for <mptcp@lists.linux.dev>; Wed,  5 Jul 2023 08:19:28 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-51d7f350758so8139715a12.3
        for <mptcp@lists.linux.dev>; Wed, 05 Jul 2023 01:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1688545167; x=1691137167;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y7pO9p8EJO8S0FyuIPgAK8ll5ga69GbpMHNTXDdaUsg=;
        b=r562uRBUEfu2mpFSOZUYJrEEtfesL45MR+qmLxPxjVpVpyQR/cbt71cYx8D83UP1aR
         joANpa/YoycczvyuaSSDhv8+GIL/6DL2CDvPHmeVyic6fIBitMpxVUmtPN9h1HRq3gxP
         JoHYyJj2n7yNdJHkaDQe8Rxv6VYBh6lBiTYXwQ6b0dbT2hWoIFEoBeUDw9D/tcbXzy3W
         n15zujsU53aK0bxONdJpgu6+HevRASItKYDj3O3/t1hNMNNGFigZrIkfWfA3gPQL20P3
         2CcP5FCQKzPQwvJnrvSGhaEPiLvo6ezHe3MgEiBULR6sTOdH4awzcmV/c+BS0a4nhtTz
         E3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688545167; x=1691137167;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7pO9p8EJO8S0FyuIPgAK8ll5ga69GbpMHNTXDdaUsg=;
        b=U1U6AZOloiJZD25A3wbfyQiGEc2LQy2znduJ2MtK2mJWfUUmmOsVawzrCU4gnGLqOB
         7U5mm/7RkRzjxo4dBsJ8ByD/eEeTKKBMVuWUCJhLHrVzlQJOPqJ3qkJguTHYqf2eqTD9
         V1W2vTJ1HoPcEiK+2vvkNTHHLZ7B0mBpSoiodNITQlBBMKee1UOkrCuWzxwHdr34uJNW
         9mFAY/BdPKkAWyq6fMvx3D8tkYNhrm1ylT/ZGU0AYrQ8q5SMrB8t02FjLkx8wk7Moj6q
         IwmHQyq068dH9vfSOVm8tYUo/QZxDKs/sjUwBO6nCpLGmqyi2ySZ7Erx4c7zFirctq1n
         PGrA==
X-Gm-Message-State: ABy/qLaJdF6Ynxivf5XDgxHz54HPWG8QpqGBQvSM+q14IHcHw46wH6T6
	DyPwx4O4KlQtS/lo9VV6y4+4bw==
X-Google-Smtp-Source: APBJJlHCNwVwEwhnCMJmxgnNjF8NhLI1APLpyifTGJ9AblTzLWln66HSumSG+18uZBynR0oVJ6v4hQ==
X-Received: by 2002:a17:907:1742:b0:991:f489:3d24 with SMTP id lf2-20020a170907174200b00991f4893d24mr10918026ejc.32.1688545166819;
        Wed, 05 Jul 2023 01:19:26 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:e210:4cad:4e78:3692? ([2a02:578:8593:1200:e210:4cad:4e78:3692])
        by smtp.gmail.com with ESMTPSA id a18-20020a1709063a5200b00988f168811bsm14274181ejf.135.2023.07.05.01.19.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 01:19:26 -0700 (PDT)
Message-ID: <cd468cb6-04a3-fe8c-789a-e7c3edb8b276@tessares.net>
Date: Wed, 5 Jul 2023 10:19:25 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH mptcp-next 2/4] bpf: Add bpf_mptcpify helper
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
References: <cover.1688004307.git.geliang.tang@suse.com>
 <53359d2572fdd676206c35d29e823e9dffd5e9f6.1688004307.git.geliang.tang@suse.com>
 <72dce095-9e4e-b9e2-0ce8-dfcfe58f7ed2@tessares.net>
 <20230703065411.GA22455@bogon>
 <75889293-09ec-a3e6-877d-c67154e36b74@tessares.net>
 <20230705081548.GA17311@bogon>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20230705081548.GA17311@bogon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 05/07/2023 10:15, Geliang Tang wrote:
> On Mon, Jul 03, 2023 at 02:58:33PM +0200, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 03/07/2023 08:54, Geliang Tang wrote:
>>> On Thu, Jun 29, 2023 at 07:43:50PM +0200, Matthieu Baerts wrote:
>>>> On 29/06/2023 04:12, Geliang Tang wrote:
>>>>> diff --git a/net/core/filter.c b/net/core/filter.c
>>>>> index 968139f4a1ac..e439f8b5f203 100644
>>>>> --- a/net/core/filter.c
>>>>> +++ b/net/core/filter.c
>>>>> @@ -11587,6 +11587,24 @@ const struct bpf_func_proto bpf_skc_to_mptcp_sock_proto = {
>>>>>  	.ret_btf_id	= &btf_sock_ids[BTF_SOCK_TYPE_MPTCP],
>>>>>  };
>>>>>  
>>>>> +BPF_CALL_1(bpf_mptcpify, struct sock *, sk)
>>>>> +{
>>>>> +	if (sk && sk_fullsock(sk) && sk->sk_protocol == IPPROTO_TCP) {
>>>>> +		sk->sk_protocol = IPPROTO_MPTCP;
>>>>> +		return (unsigned long)sk;
>>>>> +	}
>>>>
>>>> How do we ensure such modifications are done at the right moment? I
>>>> mean: we can only change the protocol ID in very few places, before even
>>>> creating the socket (__sock_create()?). If we change it after, we will
>>>> break stuff: tcp ops, security labels, etc.
>>>
>>> You're right, Matt, we need to do the modifications at the very beginning
>>> of sys_socket(). In v3, a new wrapper socket_create() is added, it's the
>>> right place to do the modifications.
>>
>> Thank you for this v3 and for your replies: it is clearer with your replies!
>>
>> I hope such wrapper can be accepted upstream :)
> 
> Hi Matt,
> 
> I just sent a v4, adding hooks in __sock_create(), instead of adding a
> wrapper. I think v4 is much more acceptable by upstream.

Thank you for your reply. Yes, I think the v4 is more acceptable.

>> It is then important to fail if bpf_mptcpify() is not executed at the
>> beginning of this new "socket_create()" wrapper. Will it be the case?
>>
>> I guess the verifier will make sure bpf_mptcpify() is only called with a
>> function having "struct socket_args" as first argument so "by accident",
>> it will only be bpf_mptcpify(), right? Maybe there is a way to clearly
>> mark that bpf_mptcpify() cannot be called elsewhere? Or make sure it
>> fails if the socket has already been created? (maybe that's something we
>> need to ask to BPF devs)
>>
>> One last thing: in your v3, I think you restrict the conversion to IPv4
>> only sockets, no?
>>
>>   (args->family == AF_INET || args->family == AF_INET6)
> 
> I updated this in v4.

Thanks!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
