Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773F71102
	for <mptcp@lists.linux.dev>; Wed, 21 Sep 2022 12:36:59 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id u9so13348653ejy.5
        for <mptcp@lists.linux.dev>; Wed, 21 Sep 2022 05:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=5CT+sXMmsHaF+zBy2XGbCDY/cTKv8iXAuktxeRMFo0k=;
        b=0si7pcdXxxh2nhVNe+3evlQyo9bgPft9OoQTxBrG4wzekuT3JB0LtnCfIFSMnh8Lc8
         uihNS03VwYMPxYJb/kagb4AgHTX7sjMsJJ9yFZMhY1qbukh0xgpd+OA/rWKIpRZoM6su
         38epx/JheipyQO/B5o0sDWO9WqoB4IlnBbrEdexndtkGxB7AASODr2W2ai+IptxJFTs9
         qosLOmVtaJvr+d+2XSTidha1Pg670HfWjeVZtuD5c1zFZJcWbYozj1Fd2ps49QpOY3JX
         pVwWIao20NSDOv76J/w8qQno+Ggd80ZfHWb5VzqE4ZNewNfK+eQkQb8qG9BUBEqg4N2W
         nBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=5CT+sXMmsHaF+zBy2XGbCDY/cTKv8iXAuktxeRMFo0k=;
        b=ZRGIZIjmr3UT9NAfex0Gry7L0D6gL9DxXWGjmEjn/v+k6dE1WC8uYDi61amUKWyt63
         hQhqTx+r3pCOKREeguMmXLOfjVb7AVYMP4iGJQSdhHDO+iAQK+HbjvrgYb+NrEBFCgui
         Hurmt+OypIcCCoLT+jFxDTb5xh2T4AhpSe2qrxinwF0rNvrU37Z8Bp9dur0hCONYms4f
         E2DK9yPhxO0DtSeuU4pWdJm1PCzA0mVQVKYsQ55jVjzA9v98OmZ5TcVkaJ+YNl6j7QhW
         PJamKAIRm7bUi9IOqz8bE5RXmtZW7wKi/idNlj7Ihov7t1Pq/po91GAN+6P/WyrBk6Zb
         FFzA==
X-Gm-Message-State: ACrzQf0ZYF3kueCNQduon9oOp5aqX4s3ofg6cZKVm32Nd5rmtog0tLJL
	phgRpWOo28hSQ4+gRDeZl+Xi4aUnmT6x2g==
X-Google-Smtp-Source: AMsMyM4vmb53Ak9xrORhUuWkGDZ+5ix61Z04ICRFaKURCL5HhfIj3WgjnsblzvDa7Zloza1IOZmw0A==
X-Received: by 2002:a17:906:9756:b0:781:bc50:abe3 with SMTP id o22-20020a170906975600b00781bc50abe3mr6598429ejy.291.1663763817347;
        Wed, 21 Sep 2022 05:36:57 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:e650:9a94:d180:442c? ([2a02:578:8593:1200:e650:9a94:d180:442c])
        by smtp.gmail.com with ESMTPSA id lh7-20020a170906f8c700b0073d6d6e698bsm1192850ejb.187.2022.09.21.05.36.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 05:36:56 -0700 (PDT)
Message-ID: <ba35f733-1a3f-9ca7-9d27-0cbd97479a8e@tessares.net>
Date: Wed, 21 Sep 2022 14:36:56 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH mptcp-next v4 3/3] selftests: mptcp: update and extend
 fastclose test-cases
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
References: <904c47ce96fa8d6d4c961a2480bf3aea702c3a9c.1662713367.git.pabeni@redhat.com>
 <ccf2c2fc0f7fdca9742c51b3fdc6bb6c5fabec5f.1662713367.git.pabeni@redhat.com>
 <801e3c41-d5c8-3ea6-958c-ac3b008810c2@linux.intel.com>
 <e0a72693-f9bb-f724-5fea-995ad6cde8ac@tessares.net>
 <cedcc1ca-258d-5c73-7ea0-4e6a1ee98c41@tessares.net>
In-Reply-To: <cedcc1ca-258d-5c73-7ea0-4e6a1ee98c41@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Paolo, Mat,

On 20/09/2022 16:54, Matthieu Baerts wrote:
> Hi Paolo, Mat,
> 
> On 11/09/2022 20:23, Matthieu Baerts wrote:
>> Hi Mat, Paolo,
>>
>> On 10/09/2022 01:21, Mat Martineau wrote:
>>> On Fri, 9 Sep 2022, Paolo Abeni wrote:
>>>
>>>> After the previous patches, the MPTCP protocol can generate
>>>> fast-closes on both ends of the connection. Rework the relevant
>>>> test-case to carefully trigger the fast-close code-path on a
>>>> single end at the time, while ensuring than a predictable amount
>>>> of data is spooled on both ends.
>>>>
>>>> Additionally add another test-cases for the passive socket
>>>> fast-close.
>>>>
>>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>>
>>> The first time I ran this test, the "fastclose server test" failed with:
>>>
>>> copyfd_io_poll: poll timed out (events: POLLIN 1, POLLOUT 4)
>>>  client exit code 2, server 0
>>>
>>> I haven't been able to reproduce it, so I'm not sure if it's related to
>>> the code changes or just an unrelated intermittent poll timeout (I know
>>> I've seen similar issues before).
>>>
>>> Looks like CI packetdrill noticed the changes like Matthieu mentioned.
>>> But that doesn't change these kernel patches.
>>
>> About that part, is it OK if I wait for these Packetdrill adaptations
>> before applying the patches? Just not to have the CI complaining about
>> all new builds on top of the export branch :)
> 
> I just adapted Packetdrill tests:
> 
>   https://github.com/multipath-tcp/packetdrill/pull/86
> 
> Do you mind checking if the new behaviour is the expected one please?
> 
> Please note that I already created a stable branch for 6.0 to continue
> validating the old behaviour when testing the -net branches.

Thank you for the patches and the review!

A few hours ago, I applied these patches in our tree (feat. for
net-next) with Mat and my RvB tags. Just before, I also accepted the PR
86 on GitHub.


New patches for t/upstream:
- 374cd727ed92: mptcp: propagate fastclose error
- c745856e931e: mptcp: use fastclose on more edge scenarios
- 7ed8005532f4: selftests: mptcp: update and extend fastclose test-cases
- Results: e4bedeb4fae3..fc5b36e8ab3d (export)


Tests were in progress there:

https://cirrus-ci.com/build/6557178965262336


Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
