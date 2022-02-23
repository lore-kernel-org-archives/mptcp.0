Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F136AC8
	for <mptcp@lists.linux.dev>; Wed, 23 Feb 2022 21:01:30 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id p9so17418ejd.6
        for <mptcp@lists.linux.dev>; Wed, 23 Feb 2022 13:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=PXq7mvGkGGkPUkI4BV3e4s+9YWCUsd0G1tHjSYW7Sw4=;
        b=4N8ZUTtUEMp3KI5CR93MD3bHQactaMYz6hrcw2lDepWzraZgYD7Dz7ZWMiwQMHYdC+
         jZ6q8TRuXo86d3w79sMC6L+fRYeWn+QfNf7GF3DXCv+5hyH48f17JNIMBgcFhzqeUhk2
         VeqQKvzmsEnEcuTqSQNeO2tioGpr4U3bSHmygMDR8Vi3vvK+EE3Dw2wWnhvyDhUgs5a1
         VpJcDYJUS2AORToRR4YWNZaWW2SKVaMuKrsKujGnmE8X++9E6BEEb87OOzciBcm7UOra
         hNlA8f9Y7FQPTN5ndLltjRFsWSC2elm/wsxaKgcU5S8N+0vhYnrOxtp9NoSwfCXscJd4
         LFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PXq7mvGkGGkPUkI4BV3e4s+9YWCUsd0G1tHjSYW7Sw4=;
        b=Tpl5g7RIi801f2QbuO5OjLx8HlzixAz5iFkui1mgTBWi+PT+uOJLMRs3FI/0KGmzIA
         m6aShnxF4FvvcDbwoo3RZbfLqvArh9sNGLLal9uOoxcpMOv+jH1lHWhfiitihw+TM7Xw
         H5atziMr3+0Vs7kAHySgyr+mdnTKx0NmFSkY7+l/NvAdDJGIimB3OrhuDP+zvEpkbUQW
         ojWygYb3zYkB7uDXOTllmh206GzMkE7Jl7rTeF9ZurDgs5KtLrBp1T1RDeSv1zfLKJ95
         nV64gIT6EoWEkSuU3p3+zM2rjF3UP5vMubfzwhlz0PqAx3Kl36caVVs8eyiz8Wzokn2B
         A4MA==
X-Gm-Message-State: AOAM533IBa2zoVW98cMrkQF4Hv05k0It9j3N8YsCG0w9dA/GoE5gXT2k
	XL6pvZ74opeyfDMeYQTkPaA9dA==
X-Google-Smtp-Source: ABdhPJx2HZ7f1vSyW6wllEkgPS/Yz9LuePgJyLEtIBPItidLmq4ADz2zf8EHaJu/1XdISyLx+7zIlA==
X-Received: by 2002:a17:906:6693:b0:6cf:3cb:89c9 with SMTP id z19-20020a170906669300b006cf03cb89c9mr1169388ejo.23.1645650089069;
        Wed, 23 Feb 2022 13:01:29 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:1d50:f5b0:90f5:6f43? ([2a02:578:8593:1200:1d50:f5b0:90f5:6f43])
        by smtp.gmail.com with ESMTPSA id vs2sm300367ejb.64.2022.02.23.13.01.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 13:01:28 -0800 (PST)
Message-ID: <95c31835-f6e9-ff75-0f9b-2edb78d8e455@tessares.net>
Date: Wed, 23 Feb 2022 22:01:27 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH RESEND mptcp-next v2 00/12] fclose and mp_fail testcases
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1645325178.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1645325178.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 20/02/2022 03:59, Geliang Tang wrote:
> v2:
>  - keep the order of the applied patches. Drop the revert patches in v1.
> 
> v1:
> Resend all my queued patches in the patchwork. The sequence of 4 applied
> patches is adjusted and rebased. No code modified.
> 
> Geliang Tang (12):
>   mptcp: add the mibs for MP_FASTCLOSE
>   selftests: mptcp: add the MP_FASTCLOSE mibs check
>   mptcp: add the mibs for MP_RST
>   selftests: mptcp: add the MP_RST mibs check
>   selftests: mptcp: add extra_args in do_transfer
>   selftests: mptcp: reuse linkfail to make given size files
>   selftests: mptcp: add fastclose testcase
>   Squash to "mptcp: infinite mapping receiving"
>   Squash to "selftests: mptcp: add infinite map mibs check"
>   selftests: mptcp: add more arguments for chk_join_nr
>   selftests: mptcp: add the MP_FAIL testcases
>   selftests: mptcp: update output info of chk_rm_nr

Thank you for this patches and the reviews!

Now applied in our tree (feat. for net-next):

* Before the "infinite mapping support" series:

- ca9cbbff446b: mptcp: add the mibs for MP_FASTCLOSE
- e9d3d6700269: selftests: mptcp: add the MP_FASTCLOSE mibs check
- 7b6ed57c70dc: mptcp: add the mibs for MP_RST
- b1dd7c48a10f: selftests: mptcp: add the MP_RST mibs check
- 481e87d3e23b: selftests: mptcp: add extra_args in do_transfer
- 6609f1c808dd: selftests: mptcp: reuse linkfail to make given size files
- 28ac700c6369: selftests: mptcp: add fastclose testcase
- bd4f93690fa6: conflict in t/selftests-mptcp-add-infinite-map-mibs-check
- 4e668db2d842: conflict in
t/selftests-mptcp-Add-tests-for-userspace-PM-type
- 519eb3313dc7: conflict in
t/selftests-mptcp-adjust-output-alignment-for-more-tests
- 5b26053898fa: conflict in
t/selftests-mptcp-add-implicit-endpoint-test-case
- Results: d7649a6f4e25..dd86303a6117

* In the "infinite mapping support" series:

- a901b62afb52: "squashed" patch 08/12 in "mptcp: infinite mapping
receiving"
- ed1ec3a2223c: "squashed" (with conflicts) patch 09/12 in "selftests:
mptcp: add infinite map mibs check"
- Results: dd86303a6117..2198a66cca7d

* After the "infinite mapping support" series:

- 0954244ea41e: selftests: mptcp: add more arguments for chk_join_nr
- 0c0217635548: selftests: mptcp: add the MP_FAIL testcases
- f2b1c0bab9a7: selftests: mptcp: update output info of chk_rm_nr
- 66fe2565137c: conflict in
t/selftests-mptcp-Add-tests-for-userspace-PM-type
- 725730b4cb61: conflict in t/mptcp-more-careful-RM_ADDR-generation
- ea63fb2b5f25: conflict in
t/selftests-mptcp-add-implicit-endpoint-test-case
- Results: 2198a66cca7d..5d3058e05cc9

* Extra fix:

- 649d88fdc3c5: tg: fix wrong conflict resolution
- 4ec880a22963: conflict in
t/selftests-mptcp-add-more-arguments-for-chk_join_nr
- Results: 5d3058e05cc9..067a741aa5fb

Hopefully everything has been applied as expected! Do not hesitate to
double-check!


Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220223T205717
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export


Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
