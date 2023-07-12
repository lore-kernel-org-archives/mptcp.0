Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D95D200A0
	for <mptcp@lists.linux.dev>; Wed, 12 Jul 2023 09:51:20 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-51fdf291330so633970a12.2
        for <mptcp@lists.linux.dev>; Wed, 12 Jul 2023 02:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689155478; x=1691747478;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p9EGYJ+z1ozPOK1JyeyDuKGraTcEds2dF9vIQKb5ud0=;
        b=ckFOINZ2srpcGnwXYYY+kmJqVhWmeCQtoCsrpvJVrhxyXswnxucTOWV+QhYFh/IJoE
         VzmtUqgDJD7tlJsKMcGdac4uc6eCUc8N3xWjNG5UtNuO28vfvLY9CzNNLO6dS6JK6EVa
         ManAt7cdCenRtyzYxguy/WC4qOexK04ESAg1BWeTU36duAWAZBhk9C2sv9vHENyqH0yI
         IxXku9T1NVWOKN3mfqeHq+LhgHJJmsqjCaNAUB8J3ti2CB9zq49TIR1oXQ25gkV6Dnfm
         k2SCm9FxUo7gPhbYpY2ZNyMW14/3cV2t9Hv3ce9TnWwExtrymcQR09ZYYEQdRwwZ2g7d
         heRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689155478; x=1691747478;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p9EGYJ+z1ozPOK1JyeyDuKGraTcEds2dF9vIQKb5ud0=;
        b=kjuAyVGNIl15A+gALJ7s5h4O2sOjtrSVbLEFZsb8t+nFHQ7lysEkZcBIPtxuGFUc0Z
         +W06y/9AJpCyZMsjVE9LbWL7IdLZLOG+ogLkiGfT3/+CvH0axTaGTi/3qQqO0ofEfs7D
         hDHQa2v3ZGa7wJ9zo+SaSuR4yVj2JCVeX6SWokIWPmzZhC1RK6qqA81w1xJbMlUXUE0/
         GrYoHEuf0l93rrYaHXCIORrcwQ5oBuEauVipJmtBLgIV1+H8fvdZMKbX4g6SlfJwWPJx
         cxLkNmgOClavkwkfp34unLR1tL1q1X/q/f+6GB+jTNTwFMYVw4w/NoSjmgtJYBHzVvHR
         /dNw==
X-Gm-Message-State: ABy/qLZJwkLD4GICEUV2vjC0XoOHLXslNg/q9ITUwK1nYUlp00w/0onZ
	+aAiP8KPoSfopeGUhgtaIXhVB+Lr4E5bhPfYV4gEdg==
X-Google-Smtp-Source: APBJJlGJpmgWHjXPqxWYpYlMa+7gDOUunVl0bSBweGG43vBGuHgH49uhYQz3NTAbHEAPj/A4xvyfjg==
X-Received: by 2002:a17:906:51d4:b0:974:1e0e:91ee with SMTP id v20-20020a17090651d400b009741e0e91eemr20510557ejk.13.1689155478249;
        Wed, 12 Jul 2023 02:51:18 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:e63d:32df:2bec:83e9? ([2a02:578:8593:1200:e63d:32df:2bec:83e9])
        by smtp.gmail.com with ESMTPSA id p18-20020a170906b21200b00992e265a22dsm2306481ejz.136.2023.07.12.02.51.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 02:51:18 -0700 (PDT)
Message-ID: <5a17fb27-32b5-8440-9fc0-279c49fdbeda@tessares.net>
Date: Wed, 12 Jul 2023 11:51:17 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Linaro tests: parsing of the kselftests results
Content-Language: en-GB
To: Anders Roxell <anders.roxell@linaro.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
 Linux Kernel Functional Testing <lkft@linaro.org>,
 MPTCP Upstream <mptcp@lists.linux.dev>
References: <a1e6596b-cffd-9860-9146-f8a41defd22e@tessares.net>
 <9c00808f-ee54-d8c1-1be9-65d508c1786e@tessares.net>
 <CADYN=9KKSjvD=TVqO_U7y4tamBHDr09WhMq2WzwcAk8WDfwPBw@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <CADYN=9KKSjvD=TVqO_U7y4tamBHDr09WhMq2WzwcAk8WDfwPBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Anders,

On 12/07/2023 10:53, Anders Roxell wrote:
> [ flollowup on what we discussed on IRC ]
> 
> On Tue, 6 Jun 2023 at 13:59, 'Matthieu Baerts' via lkft <lkft@linaro.org> wrote:
>>
>> Hello,
> 
> Hey Matthieu,
> 
>>
>> On 01/06/2023 19:41, Matthieu Baerts wrote:
>>> Hello Naresh and other people behind the lkft project,
>>>
>>> TL;DR: how can we provide results for sub-tests like it is done with TC
>>> selftests?
>>
>> If I'm not mistaken, it is OK to provide a TAP output in the current
>> kselftests TAP output, right?
>>
>> The parser seems to be this:
>>
>> https://github.com/Linaro/test-definitions/blob/master/automated/linux/kselftest/parse-output.py
>>
>> We just need a line with:
>>
>>   (not )?ok \d+ Description # Directive
>>
>> One special directive to mark a test as skipped:
>>
>>   ok \d+ Description # SKIP
>>
>>
>> If that's just that, it should not be too hard to support subtests. It
>> looks like it should even be compatible with TAP 14 if we add 4 spaces
>> for the indentation if I'm not mistaken.
> 
> I created this patch [1], thank you for the suggestion.
> Here you can see the result [2] from a run with this patch.
> It used to be pass when it was a "skipped" test.

Thank you for the follow-up and the fix!

On MPTCP side, the tests are now [1] printing a TAP output at the end,
similar to what TC is doing. So hopefully with Linux v6.6 (and "soon" in
next), we should be able to track the individual subtests instead of
only the main scripts executing hundreds of subtests.

Cheers,
Matt

[1]
https://patchwork.kernel.org/project/mptcp/list/?series=759227&state=%2A&archive=both
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
