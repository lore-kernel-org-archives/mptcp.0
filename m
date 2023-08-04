Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4A28F52
	for <mptcp@lists.linux.dev>; Fri,  4 Aug 2023 12:33:50 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-3fe4b95c371so2429355e9.1
        for <mptcp@lists.linux.dev>; Fri, 04 Aug 2023 05:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1691152428; x=1691757228;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CfQMaaRyCSwOXXto5dBQ2HSX5cYKoQ2hDP9sxrdYqM4=;
        b=BRZ106NiWzQjGJ3u9Ko38bN+c/o9i5EKY2zS0Q9uRhyVJa9uewyoNLP3Hr3YCtxv+G
         iSmeOlQzQjXsJ8sQhWfpz33Amvfn4tBGopk+MIaEhV87nopDmIE5JsLyTErWAzwLhODf
         QsA4nAj6ZPZgj7xEswQJgSkw79ah5jA4PB+oqc29zExFb+tWxBqLyXDsAqEIr2W59K/D
         Fix8s0nDJ6MukiHKw94YuQVjLaaxVsKI8r22JhlcbvsWFLHZ8VSFniCM4jw8gY+ge3vM
         4IRC3Y7+4/tePIahauon3+zLrmS7wb9TY0DjHPtQGfQGPgRoC+BpJsx1nzRWFAjTlK7b
         AjLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691152428; x=1691757228;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CfQMaaRyCSwOXXto5dBQ2HSX5cYKoQ2hDP9sxrdYqM4=;
        b=D77e2mrOnWrNZIzr//+2AVEUy+aNTh5CtfvV6sShR5IFVnv2O4s2EcQsnxNPp1R6u8
         phA2lLH942G2Cwibx0NK8ZtJr7Lx2jor3W7TxNBuB/tV7t2ixa6p9SsgJgS2ZJumPjZP
         mECeEAIfrVEXxAZPmAgAtoUj+FiKX8jeSK+Eqw9vrMP5+nZ/j4tbSDfKF1DNr++KHlRb
         7syVF+Zxr+NXDaUjAQY6IMFIrkGuZbl5muZ1QlzUczG2ku4NEGTBtVwlVGU/zlsb55MU
         /3FwgoUuuTWxf+q/W0LGJSf1s1vM6Of2q3O0GGCa1qP495xwUz+mfrL3Usv0oVFITprv
         G67A==
X-Gm-Message-State: AOJu0Yy1JaO0KsqIOD3vkMDWtrKUdie4U7gFtM+lqBuhk07qOZluJe4G
	3WT9GO0lr+hCn5W7U3QsHJkGxg==
X-Google-Smtp-Source: AGHT+IFOpfhdqJoVSDg57olWBj0uJ+aMY1t0GDTFGK6VWfAXmk9rRc2BfjVhztOuQqScsq/hN74NxA==
X-Received: by 2002:a05:600c:1f1b:b0:3f7:e78e:8a41 with SMTP id bd27-20020a05600c1f1b00b003f7e78e8a41mr1630096wmb.18.1691152428296;
        Fri, 04 Aug 2023 05:33:48 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id t11-20020a1c770b000000b003fa8dbb7b5dsm2272620wmi.25.2023.08.04.05.33.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 05:33:47 -0700 (PDT)
Message-ID: <cae87433-3457-44a4-8990-dd5cd71bd50f@tessares.net>
Date: Fri, 4 Aug 2023 14:33:46 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next] bpf: Add accesses to bpf_skc_to_tcp_sock
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, Mat Martineau <martineau@kernel.org>
Cc: sferlinr@redhat.com, mptcp@lists.linux.dev
References: <322ae693257df0c5fcd8f9254e062f394fbeab88.1690963606.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <322ae693257df0c5fcd8f9254e062f394fbeab88.1690963606.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 02/08/2023 10:07, Geliang Tang wrote:
> Squash to "bpf: Add bpf_mptcp_sched_ops" II
> 
> As is reported in #417 by sferlin, we can't access tcp_sock fields in
> BPF schedulers.
> 
> I gave two suggestions in the comments of #417 to solve it:
> 
> 1. Move the helpers which needs to access tcp_sock fields like
> tcp_packets_in_flight() into the kernel space, call the helpers in BPF
> context.
> 2. Add more helpers in the kernel space to access more tcp_sock fields,
> call the helpers in BPF context.
> 
> Although these can solve this issue to some extent, but they aren't the
> best solutions.
> 
> A better one is using bpf_skc_to_tcp_sock() to get the tcp_sock instead
> of using tcp_sk():
> 
>     tp = bpf_skc_to_tcp_sock(sk);
> 
> Then we can access every fields of tp and keep sferlin's patch as is.

Good idea!

> But this needs to add accesses to call bpf_skc_to_tcp_sock() in BPF
> schedulers.

Thank you for the patch and the review!

Now in our tree:

New patches for t/upstream:
- db817ce80c6d: "squashed" in "bpf: Add bpf_mptcp_sched_ops"
- Results: 49d27f1d2549..7875a2426749 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230804T123239

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
