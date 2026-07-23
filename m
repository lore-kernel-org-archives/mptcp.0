Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2250A369D66
	for <mptcp@lists.linux.dev>; Thu, 23 Jul 2026 18:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784829852; cv=none; b=eBSyZ06tAU1MNw27c/ceqIwwvNV7AZQN8lnZg3S0meHaqKMVAvAACqui1xFvGc5jqi8PlOaMcCQy8BWLRP+mNBzmxfEfVSxNjmxIgBgpuPq9fB7oiebcc0P6iiUVQYVhPhZhucVz1X0wnyxTH7wlbwR/r1ZXn0coByOhlR00E+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784829852; c=relaxed/simple;
	bh=va8W/YHh72OusciHFtJLnCLlMJ+yEZhtuuz2wj07DUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MCHBjCif03CjIbGYZZ8DAx2bBfybbPlcCbdpGQYn7a9GgSypV7Sc1nYFZK6BZGbLucpHN1e28koWLSf1yasR20gzFo0yDMAS0q4ZquQ3UvqCLLJP+GFQbstOthtKNnGa/dvd52EknOQvRsN+bZrimp9J55FUyZPSSS4WkjtNXj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=doMhaV/z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="doMhaV/z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E6D21F00A3A;
	Thu, 23 Jul 2026 18:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784829850;
	bh=1cS2dMurDuJGgZZl/9hgk9OJEsMy55iW0fwu/6QW5wM=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=doMhaV/zx372G1rEquuXe2O0unSw/8W5QRTx0SugzIHoKjeS2lFA7j1DyEeD0JndZ
	 BDd5m2QtmdUf3SojSR8QHit52wZ+/C6MO8Pdg9dR2R3Jx40LH6bwvULkaTtim/UoPP
	 tEobUkxweiUh1uEieUV8Mp0RRai0jb7HD2mX+kOaU0o+gBT12zwfmUl5/Rxal6qtyU
	 +0Gxut3mJY+8GjoLpRAIzEc9tns16ev6/r4OFkAnAZ9aslPIqvmy1kY8F6KLxCl+9t
	 qG1aUwjC5oUocbxfMwk22Pc8fuaWZ+wzhwAL6wlpfjgScc92bySyuB1BUjOsTC17h2
	 ONZAprIJsgS3A==
Message-ID: <8f4377ab-8b22-4f68-9b51-7f18e07a319f@kernel.org>
Date: Thu, 23 Jul 2026 20:04:08 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v5 0/3] only remove entry from local_addr_list
 when sending a REMOVE_ADDR
Content-Language: fr
To: gang.yan@linux.dev, mptcp@lists.linux.dev
References: <cover.1782457962.git.tanggeliang@kylinos.cn>
 <74f86b7879f96bd71d989e4323750c4bf77627c5@linux.dev>
 <0bdfd823d64a18b9c9230d176082289418d25a4a@linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <0bdfd823d64a18b9c9230d176082289418d25a4a@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Gang,

Sorry for the delay.

On 26/06/2026 12:24, gang.yan@linux.dev wrote:
>>
>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>  
>>  v5:
>>  - rebased.
>>  - add Matt's reviewed tags.
>>  - add a RM_ADDR from the server to the client as Sashiko suggested.
>>  - mptcpd tests (make check) are still OK after this modification.
>>
> Hi Matt,
> 
> Sorry for the off-list email before, I forget to cc the mptcp@lists.linux.dev
> 
> First, no offense intended — this is in no way a comment on this patch. 
> The patch itself looks good to me. I'm replying here only because the
> thought came up while reading it.
> 
> While looking at mptcpd recently, I noticed that 'make check' doesn't
> seem to exercise the userspace PM logic in a meaningful way. The
> userspace PM cases in test-commands issue the per-connection (mptcpd_pm_*)
> calls with a fake token that doesn't correspond to any real MPTCP connection,
> so they only really verify that the command dispatches and the genl request
> is sent without crashing.
> 
> This made me wonder whether it would be worthwhile to add functional tests
> for mptcpd within the selftest framework — for example, via a dedicated script
> (something like selftest_mptcpd.sh) that actually starts mptcpd with specific
> plugins (e.g., sspi) in a namespace/veth environment, and then asserts the
> expected path-manager behavior end-to-end.
> 
> In other words, I'm asking: does the community think mptcpd's userspace PM
> functionality deserves similar test coverage within selftest?

Good point. What about the opposite: adding such tests in mptcpd directly?

When mptcpd started to support the userspace PM, it was not easy to
access to a kernel with such support: either the old MPTCP fork, or a
v5.19 upstream kernel. The mptcpd project was and is still using GitHub
Actions for the CI. A few years ago, I suppose it was not planned to
build a kernel, start a VM and execute some tests on mptcpd side.

The situation is different now: tests are running on images using either
a v6.8 or a v6.17 base kernel:


https://github.com/actions/runner-images/blob/main/images/ubuntu/Ubuntu2204-Readme.md

https://github.com/actions/runner-images/blob/main/images/ubuntu/Ubuntu2404-Readme.md

I think that would be better to add such tests there, rather than adding
a dependence to mptcpd in the selftests where it sounds better to use
pm_nl_ctl to validate the userspace PM.

WDYT?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

