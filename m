Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4B070
	for <mptcp@lists.linux.dev>; Wed,  4 Aug 2021 08:52:36 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id x90so2535645ede.8
        for <mptcp@lists.linux.dev>; Wed, 04 Aug 2021 01:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8F0In5K6/inkq3He40ee+kCuYW6wCigwIwnUeveNK5I=;
        b=ArKtAuVuCo46t/o6yU6jlQM4RqBYL+Cot/UMU754fOvpvaWc57hESioseb9eOOfUdt
         QSRlAbuol5dd0gxU993lKj8qJ7UAu4JQsEATF7rYgc889i38GituME+NVNP8MMy/U2tI
         elzweJ1A8ghWT3Uvc2jyVFeVSAP4Dheu9VKX8r/qYPrMGLuoL4OR9U+ZsHZNin7oBw/u
         oZ5563mw3jAG8n0ZnwPwcaheHTXqKvgWn64wiW3R/ilqnZQkLUorYAmlKEVjJDNjB/G4
         cjsvx6Oj0uPaBi2Eu+HmBTHEW+eed4OdA5Lj4Mqii1jE801BBzuJCN1Pp0XNSPS1dNBh
         JxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8F0In5K6/inkq3He40ee+kCuYW6wCigwIwnUeveNK5I=;
        b=GXQEGQ3zjjV/kppiBx47wSVx+7vYj1eLV8taulPS7+X0lXjKsBDwQkg3WgXMHlkv85
         Nsmxh6HrofpMV7596Lke+Eu+7aNrd8jt8+BUZNaNpRbPK4DXP6GnGdBnOZ4s6vCRWuBb
         kn0kOm7ijf/dPPdh6MlsLQPz/Z9IIjCkpYWiylveAdGhsh64/aSL7GZpoDIIOHvYvNo3
         YLSzP/zBnZ4etI6GEfOgPI0maFrmlGa5hXLNHpjLPOCUnsxEsr2fPwoJAL2wgMGX1sED
         2eNUxBId0JdBEspaSFB/CozlmnV7fgD+BjU3nHRcwQB/iy2TUznVMQxXnrdUnkYDfDGF
         a29w==
X-Gm-Message-State: AOAM533mXLmWBpfuBa1DzyJwHpz+eWBvxB+rQTxcP6gK65dkJ8mz/9vt
	uQGzJXRzTOg9uIpzpbrSDSMrpQ==
X-Google-Smtp-Source: ABdhPJyAk+n7NRml3TM0l1jZqCdvjWzvQiDupugPUcOnAl+57Rv1f0vOUodlzIGDq4MkInSTLOYCVA==
X-Received: by 2002:aa7:c647:: with SMTP id z7mr30430143edr.52.1628067154705;
        Wed, 04 Aug 2021 01:52:34 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net (94.105.102.61.dyn.edpnet.net. [94.105.102.61])
        by smtp.gmail.com with ESMTPSA id nb39sm450494ejc.95.2021.08.04.01.52.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 01:52:34 -0700 (PDT)
Subject: Re: [MPTCP][PATCH v7 mptcp-next 0/5] MP_FAIL support
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@xiaomi.com>
References: <cover.1627547666.git.geliangtang@xiaomi.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <2d68e24d-7aa2-0a16-ebdc-e672a7065287@tessares.net>
Date: Wed, 4 Aug 2021 10:52:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1627547666.git.geliangtang@xiaomi.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat, Paolo,

On 29/07/2021 10:40, Geliang Tang wrote:
> From: Geliang Tang <geliangtang@xiaomi.com>
> 
> v7:
>  - The single subflow case is handled by sending MP_FAIL + RST instead
>    of sending MP_FAIL echo.

(...)

> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/52
> 
> Geliang Tang (5):
>   mptcp: MP_FAIL suboption sending
>   mptcp: MP_FAIL suboption receiving
>   mptcp: send out MP_FAIL when data checksum fails
>   mptcp: add the mibs for MP_FAIL
>   selftests: mptcp: add MP_FAIL mibs check

Thank you for the patches and reviews! Now in our tree with Mat's RvB tags:

- 6bf0897526b8: mptcp: MP_FAIL suboption sending
- 913f5ee5f5e8: mptcp: MP_FAIL suboption receiving
- cce924a902eb: mptcp: send out MP_FAIL when data checksum fails
- e14356532033: mptcp: add the mibs for MP_FAIL
- 77405167d756: selftests: mptcp: add MP_FAIL mibs check
- Results: 7706daf6fd74..d2d5ed438884

Builds and tests are now in progress:



https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210804T085052
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210804T085052

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
