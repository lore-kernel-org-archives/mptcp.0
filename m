Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D241213C677
	for <mptcp@lists.linux.dev>; Thu, 15 Aug 2024 21:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723755607; cv=none; b=AjY0jXHbi+iS+RM791vgLGVbFtFRiH6wK/3habzOct3CwxX75z70pPAvLcFW4DO+XVdxZMAf5NdlpdYbvkl5XG8FbuaAWvNixTjzBDKpR5zyBsF/hcTo6RnnDIozIuuyMK+iIE5h53E8+qdCtYmFrm8Gog3Z2eNG2af1tg91/sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723755607; c=relaxed/simple;
	bh=HydlqhyV1Ful9Sat+nBNm8+q0+h5c1v94FLryjyH7uk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=il8oJrQXV+xv5vP2B142PoZTBycHyMFKCm1A2xIReOsGGpzsOQh25g8+lcS7BXgwrWujW+P8xcQ5X5qRiqRZ8YU9+zSFxk8/zU2GAkGqYseuMuplheX4rM9tvGKA138Z7sFi6c3/fNSNNCvnA68sjMaNh4KUOFjolKt0R7kzyxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpf/LxkZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpf/LxkZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C21D8C32786;
	Thu, 15 Aug 2024 21:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723755607;
	bh=HydlqhyV1Ful9Sat+nBNm8+q0+h5c1v94FLryjyH7uk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jpf/LxkZtaGgRO6II+EI5o8Ga6OCp4V/e5gBL5usu1kpftIjIPvlpXdt4NSbYJdbo
	 AhywGgk7S9Jtvm4DtuwZA84wzYdpYcREnbLBXlNVek4bYcBZvkyzqKnihvof7y2uqr
	 mx+UxUGqKa6+VWI7Rr4iRaOv1T5XqYuUXUaDpENfe45deWys0Tja8HEMWr3TQImv3O
	 5oH+ISNtrGDqkO0U4CgCV23u2LuijDVHBd75kOSLnU2kN6N7X2Z/cse6v+mB2C+DWs
	 +CUoXmDHuDMLRL9KaUL3XHZCee5WeD6HlZCkwYIqHZNJyXnTAFQpaZYBEhDxRtEL5a
	 MMDkdLGBO0wmw==
Message-ID: <b0f25eeb-e644-4cd7-a719-b9dcd1b57480@kernel.org>
Date: Thu, 15 Aug 2024 23:00:05 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: Add mptcp subflow subtest
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
References: <20240805-upstream-bpf-next-20240506-mptcp-subflow-test-v4-0-2b4ca6994993@kernel.org>
 <20240805-upstream-bpf-next-20240506-mptcp-subflow-test-v4-2-2b4ca6994993@kernel.org>
 <2136317a-3e95-4993-b2fc-1f3b2c28dbdc@linux.dev>
 <8a2ff1bd-52dc-421d-87b7-fc2f56e81da2@kernel.org>
 <716cbd56-4a44-4451-a6f3-5bacef3e0729@linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <716cbd56-4a44-4451-a6f3-5bacef3e0729@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

(only the MPTCP list)

On 15/08/2024 00:37, Martin KaFai Lau wrote:
> On 8/14/24 3:04 AM, Matthieu Baerts wrote:
>> Hi Martin,
>>
>> Thank you for your reply!
>>
>> On 14/08/2024 03:12, Martin KaFai Lau wrote:
>>> On 8/5/24 2:52 AM, Matthieu Baerts (NGI0) wrote:

(...)

>>>> +    ASSERT_OK(ss_search(ADDR_1, "fwmark:0x1"), "ss_search
>>>> fwmark:0x1");
>>>> +    ASSERT_OK(ss_search(ADDR_2, "fwmark:0x2"), "ss_search
>>>> fwmark:0x2");
>>>> +    ASSERT_OK(ss_search(ADDR_1, new), "ss_search new cc");
>>>> +    ASSERT_OK(ss_search(ADDR_2, cc), "ss_search default cc");
>>>
>>> Is there a getsockopt way instead of ss + grep?
>>
>> No there isn't: from the userspace, the app communicates with the MPTCP
>> socket, which can have multiple paths (subflows, a TCP socket). To keep
>> the compatibility with TCP, [gs]etsockopt() will look at/modify the
>> whole MPTCP connection. For example, in some cases, a setsockopt() will
>> propagate the option to all the subflows. Depending on the option, the
>> modification might only apply to the first subflow, or to the
>> user-facing socket.
>>
>> For advanced users who want to have different options set to the
>> different subflows of an MPTCP connection, they can use BPF: that's what
>> is being validated here. In other words, doing a 'getsockopt()' from the
>> userspace program here will not show all the different marks and TCP CC
>> that can be set per subflow with BPF. We can see that in the test: a
>> getsockopt() is done on the MPTCP socket to retrieve the default TCP CC
>> ('cc' which is certainly 'cubic'), but we expect to find another one
>> ('new' which is 'reno'), set by the BPF program from patch 1/2. I guess
>> we could use bpf to do a getsockopt() per subflow, but that's seems a
>> bit cheated to have the BPF test program setting something and checking
>> if it is set. Here, it is an external way. Because it is done from a
> 
> I think the result is valid by having a bpf prog to inspect the value of
> a sock. Inspecting socket is an existing use case. There are many
> existing bpf tests covering this inspection use case to ensure the
> result is legit. A separate cgroup/getsockopt program should help here
> (more on this below).
> 
>> dedicated netns, it sounds OK to do that, no?
> 
> Thanks for the explanation. I was hoping there is a way to get to the
> underlying subflow fd. It seems impossible.
> 
> In the netns does help here. It is not only about the ss iterating a lot
> of connections or not. My preference is not depending on external tool/
> shell-ing if possible, e.g. to avoid the package update discussion like
> the iproute2 here. The uapi from the testing kernel is always up-to-
> date. ss is another binary but arguably in the same iproute2 package.
> There is now another extra "grep" and pipe here. We had been bitten by
> different shell behaviors and some arch has different shells ...etc.
> 
> I think it is ok to take this set as is if you (and Gelang?) are ok to
> followup a "cgroup/getsockopt" way to inspect the subflow as the very
> next patch to the mptcp selftest. It seems inspecting subflow will be a
> common test going forward for mptcp, so it will be beneficial to have a
> "cgroup/getsockopt" way to inspect the subflow directly.
> 
> Take a look at a recent example [0]. The mptcp test is under a cgroup
> already and has the cgroup setup. An extra "cgroup/getsockopt" prog
> should be enough. That prog can walk the msk->conn_list and use
> bpf_rdonly_cast (or the bpf_core_cast macro in libbpf) to cast a pointer
> to tcp_sock for readonly. It will allow to inspect all the fields in a
> tcp_sock.

Do you think it is something that you could do to replace the
validations with 'ss', and maybe help with future validations for the
BPF packet schedulers?


> Something needs to a fix in patch 2(replied separately), so a re-spin is
> needed.
> 
> pw-bot: cr
> 
> [0]: https://lore.kernel.org/all/20240808150558.1035626-3-
> alan.maguire@oracle.com/
> 
> 
> 

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

