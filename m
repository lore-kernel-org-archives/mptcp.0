Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E65320CD6
	for <mptcp@lists.linux.dev>; Thu, 28 Aug 2025 16:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756398466; cv=none; b=Pomo59fB613lUMGm15T5k9Yzzr7nrd5rlQqk1Pr4OzZYDps/X6xkE0yuPiPn10H7VklyY2aCft0QQ1R5cSFdugYdytX/FBjlknmrrGPmja+k+Ir+O6Ck8wfrjhJH34j35daJ5ICqGLL0pPLeVilBCtytOFgBunX9Jp/780yD6qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756398466; c=relaxed/simple;
	bh=LDOGMD07nZoZP/OEJ4Sz7BYQyWHi4vvsvEEV8Dxv5HY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wi2NJEH6uK9WPcsAP6R8A5RetEjOIW8hXDD2MNPoICCwBuPkkZrBb51VDL/uzwjFaTtTtJaQgPaCquExI5ftyCfhamRqoDNot+dGzt9KJGMriV3HHNjf3b5AsaNzl0fRMvlvpckOiH5j77II2qEnAtlE92hIyrnAZgakBZIMgjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ye7lnoZ9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ye7lnoZ9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9688C4CEEB;
	Thu, 28 Aug 2025 16:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756398465;
	bh=LDOGMD07nZoZP/OEJ4Sz7BYQyWHi4vvsvEEV8Dxv5HY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ye7lnoZ9IetoQeKuugThFeHoicBtAX1c2385zeE5etPkekVHNRcnY7fcE/Yh4f7WK
	 YZxavyJzbeQL9Pechfmo1V5GHnvR+JhS97s2O64TJ/bgj3Rz38jcjghvl0VV/J6pSG
	 IPsOeMjM5dNlyRgT2boKM+FEE6Z6HnuLWCTP9c3qqtdqhkJ9z4eW5m2QZSVeNBPVZO
	 o2YHyhMmbU6JNIO6tQY6ICBghvHQemcmwZy8HErf33pFmUI+aHPpwLQSLMHtLDdghX
	 s1zvFiuJIf5KV2ZChetGKQYEvmiWbA9E/gKcZKslRUjuSwbHOxYwn3katSUxWM/sqC
	 9ICl/+EYKYgww==
Message-ID: <43f3ba6e-84d2-4ee8-b4fa-ffe6cc0354c7@kernel.org>
Date: Thu, 28 Aug 2025 18:27:42 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 1/2] mptcp: Add support for SO_MAX_PACING_RATE
Content-Language: en-GB, fr-BE
To: Christoph Paasch <cpaasch@openai.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>
References: <20250802-b4-mptcp_setsockopt-v1-0-50d4905a4c2b@openai.com>
 <20250802-b4-mptcp_setsockopt-v1-1-50d4905a4c2b@openai.com>
 <f15385c8-cbec-4434-9dcb-5a0e71581314@kernel.org>
 <CADg4-L9n4YeoTPU05rsNLqSW3+Q5aY-1xOSburpvi02uHbPQAA@mail.gmail.com>
 <f1882de4-a03f-4955-84cc-3ddd34e430a6@kernel.org>
 <70da4df6-d954-460b-a089-a1171d7b2dd9@kernel.org>
 <CADg4-L9yyiqhGkTSk0m2e5AXSzOuYM4q1-QTTUgUkgxjEW+v_A@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CADg4-L9yyiqhGkTSk0m2e5AXSzOuYM4q1-QTTUgUkgxjEW+v_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Christoph,

On 28/08/2025 18:13, Christoph Paasch wrote:
> On Thu, Aug 28, 2025 at 3:45 AM Matthieu Baerts <matttbe@kernel.org> wrote:
>> On 04/08/2025 19:38, Matthieu Baerts wrote:
>>> On 04/08/2025 19:05, Christoph Paasch wrote:

(...)

>>>> Back to my use-case. I can see why we don't want to use
>>>> SO_MAX_PACING_RATE for that, if that's what we (the community) agree
>>>> on.
>>>> In that case, I guess it needs to be a new MPTCP-specific option ?
>>>
>>> I guess we can support both behaviours: one to limit per MPTCP
>>> connection, and the other one per subflow.
>>>
>>> One would be set via setsockopt(SOL_SOCKET, SO_MAX_PACING_RATE), and the
>>> other one with setsockopt(SOL_MPTCP, XXX). I guess SO_MAX_PACING_RATE
>>> should be for the whole MPTCP connection, no? In this case, I guess we
>>> should not change the behaviour: not doing a limit per subflow when
>>> using SO_MAX_PACING_RATE in some versions, then switching to a limit per
>>> connection, right?
>>>
>>> If so, would it be OK to limit per subflow via something like:
>>>
>>>   setsockopt(SOL_MPTCP, MPTCP_SUBFLOW_MAX_PACING_RATE)
>>>
>>> WDYT?
>>>
>>> Or directly implement SO_MAX_PACING_RATE? :)
>>
>> If that's easier, MPTCP_SUBFLOW_MAX_PACING_RATE (pacing per subflow) can
>> be introduced first, then SO_MAX_PACING_RATE (pacing per connection)
>> when someone has the opportunity to implement it later on. In this case,
>> this series would only need a few adaptations to switch to SOL_MPTCP.
> 
> Yes, I will do that eventually. But right now, other things have
> higher priority for me.

No worries, that's not urgent!
> If you feel like it, feel free to pick these patches up :)

I wish I would have time to pick them up :)
Maybe later!

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

