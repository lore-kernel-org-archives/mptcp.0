Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16185374A1B
	for <mptcp@lists.linux.dev>; Fri, 24 Jul 2026 10:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784887267; cv=none; b=Dadbu7bo4TV+/0yaajeiWDbFHSMi9aKrIvR7oDzH+Hv+agGvzmME0QYsMalGqEqx7a5/pl6IVmHxi3INIy/y08W6AOT4hwsDjab0rUYKObZKFnleKdYDt8yTZaQ++Ja9CIlwj5izEWH75gfIFFXTr7enWdxJ4PjQ2DSwyQCsga0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784887267; c=relaxed/simple;
	bh=oZn7Zut0x51xpQG2STLEG1+uEzH/AdWEnYPlC2FMA/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i6QVa5/5OTwCpGkQUNPcmYtgCLZnjY0QLOH4I+VZ1zGCItw3PyaM0/laxHGQsV/VGgpSYykrCIkdmP7+i5Zwqvc7fYdILFUJ817nBBr5p+y0V+01mAqGX3MuqJkHxSCvanXcV8NKxI7A99XhWYXQsOquiGPVGc+dNf52Evvvk+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlWwVsWq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlWwVsWq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 106C61F000E9;
	Fri, 24 Jul 2026 10:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784887265;
	bh=g/Zah8TyBMSNPhw2HEvyWEi6xDDjzg/GsB/Vf+6Ynh8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WlWwVsWqSYXU+5orIyZma9we0nYqHNVHEwljS5MtxOYXbaBf579q7N96/6WLUVTJU
	 xV35ISGdxUJScpGlQgXFaso/q7fZSH099t0BVOgiDX5XLe/tHNPLjaY1VKqd/g5Yc9
	 ZyWZH+pCIpBVEC4c1BkWzfhshcG/ogqhzgRPLboZR3c+y2iyZM1Y7KxRadu1ivJqow
	 SsukPiO+foCHoH3wSdQFgQeUey85LfFhfzANSo6EZekRtlvv3OxOpOiPqOgUI0HI/w
	 gBQgJJOJ1+P0M9wVxWv30Fka832BmfamO+VzQd0hZnFiDAs/l2VoR2uqphPb/2D8Zq
	 KsnNmSXVcUeQw==
Message-ID: <8fc9a0f3-76fe-489f-ba0b-9cf626a9c02f@kernel.org>
Date: Fri, 24 Jul 2026 12:01:03 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 2/2] selftests: mptcp: simult_flows: set EXIT
 trap earlier
Content-Language: fr
To: gang.yan@linux.dev, mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
References: <20260724065229.36736-1-gang.yan@linux.dev>
 <20260724065229.36736-3-gang.yan@linux.dev>
 <c6091b33-77ec-4bda-abcd-e40554f33e71@kernel.org>
 <7db78ad766d61c6bbc877acdecc7f6654d1e6582@linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <7db78ad766d61c6bbc877acdecc7f6654d1e6582@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/07/2026 11:52, gang.yan@linux.dev wrote:
> July 24, 2026 at 5:27 PM, "Matthieu Baerts" <matttbe@kernel.org mailto:matttbe@kernel.org?to=%22Matthieu%20Baerts%22%20%3Cmatttbe%40kernel.org%3E > wrote:
> 
> 
>>
>> Hi Gang,
>>
>> On 24/07/2026 08:52, Gang Yan wrote:
>>
>>>
>>> From: Gang Yan <yangang@kylinos.cn>
>>>  
>>>  Set the EXIT trap for cleanup immediately after creating the temporary
>>>  file variables, before the dd commands that fill them and the namespace
>>>  init, to ensure cleanup runs on any failure or interruption during the
>>>  early setup phase. If either dd fails (e.g. ENOSPC), the temp files
>>>  already created are not cleaned up.
>>>
>> From what I see, if one of the 'dd' command fails, the errors are simply
>> ignored.
>>
>>>
>>> Assisted-by: Codex: GLM-5.2
>>>  Signed-off-by: Gang Yan <yangang@kylinos.cn>
>>>  ---
>>>  tools/testing/selftests/net/mptcp/simult_flows.sh | 3 +--
>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>  
>>>  diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
>>>  index 3ea3d1efe32e..b40dea5f9b30 100755
>>>  --- a/tools/testing/selftests/net/mptcp/simult_flows.sh
>>>  +++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
>>>  @@ -62,13 +62,12 @@ setup()
>>>  sout=$(mktemp)
>>>  cout=$(mktemp)
>>>  capout=$(mktemp)
>>>  + trap cleanup EXIT
>>>  size=$((2 * 2048 * 4096))
>>>  
>>>  dd if=/dev/zero of=$small bs=4096 count=20 >/dev/null 2>&1
>>>  dd if=/dev/zero of=$large bs=4096 count=$((size / 4096)) >/dev/null 2>&1
>>>
>> This 'fix' is only interesting when the script is abort while one of the
>> dd command is in progress, to create files of 80k and 16M in RAM. I
>> guess this is very unlikely, no?
> 
> Hi Matt,
> 
> This change was suggested by AI, referencing commit c8da80af2838 ("selftests: mptcp:
> sockopt: set EXIT trap earlier").

This commit caused some issues when upstreaming it, and that's one of
the reasons why I reacted here.

Still, this other one was more likely, because the netns init can be
slow on debug kernels.

> I agree the problematic case is unlikely to hit in practice. My main motivation is
> to keep the selftest scripts consistent.
> 
> If left unfixed, someone might spot this later and send another similar patch,
> bringing extra review overhead in the future.
> 
> But I am still okay dropping this patch.
At Netconf, there were discussions suggesting not to take fixes for
issues that cannot be reproduced. I agree that here, it is small
possible to have the issue, but that's in the selftests and harmless.
Because of that, I think it is best to avoid such patches, as there are
already too much traffic on netdev, and little time to review more
important fixes and features. So if that's OK for you, let's drop it.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

