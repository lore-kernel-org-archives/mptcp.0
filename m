Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7CF187C
	for <mptcp@lists.linux.dev>; Wed, 16 Feb 2022 15:50:41 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id y17so4606086edd.10
        for <mptcp@lists.linux.dev>; Wed, 16 Feb 2022 07:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DGyhS7z1bnlGvTTRspLh1LIla+M2hsjmX00+DPehJCA=;
        b=KclbQ3fLanLGFAy71vnfuqvzgXnvZzG5Ky24UKE7NG7uew2YPEbbx1Gy9+8mCsnsM9
         4O/0BJ/aBeLHmldqqGHxQUGYMmvMrxyGj+4Sk/iCPDG1Vh+V/hjiyv+OEb7V2n/pSUd7
         aqt3aYvbCn+1pqzMiDe/CGV5rIWCuKMr9Zn0OT9tW7SVLrSvH11b6sxEDrLyl+uP7x7o
         wzlvkFRbrh1Qbi94pEmqSzkDs3wtDo2uSaxyT6Db0Yf6gZtOprZwiFemFBfiCdZW2L/Y
         iyaHEBgLDtYyxocKkBqGG77NfPVJ6RAEI2MNzko9+y64CjXhowMlUxPphGIvtkqiarFo
         4wfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DGyhS7z1bnlGvTTRspLh1LIla+M2hsjmX00+DPehJCA=;
        b=VyGR1tZKatXIo8g/Ih+DnQH3aCk0hJYqX2PS/YZb/o/BzGKgSOsgq8AMmiT7agS24L
         s28wWkcugRpox3iOEdCwkOG1Zn3+YuJdj7ucsUAQGk3yoFtt6Ih2TKZVPZi4W/de2vqM
         VMvOxbxO5BnABBeFnbDtXDPNjG2ZHWKg4/tzUSUiMtPR7GsHbFD3/9J+ZTidwS2iNWT3
         O0/O1kCdlNQwytKxHUbWhS/oe6qOYBa6Bg8g7wc971+zFpI1FvyToj4VkN3KZCfIfbVy
         rp5gaNhJSz7wMnsgmYE0b0sY3dLIMBiPMwXqgOfp8Frd50OEfBouJk9Xotr4Fy7Rhzkm
         16kw==
X-Gm-Message-State: AOAM530SWO1wN9NQlGCedX6w7v68U9fEmC47baTd/EYG39ysgs/9//2k
	XlLZKLydNFjTPvIZ+MJ2QuJ0qw==
X-Google-Smtp-Source: ABdhPJwYcwyUbCcfgtp38dH3LGgbbtWRkXxoIZGqR9chmaCLgcpr4zyLthlqSPrCZe99yJApsbk3gg==
X-Received: by 2002:aa7:d999:0:b0:40e:fdf0:38c with SMTP id u25-20020aa7d999000000b0040efdf0038cmr3630288eds.419.1645026639619;
        Wed, 16 Feb 2022 07:50:39 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:f860:24ec:64c5:373a? ([2a02:578:8593:1200:f860:24ec:64c5:373a])
        by smtp.gmail.com with ESMTPSA id i27sm22260ejo.214.2022.02.16.07.50.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 07:50:39 -0800 (PST)
Message-ID: <5bfeecaa-da36-c8f1-4115-c170547b19fd@tessares.net>
Date: Wed, 16 Feb 2022 16:50:38 +0100
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
 <8caf46ee-11b6-aefa-3edd-e17c0928efc7@tessares.net>
 <2ed54f9b4f33163372f368a881a31e71175ca475.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <2ed54f9b4f33163372f368a881a31e71175ca475.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 10/02/2022 16:11, Paolo Abeni wrote:
> On Thu, 2022-02-10 at 11:42 +0100, Matthieu Baerts wrote:
>> On 10/02/2022 11:04, Paolo Abeni wrote:
>>> On Wed, 2022-02-09 at 16:36 -0800, Mat Martineau wrote:
>>>> On Wed, 9 Feb 2022, Matthieu Baerts wrote:
>>>>
>>>>> Often, it is needed to run one specific test.
>>>>>
>>>>> There are options to run subgroups of tests but when only one fails, no
>>>>> need to run all the subgroup. So far, the solution was to edit the
>>>>> script to comment the tests that are not needed but that's not ideal.
>>>>>
>>>>> Now, it is possible to run one specific test by giving the ID of the
>>>>> tests that are going to be validated, e.g.
>>>>>
>>>>>  ./mptcp_join.sh 36 37
>>>>>
>>>>> This is cleaner and saves time.
>>>>>
>>>>> Technically, the reset* functions now return 0 if the test can be
>>>>> executed. This naturally creates sections per test in the code which is
>>>>> also helpful to understand what a test is exactly doing.
>>>>>
>>>>
>>>> My sense is that this is primarily for development purposes since the test 
>>>> numbers may shift as tests are added or modified. Is it worth the churn 
>>>> when we have the subgroup functionality and could comment out chunks of 
>>>> the test script that are not useful for running specific tests in a loop?
>>
>> On my side, it would be helpful. On my side, I can edit the code but
>> that's not nice, especially if you want to automate tests with and
>> without a patch: you can have conflicts with the new comments, etc.
>>
>> On the CI, I cannot easily modify the code so I end up testing more than
>> expected, that's slow and sometimes hits other issues.
>>
>> I guess on Paolo's side too as he complained about this missing feature :)
>>
>>>> I'm not set against this change, but hoping to discuss it some more to 
>>>> both understand the benefits (I assume for running CI in a loop?) and to 
>>>> see if anyone has bright ideas for avoiding the whitespace churn.
>>>>
>>>> ("Include a bash fork in our selftest code that implements 'goto'" seems 
>>>> like overkill :) )
>>>
>>> Perhapas something alike the following ?!? Not a complete solution:
>>> - completely not tested
>>> - we will first need to add some wrapper for iptables or even beffer
>>> for ip netns exec, to be more generic
>>> - possibly more 'skip_test && return' needed, but not many, I guess.
>>>
>>> I hope should be enough demonstrate the idea...
>>
>> If we really want to avoid modifying existing lines in selftests, I can
>> also not add new tabs after the new "if reset" and drop patches 7-9. But
>> that's a shame we cannot refactor the code in the selftests :-/
>>
>> I don't think it is a good idea to add the skip_test everywhere: we will
>> certainly forgot to add one somewhere until someone test the feature.
> 
> skip_test will be needed "only" in the helper called directly from the
> test body. I think the shared chunk already touches all the existing
> one.
> 
> Validating should be simple (assuming the current number of mpj
> testacase is 100): 
> 
> ---
> for I in $(seq 1 100); do
> 	./mptcp_join.sh $I
> done > out
> 
> test=$(grep -c "\d\d\d " out)
> if [ $test = 100 ]; then
> 	echo ok
> else
> 	echo paolo is dumb!
> fi
> ---

I hope it is OK but I prefer to stick with the 'if reset; then'.

The main reason is that I don't want to run this validation you gave
here and have the second and totally wrong "echo" printed in my terminal :-/

Even if it is clearly less important than that, another reason is that
there are still a few direct commands "ip netns exec (...)". I could
move them in a new helper but anyway Geliang did a lot of modifications
in the "tests" part recently to allow running the tests with 'ip'
instead of 'pm_nl_ctl'. So probably fine to do a bit more modifications,
no? :)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
