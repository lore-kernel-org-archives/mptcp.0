Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D785675
	for <mptcp@lists.linux.dev>; Fri, 19 May 2023 09:36:54 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-96598a7c5e0so487205166b.3
        for <mptcp@lists.linux.dev>; Fri, 19 May 2023 02:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684489012; x=1687081012;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IIhJXjLlwtwhFjGFHGpdXhyduE68OmcoAs3ZStSoDr8=;
        b=z8CuSLFxXkvUKHv7c4NxaIs0c4CcmGH7RMLTvuFzvRLQy0K6j+635w1pcnMw5kksWI
         kjPrdLp0HoIOZ2pGmMmEkpoWCjP1zlT+i0anME14Pg/3eJmSloYDtZG9e+kE5zmZzyhb
         BEAByUjlqG+RA27JKsbAO56JR2tvmf8cis0eiKXmfA/76UKm6Ivyi/rw1cZrgR9SirCf
         xcgfFohGv5tkHtChVOSpaQ+2loVoZqYrRXeIu2Ph8M3IumA7IWssMoOwuT5WmFgfpluW
         zHHLg4Pyy77on/eQhvtmnV8f5eM+KmEg9EB6SsVFdjub/eNCFbhkduFzj1ryZQm+s8Qy
         4jEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684489012; x=1687081012;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IIhJXjLlwtwhFjGFHGpdXhyduE68OmcoAs3ZStSoDr8=;
        b=a+iIeML5QfVW8k/3HI1a+RtVSDD2yoP9Hw8oTiQDA4RnzI++U1hfVAS9yyQQWzd4q6
         Oot79FqNk1wa2OyjPtl8uPbz6cg9Rzwj/JECrQvKBg3zu42zWxCBuQqaso0YCjz9kH05
         Tk7+Pcmron5zBWQyUIpVOEB4jy3Dn8uu16TtIYnf6OYm/LHB6vGD6MvuNO/scs2JXvzp
         jSEK/cxnxUEOOOTmmCcjaJdW8U+55MOefRHPO6CHddgOHwophoSFgWhCtyBN25fyXvjD
         jszW7UuV+S3TlXgDgeNKzThS1OrEsVYMDXdJwWVgz6AtzBVQEW0okLds63ITszSytaQQ
         ElyQ==
X-Gm-Message-State: AC+VfDweq/kkQiOYe8/5tN35sSwlMF5F/k4tK0qhRsLbQiIhorBeB12O
	+QtG5zwKaVHM3+Tt9syavyZzqw==
X-Google-Smtp-Source: ACHHUZ7wRZUoLYYBpjjC88jluhy/2RJxdL/uRrdsNOwWASDMHM4ygA3zXLx+ryXI5IxedN0Bw39Jiw==
X-Received: by 2002:a17:907:7246:b0:96a:ee54:9f20 with SMTP id ds6-20020a170907724600b0096aee549f20mr1272420ejc.37.1684489012330;
        Fri, 19 May 2023 02:36:52 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id u27-20020a170906069b00b0094f7744d135sm2080974ejb.78.2023.05.19.02.36.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 02:36:51 -0700 (PDT)
Message-ID: <8f268175-128a-d015-af04-defe4785bdd6@tessares.net>
Date: Fri, 19 May 2023 11:36:51 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH mptcp-next v4 0/6] run sched tests in a dedicated ns
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1684362296.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1684362296.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 18/05/2023 00:29, Geliang Tang wrote:
> v4:
>  - patch #1 could be merged before "mptcp: refactor push_pending logic"
>    as a single fix.
>  - patch #2 should be merged between "selftests/bpf: Add mptcp sched
>    structs" and "selftests/bpf: Add bpf_first scheduler".

Thank you for the new version and for the explanations!

I suggest to apply the first patch also between "selftests/bpf: Add
mptcp sched structs" and "selftests/bpf: Add bpf_first scheduler" as it
seems not needed before (see my comment on this patch).

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
