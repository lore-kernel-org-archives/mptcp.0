Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEA57A
	for <mptcp@lists.linux.dev>; Tue, 26 Jul 2022 10:20:35 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id m8so17132030edd.9
        for <mptcp@lists.linux.dev>; Tue, 26 Jul 2022 03:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bH5Jo0yV5sfEg+NH5QEb7LSe6ORObi++xVFlsngQunI=;
        b=uCIQ7qjfEczgzUJlr5t1moFwmJVVo1CYAMHar6RSyI4cg5MgSlPrNOlLMYpUMd5tDB
         gKeQiYTYNhKOrT0tSqQmWyeKO/UKbIqKCg3vk3lwiYEqx4WDou55AyyCHEEY1nULIMH3
         Es6LHrf9ZRpQaAg0nSTWLe5R0jMe5QxrNgWtLz90zN1kfbetbFz2S9YPgACm0SD0HXWc
         JczAALQS5/ZSLpyYKwJqOT3k3K69+P/v8KbkLlohOZiO2Ed20Zisjf8esug5r4SAHRUd
         9S+0S6jfCZVcOG7Unf6AqxAm3Tlj6xJVLVuUOeIwLrYwfEFsEeR/C7wqS2UXK26vJ5L+
         OHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bH5Jo0yV5sfEg+NH5QEb7LSe6ORObi++xVFlsngQunI=;
        b=GwRiwloGEDuwiw7jPEEDKwGexCj2NWDHMtAAZGSY7qSEQnVmfMFMNupaGuMdutUKEA
         t5pHRUGgxZ1a1yY+Jus+1GooVj2Z2oj9Q4FUp8MNxt/ZH15P9K3QFhZQO5GosycJtOcE
         1fyWTDqh4yns95eG4gbn99e1rxBZG8T1vjB79u4FxVWGyFvGE+Sq47fTWPK6tdyzovXJ
         r3xxesUoHOqeZEG4Ne+pdGDAOWp7T6+Yawpyr4i0EPsbSMlSL5WbDrOPbvijArsIPgXN
         x84dye2eqWChc2RhpHz013pGNkLV9KLAHyvhXi3oxv/JOsVkNmnkVhc8uH/8YiehUxA6
         9I8g==
X-Gm-Message-State: AJIora+QV1V4N3UCkO1nzBciVXjN+KdOSsiyRu7T/SKXyATiiVLsqxSw
	42CDnuvK/3oPBmXzoZYn7vNH1Q==
X-Google-Smtp-Source: AGRyM1tGSMF8ZTJbr6C6CDgsgcsMCrFm6B4uh1Ar2kRbDITEG8B+hLuuc3TEPcngMSGF9zIKaMeCeg==
X-Received: by 2002:a05:6402:344:b0:43b:e42b:fdf with SMTP id r4-20020a056402034400b0043be42b0fdfmr14021488edw.416.1658830833258;
        Tue, 26 Jul 2022 03:20:33 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:f6a4:3e1a:9d54:439f? ([2a02:578:8593:1200:f6a4:3e1a:9d54:439f])
        by smtp.gmail.com with ESMTPSA id x4-20020aa7dac4000000b0042617ba638esm8356218eds.24.2022.07.26.03.20.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 03:20:32 -0700 (PDT)
Message-ID: <d3bbbfcd-4b06-b7a9-eaea-38306e997beb@tessares.net>
Date: Tue, 26 Jul 2022 12:20:31 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH mptcp-net] mptcp: Do not return EINPROGRESS when subflow
 creation succeeds
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>
References: <20220715181207.522021-1-mathew.j.martineau@linux.intel.com>
 <fd3161fb-c693-48ba-3972-f0fdfe9ef3@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <fd3161fb-c693-48ba-3972-f0fdfe9ef3@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat,

On 25/07/2022 22:52, Mat Martineau wrote:
> On Fri, 15 Jul 2022, Mat Martineau wrote:
> 
>> New subflows are created within the kernel using O_NONBLOCK, so
>> EINPROGRESS is the expected return value from kernel_connect().
>> __mptcp_subflow_connect() has the correct logic to consider EINPROGRESS
>> to be a successful case, but it has also used that error code as its
>> return value.
>>
>> Before v5.19 this was benign: all the callers ignored the return
>> value. Starting in v5.19 there is a MPTCP_PM_CMD_SUBFLOW_CREATE generic
>> netlink command that does use the return value, so the EINPROGRESS gets
>> propagated to userspace.
>>
>> Make __mptcp_subflow_connect() always return 0 on success instead.
>>
>> Fixes: ec3edaa7ca6c ("mptcp: Add handling of outgoing MP_JOIN requests")
>> Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow
>> establishment")
>> Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> 
> Noting here for the lore.kernel.org records: Paolo acked this patch
> today on IRC (#mptcp / irc.libera.chat).
> 
> Given that ack, the simplicity of the change, and the timeline for this
> week's -net pull request, I'm sending this patch to netdev today.

Thank you for the patch and sorry for the delay.

I also applied this patch in our tree:

New patches for t/upstream-net:
- 75b93cbf0a74: mptcp: Do not return EINPROGRESS when subflow creation
succeeds
- Results: 78784c054bf1..76dabdd1e02b (export-net)

New patches for t/upstream:
- 75b93cbf0a74: mptcp: Do not return EINPROGRESS when subflow creation
succeeds
- Results: 7d1efaa490cf..f6822255c960 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20220726T082127
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220726T082127

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
