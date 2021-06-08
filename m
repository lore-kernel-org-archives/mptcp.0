Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31C62FAD
	for <mptcp@lists.linux.dev>; Tue,  8 Jun 2021 10:06:22 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id k7so31619230ejv.12
        for <mptcp@lists.linux.dev>; Tue, 08 Jun 2021 03:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IMmrSTQG4FkZFEdWuCH7tZk5wDpwQ16zLXzk+wEfS3c=;
        b=R5hSdG6Hln485ib83z8D3eyBGqp0tvBt7qGS5k6TdRC9SvRKMCQm0iSQIWgHCmPsQU
         BuRSICk9NmDidr1HyUqtqaMQHbF42eo+Fpx174ILe51bEun1Pi8aTm0kMdCuOOU2R60p
         1QFMa0oW4D+ZQWf/wbtoMn6gFE0Iy4+ixDVLzIsTiKAJex05+EI73Udye6NdvrfUZ77x
         pxOvmcuX2kvWqOk1Jo8LkeZEesLByWoVExYQoNKe/ZlG4/k//cllyp9r9G+Y9Ttmluzf
         qhtc35W2wFnEpFOVnEUNcQcVyB9iAE6FWzeTqdfn64ThLKkPqg3E03o18iQWCw42ESZ1
         cLPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IMmrSTQG4FkZFEdWuCH7tZk5wDpwQ16zLXzk+wEfS3c=;
        b=C69NO8wa7wxVynCMlZILPxOQsjUcV520YGUdVHWUKLGRTQrWquhPWZWLoniSTIWHbo
         W0tXAGU7KGEI2cZYOEyO4L1VAeWhehkmfbB94UHEQOhLLPS0jMr7a01m5Yv+HGn8S5VN
         WSZj9GldDGIxyKtShECXli41CBSWwEQi2LOPHRYoL8H2kvhkVwlk4L+ylOr4dkWrG431
         afxKDz7K3oLJDiM5B4Vk+CE0L/4eKWgwMZ1mPdzIlqg8h5v76tNdelADRqKwg6HtUHXA
         yYyeYIgv84uiNuOqEZNm7pwtz9Gdf0HY/sFTlysV2KCk+OI2IDfqGHCtP/T4q/nCJLZZ
         dRSQ==
X-Gm-Message-State: AOAM532yZwp76UmSVKfg9CLGwVgekqEoaxSeB+aavBQuvbyVyxbxCvju
	kY2KTueb5GHCzlKNwYS++pZdx2NuUpNOEnJS7xU=
X-Google-Smtp-Source: ABdhPJyrFCep8wchjiN0foQ4EEKxybyXfXrL4H9BPiEMNWaf33hXfUryZPo2y3Od8oi+7FhFgFdk6g==
X-Received: by 2002:a17:906:5f93:: with SMTP id a19mr22500360eju.18.1623146780771;
        Tue, 08 Jun 2021 03:06:20 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:fc48:eb4c:7e84:e1ff])
        by smtp.gmail.com with ESMTPSA id oz11sm7611000ejb.16.2021.06.08.03.06.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 03:06:20 -0700 (PDT)
Subject: Re: [PATCH mptcp-next] selftests: mptcp: display proper reason to
 abort tests
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <20210605085155.3548173-1-matthieu.baerts@tessares.net>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <cb2076f8-b684-c886-153e-8eb634a9c707@tessares.net>
Date: Tue, 8 Jun 2021 12:06:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20210605085155.3548173-1-matthieu.baerts@tessares.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Mat,

On 05/06/2021 10:51, Matthieu Baerts wrote:
> Without this modification, we were often displaying this error messages:
> 
>   FAIL: Could not even run loopback test
> 
> But $ret could have been set to a non 0 value in many different cases:
> 
> - net.mptcp.enabled=0 is not working as expected
> - setsockopt(..., TCP_ULP, "mptcp", ...) is allowed
> - ping between each netns are failing
> - tests between ns1 as a receiver and ns>1 are failing
> - other tests not involving ns1 as a receiver are failing
> 
> So not only for the loopback test.
> 
> Now a clearer message, including the time it took to run all tests, is
> displayed.
> 
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Thank you for the review and the test!

Now in our tree:

- ded8c6cd0995: selftests: mptcp: display proper reason to abort tests
- Results: 6c03f55acd58..019a9a3a705d

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210608T100603
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210608T100603

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
