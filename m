Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAE88F6C
	for <mptcp@lists.linux.dev>; Mon, 28 Nov 2022 17:26:34 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id b8so16357587edf.11
        for <mptcp@lists.linux.dev>; Mon, 28 Nov 2022 09:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C2LCS86qciGuLjwO2ge+sCV8B2FGFMwhRaz24WQJhpk=;
        b=0LoqBI4pBgPOiTvheV4vsguNtm/z2zdQj6wVYyIPW8jaF0SE0v1DnOgUQBATsqd+Ud
         nJhpsd32qEACcEN0gMh+FVbZHhoBo2tc7kK70qEe2uDH/tXuc1R9o17jOAWAVjs8Asnx
         jnWbqajq5dJRd13hpUK9l2tPAmspA/KE5Qi1aRpCIP5gWSP+yMa8I7xXAjrV5mSyU8ls
         oO57lrTAZOBdFovsN5W/z3QepIq1ACn6ihJCfFUV5En0bHzke7Yu9i0e7auUklVakgLc
         S1VlXrwFjIkCYqWbJrAVfPtjtHInIH8l8tOpBoJ79RmHYJj4/b1D9ZbdwD8yrPqF+FYC
         R5jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C2LCS86qciGuLjwO2ge+sCV8B2FGFMwhRaz24WQJhpk=;
        b=gHeN99rOnPfLtHs6lM6SqDkVvikAYwASk6lGQkjV8sEjA9HVB2HPIsM6QksjUyGxTD
         j+u2ygfklw2z8Gb8/PEFy/7+wJcz6pVKjYCu64rx/ipn/vX4KmBcWRZFGwxVKVNSIkZY
         /9osh8mVNCd050pFprV/lgx2gDAqDtiXMs6nqoSZccGyLG492o3uu0ChEIx5G3JEVpcM
         lMxRRdKlOXR8YCJfemMvdmCR8yAwrP+TTxEjrqSPwW305XryFzqGVesTNJtTkfg+RG1b
         02kevw7fvxDtyLJGx9I0A7aQXlN18yQY0E9fuHTyRzf+sCZlj+M/NAYhNqqWabXqChJk
         4J4Q==
X-Gm-Message-State: ANoB5plcgfiZ2/a0mR1tf5zu5/LniFmY2+UJhFh7lnhPWWFebBBjKEwy
	iED6RqPlFA5zpXObWLUVbladDA==
X-Google-Smtp-Source: AA0mqf6cYbzqdbi6fgpY620lo4pyUcNdjdwO7MbfPPtHc3UgHD5MHgaDz3HmjhZ5K4ghwLtuAWy86w==
X-Received: by 2002:aa7:d943:0:b0:469:cdb7:7fe4 with SMTP id l3-20020aa7d943000000b00469cdb77fe4mr33498599eds.261.1669656392456;
        Mon, 28 Nov 2022 09:26:32 -0800 (PST)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id bh16-20020a170906a0d000b007adaca75bd0sm5215922ejb.179.2022.11.28.09.26.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 09:26:32 -0800 (PST)
Message-ID: <c33411f9-73d5-2717-a6e9-9dbde95552c1@tessares.net>
Date: Mon, 28 Nov 2022 18:26:31 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH mptcp-next v3 0/4] cleanups for pm listener event tests
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, Paolo Abeni <pabeni@redhat.com>
References: <cover.1669468340.git.geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1669468340.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Paolo,

On 26/11/2022 14:15, Geliang Tang wrote:
> v3:
>  - fix CI errors in v2.

Thank you for the patches and the reviews!

> v2:
>  - add make evts global patches
> 
> Order of these patches:
>   selftests: mptcp: listener test for in-kernel PM
>   selftests: mptcp: make evts global in mptcp_join
>   selftests: mptcp: listener test for userspace PM
>   selftests: mptcp: make evts global in userspace_pm
>   selftests: mptcp: enhance userspace pm tests
>   mptcp: add pm listener events

Arf, I though the order was from the older to the newest but it was the
opposite. I saw that after having started applying patches :) Hopefully,
I fixed that properly after!

> Geliang Tang (4):
>   selftests: mptcp: make evts global in userspace_pm
>   Squash to "selftests: mptcp: listener test for userspace PM"
>   selftests: mptcp: make evts global in mptcp_join
>   Squash to "selftests: mptcp: listener test for in-kernel PM"

Now in our tree (feat. for net-next) with Paolo's ACK:

New patches for t/upstream:
- ed6d9febb0b2: selftests: mptcp: make evts global in userspace_pm
(applied just before "selftests: mptcp: listener test for userspace PM")
- Results: 392b1b99f540..79547c1065c6 (export)

- 3070d58445cf: "squashed" patch 5/4 in "selftests: mptcp: make evts
global in userspace_pm"
- b9485b47c19b: tg:msg: update commit message

- 79d06eac81fb: "squashed" patch 2/4 in "selftests: mptcp: listener test
for userspace PM"

- 52bc70ea6192: selftests: mptcp: make evts global in mptcp_join
- Results: 79547c1065c6..bc4d825a7fd3 (export)

- 2f4c24bf60f4: "squashed" patch 4/4 in "selftests: mptcp: listener test
for in-kernel PM"
- Results: bc4d825a7fd3..36f5c1632395 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20221128T172446

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
