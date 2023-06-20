Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30586101FA
	for <mptcp@lists.linux.dev>; Tue, 20 Jun 2023 11:50:11 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-51a426e4f4bso5475578a12.1
        for <mptcp@lists.linux.dev>; Tue, 20 Jun 2023 04:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687261810; x=1689853810;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4iP7EpzHzfjLyDSEX14ZrblNjd9pWqUlaITNniOSuuw=;
        b=GtZz4WGxMBMYAGLxnAt9eriKpZznFF2hNpE/MEAezWWKM7OmSn9nQWh2hiG8w7WL7c
         f3SLOiGoctwt4JbajpsZ/dAHGZ1u83ReJfENwtj2NOoB7O6vUQ8xTG2poUrujhMB2OeE
         +uiA+DVIFaeQEiH/UmH5xAadmYrtOFk0GpeYxEyfeBPj+9XqbqtX+A3jwYIqGcuOew/i
         Td1lhmgXtduypeiTwD//f8YYDSVnJylSLoc1OuqbGVdGoGqm//qNbU9nTZClMQXD++cp
         VALo8IGWwP4/pIUZ0Fgq+yZjxMwBnKqzgCr/XwKdzG3X+PUl5SLXY8BaFnYEWeAoogMS
         l6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687261810; x=1689853810;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4iP7EpzHzfjLyDSEX14ZrblNjd9pWqUlaITNniOSuuw=;
        b=joMhLBzatVe7mqFdonIF8Numor9cdv9UmnzYZvW5vW6nO1jTwRRnKGm4sXs28PpCO6
         btCVTrG0bN1VVvu+YCQ4IxlcAF/23HKtrGwD3v62WzUdpuGQsI30eHT//M8ElNOARC7w
         OCsXQhI559RE43uvdimjHpgAa5yJG4TttKenEFr+TXI0KgrUH61N8hXpprjeYb+3lItg
         HhwhUh0X94FJoG1v/Ebq+o4x1Nt7v4/8JRSY1ZpLkrhDiJVVtg3hQUVs4/Qqy4nQRuWd
         xr10zTIPjO6tJBXk3TsJGnMczb7VSH2YeWxd6btgYAcMbzO04BrJJXZFuz+pwP6aXKee
         ZuLw==
X-Gm-Message-State: AC+VfDyY+APNid9RQLR0b3nL9WACfNuHyue6HoT4b9Tf56VleG5R7MpG
	+AQ1hfkoJpEtOliiO6lBwlbOpTv1sIDRZLx7NEM=
X-Google-Smtp-Source: ACHHUZ7X930FkI2LuawwDbd6OTPeNCpXfOnG00eQF3YiECtdzytqcKvBZt11EEqR0ziGumChY9gkXQ==
X-Received: by 2002:aa7:dad2:0:b0:51a:597e:c3f2 with SMTP id x18-20020aa7dad2000000b0051a597ec3f2mr4369123eds.5.1687261810049;
        Tue, 20 Jun 2023 04:50:10 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id dy20-20020a05640231f400b0051a3e7d7996sm1037463edb.83.2023.06.20.04.50.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 04:50:09 -0700 (PDT)
Message-ID: <525a9a90-e55b-cef1-cb10-ff8352700a48@tessares.net>
Date: Tue, 20 Jun 2023 13:50:09 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH mptcp-next v20 00/10] update userspace pm mptcp_info
 fields part 2
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1686900596.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1686900596.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 16/06/2023 09:30, Geliang Tang wrote:
> v20:
>  - #1-#8, only update the commit logs with warnings reported by checkpatch.
>  - #10 don't update the tests which needs to be slower than before.

Thank you for the patches!

The first 8 patches have now been applied in our tree (feat. for
net-next) with my RvB tags and the suggested modifications for patch 3/8.

New patches for t/upstream:
- 311a895fb08b: mptcp: pass addr to mptcp_pm_alloc_anno_list
- 892a2add5178: selftests: mptcp: test userspace pm out of transfer
- 34da8c8c875b: selftests: mptcp: check subflow and addr infos
- 0aadb9475af5: selftests: mptcp: set FAILING_LINKS in run_tests
- b3ec9662b408: selftests: mptcp: drop test_linkfail parameter
- 5380de466d42: selftests: mptcp: drop addr_nr_ns1/2 parameters
- fc162dadad12: selftests: mptcp: drop sflags parameter
- 75bfcf686b7e: selftests: mptcp: add pm_nl_set_endpoint helper
- Results: d937892749f1..bd3628a02b79 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230620T114901

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
