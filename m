Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C2B1DDF7
	for <mptcp@lists.linux.dev>; Tue, 23 May 2023 09:12:37 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-3f607766059so16344685e9.3
        for <mptcp@lists.linux.dev>; Tue, 23 May 2023 02:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684833156; x=1687425156;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TVQ5+E88RrFGLmRH3XXWnrg+7IR89gzJc0dppY8JNp0=;
        b=HhHOGE0Y7bdSqfOgeaB0axH+5FLO6/nAKmdKwso8xcG6U94pXGE3dG47k79fe40rXg
         gzVuzx/K6ZepXenJbE34Zm0zn9tSovOobrNdC4tXhQb7SVB/Lpny+cjvQwE66UbycHTL
         CcmxJN4KHG/GC6npl3k6iLFYMlLmVDt/cGSXLKcPz2I+9r08mi3cvC05/0NGAysYcdmc
         r6YLUeCstxooVH8kQQ8WxY+Wx0Gk7wbxvuh2FIuUcomofOBq/jVO+MR3rtrhsvxLXffE
         2J6/CHTSDBKGnFJEFphgce2jIMgmsZFaB3DEAvlu3GRxDEBWCHLD5ayK+uRZlPWn3VWA
         AUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684833156; x=1687425156;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TVQ5+E88RrFGLmRH3XXWnrg+7IR89gzJc0dppY8JNp0=;
        b=Ce9kjvA2c4Gsa6w14guf2yhKxBQ3UeN0bpFY68eQ3KljeYKj1zszJCkZziC6yATGrN
         PJyYgAM47Fi51kIyKO+S96gru6LNbttEdrxSyZx5x9gaTJ/eG3RPyks7NMwsgeMn7DLl
         Vb8fZqOQnhTAh3ifnncyc//Z9IUp6428cL9PVE7uV8erBbuoPjYuFu51h6S14E5vyAQm
         +HhAP4gE2RBNLIi+9wehK09qk3flH1OWfBZN79xDxcyA8ulaFiNlHZRL7Cq8kWeegXsF
         D3D1rvH1RsaElNoRS6t7o/MNio1d4lwC0LR9xblpHGgGOVfnbR2rZAHQcNmzR/jQzY13
         VLTw==
X-Gm-Message-State: AC+VfDxQuTYkdul4LzuZMVlFCD72aoOTPTwgnC2pfpmFYyqXsiNxzPQK
	5RKqVHCgwVYgJd8KjJ8IfGYeXmWKyE0wi96Ud24NSw==
X-Google-Smtp-Source: ACHHUZ5bG90xV2W6GH/5BZk2eYIFe60onBLz1VV9BkDOaFxiBQUCao7ROQcFkyVsM4MigbcCm7Sy7Q==
X-Received: by 2002:a05:600c:2105:b0:3f5:fc88:dcb9 with SMTP id u5-20020a05600c210500b003f5fc88dcb9mr7160398wml.19.1684833155870;
        Tue, 23 May 2023 02:12:35 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:7ae3:96f4:110c:3f46? ([2a02:578:8593:1200:7ae3:96f4:110c:3f46])
        by smtp.gmail.com with ESMTPSA id h19-20020a05600c28d300b003f427cba193sm14223612wmd.41.2023.05.23.02.12.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 02:12:35 -0700 (PDT)
Message-ID: <8c3acdda-7bdf-aced-f897-e383aec41ca1@tessares.net>
Date: Tue, 23 May 2023 11:12:34 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH mptcp-net v2 09/37] selftests: mptcp: lib: skip if not
 below kernel version
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
 <20230406-mptcp-issue-368-selftests-old-kernels-v2-9-50313e4f83ab@tessares.net>
 <1d88e4860e959d792de27839c930cb7eca70af77.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <1d88e4860e959d792de27839c930cb7eca70af77.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 22/05/2023 19:48, Paolo Abeni wrote:
> On Mon, 2023-05-22 at 18:37 +0200, Matthieu Baerts wrote:
>> Selftests are supposed to run on any kernels, including the old ones not
>> supporting all MPTCP features.
>>
>> A new function is now available to easily detect if a feature is
>> missing by looking at the kernel version. That's clearly not ideal and
>> this kind of check should be avoided as soon as possible. But sometimes,
>> there are no external sign that a "feature" is available or not:
>> internal behaviours can change without modifying the uAPI and these
>> selftests are verifying the internal behaviours. Sometimes, the only
>> (easy) way to verify if the feature is present is to run the test but
>> then the validation cannot determine if there is a failure with the
>> feature or if the feature is missing. Then it looks better to check the
>> kernel version instead of having tests that can never fail.
>>
>> This new helper is going to be used in the following commits. In order
>> to ease the backport of such future patches, it would be good if this
>> patch is backported up to the introduction of MPTCP selftests, hence the
>> Fixes tag below: this type of check was supposed to be done from the
>> beginning.
>>
>> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
>> Fixes: 048d19d444be ("mptcp: add basic kselftest for mptcp")
>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>> ---
>>  tools/testing/selftests/net/mptcp/mptcp_lib.sh | 21 +++++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
>> index 29b65f4b73b2..dcfe5eb6f7c0 100644
>> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
>> @@ -76,3 +76,24 @@ mptcp_lib_kallsyms_doesnt_have() {
>>  
>>  	mptcp_lib_fail_if_expected_feature "${sym} symbol has been found"
>>  }
>> +
>> +# !!!AVOID USING THIS!!!
>> +# Features might not land in the expected version and features can be backported
> 
> IMHO the above wording is a symptom we should not introduce this infra,
> nor the patches using it.
> 
> Yep, self test will not be perfect on all older kernel :)

I understand, that's something we should avoid. But the thing is that
even if selftests cannot be perfect on older kernels, when one sub-test
fails, the whole selftest is marked as failed, making all the other
sub-test useless because we only track the result of the whole selftest.

In other words, if MPTCP join subtest 42/100 is always failing on kernel
5.15 because a feature is not supported, the result of the 99 other
subtests will be ignored most of the time because we will only track the
result of the selftest which will be "failed" all the time.

To support kernels backporting new features, we can also add a new env
var to skip this check (always returning that the version is recent
enough). WDYT?

Anyway I guess on these kernels, only the selftests from the same kernel
version is used (not the one from the last dev branch).

But if we see other (easy) way to check if a feature is present, always
better to use alternatives.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
