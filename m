Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290DB2C9E
	for <mptcp@lists.linux.dev>; Thu, 23 Feb 2023 16:56:51 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id j2so11020058wrh.9
        for <mptcp@lists.linux.dev>; Thu, 23 Feb 2023 08:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TZchpCRgF772Uxi9+Ph8c/l7XF/yV1c4tHpxhVkYunU=;
        b=Z0DSdyVBQMIkuYRRtwsjZK/SiSKKtrZC8yZP/09yjQopq6FI8d+VnJkpdU2B/V+ne+
         H3/w8HqcJhtdSu3ZhBlPjIjpK0z3Hjra4OW43avHzCyPEbjRqoB9x4Vy3V4QUe1Ux1J3
         Nn+HCnyKx8E5bVprOSO5zo5qtJWIdx4vbHUDwqOuRRrNMQv7hEMwYe8XPZuXt7wAJJ9s
         zmeoz7ehCR1K2XP4wmQirUPXSw+8NmF+BLZ/0rp7GNFSsUb19vOqeEmeOg34nLykpPGM
         PsUVLPdswato7Zq/jYZuKfb/Gxl4FVuIg96VVn+Yn6CBfaZWKo9XuXzF4Yxsf4kv3SU9
         vH1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TZchpCRgF772Uxi9+Ph8c/l7XF/yV1c4tHpxhVkYunU=;
        b=eyz2ttffb37u3eyXpqJhn2e2o/0pTCASAIHE+L8CG+1NMU3A+tMog8UEvwqybMIsMP
         W7cbzrDumQYn/dbqCB6/O/rQb96PUHGobxkx9PRf12HSMLeRQMCAEkmeNPnj+ThztZsj
         o3lp+NUdItlskFGMO3oiYB5nePZUEnQudGC+sz1MupB1/B8QlK6DeFgrQxVzy3WxbsR3
         zpWMzDGo3dI8MgSZuIU+taZ44KSvwQNJRcm8SiTVtTFrsdGzS6sCv1Hx+LIgnCfeipfU
         jmix/x4zVRKEG1jBjdO9spkjCO8XF4EP7blsMvK3Re2ezit/Rk0Vgrs/RCjVvVyEAFRe
         CN+Q==
X-Gm-Message-State: AO0yUKW5h3I3CUu5I11s7QTwfY3rX3aECPbbKlNUc2CZed1obqapgP59
	HkO+9xe/i32vQrY4Yg8XcKXRnA==
X-Google-Smtp-Source: AK7set/vNEpLNeZBeucBtWJXMnHTUdpzoPUM/OFpmJHxnSpwTnmuOo70UXTlCtA7wKcLLDR1T5OpIw==
X-Received: by 2002:a5d:4952:0:b0:2c6:e861:2a49 with SMTP id r18-20020a5d4952000000b002c6e8612a49mr10287460wrs.59.1677171409909;
        Thu, 23 Feb 2023 08:56:49 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:b5a0:3898:2dad:3d15? ([2a02:578:8593:1200:b5a0:3898:2dad:3d15])
        by smtp.gmail.com with ESMTPSA id e16-20020adfe390000000b002c54c8e70b1sm10770542wrm.9.2023.02.23.08.56.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 08:56:49 -0800 (PST)
Message-ID: <c32fba0c-882a-cb2a-fef7-08447c3d434a@tessares.net>
Date: Thu, 23 Feb 2023 17:56:48 +0100
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
 <6be644a3-e0d5-8da0-4b93-8c12ae961a04@tessares.net>
 <c3f15ab329f7e21fe15dbbd52387ccc8dddd7751.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <c3f15ab329f7e21fe15dbbd52387ccc8dddd7751.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/02/2023 17:38, Paolo Abeni wrote:
