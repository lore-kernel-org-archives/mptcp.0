Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790651865
	for <mptcp@lists.linux.dev>; Mon,  9 May 2022 11:53:56 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id v12so19051422wrv.10
        for <mptcp@lists.linux.dev>; Mon, 09 May 2022 04:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=TvsdTmKIer9xfAKMURdrScAEsigvcyJw/rMbr9eMKP0=;
        b=U2bnpuhcNMVxyw2LyEOavi5LDrRGnepz0GPaocEslA9uagNJUS0eqVl9kRnUN8qMFZ
         ihg57G4jc/mRxcYSvzYpYEm9RMAtl3K5qpV1YbTIa6aAvfSZxjksq3Jm9ZNCwkskIFkn
         /tKBM6ZCjhDnzrA6lI2XRsDOQKoGJjqztPGk8NayLvGihS+iaqvG5qOQJQByMfguCPV4
         hIYZzc+YNE61jrQkGGDwk2P4s/sALgCCaJCr4Qh/3XgjSkNui8MmoZ8Zh6amFMo38M9Z
         mzJ9UE1fGPSYNnUIPu08Pqt3Yvq50oKJMKktAxpc1++EP76TNcfYq7ftYt1CPJJI4pvA
         zyzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TvsdTmKIer9xfAKMURdrScAEsigvcyJw/rMbr9eMKP0=;
        b=e1tPqE28ZsMAz7+l68pedXbTSioyNO20Nr+40dBQnRuWlwTma+RzFnnXqbYM2Y22Y6
         zV0OBJZ1HkPxwYVEWjwri9t/ewHYKfK4TaLLUovc745ImnG2hx4gRVeYMcQy5PD3hw2T
         fTw05hBcK75op4n9D3GI+jV7HEpaH2VvMHi4dhO3QDaVuTKwhJu5P1tUauSz+T77W6PU
         E2kjc5jam2xfbaRTKox8GX8XBU59b5lL2kqD91sd0efmePDANL1jcv6Gk4xmEBQuyBaN
         10BA2Lz2bAcf+dShIPal3lbkbLMdpT3FQeXD5lIYa/c5zag9TxLXUNCE1XvAfp8AgrL9
         5zBw==
X-Gm-Message-State: AOAM531pvXfkt6KE+FUu0wMxJiRhTLtG2ReTXWRuWg7FWyFucni6geQr
	s9xjEHddQmGnE1chWx0QbfLogQ==
X-Google-Smtp-Source: ABdhPJzB14PvSVkhVDrWLZuMx9hwh+4TP+GNxB4g6TIXZj19F7fPLSVVHy/R9YcAKZWGgX81Ltgh3g==
X-Received: by 2002:adf:f7cb:0:b0:20c:9dbd:49be with SMTP id a11-20020adff7cb000000b0020c9dbd49bemr13378311wrq.250.1652097234305;
        Mon, 09 May 2022 04:53:54 -0700 (PDT)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id g6-20020a1c4e06000000b00394708a3d7dsm11264451wmh.15.2022.05.09.04.53.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 04:53:53 -0700 (PDT)
Message-ID: <247ec851-ec60-5b32-43f9-a3562dc0aca4@tessares.net>
Date: Mon, 9 May 2022 13:53:53 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH mptcp-next] Squash to "selftests: bpf: add MPTCP test
 base"
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <83acce83a5bafc3b45c45b56105678210d07ac92.1651904124.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <83acce83a5bafc3b45c45b56105678210d07ac92.1651904124.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 07/05/2022 08:17, Geliang Tang wrote:
> Address to Andrii's comments:
>  - add copyright 2022
>  - use ASSERT_* instead of CHECK_FAIL
>  - drop SEC("version")

Thank you for the patches!

I also replaced a few ASSERT_GT() by ASSERT_GE() and update the commit
messages: prefix + changelog. Please check if I didn't miss anything :)

- f0bf012a62d0: "squashed" in "selftests: bpf: add MPTCP test base"
- bcb1ed91a0e2: use ASSERT_GE instead of _GT: fd == 0 is valid
- d13c2826b435: conflict in t/selftests-bpf-test-bpf_skc_to_mptcp_sock
- Results: 2b6d9d722f05..2b4b3ea4ee81 (export)

- b8c48e454a31: "squashed" in "selftests: bpf: test bpf_skc_to_mptcp_sock"
- c2d9dbcf32da: use ASSERT_GE instead of _GT: fd == 0 is valid
- 909c2e46449c: conflict in
t/selftests-bpf-verify-ca_name-of-struct-mptcp_sock
- Results: 2b4b3ea4ee81..edd1596ddede (export)
- 105fd75cff3a: "squashed" in "selftests: bpf: test bpf_skc_to_mptcp_sock"
- Results: bb750830dfba..21c7846253fc (export)

- d2a584bb2988: "squashed" in "selftests: bpf: verify token of struct
mptcp_sock"
- 023c51695e66: use ASSERT_GE instead of _GT: fd == 0 is valid
- Results: edd1596ddede..44a1ca452f9d (export)

- 18126dc0fe4f: "squashed" in "selftests: bpf: verify ca_name of struct
mptcp_sock"
- 8d3b8669d7a4: use ASSERT_GE instead of _GT: fd == 0 is valid
- Results: 44a1ca452f9d..bb750830dfba (export)

- 67678621ed32: "squashed" in "selftests: bpf: add bpf_first test"
- Results: 21c7846253fc..ae3944c04e7a (export)


- 17c227d200aa: tg:msg: add changelog for "bpf: add
bpf_skc_to_mptcp_sock_proto"

- 94caf3b41f66: tg:msg: add changelog for "selftests: bpf: Enable
CONFIG_IKCONFIG_PROC in config"
- 8da49841ed59: tg:msg: fix prefix for "selftests: bpf: Enable
CONFIG_IKCONFIG_PROC in config"

- 3f14113ff1f6: tg:msg: add changelog for "selftests: bpf: add MPTCP
test base"
- 542fa9c889e0: tg:msg: fix prefix for "selftests: bpf: add MPTCP test base"

- 9f1d3a3094b4: tg:msg: add changelog for "selftests: bpf: test
bpf_skc_to_mptcp_sock"
- e8c7107863e8: tg:msg: fix prefix for "selftests: bpf: test
bpf_skc_to_mptcp_sock"

- b6003fc6580c: tg:msg: add changelog for "selftests: bpf: verify token
of struct mptcp_sock"
- 7195dbb7ee5d: tg:msg: fix prefix for "selftests: bpf: verify token of
struct mptcp_sock"

- 58ce37bdb3ce: tg:msg: add changelog for "selftests: bpf: verify
ca_name of struct mptcp_sock"
- 5431605d68cc: tg:msg: fix prefix for "selftests: bpf: verify ca_name
of struct mptcp_sock"

- 9fc1e8122379: tg:msg: fix prefix for "selftests: bpf: verify first of
struct mptcp_sock"

- c007e06819ef: tg:msg: 'selftests: bpf:' -> 'selftests/bpf:'
- 227c9d78e571: tg:msg: 'selftests: bpf:' -> 'selftests/bpf:'


> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> index cd548bb2828f..760374f1fce4 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c

(...)

>  	prog_fd = bpf_program__fd(prog);
> -	if (CHECK_FAIL(prog_fd < 0)) {
> +	if (!ASSERT_GT(prog_fd, 0, "bpf_program__fd")) {

See my commit bcb1ed91a0e2 and a few others after: the fd can be zero,
we need to use ASSERT_GE().


Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220509T115202
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
