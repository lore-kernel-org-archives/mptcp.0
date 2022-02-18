Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD484A81
	for <mptcp@lists.linux.dev>; Fri, 18 Feb 2022 21:05:54 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id c6so14782913edk.12
        for <mptcp@lists.linux.dev>; Fri, 18 Feb 2022 13:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Te2lp2UKG2h1ZsbeUVSHdCvVlMeobCWAIWMfR6Vrdd4=;
        b=XYIM3v2jsY/xCcfsWYhE00Ph4nP0dO+rJuLT06w+92hZIfbQ0jO01gRoasVfbSso4W
         ph1B8htEI7jnyMYsAgdaS7+bY69Pi+RCRJOusWeauN++YxxHDNTQgtzWJ90W2mDEu/7w
         dz5sWqjZnvD7F9j5odsSMyOHrQMJ435laRIouIJPpxFml2e1WO7cHr8XCIKvGUdbDj3k
         sIeKcQOURRDB5GDE2m+C/CfaJdYCl/yphCDkBoy31wP/QaqmyjwsrIm1u9DYsDXzN85/
         Fs2J2L3T0BasWiM5UMh6qQtQ3pNs1TNXvL2ShCMaxBtgMIqHPRfCMxRmIeKANkUVf5g5
         cE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Te2lp2UKG2h1ZsbeUVSHdCvVlMeobCWAIWMfR6Vrdd4=;
        b=hh77GfPmWUxsP7GXGLT0oLaYx004TCFPSPNnZg72km1yJuIU1/sHYFERyyxK/Wfx/A
         j3W662EuwEzwtcEHYPqIxRsL2TQEAkTY4vVpIPSecoA13A0I4UpgWhGFML1uuZbPpa8r
         1aEEcyxt9AyXENh11kSdUB/dEKnGRytuGHaoO8NUFwViSO+OQtBEEakzzXJx0LtnaJy2
         6Gi2cqAf5RKKa4rw2CLzk++J6eKSVIr9OOzG0qn4K9M3JaGsbH9fyAH7ULgBD6PopDhR
         t7tFTUvqIfG65uXoEWwb3jceZ5h6zrQuxjdrvnitCzFOlRATFJ7HXAjMime6B00bHcoB
         LJIg==
X-Gm-Message-State: AOAM531WAgWH+6+z2/e+3k6hbjKK/sKrlL/kS3KTaqpkWBs91gb542sL
	78JSIHZb6cT937EjeUTkSH1M3g==
X-Google-Smtp-Source: ABdhPJyMHYrM969AtTA3ZQmuo/3d9v7xixjGQ1BrIJ4t5PbjIRuWQ8IJqifpLw5mBQ0hyczTq0YaSA==
X-Received: by 2002:aa7:df12:0:b0:410:a50b:de00 with SMTP id c18-20020aa7df12000000b00410a50bde00mr10168012edy.2.1645218353080;
        Fri, 18 Feb 2022 13:05:53 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:dbb:9782:b78a:e346? ([2a02:578:8593:1200:dbb:9782:b78a:e346])
        by smtp.gmail.com with ESMTPSA id g6sm2625729ejz.170.2022.02.18.13.05.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 13:05:52 -0800 (PST)
Message-ID: <c906d5d7-976d-e956-81c1-c06223c0b858@tessares.net>
Date: Fri, 18 Feb 2022 22:05:52 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH mptcp-next v2 0/9] Refactor mptcp_join.sh
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
References: <20220217174329.826430-1-matthieu.baerts@tessares.net>
 <ffdf6780-5cc7-bde4-586e-eb36c7a409d@linux.intel.com>
 <808f443ae9db49c2e5bc69a2285f230d5369853c.camel@redhat.com>
 <a58fd624f7261abfe417f27b92dc906aab5fb22f.camel@redhat.com>
 <b53e8f70-dfb9-b587-5ac2-76d2e92272f1@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <b53e8f70-dfb9-b587-5ac2-76d2e92272f1@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat,

On 18/02/2022 19:59, Mat Martineau wrote:
> On Fri, 18 Feb 2022, Paolo Abeni wrote:
> 
>> On Fri, 2022-02-18 at 12:04 +0100, Paolo Abeni wrote:
>>> On Thu, 2022-02-17 at 16:33 -0800, Mat Martineau wrote:
>>>>> Patch 4/9 is the updated version of the previous patch 3/9 from v1:
>>>>> mainly
>>>>> rebased. I only added one line in the "usage()" function and use
>>>>> lower cases for
>>>>> only_tests variable.
>>>>>
>>>>> Patch 5/9 is new and similar to the previous patch: another way to
>>>>> execute a
>>>>> specific test, useful when using 'git blame'. Also help to have
>>>>> patch 6/9.
>>>>>
>>>>
>>>> These are running fine for me, it's just the issue of 2000+ lines of
>>>> churn
>>>> and the potential (or even likely) net/net-next merge conflicts if
>>>> we need
>>>> to modify mptcp_join.sh after the 5.18 merge window. Hopefully all the
>>>> work we're doing now to stabilize the tests means we will not have
>>>> as many
>>>> -net mptcp_join.sh changes in the next cycle, but we would still
>>>> probably
>>>> run in to some headaches. If we do apply these it would need to be
>>>> right
>>>> before net-next closes for 5.18.
>>>>
>>>> Since you've put this much work into this patch it implies that you
>>>> think
>>>> the merge headaches would be worth it for the 5.18 development cycle :)
>>>> For the way I use the test script the ability to test by number is not
>>>> that critical - is anyone else (Paolo?) thinking you'll use this
>>>> feature?
>>>
>>> That feature would have saved a significant amount of my time in the
>>> past weeks. I think the diffstat is a bit too much, and I still would
>>> prefer the other approach of filtering out the test in each helper used
>>> by the test themself.
>>
>> Uhmmm... my main argument vs the current version of patch 4 is defeated
>> by patches 5 && 6, which look useful. So I'm ok with patch 4 as is...
>>
> 
> Ok, thanks for the insight! I do like the features, just wanted to make
> sure there's enough interest to justify the conflict resolution work
> we're signing up for. And it does seem like the payoff is worth it. At
> least it's a selftest script and not kernel code that could be disrupted
> by incorrect git conflict resolution here :)

I think it is the good time to do that when you look at the diff with
the -net branch: a lot of other modifications in the same area have been
queued up in net-next :)

>>> Additionally, I think it would be nice replace the 'bare' ip netns exec
>>> ...' we still have in some the userspace tests with the appropriate
>>> helpers - possibly worth a separate, independent patch.
>>
>> ... still think it would be nice (almost necessary) cover the above ->
>> migrate all direct ip netns exec... usage to the appropriate helper.
>>
> 
> Sure, that would be good too.
> 
> Matthieu, I think it would be good to delay adding 4/5/6 to the export
> branch until mptcp_join.sh has stabilized in -net and been merged back
> to net-next - what do you think? Once these changes go in to the export
> branch we have a lot less flexibility in the order that patches go to
> net-next.

Sure I can. Do you mean waiting for the other patches that are in review
to fix issues in the tests?

I was thinking about that and I don't know if we need to wait: we
already have the commit 34aa6e3bccd8 ("selftests: mptcp: add ip mptcp
wrappers") in net-next and there is no patches for -net that are
currently planned if I'm not mistaken.

If we still want to send them to net-next later, I can also apply these
patches after "git markup: features net-next": so just after new patches
that will come in the next days/weeks.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
