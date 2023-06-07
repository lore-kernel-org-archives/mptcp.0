Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD77034D89
	for <mptcp@lists.linux.dev>; Wed,  7 Jun 2023 09:47:17 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5149c76f4dbso1151954a12.1
        for <mptcp@lists.linux.dev>; Wed, 07 Jun 2023 02:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686131235; x=1688723235;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JoFe8DKh0PL5eXoti4QWqd5GdtRhbNxJQ/cX+ftuscs=;
        b=5E84bJo2YhXJykSSy96QF9weofPkSOV9ZELMSPekk2AXi1cYEmDtmUKXX1e9zd7DVH
         1yMPfJYTTeQMb1FnEsbaTikzN+Z+G+P9Mh+11pEUFnF99b//uSSub6L966BZg0/Wbez/
         lTEUKXUZqI5ZxGu64wq2oBZR6XStFBmdrOgiS4nFAEA7hSJD6L5e6l0w/+IKdAQU7K/a
         +2zvmmVHQIQgRP23M90JMBl0jT/FTSY52JzOxpKyOftgjCEdVNonaexHhmkPi7vXV2Ir
         HBhpi29M2TUdw8MjMU4qFMYpKva7WF/xQl805HuvwynD8LFoq7RQKfvIXcw/+LUGLC3s
         RTEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686131235; x=1688723235;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JoFe8DKh0PL5eXoti4QWqd5GdtRhbNxJQ/cX+ftuscs=;
        b=Z3BUnoPEhiJHyTYE6j4UeXnIaO4m6nrasm/kguZetCD6v9qWVJJZMtAYyJjJn81mFk
         GU82QDmbkJSbMaxIGyq5elf1rQV/vXclUuvlovXWwPZ7LEWptZKrTbzMXgNKlvUo0JJw
         tW0O0VeeF1b5Uu/4D/FGryVzYe43JhQVoky/utxbTS/fCIl3kqbgQ06v+rk2LL+9ZH0T
         WsU6VYj2hSqHA7NkSD5v1BaU8Kw/XlRpgSBxMaYbQi+Mrwxwnm2Km8wBJS4WZIAKckcc
         DGpH4PeJLR7UrwQ0lbbuY2S+/l5YmsFwnfofw430X/XBPoiBRqKzgRi6DGYqCWWUwlEm
         TIrA==
X-Gm-Message-State: AC+VfDxjLfCpLvZ/V5fMAFi8rTyljE3+YauOllXsFvIfijV3pkx0WuFH
	qMXFq3IZbDs1UoyrsrUIsBAUzhwirSTu6GHcjFKJJQ==
X-Google-Smtp-Source: ACHHUZ6pXIAXmDtoe9gwxWdM6+y2odarfslEZlgoKQdn+cWZQIN5CaMloZmCf0UBlbrGtp0X/wm5Ag==
X-Received: by 2002:a17:907:2d8c:b0:94e:e97b:c65 with SMTP id gt12-20020a1709072d8c00b0094ee97b0c65mr5421153ejc.60.1686131235101;
        Wed, 07 Jun 2023 02:47:15 -0700 (PDT)
Received: from [192.168.43.205] ([109.139.221.102])
        by smtp.gmail.com with ESMTPSA id p10-20020a170906604a00b00977e4c1727esm3238169ejj.29.2023.06.07.02.47.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 02:47:14 -0700 (PDT)
Message-ID: <5cb1b85d-cb37-ab75-154a-61c9fb8afced@tessares.net>
Date: Wed, 7 Jun 2023 11:47:14 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH mptcp-net v3 00/32] selftests: mptcp: skip tests when
 features are not supported