> On Thu, 2023-02-23 at 16:40 +0100, Matthieu Baerts wrote:
>> Hi Paolo,
>>
>> On 23/02/2023 16:00, Paolo Abeni wrote:
>>> On Wed, 2023-02-22 at 16:25 +0100, Matthieu Baerts wrote:
>>>> Hi Paolo,
>>>>
>>>> On 22/02/2023 15:32, Paolo Abeni wrote:
>>>>> On Tue, 2023-02-21 at 18:54 +0100, Matthieu Baerts wrote:
>>>>>> tcp_set_state() is called from tcp_done() already.
>>>>>>
>>>>>> There is then no need to first set the state to TCP_CLOSE, then call
>>>>>> tcp_done().
>>>>>>
>>>>>> Fixes: d582484726c4 ("mptcp: fix fallback for MP_JOIN subflows")
>>>>>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/362
>>>>>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>>>>>> ---
>>>>>>  net/mptcp/subflow.c | 1 -
>>>>>>  1 file changed, 1 deletion(-)
>>>>>>
>>>>>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>>>>>> index 28c64811a8af..a36d1b1088d7 100644
>>>>>> --- a/net/mptcp/subflow.c
>>>>>> +++ b/net/mptcp/subflow.c
>>>>>> @@ -406,7 +406,6 @@ void mptcp_subflow_reset(struct sock *ssk)
>>>>>>  	/* must hold: tcp_done() could drop last reference on parent */
>>>>>>  	sock_hold(sk);
>>>>>>  
>>>>>> -	tcp_set_state(ssk, TCP_CLOSE);
>>>>>>  	tcp_send_active_reset(ssk, GFP_ATOMIC);
>>>>>>  	tcp_done(ssk);
>>>>>>  	if (!test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &mptcp_sk(sk)->flags) &&
>>>>>>
>>>>>
>>>>> I think this one could be squashed to:
>>>>>
>>>>> mptcp: fix possible deadlock in subflow_error_report
>>>>>
>>>>> WDYT?
>>>>
>>>> Thank you for your reply!
>>>>
>>>> I'm a bit confused: the commit you mention ("mptcp: fix possible
>>>> deadlock in subflow_error_report"):
>>>> - modifies subflow_error_report() function
>>>> - fixes 15cc10453398 ("mptcp: deliver ssk errors to msk")
>>>>
>>>> While my patch here:
>>>> - modifies mptcp_subflow_reset() function
>>>> - fixes: d582484726c4 ("mptcp: fix fallback for MP_JOIN subflows")
>>>>
>>>> They seem to fix different issues: better to keep them separated, no?
>>>
>>> I'm sorry I picked the wrong commit.
>>>
>>> What I meant is that I thought the above change could stay together
>>> with the commit introducing:
>>>
>>> 	if (ssk->sk_state == TCP_CLOSE)
>>> 		return;
>>>
>>> in mptcp_subflow_reset() - that is "mptcp: refactor passive socket
>>> initialization" unless I'm wrong again.
>>
>> All good, thank you for the explanations, now I see the link!
>>
>>> Reading again the code and the git history, I now agree it's better
>>> keep this change separate.
>>
>> Great!
>>
>> Can I interpret that as a "Acked-by" for the small series? :-)
> 
> Sure! Just to be redundant: 
> 
> Acked-by: Paolo Abeni <pabeni@redhat.com>

Thank you for the review!

Now in our tree (fix for -net + squashed twice):

New patches for t/upstream-net:
- df6d0b9cc589: mptcp: avoid setting TCP_CLOSE state twice
- a1904eac72d7: "squashed" patch 2/2 in "DO-NOT-MERGE: mptcp: use
kmalloc on kasan build (net)"
- db88e3c96f21: tg:msg: rename subject: improve code coverage for CI (net)
- Results: 2d0e2918d1a9..b0d9441c818b (export-net)

For t/upstream:
- bcffcc8152ee: "squashed" patch 2/2 in "DO-NOT-MERGE: mptcp: use
kmalloc on kasan build"
- aa72cd1b9cf2: tg:msg: rename subject: improve code coverage for CI
- Results: e438a165544f..6ad4eca4e1af (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20230223T165416
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230223T165416

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
