Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EF2539D
	for <mptcp@lists.linux.dev>; Thu, 20 Apr 2023 10:14:07 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id bg5so108941wmb.1
        for <mptcp@lists.linux.dev>; Thu, 20 Apr 2023 03:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1681985645; x=1684577645;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IMhHp3ToiOSXQR2Jm5k0DaZVdzFesoNAgqCPAddC49Q=;
        b=FS7XawVKrDyfNtAs5WBhEf5N/CLBjB5egSREcu0R5ztmy2QhlvAeWteHPFyo8j9Q8I
         9Sdl0l3aN9wqUMeJhZJMV1qS70Ab8eTiuQ1Hd1YZmsDurMqrU/uUUFbaTSTXsQniwmDW
         VM8sawmxiRX7CabEKmJrg7KhhfwQO8mJyiCqrLO/d6TMMiu9cEqr2oimGUB+U7dV+CSL
         T9HnHaRysA3Wvvor8mDZO56wr488GeKkWEKNm1p7ElBqp0nB1MM+rcQ9Lvhi/eEb1Yqe
         6QI7dSOxUp8rLuapRkZG7jQ9rUgmZLggYPGFv39POL0BSM2LcLwunpMkaLwNUbgKxCcs
         yCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681985645; x=1684577645;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IMhHp3ToiOSXQR2Jm5k0DaZVdzFesoNAgqCPAddC49Q=;
        b=jLam6uki5kddOr9on2XceRU0Sa84Iv0vNu/H9xSCBOL8I4ydgZDalHebZBP5tP2El3
         Y1n01nuPwic3olqVOf5Aj+rxQS3fTLT9Yr9yAfMuCk1U+wGvZGEZESUfOQrDGM+4i100
         v+tfJTgj345i5y2WURrZgYHg+jNtqu+Km863QY21M0hs6DTWizRaas2lafhA/eGd2bFK
         iFpJPWFXAE/wCJUf5JAUZD/Ofcvb7UgDn05yKfANx/z+F9DLw7w0wYMK4jPJylRwIf19
         DIfE/J5EZSFWa+HndgJL0xQowhW3U8bOTuDdUjperAgG69ckMcYsASdBwROMZzPdN8SJ
         jFwQ==
X-Gm-Message-State: AAQBX9c7ULlZgjYOXDYjGZxB1q7Juwz+XiPJftWGct4WJcO+kgYMnMh2
	UUEPun4QjozW4pceZpAEGInbBA==
X-Google-Smtp-Source: AKy350blN3ju4+Q1NSXUlUXaOubDiAeTRhYY2nyAWfzqB8la3ndsGbaKa3FmhqbySD0W5giF/8VSlA==
X-Received: by 2002:a7b:cc15:0:b0:3f1:65cb:8156 with SMTP id f21-20020a7bcc15000000b003f165cb8156mr975956wmh.0.1681985645469;
        Thu, 20 Apr 2023 03:14:05 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:4d8f:e9b5:dea0:5307? ([2a02:578:8593:1200:4d8f:e9b5:dea0:5307])
        by smtp.gmail.com with ESMTPSA id ay37-20020a05600c1e2500b003f18b52c73asm1320829wmb.24.2023.04.20.03.14.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 03:14:05 -0700 (PDT)
Message-ID: <ddf27f38-588a-bd6b-1de5-3c5d71cd1ed5@tessares.net>
Date: Thu, 20 Apr 2023 12:14:04 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH mptcp-net 00/13] selftests: mptcp: skip tests when
 features are not supported
Content-Language: en-GB
To: Geliang Tang <geliangtang@gmail.com>
Cc: mptcp@lists.linux.dev
References: <20230406-mptcp-issue-368-selftests-old-kernels-v1-0-246ac567724d@tessares.net>
 <CA+WQbwt06V64hW3V2xos4=CEj6PuhqRHwHBq_+dY4vBwQCfR9Q@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <CA+WQbwt06V64hW3V2xos4=CEj6PuhqRHwHBq_+dY4vBwQCfR9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

Thank you for having looked at these patches.

On 20/04/2023 05:49, Geliang Tang wrote:
> Matthieu Baerts <matthieu.baerts@tessares.net> 于2023年4月8日周六 01:06写道：
>>
>> Selftests are supposed to run on any kernels, including the old ones not
>> supporting all MPTCP features.
>>
>> These different patches add support for older kernels. More similar
>> checks will be needed but here is a first batch not to have too many
>> patches (because each patch fixes different commits).
>>
>> I tried to minimise the modifications and do the checks from the bash
>> script not to have to detect the feature when being used in a .c file,
>> then pass the info to the bash script, skip the test, clean the
>> environment, etc.
>>
>> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>> ---
>> Matthieu Baerts (13):
>>       selftests: mptcp: connect: skip if MPTCP is not supported
>>       selftests: mptcp: pm nl: skip if MPTCP is not supported
>>       selftests: mptcp: join: skip if MPTCP is not supported
>>       selftests: mptcp: diag: skip if MPTCP is not supported
>>       selftests: mptcp: simult flows: skip if MPTCP is not supported
>>       selftests: mptcp: sockopt: skip if MPTCP is not supported
>>       selftests: mptcp: userspace pm: skip if MPTCP is not supported
>>       selftests: mptcp: lib: skip if missing symbol
>>       selftests: mptcp: connect: skip TFO tests if not supported
>>       selftests: mptcp: userspace pm: skip if 'ip' tool is unavailable
>>       selftests: mptcp: userspace pm: skip if not supported
>>       selftests: mptcp: userspace pm: skip PM listener events tests if unavailable
> 
> Hi Matt,
> 
> How about merging these three commits and "selftests: mptcp: userspace
> pm: skip if MPTCP is not supported" into a single commit?

I prefer not to because they fix different issues, to be backported to
different stable versions. If I mix all of them together, it will be
harder to have them backported.

Maybe the patches 7/13 and 11/13 could be squashed together but I didn't
because the 7 first patches are doing the same for all our different
tests we have (and different "Fixes" tags).

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
