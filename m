Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A4C8C16
	for <mptcp@lists.linux.dev>; Fri, 19 May 2023 12:03:33 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-510e682795fso3181912a12.3
        for <mptcp@lists.linux.dev>; Fri, 19 May 2023 05:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684497812; x=1687089812;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/BIq/uQ1qwgRTrZFOaF3SlI8Y1Q0bzuM7AATBsQwm1s=;
        b=67+p6jQn9jM1uq7VJf2x/nRliJub/4GrhcJ8XzIKpEpqkn5EOmEIE5LrudI3UuT22Q
         YIstqrAf+gDfnUeOS6NV24PpMRCG3ONhTsm5EHdjqZhCA2CDYbdXo1iqN3f/q8Qr4B1b
         GEFJ1E9Wxn6CQfquYtqDxK0KeHopV9RAdyxXSThPncsdPGF4s71hvUGpaTfnzY0C5Kl1
         NSZR/bWCkP6Se5ddUSn7qS4B+GafMkl6lVTm9y9t5vDuk+7pufJukwYGYc7/u6eswwfb
         Hm8VW4rN6j20zECSKWBI+P1uyxe3YwkA3eobUHGWsR7B8mNJvfjiQ5PV9Q2vHz2JKZ+1
         yYxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684497812; x=1687089812;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/BIq/uQ1qwgRTrZFOaF3SlI8Y1Q0bzuM7AATBsQwm1s=;
        b=aL/bm9nJmM/CNKOihnv1PbqRE6VC02pSJTB8YXxhcRWmxDNlecTmvUehaD6hzgrQ9s
         yFAEoUxUnsU0bLQ7yRLMyIhi4OXjGvDXPEKhZGzwJBqFSvmrWpoNRFLYoL//tXbh7w3m
         wMnZ6UmcQ37dZxwHKC2/X10GH4sbMx8NNDHzCvND6SWk8jLoGHgudUdzA2Brtc5fPP5e
         uz57gLNEgZolqyaypBgokIGmv6dMdE8bwIK/6J/YDXfWxXTZiioxPFLW2iz6rfbRgU+3
         n3hjXUccklnfUEZGsKvNHVeoUK43P9tTrYDtDR3foWrcDK2TzMsKBXZiuW7Qo+sZb7ZE
         l34w==
X-Gm-Message-State: AC+VfDxREs/ljxCRhQmSfsA/npJf1lFMiIYTEg6skxQyq7WHhkmeS28g
	6HJjn4fbp7O9NrLj3lZgIuJm0A==
X-Google-Smtp-Source: ACHHUZ5KdojZAoklIqm3cGKb+PwkDjeXhVdgx6DUiiGC/lHAJK5bOKaFWgrqIWyvwJ/Ik5ANAVk74A==
X-Received: by 2002:a17:907:3e13:b0:96f:7b4a:28fe with SMTP id hp19-20020a1709073e1300b0096f7b4a28femr964503ejc.1.1684497811822;
        Fri, 19 May 2023 05:03:31 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id s2-20020a1709060d6200b00966293c06e9sm2162628ejh.126.2023.05.19.05.03.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 05:03:30 -0700 (PDT)
Message-ID: <a7975ea0-333d-ca28-d1df-7ec579008307@tessares.net>
Date: Fri, 19 May 2023 14:03:29 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH mptcp-next v4 0/6] run sched tests in a dedicated ns
Content-Language: en-GB
To: Geliang Tang <geliangtang@gmail.com>
Cc: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1684362296.git.geliang.tang@suse.com>
 <8f268175-128a-d015-af04-defe4785bdd6@tessares.net>
 <CA+WQbwu_kCmYw94WnY_+4mYE_pE04T4NfUKBs=y=81rwcrY2+Q@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <CA+WQbwu_kCmYw94WnY_+4mYE_pE04T4NfUKBs=y=81rwcrY2+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 19/05/2023 11:58, Geliang Tang wrote:
> Matthieu Baerts <matthieu.baerts@tessares.net> 于2023年5月19日周五 17:36写道：
>>
>> Hi Geliang,
>>
>> On 18/05/2023 00:29, Geliang Tang wrote:
>>> v4:
>>>  - patch #1 could be merged before "mptcp: refactor push_pending logic"
>>>    as a single fix.
>>>  - patch #2 should be merged between "selftests/bpf: Add mptcp sched
>>>    structs" and "selftests/bpf: Add bpf_first scheduler".
>>
>> Thank you for the new version and for the explanations!
>>
>> I suggest to apply the first patch also between "selftests/bpf: Add
>> mptcp sched structs" and "selftests/bpf: Add bpf_first scheduler" as it
>> seems not needed before (see my comment on this patch).
> 
> I agree. Please update the commit logs for me when merging them.

Great, just did, hopefully as expected.

New patches for t/upstream:
- 022ddca0dd31: selftests/bpf: use random netns name for mptcp
- fa066ce14aa8: selftests/bpf: add two mptcp netns helpers
- 90d56a205185: "squashed" patch 3/6 in "selftests/bpf: Add bpf_first test"
- e17099987f21: "squashed" patch 4/6 in "selftests/bpf: Add bpf_bkup test"
- 8c10fe1b6365: "squashed" patch 5/6 in "selftests/bpf: Add bpf_rr test"
- 4101020d41c3: "squashed" patch 6/6 in "selftests/bpf: Add bpf_red test"
- Results: c20d0380b999..577d6a7db2fb (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230519T120144

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
