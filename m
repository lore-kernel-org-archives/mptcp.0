Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14D1DF56
	for <mptcp@lists.linux.dev>; Thu, 17 Aug 2023 08:28:10 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-3fe1d9a8ec6so4030085e9.1
        for <mptcp@lists.linux.dev>; Thu, 17 Aug 2023 01:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1692260889; x=1692865689;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NjT6YjR1k085Z4PQDRv1hONhUEJap5CFDVXBlpQg+Ms=;
        b=Z0h2iXHnYumuOQaOmyM6YeR7xsqncsiWMhpvoLH8yFAw5MJkg6M+cMrRT/4FVU65pO
         VpXYR632Q/uf8YM2oljXBm6ph2WM0bWSfxbnunqWKMPTAH8svL8i1NRcZBNGNmDgq3AW
         RTMN+sNCeIIy5sVMWqPBz02dSyMGH/B64HDsfUiR3SBfsJR5nkB0fEqkj+XSvTb+Xg/8
         nP44ROr1Gn7/82YC1kiZZ0PhyGWmuR/hkj+0AUETqgLFkMu6HZjNgUjxpTaL225kifPS
         /pUO4bT+L5ro7Oqsv6QFEEdlS708BrfgMwbvRNH5lOoOiiyjg9u0GUTyd5hjLWaNOIiC
         cEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692260889; x=1692865689;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NjT6YjR1k085Z4PQDRv1hONhUEJap5CFDVXBlpQg+Ms=;
        b=QkISPIzwO5NtkgVMvWmqMbNSD+ibNa6ZZb71c4q0k65mgQTcyhuVLCrNYE39d+kNE4
         WeshbjYu13C5xUa1r3bkp33VQx3AaBhACS1AIPxC3Nx5pb14hdbMolp1uiigzo8coWKp
         5XAls8ZCHwjIqbVkTkJbk505cDS4gPNG8dJRuXQLe3SbNNJyklM5ZR+YqxDEoe5tiW3V
         Fnouelx3d39bBmrr9AmJbcIYOeDX8L4WqcIUPkZIMg1A65bE50QjH4RzqCs1A54RFB69
         E075X+jSAw7QtYuvZXxL6oIr1vn6rllFNiZPdVtYnp0a5X9WrcuXwO7lIW1mDRA7fPe+
         iX/g==
X-Gm-Message-State: AOJu0YxIXcy3tgh9gmMG39NutyV/c0NCtktuYPnnyo+GQ51BtWiFih4R
	JuIgs6EEdpHUY38sVAhSB2YVdCnvoncPE+AmOdU=
X-Google-Smtp-Source: AGHT+IEZo+RsU0XMMwmjGhPYYG6jdV6xWXuM8xtr4tL55K3y1J2o2OIMROF9zQXaKOw0KwkhUYSo9w==
X-Received: by 2002:a5d:5943:0:b0:315:acbc:cab6 with SMTP id e3-20020a5d5943000000b00315acbccab6mr1513180wri.16.1692260888525;
        Thu, 17 Aug 2023 01:28:08 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:c88:d59b:1c03:4962? ([2a02:578:8593:1200:c88:d59b:1c03:4962])
        by smtp.gmail.com with ESMTPSA id z10-20020a5d4d0a000000b0031ad5a54bedsm1834501wrt.9.2023.08.17.01.28.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 01:28:08 -0700 (PDT)
Message-ID: <19ddc11e-5bf4-499e-9c34-e264755b61d8@tessares.net>
Date: Thu, 17 Aug 2023 10:28:07 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v11 2/5] selftests/bpf: Use random netns name for
 mptcp
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
References: <cover.1691125344.git.geliang.tang@suse.com>
 <15d7646940fcbb8477b1be1aa11a5d5485d10b48.1691125344.git.geliang.tang@suse.com>
 <8b706f66-2afa-b3d0-a13a-11f1ffb452fe@linux.dev>
 <20230807064044.GA11180@localhost.localdomain>
 <9a84e026-402d-b6d9-b6d1-57d91455da47@linux.dev>
 <20230809081944.GA29707@bogon>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <20230809081944.GA29707@bogon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

(only with MPTCP list)

On 09/08/2023 10:19, Geliang Tang wrote:
> On Tue, Aug 08, 2023 at 11:03:30PM -0700, Martin KaFai Lau wrote:
>> On 8/6/23 11:40 PM, Geliang Tang wrote:
>>> On Fri, Aug 04, 2023 at 05:23:32PM -0700, Martin KaFai Lau wrote:
>>>> On 8/3/23 10:07 PM, Geliang Tang wrote:
>>>>> Use rand() to generate a random netns name instead of using the fixed
>>>>> name "mptcp_ns" for every test.
>>>>>
>>>>> By doing that, we can re-launch the test even if there was an issue
>>>>> removing the previous netns or if by accident, a netns with this generic
>>>>> name already existed on the system.
>>>>>
>>>>> Note that using a different name each will also help adding more
>>>>> subtests in future commits.
>>>
>>> Hi Martin,
>>>
>>> I tried to run mptcp tests simultaneously, and got "Cannot create
>>> namespace file "/var/run/netns/mptcp_ns": File exists" errors sometimes.
>>> So I add this patch to fix it.
>>>
>>> It's easy to reproduce, just run this commands in multiple terminals:
>>>   > for i in `seq 1 100`; do sudo ./test_progs -t mptcp; done
>>
>> Not only the "-t mptcp" test. Other tests in test_progs also don't support
>> running parallel in multiple terminals. Does it really help to test the bpf
>> part of the prog_tests/mptcp.c test by running like this? If it wants to
>> exercise the other mptcp networking specific code like this, a separate
>> mptcp test is needed outside of test_progs and it won't be run in the bpf
>> CI.
>>
>> If you agree, can you please avoid introducing unnecessary randomness to the
>> test_progs where bpf CI and most users don't run in this way?
> 
> Thanks Martin. Sure, I agree. Let's drop this patch.

FYI, I'm also going to drop this patch from our tree as it doesn't seem
needed and it causes conflicts with bpf-next (now in net-next).

If needed, we can still re-add it later.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
