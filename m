Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23599168BF
	for <mptcp@lists.linux.dev>; Thu, 17 Aug 2023 16:30:03 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-3fe4a89e8c4so497555e9.3
        for <mptcp@lists.linux.dev>; Thu, 17 Aug 2023 09:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1692289802; x=1692894602;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Ckb94Y3rWmsV8LkbuqyhddbshGKVHcOHBT+SwtBBQ0=;
        b=V9jFL8KQL7BxnVtUb7ThXJ8KCVHtNYNYZ+32etp1Pj55RIpWOUo5V/UlhMwvG8er9y
         D+umulpyy84dzfg9ahKKibFHbkTI4YF4XPLq4usH5VlyO8ENpcfQ4ADwQoYGVKBNfimW
         A2auN4UG9Unn5IbbEEL4ri65M8skWYAi2jQ1+EZY7MJ945bAS/NWYP1iXqYq0XtdYckk
         4BkaC79IRIMwjxHe/TyGFsxXsp1q+fosE3Ev4pC50cg9nI6XVhaKyf7/NMN+PQ9OmfDY
         KgZu0UXUgZoF6/3gOIjaEalblhTah+caURFXfkhx5rC1VmkMbh/9NlBjRCEU5s1Ubi+U
         R4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692289802; x=1692894602;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Ckb94Y3rWmsV8LkbuqyhddbshGKVHcOHBT+SwtBBQ0=;
        b=euqyekc9ehTH2Vu5SIDPKiKSzmPS6Y9S2a0kim2xcqTWoMtIaoHxw++yRhkxlN6v2z
         nDk/L2QMk4cI0/rEuker+DHEWGHgm8gbfALLSLPGaioEfBAUOJzg23u4xAjYVSqf/Yhw
         uUFYhy0+yUd0vAgOCnU9lk6evYC+AdTwy5x34/OdIlRez01nuC4jXLyUvrlJPSLlV83z
         rB3AoFlij3zTBObFc3KvHhP5EwPYAL9fHgKFRR3bmaIQx8iCJh+QTmPMC+m/msBKIJNN
         xGlWryfSWZCoLqxXD/hAzxFh2cWbRRtF5Oo2XOeE/zSuRQOugF/1MOhQVb5pqyGWkxJo
         KwWg==
X-Gm-Message-State: AOJu0Yyz1/60gMCHUYgylU+6oHTUXoEMDrOkqHlHKbI/ceTCiZdK46xG
	N2D6OXdBTOUdV90ABAwCwAhOi+pWQRUcjjQ8V4U=
X-Google-Smtp-Source: AGHT+IFJiuSFLwDeypHXJRnEYMtGpKj/mjyxyxSLVoLNHNflIImBc4PTgEUxb3vvWTV3zpm6+WkcuQ==
X-Received: by 2002:adf:f141:0:b0:319:8c35:37b with SMTP id y1-20020adff141000000b003198c35037bmr12623wro.7.1692289801727;
        Thu, 17 Aug 2023 09:30:01 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:c88:d59b:1c03:4962? ([2a02:578:8593:1200:c88:d59b:1c03:4962])
        by smtp.gmail.com with ESMTPSA id s2-20020a5d4242000000b0031989784d96sm8913914wrr.76.2023.08.17.09.30.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 09:30:01 -0700 (PDT)
Message-ID: <05b4766b-c225-4ff0-84a3-993cbb2d03ea@tessares.net>
Date: Thu, 17 Aug 2023 18:30:00 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v3 0/3] userspace pm remove id 0 subflow &
 address
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1692281317.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <cover.1692281317.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 17/08/2023 16:10, Geliang Tang wrote:
> v3:
>  - address Matt's comments in v2.

Thank you for this new version!

I think you forgot to reply to some questions I had in the v2, mainly:
was it OK before this series to remove the initial subflow?

I have other comments, please see the different patches.

Regarding the selftests, it might be good to have 3 different tests:

1) remove the initial subflow: was working before this series but not tested
2) create an additional subflow using the same source IP address as the
initial subflow (ID 0): to validate patch 1/3 from this series
3) send a RM_ADDR for the ID 0: to validate patch 2/3 from this series

For (1) and (2), the test "userspace pm create destroy subflow" could be
modified. Or a new test to cover both at the same time, e.g. to add a
new subflow with local ID 0 and then remove the initial subflow. WDYT?

Note that these 3 tests could also be validated from userspace_pm.sh
instead, no? It maybe makes more sense and would be faster? Up to you.

(also, this series is more for -net (mptcp-net) than net-next)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
