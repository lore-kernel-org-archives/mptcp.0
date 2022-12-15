Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0832CA2
	for <mptcp@lists.linux.dev>; Thu, 15 Dec 2022 09:57:33 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id z8-20020a05600c220800b003d33b0bda11so395800wml.0
        for <mptcp@lists.linux.dev>; Thu, 15 Dec 2022 01:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fg3wBfGQzRLzix1ExPbOPPMa7uFIJr/nniX5WhbXxU0=;
        b=KUKYcn7NoODghL59RFIQIC7h0kU4Y6aUpSr4S/sRg9lXCMnlEqTK0SBWgnYAOqdDuF
         +JieYgWmkN975F/nFRx8D8rGts8WVzqMcpYZs/n3NqjL8FKC4OyaJmdQ4fUXyKNU49yl
         jeSgzai51r13V3pdrgUjSfJGg2JX7V89GfN3pwmvGgYRvUzt9reo9YWzqC1VuIBFS9Au
         cWFO/Ay0r0rxUUHglGZUSfUVKlpThxSEmYpXTinK4vuZdkuBuYH5goWN9p3olCBmc5ft
         sXaAugVk9ntcyKmqZVpN6PhRiarnBqMQ6OD5PhaW/hezOkbfYunGpVciuxEmjzgElSw7
         oa6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fg3wBfGQzRLzix1ExPbOPPMa7uFIJr/nniX5WhbXxU0=;
        b=BfX1EX/s/oRDc+79u+ZCS6i6PRqZ3bVk2LDcc1HKoeC9RncYdGjYuZbexTidfBnU4X
         burLGQ6Vi1rqS84/TS0xEYL/hOxrziM+TGwhw1Rlso59TDyOyxV2lgfEH9a2zQ0xOdXq
         WcDe0+bAFNZq3egXjtZgRb6bhU7PDSleOOlFMfMwYrRij7t1gvfC31kWrqJtyvmsGd2u
         UnkLE6kJ9LoaHEjpV0otMhGMt88/L8qIRFn1fNbOdTtkr13gdCxpKa08n+HcKOQZDyaG
         1vDF138Jh3oeDOw8G05T+0Zrr/c7KRPDr1uFxMBlCj5cgC2wDCHpQT+4Hq/od7qkjZef
         yxSQ==
X-Gm-Message-State: ANoB5pknbSbVOlzFDALdGtWEJwgStdnDmXRcSfl78dmBo6N3bh7YOy7B
	p3ox5meaOqBFuu5F/wokE4NJcg==
X-Google-Smtp-Source: AA0mqf6/qbomlwOG2S2CVozTt6ExsLK3JR2noluKFiHC45hXeg3vO8pj4ARUn3rkc6Zhd3Dag4OI4g==
X-Received: by 2002:a05:600c:4e52:b0:3d1:fcac:3c95 with SMTP id e18-20020a05600c4e5200b003d1fcac3c95mr20930913wmq.34.1671098251948;
        Thu, 15 Dec 2022 01:57:31 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:2deb:62f6:e6f2:ee30? ([2a02:578:8593:1200:2deb:62f6:e6f2:ee30])
        by smtp.gmail.com with ESMTPSA id p16-20020a1c5450000000b003d07de1698asm5524150wmi.46.2022.12.15.01.57.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 01:57:31 -0800 (PST)
Message-ID: <ccfcca60-bb56-c782-167a-c8f14596f07c@tessares.net>
Date: Thu, 15 Dec 2022 10:57:30 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH mptcp-net v2] mptcp: fix lockdep false positive
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <1f27ea6ff3b76035685ec372cc9e2753b9f9d90e.1671032651.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <1f27ea6ff3b76035685ec372cc9e2753b9f9d90e.1671032651.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 14/12/2022 16:44, Paolo Abeni wrote:
> MatB reported a lockdep splat in the mptcp listener code cleanup:

(...)

> The report is actually a false positive, since the only existing lock
> nesting is the msk socket lock acquired by the mptcp work.
> cancel_work_sync() is invoked without the relevant socket lock being
> held, but under a different (the msk listener) socket lock.
> 
> We could silence the splat adding a per workqueue dynamic lockdep key,
> but that looks overkill. Instead just tell lockdep the msk socket lock
> is not held around cancel_work_sync().

Thank you for the patches, the great explanations and the reviews!

Now in our tree (fix for -net) with Mat's RvB, a Closes and RpB tags.

New patches for t/upstream-net and t/upstream:
- 71fd5e75df68: mptcp: fix lockdep false positive
- Results: d330d6da95d3..74c46cd6bf02 (export-net)
- Results: d3d3b2053b5b..130b6676200e (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20221215T095520
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20221215T095520

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
