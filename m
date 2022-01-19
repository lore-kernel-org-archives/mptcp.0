Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12702168
	for <mptcp@lists.linux.dev>; Wed, 19 Jan 2022 10:32:36 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id f17so553056edw.2
        for <mptcp@lists.linux.dev>; Wed, 19 Jan 2022 02:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KYRn8JEKopYKrGpTqLhcS/HP0UVIvrOqoegVS3dzqDM=;
        b=eta0lURbSqV91ezf6ziYouZ1jzRFFzhY/hL9bB2Jmn7GBezu01Mx+zHm3tQ2SDfUkc
         /5xWr1X/mxbI8oujiTxEQMV6J3RPkYP8CHXL3oBHnAMcFvDsm5ukrTETg1o8nga3FNjv
         vp16fUGajeQwRU6exgsRfGKKk45uAf6G6i3A3kxATPim52LIIyPJMRtVNtRZSWGOYeqW
         j/BSNNHekDR3cGHglLFkDkK93ZOoado4MPm6MXZIXXvreqsL9Lwkeycnng2STSzxfn2S
         XrFIpCbGA+iaEcaoEVoohhdtrrLCQomAnjNZfKHDToo2Bbf8x88o/udGIYTCf49OEB8D
         /BWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KYRn8JEKopYKrGpTqLhcS/HP0UVIvrOqoegVS3dzqDM=;
        b=AI1A41cZp49pblA2nibKcfpRVoKigw0jxd1V9l90F+sdgj1tPl+QPGe8pprHBLHcIf
         AG3xIR6DRkxivnxirOwhEH8jqGEVXGnvguMxrlJRmff+rPACxm2Exf1k7bs7JZudBwNk
         o+gtvaY1gUpSH6vv0a3KM1q7YUixsHqCguUiRPEOMgN73ngQQSVe7hixgQlGVnuRp3Vo
         urPsNxZIin/rrv/g+zUVbT6l1vF4z6DC1BHpWpDn2IyK+JbVCDrHAdEgnynvKaazWz4v
         RcysHYe+tChGYBR4/uTLJWifBo5QqLw7wARuuTXsHxXv2WRLNBNTjjXildpEuZN8Zg6v
         oF3Q==
X-Gm-Message-State: AOAM531CFdJw7OE+MOneqlwcNATT7SotS5YFNYeDfk8UE9X7FRneq5eQ
	fWu22EClec8NvYqfFN2LQ1OtaQ==
X-Google-Smtp-Source: ABdhPJzp7G4v2817PUHPvmaZEmqxM1tkap59s0tbwRorD2SbTeAUcm74hKhO/lg0fLwiPQhHZjBmhw==
X-Received: by 2002:a05:6402:40d0:: with SMTP id z16mr30318714edb.68.1642588355000;
        Wed, 19 Jan 2022 02:32:35 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:317c:d250:a7d4:7951? ([2a02:578:8593:1200:317c:d250:a7d4:7951])
        by smtp.gmail.com with ESMTPSA id dd6sm1824130ejc.212.2022.01.19.02.32.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jan 2022 02:32:34 -0800 (PST)
Message-ID: <f5480b3a-1ecd-23ad-5f7b-b362acdeb7bc@tessares.net>
Date: Wed, 19 Jan 2022 11:32:33 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH mptcp-next v9 5/5] selftests: mptcp: add mp_fail testcases
Content-Language: en-GB
To: Davide Caratti <dcaratti@redhat.com>
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 MPTCP Upstream <mptcp@lists.linux.dev>, Geliang Tang <geliang.tang@suse.com>
References: <cover.1641804767.git.geliang.tang@suse.com>
 <a0f7ec766ca99a5f2e2aa27a358f45fc06f6cc78.1641804767.git.geliang.tang@suse.com>
 <ea44a519-11b9-175-cceb-abb69232abbd@linux.intel.com>
 <a1679740-24ed-c788-46df-ad195068dd37@linux.intel.com>
 <CAKa-r6sgL1UUES5WYryNYedLJuq0_dEsO=X1263GFPOExci6BQ@mail.gmail.com>
 <eb7a9238-6fda-761e-23e9-47fbe332705f@tessares.net>
 <CAKa-r6t75QbV-BE3rKvUHVCBYmcO1eW2typSFUgPSA34uDFEPw@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <CAKa-r6t75QbV-BE3rKvUHVCBYmcO1eW2typSFUgPSA34uDFEPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Davide,

On 18/01/2022 17:48, Davide Caratti wrote:
> On Tue, Jan 18, 2022 at 3:15 PM Matthieu Baerts
> <matthieu.baerts@tessares.net> wrote:
>>
>> Hi Davide,
>>
>> On 18/01/2022 14:32, Davide Caratti wrote:
>>> hello,
>>>
>>> started looking at this, but the wild-guess is that the problem should
>>> be fixed with [1]: I'll do a quick test on my VM now.
>>>
>>> [1] https://lore.kernel.org/netdev/20220110094750.236478-1-eric.dumazet@gmail.com/
>>
>> Good point, it might be linked to that.
> 
> hello,
> 
> confirmed, the problem happens when kernels are built with
> CONFIG_NET_NS_REFCNT_TRACKER=y and the problem is fixed by the
> above-mentioned patch from Eric.

Thank you for having checked!

I just added this patch in our tree:

- 943a4ed011fc: net: sched: do not allocate a tracker in tcf_exts_init()
- Results: a99ed2058930..fbaefb5453f9

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220119T102401
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

I guess I should better enable this kconfig option for the debug builds, no?

Cheers,
Matt


-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
