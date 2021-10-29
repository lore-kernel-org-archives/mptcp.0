Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6E42C87
	for <mptcp@lists.linux.dev>; Fri, 29 Oct 2021 19:51:05 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id 5so41198542edw.7
        for <mptcp@lists.linux.dev>; Fri, 29 Oct 2021 12:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=M4aicsnfdfz9BCLWo6FXyFKczlDD01XeZaK1RXDmS8s=;
        b=aQZnGLph/a630BO5/k4v08HCIY1I6RTzbig8qhZ83Z9HIqQ8Ls4hgkC/p6qav95FaM
         xsFumB7gycmZ0ffh/yJDRLWjTCzHcqvZcwYZ5n8QOltLOCISBF1H2F+Q1m0KTa9Qchq0
         5zqVepA8bVdRUedxWBiqpn29kZ/z0UPzViEgagLndQp3Lllm6nQri8mAD0tESp8S8Hgt
         Rh0tkOu6qFiU7cQR13HcZw5eRtFpL/1hz6w33Xp/9/gdGFSvjdyV9pds5HIBaPdTbyZz
         Z1lUP7vlYocQFFn951IxbJ8qrEhk+01BeV8LjT6qmHWVdkFKAyZSc1eSxkjsECoYmZRu
         2YLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=M4aicsnfdfz9BCLWo6FXyFKczlDD01XeZaK1RXDmS8s=;
        b=yPVLuo4cuJGkdZhMTeYhK6QCQIgYOTpXHkR5r4EQPYj8byk0AKRi4FRVsaqQOEY59w
         rqdOTH3WUGhRMbHDeFIEtT68GOv23dpoudh6BLbcBXB3oP/v8FLPkCKmWai+6jgNvwiJ
         rC/TzvXojzBlb57vTc1lvAtcV3wObw74DC+58NRhXVKFeDBrQhq3xpCJWtMyezor9Gi2
         +ZHHsPiIDHbtuLMlGaoAGP/6UoeHkZvTAX4KHz9rtMvFds7AO/Ligst4NG1pE+nAJk0J
         H+KRV1e6R8oe55BoLZaI7OwvKxzsTvtTG4KKA/uHIBQK0eS/5i1tV5F4fYNx22g8VbgJ
         edlA==
X-Gm-Message-State: AOAM5314n0Zl1ZvWlzgePuSRMMZa140jeTLdBvIl48yz2GzWaB7C5ouw
	kXZ0bsbz8SWpyjC3RiHbm+tZPA==
X-Google-Smtp-Source: ABdhPJwKOM7m5hd2r4ww1d11ZKSeKhmueqTgSlY27oPVxq7yWHXATxIseGhFeR8COr0va4o6mw7YXw==
X-Received: by 2002:a17:906:ce38:: with SMTP id sd24mr15963348ejb.316.1635537064000;
        Fri, 29 Oct 2021 12:51:04 -0700 (PDT)
Received: from [192.168.178.46] ([213.211.156.121])
        by smtp.gmail.com with ESMTPSA id oz40sm3530163ejc.82.2021.10.29.12.51.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Oct 2021 12:51:03 -0700 (PDT)
Message-ID: <9ec8b2c5-853a-2009-d74a-12e4e565d426@tessares.net>
Date: Fri, 29 Oct 2021 21:51:02 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH mptcp-next v8 8/8] selftests: mptcp: add mp_fail testcases
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
References: <cover.1635481641.git.geliang.tang@suse.com>
 <ff613391540609e31cf4aff5abefaa03fbd63278.1635481641.git.geliang.tang@suse.com>
 <04774993-d824-0f62-c55d-bd21e46b99fb@tessares.net>
 <20211029132155.GA4144@bogon>
 <62321b89a616b27bd9bd2eaf2a38e7f91f56cb55.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <62321b89a616b27bd9bd2eaf2a38e7f91f56cb55.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Geliang,

