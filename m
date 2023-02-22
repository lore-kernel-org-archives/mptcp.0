Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7AD10E7
	for <mptcp@lists.linux.dev>; Wed, 22 Feb 2023 17:06:46 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id p18-20020a05600c359200b003dc57ea0dfeso6999862wmq.0
        for <mptcp@lists.linux.dev>; Wed, 22 Feb 2023 09:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gtLEFcT2F75BuMMaiAWf3PS9wdLEmHV7zEqTy5Ht+Jc=;
        b=PGvtg204KwQejSXnfnWFYCt0mUk9j+MKrt4mzK5D105lWafeKkksPqYccMIitKhX/2
         OQFoVxg1zOqXUtcw2ATaE/Yee0gkZdRvQFdEmE0hG2WnU0yTFCMnM0gIgNIXDUtcCcUh
         UU0jGhM6lqaNkofM/9mX63cflhiRHogAnXebynRVyE/SajITnrTfPa2vBSEkydLngEf2
         7WmpGtcs3XGTiImaHwsDiNYgxMKG/0lSwoHNtdYP7RZjZ6pbOmd/EnUCX6t68G8/gRSs
         xDVyhD8s64QEpvHaP+/ztWdWm9AEkshiizstojuOkKROfk9zZ52T3U0RlXAe5wZcBQQZ
         1gnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gtLEFcT2F75BuMMaiAWf3PS9wdLEmHV7zEqTy5Ht+Jc=;
        b=EMu9QEYR3XzBT65+9D6mkdSucX6zF95o04+xZJuSnVd9Jf+zDGE7xTTPUdYCPlmoMQ
         YD2ShROJEQJqHxWbKB+WsaLpOh+/tYSw63X5eF8VPvvg/UnETpEqbYiVxEXftNIAknh3
         ZB25+BH0lXsQ0kp68uZz8EmyGC3c/gbFEQkRXqwtEKaWyDaVZ1Bk7kpdtTaJv1jxwyQ2
         Wc0PAt6ll1HZ1DWHjaVb6CAoiW9tiuz4N/dShuJiT+Xajkhhl3FgUIneVynctWak0w66
         QtOBWhTwtYZjW7mGPMvFN+kvrQfu9lmRXc2dKXPyG0C85U6i9mAz4+SkQUMqYGUK0C6b
         y9tg==
X-Gm-Message-State: AO0yUKV2RFpME9hHnaZF2v+pygSHMjcUEJ0XSLz/U71AcQGhnPjyizXG
	wkkMaUeORDQlEA7Vw8lX7b4n7w==
X-Google-Smtp-Source: AK7set8Jk4uhejCkm6iBuW9j127WXp8m6zcF9r/zSpJIjwhwNgNoOlW2Y7+cgfPl9EPbA/6mezeQAg==
X-Received: by 2002:a05:600c:319a:b0:3df:d431:cf64 with SMTP id s26-20020a05600c319a00b003dfd431cf64mr5875815wmp.39.1677085605069;
        Wed, 22 Feb 2023 09:06:45 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:ea8d:3a00:8f98:6fb? ([2a02:578:8593:1200:ea8d:3a00:8f98:6fb])
        by smtp.gmail.com with ESMTPSA id fm18-20020a05600c0c1200b003dc1d668866sm9204649wmb.10.2023.02.22.09.06.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 09:06:44 -0800 (PST)
Message-ID: <165924d2-2441-da74-4e21-3b66d27d9c94@tessares.net>
Date: Wed, 22 Feb 2023 18:06:43 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 mptcp-net 2/2] mptcp: fix UaF in listener shutdown
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
References: <b5b35cfd2d10179fc81643e601e125aa881f7c79.1675968499.git.pabeni@redhat.com>
 <ad634b00b9c4cfb0f8cd6c8ec57d1a7405ba3799.1675968499.git.pabeni@redhat.com>
 <7c02bf27-2de1-cea8-691a-120c988c4da0@tessares.net>
 <5eb0dec3-172a-953d-110d-009cadaa711f@tessares.net>
 <531ceec4b5af0abe463e80a19d98752ed1074aad.camel@redhat.com>
 <4cef3e6b-ad2b-0757-098d-14f09692f68e@tessares.net>
 <a00e24a4f9cc571980c0f8aee6c4f9aa68ed0cdc.camel@redhat.com>
 <25431862-52d4-0868-a60a-719c079b662f@tessares.net>
