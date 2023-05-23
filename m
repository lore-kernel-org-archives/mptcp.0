Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9A21E516
	for <mptcp@lists.linux.dev>; Tue, 23 May 2023 09:58:28 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-3f603ff9c02so15633695e9.2
        for <mptcp@lists.linux.dev>; Tue, 23 May 2023 02:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684835906; x=1687427906;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nL+6QkHO6yR2KP+5MRHsFg+KPRC2y9KhSCQbZC/oBVw=;
        b=6k8wj28V7t8QoPOwiMzT//DpRtAFL3htAPJxJ3P3bVfcIumu7JhHGOGwsNVAg5MfYC
         MIT/fg2fSWTLJXea7MiuDqAxD3b2Lq4/sW2F4FWJICaqSOXEdP32ciuafhp0N3obh6VW
         kn2xaqmwWQyMtfTEJyGN4j7QTyVVKm4Jvk+A7ikbHIZbTSfEGQBF5Fqu5RX9Py6OzNXQ
         inlXJ6U5HLpC3Z7HiMYn6O88tAUIQ+TDvsA83h6+34arEnJEpcjzube2DiCSaE3QyZ8t
         71p5D1ijcb1qXFM6ujDW5AuKuKskHTfEIAge9+s0cIOM++S0WfdPBCRiQkm58wZhD+9+
         APVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684835906; x=1687427906;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nL+6QkHO6yR2KP+5MRHsFg+KPRC2y9KhSCQbZC/oBVw=;
        b=O74HqH9mPPt0tnpGp+PEMmSObU1Dvi8IsUBrQi8NieTch9X3SgUBFtixnLR0jDFsKO
         GPQ/yyulXDKfrng98dEHMeXgt+19UUiL1depNycKx4YKzcNCGKhw0SdUcedpKR+h7HQq
         vVt1B9rfsHyirV/Tjo5xbNjNEf1QZgfYKsuN4nNGPpjQ98YcW2u0GsmjFf58C4BGaGO0
         u/JBfi3L1OHGvBQ/yj2ONDAiZk6eeOyLDftrbtmGiYwwO8TX0+4fihtJtvi7pc+85kAJ
         yhkHzTIzD/R0C4dCFXdVPSjqdZe+jIGh1ShBaqzO5J2rC596F5U8dwfY7SiRd8nxqiVv
         olMw==
X-Gm-Message-State: AC+VfDztKxH59Dm4llxhtNwtdFbV+AfJDHSiawPmpdlohfWhg/3UKAoA
	SlTskFc9N/dX3v4+L6JiyJ05ZA==
X-Google-Smtp-Source: ACHHUZ6HWz5GW8YsZGz4rQ5dNsGrMUG9myHxWuddS9wJ7PQ3SXXv1U43IdUsNV0UuCf0gufmWKI7xA==
X-Received: by 2002:a05:600c:2212:b0:3f0:a08e:811b with SMTP id z18-20020a05600c221200b003f0a08e811bmr9714251wml.13.1684835906615;
        Tue, 23 May 2023 02:58:26 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:7ae3:96f4:110c:3f46? ([2a02:578:8593:1200:7ae3:96f4:110c:3f46])
        by smtp.gmail.com with ESMTPSA id n21-20020a7bc5d5000000b003f42a75ac2asm11211423wmk.23.2023.05.23.02.58.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 02:58:26 -0700 (PDT)
Message-ID: <1b1c4ef7-827b-de02-8e28-9bc76a3a6e25@tessares.net>
Date: Tue, 23 May 2023 11:58:25 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH mptcp-net v2 25/37] selftests: mptcp: join: skip check if
 MIB counter not supported
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
 <20230406-mptcp-issue-368-selftests-old-kernels-v2-25-50313e4f83ab@tessares.net>
 <81b89eceb464bd67bca36ac8eccba3489883014e.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <81b89eceb464bd67bca36ac8eccba3489883014e.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 22/05/2023 19:39, Paolo Abeni wrote:
> On Mon, 2023-05-22 at 18:37 +0200, Matthieu Baerts wrote:
>> Selftests are supposed to run on any kernels, including the old ones not
>> supporting all MPTCP features.
>>
>> One of them is the MPTCP MIB counters introduced in commit fc518953bc9c
>> ("mptcp: add and use MIB counter infrastructure") and more later. The
>> MPTCP Join selftest heavily relies on these counters.
>>
>> If a counter is not supported by the kernel, it is not displayed when
>> using 'nstat -z'. We can then detect that and skip the verification. A
>> new helper (get_counter()) has been added to do the required checks and
>> return an error if the counter is not available.
>>
>> Note that if we expect to have these features available and if
>> SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES env var is set to 1, the tests
>> will be marked as failed instead of skipped.
>>
>> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
>> Fixes: b08fbf241064 ("selftests: add test-cases for MPTCP MP_JOIN")
>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>> ---
>>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 251 ++++++++++++++----------
>>  1 file changed, 142 insertions(+), 109 deletions(-)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> index 1a8f7c6fa988..73c513f1e808 100755
>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> @@ -505,11 +505,25 @@ wait_local_port_listen()
>>  	done
>>  }
>>  
>> +# $1: ns ; $2: counter
>> +get_counter()
>> +{
>> +	local ns="${1}"
>> +	local counter="${2}"
>> +	local count
>> +
>> +	count=$(ip netns exec ${ns} nstat -asz "${counter}" | awk 'NR==1 {next} {print $2}')
>> +	if [ -z "${count}" ]; then
>> +		mptcp_lib_fail_if_expected_feature "${counter} counter"
>> +		return 1
>> +	fi
>> +
>> +	echo "${count}"
>> +}

(...)

> This looks quite invasive. I would instead skip the whole mp_join tests
> if any of the basic counters are not available - to there will be a
> single hook/check.

I agree that it is quite invasive but the idea is to backport it to
stable. Once this is done, it should not cause troubles to do other
backports.

Also, this new helper does a few things:

- It makes sure we get one counter to avoid issues we had in the past
where some counters were sharing the same prefix, e.g. MPTcpExtRmAddr
and MPTcpExtRmAddrDrop

- When a MIB counter is missing, the checks using it are skipped

- Our CI will catch typos

- (getting MIB counters is now uniformed)

Initially I used the helpers for counters that are more recent and for
the ones sharing the same prefixes but that was creating quite a lot of
commits and I was thinking it might be better to uniform them.

It should not be too hard to backports: we don't really change this part
so if there is are conflicts, it is very likely because a counter is not
used somewhere so we don't need that chunk.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
