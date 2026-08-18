Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A822363081;
	Tue, 18 Aug 2026 15:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787068226; cv=none; b=CeYqHi/O7/s1rKOHXkaWnr8vpOITslUiryIEZVZl/ftXHrcK2rZDlkT4FtVjQUnvH6QVA2HiMTqEkKiBXeMT6/RZLgTP+EJup/4gD/2oJhwEW5bajluQoapA6/B3uX/B7VJPV5fqSrR4Qxi5iZ7FCYhPeOXKsSVE1CEbfVbFiZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787068226; c=relaxed/simple;
	bh=nlp08hHGiLccYDf+/XVoWlrGj7xR3CL2bOzNqCOBPcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UINsMhOC0aAhKLP7lBTbedZLgMpI/UyFtif73xZvtXkg3P0qVWnGlEcVLK4cMpAvy6lnaTLknOjqtRQwewHMyrPyyd2sjMEEQVJk3d4Qz7lozgAnLMhuWKs0zqsRhTP6R/jnbj69i8RGOFMfVuZPpFtlUhYB+sKJHO1MjKvSjys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUUn+o8Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUUn+o8Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7187D1F000E9;
	Tue, 18 Aug 2026 15:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787068225;
	bh=fGoucq703kpQy1vL6rg4U4eLvWWv4LLJ5Mwz/r7MHdM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GUUn+o8YfLndQshOnVo/EoBsAZy7ZWyNkxpUo6O4dzPCgQIROeK+o+8W/77hLUhJT
	 bvT7roxyeEJh34ljNR/GbUBPa8spjcOYF3GiLoGo0WV36E1Q/V/QWj2I5MreTaiWqj
	 HYGyPn3hZsAzwgXL0m4YQXhXP4ISFHK8On/B3SoK9VRqVF+D1sj+08c2ONXoJAQj7g
	 Q4Kh6OsmIuBI5myWf20R741aPLBx9+aqJmJIl8UA39lw/Ay8w3ZbmSekOqB8btlq5f
	 DVJxKU/4oml7JWnE1z5fCaaHFy1O4w3s6tYbg+9d51h5vsz/wT9+ysWqGQEieuWC8h
	 +ZqnbzNRSNkfA==
Message-ID: <be72266a-a2a2-49f7-9be8-36eeb09750df@kernel.org>
Date: Tue, 18 Aug 2026 17:50:21 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2 1/5] mptcp: sched: change scheduler sysctl
 atomically
Content-Language: fr
To: gang.yan@linux.dev, sashiko-reviews@lists.linux.dev
Cc: mptcp@lists.linux.dev
References: <20260818094825.48446-1-gang.yan@linux.dev>
 <20260818094825.48446-2-gang.yan@linux.dev>
 <20260818095955.6892E1F000E9@smtp.kernel.org>
 <a9ef03bb12d3087e8f4af51d6d7dcd9967810942@linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <a9ef03bb12d3087e8f4af51d6d7dcd9967810942@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Gang,

On 18/08/2026 14:56, gang.yan@linux.dev wrote:
> August 18, 2026 at 5:59 PM, sashiko-bot@kernel.org mailto:sashiko-bot@kernel.org  wrote:
> 
> 
>>
>> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>> - [High] Use-After-Free and module reference leak due to missing reference counting when setting the default MPTCP scheduler
>> - [Medium] Redundant scheduler list traversal during socket initialization defeats pointer caching
>> --
>>
>> --- Patch [1]: [PATCH mptcp-next v2 1/5] mptcp: sched: change scheduler sysctl atomically ---
>> commit d5b1780c033b9909a1b30fbd814812af5c25ed2f
>> Author: Gang Yan <yangang@kylinos.cn>
>>
>> mptcp: sched: change scheduler sysctl atomically
>>
>> This commit changes the per-netns scheduler storage from an inline string
>> to an RCU-protected pointer to an mptcp_sched_ops struct. It updates the
>> sysctl read/write paths and socket initialization to use this pointer,
>> aiming to prevent concurrent readers from observing half-written names.
>>
>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/626
>>
>>>
>>> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
>>>  index 63c5747f0f63c..479b31eb30079 100644
>>>  --- a/net/mptcp/ctrl.c
>>>  +++ b/net/mptcp/ctrl.c
>>>
>> [ ... ]
>>
>>>
>>> @@ -126,7 +133,7 @@ static int mptcp_set_scheduler(char *scheduler, const char *name)
>>>  rcu_read_lock();
>>>  sched = mptcp_sched_find(name);
>>>  if (sched)
>>>  - strscpy(scheduler, name, MPTCP_SCHED_NAME_MAX);
>>>  + xchg(&pernet->scheduler, sched);
>>>
>> [Severity: High]
>> When replacing the scheduler pointer here with xchg(), does this leak the
>> module reference for the previous scheduler returned by xchg()?
>>
>> Also, do we need to acquire a module reference for the newly assigned sched
>> via bpf_try_module_get() before storing it? Without a reference, could the
>> module be unloaded, leaving pernet->scheduler pointing to freed memory that
>> would trigger a use-after-free when dereferenced by a concurrent reader in
>> proc_scheduler()?
> 
> Hi Matt,

(you can address such email to the list, I'm not the only one here ;) )

> As far as I know, for linux-master branch, the sched ops cannot be torndown, and
> the only static default scheduler is used, so no reference counting is needed.

Thank you for replying to these emails from Sashiko, that's the right
way to do!

> It is safe for now, the pm is as the same. Right?

Oh, sorry, I just realised the BPF module part for the scheduler is
already in Linux mainstream [1], but not the PM one [2]:

[1] https://elixir.bootlin.com/linux/v7.2/source/net/mptcp/sched.c#L130-L160
[2] https://elixir.bootlin.com/linux/v7.2/source/net/mptcp/pm.c#L1225-L1254

Sorry for the confusion, but then I guess the split is only needed for
the PM side. In fact patch 1/3 from the v1 can apply on net-next
directly. So in terms of split, the sched part from v1 was OK (no
split), but for the PM, we need the split from v2.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

