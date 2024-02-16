Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F10137C4A
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 19:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708113543; cv=none; b=Pf9+fStG73AgzH7u3RC2ZgcMSn1mpSKIdfZK3uoDA54tOo+lfJMB3voEF3Ckk8zJze3FZts5j8iNYHDVSzjJpG3twQqjnhvi8ztZmNn2q+YoYsJ9JRcjk3MYqNxrHWkEeHngnhe8SJK4BHkuXSt009r+ecxHBH5VUKAzGJW8eSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708113543; c=relaxed/simple;
	bh=FN/N3DMD1eM9Bv5g/B9TwuqSytD65ksGcd0xMEnq4Lo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BtMtM5WRwlF9qEtrgkkI5KG1oi7VznfaSaScU7eLacIqarTx4lh9DX/QQ7qNZPE4HqnhlE7JdAlz5K1aAMprFpPkupX4s27s0qX3Q+qBUCs4by0d7pEZ9JgkQv8pDzsS/1r7DP5y//xA4Ne4StCqf0mv/LlCWb219fxQGjwQ5bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkmYL7BS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkmYL7BS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2406FC433F1;
	Fri, 16 Feb 2024 19:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708113543;
	bh=FN/N3DMD1eM9Bv5g/B9TwuqSytD65ksGcd0xMEnq4Lo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=BkmYL7BS6MuseRUbYPgrhBW4FgjAuLRHNIezusVMJ+cWH/bm1Cv4MC0cV8V5Ch65Q
	 e7vwznQCjyoFc6wD+goUATNGKS41EHhtw7kqkvCNR0r7vcNt0zbNL/oUyH0qfc2jat
	 E4N3aQ5UiFoB9qhqBID6/MK0LcyaUz9oMraBxLPIReXaJ2YpHmeBPaMiUf7H9xQp2G
	 flxyOB5foV+QRQSq+3WiI0JbhF82/mrXakpT6zKAhLvX6B2a0/ZjCKINYVrkmw7UiK
	 AMVaWM+Dcrcgl6mzobUgPHcZDt3Y1BPitNBKBFnsoZQg6Lkz86DTyGaFYTdvPIsgdG
	 +djb0W1FLMtCg==
Date: Fri, 16 Feb 2024 11:59:02 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net] mptcp: avoid printing warning once on client
 side
In-Reply-To: <59625ef0-1f81-4660-b585-2e9a9ac4a8c6@kernel.org>
Message-ID: <bc35a839-0353-abd3-cb51-2d48228f4078@kernel.org>
References: <20240215-mptcp-fix-bogus-pr-warn-v1-1-d14c10312820@kernel.org> <9502e96c-8a72-a6d4-ca2d-1c75c536bfa3@kernel.org> <6b9c4a3e-3c30-4e7b-ab99-ed2e34e24015@kernel.org> <e7769e4c030b06c8ea4b14857a22eafeb9c93277.camel@redhat.com>
 <59625ef0-1f81-4660-b585-2e9a9ac4a8c6@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1586149649-1708113543=:68485"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1586149649-1708113543=:68485
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 16 Feb 2024, Matthieu Baerts wrote:

> Hi Paolo,
>
> Thank you for your reply!
>
> On 16/02/2024 12:23, Paolo Abeni wrote:
>> On Fri, 2024-02-16 at 11:42 +0100, Matthieu Baerts wrote:
>>> On 16/02/2024 00:25, Mat Martineau wrote:
>>>> On Thu, 15 Feb 2024, Matthieu Baerts (NGI0) wrote:
>
> (...)
>
>>>>> Notes:
>>>>> - Should we convert this pr_warn_once() to a WARN_ONCE()? Or just in
>>>>>   our tree? Or just in DEBUG mode?
>>>>
>>>> I think it makes sense to keep this patch minimal for -net and stable
>>>> (just moving the label).
>>>>
>>>> Also given the consequences of panic_on_warn, would be better to make
>>>> any changes to WARN_ONCE() in mptcp-next/net-next. I don't see extra
>>>> complexity to modify this warning in our tree or debug mode as being
>>>> worth it, do you think it would be valuable?
>>>
>>> Sorry, I'm a bit confused by your reply. For the moment, our CI
>>> complains when a "Call Trace:" is printed, but it doesn't complain when
>>> there is a pr_warn().
>>>

Ok, I didn't realize our CI ignored pr_warn() output so didn't really see 
the motivation for switching to the WARN() macro - but did want to make 
sure (at a minimum) that you weren't proposing WARN() for a -net patch.

>>> If the warning here can be caused by interactions with a buggy host, it
>>> makes sense not to have a WARN() when used in production, but it would
>>> be good for our CI can catch that. If the warning can only be caused by
>>> an internal bug, then easier to use a WARN_ONCE().

This makes sense - I agree it's better for CI to catch it.

>>
>> We can trigger the warning due to either:
>> * local S/W bug
>> * bugged/malicious peer.
>>
>> I think we should avoid a WARN there.
>>
>>> So I think here, we could maybe convert it to a DEBUG_NET_WARN_ON_ONCE()
>>> and upstream that. WDYT?
>>
>> DEBUG_NET is quite lightweight and could be enabled even in production,
>
> Ah OK, I didn't know that!
>
>> that should be an export-branch only change.
>

+1

> Fine by me! I appreciate your suggestion.
>

Thanks Paolo and Matthieu


- Mat
--0-1586149649-1708113543=:68485--
