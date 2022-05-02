Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8B015A3
	for <mptcp@lists.linux.dev>; Mon,  2 May 2022 20:32:01 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id kq17so29858432ejb.4
        for <mptcp@lists.linux.dev>; Mon, 02 May 2022 13:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=onDg7qBT+kEsafz9H2+unQ9awszPppVtSWMu7faylOg=;
        b=rI5u6Yja1jaVB8l8eDO2qs2zxmkwNCnpx51F79YK/mnDn0dHcgL4CbKfvb+/satsco
         83shnnrPPEqSUV2FXqrSjd39WtPeFXYFvY3bjbGjKRo4eA9AN2tr+q7krU1+kr/T0GFd
         WJu7I8vrFBY8EAnsUh+7nm7TarIvpvw0CiwrHRQ8drhq0SYWigqwyL/WsMMeORUDEZJ+
         WpZSVuNLwrHIwt5JAyOftVBYfAlEk2GH/YKiLhgy5NiQ9MtGM7zDyoIGW8pgfhsiJLUj
         AcmbnxJ+SR9lbJOFo+BsjCMbdFIyE7VPWf/VXdbvGM/mrzpsXPiNdqdLBxfgVZZ7nRR7
         W7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=onDg7qBT+kEsafz9H2+unQ9awszPppVtSWMu7faylOg=;
        b=wz0DGDZM7e6ZpcF3/NjB8Ograc6Ic6ssjy6aPLOmCgCOmfXgPSylM1AQUeZEdwKLcF
         k/dxwJ7+4kE0G8pjfgKDyCH00DnkQaOpuqMyqSP8H1m8U/8LaKFddzuhhLGW6f1cK7BG
         4i0AYocqctRq4iEpiJyAj6RbbbNi1UHqRMY4mxKiiJqxiWmWbPawJL8gy0cYQnL1Pvfb
         W9KMA6LgeXFsC+P9Y5rjXhFFt5cEI2NStZx5DI1R1W+sv3hqhVH7oO3Q1hzl94ZtPaBz
         lTXntse1DO6ajioou5C3SNN8ZK/0R+BRp6WwVBDWS93ToIt6e5loZk95Hc5EO2Fkv1sH
         M/HA==
X-Gm-Message-State: AOAM532wwceG17OB8CS2gW8y0BVBObZy66DH6mTazeOAmlDh4ebz7aUq
	Dy8jHUusAZY8Ty/CadyhLVqZWHswMX9p95vN
X-Google-Smtp-Source: ABdhPJwShK3+jinlxkDEorXJGrd6fLp/P2dTFTNZjp8PWd0lWuU9VTdcVq1/3ejQAwQhJFrNiI3wEA==
X-Received: by 2002:a17:907:1c01:b0:6f4:2692:e23 with SMTP id nc1-20020a1709071c0100b006f426920e23mr10331541ejc.243.1651523519545;
        Mon, 02 May 2022 13:31:59 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:8b1c:91db:8679:8c21? ([2a02:578:8593:1200:8b1c:91db:8679:8c21])
        by smtp.gmail.com with ESMTPSA id er9-20020a170907738900b006f3ef214e6asm3899666ejc.208.2022.05.02.13.31.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 13:31:59 -0700 (PDT)
Message-ID: <3ecc1956-d35f-b53b-43c5-316ddb54bbab@tessares.net>
Date: Mon, 2 May 2022 22:31:58 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH mptcp-net v2] net/sched: act_pedit: really ensure the skb
 is writable
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <26445210b10b18b39129c4ede9d7fde0e37fe21f.1651253087.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <26445210b10b18b39129c4ede9d7fde0e37fe21f.1651253087.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat, Geliang,

On 29/04/2022 19:29, Paolo Abeni wrote:
> Currently pedit tries to ensure that the accessed skb offset
> is writeble via skb_unclone(). The action potentially allows
> touching any skb bytes, so it may end-up modifying shared data.
> 
> The above causes some sporadic MPTCP self-test failures.
> 
> Address the issue keeping track of a rough over-estimate highest skb
> offset accessed by the action and ensure such offset is really
> writable.
> 
> Note that this may cause performance regressions in some scenario,
> but hopefully pedit is not critical path.

Thank you for the patch, review and tests!

Now in our tree (fixes for -net) with Mat's ACK and Geliang's Test tags:

New patches for t/upstream:
- b841c3f765af: net/sched: act_pedit: really ensure the skb is writable
- Results: 2767792d035c..8ae619c5e009 (export)

New patches for t/upstream-net:
- b841c3f765af: net/sched: act_pedit: really ensure the skb is writable
- Results: eefc441cb5ab..8b01b4ca3343 (export-net)

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220502T202900
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20220502T202900
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export-net

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
