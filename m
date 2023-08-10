Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB3A20C94
	for <mptcp@lists.linux.dev>; Thu, 10 Aug 2023 15:50:08 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-317716a4622so1001858f8f.1
        for <mptcp@lists.linux.dev>; Thu, 10 Aug 2023 08:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1691682607; x=1692287407;
        h=content-transfer-encoding:in-reply-to:cc:autocrypt:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QVOv0SxVKUy1TZOvGgc/oN8xuHqRia//yM2DG+OlxDE=;
        b=AOWjpbW+ji360tPcR8DTj4dPX+siaPtUMzR/cxFoqtUHqkTbnldU/HRhBJRHZ/vbrE
         IZn4LdisFaCnYcZBTVYECmD2401tsol2PlvfthxsYQTwH6z214nENwKhzCix+ku+RLfa
         EXFJio3+VpRjiQnRE5ur113GkGJMT8cWQWjHX4Itstd+pQHHo8jzBuzVJbIjjGVQjOV2
         HBuySwv3A3Dgwp7ufjomfCmLJCqdPbfMvLg0CrEn3/4VZdvOU0d4T8kRkGAnCfrZZBFX
         Ft1d1Qb3aW/VuHSqaZ97s/xqweOdB5R5s5A2xV3ysCBoIAWU1aiq+YSpDom41tSEkI5W
         ZVUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691682607; x=1692287407;
        h=content-transfer-encoding:in-reply-to:cc:autocrypt:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QVOv0SxVKUy1TZOvGgc/oN8xuHqRia//yM2DG+OlxDE=;
        b=Ffid3JMlaBDxrERgE8JcK8HXRPq6BtSPoJKcXE2EDftfRm/KO4kgSMVKQkYHKISx81
         0stq5fhoXVEFmFw95L7BsHO7yRhNF8o0dqNBRXUaToQwoh2eL2+hOh7NOeBwJRMSRGGb
         cwpwAQiD5PUjCJSjRf2gfZe7cbVGodl2SNMmaDaiO2+8Dg2aBiexydVSQB2R5AvvbhTn
         SFu3bMTCoFY5QCjuWa3Sv6NHsh1VPHuAWtNhNdV+I9mYwG1MHm1gfj38O4t9xvzCrZtw
         s7/3EHOP7comzyFrf4elupDO+faxBnfpVdCPVo+WTxfTVdW8+4kDwxGV2nrhBQCJmYrw
         brjw==
X-Gm-Message-State: AOJu0Yyk3rpikMT2kKDDm4w/yjhO5Rki0A+ShP35aNvuULXvJFWirdOw
	XY+SCSisM2uUo0hLYtIlzL+7RDd1HS9axyyKDls=
X-Google-Smtp-Source: AGHT+IFtHNhvjKKvXLdvbYVSO7oXnAk8FS81hYsiB5vIhKPFcuU/fWUTCyy+vhQ83nJ/RwgqfPP26A==
X-Received: by 2002:a05:6000:136a:b0:313:f783:262b with SMTP id q10-20020a056000136a00b00313f783262bmr2559085wrz.26.1691682606896;
        Thu, 10 Aug 2023 08:50:06 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:9609:9964:25d3:6050? ([2a02:578:8593:1200:9609:9964:25d3:6050])
        by smtp.gmail.com with ESMTPSA id t11-20020adfe44b000000b0030fd03e3d25sm2585920wrm.75.2023.08.10.08.50.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 08:50:06 -0700 (PDT)
Message-ID: <2eac859e-6884-40d1-af20-e79f58424e06@tessares.net>
Date: Thu, 10 Aug 2023 17:50:05 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC mptcp-next 00/11] BPF packet scheduler updates part 4
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>
References: <cover.1691676509.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>
In-Reply-To: <cover.1691676509.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

Thank you for these patches!

On 10/08/2023 16:09, Geliang Tang wrote:
> There's a bug in bpf_burst. snd_burst stored in mptcp_burst_storage in
> BPF context is not used. msk->snd_burst is still used in kernel space.
> To fix this, add two new interfaces in mptcp_sched_ops to get and set
> scheduler's paramters from BPF context to kernel space.

I didn't fully look at this series in details (and I don't have the full
picture in mind) but I'm a bit worry about these parameters. I see two
ways to extend the BPF packet schedulers:

(1) either we keep the API as it is and we parametrise actions like here

(2) or the new schedulers have more control on what is being done
replacing what the core is doing to select what can be sent and where

I think that if we take the first option, we would limit the extensions:
when a new scheduler will want to change what the core is doing, a new
parameter will need to be added with more indirections, complexity, etc.

The second option requires some "big" changes in the scheduler API but
it is probably the right time to do that and probably worth it. (but
before modifying the code, we should probably discuss high level
architecture). With this new API, BPF scheduler should be able to only
modify the parts they want, leaving the rest like it is when the default
scheduler is running (or use helpers to keep the behaviour of the core).

This is also somehow linked to issues #343 and #344 on GitHub.

> Geliang Tang (11):
>   Squash to "mptcp: add struct mptcp_sched_ops"
>   Squash to "mptcp: add scheduler wrappers"
>   mptcp: use snd_burst wrappers
>   Squash to "mptcp: register default scheduler"
In other words, I think we should not modify the patches above and send
them as their are to netdev. Then think about the strategy we want  to
allow "any kind" of packet schedulers implemented in BPF.

WDYT?

>   Squash to "bpf: Add bpf_mptcp_sched_ops"
>   Squash to "selftests/bpf: Add mptcp sched structs"
>   Squash to "selftests/bpf: Add bpf_bkup scheduler"
>   Squash to "selftests/bpf: Add bpf_rr scheduler"
>   Squash to "selftests/bpf: Add bpf_burst scheduler"
>   selftests/bpf: Add bpf_stale scheduler
>   selftests/bpf: Add bpf_stale test

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
