Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6F92C85
	for <mptcp@lists.linux.dev>; Thu,  4 Nov 2021 14:05:18 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id b15so2540035edd.7
        for <mptcp@lists.linux.dev>; Thu, 04 Nov 2021 07:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hkGOhJbeg3u/4X+9J47AVbq0pBoFzeQP32M92ORancU=;
        b=TwTraVV+YQcpynwr3lUGE3wsG2o6Y9dTaA8BGfXfSKlqxZ6ADk4peTtpUmDIfPhzan
         dS0/Je+Ksi9cKeEqIOAo3JcRZ9OTp2a3zzOfbEfiViPM+JYdr95qVAPchxXp4CrlG2we
         S78wsv8ckMOqw3UDBYFDfhluLIgKbUunZS1UGvZSV7MN93CYOcT+zcnW+Sn+aDNtohLB
         DUPKcn0SguuttSd2egy4JtTxdjbkokFJyurIklFtsF6ueWBKRMJjjyt4zVp662rRX/wj
         aL8EVmq5bYd5VgKZ5FCcgj67Xl7aYTohgZ3xnctu5ULZ46AGoqT2pt4vqhmd/MFClyzZ
         B9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hkGOhJbeg3u/4X+9J47AVbq0pBoFzeQP32M92ORancU=;
        b=vqpF6V+yUVwzkBxFpp2X+/EbWJ6krqk4xhsOikobFDzwfF6MbhOXdN2+bZIGgHb3Hi
         eDbywY9LGaFMARRiif/wC0Jxv39YthPvbMlEFO4w8heylMWv1zL4f5Q5vSn7iTHWoavc
         VFbVaKA8I9QEtdFeDne9K8Lf6+wOEtEsEhS7oI+4cnTsh5gPLT03G3+tLQMozqp+CZ2x
         KtTk5porsr9ijejoA82ZR13S76C1liXT/ru066BWT/fQ2FwLfT426deo/wJqSQpYbL8M
         j9co4rBuhfGy3tIvgsFZ2s2IhW7K/CgVvvMj4t1qX62JVrR2kENkRs6UM3HYA9/cUAoN
         E4kQ==
X-Gm-Message-State: AOAM530Kb5SoIoETihmtKiMkzjkGP1pc4amioKjsJPaztBHyhyK8SpF/
	aFr/6r+ytn/OSosKxjwyHgteFmu4IjEzsAmJ
X-Google-Smtp-Source: ABdhPJxayaueq/oL/786adrdRoH0L+bzNN1+5gsFDvk2JcszwWNxEtANoSBOPtLM2KkxnZh8TCdPSw==
X-Received: by 2002:a05:6402:2687:: with SMTP id w7mr28959211edd.266.1636034714310;
        Thu, 04 Nov 2021 07:05:14 -0700 (PDT)
Received: from ?IPV6:2a02:578:85b0:e00:8bb4:2878:7380:649e? ([2a02:578:85b0:e00:8bb4:2878:7380:649e])
        by smtp.gmail.com with ESMTPSA id di12sm2693011ejc.3.2021.11.04.07.05.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 07:05:13 -0700 (PDT)
Message-ID: <c6d5e837-e2a8-3836-74fe-cf5afff671bc@tessares.net>
Date: Thu, 4 Nov 2021 15:05:13 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH v2 mptcp-next] mptcp: enforce HoL-blocking estimation
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
References: <d3477a25f27b733d33a85800713949dae0e1ea4a.1635241330.git.pabeni@redhat.com>
 <8a4189c20285e73f1b4f51d4e442477003f40d1f.camel@redhat.com>
 <a7127287-2a50-cd58-e82-4022ed399ad@linux.intel.com>
 <c59a50d92d0dc8b6381de96cd22883a56227f188.camel@redhat.com>
 <98a575e6-7784-eb6c-7286-df7b8e4f2e87@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <98a575e6-7784-eb6c-7286-df7b8e4f2e87@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 04/11/2021 00:28, Mat Martineau wrote:
> On Wed, 3 Nov 2021, Paolo Abeni wrote:
>> On Tue, 2021-11-02 at 18:07 -0700, Mat Martineau wrote:
>>> On Tue, 2 Nov 2021, Paolo Abeni wrote:
>>>> On Tue, 2021-10-26 at 11:42 +0200, Paolo Abeni wrote:
>>>>> The MPTCP packet scheduler has sub-optimal behavior with asymmetric
>>>>> subflows: if the faster subflow-level cwin is closed, the packet
>>>>> scheduler can enqueue "too much" data on a slower subflow.
>>>>>
>>>>> When all the data on the faster subflow is acked, if the mptcp-level
>>>>> cwin is closed, and link utilization becomes suboptimal.
>>>>>
>>>>> The solution is implementing blest-like[1] HoL-blocking estimation,
>>>>> transmitting only on the subflow with the shorter estimated time to
>>>>> flush the queued memory. If such subflows cwin is closed, we wait
>>>>> even if other subflows are available.
>>>>>
>>>>> This is quite simpler than the original blest implementation, as we
>>>>> leverage the pacing rate provided by the TCP socket. To get a more
>>>>> accurate estimation for the subflow linger-time, we maintain a
>>>>> per-subflow weighted average of such info.
>>>>>
>>>>> Additionally drop magic numbers usage in favor of newly defined
>>>>> macros and use more meaningful names for status variable.

Thank you for the new version of the patch!

(...)

> I do agree it's likely an improvement - I'll still collect some more
> data (this time with the avg, snd_wnd, and sk_wmem_queued) to see if
> more adjustments are needed before upstreaming.

Small idea: if you redo the measurements, I do recommand you to use
trace_printk() (or ebpf) instead of pr_debug() to collect data to avoid
being impacted by printk() processing if you have a lot of stuff to display.

>>> Before we merge a change here, we should develop a clear
>>> understanding of what the data going in to the scheduling decision looks
>>> like, and make sure that outliers in that input data are handled
>>> appropriately in a variety of scenarios.
>>
>> Due to the above, I still propose to go ahead with this version and
>> ev., as needed, improve incrementally.
> 
> I'm ok to provisionally add it to the export branch now to get some more
> test exposure beyond the tests I'm running locally. I haven't convinced
> myself it's ready for net-next yet but we can sort that part out later.

Great! Now applied in our tree with a Closes tag for issue /137!

- 43868e0b4755: mptcp: enforce HoL-blocking estimation
- Results: 1e4fe04f517d..6a2b7fa0be7c

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20211104T140457
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
