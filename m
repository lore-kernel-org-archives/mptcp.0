Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB691158DCA
	for <mptcp@lists.linux.dev>; Tue,  2 Jul 2024 10:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719917667; cv=none; b=ImokAk6b5e+sN3Z9i83tTwrHTlt9VN2OYgxVPN7vEH2uZufum9UbgVLv/u6VRgCdWr276qU2sJxqgPORlQeYRgtTWOKJjC4u/UQTzwCcqNca/qBYPLXpaPevByShvzev8lRKtpQq+lwOE13fLOX2melRYgMQ2teEfXnTwgRInuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719917667; c=relaxed/simple;
	bh=yW1OtRITi80br/kPt0OLBAQZH6LYCej1FnMOLVGquMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B5hoOHVffDQBfWr1VqooQnKBbDR0xst/OPwuziAnJJbm33mFHntWHHEmnv86c61CWbuoYx18OKUM88YYa1KW55Ge6y6EYrBGXxHfoRdwNQqqAfblVjEswWadJQcbxrxaqSVNd8h3Blo/3kBr9tTsdWnu7jHx92g/SdfzZK5Gs2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6/WepsO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6/WepsO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA7CC2BD10;
	Tue,  2 Jul 2024 10:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719917667;
	bh=yW1OtRITi80br/kPt0OLBAQZH6LYCej1FnMOLVGquMA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a6/WepsOPRtT+95qhps8x3Vl/AzGlO07yU+q/OJbw6VvuCZ/3ZJfiXxXC+xdBvi9c
	 zgIpMxr7pS7NEzqPuUeTylselvsVSAE9U+v6ModxePv/QigUeu2NN4eIiDt3ZnI85o
	 NpRhYRvz001RkPhB5cvcebZfYLDBr8sxOIqBVrRObkhNH+i67cNj4e9jFfz+0OnAMB
	 9yFO2z26FGUtij9eQgXAdzabx+E6/LiXscHxVTcnMRRR+xjUzWqE9M5uUlYmxKLc1U
	 iXLGnEE9P4VLUNvVv3Jf3XYnFjYeVmY1qncw8sy6QJ76cC7J7WTFGpwxkqEZYPy9IN
	 QD0Ugl53f5XzQ==
Message-ID: <a0d4520d-29ba-47df-aa4d-5bfa4661323e@kernel.org>
Date: Tue, 2 Jul 2024 12:54:24 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 2/4] mptcp: split id_avail_bitmap per target
Content-Language: en-GB
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
References: <20240621-mptcp-pm-avail-v1-0-b692d5eb89b5@kernel.org>
 <20240621-mptcp-pm-avail-v1-2-b692d5eb89b5@kernel.org>
 <e1d59bcb-3baa-c432-31ab-139428ef7cde@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <e1d59bcb-3baa-c432-31ab-139428ef7cde@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

Note: I forgot to change the topic to 'mptcp-net'...

