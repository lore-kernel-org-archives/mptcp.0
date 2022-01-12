Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533672C80
	for <mptcp@lists.linux.dev>; Wed, 12 Jan 2022 17:42:30 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id w16so12907500edc.11
        for <mptcp@lists.linux.dev>; Wed, 12 Jan 2022 09:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3yrF+lD1uXRjGSCIZxHvhCDtXerroUYgh7nI0tlMNzE=;
        b=3ZwkpB5jJcgNei5f+FPzto+Mo6t0zxoJVwX97c10OMES8IEkBpQ+EjG5QIhlvtcDQb
         R6efifYcfEoQ5+97VZflw3sxo5ndphIYW5wr/xFCvTbaQ0GaluCl4JtI/1ZMNEKN9KOD
         unNh7PlGIxOLPvCB34wtnIvAUEmK5VpO7PxyJQHxb2dWDGZ9aZpABpuBPz/KZn+C3Z5B
         wGZnMINqo3R8ZnhRZb+YsXTUGvRZmiW9m55DxZ05HPmS1P0riucNlQEg+cXlWQPGDLDu
         uoJ0aw+uMh1UmBCmOabmCwojK2IdcmqgWWoPxMROLQ+9N5OlyqaB08P7wNNRiwtep62W
         eDdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3yrF+lD1uXRjGSCIZxHvhCDtXerroUYgh7nI0tlMNzE=;
        b=3etecAKbRk5tnq8iMwuxpEmFNfBEqtDTpnP3hIms70ppNJbgkVVLG96MuUzeuh5lqa
         6sU155s+pgzI4CGIQ732FUmgtzVF870D8SBM+tpXe3+8ixMQ6+c/oTDOR2lWS/uN4I6p
         cq6F1rhzuK7/0c2ES+ThEtllCj/nWxdjFLWpYRAg/MvaJnV4eIjCj7JrzteWuSY7qPYd
         vOMJajx3DL66i2rW93uGB1cZRxwJnenif1JLQOGYZyXXJr8WactusWtwCSaqcTyYegG9
         mPc1ET7qgxnUV/6rXyRCECgxDyC5P/vrjnDUBaqt2rhs/E3H5qx17ELHGuUgH1Bhxnwf
         e93w==
X-Gm-Message-State: AOAM5305/Xg8jTVfXqz4UrfkH3khii5ENO301NztcYZYMJh0tK5wECqM
	ibQZgYHQBDmd2GbzJcbnxWkFvMFzk+E6eg==
X-Google-Smtp-Source: ABdhPJyJ8xJTKTyd569Ojm6tlnu7txhE/UxmfBOsLoCXxbyU98uRr20CWt4f3Iwir8wxSHU+F+q4mg==
X-Received: by 2002:a05:6402:26c2:: with SMTP id x2mr687754edd.6.1642009349156;
        Wed, 12 Jan 2022 09:42:29 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:47ae:90ef:fe3c:4c59? ([2a02:578:8593:1200:47ae:90ef:fe3c:4c59])
        by smtp.gmail.com with ESMTPSA id sa12sm113217ejc.193.2022.01.12.09.42.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 09:42:28 -0800 (PST)
Message-ID: <b78dc53f-a4e6-483e-860f-a6a092c59ffc@tessares.net>
Date: Wed, 12 Jan 2022 18:42:28 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH mptcp-next] Squash to "selftests: mptcp: more stable join
 tests-cases"
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
References: <613b986defe37faa7298095b364d9c81d6899664.1641549011.git.geliang.tang@suse.com>
 <9fde3240-18c4-ceb5-903d-64c532a87992@tessares.net>
 <20220110074343.GA4714@dhcp-10-157-36-190>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220110074343.GA4714@dhcp-10-157-36-190>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 10/01/2022 08:43, Geliang Tang wrote:
> On Fri, Jan 07, 2022 at 12:03:00PM +0100, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 07/01/2022 10:51, Geliang Tang wrote:
>>> IPv6 removing test failed on my test every time, this patch fixed it.
>>
>> Thank you for looking at that!
>>
>> The public CI has many similar errors and maybe (hard to say) more with
>> your patch, e.g.:
>>
>> https://api.cirrus-ci.com/v1/artifact/task/5889173428109312/summary/summary.txt
>>
>>
>>> Our CI did some validations and here is its report:
>>>
>>> - KVM Validation: normal:
>>>   - Unstable: 1 failed test(s): selftest_mptcp_join 🔴:
>>>   - Task: https://cirrus-ci.com/task/5889173428109312
>>>   - Summary:
>> https://api.cirrus-ci.com/v1/artifact/task/5889173428109312/summary/summary.txt
>>>
>>> - KVM Validation: debug:
>>>   - Unstable: 2 failed test(s): selftest_diag selftest_mptcp_join 🔴:
>>>   - Task: https://cirrus-ci.com/task/5326223474688000
>>>   - Summary:
>> https://api.cirrus-ci.com/v1/artifact/task/5326223474688000/summary/summary.txt
>>>
>>> Initiator: Patchew Applier
>>> Commits:
>> https://github.com/multipath-tcp/mptcp_net-next/commits/3b5258004128
>>
>> Could it be linked?
> 
> Hi Matt,
> 
> I tested this on my Thinkpad X1 laptop, only two failures occur. But
> I think it's somehow linked with the commit "selftests: mptcp: more
> stable join tests-cases", it dropped many latencies (sleep 1) in the
> selftests.
> 
> The CI is runing in a KVM, right? I think we didn't tune the latencies
> of the selftests for a KVM yet (At least for me). I think we need to login
> into a KVM to run the selftests there and change the latencies there. I
> think different latencies are needed. We need to make sure the selftests
> could be passed on both a real machine and a KVM.
> 
> Could you tell me how to get the CI KVM image? Or could you do this
> test?

Sorry for the late reply.

To test, it is very easy, you just need to install a recent version of
docker before:

  cd <kernel source code>
  docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
    --pull always mptcp/mptcp-upstream-virtme-docker:latest \
    auto-all

This will do what the CI is doing: running all tests, once without and
once with a "debug" kernel config.

There are different arguments you can give instead of "auto-all": only
"normal" or "debug" kernel config, having a shell instead of running all
tests, etc.. Please see:

https://github.com/multipath-tcp/mptcp-upstream-virtme-docker#entrypoint-options

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