In-Reply-To: <25431862-52d4-0868-a60a-719c079b662f@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 20/02/2023 15:37, Matthieu Baerts wrote:
> On 20/02/2023 15:30, Paolo Abeni wrote:
>> On Mon, 2023-02-20 at 15:05 +0100, Matthieu Baerts wrote:
>>> Hi Paolo,
>>>
>>> Thank you for your reply.
>>>
>>> On 20/02/2023 12:51, Paolo Abeni wrote:
>>>> On Mon, 2023-02-20 at 12:14 +0100, Matthieu Baerts wrote:
>>>>> Hi Paolo,
>>>>>
>>>>> On 17/02/2023 18:58, Matthieu Baerts wrote:
>>>>>> Hi Paolo,
>>>>>>
>>>>>> On 09/02/2023 19:48, Paolo Abeni wrote:
>>>>>>> As reported by Christoph, the mptcp listener shutdown path is prone
>>>>>>> to an UaF issue.
>>>>>>
>>>>>> Again, thank you for the two patches!
>>>>>>
>>>>>> Now in our tree (fixes for -net) with my RvB tag.
>>>>>>
>>>>>> I had a few conflicts when applying them on -net (and later when
>>>>>> propagating them to our tree, see below), I hope that's OK but don't
>>>>>> hesitate to double check if you have the opportunity :)
>>>>>
>>>>> I probably didn't resolve the conflicts properly (or maybe some
>>>>> adaptations are needed on -net) because this introduce some regressions
>>>>> on export-net (not on net-next):
>>>>>
>>>>> Any idea what could cause that?
>>>>>
>>>>> https://github.com/multipath-tcp/mptcp_net-next/issues/361
>>>>
>>>> I *think* it's not a conflict resolution issue; patch 1/2 here
>>>> functionally depends on ("mptcp: refactor passive socket
>>>> initialization") which let msk take a reference on unaccepted MPC
>>>> subflows, so that incoming reset will not free such subflow via
>>>> inet_child_forget().
>>>>
>>>> I *think* the easier solution is moving this patches on export-next
>>>> after ("mptcp: refactor passive socket initialization"), mentioned
>>>> explicitly the functional dependency
>>> Indeed, it makes sense. I just did that.
>>>
>>> I removed the Fixes tags and mentioned it was linked to the refactor of
>>> the passive socket initialization: is it OK? :)
>>
>> I *think* we want to preserve the Fixes tag, to help stable team. We
>> can send fix to net-next in case like this. 
> 
> It is not clear to me if this bug is visible without the patches that
> are currently in our export branch. If yes, we can keep the Fixes but we
> need to mark that it depends on the refactor not to confuse the stable team.

As discussed on IRC, I moved the two patches back to -net + "mptcp:
refactor passive socket initialization":

New patches for t/upstream-net and t/upstream:
- eb67c35c665c: mptcp: refactor passive socket initialization (net)
- 315f247fb103: mptcp: use the workqueue to destroy unaccepted sockets (net)
- 26486b7946a6: mptcp: fix UaF in listener shutdown (net)
- Results: d9da79d599ab..8de0668c80e8 (export-net)

- 40500a9320da: conflict in t/mptcp-drop-legacy-code
- 0429d72c1ceb: conflict in
t/mptcp-use-the-workqueue-to-destroy-unaccepted-sockets-net-next
- Results: eb4a580f39ff..6d711df72d37 (export) # empty, as expected

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20230222T170427
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230222T170427

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
