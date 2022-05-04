Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF132101
	for <mptcp@lists.linux.dev>; Wed,  4 May 2022 07:03:26 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id b24so642184edu.10
        for <mptcp@lists.linux.dev>; Wed, 04 May 2022 00:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=1tCQPW+H36Y8+QmLJ4x094v94ZS8qHXB5SBzSQFvweY=;
        b=hzHeAsAHnWKtTVVdwqEobSgPmuuoYEffVR9krW6kK1Qpf5Fe6hhhXpaLp3jAgtX38i
         IlnhiYCmeKGclae2mqFYWDy3ruod1Yg3Mc+2PvzsJumc+RcnYIoQuTQAyDkjCiRDkrWz
         lee3vPY1KQazVVTtS5oTJHdtiN8LIMMELXssXpWZO2wHup9Oxp37Q8M7fEbMOoBn4feY
         MqOdTL9j+spqHeEWu5iJ+DgrQogMz1uFVJc+G8QYqXrFFXegh1pb9AbQRc6CQ0L5RSO3
         q7KbVxPLwstoS6pgB3E8dNKfJtm5VzggeOXtGQ/u5xC/5/bIbaJYJMqiluMMm6q/ggQD
         ejVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1tCQPW+H36Y8+QmLJ4x094v94ZS8qHXB5SBzSQFvweY=;
        b=C+LjFIWr34V1R6P/7fN8kv/h2LeuZGzYkTASL2aWi1Ue/LCj3o7OcJi+3cf3eGjVWm
         z/k1VEa3CsTzX5aJsGYiLCfyLCArYzaSWU/iE/BkAxdDVh/IuNVk8yrRTyi5q+Q0M4+7
         03kZ+nMm+gGVSri72NbX5N6aeAPGKqYPxCf8oA4qcs8huJ9QGv6Rb2SypoprD7npb+hI
         GTcNnA0ElSB1DdUq2mV0zF10Wj/W/pJmsDgNtjaVDcyZwTqkpob3krHQ39WkW0gM4bUr
         GCLRkezPuUp0tS5yZvs2utcUDu9qg4fHrCCDe/UTjpIc5/8sCpey03s2nDkyGzzu4gi8
         YAbQ==
X-Gm-Message-State: AOAM533WQ+GB8TyvX7xAszgJ1o9p6MqwdmmejDt9WtiYenRZVWJAFKF4
	6pHseafqxOIAwqSt+YFjtpovwwtzMNfyIA==
X-Google-Smtp-Source: ABdhPJzyTnbqtezibIN/pjWbTJEkHN3MCw8AFUwxy6cWMtCwDOyfYBKEGkmIuyApvROY3dNZ0e402A==
X-Received: by 2002:a50:ba8a:0:b0:423:bdf5:41d6 with SMTP id x10-20020a50ba8a000000b00423bdf541d6mr21845670ede.204.1651647805149;
        Wed, 04 May 2022 00:03:25 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:7a96:3505:45fc:e9cf? ([2a02:578:8593:1200:7a96:3505:45fc:e9cf])
        by smtp.gmail.com with ESMTPSA id b13-20020aa7df8d000000b0042617ba638asm8838787edy.20.2022.05.04.00.03.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 00:03:24 -0700 (PDT)
Message-ID: <c7d94470-f161-7bb0-f4c1-b62ce7263134@tessares.net>
Date: Wed, 4 May 2022 09:03:23 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH mptcp-next] Squash to "selftests: bpf: add bpf_first test"
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <3efc49e473d2fbb03c9577aea5959b35d29d2c9e.1651625191.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <3efc49e473d2fbb03c9577aea5959b35d29d2c9e.1651625191.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 04/05/2022 02:47, Geliang Tang wrote:
> Set scheduler to default after test.

Thank you for the patch and the review!

Now in our tree:

New patches for t/upstream:
- 56aa85d15070: "squashed" in "selftests: bpf: add bpf_first test"
- Results: 9cac72edfb62..ba73bf84ee7f (export)

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220504T070238
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
