Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2389B6AA2
	for <mptcp@lists.linux.dev>; Tue, 20 Sep 2022 14:54:08 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id y3so6853337ejc.1
        for <mptcp@lists.linux.dev>; Tue, 20 Sep 2022 07:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=p6m3HzGWgbVrhp6WtexB0+oDEg33Vj97+IKmgt+5bo4=;
        b=XJV61Yx2coJ4AVO43TOlVrkyKivWhbAxn0S0+/7BV15H+3zP2z3GD45StvKanyj+Yv
         1Ao1lvzb7AhCEpylbBIdYEufuz29u2MYIVUaLEXYX36iYPZIVlM2A6Ay2TqTTvjxioEV
         4S5cqRclX69mjB1xYjeQPTsj1mm/bM+S1igprUchdUNj6wE//almMIQS73elO3865SWr
         5+dw5/mcA9PMpfsAaUzNUgFC0Xty/ajCMYLvOuai4zJBgwOPPlKaDER0gA3nXCozMpKY
         abddfqL98UfFVzVXz8sS+v/SiXhJPgAwOBXorlipwCLyyHjeuSXeI7Pw7+FVFmhGB5B3
         F2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=p6m3HzGWgbVrhp6WtexB0+oDEg33Vj97+IKmgt+5bo4=;
        b=g2bUzdryS7j5x81E+zdrpCiuElPTJtWn7kxKF9bbljA8Cjg9bbVCmhYB5jwh518HGu
         ltWfO0sx7gzKYUOM7Gv1mSKuRGtGg3XrbTNkPJeaQgGbDNYmrk3JI/WjsEmw37EMhUdX
         1C10t37eWDUvwVRUiEdD40W/zs637KGYXn2o0O0DBY7o6FLJBN8eUVpSuxkcNDnlyKS1
         FkSJ7aLtziqfHtyjAH4rRtcVcsii88/hJaDgQ8nFB/KIr/zAkuQ9X8wdR1N0of/tOXSn
         LxQTX7vFNF6DM6BgNIa8NGpzkJ+s+XqG5RGgtuuvhzexaHDhuZwIeYSR/rS4gydk7xVh
         S6fQ==
X-Gm-Message-State: ACrzQf1ajvxLM0auWMJOis7i/K5NydHFKpHp+3KOiQ2YMNUO2fbnOr1L
	Tdd/kAd4abOzreC0MotR9PHWBg==
X-Google-Smtp-Source: AMsMyM5zinVZrkJwSnl3VS/cwv/T3ekRAivA/XZuALVhUzIZD3y6twowCKtCMvK0PnInJUqFUKwy+g==
X-Received: by 2002:a17:907:b0e:b0:77a:d97d:9afc with SMTP id h14-20020a1709070b0e00b0077ad97d9afcmr16928008ejl.199.1663685646970;
        Tue, 20 Sep 2022 07:54:06 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:e5ca:f250:ef0:bd18? ([2a02:578:8593:1200:e5ca:f250:ef0:bd18])
        by smtp.gmail.com with ESMTPSA id g2-20020a056402090200b00447e5983478sm153186edz.76.2022.09.20.07.54.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 07:54:06 -0700 (PDT)
Message-ID: <cedcc1ca-258d-5c73-7ea0-4e6a1ee98c41@tessares.net>
Date: Tue, 20 Sep 2022 16:54:05 +0200
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
In-Reply-To: <e0a72693-f9bb-f724-5fea-995ad6cde8ac@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Paolo, Mat,

On 11/09/2022 20:23, Matthieu Baerts wrote:
> Hi Mat, Paolo,
> 
> On 10/09/2022 01:21, Mat Martineau wrote:
>> On Fri, 9 Sep 2022, Paolo Abeni wrote:
>>
>>> After the previous patches, the MPTCP protocol can generate
>>> fast-closes on both ends of the connection. Rework the relevant
>>> test-case to carefully trigger the fast-close code-path on a
>>> single end at the time, while ensuring than a predictable amount
>>> of data is spooled on both ends.
>>>
>>> Additionally add another test-cases for the passive socket
>>> fast-close.
>>>
>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>
>> The first time I ran this test, the "fastclose server test" failed with:
>>
>> copyfd_io_poll: poll timed out (events: POLLIN 1, POLLOUT 4)
>>  client exit code 2, server 0
>>
>> I haven't been able to reproduce it, so I'm not sure if it's related to
>> the code changes or just an unrelated intermittent poll timeout (I know
>> I've seen similar issues before).
>>
>> Looks like CI packetdrill noticed the changes like Matthieu mentioned.
>> But that doesn't change these kernel patches.
> 
> About that part, is it OK if I wait for these Packetdrill adaptations
> before applying the patches? Just not to have the CI complaining about
> all new builds on top of the export branch :)

I just adapted Packetdrill tests:

  https://github.com/multipath-tcp/packetdrill/pull/86

Do you mind checking if the new behaviour is the expected one please?

Please note that I already created a stable branch for 6.0 to continue
validating the old behaviour when testing the -net branches.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
