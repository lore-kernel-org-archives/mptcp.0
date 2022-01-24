Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B362CB2
	for <mptcp@lists.linux.dev>; Mon, 24 Jan 2022 09:39:49 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id j23so50351419edp.5
        for <mptcp@lists.linux.dev>; Mon, 24 Jan 2022 01:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=I4gm0j1SL9jdoa4UUvMGwzTjpvwrwaYG4egTZ5JlLro=;
        b=eW6NvDghtH3rYQRqWjmJVTGItu7RDAztBSvho/y+aO3526E0NMb33cnGqetIEb9DAi
         HtAp8OFjE1QK/Y5luZpbeMtL4q18py4Ep1NWxcJHn/72yNy0888SFUl2SklXZKGGef/s
         EnKYzIP9eQ0IalHroG3PAmAdFKQZ2SgMSE7lldrzHZU8eUV1iGTMaEHLgRe55958zEZx
         jYc6B90A6HlXYp4HH0+LbRiBNw1709hsUbTIl9oKXli710DkoZPe/el114CbOe4Z3+Cm
         dUFkZjGIEi5aJaMoU9bLDQHmVmmzTtuA/k/RsZrrU/+o8J+EwmoYaBN5c/5ld08iirnd
         vOrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=I4gm0j1SL9jdoa4UUvMGwzTjpvwrwaYG4egTZ5JlLro=;
        b=4prYUHMz2VyHpRO0fKQcboUKDv5PCGYFrszbDy+pOjGF8yzu2Ft0MQDLPov3YDlCwi
         s0h448kDiAwLo/zK8Xhx6DqlffH/hGDJs93U7Y9zG6oW3xGsYbsXVYaoQukEPNVTurQn
         7vbzKYcGYEOoWFlqYu60FA8fRaPmEgCfL6cL8uFvpW8n1jBEE8tvoE5gc71s185Gr1cc
         IZh+dMR+YmOC2kPKu9jETYwtM1u17H9bgnmyLYQ51DqrphgLgDkD8ew6ifI5ajGkJ34e
         2Pp7VPDzBTAkaaHI67IHzLehvhlj2AaWitiUGCRtH8KVjbybA4CRsNbChdQLYELR4QGc
         Xq1A==
X-Gm-Message-State: AOAM5329WINJMgDnskapFDH2LAnhfCEEIU6Kl2iO0xZwQYmwJScf6d0L
	Bbt0TBa8pAVLYNtHa0mIY5Bxs8znHw+AYg==
X-Google-Smtp-Source: ABdhPJzLvWXsQ7azF48gpgwLA0gKCPRZHTCh3BV7FU5TjeKSIrj5kDqooWx6/vvTdKX0bbbwUusfZA==
X-Received: by 2002:aa7:cd8a:: with SMTP id x10mr15036832edv.3.1643017187380;
        Mon, 24 Jan 2022 01:39:47 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:34ac:d0ea:17a3:8b08? ([2a02:578:8593:1200:34ac:d0ea:17a3:8b08])
        by smtp.gmail.com with ESMTPSA id p13sm4661857ejx.183.2022.01.24.01.39.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 01:39:46 -0800 (PST)
Message-ID: <fc920e6d-72fe-49c8-e31f-920fbd15c952@tessares.net>
Date: Mon, 24 Jan 2022 10:39:46 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH mptcp-net 2/2] selftests: mptcp: add missing join check
Content-Language: en-GB
To: Geliang Tang <geliangtang@gmail.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Paolo Abeni <pabeni@redhat.com>
References: <20220122093135.4023846-1-matthieu.baerts@tessares.net>
 <20220122093135.4023846-3-matthieu.baerts@tessares.net>
 <CA+WQbwuSJ-WZuQFEjTAtD5ycodbiC0mZ7dwDWQa0VEWsOPSO=g@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <CA+WQbwuSJ-WZuQFEjTAtD5ycodbiC0mZ7dwDWQa0VEWsOPSO=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

Thank you for looking at that!

On 22/01/2022 15:04, Geliang Tang wrote:
> I think in this test chk_join_nr is omitted on purpose, since it is more
> likely to fail. As we can see, chk_add_nr failed sometimes, if we add this
> chk_join_nr, it will fail more frequently.

May you explain why this tests is likely to fail? Both the commit
message and the comment in the code don't explain that.

> Matthieu Baerts <matthieu.baerts@tessares.net> 于2022年1月22日周六 17:32写道：
>>
>> This function also writes the name of the test with its ID, making clear
>> a new test has been executed.
>>
>> Without that, the ADD_ADDR results from this test was appended at the
>> end of the previous test causing confusions. Especially when the second
>> test was failing, we had:
>>
>>   17 signal invalid addresses     syn[ ok ] - synack[ ok ] - ack[ ok ]
>>                                   add[ ok ] - echo  [ ok ]
>>                                   add[fail] got 2 ADD_ADDR[s] expected 3
>>
>> In fact, this 17th test was OK but not the 18th one.
>>
>> Now we have:
>>
>>   17 signal invalid addresses     syn[ ok ] - synack[ ok ] - ack[ ok ]
>>                                   add[ ok ] - echo  [ ok ]
>>   18 signal addresses race test   syn[ ok ] - synack[ ok ] - ack[ ok ]
>>                                   add[fail] got 2 ADD_ADDR[s] expected 3
> 
> I think if chk_add_nr fail here, chk_join_nr must fail too. If we got 2
> ADD_ADDR[s], we got 2 JOIN[s] syn too, not 3. Furthermore, if chk_add_nr
> passed, we can't make sure chk_join_nr will pass too. Since MP_JOIN is
> translated after ADD_ADDR, it may be lost.

Indeed, to simplify the commit message, I mixed both a "success" and a
"failure" output. I should not have done that and only put a "success"
one to keep the output small.

>> Fixes: 33c563ad28e3 ("selftests: mptcp: add_addr and echo race test")
>> Reported-by: Paolo Abeni <pabeni@redhat.com>
>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>> ---
>>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> index 76c45c845d3b..67be3e1215d7 100755
>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> @@ -1342,6 +1342,7 @@ signal_address_tests()
>>         pm_nl_add_endpoint $ns2 10.0.3.2 flags signal
>>         pm_nl_add_endpoint $ns2 10.0.4.2 flags signal
>>         run_tests $ns1 $ns2 10.0.1.1
>> +       chk_join_nr "signal addresses race test" 3 3 3
> 
> I think we can omit the join numbers check, just print out the name of the
> test. Don't pass the join numbers to chk_join_nr, just the msg:
> 
>         chk_join_nr "signal addresses race test"

Do you mean we could have situations where ADD_ADDR have been properly
sent and received but we check counters just before MPJ are emitted? In
this case we would mark the test as failed because MPJs are not OK
(checked too soon in fact) while ADD_ADDR are?

If yes and if it helps, we can also wait for the kernel to have sent
exactly 3 ADD_ADDR before checking the MPJ. On the other hand, do we not
already cover this UC where we look for MPJs emitted after having
received an ADD_ADDR, no?

If we keep checking all counters, I think it might be clearer: MPJ
counters are not OK because we didn't receive/process the ADD_ADDR, no?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
