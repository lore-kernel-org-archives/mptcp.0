Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147C23DDAEB
	for <mptcp@lists.linux.dev>; Thu, 23 Jul 2026 08:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784794412; cv=none; b=MX/FwIZrGVBbuksM01lwuOuKnDvmV5DS576utPE5xFxmsvsk7BCPtJvFNInnLjr0W1hqwxud6Wy0mPoy2ORxyfj5A1Jc/TM14tYasdgphJIHsbWKLu8GxtcfAVYezCahg2Bg4h3vq3dysETcYpEI8d847Dun/7KeqFgGkPdTjKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784794412; c=relaxed/simple;
	bh=N6kp4rTCXZLSoS2zmu/QyRs/7yzaNocasgINH+W1IkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tKKFthLuFLTziaVrhjB1bHE4mxYyuq8au+gHLL388ilkbUMILRjHJR/tucVplGWaAJAXwobC4DneJHGIAQTCVr/mteaXGIW3WFAOuXq1SpzHVteI2EULjeTP0+GgZJIwchAq6Ve7eBf+45NTPKSezdX8wEO+hSFwlaLxN0YjwJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJBjWK3g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJBjWK3g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF8A1F000E9;
	Thu, 23 Jul 2026 08:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784794410;
	bh=KMiMH3BKO8Njrj8uw3LXH716CLlJYP8AgpmzPtH7lgg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=aJBjWK3gTABH06f3Rtb+KzXlji7ophzpRrNQWTHjwyS0iM9fFJPsoiR2TRO/nhgAc
	 sTmMQezAQXg1CigJdMJjYsIpOZWf4VN/VwbeuTF4vQ4nNERcl1iSbuOl+wjT62F/wH
	 6+7LYixuJtavGL8KfnjfwN46je7OzhrlkHElzWlR7AVlM86xsNNyM8tvxwxUJT7MPD
	 GAuW3DtkYWcUjzr+Ga4O3ZZRhynwDh3TFiVKGVfgWI0hcLdlIK9JZkt5tqfILHz5cR
	 oQ66bhbHSmdjhCeZkakR5EfMWb8LT4PpFTt/KcaZuzisl8MA0UZ6iB/evfbVn4DBkE
	 ExO91YBplcVXA==
Message-ID: <be6c654f-f7a2-4eab-95ce-c49889445f6f@kernel.org>
Date: Thu, 23 Jul 2026 10:13:24 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v4] mptcp: pm: fix data race in add_addr timer
 callback
Content-Language: fr
To: luoqing <l1138897701@163.com>
Cc: gang.yan@linux.dev, luoqing@kylinos.cn, mptcp@lists.linux.dev
References: <da4b96a3-c7ba-4444-bc41-96760e5ee08d@kernel.org>
 <20260723032324.189675-1-l1138897701@163.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260723032324.189675-1-l1138897701@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi luoqing,

Thank you for the v4 and the reply.

Please next time do not send a new version as a reply to a previous one,
that's easier with a new thread and a link to the previous one.

On 23/07/2026 05:23, luoqing wrote:
>> How did you find the bug? Do you have a reproducer or is it by analysing
>> the code?
>>
>> Were you assisted by a tool/LLM? If yes, please add the Assisted-by tag.
>
> I discovered this potential issue while studying the new MPTCP path
> manager code. Through code analysis, I noticed that entry->retrans_times
> could be accessed both inside and outside the pm.lock, which appeared to
> create a race condition with mptcp_pm_announced_del_timer().
> Unfortunately, I don’t have a reproducer for this issue at the moment,
> as it’s difficult to construct a test scenario that reliably triggers
> this specific race condition. I submitted the patch based on code
> analysis to prevent potential issues.

To help categorise data race issues, these questions should be ideally
answered in the commit message:

- Is it a potential issue (i.e. code analysis but never reproduced), or
do we have a proof it can happen (i.e. KCSAN trace)

- If there is a proof, is it easy to reproduce? Is there a reliable
reproducer?

- Could this issue cause damages?

With the increase number of issues reported by AI, potential issues
without proofs might not need to be fixed, especially if it introduces a
higher complexity. Having a reproducer or at least a calltrace would
really help not to waste time on potentially unreproducible bug spot by
AI. But AI could also help to find a reproducer (ideally using packetdrill).

> I used AI tools to help verify and
> analyze the code logic during my investigation. However, I’m not
> entirely certain about the extent to which I should acknowledge this
> assistance, so I didn’t add an Assisted-by tag in the current version.
> If you think it’s necessary, I’d be happy to add it.

OK, thank you for the explanation. There are ongoing discussions [1] to
use this tag like this:

  Assisted-by: LLM # find issue, code, review, test

In your case, it would be this I suppose:

  Assisted-by: LLM # review

[1] https://lore.kernel.org/ksummit/87wluv7yzc.fsf@trenco.lwn.net/

But that's still under discussions. In the meantime, it would help if
you write this with word in the commit message, e.g.

  I discovered this potential issue while studying the code. AI tools
  helped me to verify the issue can potentially happen.

(no need to send a v5, I will apply the v4)

>> For legal reasons, you are supposed to put your full name. Having only
>> one "word" for your full name, without capital letters looks wrong, no?
> I apologize for the confusion. “Luoqing” is actually my full name in
> Chinese convention - “Luo” (罗) is my family name and “Qing” (庆) is my
> given name. In Chinese, we don’t typically capitalize individual
> characters or add spaces between them. However, I understand the concern
> about the formatting, and I’ve updated the Signed-off-by to “Qing Luo
> luoqing@kylinos.cn” to follow the Western name order convention, which I
> hope is more appropriate.

Thank you for the explanation! I understand that conventions are
different. I was asking because usually the "Western name order
convention" is used, and the full name is required, not a nickname. To
avoid confusions, even if I'm not a big fan of force people using a
different convention, I think it is easier with the Western form, if
that's OK for you.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

