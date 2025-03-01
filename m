Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F23C1DE2C5
	for <mptcp@lists.linux.dev>; Sat,  1 Mar 2025 11:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740827452; cv=none; b=CD+vbO07Nn8W864p1CEpcb39P9tjMkNYfCyDDQjj8oKJSugZZRC/7qYrYgx1JNIlfhDkhmZJwHyRZ7H0sWJS8kWNA5Dd7uOGgc48JcET4u4qIAV2YunOEbTb3GcbeYWc47FIsd1H4VPcFf0jNx23rrAxDx4GRG8lXdwqR5WsxlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740827452; c=relaxed/simple;
	bh=oh77gKWxa9dI9GapShhb0XeX/+EHiIRRvPyvId1CU14=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TEybHMgfRxG5gEt5+gzfdJ9W/Glh7G/Gjdz3/Y6JaarNtR7cGJgnTVuIZ3K+HE/pgADHOU6WWhHfB+IrfhYMCW6g4dsepXq+d0hkql8HWFhANjTWWXL3Oxd8IaQDzbNNfQK4ZcmYd388nj523XC72IjmLpxbkgnC/hvksgVrUWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYh4X8GQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYh4X8GQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B091C4CEDD;
	Sat,  1 Mar 2025 11:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740827452;
	bh=oh77gKWxa9dI9GapShhb0XeX/+EHiIRRvPyvId1CU14=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=fYh4X8GQxgK362dzZFXH7qXcp8igsI1x+CKblNyLI0BtwE4ZzLp9iMSpM3fJqD7Cg
	 17/p5eYgLh987V77tbdDLpGnNu/MaJeT7EVQd+pf/w83glHaflPE4V4Mcdq82L7cJx
	 yjeq0hrcbkIIIjE6HVLYdjDC+oEDn3fITAoMV95UgtzFxhnyhBQcETRA/JT8rQO+2A
	 HRATmJJxI54oyD+ZVB9wvVlvcrz7fUB4vi1Ao7vlvMi5gvxm/PaAwB3VQUgIFRrs+M
	 3QMLMALnILuacrfezPQm20ALEs0M5A+7C86zSq1wuAsPRi5ncU5f2qGjKQQe4uOJZk
	 2cFAm5YAQJjyw==
Message-ID: <8e6a57b2-8d45-4c7d-a0d1-ca120eb0114a@kernel.org>
Date: Sat, 1 Mar 2025 12:10:49 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2 00/14] mptcp: pm: code reorganisation
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
References: <20250228-mptcp-pm-reorg-code-v2-0-fa8b2542b7a5@kernel.org>
 <6dd5447d53d519a848f8b21104d90478802a0372.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <6dd5447d53d519a848f8b21104d90478802a0372.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 01/03/2025 01:21, Geliang Tang wrote:
> Hi Matt,
> 
> On Fri, 2025-02-28 at 14:31 +0100, Matthieu Baerts (NGI0) wrote:
>> I have been thinking about that during the past couple of months, but
>> now, with the recent modifications done by Geliang, and the
>> associated
>> reviews, I really think it is time to reorganise the code around the
>> path-managers to avoid confusions, and a mix of code used in
>> different
>> conditions.
>>
>> I hope this will not cause too many issues with the in-progress
>> patches.
>> I tried only to move the code around, and minimise the functions
>> renaming. Then, to switch to the new code, it might be easier to
>> simply
>> copy your modified code from the old place to the new one. In other
>> words, duplicate the net/mptcp directory, then do a rebase, resolve
>> the
>> conflicts with 'git restore --ours', then reapply the modifications
>> by
>> copying your old code to the new place. If it is too difficult,
>> please
>> let me know.
>>
>> Before this series, the PM code was dispersed in different places:
>>
>> - pm.c had common code for all PMs
>>
>> - pm_netlink.c was supposed to be about the in-kernel PM, but also
>> had
>>   exported common helpers, callbacks used by the different PMs, NL
>>   events for PM userspace daemon, etc. quite confusing.
>>
>> - pm_userspace.c had userspace PM only code, but using specific
>>   in-kernel PM helpers
>>
>> To clarify the code, a reorganisation is suggested here, only by
>> moving
>> code around, and small helper renaming to avoid confusions:
>>
>> - pm_netlink.c now only contains common PM Netlink code:
>>   - PM events: this code was already there
>>   - shared helpers around Netlink code that were already there as
>> well
>>   - shared Netlink commands code from pm.c
>>
>> - pm_kernel.c now contains only code that is specific to the in-
>> kernel
>>   PM. Now all functions are either called from:
>>   - pm.c: events coming from the core, when this PM is being used
>>   - pm_netlink.c: for shared Netlink commands
>>   - mptcp_pm_gen.c: for Netlink commands specific to the in-kernel PM
>>   - sockopt.c: for the exported counters per netns
>>
>> - pm.c got many code from pm_netlink.c:
>>   - helpers used from both PMs and not linked to Netlink
>>   - callbacks used by different PMs, e.g. ADD_ADDR management
>>   - some helpers have been renamed to remove the '_nl' prefix, and
>> they
>>     have been marked as 'static'.
>>
>> - protocol.h has been updated accordingly:
>>   - some helpers no longer need to be exported
>>   - new ones needed to be exported: they have been prefixed if
>> needed.
>>
>> The code around the PM is now less confusing, which should help for
>> the
>> maintenance in the long term.
>>
>> This will certainly impact future backports, but because other
>> cleanups
>> have already done recently, and more are coming to ease the addition
>> of
>> a new path-manager controlled with BPF (struct_ops), doing that now
>> seems to be a good time. Also, many issues around the PM have been
>> fixed
>> a few months ago while increasing the code coverage in the selftests,
>> so
>> such big reorganisation can be done with more confidence now.
>>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> Changes in v2:
>> - Addressing Geliang's comments
>> - The renaming of common helpers have been done in dedicated patches
>> - Some helpers have been kept where they were in pm.c, except one now
>> in
>>   a dedicated patch.
>> - The last patch has been split in smaller chunks, only moving code
>> from
>>   one file to another to help with the reviews.
> 
> Thanks for this v2, I have some comments for it:

