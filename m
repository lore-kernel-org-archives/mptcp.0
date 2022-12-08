Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352862F3D
	for <mptcp@lists.linux.dev>; Thu,  8 Dec 2022 13:53:22 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id bx10so1726295wrb.0
        for <mptcp@lists.linux.dev>; Thu, 08 Dec 2022 05:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=As0GLmhqaqrZ5nmVwaWOkG3DSE3ny3px46Vfsfdwtsc=;
        b=1QJuAMYUFljsL6BBhrAYfuvY9ApYV9h2m2MS335may4M2Ga1WPFc49MR8RWySMtBaF
         e7r6nb88VVWjHTgFXmqIuUe4kEdZ4c+q90WECt0sTJHxLtgkXrUH90MLpU+xUn2l9KYC
         ZXELYQxdP/VGgpeyVrTUgEDC3N+JLMZQ8B3M01HvnkzizDK1+KGwJeO3fzYelUGsqSyy
         MuyWMuZmSsnyc2SfB4xiioQ0YCclfYr8xHm2aFGNrincvBpTwvc4Rev8ppqv1/iJxaji
         U/Akjc+sBvZIHIVQspnsQq9DVFDV/HatYhrB05HnoiGgzY2yZ7kSQG+aKUFK//9RtXUq
         ub8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=As0GLmhqaqrZ5nmVwaWOkG3DSE3ny3px46Vfsfdwtsc=;
        b=JBErJRATIg2vBgzPXoOoZdafUrUVN94WE66JakAdK9pZwkf3lRAtp2FFeXbQxWZTam
         gMms8q+sWBm9uD7hZolhr3NtVD7lVQCsWapneVj+gApFKkH92YTuakIKNGvlwXGSpnjH
         lYt44X9OyN4Cx8jWBW+UO//MdmMRW4+nRbW5yoJr9Hgz93OvrTrLg+++f0QfP5MuHEIJ
         z661VkO/O+iquab7RP+CAtg8WaaV7wWnCL9HeGzQMCoa6vnZPxjckdCpynTsrAuRrIgS
         WPhDvWn/gQPHtglQmfg/iz02BIlwBn/2syYkFQphNM+yZSkaaEH2OoFmPs8u2KvJC5yZ
         r9Yg==
X-Gm-Message-State: ANoB5pmrycqVvkcqD1hw95JsC14E0SM/Dw0lP5v0poW6NVQJSxbLe5Gk
	Cr3tIC9jqg9/e1Ep8RDjO1j3SQ==
X-Google-Smtp-Source: AA0mqf4700HUOI9fGovqyQCiClk/iCvAjjsPkQzWF9hZnH4Mi4kJf4WqFdVgqK+zek+hQM5q/u4tEQ==
X-Received: by 2002:a05:6000:710:b0:242:4e26:51bc with SMTP id bs16-20020a056000071000b002424e2651bcmr1608232wrb.69.1670507600927;
        Thu, 08 Dec 2022 05:53:20 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:a7ee:97c9:e05c:9537? ([2a02:578:8593:1200:a7ee:97c9:e05c:9537])
        by smtp.gmail.com with ESMTPSA id j8-20020a5d4488000000b0024287d9d4a8sm3393249wrq.74.2022.12.08.05.53.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 05:53:20 -0800 (PST)
Message-ID: <b4ef6ea7-4eaa-05ef-9447-43763e1c0aea@tessares.net>
Date: Thu, 8 Dec 2022 14:53:19 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH mptcp-next v8 2/4] mptcp: add statistics for mptcp socket
 in use
Content-Language: en-GB
To: menglong8.dong@gmail.com, pabeni@redhat.com,
 mathew.j.martineau@linux.intel.com
Cc: mptcp@lists.linux.dev, Menglong Dong <imagedong@tencent.com>
References: <20221208024543.113633-1-imagedong@tencent.com>
 <20221208024543.113633-3-imagedong@tencent.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20221208024543.113633-3-imagedong@tencent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Menglong Dong,

On 08/12/2022 03:45, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <imagedong@tencent.com>
> 
> Do the statistics of mptcp socket in use with sock_prot_inuse_add().
> Therefore, we can get the count of used mptcp socket from
> /proc/net/protocols:
> 
> & cat /proc/net/protocols
> protocol  size sockets  memory press maxhdr  slab module     cl co di ac io in de sh ss gs se re sp bi br ha uh gp em
> MPTCPv6   2048      0       0   no       0   yes  kernel      y  n  y  y  y  y  y  y  y  y  y  y  n  n  n  y  y  y  n
> MPTCP     1896      1       0   no       0   yes  kernel      y  n  y  y  y  y  y  y  y  y  y  y  n  n  n  y  y  y  n
> 
> Signed-off-by: Menglong Dong <imagedong@tencent.com>
> ---
> v8:
> - remove the MPTCP_INUSE flag and do the statistics according to the
>   creation and destruction of the token

Thank you for the new version!

I marked this series as "Changes Requested" on Patchwork because I guess
you saw the CI was not happy with the KUnit token tests, e.g.:

- KVM Validation: normal (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): insmod - Critical: 3 Call Trace(s) ❌:
  - Task: https://cirrus-ci.com/task/5270512411082752
  - Summary:
https://api.cirrus-ci.com/v1/artifact/task/5270512411082752/summary/summary.txt
  - Debug: https://cirrus-ci.com/task/4989037434372096

Do you mind looking at that please?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
