Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E536123F429
	for <mptcp@lists.linux.dev>; Thu, 23 Oct 2025 15:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761234862; cv=none; b=jaF9sW+njRAw9MNEdW59GL0v15pSOWtPNvGtAY69yoytjO6QRtpcVof6kvEXC1iYyeEuI65/Xd3pBKWum6EjtHEMuzWF9Afg4xBBBpFNCw8cpz5ZtbLqvXiP2AYkolFhAWTIvBtgIJQNphMCWny1xbLRw935cXfx2PZ+E0F++r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761234862; c=relaxed/simple;
	bh=sl6OFuJVdaKig92xnltiAlleV8Qv0ZnqCfyZuedY3/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W9Zv/DIsFLqFkSdCWuSeAZOoojljzKL0Dc8yv5wqlUe4oDg7KPjBddoi1I4+XW/MarJnAuFLZqB4GNLZQeuZiteiifUmdywOM7g1ksowVcgf4X07BFXYiBQnpU1jY1U52Lu8grLJer8nPgwDTJt90jNF6nTFN652s9JIxVxQKQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IzQ08HJC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IzQ08HJC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61205C4CEFF;
	Thu, 23 Oct 2025 15:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761234861;
	bh=sl6OFuJVdaKig92xnltiAlleV8Qv0ZnqCfyZuedY3/c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IzQ08HJCrqiMZOoJ76vZKS8aawfz0ZqNxkNJ3v8y8iKOMcagXSWUzYnn5ISzAB6jG
	 60KofO0L5vRvzyb1bMkOeUq9/qC/mH30KqL29m4MK5bTITLn3mv9ZN4K8TVXlo6WBe
	 0LUs3MALI+KIl1kwesUeRI2g6RL+ZOhK06T0yDxjFxIpg1HLXrMoH9D7u31KV7AQjf
	 nDM2xZeoQ1QqWPt6gsWooh7UVPP/jB1YqCQtrxBNoTjr4dERFWXQng89orcCoG4QOb
	 s/+BQwNukLo/Ooi0ky8T4UtFgZMVzKKlbIVxjwOjYQNByoEUOfi7cXrDu5LE4dV9Vn
	 vE+RCKTablxvA==
Message-ID: <2dc7ad69-e264-4733-a953-8368ee2a0b44@kernel.org>
Date: Thu, 23 Oct 2025 17:54:18 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 mptcp-net 0/2] mptcp: restore zero window probe
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>
References: <cover.1761118636.git.pabeni@redhat.com>
 <5676a1d0af9ee91eee8f90be2574ed297bd70272.camel@kernel.org>
 <f7e3bb32be02262fa77a5311640f2282e4acdfbc.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <f7e3bb32be02262fa77a5311640f2282e4acdfbc.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 23/10/2025 08:24, Geliang Tang wrote:
> Hi Paolo,
> 
> On Wed, 2025-10-22 at 18:07 +0800, Geliang Tang wrote:
>> Hi Paolo,
>>
>> On Wed, 2025-10-22 at 09:39 +0200, Paolo Abeni wrote:
>>> It turns out that the issue reported by Geliang on the pending
>>> backlog
>>> patches is actually on older one that the new code made more easy
>>> reproducible.
>>>
>>> The first patch in the series addresses it[1], the 2nd one
>>> introduce
>>> new
>>> mibs to hopefully catch this problem sooned.
>>>
>>> I have a pktdrill to validate this scenario. I'll share that soon.
>>>
>>> @Geliang could you please validate the above in your testbed, on
>>> top
>>> of
>>> the backlog and splice patches?
>>
>> Thanks very much. I've already started testing, and so far everything
>> is running smoothly. I'll let it run loop tests overnight and will
>> have
>> the results by tomorrow morning. I'll provide you with feedback then.
> 
> Thank you so much! This fix really works. I've run hundreds of splice
> test loops with the following three patchsets applied, and no test
> failures occurred:
> 
> 	mptcp: restore zero window probe, v2
> 	mptcp: introduce backlog processing, v6
> 	implement mptcp read_sock, v13
> 
> Please add my tag for this set:
> 
> 	Reported-and-tested-by: Geliang Tang <geliang@kernel.org>

Thank you for the test!

To avoid issues with checkpatch and to be consistent, I'm going to add
this on the first patch:

  Reported-by: (...)
  Closes:
https://lore.kernel.org/d0a814c364e744ca6b836ccd5b6e9146882e8d42.camel@kernel.org
  (...)
  Tested-by: (...)

And only the Tested-by on the second one. I hope that's OK!

>> Thanks,
>> -Geliang
>>
>>>
>>> [1] at least here, at least with the packet drill reproducer ;)
>>> ---
>>> v1 -> v2:
>>>   - drop unneeded delta in patch 1/2
> 
> This change in v1 is valid. Later I will send a dedicated cleanup patch
> for -next to use tcp_sk() in mptcp_sendmsg_frag() with your "Suggested-
> by" tag.

Please only add such patch when we modify code around in net-next.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

