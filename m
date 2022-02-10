Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F79A2F21
	for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 10:42:36 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id bg21-20020a05600c3c9500b0035283e7a012so3636023wmb.0
        for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 02:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7JD+H0ZCO12M7VuczeDxSZKvHHzxz+CCJPESahGhG4k=;
        b=NY1LcJdr5ei3UMppF6gH79MJxZffJNo0IfHV1Krv67ECwS5uJiQCVGiQmDdSQaaeNq
         SlxAGzoz1/+HCa26P5cPfwvcS1hX4RAcaqZjVYrbgwLB6/HnVK2klgNkvT0NtdZibpDk
         K1bv4OUQD92e19ZWkP6p5Sr/Mo2gtv1Aam3IQKhSvFGTnG7SEHAHfquvQjkqPMHYcQ4E
         qAQVtK2Q3nuXZ3X3UIznQ1W4Ivp1vuf8bEIQbLHnghfHm3m9ztlMu1c0kZsKd+v+sXQP
         rG7MmfuSayvz8LOwHa7lst3u0yQWEO5YPC78fm58u73q0AHricknUOIPc+LdOazD4YwH
         lwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7JD+H0ZCO12M7VuczeDxSZKvHHzxz+CCJPESahGhG4k=;
        b=wT0Tf+X72TMzDdFjVeAJIRELe83svBS5Z0Gy2LVFVKMtZtEWjqWJUpHxyqh2x50mXX
         54+c7PAthIlLHQliR0WMhO9fYHWygNFI9t3G0IlwdNjFmZFLmKNjFMxmtjogk5uvbIc1
         nddglIrVoAk3NodK2he29SjuCz67Mh7e7kNwm7nrElLKXrhYBppmsSXufeJV4BKK02fE
         u5gfWBOdGhUCvSYQfn+vlaxHJa6etrsI5MsjO0/A5Upa3VuLpExb90voJLAIhOL8+Kn3
         pVLewm6h7Tl0micBRWlcp1IW0EI0Ajp++JHkuAiEF4zq/b/8Fin/kR2L5QwDydQKbA4z
         3j7w==
X-Gm-Message-State: AOAM530EHfi3hQvqTz5Ww0+47lB8DFIbqlIMsNsotQHA+Ddwwp5az7hj
	4YWTrCYsU9ZketlKKe/HexWY8RuPKW+Ez3YX
X-Google-Smtp-Source: ABdhPJxL+mKohSBZyyNtkZALvftBFkeSxFWq1xT4gAgFxBVdwTB/NNcinyLIIETOoDgA0DFywuVHKw==
X-Received: by 2002:a05:600c:2d4b:: with SMTP id a11mr1610476wmg.44.1644489754419;
        Thu, 10 Feb 2022 02:42:34 -0800 (PST)
Received: from [10.44.2.26] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id r2sm1398878wmq.24.2022.02.10.02.42.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 02:42:34 -0800 (PST)
Message-ID: <8caf46ee-11b6-aefa-3edd-e17c0928efc7@tessares.net>
Date: Thu, 10 Feb 2022 11:42:33 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH mptcp-next 3/9] selftests: mptcp: join: option to execute
 specific tests
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
References: <20220209212520.2989291-1-matthieu.baerts@tessares.net>
 <20220209212520.2989291-4-matthieu.baerts@tessares.net>
 <199e2a26-da9-e79f-53c-50498fda97c@linux.intel.com>
 <066bb7a33e8f2128968c4aec5ba57c38b2f2c4cd.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <066bb7a33e8f2128968c4aec5ba57c38b2f2c4cd.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat, Paolo,

On 10/02/2022 11:04, Paolo Abeni wrote:
> On Wed, 2022-02-09 at 16:36 -0800, Mat Martineau wrote:
>> On Wed, 9 Feb 2022, Matthieu Baerts wrote:
>>
>>> Often, it is needed to run one specific test.
>>>
>>> There are options to run subgroups of tests but when only one fails, no
>>> need to run all the subgroup. So far, the solution was to edit the
>>> script to comment the tests that are not needed but that's not ideal.
>>>
>>> Now, it is possible to run one specific test by giving the ID of the
>>> tests that are going to be validated, e.g.
>>>
>>>  ./mptcp_join.sh 36 37
>>>
>>> This is cleaner and saves time.
>>>
>>> Technically, the reset* functions now return 0 if the test can be
>>> executed. This naturally creates sections per test in the code which is
>>> also helpful to understand what a test is exactly doing.
>>>
>>
>> My sense is that this is primarily for development purposes since the test 
>> numbers may shift as tests are added or modified. Is it worth the churn 
>> when we have the subgroup functionality and could comment out chunks of 
>> the test script that are not useful for running specific tests in a loop?

On my side, it would be helpful. On my side, I can edit the code but
that's not nice, especially if you want to automate tests with and
without a patch: you can have conflicts with the new comments, etc.

On the CI, I cannot easily modify the code so I end up testing more than
expected, that's slow and sometimes hits other issues.

I guess on Paolo's side too as he complained about this missing feature :)

>> I'm not set against this change, but hoping to discuss it some more to 
>> both understand the benefits (I assume for running CI in a loop?) and to 
>> see if anyone has bright ideas for avoiding the whitespace churn.
>>
>> ("Include a bash fork in our selftest code that implements 'goto'" seems 
>> like overkill :) )
> 
> Perhapas something alike the following ?!? Not a complete solution:
> - completely not tested
> - we will first need to add some wrapper for iptables or even beffer
> for ip netns exec, to be more generic
> - possibly more 'skip_test && return' needed, but not many, I guess.
> 
> I hope should be enough demonstrate the idea...

If we really want to avoid modifying existing lines in selftests, I can
also not add new tabs after the new "if reset" and drop patches 7-9. But
that's a shame we cannot refactor the code in the selftests :-/

I don't think it is a good idea to add the skip_test everywhere: we will
certainly forgot to add one somewhere until someone test the feature.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
