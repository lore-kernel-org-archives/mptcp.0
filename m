Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7DE2F25
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 08:56:34 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id y3so5340649ejf.2
        for <mptcp@lists.linux.dev>; Wed, 09 Feb 2022 00:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8WOaXUABMjIvKuLRSMPV8Vudd+Zi3rjKkIP09Q/6KJY=;
        b=8MIUFYaSQDty65xxjlyqE/3dI3++KtCBOPKzE8kdNHkaKk8rGbYH3nVvO5NllQW1bC
         Kwx3jib63jvUTnTljzTkvY7+cg9pYA3kTPd4X4jb2cB7gngrd+PKrXhYOmo1N+9bn+p1
         oxB8617TTNJlSqgBLgrkKQMdnmX9hwM57ydO6ZVYqgfiXIQozCCC8kVK56jxRAtygMZA
         Av9GB9xBkfKhAXHYLbBNXyxtMnmIi86TeCMZ3kg/r8Vthtf5qSwRvxbBn41Q+1Grf3ua
         vn+pH8c5WJz+dqM6R+bCaGsu5wEbGJ0TtBqJxQFRmezywbakM9qhiWVt4HJwG9/sF49L
         868Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8WOaXUABMjIvKuLRSMPV8Vudd+Zi3rjKkIP09Q/6KJY=;
        b=TXeM0Du8FvhLuYS4T7dQjG6Ruuh5cdkQLuJ7j9zRn/MpPgsGx06Y4S148dd+r9iyTh
         FDmfJx7IYyh3MDJSc0QSfFQQpg9nzDV2+eoK2Dedswv0eOvFuKYzfwdXqZbzPClZDe0e
         Ud6/UKxJ4D//xX6zmzMjOblEHhVjFLJqwDiL1rXZqnquun/XuIbhta+eJ5rSlHxhqzQS
         g9pSH2dcjBUcVA4bH1UFRzqUZmTuaoi6hKC2deA2sC1tpM6WU1q0lvmdCUlrWvRwNZ/G
         EhMO7dOQtnQRII8ImSLp9OpiGe8Kkxuom4iMSfCv7rok8I5VT9VEMP+N+OeAL6ioZHrE
         CGhQ==
X-Gm-Message-State: AOAM530oW/z6t1mGXEh4zuWGQwbkX08E2QtYLat6CTnfTj53M5vLodWw
	99MVw6we3Gsam1IvIWEXYjK38g==
X-Google-Smtp-Source: ABdhPJy0ObR0yOejjbxvuf9Gaigu81tteWCbrvxnveC9s2TPUvjol3n6v/h6Q89RyMZ+L3oce0WQDg==
X-Received: by 2002:a17:906:7489:: with SMTP id e9mr994585ejl.113.1644396992101;
        Wed, 09 Feb 2022 00:56:32 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:43c2:5bca:4e2c:3c7d? ([2a02:578:8593:1200:43c2:5bca:4e2c:3c7d])
        by smtp.gmail.com with ESMTPSA id o3sm3068101edt.67.2022.02.09.00.56.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 00:56:31 -0800 (PST)
Message-ID: <0de494ee-7c30-0c08-6248-3a55f3043d4e@tessares.net>
Date: Wed, 9 Feb 2022 09:56:31 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH mptcp-next v2 2/2] selftests: mptcp: add mp_fail testcases
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev, Davide Caratti <dcaratti@redhat.com>
References: <cover.1644364562.git.geliang.tang@suse.com>
 <846d7cac1f134fe9d3b6e8ac2b0c0ab47defc341.1644364562.git.geliang.tang@suse.com>
 <358eb7b4-84fe-d8e5-c0fa-e172c8deb7@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <358eb7b4-84fe-d8e5-c0fa-e172c8deb7@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 09/02/2022 03:10, Mat Martineau wrote:
> On Wed, 9 Feb 2022, Geliang Tang wrote:

(...)

>> +    ip netns exec $ns2 iptables \
>> +        -t mangle \
>> +        -A OUTPUT \
>> +        -o ns2eth$i \
>> +        -p tcp \
>> +        -m length --length 150:9999 \
>> +        -m statistic --mode nth --packet 1 --every 99999 \
>> +        -j MARK --set-mark 42
>> +
> 
> I think it would help to check the exit code of iptables here, my first
> attempt was with a misconfigured kernel and it would help to fail in a
> more informative way:
> 
> $ sudo ./mptcp_join.sh -F
> Created /tmp/tmp.P4AWbNYGQ5 (size 1 KB) containing data sent by client
> Created /tmp/tmp.ny1Q9MWo85 (size 1 KB) containing data sent by server
> iptables v1.8.7 (legacy): Couldn't load match `length':No such file or
> directory
> Try `iptables -h' or 'iptables --help' for more information.
> Error: TC classifier not found.
> We have an error talking to the kernel

I understand it is not good to ignore the error but just to be sure,
here you suggest to exit with an error, right?

In Geliang's v3, the whole test is skip but I don't think that's a good
idea.

I mean: we manage a kernel config file so we expect the right kernel
config is applied. If the kconfig is not the correct one, that's an error.
For the tools, that's different and that's why we check if iptables tool
is available. (a plugin might be missing but no need to check everything
I think).

In other words, I think we should add a " || exit 1" after the IPTables
and TC commands in this function.

@Geliang: WDYT?

(...)

>> +get_nr_mp_fail()
>> +{
>> +    i="$1"
>> +
>> +    local action=$(tc -n $ns2 -j -s action show action pedit index 100)
>> +    local packets=$(echo $action | jq '.[1].actions[0].stats.packets')
>> +
>> +    if [ $packets -gt 0 ]; then
> 
> This triggered a bash parsing error when I did not have the added
> netfilter kernel config options:
> 
> $ sudo ./mptcp_join.sh -F
> Created /tmp/tmp.P4AWbNYGQ5 (size 1 KB) containing data sent by client
> Created /tmp/tmp.ny1Q9MWo85 (size 1 KB) containing data sent by server
> iptables v1.8.7 (legacy): Couldn't load match `length':No such file or
> directory
> Try `iptables -h' or 'iptables --help' for more information.
> Error: TC classifier not found.
> We have an error talking to the kernel
> Created /tmp/tmp.CvX8qnG1gC (size 512 KB) containing data sent by client
> Created /tmp/tmp.wenxUAgsj8 (size 512 KB) containing data sent by server
> ./mptcp_join.sh: line 310: [: null: integer expression expected

I think we don't have to deal with this error if we already check if the
previous TC commands were OK, no?

(...)

>> +fail_tests()
>> +{
>> +    # multiple subflows
>> +    reset_with_fail 2
>> +    pm_nl_set_limits $ns1 0 2
>> +    pm_nl_set_limits $ns2 0 2
>> +    pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
>> +    pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow
>> +    run_tests $ns1 $ns2 10.0.1.1 3
>> +    get_nr_mp_fail 2
>> +    chk_join_nr "$nr_mp_fail MP_FAIL, multiple subflows, MP_RST" 2 2
>> 2 $nr_mp_fail
> 
> Is the first $nr_mp_fail supposed to be in the test description? It's
> not clear what it means in the test output.

In the v3, this is written after, it can help if this test fails.

But I don't think we should use it in the MP FAIL we expect. Otherwise
we will have the same situation Mat had: IPTables and TC commands fail
but the test showed no error :)

So we should have:

  chk_join_nr "MP_FAIL (...) $nr_mp_fail" 2 2 2 1

No?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
