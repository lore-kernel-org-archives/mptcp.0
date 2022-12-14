Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551E7193
	for <mptcp@lists.linux.dev>; Wed, 14 Dec 2022 17:34:12 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id h7so489509wrs.6
        for <mptcp@lists.linux.dev>; Wed, 14 Dec 2022 09:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q2i5iaUMVATwi4rzrOWHYtr4lVvdx3J7myn7DkztagQ=;
        b=PWlnLYfrHsaMRs9SuHMUBPLXrD/5dt7gXgCbTW2u9Ucz9yisDb+/BFnVXPhCzc73IG
         g2SkCfW/FofntVhnTzPC/U1IGK8LbXKDyT7cxf6S38txJkAol868mw8Au8dGPjXK/gDW
         bJWIczjTgEP+CA3wJ6V0qZws0xtueHG8VeC3p2p8V5UajdhUn37ttmAI0Mw0jJ+KQPXJ
         GL2ePwL8Yi6Uaxp5WuRss3jiSpK5NX9jzyPfGU1I99Y18qvU8YdA+Rv+levywH7Wh9+/
         +e4vsd9CX7dV0zuNWSvZsPLzuFGqaEBU+cTvE01Y+WhfJ6dM5Hr0cvGx3cZHoJmNHmVj
         2/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q2i5iaUMVATwi4rzrOWHYtr4lVvdx3J7myn7DkztagQ=;
        b=MgnULYa13wZ9OhS2ny0uUM2vqvwCqlsacVeYomryI6bZfij5eFGtVuhEuXUD5IyjM7
         ezFDLk1Em/khtBZdPkFMtKOHTCX1wHetkv+uMPESm3wJsM27DVg5k1REowXUSc0oJGko
         uK3zc9pE5QBibQizIBf4y3+ZDHwD+CbxN+gvy/0to+gUfbciRCpwuxLbIeliOXmRN1oA
         oK6IbvZg1v10+nib+bbyr4AlZ7wYg9GkhSNdnXaXuaXzwX54PJZ2GB5jM1WADEqdGPjc
         hG8AnPvMzrxtlOfuWiJaEQYggbcsYLGI3NawacXCQ0EBvE0Ru6hRVr8bMT5ld3EFHzIy
         6/wg==
X-Gm-Message-State: ANoB5plt3VK6zNVBBEWULlmMmx7u1DNOQQPjxUmQml1aBndg1GIIFYxf
	rWnbQKO11nhcB6q1DK9sP9Hmz+sEfZCFE9MQ
X-Google-Smtp-Source: AA0mqf6WCDWoWp2yOqbgZjdpok8gPyD7q43+VihJgzRLu3jHqVhLlSYFNchIwKEbU50ArwXhsXnYiA==
X-Received: by 2002:adf:cc85:0:b0:242:713c:7f65 with SMTP id p5-20020adfcc85000000b00242713c7f65mr16661128wrj.55.1671039251179;
        Wed, 14 Dec 2022 09:34:11 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:22af:65bc:a1dd:1562? ([2a02:578:8593:1200:22af:65bc:a1dd:1562])
        by smtp.gmail.com with ESMTPSA id j23-20020adfa557000000b00241ce5d605dsm3792835wrb.110.2022.12.14.09.34.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 09:34:10 -0800 (PST)
Message-ID: <32db3603-0161-ef4a-21e6-ba439a12202b@tessares.net>
Date: Wed, 14 Dec 2022 18:34:10 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH mptcp-next v19 0/9] BPF redundant scheduler, part 1
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
References: <cover.1668151131.git.geliang.tang@suse.com>
 <ae42a5ff-8d1b-e4ce-6702-eb3b3045cfec@tessares.net>
 <20221209031852.GA26930@localhost.localdomain>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20221209031852.GA26930@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 09/12/2022 04:18, Geliang Tang wrote:
> On Fri, Nov 18, 2022 at 03:52:38PM +0100, Matthieu Baerts wrote:
>> Hi Geliang, Mat,
>>
>> On 11/11/2022 08:47, Geliang Tang wrote:
>>> v19:
>>>  - update patch 1.
>>>  - split "BPF redundant scheduler" into two parts.
>>>  - rebased on "export/20221111T055536".
>>>
>>> Geliang Tang (9):
>>>   mptcp: refactor push_pending logic
>>>   mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
>>>   mptcp: add sched_data_set_contexts helper
>>>   Squash to "mptcp: add struct mptcp_sched_ops"
>>>   Squash to "bpf: Add bpf_mptcp_sched_ops"
>>>   Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
> 
> Hi Matt,
> 
> The commit logs in these three patches become mismatched since the squashed
> code, please update them for me:

Good catch!

Sure, just did:

New patches for t/upstream:
- 8685053d6d06: tg:msg: update as requested by Geliang
- b81ee295d042: tg:msg: update as requested by Geliang
- e399a35fdc24: tg:msg: update as requested by Geliang
- Results: 6d7665253eef..8ef79d8e4dfb (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20221214T173325

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
