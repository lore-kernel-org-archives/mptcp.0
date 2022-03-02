Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9ED57A
	for <mptcp@lists.linux.dev>; Wed,  2 Mar 2022 15:45:42 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id pj17so220326ejb.2
        for <mptcp@lists.linux.dev>; Wed, 02 Mar 2022 07:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=IvYqoemLgrAE9m36bR3wJa6+/kaT3Oapbcogqe4SzpY=;
        b=DkqttKj7U5EHoCKvGrdQkSa3ZNIv/y7VXvlS4eeCY7US3xmr67xe1ymHXz5nV+EypJ
         HsmCsrInRgudNj0JFac0JTdDCDCZlHkWjTaBbY4LuvcFM0Cx5gkUL8ik737s5nkIuBYw
         lXG5TmCvfsL7boDIqlT78DkP7yDS6skUZ9RkwfSYb0McsFX8gh2l+zIWEOGYO7TOIHue
         ZxuLuVGl69E5oskGXO7ItGV+MxFHxuSeWAzakr7oftLkmsIUmrZrgy2JCmZD2l8JKGWB
         O/lAl6NBicyHH9Go9v0cP2omrW25S0wM7P0vZ2/Fid93xXylmBWjs/ggkN03UfRwbgXI
         lQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=IvYqoemLgrAE9m36bR3wJa6+/kaT3Oapbcogqe4SzpY=;
        b=CZhBPYiqQWX5yeBfNnmKVW+kxdHWY+YeKc4h0VMDssTPPctdHr+U0xDSE32OAAiPbN
         aQduY5y2hoYVpK4mZs0jklM0ZEhod9AOP6POBx0q6kyGdMPlxSlYdf94UBQ3FujFFuRN
         f6VW185K3PG0yt0NtbXpsPQGTN49hz/Z1vFjmU5tQ+Fx64cRVvl+wnmXP4k24HA6MjSv
         +8/pc7eU7xpWz0XqKCgZl/zmrqwMCbkCxcjhq9c/a1bqrCdeuQNHd5U64ScizypMx8e0
         dAKTMWH2NV+AgQaZD39dCsZu+PlSKjnvVnBQ1XiTTkUfJi2S3wyKeRU1F5lkZWilCund
         IgIg==
X-Gm-Message-State: AOAM5311FsGxwrq45NSzjCc21FZEttDS2uXpJuzImAcCzQcGYHCMKfia
	1++upyfVAu8pxLR+fE/CyK+FYXKAACHeDQ==
X-Google-Smtp-Source: ABdhPJxqnHXiFr6TnwaTr4wsdkb53iX2MC4ziZhQnM4noIT8femMhX7/NZgUXOTDT6rlwBiSxQ5yXA==
X-Received: by 2002:a17:907:3a13:b0:6cf:1186:1381 with SMTP id fb19-20020a1709073a1300b006cf11861381mr22931818ejc.539.1646235940375;
        Wed, 02 Mar 2022 07:45:40 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:37ec:5979:97fc:8ba4? ([2a02:578:8593:1200:37ec:5979:97fc:8ba4])
        by smtp.gmail.com with ESMTPSA id ga12-20020a170906b84c00b006bd3d11bf8csm6375222ejb.181.2022.03.02.07.45.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 07:45:39 -0800 (PST)
Message-ID: <40de3558-9505-f9cd-e6ac-7b26359dc380@tessares.net>
Date: Wed, 2 Mar 2022 16:45:38 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH mptcp-next 0/3] Upstreaming cleanup
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev, Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <20220218221814.72026-1-mathew.j.martineau@linux.intel.com>
 <ec7dea0e-36cd-4a47-daf2-ae4e2cb20aa3@tessares.net>
 <7120fc8c-cb24-c54f-67fd-5aaa7d32f8b@linux.intel.com>
 <431c81f9-e858-46c0-a2d1-6b32445dee3d@tessares.net>
In-Reply-To: <431c81f9-e858-46c0-a2d1-6b32445dee3d@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Paolo,

