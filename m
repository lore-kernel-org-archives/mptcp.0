Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFC029CA
	for <mptcp@lists.linux.dev>; Thu, 28 Oct 2021 11:21:39 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id h7so23779045ede.8
        for <mptcp@lists.linux.dev>; Thu, 28 Oct 2021 04:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Ct261T26XuQLtbJ266jyiELLD4CeJLT7LShzGNRZkTs=;
        b=ShKXjyau/Q+1kDhgTEbPeNi7UoBNq26Ycif6ZMFFY4VpN3+mxlXwitHAcN9jp/08Wq
         Wu/n8ri5t66nEQd3jwb03WmZK8N2A5Hd32ZesFHHYXWQ6qWYcCWPK9n7ECrcFsMJYXBg
         b0QskGuzkPNlSX59E3tDI5W7zXqG7otnAd8FsfW04g+43azi8WI/tR5kMNkg07enk4Q4
         IWbcV0dO5HKcclV35yLex2gKdS46tj2uVfs3sqCcewQv9Z+GdLwh2ZRI2aodGbHjbGcT
         Zhlwz+ndhrOtmb797z6Ri5+nj5TL8at51fb6VAGHzVHgOE9PjPe5NlDXhwX/Qw8hosrP
         /WqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ct261T26XuQLtbJ266jyiELLD4CeJLT7LShzGNRZkTs=;
        b=NlakEfJPIWGFQZBye5/GP2acASVWWLBhGFOB/+fkJZbYZ95kYCywhUOsCNrbnbOTwl
         JWO2uRSIUYw6X6vNqWTp9HKzLGPmixCVn2xT8u4KNk+BrlXO8i2i60V8lYT18IQj0UL8
         J6n69itJ5Ac/yR4bx9UP8kwyUjr69MfRgNmwpNYnHtHQXkwTW6cqECck64Oeqh3tq5Nt
         I6843jBbnUxsKGw6Q+YPCd48MRmPD313NZ6UzDyZKXYzxR1iaVtvBCv53cn/BwNLRxEM
         p9N3fRVqB6CQj/i3d5u5am1FCtZ5Zvtn0F+kJFuAlIP5dsFa1vPir+TVUGOs/n5/TJEi
         giMw==
X-Gm-Message-State: AOAM531v13j+PNKhtkOQ6cRdb6QcnnT7ZoGGytoqLHlaECv50HHkqKoz
	gUmMTH2Oz7qi06DO/3fg00VOpw==
X-Google-Smtp-Source: ABdhPJwYJCvcVLvIEvoZ5F6xF4nV6aOT6ffVbakJsjcIgtQ/rQklQxnRb99emg1NroHarXHtLNjndQ==
X-Received: by 2002:a17:907:628f:: with SMTP id nd15mr4655132ejc.389.1635420098196;
        Thu, 28 Oct 2021 04:21:38 -0700 (PDT)
