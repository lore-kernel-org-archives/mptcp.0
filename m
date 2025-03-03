Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4600C1F461E
	for <mptcp@lists.linux.dev>; Mon,  3 Mar 2025 11:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000072; cv=none; b=hRADj5i1m04/tsGOTubN4QURDynKlXw95UlBxlGf18uh2vPwzfF8DCO988ydCM8c+5ulm+evbNhAW8yO362LqmetyeYyA5VWMf+6uU1Xo9w3/x4prT50oPaiDI90l9jd3JrN92lvK/Ar+N5gPHm1V1Q3ZlyufNeaR6DpPfpl3FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000072; c=relaxed/simple;
	bh=qFXBtSesQaVApg2n9H6yDKnM/KbRuqT/l/WhldxuL40=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=W8YWIGJwBjSEtXB84eM7HP9+65cRAHDk6aLsfxZsEa8h+v/vKaKHEO0jQduw6AfbmL4dEL4ATfbhF8AMhQR0ghZnys9NQR0EH+kIjBVl1BqzibdBntXTYHZ1TCIIIzMTvAf5WC7GrpWBP9pCBtvebZHSC4ArjfDb180SVQJZvxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNM5swsF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNM5swsF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06996C4CED6;
	Mon,  3 Mar 2025 11:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741000071;
	bh=qFXBtSesQaVApg2n9H6yDKnM/KbRuqT/l/WhldxuL40=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=CNM5swsFAXFFNIuKlV1yO6yJHE6f2gEvnwUQVksLDQDH6SiYUWE/RRZC25WNxS+iR
	 222ByypOFFmQTAxRE8gqSyScmoAW12S/g5EZQqHXpjhaVGjcaG4vLOK6QtrfYKFLOR
	 gk1qF0Wetjr/QlP2OdsFKhReJpH+DRC2JiaLR2pFItRAoO5OYop2Hr8eQ7zLAcg40+
	 DzPS9tcfTteMY4+Eefyw5YauwDuA7E391DfKsdsoECqZdxq1jG8DAWsUah7pBnqwv5
	 tWXupSYpnBf+KwLgc0gWJKXjz9ZnasmsxQtVJmiNdjBUC5BklfutVmQ8DTu6cdOUny
	 kBTLt9ji3P0WQ==
Message-ID: <adcbfc72-0eb3-4340-9af5-97e2ffbe12c1@kernel.org>
Date: Mon, 3 Mar 2025 12:07:49 +0100
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
 <8e6a57b2-8d45-4c7d-a0d1-ca120eb0114a@kernel.org>
 <d92038d729b02be236e736bc598dc17bd6f71b23.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <d92038d729b02be236e736bc598dc17bd6f71b23.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 03/03/2025 11:55, Geliang Tang wrote:
