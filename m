Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CC660841
	for <mptcp@lists.linux.dev>; Wed, 24 May 2023 13:58:28 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-3f6094cb2d2so11673145e9.2
        for <mptcp@lists.linux.dev>; Wed, 24 May 2023 06:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684936707; x=1687528707;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=io5vVKS79zb1wZuL5eitzTabAMSFvkmFQSoVpZRW6nk=;
        b=fktxj6vtbUcQOP7cylf25uLlIbRfIlQYSVOXgdbaA15aIF9fxwxhP6brlPtadBccZC
         vb7OdgjBPYmnW1VAiBgiKPmzuc533LxzEWru5Z2+J+QLl1YVmi3DXZ2HPvEkKjD0WYqU
         kqCdGjB9ed5j4wfUY2phacQ/F5+j0nHVxOrWEPk7pTZrvgEg6A++rlUgAulas/u7tMOG
         cZspFbk8UuUfO5vV7IYGzIG+xwPxIJ6pZALhAqQa4TpsJc0LvPNHOk7kyvzJUqU/c6vE
         2vteophjWLupd2DaJ7qKzsF/IP+FiPL5qfPsNuXXJOij5ntqJ4q79XlHza9TiCFbLvxQ
         Xjyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684936707; x=1687528707;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=io5vVKS79zb1wZuL5eitzTabAMSFvkmFQSoVpZRW6nk=;
        b=eQ9bbbnlDCqCuMuFttx0Xq2BMO6eNYr/mP9hjoBdrKuO95f8HgNbQQ/w6IHDpLo8Uw
         oyH9vtqAwdGQQDM656Z28P+T7whv8cJM8y36c6ClYgwvIllK3z0azMWuJ7D+oKIsfyAb
         IfIWBEkIY/mpylO/HWIQ4oAGTmgzFEPby8eCnnuMrHRRjSsGmYScqhfCPyK/hyfkCD9x
         YJ+eNDFcCA6qUN0fXq5Clu0aPq9hDOkGzt0uMzWUA1YmLKcoo5Tr1BlEd97Vm2/Z9/el
         XOa1RfuA8RgzeoTu6lmGew5I+/z0QB6423INLrFj/zv7uddJz5M07TQVgsABOHAl8sD3
         kFcQ==
X-Gm-Message-State: AC+VfDyRRjw7DOuDDZ0kwrM22tFivHqm8zAP8kxbS8tp+jHgVhVxWMCA
	uS5bkAptR9deMX6Ii8e0W9Cqzw==
X-Google-Smtp-Source: ACHHUZ5m5VSLeuMUZX58c5fmEHrv84P7rlKMXH4wmHdtuj9x8kqjQCSpcscBwckqIdWf6hz8I08ONw==
X-Received: by 2002:a05:600c:364b:b0:3f6:be1:b8d8 with SMTP id y11-20020a05600c364b00b003f60be1b8d8mr4741381wmq.14.1684936707076;
        Wed, 24 May 2023 06:58:27 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:735b:1ad0:911b:4361? ([2a02:578:8593:1200:735b:1ad0:911b:4361])
        by smtp.gmail.com with ESMTPSA id m11-20020a7bce0b000000b003f6042d6da0sm2525246wmc.16.2023.05.24.06.58.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 06:58:26 -0700 (PDT)
Message-ID: <3d861cf3-3c6c-b1b9-314a-5fecb47cd34c@tessares.net>
Date: Wed, 24 May 2023 15:58:25 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 mptcp-net 0/5] mptcp: a bunch of data race fixes
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev,
 Mat Martineau <martineau@kernel.org>
Cc: Christoph Paasch <cpaasch@apple.com>
References: <cover.1684427027.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1684427027.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 18/05/2023 18:59, Paolo Abeni wrote:
> The patch 1 && 4 are direct response to recently reported KCSAN
> splat.
> 
> The patch 2 && 3 are just by code inspection of related code path.
> Patch 3/5 is there mostly to make the next one simple, even if the race
> mentioned in such patch should be real (but very tiny, if possible at
> all).
> 
> This iteration addresses a compile warning in patch 2/5 reported by
> kbuild bot.
> 
> Patch 5/5 is new in this round, fixes an unrelated issue found by code
> inspection. I should have posted separatelly

Thank you for the patches and the reviews!

Now in our tree (fixes for -net) with Mat's RvB tag (and without some
typos reported by checkpatch.pl --codespell). I had one conflict with
the scheduler BPF series, nothing important:

New patches for t/upstream-net and t/upstream:
- 2bf493e0a2c7: mptcp: add annotations around msk->subflow accesses
- 824fba99ecc6: mptcp: consolidate passive msk socket initialization
- 76d73119db47: mptcp: fix data race around msk->first access
- d68a0ccb3108: mptcp: add annotations around sk->sk_shutdown accesses
- 2971ca12a7ac: mptcp: fix active subflow finalization
- 0063946d91ed: conflict in t/mptcp-add-a-new-sysctl-scheduler
- Results: c08e2cb009ac..b87768580a4d (export-net)
- Results: 1a70ca6023d3..0a9978390b78 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20230524T135256
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230524T135256

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