On 29/10/2021 16:43, Paolo Abeni wrote:
> On Fri, 2021-10-29 at 21:21 +0800, Geliang Tang wrote:
>> Hi Matt,
>>
>> On Fri, Oct 29, 2021 at 12:02:47PM +0200, Matthieu Baerts wrote:
>>> Hi Geliang,
>>>
>>> Thank you for the new version.
>>>
>>> On 29/10/2021 06:40, Geliang Tang wrote:
>>>> Added the test cases for MP_FAIL, use 'tc' command to trigger the
>>>> checksum failure.
>>>>
>>>> Suggested-by: Davide Caratti <dcaratti@redhat.com>
>>>> Suggested-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>>>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
>>>> ---
>>>>  tools/testing/selftests/net/mptcp/config      |  5 ++
>>>>  .../testing/selftests/net/mptcp/mptcp_join.sh | 75 +++++++++++++++++--
>>>>  2 files changed, 72 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
>>>> index 0faaccd21447..f522288b2204 100644
>>>> --- a/tools/testing/selftests/net/mptcp/config
>>>> +++ b/tools/testing/selftests/net/mptcp/config
>>>> @@ -15,3 +15,8 @@ CONFIG_NETFILTER_XTABLES=m
>>>>  CONFIG_NETFILTER_XT_MATCH_BPF=m
>>>>  CONFIG_NF_TABLES_IPV4=y
>>>>  CONFIG_NF_TABLES_IPV6=y
>>>> +CONFIG_NET_ACT_CSUM=m
>>>> +CONFIG_NET_ACT_PEDIT=m
>>>> +CONFIG_NET_CLS_ACT=m
>>>> +CONFIG_NET_CLS_FLOWER=m
>>>> +CONFIG_NET_SCH_INGRESS=m
>>>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>>>> index 2684ef9c0d42..d33cb5ce0ff3 100755
>>>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>>>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>>>> @@ -178,6 +178,12 @@ if [ $? -ne 0 ];then
>>>>  	exit $ksft_skip
>>>>  fi
>>>>  
>>>> +jq -V > /dev/null 2>&1
>>>> +if [ $? -ne 0 ];then
>>>> +	echo "SKIP: Could not run all tests without jq tool"
>>>> +	exit $ksft_skip
>>>> +fi
>>>> +
>>>>  print_file_err()
>>>>  {
>>>>  	ls -l "$1" 1>&2
>>>> @@ -232,6 +238,28 @@ link_failure()
>>>>  	done
>>>>  }
>>>>  
>>>> +checksum_failure()
>>>> +{
>>>> +	i="$1"
>>>> +
>>>> +	tc -n $ns2 qdisc add dev ns2eth$i clsact
>>>> +	tc -n $ns2 filter add dev ns2eth$i egress \
>>>> +		protocol ip prio 1000 \
>>>> +		flower ip_proto tcp \
>>>> +		action pedit munge offset 148 u32 invert \
>>>> +		pipe csum tcp \
>>>> +		index 100
>>>> +
>>>> +	while true; do
>>>> +		local pkt=$(tc -n $ns2 -j -s action show action csum index 100 |
>>>> +				jq '.[1].actions[0].stats.packets')
>>>> +		if [ $pkt -gt 0 ]; then
>>> The CI [1] is complaining about that line:
>>>
>>> [09:34:44.063] # RTNETLINK answers: Operation not supported
>>> [09:34:44.107] # ./mptcp_join.sh: line 256: [: null: integer expression
>>> expected
>>> [09:34:44.267] # RTNETLINK answers: Operation not supported
>>> [09:34:44.332] # ./mptcp_join.sh: line 256: [: null: integer expression
>>> expected
>>> (...)
>>>
>>> This is displayed in a loop as it is a "while true".
>>>
>>> But just before the first one, we had this:
>>>
>>> [09:34:43.859] # Error: Cannot find ingress queue for specified device.
>>> [09:34:43.955] # Error: Parent Qdisc doesn't exists.
>>> [09:34:43.959] # We have an error talking to the kernel
>>>
>>> I guess the previous "tc" command failed and I also guess you don't have
>>> that on your side, right?
>>
>> Yes, it works on my side.
>>
>>> Maybe a missing kconfig?
>>
>> I think so. How can I get the kconfig of the CI?
> 
> The need kernel config flags are correctly specified into:
> 
> tools/testing/selftests/net/mptcp/config
> 
> In this case it looks like the CI is missing/not applying:
> 
> CONFIG_NET_SCH_INGRESS=y
> 
> @Mat, does the CI take properly in account the self-tests config?
> 
> I guess:
> 
> make kselftest-merge
> 
> would fix, but could also be overkill (pulling a lot of config for
> other, non mptcp self-tests)

I'm using something like:

  ./scripts/kconfig/merge_config.sh -m (...)/.config \
     tools/testing/selftests/net/mptcp/config

But I guess the issue is in the config we give:

.config:5004:warning: symbol value 'm' invalid for NET_CLS_ACT

It should then be set to =y. Sorry, I didn't see that before.
I can also change that when applying the patch if no other modifications
are needed. (and if I don't forget :) )

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
