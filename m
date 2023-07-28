Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2D114013
	for <mptcp@lists.linux.dev>; Fri, 28 Jul 2023 16:02:17 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-99b9161b94aso324039666b.1
        for <mptcp@lists.linux.dev>; Fri, 28 Jul 2023 09:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1690560135; x=1691164935;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tmAtfObvSn7R38c4kvxaU42I5guT2C2HsjkEtQrDePA=;
        b=Ci+W0iIMC8PW7ejhKI0sWm9avQNueTty5UYXSUXV22t7Tmw1m12gqyOTQDi/37Ekda
         2SVPYYPqSqvVCqDvLrfBzrZkleFKYM1sCIZZSCkCcYAQA3ZkXI5m8hIDC3Ka2+qkvfxS
         Z+U4NGi2FIr+35ik4SfXsf0Id91J9si63sQ+eo2owADvrhMB03ZTIpp8iVMQAX28LHW1
         i8gn36YNG31a9Uay72o/FtnzVuGXHhUVlZpS3UGMX1XeGUBT5hR2nYl/qnKwIeHxmhXZ
         orEFVkOo2odEBWzTMh/UD2DF/W0iENrwh9bGnu7UnIya3Q2+0gpdFitgFTVAVz6IoPC4
         y/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690560135; x=1691164935;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tmAtfObvSn7R38c4kvxaU42I5guT2C2HsjkEtQrDePA=;
        b=PmQrUsQcEP8dZe3Lr8aREjbJIPqVUPH3JujGk6Js3Bd2omjgU8ksFkmTuYZaBMKP1Y
         gUkmLXtMm5GbzW5TQXqQaI0zNlTDKTZg2tuDgmMhuSHwdPkDSVoAzri1LOwkLAkp07YG
         MMyGbyQJIbg7Nx3kxB3zXUptHNVw9EHoiEPueDUZM244V2vXOE4pLTfvI+7VCMQ/gpdR
         IYMPKaXJYdFBAXLKigjh4Tzh7cwWFsqLVh0ACMfAShCzq1TEBU7IfB5X6N16aGNB3AWj
         eppXqBiU7au9epTeI94YL9E9ABItlV2eqU2cS4Xqv3YSdzgcvPoIZMF4g53krHjSwipW
         Oz0A==
X-Gm-Message-State: ABy/qLbN/FUucRS2ljCSD7A2dbkfruH0KVTvXblOd0ccRhUiFvvixWiv
	ZjTA1TH4uFOLXVguTmuBcU9/59ZmyRLOFfdgiWFdxQ==
X-Google-Smtp-Source: APBJJlElHKaTeDw/ePzepaF/D5s5GG7qTlOd8m7aIETKNoR+ulkLKG9+Cp1G5v7PZYaW40BFKvTvmg==
X-Received: by 2002:a17:906:3f44:b0:99b:ead0:2733 with SMTP id f4-20020a1709063f4400b0099bead02733mr2722399ejj.72.1690560135624;
        Fri, 28 Jul 2023 09:02:15 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id j20-20020a170906051400b00992b8d56f3asm2182370eja.105.2023.07.28.09.02.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 09:02:15 -0700 (PDT)
Message-ID: <f0e3f890-b036-06ef-cb61-ed2dcbf85fe9@tessares.net>
Date: Fri, 28 Jul 2023 18:02:14 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH mptcp-next v2 00/13] BPF packet scheduler updates part 2
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, Mat Martineau <martineau@kernel.org>
References: <cover.1689650435.git.geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1689650435.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 18/07/2023 05:36, Geliang Tang wrote:
> v2:
> - Init nr to -1 for bpf_bkup and bpf_stale.
> - Update has_bytes_sent() to make sure only one item showed in 'ss -it',
>   this needs to start server with PORT_1.
> - Rename to bpf_mptcp_subflow_memory_free() and
>   bpf_mptcp_subflow_queues_empty().
> - Simplify div_u64().
> - Move mptcp_subflow_set_stale() to kernel space. stale is a bit filed,
>   I haven't found a way to set a bit filed in BPF context yet, so set it
>   in kernel space.
> - Sync with new bpf_tcp_ca.c.
> 
> Geliang Tang (13):
>   Squash to "bpf: Add bpf_mptcp_sched_ops"
>   Squash to "selftests/bpf: Add bpf scheduler test"
>   Squash to "selftests/bpf: Add bpf_first test"
>   Squash to "selftests/bpf: Add bpf_bkup scheduler"
>   Squash to "selftests/bpf: Add bpf_bkup test"
>   Squash to "selftests/bpf: Add bpf_rr test"
>   Squash to "selftests/bpf: Add bpf_red test"
>   mptcp: add subflow_set_stale helper
>   selftests/bpf: Add bpf_stale scheduler
>   selftests/bpf: Add bpf_stale test
>   bpf: Export more bpf_burst related functions
>   selftests/bpf: Add bpf_burst scheduler
>   selftests/bpf: Add bpf_burst test

Thank you for the patches and the reviews!

Just applied in our tree (feat. for other trees) with Mat's RvB tag on
patch 11-13:

New patches for t/upstream:
- 53ac64c3872b: "squashed" patch 1/13 in "bpf: Add bpf_mptcp_sched_ops"
- 0ab66f43ec70: "squashed" patch 2/13 in "selftests/bpf: Add bpf
scheduler test"
- 2fc5650638c1: "squashed" patch 3/13 in "selftests/bpf: Add bpf_first test"
- e98afc8e2110: "squashed" patch 4/13 in "selftests/bpf: Add bpf_bkup
scheduler"
- 0a920c696b80: "squashed" patch 5/13 in "selftests/bpf: Add bpf_bkup test"
- ca0924acae70: "squashed" patch 6/13 in "selftests/bpf: Add bpf_rr test"
- 4dfce80db661: "squashed" patch 7/13 in "selftests/bpf: Add bpf_red test"
- Results: b5ba626e6a54..59eafd2d73d8 (export)

- fd91a6aba636: bpf: Export more bpf_burst related functions
- ba9ff2266f7b: selftests/bpf: Add bpf_burst scheduler
- 558ed1c12d57: selftests/bpf: Add bpf_burst test
- Results: 59eafd2d73d8..e77fd85b3873 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230728T160116

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
