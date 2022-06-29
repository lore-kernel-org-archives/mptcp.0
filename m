Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B89E7B
	for <mptcp@lists.linux.dev>; Wed, 29 Jun 2022 08:32:41 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id d2so19312802ejy.1
        for <mptcp@lists.linux.dev>; Wed, 29 Jun 2022 01:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bbhhIC/azOQXIMOedO8/sG5fYJVYILH4PjSBwpr8POg=;
        b=I/YGSkfEEOgOJLpfKYEYtNiGItVEHNeDDrUDNLNzC9FZEBAS4MRu/4antS4RpUkqyC
         ARyTI52cH4Um4HgWmftE9rskVauv7hIBiRJpDyaT/vTPdznduk2rnGijyEgG+xl3jU2A
         9me51MwwWDozycY3lKTiLMQs6s7b7CAyAVPOWstwSBrunt+BUPTVxhDkXvtCTsfjbtcF
         R47y33UDhhjfvHvdMD3hGUU83p+1mse/HRmmV4ds1DYeNQdpNIv8wwawvoWQ2iC3HHhZ
         rHnJhTGCcH7yPrnJ5kxiKnIU4FiJEoY3NYk/qpbdAUzLzhrZAOANYzfejxiEuciD0lDG
         8I6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bbhhIC/azOQXIMOedO8/sG5fYJVYILH4PjSBwpr8POg=;
        b=Fk+ovc3NwCf/bv2jFvU1lHEi1fwrB709eEPGiNkkNrnCqwItc8rouPvb2sS3GlmXM/
         6sAWU37EQdKEoy2Z+38rAxPHBi+t5JQBlXbVXdo/Fn471x6dkG0tknVarmh4xZPOQTbZ
         +9QIe7gc75Mwg0R11gyZyCxFROsiRIFLm+AdLeiJTgx5cy8VsLGPkFDRYWuWwae7vdm0
         4tWHbY/9FxwZRbeUc6J9rssgobKMTnvz/qcL80byoMoSXWcuNk8zH+UecFlj8t6ERfUC
         rlNsd/4/USzPxc9YYoYnw86w9E+NQaEZ1eQeA4SQJKXUxMWoS7zVEAj38PlotHBREPWQ
         U4vg==
X-Gm-Message-State: AJIora9SvIYk/pBWlemXMNCRn9g80JMBVLg4X7yfEIGOqgSaLJjtZYAS
	Yj4HX1FYZhw5xEFEVvOus+bd7Q==
X-Google-Smtp-Source: AGRyM1vHvaGOdfGoK8Aj8iCKU3gjc6se6fcrtn38V106CvDwU1CKEESlhe/LeRxKf7QJd46boVn2lA==
X-Received: by 2002:a17:907:2ce3:b0:722:e1b0:68b7 with SMTP id hz3-20020a1709072ce300b00722e1b068b7mr2158093ejc.14.1656491559754;
        Wed, 29 Jun 2022 01:32:39 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:a891:49f2:211e:5634? ([2a02:578:8593:1200:a891:49f2:211e:5634])
        by smtp.gmail.com with ESMTPSA id r14-20020a170906c28e00b00722edb5fb53sm7474307ejz.116.2022.06.29.01.32.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 01:32:38 -0700 (PDT)
Message-ID: <b3baf637-f34d-2015-ef5e-1602877af5d6@tessares.net>
Date: Wed, 29 Jun 2022 10:32:37 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH mptcp-next] Squash-to: "selftests: mptcp: tweak
 simult_flows for debug kernels"
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev, pabeni@redhat.com
References: <20220627214438.17887-1-mathew.j.martineau@linux.intel.com>
 <acfcb031-4be5-c5a2-6858-02fed78a89f3@tessares.net>
 <edce75f6-48fc-7b40-af0-8a5410b19223@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <edce75f6-48fc-7b40-af0-8a5410b19223@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 28/06/2022 19:55, Mat Martineau wrote:
> On Tue, 28 Jun 2022, Matthieu Baerts wrote:
> 
>> Hi Mat,
>>
>> On 27/06/2022 23:44, Mat Martineau wrote:
>>> kbuild is still seeing intermittent failures in the simult_flows.sh
>>> test. It uses a kernel config without kmemleak, but with other
>>> performance-affecting debug options like lockdep and kasan.
>>>
>>> Example failures:
>>> kernel-selftests.net/mptcp.simult_flows.sh.unbalanced_bwidth_with_unbalanced_delay_transfer_slower_than_expected!_runtime_4339_ms_expected_4005_ms_max_4005.fail
>>>
>>> kernel-selftests.net/mptcp.simult_flows.sh.unbalanced_bwidth_transfer_slower_than_expected!_runtime_4285_ms_expected_4005_ms_max_4005.fail
>>>
>>> kernel-selftests.net/mptcp.simult_flows.sh.unbalanced_bwidth_transfer_slower_than_expected!_runtime_4346_ms_expected_4005_ms_max_4005.fail
>>>
>>
>> If I'm not mistaken, adding 200ms would not prevent these failures if
>> you got 4346ms instead of 4005ms, right? It looks like we need to extend
>> the time to something around 350ms.
>>
> 
> I had thought the "slack" was calculated differently, but I think you're
> correct here. I am a little reluctant to increase the limit too far,
> since the whole point is to detect when the transfers become slower -
> and we seem to instead keep finding slower CI systems!

Indeed.
In a recent build with a non debug kernel, I also got one issue:

>  # unbalanced bwidth with opposed, unbalanced delay - reverse directiontransfer slower than expected! runtime 4097 ms, expected 4005 ms max 4005 [ fail ]

It seems it is quite rare and probably due other jobs running in
parallel. I will monitor that.

> What do you think about this approach: make simult_flows.sh 'SKIP' when
> debug kernel features are detected, unless a "-f" flag forces it to run?
> That way we could run it with debug features where we know the system
> performance, like our CI, but not show bogus failures on random
> debug-enabled systems.

Yes, that was my suggestion in the GitHub issue I opened. In "debug"
mode, we are going to be slowed down by the extra processing the kernel
has to do while in this test we mainly focus on the network delay. A bit
more is added the processing but not much because I guess the "slack" is
also there for the "slow start" at the beginning of the connection.

https://github.com/multipath-tcp/mptcp_net-next/issues/282

If we add a "-f" flag, maybe good to add the possibility to change the
default "slack" value, e.g.

  ./simult_flows.sh -f 400


Or maybe clearer with:

  ./simult_flows.sh -f -s 400


(slack would be 400 instead of 50 then)


@Paolo: would it be OK for you if we skip this test in debug mode?


>>> Adjust the debug detection to loosen the simult_flows timing constraints
>>> if either kmemleak or lockdep are configured.
>>
>> Good idea!
>> I didn't find any "safe" ways to easily check that KASAN is used.
>>
>> Checking dmesg doesn't seem to be a safe way for all environments.
>>
>> But maybe we could do this? (with '-q')
>>
>>  $ grep mm/kasan /sys/devices/system/cpu/hotplug/states/sys/devices
>>  /system/cpu/hotplug/states:70:214: mm/kasan:online
>>
> 
> How about:
> 
> grep -q ' kmemleak_init$\| lockdep_init$\| kasan_init$\| prove_locking$'
> /proc/kallsyms
> 
> ?
> 
> That detects the compiled-in features, rather than what's enabled at
> runtime, but it's simple and may be good enough.

Good idea, seems OK on my side:

  # grep ' kmemleak_init$\| lockdep_init$\| kasan_init$\|
prove_locking$' /proc/kallsyms
  ffffffff9ae5b420 d prove_locking
  ffffffff9c51b592 T kasan_init
  ffffffff9c525857 T lockdep_init
  ffffffff9c542072 T kmemleak_init

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