Content-Language: en-GB
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 31/05/2023 16:16, Matthieu Baerts wrote:
> Selftests are supposed to run on any kernels, including the old ones not
> supporting all MPTCP features.
> 
> These different patches allow the different MPTCP selftests to be
> executed on older kernels.
> 
> I tried to minimise the modifications and do the checks from the bash
> script not to have to detect the feature when being used in a .c file,
> then pass the info to the bash script, skip the test, clean the
> environment, etc. As you can see, even with this minimalistic way, a lot
> of modifications have been done to support old kernels.
> 
> Note that if we expect to have all features available,
> SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES env var can be set to 1 to mark
> the tests as failed instead of skipped and track regressions just in
> case one of these checks is wrong. The public CI already set this env
> var to 1.
> 
> This is a big series impacting new development. Probably best to apply
> it "quickly" in our tree and fix issues later to avoid multiple rebases.
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/368
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
> Changes in v3:
> - Patches 1-7 have been already applied
> - check kernel version: new env var that can be set to skip the versions
>   check so it works if a new feature is backported to an older kernel.
> - get_counter() to get the MIB counters: I can help the stable team with
>   the backports that will not be difficult I think but will cause
>   conflicts
> - check nf/tc issues: looks safer just in case a kconfig is missing or
>   an issue with nf/tc but can be removed if you prefer (still I don't
>   think we should exit in the middle of a test so I kept it for the
>   moment)
> - one check per block of tests around the same theme: it would indeed
>   avoid re-doing the same check 2 or 3 times but it would break the IDs
>   (+maybe less obvious a test might be skipped when reviewing code)
> - backports: at the end, we just need all these new checks to be
>   backported on the last stable kernel (6.3) because that's what is used
>   by the different CIs. It is fine if it is not backported after. (but
>   still I can help with the backports, I'm used to :) )
> - New patches:
>   - selftests: mptcp: join: uniform listener tests
>   - Squash to "selftests: mptcp: add MPTCP_FULL_INFO testcase"
> - See the changelog on the individual patches
> - Link to v2: https://lore.kernel.org/r/20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net

As discussed at the last weekly meeting, I just applied this series
(without any extra ACK/RvB for the moment, I can always add some later
if needed). Note that there is a conflict between net and net-next:

- a73cbdf0325c: conflict in top-bases/t/DO-NOT-MERGE-git-markup-net-next

I will make sure we pass the information to netdev maintainers when we
will send these patches to netdev for -net.


Applied in our tree (fix for -net + 1 fix for net-next and a squash-to
patch, see below):

New patches for t/upstream-net and t/upstream:
- c8230ff8c611: selftests: mptcp: lib: skip if missing symbol
- d5b45288feab: selftests: mptcp: lib: skip if not below kernel version
- 13c09048a8a9: selftests: mptcp: connect: skip transp tests if not
supported
- da3fbb1c9d55: selftests: mptcp: connect: skip disconnect tests if not
supported
- 17fd0d99c269: selftests: mptcp: connect: skip TFO tests if not supported
- 56f59ccac581: selftests: mptcp: diag: skip listen tests if not supported
- dc15a4faa5d2: selftests: mptcp: diag: skip inuse tests if not supported
- 0a0aedc21e62: selftests: mptcp: pm nl: remove hardcoded default limits
- a4f952fdfd0d: selftests: mptcp: pm nl: skip fullmesh flag checks if
not supported
- c9e5532bbb9a: selftests: mptcp: sockopt: relax expected returned size
- 119bd6b5574d: selftests: mptcp: sockopt: skip getsockopt checks if not
supported
- 5057b6fd18b4: selftests: mptcp: sockopt: skip TCP_INQ checks if not
supported
- b83b318c8d6a: selftests: mptcp: userspace pm: skip if 'ip' tool is
unavailable
- fae0ec9a5799: selftests: mptcp: userspace pm: skip if not supported
- c8763f8313c2: selftests: mptcp: userspace pm: skip PM listener events
tests if unavailable
- 96914defcb81: selftests: mptcp: join: use 'iptables-legacy' if available
- 67a7d697e202: selftests: mptcp: join: helpers to skip tests
- 8bf1ea244e7a: selftests: mptcp: join: skip check if MIB counter not
supported
- da5bce0ddee8: selftests: mptcp: join: skip test if iptables/tc cmds fail
- 5ce49553bff9: selftests: mptcp: join: support local endpoint being
tracked or not
- caa512715f88: selftests: mptcp: join: skip Fastclose tests if not
supported
- 66a74fd06d9e: selftests: mptcp: join: support RM_ADDR for used
endpoints or not
- de48230c2cc5: selftests: mptcp: join: skip implicit tests if not supported
- f17f007808ad: selftests: mptcp: join: skip backup if set flag on ID
not supported
- 4b6f29b3fdee: selftests: mptcp: join: skip fullmesh flag tests if not
supported
- 14545e86df1e: selftests: mptcp: join: skip userspace PM tests if not
supported
- 4085b667634e: selftests: mptcp: join: skip fail tests if not supported
- 93c1d1a9c615: selftests: mptcp: join: skip MPC backups tests if not
supported
- d42fc1b70fb7: selftests: mptcp: join: skip PM listener tests if not
supported
- 8b438e39bbee: selftests: mptcp: join: uniform listener tests
- 356b01bcdc41: selftests: mptcp: join: skip mixed tests if not supported
- 426c2b289431: "squashed" patch 32/32 in "selftests: mptcp: add
MPTCP_FULL_INFO testcase"
- Results: 551314e25c6e..4865fe6804ff (export-net)
- a17f99898f8a: selftests: mptcp: join: skip check if MIB counter not
supported (part 2)
- Results: 81bf7db050d7..7aa34a6db848 (export)

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20230607T094539
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230607T094151

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
