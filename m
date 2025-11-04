Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6012F19CCF5
	for <mptcp@lists.linux.dev>; Tue,  4 Nov 2025 08:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762246072; cv=none; b=PB4cj9HVkC/k6gjKSmit1kbIfpNQl507hP7M4R17NX2OZx+1+V+9uIy+rosC3dKKa0qfJxe/5HzAb+wtVQpVBFuqkegAJ6f8Cz+bS9xzy4jXtXKhE6SKHNhaeUlthojMoGthM9kdbDkkapk9NzxQy7EyV3DRCMDUHRjS4gotNm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762246072; c=relaxed/simple;
	bh=rSKa1onPnz4y9tHtft9xZIr0qyl/TXyL9XdGGiCvbVA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ke7LKR2tTB9FbSo2+UzHSApz6o24r4UpjenL6Kw4euePMe6UzlRRE3BJSbtg8FTNMkX3ikdCR8HLhEY/PfsYacpYTm0U0lwmQtunprgus05NlDVoQH1Y4A/yrCzIqFSNaVt4xDMyDhsDqeop7pzUPgSsIS5KfvWwr0LLjMJgnyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u3RlyRAw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3RlyRAw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B2BC4CEF7;
	Tue,  4 Nov 2025 08:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762246071;
	bh=rSKa1onPnz4y9tHtft9xZIr0qyl/TXyL9XdGGiCvbVA=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=u3RlyRAw+/I9kdHbQJMj1aZCf4Btgz7TzrLz9w/LG/tMPyy9UetjZJNAzY6kiXhu3
	 aLltHJ4NuAy2Ld3UraJc8/ONgiRjhXSFkvWF/ruMmVMXcpau7Q3DZUWPmacfQKj+xI
	 zuWt679yWyOm1su6pAD0FP6CwmThVxFqpcu+4it5I4/pNNF1brcZvPii/lSpVsPoi0
	 xwwLQP8V2TicFSJ5Feh2ic8nJrnhutjMeEP9drdf33aQAR/9Kvbg0AqwLUNMuHQGRI
	 bjs4enjWU1shAG+9VceHqRYyS7oBn03nMbUGti2ddFe9VPcCoFCaqupNdU/o5A100f
	 Jp4g6skvvD7dg==
Message-ID: <ed7be7cc-5ff9-4a55-8d97-fa6be887b62d@kernel.org>
Date: Tue, 4 Nov 2025 09:47:48 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v2 2/6] selftests: mptcp: join: rm: set backup
 flag
Content-Language: en-GB, fr-BE
From: Matthieu Baerts <matttbe@kernel.org>
To: Geliang Tang <geliang@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
References: <20251102-slft-join-inst-v2-0-b4f3ba15a7c4@kernel.org>
 <20251102-slft-join-inst-v2-2-b4f3ba15a7c4@kernel.org>
 <1d91f6b378b430088d81c2a5a1d33c678fc81cac.camel@kernel.org>
 <21daa38d-d335-4d62-b247-472629ee54dc@kernel.org>
 <c707d12083543db56fa5b2f361837d1c29931c58.camel@kernel.org>
 <0b8d61bc-836b-4f61-a8c7-a5ce17906e19@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <0b8d61bc-836b-4f61-a8c7-a5ce17906e19@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/11/2025 09:47, Matthieu Baerts wrote:
> On 04/11/2025 08:29, Geliang Tang wrote:
>> Hi Matt,
>>
>> On Tue, 2025-11-04 at 07:57 +0100, Matthieu Baerts wrote:
>>> Hi Geliang,
>>>
>>> Thank you for the review.
>>>
>>> 4 Nov 2025 07:06:34 Geliang Tang <geliang@kernel.org>:
>>>
>>>> Hi Matt,
>>>>
>>>> Thanks for this fix. It works indeed.
>>>>
>>>> On Sun, 2025-11-02 at 12:30 +0100, Matthieu Baerts (NGI0) wrote:
>>>>> Some of these 'remove' tests rarely fail because a subflow has
>>>>> been
>>>>
>>>> In my testing, only the "flush addresses" test case fails
>>>> intermittently. I'm wondering which other test cases have failed in
>>>> your environment?
>>>
>>> I took the unstable ones from the Netdev and MPTCP CIs:
>>>
>>> https://netdev.bots.linux.dev/contest.html?pass=0&executor=vmksft-mptcp-dbg&ld-cases=1
>>>
>>> https://ci-results.mptcp.dev/flakes.html
>>>
>>>> I'm thinking we shouldn't add the "backup" flag to every test in
>>>> remove_tests, but only to the specific ones that are actually
>>>> failing.
>>>>
>>>> Similarly for patches 3 and 4, we don't need to add
>>>> "test_linkfail=128"
>>>> to every test. We should only apply it to the specific ones that
>>>> are
>>>> actually failing.
>>>
>>> If my analysis is correct, it means the simple fixes I did (backup
>>> and
>>> longer file size) can be applied to multiple tests. Then probably
>>> better
>>> to avoid these other tests to fail for the same reasons even if it is
>>> very
>>> rare, and very hard to reproduce, no? Each false positive takes a lot
>>> of
>>> resources (mainly time) to debug.
>>
>> I'll leave it to you to decide. However, I still believe it's better to
>> apply these fixes to the tests one by one, in case we see failures in
>> the future.
> 
> Because these modifications are not modifying what is being validated in
> the test, but only avoid noises that would make the tests failing, I
> think it is better to prevent issues and waiting for them to happen.

I meant to say: "it is better to prevent issues *than* waiting for them
to happen.".

> 
>> I'll respond with my Reviewed-by tag in the cover letter.
> 
> Thanks!
> 
> Cheers,
> Matt

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

