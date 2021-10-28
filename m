Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453832C81
	for <mptcp@lists.linux.dev>; Thu, 28 Oct 2021 16:46:54 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id r4so26783772edi.5
        for <mptcp@lists.linux.dev>; Thu, 28 Oct 2021 09:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=m2fqIyERoqSQZ2v4DjDDTFYNks/NLVIjsVBxEJeMYZY=;
        b=1UvnSUS/0Z2wARZs56lrVoO+9u/ELRVFxPFeZpPbTuSpTDtEGPZlZ25AP7/EaRxQNZ
         xi5owIXAeGUFHnq2JMrc4c3aqzMc3H6bDJ8DMQ44dxlAwJhGYlFcqgLPypwFkQvBpHVV
         U4qffHPil1nfPCBFOKh9DUc1UXqGzkDDd3F1yJg31wNj1rNEmYULIOUWuXFV2NNEk34q
         NzLNhFt6Rmegtqbg6StdlpXWi2BCGK3KeNgcEBcRfuvIeNSHPJ4yAc2zWiyjn0q+fAFw
         BKFecrylncoSf7po2D3OramMS12HznqnKKj8XyF+sMTToqsd8Bs8crWCb/X3bFHcmADJ
         rz6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=m2fqIyERoqSQZ2v4DjDDTFYNks/NLVIjsVBxEJeMYZY=;
        b=H3tBqL+0kFj7YljPAoMIMeFWfcjATUD5Qq50KX0iYpQmBDiLco1/7RMxGtIkHeN5xR
         ihMB3fFk+HSkuDfZGzwHyWO6Xhvh6XzvQManPYQ1R1XSubTZB8XtnBy8xvBBqYCxPygJ
         BChqWIa0jyPn0XGBp6x5ZbrdrkwBfOIQn5uj74XUi02B4UX0zhUy2Kz0wAqWnEYpD2Qa
         +9fm+4lUbFpibx+hcTdGd17MEKJwcLEBt/fnWg5f8Q7FWqKe92iOXHOY59MLRwIFVx0f
         5dZbgqWYwJLs8d2r3zwvI62w3LXHvLXsB6zTzhf8ywaAaLiNlzPL0kL9PgbBuEEDbFRl
         bIxw==
X-Gm-Message-State: AOAM533Iar6cHAFiu1/g9ex8iUIVFMHoe/0LGIbtPlQWyvDfQlhNMqgt
	iJrJduZpJSu9KEFODLoMODfIUQ==
X-Google-Smtp-Source: ABdhPJyIpQrhrb5yirqKnL4BZq7TOJNsg7UUCLKPeBtfR9O+BM7urD4rjE3UINIUo8DUcgqB3bcRKw==
X-Received: by 2002:a17:906:5384:: with SMTP id g4mr6554350ejo.27.1635439613089;
        Thu, 28 Oct 2021 09:46:53 -0700 (PDT)
Received: from [192.168.178.46] ([213.211.156.121])
        by smtp.gmail.com with ESMTPSA id ay9sm2007912edb.95.2021.10.28.09.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Oct 2021 09:46:52 -0700 (PDT)
Message-ID: <cd55aaac-ea6f-e09c-489d-34112e3ceb39@tessares.net>
Date: Thu, 28 Oct 2021 18:46:52 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH mptcp-next v2] selftests: mptcp: add mp_fail testcases
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: Geliang Tang <geliang.tang@suse.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
 Davide Caratti <dcaratti@redhat.com>
References: <bfa01f99cbb0479029ad284b020dbb250d19b941.1635390811.git.geliang.tang@suse.com>
 <20211028092338.GA6915@dhcp-10-157-36-190>
 <CAKa-r6srprPPPhUCXW3YnsQEL0ewFBptQFvUo_9mwtw_mD7DOQ@mail.gmail.com>
 <de15a4e9-0140-2b18-7a5a-c010980eedc2@tessares.net>
 <CAKa-r6t_ajhpvO2PnGyL2E-0FuV+r9D1i31vO9J71M8XiajnkQ@mail.gmail.com>
 <0ea55f5c-df3a-2848-a9f4-a830cba876c1@tessares.net>
