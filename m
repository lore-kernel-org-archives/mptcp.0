Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180E2DDC7
	for <mptcp@lists.linux.dev>; Mon,  3 Jul 2023 15:44:07 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-991fe70f21bso537741766b.3
        for <mptcp@lists.linux.dev>; Mon, 03 Jul 2023 08:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1688399046; x=1690991046;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8YvSixjm65AaTN4Ri4dyIKfN8AZskmsg5CTXS1N+RGI=;
        b=7EycRNbGKdyr5/+wZH7xO7+GgiAKYubTkt5xKwwEg/yEyABdgdKzi5pzi4+PC6pknq
         zHMEozU+fP4MIIcELxr6o76Vtvq16LPHTR3ptBw/iMCcJpQw+du6uBdM9XtTPoLW5DPo
         SotDoVFzmWB2idDSo2CUHN88X6v4VP5px7J/mf3bicu8CgwffmAQlkT44ehlQi3jjJzj
         nOTXZJhV7sjp5UHuFFMWZSDiUPxXkmQyVQoVAEvCcRRfdylk70Wwg8rwAsEi77M0Iohz
         CxRoDAhB/b0SdsZpgFq/VRxrLD13CMvz01WaOpeaR/uFf2wrz3MRF+B7cvxbLBjrHPDE
         oP5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688399046; x=1690991046;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8YvSixjm65AaTN4Ri4dyIKfN8AZskmsg5CTXS1N+RGI=;
        b=KOGvDkHnM8mYKFV4lUpevqvs5oodnAGLN9zHfILtcxHFIGOyNuus9v9jqPOyKSTMkQ
         hxUYqli+z3P8HCCvLz7lLtSCYDBA8XrJlflyb0nKXVqGO93UvgnhtD3Ei/wj0xq5tRjU
         oXtAxAVNnW1iyyST0m/hAMzzlo3WkVSBIla5xAC8Mo9zGYu2jOTqz3VjXkvroNOsiFQq
         HUXOEvHScCDzTEBV8BmKm3zAdRt8BQO/Mpkgln1rK9N9Y++d3A0YC34sLnpLkwp1oX0/
         w7eOYq91WRUW4Emm/PV2S0/VxFSzg7rd+CZqQmVos96u91IpuocwHIAfwb2SrjwZgvu0
         I4kQ==
X-Gm-Message-State: ABy/qLYu0Av+mNfT9Io7r9mOb9mhCuhM22sd0y4U5fDdsGAGXOCcZ076
	pzqImCrZG1SWE8tWDlsExI0i/w==
X-Google-Smtp-Source: ACHHUZ545N2eVLCXItRyAm6NlVmgEL2FEBjWdcTzNxgH7Gl6Yc/IUtTijOP2X7ccsX27u87djVVUiQ==
X-Received: by 2002:a17:906:c786:b0:98e:2c13:c44d with SMTP id cw6-20020a170906c78600b0098e2c13c44dmr8351626ejb.68.1688399045765;
        Mon, 03 Jul 2023 08:44:05 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id n10-20020a170906688a00b00992f309cfe8sm4538923ejr.178.2023.07.03.08.44.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 08:44:05 -0700 (PDT)
Message-ID: <7d4ccbc9-17b6-28cf-9046-c7f81401ee60@tessares.net>
Date: Mon, 3 Jul 2023 17:44:05 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH mptcp-next 0/4] BPF 'force to MPTCP'
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, Geliang Tang <geliang.tang@suse.com>,
 mptcp@lists.linux.dev
References: <cover.1688004307.git.geliang.tang@suse.com>
 <dde10ed6f356d1593d43b64f582e8bc740ff3e9b.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <dde10ed6f356d1593d43b64f582e8bc740ff3e9b.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 03/07/2023 17:18, Paolo Abeni wrote:
> Hi Geliang,
> 
> On Thu, 2023-06-29 at 10:12 +0800, Geliang Tang wrote:
>> This series depends on the two netns patches, should be inserted before
>> the BPF scheduler series:
>>   selftests/bpf: use random netns name for mptcp
>>   selftests/bpf: add two mptcp netns helpers
>>   bpf: Add bpf_mptcpify helper
>>   selftests/bpf: Test bpf_mptcpify helper
>>   selftests/bpf: Add mptcpify selftest
>>   mptcp: refactor push_pending logic
>>
>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/79
> 
> Again sorry for the possibly late feedback.
> 
> Before investing more time on this topic, are there any issues with the
> current tools available (mainly: 'mptcpize') that need to be addressed?

I don't have specific use cases for having bpf_mptcpize but I know the
"original" mptcpize doesn't not work in some cases:

- if the application is not using libc (e.g. GoLang apps)
- in some envs, it might not be easy to set env vars, e.g. on Android
- it needs to be launched with all apps that wants MPTCP: we can have
more control from BPF to enable MPTCP only for some apps or all the ones
of a netns or a cgroup, etc.
- it is not in BPF, we cannot talk about it at netdev conf (:-D)

Even if I agree mptcpize can help a lot, having bpf_mptcpize seems to
help in some other cases.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
