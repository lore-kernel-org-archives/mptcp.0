Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B04128ED
	for <mptcp@lists.linux.dev>; Thu, 23 Feb 2023 15:40:30 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id t15so11119548wrz.7
        for <mptcp@lists.linux.dev>; Thu, 23 Feb 2023 07:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nOfhFPejgBNTc7kmzv13kHv+rr3AVJc/vzejRNB1aWw=;
        b=Lwfc4LcpwRTl9dtafkoW5bcwxdfQ6SygL1vt2labml512vTcvbkGkp5cZ6YE5Sn316
         9/QG6I/z/hsOReOAfcvPoyAREU9nPFtk3dsfw6rC3j4NYpjFHkVVtamFRtNhoI508xqj
         NjJDhlZrZMmNXr/saW9HaMcrfH4PWP3mi1fCC0+DHrY9gEuaIDmg1oBYEtrTZDtIeii7
         W1L69V/DB9GMdPsQ7cTGPdoU6fAuGKHI6R/U7dIRfxrFuaeB5s4uPeX8fMtN+DG7XMzD
         VLvgcri2hE2YNKIKZd57EuZ72aa9BG8Q+0n6u2Rp+H77qEYLdROx4Lq9xsxo1SHdxrZM
         3APw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nOfhFPejgBNTc7kmzv13kHv+rr3AVJc/vzejRNB1aWw=;
        b=VdXXd7xHUBQxb5nmnHjCQq4/sLIAr1uBNLtzW7uZ0z0QsxaswADuuSVnm299fySh99
         tlncV1Bs5YXA60cEFZC04WoTTQdjFo28C9N4ymfs1S+wfsabmoyaIZ55wtL3avvkBvRb
         w16sudY5jBCpwljrpVRzRzAGNIhvWIfgSncVnFG2rrSNSB19tdup1v1ZiI6toOhh6BrP
         EVp1OA8e60MePXfXFZHt/jFR2L/9xu18nRpFl/GthOtJFJqYo9VbNjN6w0xEe3qOhQeL
         aGBVWYhfYIKkMOuvY5gkUi9nfZ4ITlN10I/T9e3xWiamZrRkpwWr2x4YDKkD6ClV5tYA
         RKPg==
X-Gm-Message-State: AO0yUKVC6Aik+sfHydohiUVLYus2pn17wPWzOl1eUlmi0xOdji4iiUoq
	23d5Ezj76wVePcp+679vHZJvFxaC8WHV/mMXdds=
X-Google-Smtp-Source: AK7set/ig3+wONhLsvriVosTnuoCUj6pTEl33/VfJJg0rZIpJa/I2KzJrnsCQ7s+CNGzuVHTNzyg+A==
X-Received: by 2002:a5d:6f15:0:b0:2c5:51a5:9ef8 with SMTP id ay21-20020a5d6f15000000b002c551a59ef8mr9274939wrb.8.1677166828467;
        Thu, 23 Feb 2023 07:40:28 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:b5a0:3898:2dad:3d15? ([2a02:578:8593:1200:b5a0:3898:2dad:3d15])
        by smtp.gmail.com with ESMTPSA id a9-20020a5d5709000000b002be099f78c0sm10888855wrv.69.2023.02.23.07.40.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 07:40:28 -0800 (PST)
Message-ID: <6be644a3-e0d5-8da0-4b93-8c12ae961a04@tessares.net>
Date: Thu, 23 Feb 2023 16:40:27 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH mptcp-net 1/2] mptcp: avoid setting TCP_CLOSE state twice
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <20230221-mptcp-warn-tcp-done-close-v1-0-d248242b29b6@tessares.net>
 <20230221-mptcp-warn-tcp-done-close-v1-1-d248242b29b6@tessares.net>
 <5634a811ff8da65d6063ec03218a6462f5a189e7.camel@redhat.com>
 <2c17ceb5-09c8-18c2-24e4-cd094d5933bf@tessares.net>
 <b467799eb9dea501f326106615b5b34b5c917a93.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <b467799eb9dea501f326106615b5b34b5c917a93.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 23/02/2023 16:00, Paolo Abeni wrote:
> On Wed, 2023-02-22 at 16:25 +0100, Matthieu Baerts wrote:
>> Hi Paolo,
>>
>> On 22/02/2023 15:32, Paolo Abeni wrote:
>>> On Tue, 2023-02-21 at 18:54 +0100, Matthieu Baerts wrote:
>>>> tcp_set_state() is called from tcp_done() already.
>>>>
>>>> There is then no need to first set the state to TCP_CLOSE, then call
>>>> tcp_done().
>>>>
>>>> Fixes: d582484726c4 ("mptcp: fix fallback for MP_JOIN subflows")
>>>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/362
>>>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>>>> ---
>>>>  net/mptcp/subflow.c | 1 -
>>>>  1 file changed, 1 deletion(-)
>>>>
>>>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>>>> index 28c64811a8af..a36d1b1088d7 100644
>>>> --- a/net/mptcp/subflow.c
>>>> +++ b/net/mptcp/subflow.c
>>>> @@ -406,7 +406,6 @@ void mptcp_subflow_reset(struct sock *ssk)
>>>>  	/* must hold: tcp_done() could drop last reference on parent */
>>>>  	sock_hold(sk);
>>>>  
>>>> -	tcp_set_state(ssk, TCP_CLOSE);
>>>>  	tcp_send_active_reset(ssk, GFP_ATOMIC);
>>>>  	tcp_done(ssk);
>>>>  	if (!test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &mptcp_sk(sk)->flags) &&
>>>>
>>>
>>> I think this one could be squashed to:
>>>
>>> mptcp: fix possible deadlock in subflow_error_report
>>>
>>> WDYT?
>>
>> Thank you for your reply!
>>
>> I'm a bit confused: the commit you mention ("mptcp: fix possible
>> deadlock in subflow_error_report"):
>> - modifies subflow_error_report() function
>> - fixes 15cc10453398 ("mptcp: deliver ssk errors to msk")
>>
>> While my patch here:
>> - modifies mptcp_subflow_reset() function
>> - fixes: d582484726c4 ("mptcp: fix fallback for MP_JOIN subflows")
>>
>> They seem to fix different issues: better to keep them separated, no?
> 
> I'm sorry I picked the wrong commit.
> 
> What I meant is that I thought the above change could stay together
> with the commit introducing:
> 
> 	if (ssk->sk_state == TCP_CLOSE)
> 		return;
> 
> in mptcp_subflow_reset() - that is "mptcp: refactor passive socket
> initialization" unless I'm wrong again.

All good, thank you for the explanations, now I see the link!

> Reading again the code and the git history, I now agree it's better
> keep this change separate.

Great!

Can I interpret that as a "Acked-by" for the small series? :-)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