Thank you for having looked at the v2.

> Patches 1, 2, 5 can be merged into one.
> Patch 3 can be merged into patch 9.

We could, but how can this help? If these patches are OK for the moment
and reviewable, maybe no need to spend more time on that and merging
stuff that might make it harder to follow, and might cause new conflicts?

> Patch 4, change mptcp_pm_rm_addr_recv() as non-static here, instead of
> changing it in patch 9. How about renaming it as
> __mptcp_pm_nl_rm_addr_received?

Would it not be confusing with the previous functions? Especially in
case of backports.

> Patch 7, how about renaming mptcp_pm_nl_set_flags_all as
> __mptcp_pm_nl_set_flags too?

No, the '__' prefix is usually used to mark that this function is going
to be used in a "critical" section, e.g. when a lock is held.

> Patch 11, how about dropping this patch, keep
> mptcp_pm_addr_families_match() unmoved, but add a new section like "/*
> generic PM helpers */" to import the helpers there?

I did that at the beginning, but:
- that's strange not to put the generic helpers at the beginning
- also strange to have to go down to see how a helper is implemented

> Patch 12
>  - in mptcp_remove_anno_list_by_saddr() behavioural is changed, a
> separate patch is needed.

It is not, it is just a fix for a checkpatch warning mentioned in the
commit message. The netdev FAQ seems to suggest avoiding such fixes,
except if it is part of other changes. I don't think it is worth
splitting, the behaviour is not really modified.

>  - mptcp_lookup_subflow_by_saddr should be after mptcp_remote_address

Why? I moved mptcp_pm_is_init_remote_addr() there because it was in the
middle of pm_netlink.c and it is very closed to remote_address.

>  - mptcp_pm_sport_in_anno_list should be after
> mptcp_lookup_anno_list_by_saddr and befor mptcp_pm_add_timer.

Why?

>  - split "move all struct mptcp_pm_add_entry related code into pm.c"
> from patch 12 as a separate one.

Why?

>  - split "move all send_ack related code into pm.c" from patch 12 as a
> separate one.

Why?

>  - make mptcp_pm_is_init_remote_addr() static shoud be merged into
> patch 6.

We cannot do that: it is called from pm.c, and we need remote_address(),
at that time only declared in pm_netlink.c.

> Split "move all pm_nl_pernet related code into pm_kernel.c" from patch
> 13 as a separate one.

Why?

> Can the action of deleting three headers in patch 14 be advanced to the
> previous patch?

For the two first ones, maybe but is it important? For mptcp_pm_gen.h, no.

Thank you for the suggestions, but I don't think it is worth spending
more time on that, except if you think it would help for the maintenance
and the backports. Merging patches probably will not help, and splitting
code being moved around is still too big for the backports. But maybe I
missed something.

I think it would be better to apply these patches ASAP, not to block
further developments, or having to rebase this kind of series. WDYT?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