On 24/02/2022 15:41, Matthieu Baerts wrote:
> Hi Mat,
> 
> On 24/02/2022 01:25, Mat Martineau wrote:
>> On Sat, 19 Feb 2022, Matthieu Baerts wrote:
>>
>>> Hi Mat,
>>>
>>> On 18/02/2022 23:18, Mat Martineau wrote:
>>>> The most recent patch series I upstreamed for -net needed a couple of
>>>> tweaks to mitigate net/net-next merge conflicts. The first two patches
>>>> here update the commits in "fixes net" on the export branch to match
>>>> what I sent upstream, and the third patch restores Paolo's function
>>>> rename in mptcp_join.sh.
>>>
>>> Thank you for these patches!
>>>
>>> I was thinking a bit about how to avoid such "issues" in the future.
>>> Here are some ideas:
>>>
>>> - there could be 2 separated trees periodically updated:
>>>  - one for net-next, the one we have for the moment
>>>  - one for -net: a new one
>>>  → all patches for the -net tree would be duplicated in both trees
>>>  → when applying patches in the -net tree, we will notice the conflicts
>>>  → applying the different patches can be automated with the scripts I'm
>>> currently using
>>>
>>> - there could be 2 mixed trees periodically updated:
>>>
>>>
>>>            top
>>>
>>>             ^
>>>             |
>>>
>>>    commits for net-next
>>>
>>>             ^
>>>             |
>>>
>>>    merge net + net-next
>>>
>>>             ^
>>>            / \
>>>               \
>>>    net-next    \
>>>                 \
>>>
>>>                commits for -net (+ commits for the CI)
>>>
>>>                   ^
>>>                   |
>>>
>>>                  net
>>>
>>>
>>>  → no duplicated -net commits
>>>  → the "export" branch will be on top of net and net-next
>>>  → "mptcp: use kmalloc on kasan build" could be cherry-picked on top of
>>> the "export" branch for the -net tree not to have it "under" the ones
>>> for net-next.
>>>
>>> In both cases, it would be easy to export the different commits and have
>>> different tags that can be used by the CI.
>>>
>>> The second case looks interesting to me but there are at least two main
>>> points to be careful with:
>>>
>>> - if the "export" branch is on top of the net-next branch, it means the
>>> patches we have in the tree might no longer apply as is in net-next:
>>> that's the opposite situation as of today where the patches for -net are
>>> on top of net-next. I think that's fine because we would have this issue
>>> in any case if a patch for net-next depend on one that has been
>>> queued/applied in -net but is not in net-next yet.
>>>
>>
>> I don't think it changes the situation for the mptcp-next patches - even
>> today, they are on top of the mptcp-net patches which is what would
>> potentially cause problems sending to net-next.
>>
>> Since I apply the patches to net-next and resolve conflicts before
>> sending to netdev, it's not too big of a concern. I think your proposal
>> here is an improvement because fewer adjustments will be needed when
>> sending the -net patches to netdev.
>>
>>
>> I would adjust your diagram this way:
>>
>>
>>            export
>>
>>              ^
>>              |
>>
>>     kmalloc on ksan build
>>
>>              ^
>>              |
>>
>>     commits for net-next
>>
>>              ^
>>              |
>>
>>     merge net + net-next
>>
>>              ^
>>             / \        export-net
>>                \      /
>>     net-next    \    kmalloc on ksan build
>>     (rebase      \  /
>>      daily)
>>                 commits for -net (+ commits for the CI)
>>
>>                    ^
>>                    |
>>
>>                   net (rebase on upstream net-next sync,
>>                        as you suggest below)
>>
>> Then people could check out export-net when developing mptcp-net patches.
> 
> Yes, that's what I had in mind for the extra patches for the CI (for
> KASAN, GitHub Actions and Cirrus).

I was looking at updating the tree as discussed above. I started by
doing some tests with a new Git Project to simulate the situation.

For the moment I have something like (from 'git log --graph'):


        * export
        *   (...)
        *   MPTCP commits for net-next
        *   (...)
        |\
        | *   (...)
        | * MPTCP commits for -net
        | *   (...)
        * | top of net-next branch
        |\|
        | * top of -net branch
        | | (...)

Would that work for you?
Or do you prefer if I do some tests on a separated repo?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
