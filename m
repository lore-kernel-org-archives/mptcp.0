Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E896377555
	for <mptcp@lists.linux.dev>; Fri, 28 Aug 2026 09:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787908469; cv=none; b=pxZK82oIF1OvKbaFej0zhtjyIrcO7ahwFf6kKK+XslMJAEZhYR56y+F2bhSPYPaN/MeenIv0CfPtFHaI2FQm8Maks2cJopVw2y3DdWm+5nHRo8YTEAdsu+GfX8Yh+0JxoN6ck7gzsXbTtDaLCsn91GaAnEeKMiXr9i3Vnht9Des=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787908469; c=relaxed/simple;
	bh=ahQsN5JrEdQ1KmKOXaQ9VTAnLsOH6U7bIAVnNmPgrv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AP9aDfRPiRng1GIFWeHWxp9rljisYBfYYOim0cTmNjFjEa7v+NfODWeRPBXs77miwNzTG6xBRaINPWxX3/E5p4w8XBt3+i2MN0cjN90o8uZJtjbL3KLSho5fjvuu9j4ZMHEdCnYar9kGH4E9dsUDFZEaUOth7NZr0wzEMZ6zNsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iddRhJ4l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iddRhJ4l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6AB61F000E9;
	Fri, 28 Aug 2026 09:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787908467;
	bh=Lc8CQjxdnDK0VttkKdh5VUBLqQbLXWvp7ZZa4U2Nz6E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=iddRhJ4lu1NUxOZ5rlmtoLpMSEqRabMPnx5k1jSImao1DTr9rTNl2h9PfWdyVmgcI
	 MV42wjNLP6EHTkvv/qsRGPBt27NAFw1s5M8fUDzpofINR9FY5GfKDu0lbxXRkvR9kp
	 kb4jw5v3okv5O7X+zoNZC0h7K7bj0k3R0svgOpYvAxxDEd5B9K3QPeVf7QZcTfKbGG
	 BSuLJ+2d+sPCZ9Dp9Da+p3g0kQ37lDLRwX0kuLBl+IKgAYdI2b6ZX5QqoG+ReN0T5y
	 GzLVCclOgs8XQFzW/AqYPwVYmygjPetJU7pj+iC3S6woNeNUlTWPscPZh4Z/yc2yuF
	 9xv8CP3Wfm3bQ==
Message-ID: <9de4df76-3ee2-45c4-b0f5-1afa968c098c@kernel.org>
Date: Fri, 28 Aug 2026 11:14:24 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next 01/11] mptcp: pm: add WARN_ON_ONCE guards on
 extra_subflows underflow
Content-Language: fr
To: Tao Cui <cui.tao@linux.dev>
Cc: cuitao@kylinos.cn, geliang@kernel.org, mptcp@lists.linux.dev
References: <5eeb6f1e-3444-4737-a310-dfc0b6b644cd@kernel.org>
 <20260828083352.292492-1-cui.tao@linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260828083352.292492-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Tao,

On 28/08/2026 10:33, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> Hi Matt,
> 
>> On 22/05/2026 10:50, Tao Cui wrote:
>>> extra_subflows is a u8 counter that can underflow if a decrement races
>>> with or precedes an increment. While the recently fixed userspace PM
>>> subflow creation path eliminated the primary cause, add defensive
>>> WARN_ON_ONCE guards at both decrement sites to catch any remaining edge
>>> cases rather than silently wrapping to 255.
>>
>> FYI, Clashiko found some existing issues linked to this patch:
>>
>> https://github.com/multipath-tcp/mptcp_net-next/issues/629
>>
>> I don't know if it impacts your case, but just to avoid having multiple
>> people looking at it, do you plan to address Clashiko's comments?
> 
> Thanks for the pointer, I had missed that issue.
> 
> I had another look and yes, I'll take care of it. Both findings look
> real to me:
> 
> The disconnect() race is the nasty one. The MP_JOIN softirq bumps the
> counter under pm->lock and defers the subflow to the join list, then
> mptcp_pm_data_reset() zeroes it with only the socket lock held, and
> the subflow gets closed later at release_sock() time when the join
> list is flushed. So we hit the new warn with the counter already at 0.
> With panic_on_warn that's a remotely triggerable panic, which is
> arguably worse than the silent wrap we had before.
> 
> The unbounded increment on the userspace PM side is pre-existing, but
> now the wrap also lands on the warn instead of just corrupting
> mptcpi_subflows_total.
> 
> I don't think we want to keep WARN_ON_ONCE() on paths we know are
> reachable. My plan for a fix series:
> 
> - refuse new MP_JOINs on the userspace PM once extra_subflows is at
>   U8_MAX, so the counter can't wrap anymore
> - sort out the accounting across disconnect (reset vs join list
>   drain) and downgrade the warn to a clamp, maybe with a
>   pr_warn_ratelimited() to keep some trace of it
> 
> I'll follow up in the issue once I have patches. No strong opinion
> between clamping and refusing admission at the limit, happy to go
> with whatever you prefer.
Thank you for having checked and looking at fixes!

Note that for the disconnect part, maybe other variables could be
checked before looking at decrementing the PM counters? e.g. the msk
state? Would that work?

Note that I think we would prefer a pr_warn_ratelimited over a complex
fix involving more locks.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

