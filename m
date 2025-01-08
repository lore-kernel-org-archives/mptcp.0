Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAA21F8ADF
	for <mptcp@lists.linux.dev>; Wed,  8 Jan 2025 11:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736337471; cv=none; b=uqHIELfynknLBtqjYT8KxyTJxa279wYcb7au61vAi90/1Z6juW4srLxqmBwIFRbVtJMRHMl4nbPWipu4saLWXSYRiHlKr1mVNDNLcR0GjHOe0zeRdlocChhsf3bHqopnYAYnoq/gSrOWW7BvtnZQoUaAiRKSXqvA2vCSX9/sv1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736337471; c=relaxed/simple;
	bh=D5YzjvdjB3RXvjfxcHfXm82Xqr86PT3LxoQW3rjiYF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oe88nHYpdd60eh7KIVb7p9vA+ZPI14LWo5+CWHc+9jeBohgivHd8Gz/ZRBwQEFcDHwINnvKkPln54xZrsD6UFAIq0UhZ1k6BSMAO9BM93WU68AanMceiifZRKr1u26aX7DpckPE/62Zv8s+g9KNbYQQnihzlhwEFRkUZpVlhCkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qLFWDOau; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qLFWDOau"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19906C4CEDD;
	Wed,  8 Jan 2025 11:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736337470;
	bh=D5YzjvdjB3RXvjfxcHfXm82Xqr86PT3LxoQW3rjiYF4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qLFWDOauRk18QCNyr6Vep/UqalniaGRyBx4toTRphH6HAZx2+66ujzgT4s7ZiNsE2
	 a7pcn6t7Zqxa0G73uK9ny1qp4SPD7Mip1+/vX2Gcsyc7iwupHu8Hcg47ZAIgq15noT
	 lt7vyZkUJ23VntNiKtFnORTDwQYrH4uGqvsCl6uzZbsxVl/2Yoo1wbNiae0i15hVRN
	 s64wy+HlBqHD4OfoSkr6fIh1L3i+h7mhfQzWkPXenkRIKxgl0l0lfkT/LD4ZNecdFO
	 DqQWdFawj2+oPYlASFXt9blR+tkGttr9CIelb2/SPj5C5MEPPQcza+RlmRN2PCaTBO
	 zphFKBsbt6p+Q==
Message-ID: <e0a09148-2b5a-43e3-941b-e9bc381a424c@kernel.org>
Date: Wed, 8 Jan 2025 12:57:48 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net 0/9] net: sysctl: avoid using current->nsproxy
Content-Language: en-GB
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
References: <20250107-mptcp-sysfs-netns-v1-0-2fa7075d9970@kernel.org>
 <d79d6baa-7215-a7f3-df35-c802fafb073e@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <d79d6baa-7215-a7f3-df35-c802fafb073e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 08/01/2025 02:49, Mat Martineau wrote:
> On Tue, 7 Jan 2025, Matthieu Baerts (NGI0) wrote:
> 
>> As pointed out by Al Viro and Eric Dumazet in [1], using the 'net'
>> structure via 'current' is not recommended for different reasons:
>>
>> - Inconsistency: getting info from the reader's/writer's netns vs only
>>  from the opener's netns.
>>
>> - current->nsproxy can be NULL in some cases, resulting in an 'Oops'
>>  (null-ptr-deref), e.g. when the current task is exiting, as spotted by
>>  syzbot [1] using acct(2).
>>
>> The 'net' or 'pernet' structure can be obtained from the table->data
>> using container_of().
>>
>> Note that table->data could also be used directly in more places, but
>> that would increase the size of this fix to replace all accesses via
>> 'net'.
>>
>> Patches 2-9 remove access of net via current->nsproxy in sysfs handlers
>> in MPTCP, SCTP and RDS. There are multiple patches to ease the
>> backports.
>>
>> Patch 1 is not directly linked to this, but it is a small fix for MPTCP
>> available_schedulers sysctl knob to explicitly mark it as read-only.
>>
>> Please note that this series does not address Al's comment [2]. In SCTP,
>> some sysctl knobs set other sysfs-exposed variables for the min/max: two
>> processes could then write two linked values at the same time, resulting
>> in new values being outside the new boundaries.
> 
> 
> Thanks Matthieu,
> 
> The mptcp patches (1-3) LGTM:
> 
> Reviewed-by: Mat Martineau <martineau@kernel.org>
> 
> 
> The sctp and rds patches look fine as well.

Thank you for this review!

Patches are now in our tree (fixes for -net) with your RvB tag on the 3
first ones. I will upstream them later on today.

New patches for t/upstream-net and t/upstream:
- 968e9bb5a4cd: mptcp: sysctl: avail sched: remove write access
- eda363130f80: mptcp: sysctl: sched: avoid using current->nsproxy
- c838529f87ee: mptcp: sysctl: blackhole timeout: avoid using
current->nsproxy
- fb1a7a8fb16c: sctp: sysctl: cookie_hmac_alg: avoid using current->nsproxy
- a18c9552dca0: sctp: sysctl: rto_min/max: avoid using current->nsproxy
- 8408f9182e52: sctp: sysctl: auth_enable: avoid using current->nsproxy
- c45cb99c9aa0: sctp: sysctl: udp_port: avoid using current->nsproxy
- 3df3f684ee7e: sctp: sysctl: plpmtud_probe_interval: avoid using
current->nsproxy
- a77b912deb35: rds: sysctl: rds_tcp_{rcv,snd}buf: avoid using
current->nsproxy
- Results: bd3d4b1ab1bc..d66993cd4a59 (export-net)
- Results: ebe8ebeee62e..f289bc80702c (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/6c101bff7e1613c0087472d2ee78c986e221435e/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/0e96d0da96b041f087c5c0b46bc34978572ccffe/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

