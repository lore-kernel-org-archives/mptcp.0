Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCBE7C
	for <mptcp@lists.linux.dev>; Thu,  8 Sep 2022 12:13:18 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id b16so24057290edd.4
        for <mptcp@lists.linux.dev>; Thu, 08 Sep 2022 05:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=KZPoYELu+OmWPyWckkyXqumb2NlvL3QHh34vPnJ9dWs=;
        b=xvaCTWewx5mhKCJ1K77u3ElgZmp66DGBTt8Eg9nXCqF33QjGWGqWkdEAn3grUPE5k8
         c1rg06NXQlORQ12jnnb4JxskOe7BzJFHT4grIeeOj44ZXUQzmPPQ5LP9bjsZpLbGp3r1
         WWU60sMNhk0Ctoe7yEpdduMkhFhG5BtUP0E+BJR/OGIZ1pAizbP6ee9Bl3CZ/4MJNwxo
         lsn+clTxIYwjvAXQ/HVkBqYd8ET6KlAcWBSqAdti1gUGlsSfEUYgT3pYg0R0Hoq26qtn
         GpQY9t7+8QDWZjU0i8sNQ62fwi+54DlRmBbavReJdB6VbtTAe38fwPn8Z4SIdOH7kdmx
         8AIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=KZPoYELu+OmWPyWckkyXqumb2NlvL3QHh34vPnJ9dWs=;
        b=kmD2bIa9FZHRRAoXbsKoJytWq9LFds3pLL3dJGyi4y2d3MlIiQw5MMbP3IJwXBCDdF
         8bkN3vPZ2G+gXCyfD61Yaj5ly+aO2iR5TP1QSWzLlPEW9tPjxatbM+MRr61J1DNZQPqY
         PfJhBIWDukXZtMVFklsIVvC4q43iMGaoVGixrsN1OECq3nVg2PfVUd0LGpEN23iGJWIX
         bWJbwq6YrIvIVN0cz3FQZEmwCPiQstblFH6Hc82H22ZehKWHjxiYZlcAfbB4JFlTlWD1
         PmENY+z1t5w62reuN9ifUiLuH3DAlN1MTzBCZwxk8dlvIMOmArMwK5cWRJ+V+N8PvP95
         D1rA==
X-Gm-Message-State: ACgBeo1zsxsyycDO2+FpKjSq5Fs6oHW9reEJ1ZAGhP5Y1WyEpQQoKv20
	7kW5DGCIjsh0Ugt6rHfJOxQs8g==
X-Google-Smtp-Source: AA6agR556DDIPSoVfy3e1aneqC8KEmjuTo5dovhgxjW86uLak4OK0h+a4PxiRTbzGDYrpAF9LWx9Pw==
X-Received: by 2002:aa7:d5c8:0:b0:44e:3eb1:a13f with SMTP id d8-20020aa7d5c8000000b0044e3eb1a13fmr7028078eds.220.1662639196675;
        Thu, 08 Sep 2022 05:13:16 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:8618:9875:a93a:7063? ([2a02:578:8593:1200:8618:9875:a93a:7063])
        by smtp.gmail.com with ESMTPSA id cm20-20020a0564020c9400b0044e74c9dfedsm8480861edb.86.2022.09.08.05.13.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 05:13:16 -0700 (PDT)
Message-ID: <471abad1-74ec-c8ee-163b-0a1a215a89d9@tessares.net>
Date: Thu, 8 Sep 2022 14:13:14 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v3 mptcp-next 1/3] mptcp: propagate fastclose error.
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>
References: <5e26963328ae04aa375089a713ec40f5eb6adacd.1662051551.git.pabeni@redhat.com>
 <86057d75-499c-8e30-ef15-7cd67cbc2344@tessares.net>
 <697a9878ebff12d2a08a40bab699ed7cb41326d9.camel@redhat.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <697a9878ebff12d2a08a40bab699ed7cb41326d9.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

Thank you for your replies!

On 08/09/2022 13:48, Paolo Abeni wrote:
> On Wed, 2022-09-07 at 19:22 +0200, Matthieu Baerts wrote:
>> On 01/09/2022 19:31, Paolo Abeni wrote:

(...)

>>> Additionally sendmsg() is currently not handling properly
>>> the sk_err, always returning EPIPE.
>> Could it be seen as a bug-fix and deserving a dedicated commit?
> 
> I personally see this as an improvement, as AFAIK there is no mandated
> by RFC return error code for MPTCP.

Mmh yes I see, we can say that.

>>
>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>> ---
>>>  net/mptcp/protocol.c | 45 ++++++++++++++++++++++++++++++++++----------
>>>  1 file changed, 35 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>> index f4891db86217..b04f184695e4 100644
>>> --- a/net/mptcp/protocol.c
>>> +++ b/net/mptcp/protocol.c
>>> @@ -1685,9 +1685,13 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>>>  	if ((1 << sk->sk_state) & ~(TCPF_ESTABLISHED | TCPF_CLOSE_WAIT)) {
>>>  		ret = sk_stream_wait_connect(sk, &timeo);
>>>  		if (ret)
>>> -			goto out;
>>> +			goto do_error;
>>>  	}
>>>  
>>> +	ret = -EPIPE;
>>
>> Regarding this line above... (see below)
>>
>>> +	if (unlikely(sk->sk_err || (sk->sk_shutdown & SEND_SHUTDOWN)))
>>> +		goto do_error;
>>> +
>>>  	pfrag = sk_page_frag(sk);
>>>  
>>>  	while (msg_data_left(msg)) {
>>
>> ...Could we eventually have no data left and no going through the while
>> loop?
> 
> yes...
> 
>> In this case "copied" will be 0 and we will return the new -EPIPE, maybe
>> not what we want, no?
> 
> no;) we now always return 'copied'. We set 'copied' to the correct
> error code only in the error path, saving a conditional in the fast
> path.

My bad, for the end of the function, I was looking at code prior this
patch... Indeed, all good with the rest of the modifications :)

> All gracefully stolen from plain TCP ;)

:)

> 
>> Or should we change 'ret' value just before calling 'goto do_error' to
>> avoid that?
>>
>> (...)
>>
>>> @@ -2404,12 +2410,31 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
>>>  		unlock_sock_fast(tcp_sk, slow);
>>>  	}
>>>  
>>> +	/* Mirror the tcp_reset() error propagation */
>>> +	switch (sk->sk_state) {
>>> +	case TCP_SYN_SENT:
>>> +		sk->sk_err = ECONNREFUSED;
>>> +		break;
>>> +	case TCP_CLOSE_WAIT:
>>> +		sk->sk_err = EPIPE;
>>> +		break;
>>> +	case TCP_CLOSE:
>>> +		return;
>>> +	default:
>>> +		sk->sk_err = ECONNRESET;
>>> +	}
>>
>> Should we eventually move this out of tcp_reset(), export it (inline
>> function?) and re-using it here to avoid the duplication (and eventually
>> being out-of-sync in case of changes on TCP side? even if I guess this
>> would not change but well)
> 
> That could be a possible follow-up I guess, but I would refrain from
> touching TCP to address issues/295.

Sure, we can do that later as a clean-up.


Patch 1/3 and 2/3 from this v3 are then good to me:

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

(I'm not going to apply them now as we need patch 3/3 and I had some
questions there + packetdrill adaptations)


Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
