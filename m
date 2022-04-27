Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C24A50
	for <mptcp@lists.linux.dev>; Wed, 27 Apr 2022 16:33:31 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id g23so2562818edy.13
        for <mptcp@lists.linux.dev>; Wed, 27 Apr 2022 09:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=R/M/1GRnghZRDEKCFqNOzr1UxcoTfGcFtEepjgQjUZE=;
        b=6EVB1b+T1jrVe04DMHbdtLoKT+yLk75IHpBeabui9sb0UdkF3eOPjfyankcwcFaTsa
         EsFHDjksOP7+ok0bxXrxHybg/3vC+9beTq21OJaC7buAnIn3QFD+E2X9PLDOviN3cS3l
         /vKVULjm2Y3Yz9WYCAUHwL1DbutjAAO1CQ4z224Q4LS2JLnMx+EgxNEbu+xdyXQuW0P8
         JyAkUG7HsSYwub3p0A85WS9ENRadhB67tFGQjHZ0u2BDBSl43yEfrZ+YZn873ZLM2iXQ
         zBEr2ep/cdaNYIiMKF10cBm3yBDCba97uVmgwFKx2+NJuQh00NqpSwHCFn82iPZwDdCg
         /Klg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=R/M/1GRnghZRDEKCFqNOzr1UxcoTfGcFtEepjgQjUZE=;
        b=1DPUKDAUvfJFeo9aWNpmDDbtlhzuB3v7aGAho7VWK11ls8BMIHZ2O7JUo/a1oqw/rp
         Lj3CLkhVO/vn2lDjHH2sTzp42AzsXoRxDhEelbU97q+KhlH7T40YeoI2qn3efg0oC4Cz
         3I4mWmqX4lYvQFiGn+7E/ppCqv5dJ0UP2B2qjOdRJaLeQMX1sM3utE+Nn1EIKfyLk564
         CHCD1Sdumt/0IvOGsjCpvi7ZsxOtMB8lv2Ho+WHZz176rwwORBcc/dfkpOaOuVlkH5Jh
         z65oo/lGvBVto9zBa9/9H6Qgq76Bg65hq1gOfsfzEJ6rQLK5+QegU/9+vJ/CbUOD+1Xj
         3iPQ==
X-Gm-Message-State: AOAM533gP1FesxW7zrRaRtbN/jszRZ7ROynfx5rCm60EGa7T9pDwcqh9
	OFFALQkN3hJ/FcK0WEs1XUsdBg==
X-Google-Smtp-Source: ABdhPJwzpwFT6atA6HhDxvjVU8liMtbHLY2sfndCSSkKd3rtUCJjOMg0a14A7ZZlvZIhkM/s2HtfJQ==
X-Received: by 2002:a05:6402:2985:b0:425:d51f:ae4 with SMTP id eq5-20020a056402298500b00425d51f0ae4mr23311037edb.379.1651077209978;
        Wed, 27 Apr 2022 09:33:29 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:3b64:994c:90d3:9913? ([2a02:578:8593:1200:3b64:994c:90d3:9913])
        by smtp.gmail.com with ESMTPSA id l2-20020a1709060cc200b006d3d91e88c7sm6977552ejh.214.2022.04.27.09.33.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 09:33:29 -0700 (PDT)
Message-ID: <1ce1811d-7f59-c739-c750-4f46fb0bb9b9@tessares.net>
Date: Wed, 27 Apr 2022 18:33:28 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH mptcp-next] Squash to "selftests: bpf: test
 bpf_skc_to_mptcp_sock"
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <a412b57378176f189e112a36443ac133fa90566c.1650947043.git.geliang.tang@suse.com>
 <50d4d7a13beec75c5172d81c2c6d037fb74efd79.1650947056.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <50d4d7a13beec75c5172d81c2c6d037fb74efd79.1650947056.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 26/04/2022 06:26, Geliang Tang wrote:
> Add CONFIG_MPTCP check.
> 
> When CONFIG_MPTCP is not enabled, we'll get a clearer error message:
> 
> libbpf: extern CONFIG_MPTCP (strong) not resolved
> libbpf: failed to load object './mptcp_sock.o'
> 
> The message before is like this:
> 
> libbpf: prog '_sockops': BPF program load failed: Invalid argument
> libbpf: prog '_sockops': -- BEGIN PROG LOAD LOG --

Thank you for the two patches and reviews!

Now in our tree:

- f456d87ca214: "squashed" in "bpf: add bpf_skc_to_mptcp_sock_proto"
- 8aa57e042f44: "squashed" in "selftests: bpf: test bpf_skc_to_mptcp_sock"
- Results: c2a1191f33d3..440ea2eff5af (export)

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220427T162930
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
