Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D7C82D99
	for <mptcp@lists.linux.dev>; Tue, 30 Jan 2024 15:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706629853; cv=none; b=s7fhLgVSkM6BYsffVD1Fvngh1Szh9xENYEPQYXk1axtP939XEBITuc79opEJ1tAvGvA00cTdBoBbPRdRVLqYmTiJMbcMa1i35kJ17LLmLuJ+uMmgG8tR6+lYPwnHEFWsOyMEuVLioGiLr53DB9Hm0qA53cBnr1fdN43NpsCW7Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706629853; c=relaxed/simple;
	bh=hw8JAtVdmGwf69zwFgkX0F5JcVc/khkbGMIANx3Vfdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=inD+F2VgtH+53mahzkgp60Yl3AmJSv2R6CtYiwn8cmwi5ZVNjAL04CnFyVy+kTmo8NKOVqBppYhiutdmcJTkqeCVxnQefRrYVR21iRsn9NMxpvMTesszdER/aTi7xtaqejsOq4P+ddteWN9QDWc8ew8sXNT5qYwYJDF9kfLkWIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=buW2QAPs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="buW2QAPs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F25DCC433C7;
	Tue, 30 Jan 2024 15:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706629853;
	bh=hw8JAtVdmGwf69zwFgkX0F5JcVc/khkbGMIANx3Vfdc=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=buW2QAPs9W8PHWoFuuM38NzWfszXKdLITxRNIsGb/caZ1/fcUxN3H/h740JgtI+Iz
	 FiKsw4DO6eCJJzHxzRqoffGkLxvIbiaoPfkFVcCE6kIXLnGm6qxVi8HIc1DdOGOmui
	 1hsAHNLUkUlrvV6SiklSdIkDLhjJshT5SbpTC9gwLZQCpwtDPUlaCdaBggYyw4y58u
	 WbyfxSP3QQVIG0rUp6BdT4oqezpJ6Gu117no6+XC5xocPhHBvwgPSy9sYKMaAfsYln
	 UbAlenNfjDQ+c83rUDCPCY78hEaKb+wuW6kYdlT3KRKhkBXlmIo2h6mj5kiDZm3QfU
	 nSRE6MGqD/VqQ==
Message-ID: <a201bd1f-8c67-4196-bc71-4e08ab60d1db@kernel.org>
Date: Tue, 30 Jan 2024 16:50:46 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH virtme-docker 2/3] upgrade to ubuntu 23.10
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
References: <cover.1706422466.git.geliang@kernel.org>
 <dc2e14b63fd7ec288e015124919c28c9470d5913.1706422466.git.geliang@kernel.org>
 <ZbhHy6GPo4UcCKy0@t480>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <ZbhHy6GPo4UcCKy0@t480>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 30/01/2024 01:50, Geliang Tang wrote:
> On Sun, Jan 28, 2024 at 02:16:02PM +0800, Geliang Tang wrote:
>> There will be many build errors when comliling bpf selftests under
>> Ubuntu 22.04. Upgrade to 23.10 to use the new versions of gcc, clang
>> and LLVM.
>>
>> Fix sparse build errors for llvm-16. This part alse be sent to sparse
>> upstream. It can be dropped from this patch when accepted.
> 
> This part has been upstreamed, we can drop it now from this patch.

Thank you for the patches and this note, I didn't see it has been fixed
upstream.

I didn't know you needed to upgrade to Ubuntu 23.10. I did something
similar for your two first patches last week when looking at the issue
471 [1] to switch to a more recent version of QEmu, but I didn't push my
changes. I hope you don't mind if I apply my modifications (with your
co-dev tag) where I use new versions of the dependences instead of
patching them.

I will look at the patch 3/3 (v2). I will need to modify it slightly I
think not to have the current CI failing. I can also look at modifying
the current CI job to validate this BPF test. I will probably need more
conditions to be able to run on older kernels as well. I will push that
after having done some tests, not to have regressions for the tests we
are currently validating.

[1] https://github.com/multipath-tcp/mptcp_net-next/issues/471

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