On 26/06/2024 01:16, Mat Martineau wrote:
> On Fri, 21 Jun 2024, Matthieu Baerts (NGI0) wrote:
> 
>> Up to the 'Fixes' commit, having an endpoint with both the 'signal' and
>> 'subflow' flags, resulted in the creation of a subflow and an address
>> announcement using the address linked to this endpoint. After this
>> commit, only the address announcement was done, ignoring the 'subflow'
>> flag.
>>
>> That's because the same bitmap was used for the two flags. It is easy to
>> split it in two: one for 'signal', and one for 'subflow'.
>>
>> It is unusual to set the two flags together: creating a new subflow
>> using a new local address will implicitly advertise it to the other
>> peer. So in theory, no need to advertise it explicitly as well. Maybe
>> there are use-cases -- the subflow might not reach the other peer that
>> way, we can ask the other peer to try initiating the new subflow without
>> delay -- or very likely the user is confused, and put both flags "just
>> to be sure at least the right one is set". Still, the kernel should do
>> what has been asked: using this endpoint to announce the address and to
>> create a new subflow from it.
>>
>> An alternative is to forbid the use of the two flags together, but
>> that's probably too late, and there are maybe use-cases. This patch will
>> avoid people complaining subflows are not created using the endpoint
>> they added with the 'subflow' and 'signal' flag.
>>
>> Fixes: 86e39e04482b ("mptcp: keep track of local endpoint still
>> available for each msk")
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> net/mptcp/pm.c         |  3 ++-
>> net/mptcp/pm_netlink.c | 20 ++++++++++++--------
>> net/mptcp/protocol.h   |  5 +++--
>> 3 files changed, 17 insertions(+), 11 deletions(-)
>>
>> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
>> index 55406720c607..d29fb35bb927 100644
>> --- a/net/mptcp/pm.c
>> +++ b/net/mptcp/pm.c
>> @@ -543,7 +543,8 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
>>     WRITE_ONCE(pm->addr_signal, 0);
>>     WRITE_ONCE(pm->remote_deny_join_id0, false);
>>     pm->status = 0;
>> -    bitmap_fill(msk->pm.id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
>> +    bitmap_fill(msk->pm.id_avail_signals_bitmap, MPTCP_PM_MAX_ADDR_ID
>> + 1);
>> +    bitmap_fill(msk->pm.id_avail_subflows_bitmap,
>> MPTCP_PM_MAX_ADDR_ID + 1);
>> }
>>
>> void mptcp_pm_data_init(struct mptcp_sock *msk)
>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>> index ea9e5817b9e9..4805452d05a2 100644
>> --- a/net/mptcp/pm_netlink.c
>> +++ b/net/mptcp/pm_netlink.c
>> @@ -156,7 +156,7 @@ select_local_address(const struct pm_nl_pernet
>> *pernet,
>>         if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW))
>>             continue;
>>
>> -        if (!test_bit(entry->addr.id, msk->pm.id_avail_bitmap))
>> +        if (!test_bit(entry->addr.id, msk->pm.id_avail_subflows_bitmap))
>>             continue;
>>
>>         ret = entry;
>> @@ -178,10 +178,10 @@ select_signal_address(struct pm_nl_pernet
>> *pernet, const struct mptcp_sock *msk)
>>      * can lead to additional addresses not being announced.
>>      */
>>     list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
>> -        if (!test_bit(entry->addr.id, msk->pm.id_avail_bitmap))
>> +        if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
>>             continue;
>>
>> -        if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
>> +        if (!test_bit(entry->addr.id, msk->pm.id_avail_signals_bitmap))
>>             continue;
>>
>>         ret = entry;
>> @@ -228,7 +228,9 @@ bool mptcp_pm_nl_check_work_pending(struct
>> mptcp_sock *msk)
>>     struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
>>
>>     if (msk->pm.subflows == mptcp_pm_get_subflows_max(msk) ||
>> -        (find_next_and_bit(pernet->id_bitmap, msk->pm.id_avail_bitmap,
>> +        (find_next_and_bit(pernet->id_bitmap, msk-
>> >pm.id_avail_signals_bitmap,
>> +                   MPTCP_PM_MAX_ADDR_ID + 1, 0) ==
>> MPTCP_PM_MAX_ADDR_ID + 1) ||
>> +        (find_next_and_bit(pernet->id_bitmap, msk-
>> >pm.id_avail_subflows_bitmap,
>>                    MPTCP_PM_MAX_ADDR_ID + 1, 0) ==
>> MPTCP_PM_MAX_ADDR_ID + 1)) {
>>         WRITE_ONCE(msk->pm.work_pending, false);
>>         return false;
>> @@ -537,7 +539,8 @@ static void
>> mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
>>         rcu_read_lock();
>>         entry = __lookup_addr(pernet, &mpc_addr);
>>         if (entry) {
>> -            __clear_bit(entry->addr.id, msk->pm.id_avail_bitmap);
>> +            __clear_bit(entry->addr.id, msk-
>> >pm.id_avail_signals_bitmap);
>> +            __clear_bit(entry->addr.id, msk-
>> >pm.id_avail_subflows_bitmap);
>>             msk->mpc_endpoint_id = entry->addr.id;
>>             backup = !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
>>         }
>> @@ -570,7 +573,7 @@ static void
>> mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
>>
>>         if (local) {
>>             if (mptcp_pm_alloc_anno_list(msk, &local->addr)) {
>> -                __clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
>> +                __clear_bit(local->addr.id, msk-
>> >pm.id_avail_signals_bitmap);
> 
> Hi Matthieu -
> 
> I don't see anywhere that __set_bit(id, msk->pm.id_avail_signals_bitmap)
> is ever called, so it looks like once an id is announced it is never
> available to announce again.

Good point! It looks like it was already the case before: we only mark
an ID as available again in mptcp_pm_nl_rm_addr_or_subflow(), but only
when we found a matching local subflow. If the local ID was not used
locally -- e.g. the other peer didn't establish a new subflow -- the ID
was not marked as available again.

> I think it would work to set that bit whenever an announce list entry is
> removed using remove_anno_list_by_saddr()? The idea would be to keep
> id_avail_signals_bitmap consistent with the anno_list, and
> id_avail_subflows_bitmap consistent with the connected subflows.

Yes, either in remove_anno_list_by_saddr() or mptcp_pm_remove_addr().
But then it is now linked to Paolo's series :)

https://lore.kernel.org/r/cover.1719589916.git.pabeni@redhat.com

Maybe better to do that there?

It might be clearer to keep the suggested modification in
mptcp_pm_nl_rm_addr_or_subflow(): only set the ID as available for the
subflows bitmap. Then in another patch, set the ID as available for the
signal bitmap in remove_anno_list_by_saddr() or mptcp_pm_remove_addr().
WDYT?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

