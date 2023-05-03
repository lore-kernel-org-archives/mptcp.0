Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEBAA52
	for <mptcp@lists.linux.dev>; Wed,  3 May 2023 17:33:59 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-2f7db354092so3498909f8f.2
        for <mptcp@lists.linux.dev>; Wed, 03 May 2023 10:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1683135237; x=1685727237;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Glsb/N9unMvImeu7vJOKRsx93i0/9l+zFSZSHUmtuCk=;
        b=wdJMCw31B7HlJUVDB7pkMKUf0t6m2rUenB+5tIzWSyLkBOKE1JFGZdGOZbg5F+6OIE
         2n/Pw7EXohrWhenSbQRTSV3nVDcztRKgQ3OUW4cLY4f2CKb3HmQJwwEBkrkL2aqykcXp
         8clJDH1ceiebg0HNJ41rAo9PXSP0HvsiXTMQvWMgboG2R3vw2g1K1+wPGueoctbN9u6u
         chmSX0K+37SOHeqhNYPzKWgmK1yeb3XsSHm91hWxNK5rkoDEDxg6WHpKlFJ6882Y1ZwV
         UxMC9HWO3N3m5V1eLn06vp3qdLiBI1sZJ/r1VY+j1kHnaCJzSHskYBQRk9BVVq73xsBq
         iAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683135237; x=1685727237;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Glsb/N9unMvImeu7vJOKRsx93i0/9l+zFSZSHUmtuCk=;
        b=EB9B+wVejuIyPaaSaB7o0KmC/HZjRjTylUdFotQfFW+7Bu3OSl6cNtocZoR/d/Y2AO
         utbr7qUloiuy2XjVz/0uAA26EQDkBrsYzeKLutw1qCJZYlOMi3FDPngpMYryrLehGLhT
         6xWFoDJpe52leEF6mEmLg81p9sNDvu6NDBb+LAsmKMdNKXgknu8rGJsEeLE6qLKI2vSz
         bX0PebBJfyo4SEInqzDjAMnoCrmk20wqVI0gLRr3wwXLyvwrOlbLXf81N7NZDdzR6fWY
         m53wvu337QrnRkBiIEVeErjaq5nO6DG8Iedbg0PzgtNeyej5GUvIayXZPCpQ9wO6KWW6
         uPEg==
X-Gm-Message-State: AC+VfDxUBF3rt7g4impvihTe5+AizoQqY4I7Orqy3HBAFNXxm11a/nDR
	Fmogia7EikD93PHQXhpFo+YhY77/c2RMR9kZLGQ=
X-Google-Smtp-Source: ACHHUZ5HFhMXubLgAlzCWiHhDAtDn4Og3Fc1hGCMcvSp5dHJW3Hbdg73Som0hG+xev9pf+wuFEGXuQ==
X-Received: by 2002:adf:f1d0:0:b0:306:3b72:6b7 with SMTP id z16-20020adff1d0000000b003063b7206b7mr611762wro.55.1683135237614;
        Wed, 03 May 2023 10:33:57 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:ffdc:60e3:7c6d:ec67? ([2a02:578:8593:1200:ffdc:60e3:7c6d:ec67])
        by smtp.gmail.com with ESMTPSA id u6-20020adff886000000b002f28de9f73bsm34407581wrp.55.2023.05.03.10.33.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 10:33:57 -0700 (PDT)
Message-ID: <cac7c93d-d82b-c050-d232-bab84850547f@tessares.net>
Date: Wed, 3 May 2023 19:33:56 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH mptcp-next v10 0/6] update userspace pm mptcp_info fields,
 pt 1
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1682499136.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1682499136.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 26/04/2023 10:56, Geliang Tang wrote:
> v10:
>  - fix userspace_pm.sh errors reported by CI.
>  - fix the bug in mptcp_pm_remove_addrs in patch 1.
>  - drop msk->pm.subflow == 1 in mptcp_userspace_pm_delete_local_addr in
>    patch 3.
>  - exchange the order of "pm_nl_ctl rem" and "pm_nl_ctl dsf" in patch 2
>    and 6.
>  - update the commit logs.
Thank you for this v10 and sorry for the delay!

The code looks good to me, I just have some questions for you in the
individual patches: do you mind replying to these questions please?

Maybe all we need is to add a TODO comment/ticket and re-order/squash
patches? Or maybe not, I will see your replies!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
