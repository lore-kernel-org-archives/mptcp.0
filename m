Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD67870
	for <mptcp@lists.linux.dev>; Tue,  3 Aug 2021 16:00:02 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id oz16so37079174ejc.7
        for <mptcp@lists.linux.dev>; Tue, 03 Aug 2021 09:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CR6LA684gUu2VeIDXTYHtXni0lURU5l9XZCnKW4i7HQ=;
        b=Bg0twJX+76ZA1qQfTnoue8D4WAtoDspHSuzW6SSzIP35FqoyWAAVVmW9jyUWtGdRCK
         RbxgjQBicAaepYIqr7tLv8CfU0M0vXUaAuYQFn/YIMull/XhFbOE87O7GA4qNzgNtJzP
         U3K8DBngO5rDqlQVvdo0WC2Th8t5NRoJu+bfJubietsOmyWxZy4S8th5k946HOWPTSFi
         BinJJ48YONeT1sXoszLNVwItoXrbyokmBrHaYRK5tv+Km16tD+d+k60IdocO6zqOnWDU
         jnIBF3+j/ANbywsXlCGHZpL17NFpzwF922NFVypqLr8xTdw14NbuYvRu4DzBwXiQRLRp
         LE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CR6LA684gUu2VeIDXTYHtXni0lURU5l9XZCnKW4i7HQ=;
        b=PrTCKEL1xD8c08YejKs5YzTK9T9s+K63EwpIyWqYUZXkvIzLKBoWtQn0V3nVVGmRyG
         XbEJRNx3RQOYL70SJEMYQ/Fb0WLQ6N+vYb4W80FR9BbeRRF3GnJ+RIvazWXmom1+PIRB
         Do3WUNcYdEUxRWr4qiBUmqeFBbx1fblSakxxtgLU2aJp3b8EuHaOHsFTyoVQlTj2Q/fi
         awNSmdXP3vmj/jG+fHa/oXPM8LROkJ/DqgdpxHlfSa9Pfg/6vbbi5tvUJC6jHia2XeyY
         A80oHA46D232yUGRzeeCWtXpfdxEyLSIWkp72YBeG2XUJ5PFS/kp0NNtwJBowHiRy5EW
         lj1w==
X-Gm-Message-State: AOAM532Zha/37l3uRF8fVjIy88loe+1OF2WxHXdf2LUGCbxBPO3bAZrj
	+aleQxW1pB0eXsvid/RfUnmkuw==
X-Google-Smtp-Source: ABdhPJwR/vRl14QWHpNw+rt2UiUUBpfyzvlLzuA3pcGz4IFU8kgIF1yQLjaC223+1ksqtzU6fypcJA==
X-Received: by 2002:a17:906:d153:: with SMTP id br19mr21701382ejb.166.1628006400798;
        Tue, 03 Aug 2021 09:00:00 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:9b3:12ee:6aeb:6555])
        by smtp.gmail.com with ESMTPSA id u2sm8344695edd.82.2021.08.03.09.00.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Aug 2021 09:00:00 -0700 (PDT)
Subject: Re: [MPTCP][PATCH v7 mptcp-next 0/6] fullmesh path manager support
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@xiaomi.com>
References: <cover.1627543032.git.geliangtang@xiaomi.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <95794bb7-eeeb-273e-7e38-b552cbbb8e58@tessares.net>
Date: Tue, 3 Aug 2021 17:59:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1627543032.git.geliangtang@xiaomi.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat, Paolo,

On 29/07/2021 09:20, Geliang Tang wrote:
> From: Geliang Tang <geliangtang@xiaomi.com>
> 
> v7:
>  - add a new patch to drop flags and ifindex arguments of
>    __mptcp_subflow_connect().
>  - add more comments for the testcase.

(...)

> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/193
> 
> Geliang Tang (6):
>   mptcp: drop flags and ifindex arguments
>   mptcp: remote addresses fullmesh
>   mptcp: local addresses fullmesh
>   selftests: mptcp: set and print the fullmesh flag
>   selftests: mptcp: add fullmesh testcases
>   selftests: mptcp: delete uncontinuous removing ids

Thank you for the patches and the reviews!

Now in our tree with Mat's RvB tag:

- 8235745392a1: mptcp: drop flags and ifindex arguments
- 31e4fdaf9c0b: mptcp: remote addresses fullmesh
- 6ad65bd12896: mptcp: local addresses fullmesh
- 3faae7f56182: selftests: mptcp: set and print the fullmesh flag
- ee6f6d4a5b48: selftests: mptcp: add fullmesh testcases
- 68e72848611e: selftests: mptcp: delete uncontinuous removing ids
- Results: d5c73e4f859d..dcbca66e0658

And the squash-to patch:

- 22876224b527: "squashed" in "mptcp: drop flags and ifindex arguments"
- Results: dcbca66e0658..b1d5eb590503

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210803T155939
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210803T155939

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
