Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC2BF9E4
	for <mptcp@lists.linux.dev>; Mon,  3 Jul 2023 16:41:05 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so8240652a12.0
        for <mptcp@lists.linux.dev>; Mon, 03 Jul 2023 09:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1688402464; x=1690994464;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ptBa9cJbcY0rl0UObQZ+ypXPKMypMJTyMZoxgSWMIkY=;
        b=sEUmZ0YkMHIA4a46iPBxEdEeV9GpukmX5ZOCdCu7/c0SfhqVL8CR8bm3x5szR1x+zY
         QSpnH/XjH0I8sDAiljVP0vNsLDQSJJ15rxMPRWnsED8PuTfwbFnS/F4rmqv9ZqAwBeDe
         PBf2I/jDstcx5aevupArLS/jyEpnHitzqMAjUL/yQVKJrvGoSIE3VPjE1aUBdttQLVY6
         NF3zNRDSYRkQOo88GzwVdsiGSR83sDDNcjzlDE50CCCxMnuIUQORRzQRByQveCHPU7go
         WeDjIN+Me5aBdh9wq774oGAMyzA3YnlqwX+B9bVx8OOubP0AIe2IUrKqEa3WGfj/o6Og
         EjWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688402464; x=1690994464;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ptBa9cJbcY0rl0UObQZ+ypXPKMypMJTyMZoxgSWMIkY=;
        b=UiZogEELdSiEWsxCcknF7BMhiV7BxccNUhbEct2e2L7kipji5QJGHnD90geOIqzmcS
         t/okcFJEocHaDrQj0FPH4kXeiUnC2hIV4y/6XcBEn94Fnb4sEuHioMw8TSLbR6RmKeuI
         T3a13LjI9gtLHD/uo35TB9IOd0P74rA5CmYU5QEqXskCGYb75091bDF9D5fyLUKeG65V
         BQyuViSc8cFL3w3cmQeWxdlndLrObauqwbbPomkjH++I3DyfAfni01gPhVAj3KDeya2g
         HJ2lVB0u7XJXOeTkaIMT/88DM/mIWg2xEeKbQFsnkwWZDbGwQpCIMzpaZa2wEs3cG4JC
         jnLA==
X-Gm-Message-State: ABy/qLbTO1aQv5LDtk+CgHndvo4ZTvJWDlE9Tv+NnuMFWHHgpXG66NH/
	8j5IjUCfoZmSTTd7I4LIjy3ira0WiYIVZsReTSQ=
X-Google-Smtp-Source: APBJJlFKgkSBfl+GBfgdf9LjQwebvOva25FISK/ASsWkbv7OUmduTW1eZWt58Y7isf3DuDfLwxteLQ==
X-Received: by 2002:a17:906:18d:b0:991:d883:3df9 with SMTP id 13-20020a170906018d00b00991d8833df9mr12174077ejb.21.1688402463637;
        Mon, 03 Jul 2023 09:41:03 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id w15-20020a170906480f00b00992fafcb82fsm4385265ejq.24.2023.07.03.09.41.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 09:41:03 -0700 (PDT)
