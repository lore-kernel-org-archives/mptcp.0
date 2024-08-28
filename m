Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF1914A4F3
	for <mptcp@lists.linux.dev>; Wed, 28 Aug 2024 06:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724827525; cv=none; b=P7JyY5UW5XHqq99m3YBJv7ZsuQOgfbd5v4Ok+sTgJNT0ml3gKdACkcWmMAlny4tFIt9bNMxqTd7mWdpQ69RbQHrq3ZpIZHLLCz1QUkxdnUKPUiFW6g5Ym1hmcd8TnWRreYrOI4atvMaRoM46gX/SsVAWHmBRJRAkr7YLbTDAKxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724827525; c=relaxed/simple;
	bh=mFupG58wIZgBGkp0V3Bxv80mv1dxUy3kp4V9W14RpZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a2UT+OJr1HnvT8c/xEusSSuAjgD1drcDEv5wF1b7f8jsvtlZ8nj9PSFiGPUXgaxRAa5idddGjrifn+fJyoLFf2KOwuAe5BGcv8nogz0hjKwO3IFXSVZdF7qIv6zzA+9QwOJ/k5SdtQUyl7NCSaHbIpAXtNusCUhDMoetvXBA0mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PR4tqfJj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PR4tqfJj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D1B8C4DE00;
	Wed, 28 Aug 2024 06:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724827524;
	bh=mFupG58wIZgBGkp0V3Bxv80mv1dxUy3kp4V9W14RpZs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PR4tqfJjCgEqV9AcNYMW9+RNLry4JvtB86261gsSQ4jBIi9CNQDzUCeHj1cg3HIaG
	 IV95i+Om56Kw0WJAeSxOU6FPqU2gpZyqGpsuW/BopWA5DtthjxpZ+GlLL1LZ0my70E
	 fVT/wSWVKmpKjg2r1N+cejbPqmz7WiXlb/C2nGXvLjez7wtRVsPZFXES8aCfZdKUry
	 +Er/oFAALQympHu3/VtqOXIx839via5Mxoo+yOL9PiMNqXZPLY6L1ZAnrV6lhCAiu0
	 VKItHtWJrX2gOpMotVLIU72lctgkQjemM6Whlp2vVzDIXZRPVe8ba5EGxp5s4qQ+Qj
	 8Icj3fZivlw6A==
Message-ID: <f25803ab-ee6d-4f05-a538-756c25958a65@kernel.org>
Date: Wed, 28 Aug 2024 08:45:22 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v4 3/3] Squash to "selftests/bpf: Add mptcp
 subflow subtest"
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1724415435.git.tanggeliang@kylinos.cn>
 <ac6c7b2338205693434883a34256eddfd7605985.1724415435.git.tanggeliang@kylinos.cn>
 <26a19624-f042-487f-8227-a992ab786696@kernel.org>
 <363548497c01a3955412d32b281022104f993563.camel@kernel.org>
 <17b3927e-0007-4e97-8c98-4c95068401b8@kernel.org>
 <2a3a8b53865e3dc68e7aab28cca1b3433981d81a.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <2a3a8b53865e3dc68e7aab28cca1b3433981d81a.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 28/08/2024 04:44, Geliang Tang wrote:
> Hi Matt,
> 
> On Tue, 2024-08-27 at 11:08 +0200, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> Thank you for your reply.
>>
>> On 27/08/2024 10:49, Geliang Tang wrote:
>>> Hi Matt,
>>>
>>> Thanks for the review.
>>>
>>> On Mon, 2024-08-26 at 18:54 +0200, Matthieu Baerts wrote:
>>>> Hi Geliang,
>>>>
>>>> On 23/08/2024 14:19, Geliang Tang wrote:
>>>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>>>
>>>>> Drop ss_search() from run_subflow().
>>>>>
>>>>> Now ss_search() are only used by bpf_sched tests. It will be
>>>>> dropped
>>>>> in next step.
>>>>>
>>>>> Use the "cgroup/getsockopt" way to inspect the subflows.
>>>>>
>>>>> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
>>>>> ---
>>>>>  .../testing/selftests/bpf/prog_tests/mptcp.c  | 57
>>>>> ++++++++++++---
>>>>> ----
>>>>>  1 file changed, 35 insertions(+), 22 deletions(-)
>>>>>
>>>>> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c
>>>>> b/tools/testing/selftests/bpf/prog_tests/mptcp.c
>>>>> index 73adc58cd776..ce464b1e0802 100644
>>>>> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
>>>>> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
>>>>> @@ -368,22 +368,13 @@ static int endpoint_init(char *flags)
>>
>> (...)
>>
>>>>> + len = sizeof(mark);
>>>>> + err = getsockopt(client_fd, SOL_SOCKET, SO_MARK, &mark,
>>>>> &len);
>>>>> + if (!ASSERT_OK(err || mark != 2, "getsockopt(client_fd,
>>>>> SO_MARK)"))
>>>>
>>>> The mark should be 0 on the MPTCP socket, no?
>>>
>>> optval is modified in _check_getsockopt_subflows_mark(), so the
>>> mark is
>>> 2 now.
>>
>> Mmh, I missed that. I don't think a helper called 'check_xxx()'
>> should
>> modify anything.
> 
> We can rename _check_getsockopt_subflow_mark/_cc to
> _getsockopt_subflow_mark/_cc to make their names match.

I don't know: to me, it is still strange to have the validation part
modifying output. It could then hide thing.

>>
>> Would it not be better to have ...
>>
>>   _check_getsockopt_subflows_mark()
>>
>> ... making sure the first subflow has the mark 1, and the other one,
>> the
>> mark 2? (if we add items at the end of the list)
> 
> No, this is what v3 do. I think this v4 is much better than v3.
> 
> I didn't find a way to return a string type optval to getsockopt() in
> v3, so I had to do the mark/cc checks in
> _check_getsockopt_subflow_mark/_cc. I finally found a way to do this,
> so I used it in v4.
> 
> It's strange that v3 sets mark/cc in the BPF program and checks mark/cc
> in the BPF program too. 
> 
> v4 is much better, it sets mark/cc in the BPF program, use getsockopt()
> to get mark/cc in user space in prog_tests/mptcp.c and do the checks in
> user space too.

I don't know as well: I understand that the v4 is doing more operations
in BPF, but it still does not check the MPTCP socket option, only the
ones of the subflows. Also, the userspace, and the BPF programs are now
validating the same thing: the options have been changed on the
subflows, but is it really needed to do the same validation twice?

The idea being Nicolas' BPF program is to show that it is possible to
set socket options per subflow with BPF. So it likes it is important to
validate that:

- the subflows TCP socket options have been modified: different marks
and CC, validated by the new BPF program
- and the MPTCP socket options are still referencing the default ones

I don't think it is important to check that BPF can change the values
returned by getsockopt(). I mean: doing this is not specific to MPTCP I
think. That's why I think the BPF program should not modify the value
returned by getsockopt(), but only checking everything is OK on the
subflow side. No?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

