Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A9B1B6CEF
	for <mptcp@lists.linux.dev>; Mon,  4 Nov 2024 12:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730722078; cv=none; b=hgYB9Ett+7E+b06/RAgfGTKepBA5SW1v3KeANHu/eJDA5SCJX/oYqnAjsgl6uT7EDlU7CDXEQBB+sootw44fBKBP4XgJKfE3KhlHC8qWnxvZfsB3HalDMZ+95ZeMheUUuz+bjIjh/WoEdzPeqSgbFaWoo5rz8OYTRYzRNGH+AY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730722078; c=relaxed/simple;
	bh=RI6yt7x8NAUXiYY2zxis4l26rO8FUYVCd3GMXnVPl9M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=tbyRoVQBftLdz1EuZFBq6nLM7xDepcjTbRP9ydOXzm34zs+Z7iDW+o2aw2WyCH/aNpEGZmdUsFyLEwWl6NJpsHqQzpAnoDYQVrOX44NzPV3bPpxnqjvkhQJdaKiaxA6m5UOe0c+j4y1LPiEuLLfDGeFhwF5zk6wWKzmiuJMMGG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s2RZKEKT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s2RZKEKT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13446C4CECE;
	Mon,  4 Nov 2024 12:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730722078;
	bh=RI6yt7x8NAUXiYY2zxis4l26rO8FUYVCd3GMXnVPl9M=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=s2RZKEKT5mUzagY5MWwVDHizPtsWCWj4IvQ6k1RQ7JOkwO4F24jaV5wbKZxSNNpII
	 J4yU0l3VULZX6jZ/eoyQ9Fkv9+08GVTYsGj37nMdLUODd0/zfAQpO2miS1Khg/awqz
	 TuySlAGZ+MsfSToAA088vDDofBJt4x2RQlfLcTsAeHeqpNO9C7wSUUEJWUxmb3LP6U
	 VE0Yisg+kTOaTmi4jd4eQtm6LuYehV5CBmtrHmR2bm2iOy1TsvTnCWIIcLigKx3AyD
	 ml1lKrcBEf1Tc88IMluUBSEGi6EFfRDR92cmAhYmra9OWlTjB7GUxB3hDNEev3tDJ7
	 oVAc81PqNmR/w==
Message-ID: <21137b33-9b79-403a-8032-6aec174e91f2@kernel.org>
Date: Mon, 4 Nov 2024 13:07:56 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next] Squash to "DO-NOT-MERGE: mptcp: improve code
 coverage for CI"
Content-Language: en-GB
From: Matthieu Baerts <matttbe@kernel.org>
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
References: <ab62e7d2f50512594416acb973dcaf3d4ec85fe3.1730708911.git.geliang@kernel.org>
 <26b229f0-9b4d-43ca-b06d-0d2ff1271c6c@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <26b229f0-9b4d-43ca-b06d-0d2ff1271c6c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/11/2024 12:58, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 04/11/2024 09:28, Geliang Tang wrote:
>> When our bpf_selftests are re-built, this error occurs:
>>
>>  make[1]: *** No rule to make target 'atomics.lskel.h',
>> 			needed by '.../atomics.test.o'.  Stop.
>>  make[1]: *** Waiting for unfinished jobs....
>>  make[1]: Leaving directory 'tools/testing/selftests/bpf'
>>  make: *** [Makefile:259: install] Error 2
>>  make: Leaving directory 'tools/testing/selftests'
> 
> Ah yes, I already noticed that when checking some stuffs, but I didn't
> investigate. Thank you for having looked at this!
> 
>> In this case, I had to remove the cache directory .virtme and recompile it
>> again. This was very time-consuming.
> 
> You don't need to remove the whole ".virtme" directory, you can remove
> ".virtme/build*" instead, so you still have CCache (from ".virtme/ccache*").
> 
>> A workaround patch for this is found in [1]. I don't know why this patch
>> has not been upstreamed, but it's in BPF CI environment. I think it's
>> necessary to synchronize this modification to MPTCP CI environment as well.
> 
> It looks like another version has been applied in bpf-next, even if it
> is a fix:
> 
>   https://lore.kernel.org/bpf/20240916195919.1872371-2-ihor.solodrai@pm.me/
> 
> Do you mind checking it please?

Just in case, their bpf-next/master branch has been rewritten in
between. The last ref I have is:

  fd4a0e67838c ("selftests/bpf: Set vpath in Makefile to search for skels")

> If it works, I can backport it to our tree, and ask BPF maintainers if
> they can add these two patches in 'bpf' (fix) instead, because this
> issue is present in v6.12, but only fixed in next (v6.13).
> 
> Cheers,
> Matt

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

