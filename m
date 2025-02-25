Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3192225EF9A
	for <mptcp@lists.linux.dev>; Tue, 25 Feb 2025 09:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740475513; cv=none; b=R8BQhSn2CJjdwTFabNIIBbXzTlx3JhF2fg8pJ0fpXZj/tOBjdrw9ES7eMZV8HgcsRABvcUr4EWOY5hMer8C+wNf/OoHqYJ7LrOxWGtzMVP7g8Cp53EkopIbM29Wm0D6ZzPIGPouCeRoFHUipCfm7Wd2JR5EKq2mDdyJNbxYoBb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740475513; c=relaxed/simple;
	bh=hUJ2nJBr7yIwmIOp79GfM0WpOOeOvBz+MbV/HeeXbeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ggnmNOtpo2aZvdg3VhjJeGoYAHYANkdo92fJ6Of3cW4kXc07b3yAJrW2liMj4nVhL13Wt6G7n/kAckvziQfgaaqhQlfcmofTPuWKQNKQMQCnGjE/0JEITe6PPe/b4wmr2i0v6dv1aKJjIJVdaQmvqSnLhGZhMoCSxXg9xKUNe3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rLQWR4T/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rLQWR4T/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC2EC4CEDD;
	Tue, 25 Feb 2025 09:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740475512;
	bh=hUJ2nJBr7yIwmIOp79GfM0WpOOeOvBz+MbV/HeeXbeI=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=rLQWR4T/HWdhTi5UDyRSUeNGTuVPRGaQOvT59v8rCoj29Nu3Gg3ARo620gtPFuVuM
	 F+f1v5ZXsLPMEEpUd6yOyeguCMEQCnoeo5avt2akwWLm2CJLPlRYJGeg69Ux5epPzG
	 NDWGE7t/gM8JREj6j1In31WdP7lt/ACv86ADr1bhXx+lh5DFovanDvwc+DWDmrtZaV
	 lL/+BFx+6UuOduKJkz9bvfkidM37TuQIdoGD5CyU0CHLEmrs8sBxNl9DuFFltghXDZ
	 2l1rLFUvYqPZl5BbIct9BDRGETcmsReB9XCfIVXa2Rrhw/mJNgMd1pERWlCoaAPza/
	 9VeB2Sjd419uA==
Message-ID: <0b1c7e47-78d1-4dbb-b78b-e071f9c08dac@kernel.org>
Date: Tue, 25 Feb 2025 10:25:09 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next] mptcp: pm: userspace: avoid scheduling
 in-kernel PM worker
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
References: <20250224-mptcp-userspace-avoid-worker-v1-1-127325d3e9a4@kernel.org>
 <8ccd5c340bb75c8e325c8b8a1207671785cf911d.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <8ccd5c340bb75c8e325c8b8a1207671785cf911d.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

Thank you for your review!