Received: from [10.44.1.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id v9sm1180682ejq.55.2021.10.28.04.21.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Oct 2021 04:21:37 -0700 (PDT)
Message-ID: <de15a4e9-0140-2b18-7a5a-c010980eedc2@tessares.net>
Date: Thu, 28 Oct 2021 13:21:37 +0200
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
To: Davide Caratti <dcaratti@redhat.com>, Geliang Tang <geliang.tang@suse.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
References: <bfa01f99cbb0479029ad284b020dbb250d19b941.1635390811.git.geliang.tang@suse.com>
 <20211028092338.GA6915@dhcp-10-157-36-190>
 <CAKa-r6srprPPPhUCXW3YnsQEL0ewFBptQFvUo_9mwtw_mD7DOQ@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <CAKa-r6srprPPPhUCXW3YnsQEL0ewFBptQFvUo_9mwtw_mD7DOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Davide, Geliang,

On 28/10/2021 13:01, Davide Caratti wrote:
> On Thu, Oct 28, 2021 at 11:23 AM Geliang Tang <geliang.tang@suse.com> wrote:
>>
>> On Thu, Oct 28, 2021 at 11:16:12AM +0800, Geliang Tang wrote:
>>> Added the test cases for MP_FAIL, use 'tc' command to trigger the
>>> checksum failure.
>>>
>>> Suggested-by: Davide Caratti <dcaratti@redhat.com>
>>> Suggested-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>

Thank you for the new version!

>>> ---
>>>  tools/testing/selftests/net/mptcp/config      |  5 ++
>>>  .../testing/selftests/net/mptcp/mptcp_join.sh | 60 ++++++++++++++++---
>>>  2 files changed, 58 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
>>> index 0faaccd21447..f522288b2204 100644
>>> --- a/tools/testing/selftests/net/mptcp/config
>>> +++ b/tools/testing/selftests/net/mptcp/config
>>> @@ -15,3 +15,8 @@ CONFIG_NETFILTER_XTABLES=m
>>>  CONFIG_NETFILTER_XT_MATCH_BPF=m
>>>  CONFIG_NF_TABLES_IPV4=y
>>>  CONFIG_NF_TABLES_IPV6=y
>>> +CONFIG_NET_ACT_CSUM=m
>>> +CONFIG_NET_ACT_PEDIT=m
>>> +CONFIG_NET_CLS_ACT=m
>>> +CONFIG_NET_CLS_FLOWER=m
>>> +CONFIG_NET_SCH_INGRESS=m
>>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>>> index 7ef639a9d4a6..95bac447f857 100755
>>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>>> @@ -232,6 +232,29 @@ link_failure()
>>>       done
>>>  }
>>>
>>> +checksum_failure()
>>> +{
>>> +     i="$1"
>>> +
>>> +     tc -n $ns2 qdisc add dev ns2eth$i clsact
>>> +     tc -n $ns2 filter add dev ns2eth$i egress \
>>> +             protocol ip prio 1000 \
>>> +             flower ip_proto tcp \
>>> +             action pedit munge offset 148 u32 invert \
>>> +             pipe csum tcp \
>>> +             index 100
>>> +
>>> +     while true; do
>>> +             local pkt=`tc -n $ns2 -j -s action show action csum index 100 | \
>>> +                     awk -F ',' '{ print $12 }' | \
>>> +                     awk -F ':' '{ print $2 }'`

(small detail if you have to send a new version: it is often recommended
to use "$(cmd)" form instead of `cmd`: more visible, allow nested
commands, quotes, etc.)

Also if a v3 is needed, do not hesitate to add in a comment an example
of the output just in case it changes later and also to better
understand what you are trying to extract :)

>>> +             if [ $pkt -gt 0 ]; then
>>> +                     tc -n $ns2 qdisc del dev ns2eth$i clsact
>>> +                     break
>>> +             fi
>>> +     done
>>> +}
>>
>> I got this log in the dmesg output:
>>
>> [ 2495.182631] tc action pedit offset 162 out of bounds
>>
>> It looks like something wrong with tc.
> 
> this is a packet too small to be edited by pedit:
> 
> https://elixir.bootlin.com/linux/latest/source/net/sched/act_pedit.c#L368
> 
> when this happens, pedit gives up mangling and passes the packet to
> the next action (csum in your case, but it's useless)
> 
>> How can I fix this?
> is that a problem? maybe we can just ignore it.

Do you have this message once or one for each packet?
Does it increment the counter you are monitoring when the warning is
printed?

If I understand the code, it might print that once per packet and once
but also increment the counter which is not good for us. But another
counter -- "overlimits" -- seems to be incremented too, maybe we can use
the two counters.

> Otherwise, a possibility is to add a more narrow filter (e.g. flower),
>  to only mangle packets that have the ack flag but not the syn or
> push. We might also try corrupting the TCP payload to a smaller
> offset, so that more packets are impacted.

Yes, maybe good to narrow a bit the filter by using:

  flower ip_proto tcp tcp_flags 0x10/0xff

Or is there another filter to specify a minimum size?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