In-Reply-To: <0ea55f5c-df3a-2848-a9f4-a830cba876c1@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 28/10/2021 15:21, Matthieu Baerts wrote:
> Hi Davide,
> 
> On 28/10/2021 14:24, Davide Caratti wrote:
>> On Thu, Oct 28, 2021 at 1:21 PM Matthieu Baerts
>> <matthieu.baerts@tessares.net> wrote:
>>>
>>> Hi Davide, Geliang,
>>>
>>> On 28/10/2021 13:01, Davide Caratti wrote:
>>>> On Thu, Oct 28, 2021 at 11:23 AM Geliang Tang <geliang.tang@suse.com> wrote:
>>>>>
>>>>> On Thu, Oct 28, 2021 at 11:16:12AM +0800, Geliang Tang wrote:
>>>>>> Added the test cases for MP_FAIL, use 'tc' command to trigger the
>>>>>> checksum failure.
>>>>>>
>>>>>> Suggested-by: Davide Caratti <dcaratti@redhat.com>
>>>>>> Suggested-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>>>>>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
>>>
>>> Thank you for the new version!
>>>
>>>>>> ---
>>>>>>  tools/testing/selftests/net/mptcp/config      |  5 ++
>>>>>>  .../testing/selftests/net/mptcp/mptcp_join.sh | 60 ++++++++++++++++---
>>>>>>  2 files changed, 58 insertions(+), 7 deletions(-)
>>>>>>
>>>>>> diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
>>>>>> index 0faaccd21447..f522288b2204 100644
>>>>>> --- a/tools/testing/selftests/net/mptcp/config
>>>>>> +++ b/tools/testing/selftests/net/mptcp/config
>>>>>> @@ -15,3 +15,8 @@ CONFIG_NETFILTER_XTABLES=m
>>>>>>  CONFIG_NETFILTER_XT_MATCH_BPF=m
>>>>>>  CONFIG_NF_TABLES_IPV4=y
>>>>>>  CONFIG_NF_TABLES_IPV6=y
>>>>>> +CONFIG_NET_ACT_CSUM=m
>>>>>> +CONFIG_NET_ACT_PEDIT=m
>>>>>> +CONFIG_NET_CLS_ACT=m
>>>>>> +CONFIG_NET_CLS_FLOWER=m
>>>>>> +CONFIG_NET_SCH_INGRESS=m
>>>>>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>>>>>> index 7ef639a9d4a6..95bac447f857 100755
>>>>>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>>>>>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>>>>>> @@ -232,6 +232,29 @@ link_failure()
>>>>>>       done
>>>>>>  }
>>>>>>
>>>>>> +checksum_failure()
>>>>>> +{
>>>>>> +     i="$1"
>>>>>> +
>>>>>> +     tc -n $ns2 qdisc add dev ns2eth$i clsact
>>>>>> +     tc -n $ns2 filter add dev ns2eth$i egress \
>>>>>> +             protocol ip prio 1000 \
>>>>>> +             flower ip_proto tcp \
>>>>>> +             action pedit munge offset 148 u32 invert \
>>>>>> +             pipe csum tcp \
>>>>>> +             index 100
>>>>>> +
>>>>>> +     while true; do
>>>>>> +             local pkt=`tc -n $ns2 -j -s action show action csum index 100 | \
>>>>>> +                     awk -F ',' '{ print $12 }' | \
>>>>>> +                     awk -F ':' '{ print $2 }'`
>>>
>>> (small detail if you have to send a new version: it is often recommended
>>> to use "$(cmd)" form instead of `cmd`: more visible, allow nested
>>> commands, quotes, etc.)
>>
>> also, please consider using jq rather than awk. Specially if you are
>> planning to use more than one counter. For reference, see [1]
> 
> Good idea, I didn't know jq was used in other selftests. But then we
> would need to check if 'jq' is installed. *Maybe* if we only need once
> to retrieve 2 counters, it would be "easier" to use awk?
> 
>> [...]
>>>>
>>>>> How can I fix this?
>>>> is that a problem? maybe we can just ignore it.
>>>
>>> Do you have this message once or one for each packet?
>>> Does it increment the counter you are monitoring when the warning is
>>> printed?
>>>
>>> If I understand the code, it might print that once per packet and once
>>> but also increment the counter which is not good for us. But another
>>> counter -- "overlimits" -- seems to be incremented too, maybe we can use
>>> the two counters.
>>>
>>>> Otherwise, a possibility is to add a more narrow filter (e.g. flower),
>>>>  to only mangle packets that have the ack flag but not the syn or
>>>> push. We might also try corrupting the TCP payload to a smaller
>>>> offset, so that more packets are impacted.
>>>
>>> Yes, maybe good to narrow a bit the filter by using:
>>>
>>>   flower ip_proto tcp tcp_flags 0x10/0xff
>>>
>>> Or is there another filter to specify a minimum size?
>>
>> unfortunately we can't do that with TC filters (unless using the eBPF
>> classifier for this (and I'm still not 100% the verifier would be
>> happy _ but that's still in my long-term todo list :) ). I know there
>> are ongoing efforts to introduce a "check_pkt_larger" (because this
>> check is actually a possible openflow action) , but that won't happen
>> in the short period.
> 
> That's a shame but then better to restrict to ACK flag to omit a few
> packets.

As discussed at the last meeting, we should reduce the number of kernel
message (pr_info for each packet not matched by the pedit action). For that:
- best to restrict to TCP packets with ACK flag only:

    flower ip_proto tcp tcp_flags 0x10/0xff

- and send only in one direction to reduce the chance to have "pure ACKs".

Having a few pr_info message is OK but plenty messages in dmesg/serial
will likely cause other issues (flooding logs, slowing down stuff, etc.)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
