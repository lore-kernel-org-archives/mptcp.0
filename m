Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23767C
	for <mptcp@lists.linux.dev>; Thu, 31 Mar 2022 11:29:36 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id x34so27770065ede.8
        for <mptcp@lists.linux.dev>; Thu, 31 Mar 2022 04:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2DQnXPvzrbE4GzdzMJXP/x87i82v9nrH7TMqt92B88E=;
        b=71InpzU1E8NQC35f8p9q2SAE/Hp9u9GfFKE1OB0IdPGN9qD38C076UBWWhB5liBgyk
         M7S+CwUFrqjlGSUerrrHch2TDpJP5GBzzZs1Klx+fdr5lbtKjgBGiL1qPdF4+XE5P2Sc
         pMDkL4exd68pwyjQn+SE4QSflYIk34mXBN3g2fj8bCCDiQHR6DxpcwluLnGUNcGfgzrV
         c1QLgb/vRz3+ScMbt4pfd9Rivmgi1zQs+V5sEjVhZESdERP9f5JC73DcLzRhIybOvpOV
         H2cU7wFD81N1lPv1PyAcLsXiW/EuIS6vPI0VAi8Kj2r7ewokfGYhEFGh6znhsshlHm4M
         fG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2DQnXPvzrbE4GzdzMJXP/x87i82v9nrH7TMqt92B88E=;
        b=EfYldGXhTH5VsczXtA4e3FewOtkPppNCVIenU+6KITkpkghTE+PbsIEVQFle3oDnTP
         Vl7jS90Nb6JrHPeS9L5e4rup1Caa3LOGzldkwQz2dsWAbfq2+M/LHxNKCjE9SlGcSz5X
         KtJipAeZ7PIdOjaMTDD2EA30UV36kQZCbl4XYXNK4iIRTAI2xC0j3KQeHUKdjtCLIHEy
         IDIGE6/xGGXyCBfjLpxRhrl7R8MeCkwzTnF/KKwOxnZvYEgdMg/jETqevQg7c+TeuVNs
         3rtulQNSLPy7+Io8wAfinfc+x4wTwXtmlWZySgrPPaz6xWMfIbYtBr0R5QYJmgmzAL+0
         C47A==
X-Gm-Message-State: AOAM5317SZrLxziBy/rfLtF2RM1OmE/UZYNJS02/QKRuRN9IzhZP4FpT
	bsxTRCgvHkFsnZ+4It/v/fQVFA==
X-Google-Smtp-Source: ABdhPJzQv+np8r82W3Vqy4lDYJS8bFhJSjhPpyUxDmYpSL87fY0u/cnxXb92ZT8+BLT55gB0dEQ15Q==
X-Received: by 2002:a05:6402:4315:b0:419:2e38:ab8f with SMTP id m21-20020a056402431500b004192e38ab8fmr16195788edc.250.1648726174376;
        Thu, 31 Mar 2022 04:29:34 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:67bb:4772:e0be:4bc4? ([2a02:578:8593:1200:67bb:4772:e0be:4bc4])
        by smtp.gmail.com with ESMTPSA id b11-20020a170906728b00b006df8494d384sm9513390ejl.122.2022.03.31.04.29.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 04:29:34 -0700 (PDT)
Message-ID: <fa5d6e08-8425-318d-3b9c-606a2c46f817@tessares.net>
Date: Thu, 31 Mar 2022 13:29:33 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH mptcp-next] Squash to "selftests: bpf: add bpf_first
 scheduler v8"
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
References: <e6bb3c020929be2e6a41ef994e740eafe7fedce9.1648714973.git.geliang.tang@suse.com>
 <7fb77cd5-4d97-0697-d88f-f20348a79347@tessares.net>
 <20220331104051.GA22988@localhost>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220331104051.GA22988@localhost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 31/03/2022 12:40, Geliang Tang wrote:
> Hi Matt,
> 
> On Thu, Mar 31, 2022 at 12:07:45PM +0200, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 31/03/2022 10:23, Geliang Tang wrote:
>>> - Move mptcp_sched_ops to bpf_mptcp_helpers.h.
>>> - Update MAINTAINERS.
>>>
>>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
>>> ---
>>>  MAINTAINERS                                         |  1 +
>>>  tools/testing/selftests/bpf/bpf_mptcp_helpers.h     | 12 ++++++++++++
>>>  tools/testing/selftests/bpf/bpf_tcp_helpers.h       | 12 ------------
>>>  tools/testing/selftests/bpf/progs/mptcp_bpf_first.c |  2 +-
>>>  4 files changed, 14 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 40a62dc29e31..852e21ca47f8 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -13746,6 +13746,7 @@ F:	include/trace/events/mptcp.h
>>>  F:	include/uapi/linux/mptcp.h
>>>  F:	net/mptcp/
>>>  F:	tools/testing/selftests/bpf/bpf_mptcp_helpers.h
>>> +F:	tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
>>>  F:	tools/testing/selftests/bpf/progs/mptcp_sock.c
>>>  F:	tools/testing/selftests/bpf/prog_tests/mptcp.c
>>
>> Maybe we should start using '*' to avoid having to update this file all
>> the time :)
>>
>>   tools/testing/selftests/bpf/bpf_mptcp_helpers.h
>>   tools/testing/selftests/bpf/*/*mptcp*.[ch]
>>
>> WDYT?
> 
> Yes, using '*' is much better. Could you please update this for me when
> squashing it? Or should I send a v2 for this?

I can do that directly, probably easier! :)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
