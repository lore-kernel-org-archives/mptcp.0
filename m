Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB22627A91D
	for <mptcp@lists.linux.dev>; Fri, 11 Jul 2025 16:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752250492; cv=none; b=TvljE2SuFVl0uYSmCKYLQfk3UizNTLloz7lPnLJsPx8MOHbguzKiJPg/7irZL311+kQfq4t2tRZptRoq03tBPWht+QhAOtIeaq12FoJ2CwWgDCiurSdP2sxcoRDGLNMEy0v8BJmIsXJDY7L2ws60WkGaNN63J9oxrc3WEgbl3+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752250492; c=relaxed/simple;
	bh=AqW1TSM8EuzJ00LNNv8hcxROlVRoaqeH3g64MiPi/cQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=n0aWPG5rloyVZoluIRZxEo/1ebrN8GnzLCBKfO9MpeNjc+3oNxu78GlGKqt9MyB6ocR1jfRwv3K4Nq9wDo0b0xFsMXRroMR4R8f06lv9VjgtuTM6flXBEnFVhfUf2TjPWcjRCTkMLlkvn5R4hPKB3MRGlFsGwBUgQQQAA7X73iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZyoBnOY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZyoBnOY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1DDDC4CEED;
	Fri, 11 Jul 2025 16:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752250492;
	bh=AqW1TSM8EuzJ00LNNv8hcxROlVRoaqeH3g64MiPi/cQ=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=JZyoBnOYczzywHtxL+TtJg3CQJThsCLoYiprVM6UXHpciLiq4znWCTozoZnqlWjMH
	 DKCddoBS4VCyqDVwkhlk/vfL1Du/Y/VrvoBBV68o1OdmLyIdsoPtpOfvmR6on2Wjbm
	 5W0W0cS1U/kiusRmCW/HuZ3AiDBph1LkLuZwJS9lJevVN/iTcxrXMYdX9nqMN8qkPM
	 hfDRKwF6BIp4I0cxwcp2Rwkd8+rNdNcma045A4JE7pOEwT0C42g/7lxwisWbTBAPaP
	 TCFbj9ySPSXahwFBRGfYoqIXFCec8Pqh5gwcFxboC+gqMgL7P63zq7VpdxiM5iU/j4
	 5QrNzFO4XsFFA==
Message-ID: <cc5c284a-dc08-46d2-85db-cb5a5b12395d@kernel.org>
Date: Fri, 11 Jul 2025 18:14:49 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v4 mptcp-net 0/5] mptcp: fix fallback-related races
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1752221786.git.pabeni@redhat.com>
 <697f6cb1-1783-4b1c-8d76-75aad0faf8b2@kernel.org>
 <5364ad7f-a7b3-4244-bfc9-00fb3ff2e67a@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Content-Language: en-GB, fr-BE
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <5364ad7f-a7b3-4244-bfc9-00fb3ff2e67a@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 11/07/2025 15:51, Paolo Abeni wrote:
> On 7/11/25 11:36 AM, Matthieu Baerts wrote:
>> On 11/07/2025 11:29, Paolo Abeni wrote:
>>> This series contains 3 fixes somewhat related to various races we have
>>> while handling fallback and 2 small follow-up likely more suited for
>>> net-next.
>>>
>>> The root cause of the issues addressed here is that the check for
>>> "we can fallback to tcp now" and the related action are not atomic. That
>>> also applies to fallback due to MP_FAIL - where the window race is even
>>> wider.
>>>
>>> Address the issue introducing an additional spinlock to bundle together
>>> all the relevant events, as per patch 1 and 2.
>>>
>>> Note that mptcp_disconnect() unconditionally
>>> clears the fallback status (zeroing msk->flags) but don't tuch the
>>> `allows_infinite_fallback` flag. Such issue is addressed in patch 3.
>>>
>>> Patch 4 cleans up a bit the fallback code, introducing specific MIB for
>>> each FB reason, and patch 5 drops the, hopefully now redundant
>>> pr_fallback().
>>> ---
>>> v3 -> v4:
>>>  - fic MIB exposed names
>>
>> Thank you for the new version, it looks good to me!
>>
>> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> Thank you!
> 
>> I can apply this series, restart syzkaller on top of it, and send
>> patches 1-3 on Monday if everything is OK. WDYT?
> 
> I would wait a little more for syzkaller. The underlying issue is not
> very recent and the fix is not that invasive, I guess it's not a tragedy
> if it reaches Linus' tree the following week.
> 
> But no strong opinion either ways.

Sure, I can wait, but it was just to be able to flush the new MIB
counters in next before the new release :)

Note that syzkaller was validating your previous versions since Monday,
not only from today then :)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