On 25/02/2025 05:21, Geliang Tang wrote:
> Hi Matt,
> 
> On Mon, 2025-02-24 at 20:01 +0100, Matthieu Baerts (NGI0) wrote:
>> When the userspace PM is used, there is no need to schedule the PM
>> worker for in-kernel specific tasks, e.g. creating new subflows, or
>> sending more ADD_ADDR.
>>
>> Now, these tasks will be done only if the in-kernel PM is being used.
>>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> Notes:
>>  - I don't know if this should be seen as a fix. Maybe yes because it
>>    was not supposed to do that from the beginning, and it feels less
>>    risky not to schedule the worker when it is not needed. I'm open
>> to
>>    suggestions here.
>>  - I'm mainly sharing this patch now because Geliang is going to
>> modify
>>    these helpers to separate PM specific code.
>>    @Geliang: please rebase your series on top of this one (or include
>>    this patch if it is easier).
>> Cc: Geliang Tang <tanggeliang@kylinos.cn>
>> ---
>>  net/mptcp/pm.c | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
>> index
>> 16cacce6c10fe86467aa7ef8e588f9f535b586fb..4eabb83328905676759768fb44c
>> 859f5682721e3 100644
>> --- a/net/mptcp/pm.c
>> +++ b/net/mptcp/pm.c
>> @@ -138,7 +138,7 @@ void mptcp_pm_fully_established(struct mptcp_sock
>> *msk, const struct sock *ssk)
>>  	 * racing paths - accept() and check_fully_established()
>>  	 * be sure to serve this event only once.
>>  	 */
>> -	if (READ_ONCE(pm->work_pending) &&
>> +	if (mptcp_pm_is_kernel(msk) && READ_ONCE(pm->work_pending)
>> &&
> 
> I think there's no need to modify this. work_pending is set to 0 by 
> userspace pm, for all cases where work_pending is 1, the path manager
> must be an in-kernel pm.

Good point, I missed that!

'pm->work_pending' doesn't look like a good name for what it does.
Hopefully, this will be clearer when pm->ops will be used, which will
clearly separate what is done by the different PMs.

Also, is it possible we never set 'pm->work_pending' back to 'true' once
it has been set to 'false'? Does it mean when we reach the limits, and
something happens (e.g. a removed subflow, limits are changed, etc.),
the worker is no longer used to establish new subflows or react when an
ADD_ADDR is received?

> So there is no need to add mptcp_pm_is_kernel() check here. Just
> checking work_pending is sufficient.

Indeed.

>>  	    !(msk->pm.status & BIT(MPTCP_PM_ALREADY_ESTABLISHED)))
>>  		mptcp_pm_schedule_work(msk, MPTCP_PM_ESTABLISHED);
>>  
>> @@ -166,7 +166,7 @@ void mptcp_pm_subflow_established(struct
>> mptcp_sock *msk)
>>  
>>  	pr_debug("msk=%p\n", msk);
>>  
>> -	if (!READ_ONCE(pm->work_pending))
>> +	if (!mptcp_pm_is_kernel(msk) || !READ_ONCE(pm-
>>> work_pending))
>>  		return;
> 
> No need to modify this too, work_pending has been checked later in
> mptcp_pm_subflow_established:
> 
>     if (READ_ONCE(pm->work_pending))
>         mptcp_pm_schedule_work(msk, MPTCP_PM_SUBFLOW_ESTABLISHED);

Indeed.

>>  
>>  	spin_lock_bh(&pm->lock);
>> @@ -251,6 +251,9 @@ void mptcp_pm_add_addr_echoed(struct mptcp_sock
>> *msk,
>>  
>>  	pr_debug("msk=%p\n", msk);
>>  
>> +	if (!mptcp_pm_is_kernel(msk) || !READ_ONCE(pm-
>>> work_pending))
>> +		return;
>> +
> 
> Same here, work_pending has been checked later in
> mptcp_pm_add_addr_echoed:
> 
> if (mptcp_lookup_anno_list_by_saddr(msk, addr) && READ_ONCE(pm-
>> work_pending))
>     mptcp_pm_schedule_work(msk, MPTCP_PM_SUBFLOW_ESTABLISHED);

Indeed.

>>  	spin_lock_bh(&pm->lock);
>>  
>>  	if (mptcp_lookup_anno_list_by_saddr(msk, addr) &&
>> READ_ONCE(pm->work_pending))
>> @@ -278,6 +281,9 @@ void mptcp_pm_rm_addr_received(struct mptcp_sock
>> *msk,
>>  	for (i = 0; i < rm_list->nr; i++)
>>  		mptcp_event_addr_removed(msk, rm_list->ids[i]);
>>  
>> +	if (!mptcp_pm_is_kernel(msk))
>> +		return;
> 
> This mptcp_pm_is_kernel() is indeed needed.

Yes it is. And 'pm->work_pending' cannot be used, because it will be set
to false when the limits are reached, but a RM_ADDR will potentially
decrement counters.

I will send a v2 with only this change.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