Message-ID: <046527a4-4c24-542e-e094-905c1e28e662@tessares.net>
Date: Mon, 3 Jul 2023 18:41:03 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH mptcp-next 00/18] selftests: mptcp: format subtests
 results in TAP
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>
References: <20230621-mptcp-issue-368-selftests-subtests-v1-0-0cae453ae1fa@tessares.net>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20230621-mptcp-issue-368-selftests-subtests-v1-0-0cae453ae1fa@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 21/06/2023 19:18, Matthieu Baerts wrote:
> The current selftests infrastructure formats the results in TAP 13. This
> version doesn't support subtests and only the end result of each
> selftest is taken into account. It means that a single issue in a
> subtest of a selftest containing multiple subtests forces the whole
> selftest to be marked as failed. It also means that subtests results are
> not tracked by CI executing selftests.
> 
> MPTCP selftests run hundreds of various subtests. It is then important
> to track each of them and not one result per selftest.
> 
> It is particularly interesting to do that when validating stable kernels
> with the last version of the test suite: tests might fail because a
> feature is not supported but the test didn't skip that part. In this
> case, if subtests are not tracked, the whole selftest will be marked as
> failed making the other subtests useless because their results are
> ignored.
> 
> Regarding this patch set, the 5 first patches are fixes for -net:
>  - connect: issues with nft were not reported and then ignored by the CI
>  - sockopt: issues with packet marks were also not reported and ignored
>  - userspace_pm: similar fix for "remove" tests + use correct var
> 
> Then some various improvements for net-next:
>  - connect & userspace_pm: continue executing tests if there is an error
>  - userspace_pm: some refactoring to reduce duplicated code and prepare
>    subtests' support.
> 
> And finally we have one commit adding helpers to support subtests
> followed by commits in the different selftests to support this feature.
> 
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
> Matthieu Baerts (18):
>       selftests: mptcp: connect: fail if nft supposed to work
>       selftests: mptcp: sockopt: use 'iptables-legacy' if available
>       selftests: mptcp: sockopt: return error if wrong mark
>       selftests: mptcp: userspace_pm: use correct server port
>       selftests: mptcp: userspace_pm: report errors with 'remove' tests
>       selftests: mptcp: connect: don't stop if error
>       selftests: mptcp: userspace pm: don't stop if error
>       selftests: mptcp: userspace_pm: fix shellcheck warnings
>       selftests: mptcp: userspace_pm: uniform results printing
>       selftests: mptcp: userspace_pm: reduce dup code around printf
>       selftests: mptcp: lib: format subtests results in TAP
>       selftests: mptcp: connect: format subtests results in TAP
>       selftests: mptcp: pm_netlink: format subtests results in TAP
>       selftests: mptcp: join: format subtests results in TAP
>       selftests: mptcp: diag: format subtests results in TAP
>       selftests: mptcp: simult flows: format subtests results in TAP
>       selftests: mptcp: sockopt: format subtests results in TAP
>       selftests: mptcp: userspace_pm: format subtests results in TAP

Thank you for the review!

I just applied these patches in our tree (1-5: fixes for -net ; 6-18:
feat. for net-next) with your Acked-by and without the fix in patch 14/18:

New patches for t/upstream-net and t/upstream:
- bd32644a1704: selftests: mptcp: connect: fail if nft supposed to work
- e514dd195a47: selftests: mptcp: sockopt: use 'iptables-legacy' if
available
- 239d7db18bb5: selftests: mptcp: sockopt: return error if wrong mark
- 38a841f8e2ba: selftests: mptcp: userspace_pm: use correct server port
- ff68420a15db: selftests: mptcp: userspace_pm: report errors with
'remove' tests
- Results: 045d70ca4742..221a200140cf (export-net)

New patches for t/upstream:
- 7ace02ce8ee8: selftests: mptcp: connect: don't stop if error
- a9f0d3c9ed84: selftests: mptcp: userspace pm: don't stop if error
- 03f8da0a8a4c: selftests: mptcp: userspace_pm: fix shellcheck warnings
- 81c83275036e: selftests: mptcp: userspace_pm: uniform results printing
- 7be13e337f8b: selftests: mptcp: userspace_pm: reduce dup code around
printf
- 544e972c95d9: selftests: mptcp: lib: format subtests results in TAP
- 38a281bb1703: selftests: mptcp: connect: format subtests results in TAP
- aed83c0c6b35: selftests: mptcp: pm_netlink: format subtests results in TAP
- a600e75d6df4: selftests: mptcp: join: format subtests results in TAP
- 8d64331739d6: selftests: mptcp: diag: format subtests results in TAP
- b4c131ff9e9a: selftests: mptcp: simult flows: format subtests results
in TAP
- 9f91056e4349: selftests: mptcp: sockopt: format subtests results in TAP
- 4c4a5aa7ab0d: selftests: mptcp: userspace_pm: format subtests results
in TAP
- Results: 922570c97fcb..619c3c3e5a9b (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20230703T163105
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230703T163926

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
