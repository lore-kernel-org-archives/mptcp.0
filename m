Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EB913ADA
	for <mptcp@lists.linux.dev>; Sat, 16 Sep 2023 11:14:13 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-31f737b8b69so2797849f8f.3
        for <mptcp@lists.linux.dev>; Sat, 16 Sep 2023 04:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1694862852; x=1695467652; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nmQ/Or7+Sj6zlIcSI+sPdxyZAP/UvEcK82Vjo6Mt7y0=;
        b=sy1cyQ8QB76H9WM0viDm1XePH1D84l5qKdYFeext4sI9gyT5qjgwBLUWFHLP2cO9gq
         D0ghHDOrHcA+Uv90HdM+ZyvaeemHOzQdg7/4Alz0pOaDXexE7Sb58Pcp1TtR0CEJ1qBy
         dyayD2WnWxaZB+lXoW0M13VYxIK7Ap4FeUVjnTyWZ75atrXOW6cl6W3wXbOy3d1NXf2F
         daMDSwpvSMcgjqgcaKf5+KWUnj4YQl9waCw2FLEd4WqNTODUFsglT5YnQX+itH9fDLlR
         pGmdV3OQD2vu1QihB6oHN36+xQPiXxrDx8Q/uZxAGFzGtHUn6hPIv8H4OzkYB77wpVls
         0/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694862852; x=1695467652;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nmQ/Or7+Sj6zlIcSI+sPdxyZAP/UvEcK82Vjo6Mt7y0=;
        b=Fctnwjz93tjZ+GaGiIkizMnT53jzlj1txRAootTVBpJ9KwOPcXgtrBQYpSdgHcFYhg
         8Bbiz6YRPIGrttyF5QhUog47RxN6PorFqBcEPlBCZQmkXEsu4jTclZ9NKBiv+IAJ1sl1
         zHsai2ZgOKtuPNZuGmdaQl0egMfAn4kbYONrWib9usCsl2eK12l7rWUA034K+slnczno
         q4V8WH37P6DhRpprtc+Mir1zWcyFy5TWSQGcg+H2EbnKLbJ93xVkFrDUOePsnLOzSFAE
         VF0AqLi/+0ypdcX9Z3Iup7CaRajc8EiVO5w06sbGEQGD4phnlFC4g26q26Als4DPpERG
         9PTQ==
X-Gm-Message-State: AOJu0YxT6JsB8D7QdNGHJiOl+xDtFxGfltKX2yKgmbrYO4GvZF82kK+J
	JYNMLiSZG7W7Pd8RwxoBknySCjbd8EqZTpdzz13YxByP
X-Google-Smtp-Source: AGHT+IFwEFVL7Ik6B3yynAWlM+OGI/gKiloHeBCHyPRhytgHoq90jRkFlLQOlGOEO3pCPgDI6uO+Fw==
X-Received: by 2002:a05:6000:1865:b0:31f:f8c1:f43c with SMTP id d5-20020a056000186500b0031ff8c1f43cmr3781782wri.41.1694862852034;
        Sat, 16 Sep 2023 04:14:12 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:3867:6b1f:fd8b:a841? ([2a02:578:8593:1200:3867:6b1f:fd8b:a841])
        by smtp.gmail.com with ESMTPSA id r6-20020a5d4e46000000b003198a9d758dsm6939608wrt.78.2023.09.16.04.14.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Sep 2023 04:14:11 -0700 (PDT)
Message-ID: <2a1c0acc-52d2-4ffe-8216-c6fdf3e24a5c@tessares.net>
Date: Sat, 16 Sep 2023 13:14:10 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v3 0/6] mptcp: convert netlink code to use YAML
 spec
Content-Language: en-GB, fr-BE
To: Davide Caratti <dcaratti@redhat.com>, mptcp@lists.linux.dev
Cc: pabeni@redhat.com
References: <cover.1693921470.git.dcaratti@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <cover.1693921470.git.dcaratti@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Davide,

On 05/09/2023 15:53, Davide Caratti wrote:
> this series converts most of the MPTCP netlink interface (plus uAPI bits)
> to use sources generated by a YAML spec file. Patch 2/6 and 6/6 have been
> individually verified with kselftests.

Thank you for the patches!

I was looking at applying them but I just noticed quite a few errors and
warnings reported by CheckPatch. Do you mind looking at them please?

> Davide Caratti (6):
>   tools: ynl: add uns-admin-perm to genetlink legacy>   net: mptcp: convert netlink from small_ops to ops

Spaces are used instead of tabs for the indentation in
include/uapi/linux/mptcp.h and net/mptcp/pm_netlink.c. This code is
removed later but I think it is still best to avoid having many errors
reported by the CI when sending them upstream.

>   Documentation: netlink: add a YAML spec for mptcp

Can you add the path of the new file in the MAINTAINERS file please?
Also good to add a small description in the commit message, at least to
say that it is supposed to represent the YAML spec as currently
available today ("no behaviour change intended").

>   uapi: mptcp: use header file generated from YAML spec

Please add a "*" in the MAINTAINERS file to handle the new one in uapi.

Also, I guess we cannot fix:

  Please use a blank line after function/struct/union/enum declarations

in include/uapi/linux/mptcp_pm.h as it is auto-generated. (Maybe we
should add a comment about that in the commit message? But maybe it is
clear it is auto-generated?)

>   net: mptcp: rename netlink handlers to mptcp_pm_nl_<blah>_{doit,dumpit}
>   net: mptcp: use policy generated by YAML spec

If it is OK to send a v4, please also add Paolo's ACK. I think that what
he meant to say but he was apparently only allowed to send acronyms :-D

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
