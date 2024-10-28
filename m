Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4304AEE0
	for <mptcp@lists.linux.dev>; Mon, 28 Oct 2024 11:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730116142; cv=none; b=CbE4pJOU4UEjkUE/BPPC+q6yqnoF/K9KJGNa39Vify4F/3EjnGMsT5fyzpSbn9g4b3iHmubTZnY/vUxL1wbE0zMnJTifHwywuwSDk+4evaVOghkob1XLkvJYvCifexhRJV55gqtVWgKz50nIkJOq+aKKB+TgwDNMgruu6wgyJFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730116142; c=relaxed/simple;
	bh=ktyDBL2ewhtxR7y8wVfVl/fcB1Pv2+OVMLKPfmP+aHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L7kZMyTm0lC7KO/Rsf19AOFaz670OrwH8lNh05gwH0PRn7RVZ7dsJ8PMUMb2M0O1de1MEqZc+BrDi+fDu+YpgSU51DEYpAv40F0E/JZgeIsiDpociHcr+7n5LBs0W4XyjZEQenzraBXuLhKiabn8NKIP+mxRqsphEDE2NP0chYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Er6NHQkh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Er6NHQkh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C93C4CEC3;
	Mon, 28 Oct 2024 11:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730116141;
	bh=ktyDBL2ewhtxR7y8wVfVl/fcB1Pv2+OVMLKPfmP+aHU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Er6NHQkhfHiqg5Ev84I46LPlhKz3PL0tOG5j+IvvVD5LHD76KQ49oLNjWxcp8Z9SU
	 TthWSLukJBvz5gx+WSbe6u+89pcbBsYY0tVWoQGIgnrfAbbJGseUJXh2p6VE/nm7St
	 GnxV+TNAZ5/3eLLT5q+xDHpOl8o4TNGiFxtUFF1kWvouEyKvEzJsgYZFlzPLBB3JMa
	 2rmX/ME8jBSQeoMEY5/mKQyp7vheKfYXyu6jBIYjG3sQ7ueI19tOsHGhJNo60BW6cX
	 3GJioKLh/ffK6b9jUSa9DIO6DIXzlf9DZ4OGkZ7lIUDFjUZuK9jvuuqvwO1sWr9Rvu
	 PLvDCFR2BoAjw==
Message-ID: <cb3c0685-a3ce-4009-b5a4-7e4fb9d4716e@kernel.org>
Date: Mon, 28 Oct 2024 12:48:58 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v2 2/3] mptcp: pm: lockless list traversal
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>
References: <20241025-mptcp-pm-lookup_addr_rcu-v2-0-1478f6c4b205@kernel.org>
 <20241025-mptcp-pm-lookup_addr_rcu-v2-2-1478f6c4b205@kernel.org>
 <48c030b9f5156dddec50e8727062b8350a53f8a0.camel@kernel.org>
 <b303b3d0-1c0a-4c0a-8031-77023a2de005@kernel.org>
 <bb346392a148c223c9aed723ba5f45c8d9a2f34c.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <bb346392a148c223c9aed723ba5f45c8d9a2f34c.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 28/10/2024 03:08, Geliang Tang wrote:
> Hi Matt,
> 
> On Fri, 2024-10-25 at 17:26 +0200, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> Thank you for the review!
>>
>> On 25/10/2024 16:25, Geliang Tang wrote:
>>> On Fri, 2024-10-25 at 11:32 +0200, Matthieu Baerts (NGI0) wrote:
>>>> In a few places -- to get an endpoint, dump all of them, and
>>>> change
>>>> their flags -- the list is iterated while holding the pernet-
>>>>> lock,
>>>> but
>>>> only to read the content of the list. In these cases, we can
>>>> replace
>>>> the
>>>> spin locks, by RCU read ones, and use the _rcu variants to
>>>> iterate
>>>> over
>>>> the entries list in a lockless way.
>>>>
>>>> To make it clear, the lookup helpers using the _rcu variant are
>>>> renamed
>>>> with a _rcu suffix. The previous __lookup_addr() helper can then
>>>> be
>>>> removed, but __lookup_addr_by_id() is still needed.
>>>>
>>>> While at it, the IDs bitmap is copied before iterating the list
>>>> to
>>>> dump
>>>> the different addresses, to avoid any consistencies.
>>>>
>>>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>>> ---
>>>> Notes:
>>>>  - This is not a fix, a small improvement for -next.
>>>> ---
>>>>  net/mptcp/pm_netlink.c | 36 +++++++++++++++++++-----------------
>>>>  1 file changed, 19 insertions(+), 17 deletions(-)
>>>>
>>>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>>>> index
>>>> a93b9b7776b48781a883673fe5fd521a978487ff..f38e1ccd34e95cd88b179a8
>>>> b50e
>>>> 6965731542871 100644
>>>> --- a/net/mptcp/pm_netlink.c
>>>> +++ b/net/mptcp/pm_netlink.c
>>
>> (...)
>>
>>>> @@ -1872,16 +1872,18 @@ int mptcp_pm_nl_dump_addr(struct sk_buff
>>>> *msg,
>>>>  	struct net *net = sock_net(msg->sk);
>>>>  	struct mptcp_pm_addr_entry *entry;
>>>>  	struct pm_nl_pernet *pernet;
>>>> +	unsigned long id_bitmap[4];
>>>>  	int id = cb->args[0];
>>>>  	void *hdr;
>>>>  	int i;
>>>>  
>>>>  	pernet = pm_nl_get_pernet(net);
>>>> +	bitmap_copy(id_bitmap, pernet->id_bitmap,
>>>> MPTCP_PM_MAX_ADDR_ID + 1);
>>>
>>> I think the id bitmap should only be copied when id is 0:
>>>
>>> if (!id)
>>>   bitmap_copy(id_bitmap, pernet->id_bitmap, MPTCP_PM_MAX_ADDR_ID +
>>> 1);
>>>
>>> Since this mptcp_pm_nl_dump_addr() may be called repeatedly when
>>> the
>>> dump information is very long. We only copy it the first time it is
> 
> A correction is needed here. Regardless of whether the dump information
> is large or small, the dumpit function will be called repeatedly when
> dumpit returns non-zero. The loop stops when dumpit returns 0.
> 
>>> called, and subsequent calls cannot copy it again. WDYT?
>>
>> Sorry, I'm not sure to understand. Here, I did a local copy of
>> 'id_bitmap' just to keep a certain consistency if the bitmap is
>> changed
>> during the RCU read section below: not to have this bitmap being
>> changed
>> during the for loop here below. Before, we had this protection
>> because
>> pernet->lock was held.
> 
> It is precisely because we need to maintain this consistency that we
> need to copy the bitmap only once. If we copy the bitmap when dumpit is
> called a second time, the bitmap obtained at this time is a new bitmap,
> which destroys this consistency, right?

OK, but then I have a few questions:

- Was the code before my patch here prevented such consistency issues?
Or said differently: is there a regression introduced by this patch?

- Is it really an issue that can lead to a crash or reading freed info?

- Where would you store the copy of the bitmap? In cb-args?

- If we store this copy somewhere, could you not have situations where
the bitmap would no longer be in sync with the addresses that are stored
in 'pernet->local_addr_list', and then displaying wrong/freed info? It
looks like more would be needed to cope with that. And maybe that's not
worth it?

>> Are you suggesting here to keep a copy in the cb, not a local one, to
>> do
>> the copy only once? Are you sure it is worth it (and safe)?
> 
> Because dumpit will be called repeatedly, we need to ensure that the
> same bitmap is accessed each time, so we cannot use a local one, but
> need to keep a copy in the cb just like what we do in
> mptcp_userspace_pm_dump_addr.
> 
> 
> In addition, when doing bitmap_copy, we need to hold pernet->lock:
> 
> bitmap = (struct mptcp_id_bitmap *)cb->ctx;
> 
> if (!id) {
>   spin_lock_bh(&pernet->lock);
>   bitmap_copy(id_bitmap, pernet->id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
>   spin_unlock_bh(&pernet->lock);
> }

Ah yes, maybe, I need to check: I thought the modification of the bitmap
was done atomically, and it was fine to read without the lock. But maybe
not because it is stored in multiple bytes.

> Also, we can put this bitmap copy code into a separate patch, which is
> applied before this one. In this patch we only need to replace
> spin_lock_bh with rcu_read_lock.

OK so we are talking about separate fix that is not directly linked to
my change, apart from the fact I modified code around, right?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

