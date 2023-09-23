Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB73818
	for <mptcp@lists.linux.dev>; Sat, 23 Sep 2023 07:55:22 +0000 (UTC)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-501eec0a373so5614412e87.3
        for <mptcp@lists.linux.dev>; Sat, 23 Sep 2023 00:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1695455720; x=1696060520; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=O64NvoB1FxjbGCVaNSnzgxJIeuN2vjN9z1E+ICwvUnA=;
        b=Kn95l+nZBB6+EqlUL1lcdWk3eWVCMF8tYJhRmQoEL72TL2WhNE/Rc7YboER/U8gCsD
         qBAAB7Q04+kK9tfQRKBmuF9ny4RWuAp8cgPVe9NVZgE1kcinS31WUJespzF3XPGfeDI0
         nV3Ht1fInOQuh3lyN4iWg+sMCjxGi/rmj6b3dG5B3eigWIIalR/QOa9ZWYF3b05dZ/5t
         m8SDhG2BxLzvqGCuFuRifqNEhT+a/ThM41FZeCu8uhfDF9KhTZYprCV3i1kMicj0MTnL
         ELjJ9767CWkAPcfzN1cL8tttlXbjJxwi951MmhXIFQ8RVkCcb757O46FemppwK4NMGpH
         VAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695455720; x=1696060520;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O64NvoB1FxjbGCVaNSnzgxJIeuN2vjN9z1E+ICwvUnA=;
        b=CA/R05iIC6F1BH+KDOgdSijygNwO8MhdnI8T8xpqTfBOHr2ScIGQ/5EMGul2+0YHhG
         PoTVKQUfPI06GKHUAiPa0Xh+5eBn5Wtvo5BlvNrRXhaupbJvnpqxtWNYKuXRzEx9Vvas
         hJdFQlwvoZF//dTIT1bolKOHNJAJWzFxsw9OMiAxskIRGRACqWV2rdMgKfOsA1Uwi9n2
         wFSTEFssD/D22629csN0fntSH6QVHIhus9wD5JT3OcqFWkABObsjVzuWfQR0WGh6kXBU
         GI3Q04UJKgM3xEv58+FaoLh6Z2dEHpDLtJBOfpOBpJM1ZLC227iOAvp2bAr09xFy83cy
         TvJw==
X-Gm-Message-State: AOJu0Yxrt1f7ZqqWVjyRv6YF+4GADkVZZFYWT0tNXKenYOZ07/YQfNf5
	eHDHsav/NMb3xXjUvCJD/8Pf5w==
X-Google-Smtp-Source: AGHT+IEFhTqMKU4RMr3PKHAjXloNbAXwXlReNo4bqSbxyspwaDUHb3W4RiUOAOz/jkx4taDJZd1mqg==
X-Received: by 2002:a05:6512:318d:b0:503:367c:49c6 with SMTP id i13-20020a056512318d00b00503367c49c6mr1769454lfe.45.1695455719963;
        Sat, 23 Sep 2023 00:55:19 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:1c88:7af9:498d:bb0e? ([2a02:578:8593:1200:1c88:7af9:498d:bb0e])
        by smtp.gmail.com with ESMTPSA id s13-20020a5d424d000000b0031f729d883asm6280626wrr.42.2023.09.23.00.55.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Sep 2023 00:55:19 -0700 (PDT)
Message-ID: <b0102ef9-9dd1-4622-a7ba-117dc3b14c0a@tessares.net>
Date: Sat, 23 Sep 2023 09:55:18 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v4 0/6] mptcp: convert netlink code to use YAML
 spec
To: Davide Caratti <dcaratti@redhat.com>, mptcp@lists.linux.dev
References: <cover.1695201346.git.dcaratti@redhat.com>
Content-Language: en-GB, fr-BE
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <cover.1695201346.git.dcaratti@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Davide, Paolo,

On 20/09/2023 11:24, Davide Caratti wrote:
> this series converts most of the MPTCP netlink interface (plus uAPI bits)
> to use sources generated by a YAML spec file. Patch 2/6 and 6/6 have been
> individually verified with kselftests.
> 
> POC:
> 
>  $ sudo  ./tools/net/ynl/cli.py  --spec \
>  > Documentation/netlink/specs/mptcp.yaml --do add_addr \
>  > --json '{"addr": {"addr4": 16909061, "family": 2, "flags": 4, "id": 10, "port": 0}}'
> 
>  $ ip -j mptcp endpoint show id 10
>  [{"address":"1.2.3.5","id":10,"backup":true}]

Thank you for this series, the new version and the reviews!

Now in our tree (feat. for net-next):

New patches for t/upstream:
- 9efccfde1d18: tools: ynl: add uns-admin-perm to genetlink legacy
- 34e8d83f1515: net: mptcp: convert netlink from small_ops to ops
- cf4a7c60248c: Documentation: netlink: add a YAML spec for mptcp
- 25385acaa5c7: uapi: mptcp: use header file generated from YAML spec
- 11351fc8e13b: net: mptcp: rename netlink handlers to
mptcp_pm_nl_<blah>_{doit,dumpit}
- 7d081cf1470a: net: mptcp: use policy generated by YAML spec
- Results: bf9368cc6ffb..1c2adc4e573c (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230923T075423

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