> Hi Matt,
> 
> On Sat, 2025-03-01 at 12:10 +0100, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 01/03/2025 01:21, Geliang Tang wrote:
>>> Hi Matt,
>>>
>>> On Fri, 2025-02-28 at 14:31 +0100, Matthieu Baerts (NGI0) wrote:
>>>> I have been thinking about that during the past couple of months,
>>>> but
>>>> now, with the recent modifications done by Geliang, and the
>>>> associated
>>>> reviews, I really think it is time to reorganise the code around
>>>> the
>>>> path-managers to avoid confusions, and a mix of code used in
>>>> different
>>>> conditions.
>>>>
>>>> I hope this will not cause too many issues with the in-progress
>>>> patches.
>>>> I tried only to move the code around, and minimise the functions
>>>> renaming. Then, to switch to the new code, it might be easier to
>>>> simply
>>>> copy your modified code from the old place to the new one. In
>>>> other
>>>> words, duplicate the net/mptcp directory, then do a rebase,
>>>> resolve
>>>> the
>>>> conflicts with 'git restore --ours', then reapply the
>>>> modifications
>>>> by
>>>> copying your old code to the new place. If it is too difficult,
>>>> please
>>>> let me know.
>>>>
>>>> Before this series, the PM code was dispersed in different
>>>> places:
>>>>
>>>> - pm.c had common code for all PMs
>>>>
>>>> - pm_netlink.c was supposed to be about the in-kernel PM, but
>>>> also
>>>> had
>>>>   exported common helpers, callbacks used by the different PMs,
>>>> NL
>>>>   events for PM userspace daemon, etc. quite confusing.
>>>>
>>>> - pm_userspace.c had userspace PM only code, but using specific
>>>>   in-kernel PM helpers
>>>>
>>>> To clarify the code, a reorganisation is suggested here, only by
>>>> moving
>>>> code around, and small helper renaming to avoid confusions:
>>>>
>>>> - pm_netlink.c now only contains common PM Netlink code:
>>>>   - PM events: this code was already there
>>>>   - shared helpers around Netlink code that were already there as
>>>> well
>>>>   - shared Netlink commands code from pm.c
>>>>
>>>> - pm_kernel.c now contains only code that is specific to the in-
>>>> kernel
>>>>   PM. Now all functions are either called from:
>>>>   - pm.c: events coming from the core, when this PM is being used
>>>>   - pm_netlink.c: for shared Netlink commands
>>>>   - mptcp_pm_gen.c: for Netlink commands specific to the in-
>>>> kernel PM
>>>>   - sockopt.c: for the exported counters per netns
>>>>
>>>> - pm.c got many code from pm_netlink.c:
>>>>   - helpers used from both PMs and not linked to Netlink
>>>>   - callbacks used by different PMs, e.g. ADD_ADDR management
>>>>   - some helpers have been renamed to remove the '_nl' prefix,
>>>> and
>>>> they
>>>>     have been marked as 'static'.
>>>>
>>>> - protocol.h has been updated accordingly:
>>>>   - some helpers no longer need to be exported
>>>>   - new ones needed to be exported: they have been prefixed if
>>>> needed.
>>>>
>>>> The code around the PM is now less confusing, which should help
>>>> for
>>>> the
>>>> maintenance in the long term.
>>>>
>>>> This will certainly impact future backports, but because other
>>>> cleanups
>>>> have already done recently, and more are coming to ease the
>>>> addition
>>>> of
>>>> a new path-manager controlled with BPF (struct_ops), doing that
>>>> now
>>>> seems to be a good time. Also, many issues around the PM have
>>>> been
>>>> fixed
>>>> a few months ago while increasing the code coverage in the
>>>> selftests,
>>>> so
>>>> such big reorganisation can be done with more confidence now.
>>>>
>>>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>>> ---
>>>> Changes in v2:
>>>> - Addressing Geliang's comments
>>>> - The renaming of common helpers have been done in dedicated
>>>> patches
>>>> - Some helpers have been kept where they were in pm.c, except one
>>>> now
>>>> in
>>>>   a dedicated patch.
>>>> - The last patch has been split in smaller chunks, only moving
>>>> code
>>>> from
>>>>   one file to another to help with the reviews.
>>>
>>> Thanks for this v2, I have some comments for it:
>>
>> Thank you for having looked at the v2.
>>
>>> Patches 1, 2, 5 can be merged into one.
>>> Patch 3 can be merged into patch 9.
>>
>> We could, but how can this help? If these patches are OK for the
>> moment
>> and reviewable, maybe no need to spend more time on that and merging
>> stuff that might make it harder to follow, and might cause new
>> conflicts?
>>
>>> Patch 4, change mptcp_pm_rm_addr_recv() as non-static here, instead
>>> of
>>> changing it in patch 9. How about renaming it as
>>> __mptcp_pm_nl_rm_addr_received?
>>
>> Would it not be confusing with the previous functions? Especially in
>> case of backports.
>>
>>> Patch 7, how about renaming mptcp_pm_nl_set_flags_all as
>>> __mptcp_pm_nl_set_flags too?
>>
>> No, the '__' prefix is usually used to mark that this function is
>> going
>> to be used in a "critical" section, e.g. when a lock is held.
>>
>>> Patch 11, how about dropping this patch, keep
>>> mptcp_pm_addr_families_match() unmoved, but add a new section like
>>> "/*
>>> generic PM helpers */" to import the helpers there?
>>
>> I did that at the beginning, but:
>> - that's strange not to put the generic helpers at the beginning
>> - also strange to have to go down to see how a helper is implemented
>>
>>> Patch 12
>>>  - in mptcp_remove_anno_list_by_saddr() behavioural is changed, a
>>> separate patch is needed.
>>
>> It is not, it is just a fix for a checkpatch warning mentioned in the
>> commit message. The netdev FAQ seems to suggest avoiding such fixes,
>> except if it is part of other changes. I don't think it is worth
>> splitting, the behaviour is not really modified.
>>
>>>  - mptcp_lookup_subflow_by_saddr should be after
>>> mptcp_remote_address
>>
>> Why? I moved mptcp_pm_is_init_remote_addr() there because it was in
>> the
>> middle of pm_netlink.c and it is very closed to remote_address.
>>
>>>  - mptcp_pm_sport_in_anno_list should be after
>>> mptcp_lookup_anno_list_by_saddr and befor mptcp_pm_add_timer.
>>
>> Why?
>>
>>>  - split "move all struct mptcp_pm_add_entry related code into
>>> pm.c"
>>> from patch 12 as a separate one.
>>
>> Why?
>>
>>>  - split "move all send_ack related code into pm.c" from patch 12
>>> as a
>>> separate one.
>>
>> Why?
>>
>>>  - make mptcp_pm_is_init_remote_addr() static shoud be merged into
>>> patch 6.
>>
>> We cannot do that: it is called from pm.c, and we need
>> remote_address(),
>> at that time only declared in pm_netlink.c.
>>
>>> Split "move all pm_nl_pernet related code into pm_kernel.c" from
>>> patch
>>> 13 as a separate one.
>>
>> Why?
>>
>>> Can the action of deleting three headers in patch 14 be advanced to
>>> the
>>> previous patch?
>>
>> For the two first ones, maybe but is it important? For
>> mptcp_pm_gen.h, no.
>>
>> Thank you for the suggestions, but I don't think it is worth spending
>> more time on that, except if you think it would help for the
>> maintenance
>> and the backports. Merging patches probably will not help, and
>> splitting
>> code being moved around is still too big for the backports. But maybe
>> I
>> missed something.
>>
>> I think it would be better to apply these patches ASAP, not to block
>> further developments, or having to rebase this kind of series. WDYT?
> 
> Patches that move code to another location are not very friendly to
> backporting, especially large patches like this set, which almost
> always conflict. When conflicts occur, we need to deal with them
> manually.
> 
> All my suggestions are to reduce the workload of manually dealing with
> conflicts when they occur.
> 
> If the code is moved in one piece, we can handle it easily. If the
> function location changes during the code move, we need to move each
> function one by one, which increases the workload. If the function name
> changes, we need to compile and verify it at the same time, which
> further increases the workload. If the code logic also changes, the
> situation will be worse.
> 
> It is possible that this patch does not need to be backported, but the
> subsequent PM code is modified based on the new code location, and the
> subsequent new features are developed based on it, so there is still a
> possibility that this patch needs to be backported.

Thank you for your reply!

Yes, clearly this series can cause troubles for future fixes in the PM
manager, but it looks worth it, and the right time to do so with all
other cleanups.

Usually, conflicts in smaller chunk are easier to deal with. Now, here
it is a bit different: big blocks of code are being moved from one side
to another. The idea is not to backport this series. We might want to do
that to ease the backport of some fixes, but it feels to me that we
would either take all patches from this series, or none.

So far, I think I did the backports of all MPTCP patches having
conflicts, and my feeling is that the v2 is OK like that. It was good to
extract all functions renaming in separated patches and only move code
from one file to another as you suggested after having reviewed the v1.
This will help for other reviews, but also for the backports, where we
will clearly understand what has moved where. I don't think we need more.

> Since all my comments do not involve any code modifications, and the
> code itself in this set looks good to me, I am also willing to add my
> reviewed-by tag:
> 
> Reviewed-by: Geliang Tang <geliang@kernel.org>
Thank you! I'm then going to apply this series in our tree ASAP.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

