Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5C324160
	for <mptcp@lists.linux.dev>; Wed, 12 Jul 2023 15:16:29 +0000 (UTC)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2b6f943383eso115065711fa.2
        for <mptcp@lists.linux.dev>; Wed, 12 Jul 2023 08:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689174987; x=1691766987;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rF5+femrc/9pJY0m/8fZt1OSXF34LxMFVgcZqkZScLY=;
        b=MK+VXiwd169KKAeUCLGHKXIw5kjDYk09HOfZ/ZiOiuS/GBbuWFTiUgH8XgnNZtmkBU
         Wtb08kNSUZnv9Bmyzo4sMYSX17so2DuOmt6V0xIDkPTaJTsQc6v3E54cA5u2o0iHXx9K
         0PQykqEFMvR4y59gvIbCpX5tj12DIRebzs71KJpz8dhJarS0aa1IaQoksu3EXZPTzh8h
         xUNvIHBCEd/1412kRW8vGFjhd5WtYBUhhh9X+KOiTwgC17Fl8C2PKEhknj6Jqr1qCQii
         Pxq87Ky3KBEhSCq2jmovdhCCT0ya+GAXhjUERzxefiMjpRuNhxJjbb8EipqJp8lf7F9I
         CnpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689174987; x=1691766987;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rF5+femrc/9pJY0m/8fZt1OSXF34LxMFVgcZqkZScLY=;
        b=brzWakT6MxYeNGqlDpmGCRHFFm/J2H74RcDc9+5Yg0Pttc/aDo08ixZmG/8lEqgmcL
         5/DH97aZok+Lwlu0EsJKTY6iIVp9pT38cS8O1Zz+N8fRehKUt3fHxOEffUD/vMwbBUsV
         9tnNrGzd7fiZwWsG41FaYb2kR2A2T5V7a3kjJPeXT4YAYaOG20glc91pRbb5jqpIfxHd
         lD44PrFVsIw50xYytSXtjAaEwXHJPI1q50PIoPoA2tN5/vfNaN7o0mjXvY3W524IIqRx
         CMrhD0TNlDnyZ1fgfzTDLXv1/40LEgRcfx9l8+3ayeT1OYSgHIIveJ6VoMjPuykHrOD5
         L4kw==
X-Gm-Message-State: ABy/qLaOcGuzkesunP9dUxXdiC2zTB1vFi3fsblRfUtnVcdmuuaCe+CO
	a2BPGYdQb6g+cZSFqI4dtRqOmw==
X-Google-Smtp-Source: APBJJlGK+GjEJ5cOBq9se7dhFmI2lyEAi3L6Lx6WaEJHMj0C2KHW3uft6HwqPgaHHwjpKE18WkL8Aw==
X-Received: by 2002:a2e:8050:0:b0:2b6:f1d5:619 with SMTP id p16-20020a2e8050000000b002b6f1d50619mr16173395ljg.14.1689174986951;
        Wed, 12 Jul 2023 08:16:26 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:ef4b:f9b8:e94a:ea27? ([2a02:578:8593:1200:ef4b:f9b8:e94a:ea27])
        by smtp.gmail.com with ESMTPSA id o16-20020a1709062e9000b00992ea405a79sm2642915eji.166.2023.07.12.08.16.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 08:16:26 -0700 (PDT)
Message-ID: <950766b1-4328-765f-f0c0-321824a14bf4@tessares.net>
Date: Wed, 12 Jul 2023 17:16:25 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH mptcp-next v2 0/3] selftests: mptcp: format subtests
 results in TAP (part 2)
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <20230712-mptcp-issue-368-selftests-subtests-v2-0-c8b174c18f93@tessares.net>
 <e6d6a299388b5e2324989d1063a80bbdbbd17329.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <e6d6a299388b5e2324989d1063a80bbdbbd17329.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 12/07/2023 15:46, Paolo Abeni wrote:
> On Wed, 2023-07-12 at 13:33 +0200, Matthieu Baerts wrote:
>> As discussed at a previous meeting, it might be good to print the test
>> name earlier to avoid confusions when there is an issue: sometimes the
>> error is printed at the end of the previous test and then the test name
>> is printed.
>>
>> While at it, the code has been uniformed and it allows new features,
>> e.g. colour support, see patch 2.
>>
>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>> ---
>> Changes in v2:
>> - Address Paolo's comment in patch 1/2 to print info only if there is any.
>> - Add patch 3/3, a fix for -net, a bit unrelated but discussed when
>>   working on part 1
>> - Link to v1: https://lore.kernel.org/r/20230628144927.828117-1-matthieu.baerts@tessares.net/
>>
>> ---
>> Matthieu Baerts (3):
>>       selftests: mptcp: join: rework detailed report
>>       selftests: mptcp: join: colored results
>>       selftests: mptcp: join: only check for ip6tables if needed
>>
>>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 454 +++++++++++-------------
>>  tools/testing/selftests/net/mptcp/mptcp_lib.sh  |  38 ++
>>  2 files changed, 253 insertions(+), 239 deletions(-)
>> ---
>> base-commit: 5fca7ce8c3c8d7badac7a9dd8b552bb221d91ee4
>> change-id: 20230621-mptcp-issue-368-selftests-subtests-3c29a649dcdd
>>
>> Best regards,
> 
> Series LGTM, thanks Matttbe !
> 
> Acked-by: Paolo Abeni <pabeni@redhat.com>

Thank you for the review!

Now in our tree (feat. for net-next):

New patches for t/upstream:
- b0d400ffb30a: selftests: mptcp: join: rework detailed report
- 8973057b67fb: selftests: mptcp: join: colored results
- 196ffdd8bf70: selftests: mptcp: join: only check for ip6tables if needed
- Results: 5fca7ce8c3c8..611b54c853d3 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230712T150953

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
