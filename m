Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE6171
	for <mptcp@lists.linux.dev>; Sat, 19 Jun 2021 07:07:58 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id nd37so19540940ejc.3
        for <mptcp@lists.linux.dev>; Sat, 19 Jun 2021 00:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=NMDe4CZdgGGgVe797gV0P5RyXahODRLwEkkEn9XksJQ=;
        b=Yp66EVooXJOC0kVHTsJ5nBLjGU4nxQDfRmpE0u+JjeQotjVy0gelcqvNOfSTEffW8p
         u97Gt+zghczAKF/4K/a/HuQu9St1sRabPvCU+WNK4W5NVma7i1T9lGfl/j+nNGbQIh8n
         IxaI0zzabGxjZi0Q54tWKZIiZs2JQyDZDlLvFAmFu9SMqNvY2848ZJX9UphDDNxdzIuK
         Fqg9oL8r9duo0yye7hBmccDBaLV4lFv41OuVydKF5TwAIFaJKWkdU8CvKt5OUo9Fppvk
         QbdtNuf16R17H/f+Uit86RLLg1+KrQ1l1oFMM6LCsJ0Led2fbjM4errwEMRslbcZ7089
         73zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NMDe4CZdgGGgVe797gV0P5RyXahODRLwEkkEn9XksJQ=;
        b=sUtQL7FHKP0ga64RZ6zBdnjKgTEqXzAFP52FH7hvhroAI+JcYbYapOtCxhlwKaTMSQ
         P40qlpXaCT3SRmI9uyAKyB1CsMZ9JJTUGnoDD6ERKQ0ISUpFLtoNcuGmeiXCMEsHCTnt
         2nQoSljPqe4WFA7mHByRpj7BywTW7XDi8nPJrgNFVpvb7qbq0tR+QVjpoW8uRZZ6AyZj
         EjIlc9NRgLDf75vcFzDJv76TtIJWcV+OYQY4mt9riJVqx0nWEA3c9NBFdJghGTPVIV+j
         v1wt4m2EohoynIWnSGVdxKa0RfVyjvUnXR16MJcSfGZ+ENHkx5LA28EXQGZVnhwMmSsq
         jMKg==
X-Gm-Message-State: AOAM532ShesNK5mDPQzbN9wjv8e4T6/9+8MM+zsnBLlGzTtLRm0GSbFN
	/WaTO39jMFe+YABvJ3duOixTolDla6uY8Kkb
X-Google-Smtp-Source: ABdhPJyLVv2pvTTCawLVHayzblrOz1a21XGu9oYqfXD20pW907cJUkf87KLT32RG3EuUiRanTjyekQ==
X-Received: by 2002:a17:906:b201:: with SMTP id p1mr9009945ejz.316.1624086476782;
        Sat, 19 Jun 2021 00:07:56 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:6056:4c8a:a7ae:d72f])
        by smtp.gmail.com with ESMTPSA id bh2sm1989846ejb.80.2021.06.19.00.07.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Jun 2021 00:07:56 -0700 (PDT)
Subject: Re: [PATCH mptcp-net] mptcp: drop duplicate mptcp_setsockopt()
 declaration
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <c3038e2051a4b0a718e868b9129b5c6ecc682fef.1624038975.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <336c63d8-d202-024f-ac2f-1626af8e08ab@tessares.net>
Date: Sat, 19 Jun 2021 09:07:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <c3038e2051a4b0a718e868b9129b5c6ecc682fef.1624038975.git.pabeni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Paolo, Florian, Mat,

On 18/06/2021 19:56, Paolo Abeni wrote:
> commit 7896248983ef ("mptcp: add skeleton to sync msk socket
> options to subflows") introduced a duplicate declaration of
> mptcp_setsockopt(), just drop it.
> 
> Reported-by: Florian Westphal <fw@strlen.de>
> Fixes: 7896248983ef ("mptcp: add skeleton to sync msk socket options to subflows")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Thank you for the report, the patch and the review!

Now in our tree -- fixes for net -- with Mat's RvB tag:

- 2c55fe95b0ee: mptcp: drop duplicate mptcp_setsockopt() declaration
- Results: 43a335a6d44d..eb9ae196ed3a

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210619T070741
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210619T070741

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
