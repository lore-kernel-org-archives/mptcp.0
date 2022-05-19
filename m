Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140437E
	for <mptcp@lists.linux.dev>; Thu, 19 May 2022 14:12:17 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id i27so10204095ejd.9
        for <mptcp@lists.linux.dev>; Thu, 19 May 2022 07:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=p6fNzP4yQRrlHL62qFX5OCcKyB/XuN8DHnsMnnt0I9Q=;
        b=rhOi/rqTFLOh16fMt01QnhpIAJ7batuAAMLFgewecAwvRrK+nBIB8M7HBoSUHypqQY
         wjSN9RDArMxKm1hEtjI6coFYwf1ldCkhbpLtj3kx/IGkajEplUgyp/o1D9AeC3SVWq5L
         K5NvQOHE5eteQec1mjK9wIqdOADSPJrlBA9zAXqU9AoYALZV4b7IkW8yUsbSwtvo/9rM
         UFc5osqIMQjqAv7Xn7Fky8rOxItEFnkbwVVujJd+wcWRWB1o1hkMcgGGk1jbDnP8wjtg
         Fk0qx6h9QwYERVtXPNDWX+pPCCTfCTEscuQ5WuPnKrbuzMX7QZRG7VE1cb0OatU33ppR
         velg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=p6fNzP4yQRrlHL62qFX5OCcKyB/XuN8DHnsMnnt0I9Q=;
        b=4LhZ6iJfNlmy2uISz1AZRWA6glWbzrBCosRtPvNBvsOzYeUGCu6zm5G3bBaOJtIPmH
         2DzYIypqqQzdlJsb36PpX2Ev26JsLLaWeh4dB7jZ/3QD9m8RaF2RyPOW6uBFRFWvMCR3
         4jmWImCQoLMNKvKHGwg3mPL0suTtsw9gaKiFC1beQWwd5ADcVTsBqj1nx4ekGe1n/5jl
         AuIVU7jhyrqkYwqGRbhGrTxxBBaNF8CMEHD/cG2zn1kiRh+bop7WR4jHkx4YW9vRJjIs
         MifOxDEvZQszDe78/j+ZEvmFRwBAf+ZOQwVykQy7R2qIhoNtaiFJii4xRl1CjBjvMc/C
         IIlg==
X-Gm-Message-State: AOAM533HE+sVHibjG3bUiW55CXatFbVIXbCh+7ZON5rwpccb3urSu65c
	C/AovYgC1v1aR9SWTMRs/ojxwA==
X-Google-Smtp-Source: ABdhPJw0zYVwkSgrM6aBK6/NNXWP486XmUjH5vz96odftpZlAXPu1ZX/6gfxAhEL3K11M0hK5IY7hg==
X-Received: by 2002:a17:907:972a:b0:6f4:f456:50a7 with SMTP id jg42-20020a170907972a00b006f4f45650a7mr4381010ejc.431.1652969536012;
        Thu, 19 May 2022 07:12:16 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:dd49:d598:4fbc:6d53? ([2a02:578:8593:1200:dd49:d598:4fbc:6d53])
        by smtp.gmail.com with ESMTPSA id ca7-20020aa7cd67000000b0042617ba63absm2819421edb.53.2022.05.19.07.12.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 07:12:15 -0700 (PDT)
Message-ID: <025be707-a620-8e83-3aca-d962c5ff7ff4@tessares.net>
Date: Thu, 19 May 2022 16:12:14 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH mptcp-next v2 0/7] for bpf-next
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1652948238.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1652948238.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 19/05/2022 10:25, Geliang Tang wrote:
> v2:
>  - The series is for bpf-next v5.
>  - patch 1, keep bpf_mptcp_sock_from_subflow() in bpf.c
>  - patch 3, Drop the 'msg' parameter of verify_sk
>  - base-commit: df896c77f02a ("DO-NOT-MERGE: git markup: features
> net-next-next"), export/20220517T155019
>  - The last squash-to patch is for "BPF packet scheduler" series.

I just imported this new series in our tree.

- 7046a98c4501: "squashed" patch 1/7 in "bpf: add
bpf_skc_to_mptcp_sock_proto"
- dc043d25d647: "squashed" patch 2/7 in "selftests/bpf: Enable
CONFIG_IKCONFIG_PROC in config"
- bd3e6e2ffc15: "squashed" patch 3/7 in "selftests/bpf: add MPTCP test base"
- efa55efc427c: "squashed" patch 4/7 in "selftests/bpf: test
bpf_skc_to_mptcp_sock"
- f087e13912ad: "squashed" patch 5/7 in "selftests/bpf: verify token of
struct mptcp_sock"
- 21c0f634b797: "squashed" patch 6/7 in "selftests/bpf: verify ca_name
of struct mptcp_sock"
- d38ab51eb84e: "squashed" patch 7/7 in "selftests/bpf: verify first of
struct mptcp_sock"
- c79872213ec4: conflict in t/selftests-bpf-add-bpf_first-test
- Results: 9ceda99ef71f..5fbf0e7a331f (export)

- 4353cb87928e: "squashed" in "selftests/bpf: add bpf_first test"
- Results: 5fbf0e7a331f..086d4a4a0f34 (export)

Builds and tests are now in progress:



https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220519T141104

https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
