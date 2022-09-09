Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9AF7E3
	for <mptcp@lists.linux.dev>; Fri,  9 Sep 2022 08:52:32 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id d5so864613wms.5
        for <mptcp@lists.linux.dev>; Fri, 09 Sep 2022 01:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date;
        bh=m0WkAxoDZIE469NFtpm+Am37fkJGukSD3NRN8zfoylY=;
        b=dC/uHwbNsC+KQb9fDG27OAIRcJQa0GDDNoy1hX0Jx1MY2NlHfxS/Jkc4LAQeInYGSV
         ikbcAW67mja8o+K0MI2bRaOm8/X+/m/MSf0CVV6R1I5JJgNQRjKQzdA95r9paMGwJ40l
         ug982h6EqvtGkhQYD2TmE/0Dima7+zowWulJpTU8UN1QyKCWJgFLYt83euFy2P+0oBot
         ERkigdOcZ3dHuIRtaSza+6GCMkARCdSqT9G3WKwl6BeAXz4tehLSA5abuMtuNAJfn9AN
         OkoPP+ZiOSG/OhtQah/z5NXa5rCSz5xkOcwaUp1bKoFAySxG1f8O9wJa2LeF6fHVt24V
         U8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=m0WkAxoDZIE469NFtpm+Am37fkJGukSD3NRN8zfoylY=;
        b=W9W62qSTEl3OfTdCMt+UNHllWqq/6gJC/et7x7ZE8jN4ZzwQ8LikYoqWbg22+dQJZ4
         zKwWpg00j4gNvFh4PwmeE6wn9mtKKMi//R/gcysGC5n0gSbRhAJauLLjKY/0ByUkmVYF
         K/XIuQTNGP1RjFWZI5yxlwoOghVmdWDDSyCLlI2sABRJa+w+6Nngu5zZuGLzrzFQBcIg
         c0O/GhEtYPOHtzx5Ob9ycjb50AEl8Z70n8/mx8I9+Gl36f4olFh9jgGu+ZxEG/6PrBkf
         wzVIK3vvkPttGCN2XvdkiXU+lv9DgnwswoZ9/QWWPujbzP5kUisYfGQlfMDmhLWV1Ztj
         P95g==
X-Gm-Message-State: ACgBeo3iv0ysnVgu3Po+Vs6soCc/K5aZYHk/wgFOi5H3W3N6KMvtUxCd
	GNhkloMrsGNwU6hPoAGR0Epko/hjAAY4jGS2
X-Google-Smtp-Source: AA6agR5vQI14N5LNHZJnIQwDiAj6NGku+bhJ1vRSM3jfsOLOh7E+D4XLkQ8vf+apoc1mWXuUlMvNKw==
X-Received: by 2002:a05:600c:5009:b0:3a9:f99e:7410 with SMTP id n9-20020a05600c500900b003a9f99e7410mr4821437wmr.5.1662713550523;
        Fri, 09 Sep 2022 01:52:30 -0700 (PDT)
Received: from [10.44.2.26] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id w10-20020a05600c474a00b003a608d69a64sm5577664wmo.21.2022.09.09.01.52.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 01:52:30 -0700 (PDT)
Message-ID: <b42df2fb-446c-f7ee-650d-0c634364dffc@tessares.net>
Date: Fri, 9 Sep 2022 10:52:29 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v3 mptcp-next 3/3] selftests: mptcp: update and extend
 fastclose test-cases
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <5e26963328ae04aa375089a713ec40f5eb6adacd.1662051551.git.pabeni@redhat.com>
 <27d535b3cc0cd665ba6404056aa51fb4a1628f44.1662051551.git.pabeni@redhat.com>
 <d7a536f8-ac96-0b8b-7460-2a240aeb2d32@tessares.net>
 <8f1825a347340edfc1af0ebba57b8088f4f49cb6.camel@redhat.com>
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <8f1825a347340edfc1af0ebba57b8088f4f49cb6.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 09/09/2022 10:09, Paolo Abeni wrote:
> On Wed, 2022-09-07 at 19:22 +0200, Matthieu Baerts wrote:
>> On 01/09/2022 19:31, Paolo Abeni wrote:
>>> After the previous patches, the MPTCP protocol can generate
>>> fast-closes on both ends of the connection. Rework the relevant
>>> test-case to carefully trigger the fast-close code-path on a
>>> single end at the time, while ensuring than a predictable amount
>>> of data is spooled on both ends.
>>>
>>> Additionally add another test-cases for the passive socket
>>> fast-close.
>>
>> Thank you for the v3!
>>
>> (...)
>>
>>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
>>> index 24d4e9cb617e..ee6df83c55f3 100644
>>> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
>>> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c

(...)

>>> @@ -1236,7 +1283,7 @@ chk_rst_nr()
>>>  	printf "%-${nr_blank}s %s" " " "rtx"
>>>  	count=$(ip netns exec $ns_tx nstat -as | grep MPTcpExtMPRstTx | awk '{print $2}')
>>>  	[ -z "$count" ] && count=0
>>> -	if [ "$count" != "$rst_tx" ]; then
>>> +	if [ $count -lt $rst_tx ]; then
>>
>> Why is it fine if we send (and below receive) more than expected?
> 
> [answering only here because this will be the only suggestion leading
> to no changes in the next revision]
> 
> Because the rst can be retransmitted. I'm not sure/can't recall how the
> self-test previously was able to enforce a single reset, but that does
> not look possible now.

Indeed, good idea to do that! I guess we can control the number of
retransmissions in general but not specific to the reset: we don't want
to not accept any retransmissions of the previous data packets.

(I'm sorry to repeat the same kind of thing again but should we extract
this part and have a dedicated commit for -net? :) )

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
