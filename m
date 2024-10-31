Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D5F19923A
	for <mptcp@lists.linux.dev>; Thu, 31 Oct 2024 23:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730417087; cv=none; b=rIX/hH/wE5VT5armw2ukmH2fa5Wiwvr+o09rA6cLYqHNZe6tLfaa1Pm+OYV1MOMeofLFOBTOv7kwMIwPMt3PyOHLJQrOWVsdzFXv/XFogk7y4vEIKRC7ztNtK/YmEJ0f5/5UqwQDpE/XHp7Fn/6EqBdjinvB9eO4nGFRufcn9o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730417087; c=relaxed/simple;
	bh=+RcXysD1E1bBGRQk/L90jnQogRr/+IWeIADCBR8N818=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DNjqucprNx09zCIGp6d4YF+LC2ZdbKXvee+29HCL8Gy3RANDqgtS/90OkCfVp6us151jVuTAIZFNP8b6xTIdbHlxrzTpvHTQtxpV9gG3gxXZUEoMAmAgGH+DPMrE7G0klgYyLSkdqop3N465OkfOZthThKnZTJltJAS390Gvj9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1ceJmBn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1ceJmBn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0D4C4CEC3;
	Thu, 31 Oct 2024 23:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730417087;
	bh=+RcXysD1E1bBGRQk/L90jnQogRr/+IWeIADCBR8N818=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=d1ceJmBngVmi5ErGOftHp3bdsX8moVtxXHXz7tkNPNeYcdRyMVwpH6iQIiyYQUrGH
	 FEnzQFkE8jpEiVtgB1pUFyvyAYWasngstAH5LMip2OBoUmCvvW5N9N/b+iDJKQz2Zn
	 AqzmuoSE8Ry+4dQXCpOIHe3uc5p3Gd/D4R8J/so9GfTrROvhNb1cCkjVMT0cf6kzcL
	 NOpBS1aPwVgQxjC+Ft4B1Lh7w2ESlvCaI4UYZBy9TIHB0WH+mD20n5vP4E91SUpAbD
	 UdZcwudqVJmdDYKFyZLPpRiHB6ii0/G5eKciip5PcCzVDBwhxk6jTXVySbxYY+HmC8
	 wNtfmbUpmxCwA==
Date: Thu, 31 Oct 2024 16:24:40 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev, 
    Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH mptcp-net v2 2/3] mptcp: pm: lockless list traversal
In-Reply-To: <7f5c3d67bad2a3e8773930128b0c3ddbccd0fd98.camel@kernel.org>
Message-ID: <64ed2e39-b3ac-bfc5-1f22-7f5fda69fbce@kernel.org>
References: <20241025-mptcp-pm-lookup_addr_rcu-v2-0-1478f6c4b205@kernel.org> <20241025-mptcp-pm-lookup_addr_rcu-v2-2-1478f6c4b205@kernel.org> <48c030b9f5156dddec50e8727062b8350a53f8a0.camel@kernel.org> <b303b3d0-1c0a-4c0a-8031-77023a2de005@kernel.org>
 <bb346392a148c223c9aed723ba5f45c8d9a2f34c.camel@kernel.org> <cb3c0685-a3ce-4009-b5a4-7e4fb9d4716e@kernel.org> <7f5c3d67bad2a3e8773930128b0c3ddbccd0fd98.camel@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1471392236-1730417087=:35686"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1471392236-1730417087=:35686
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 29 Oct 2024, Geliang Tang wrote:

> Hi Matt,
>
> On Mon, 2024-10-28 at 12:48 +0100, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 28/10/2024 03:08, Geliang Tang wrote:
>>> Hi Matt,
>>>
>>> On Fri, 2024-10-25 at 17:26 +0200, Matthieu Baerts wrote:
>>>> Hi Geliang,
>>>>
>>>> Thank you for the review!
>>>>
>>>> On 25/10/2024 16:25, Geliang Tang wrote:
>>>>> On Fri, 2024-10-25 at 11:32 +0200, Matthieu Baerts (NGI0)
>>>>> wrote:
>>>>>> In a few places -- to get an endpoint, dump all of them, and
>>>>>> change
>>>>>> their flags -- the list is iterated while holding the pernet-
>>>>>>> lock,
>>>>>> but
>>>>>> only to read the content of the list. In these cases, we can
>>>>>> replace
>>>>>> the
>>>>>> spin locks, by RCU read ones, and use the _rcu variants to
>>>>>> iterate
>>>>>> over
>>>>>> the entries list in a lockless way.
>>>>>>
>>>>>> To make it clear, the lookup helpers using the _rcu variant
>>>>>> are
>>>>>> renamed
>>>>>> with a _rcu suffix. The previous __lookup_addr() helper can
>>>>>> then
>>>>>> be
>>>>>> removed, but __lookup_addr_by_id() is still needed.
>>>>>>
>>>>>> While at it, the IDs bitmap is copied before iterating the
>>>>>> list
>>>>>> to
>>>>>> dump
>>>>>> the different addresses, to avoid any consistencies.
>>>>>>
>>>>>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>>>>> ---
>>>>>> Notes:
>>>>>>  - This is not a fix, a small improvement for -next.
>>>>>> ---
>>>>>>  net/mptcp/pm_netlink.c | 36 +++++++++++++++++++-------------
>>>>>> ----
>>>>>>  1 file changed, 19 insertions(+), 17 deletions(-)
>>>>>>
>>>>>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>>>>>> index
>>>>>> a93b9b7776b48781a883673fe5fd521a978487ff..f38e1ccd34e95cd88b1
>>>>>> 79a8
>>>>>> b50e
>>>>>> 6965731542871 100644
>>>>>> --- a/net/mptcp/pm_netlink.c
>>>>>> +++ b/net/mptcp/pm_netlink.c
>>>>
>>>> (...)
>>>>
>>>>>> @@ -1872,16 +1872,18 @@ int mptcp_pm_nl_dump_addr(struct
>>>>>> sk_buff
>>>>>> *msg,
>>>>>>   struct net *net = sock_net(msg->sk);
>>>>>>   struct mptcp_pm_addr_entry *entry;
>>>>>>   struct pm_nl_pernet *pernet;
>>>>>> + unsigned long id_bitmap[4];
>>>>>>   int id = cb->args[0];
>>>>>>   void *hdr;
>>>>>>   int i;
>>>>>>
>>>>>   pernet = pm_nl_get_pernet(net);
>>>>>> + bitmap_copy(id_bitmap, pernet->id_bitmap,
>>>>>> MPTCP_PM_MAX_ADDR_ID + 1);
>>>>>
>>>>> I think the id bitmap should only be copied when id is 0:
>>>>>
>>>>> if (!id)
>>>>>   bitmap_copy(id_bitmap, pernet->id_bitmap,
>>>>> MPTCP_PM_MAX_ADDR_ID +
>>>>> 1);
>>>>>
>>>>> Since this mptcp_pm_nl_dump_addr() may be called repeatedly
>>>>> when
>>>>> the
>>>>> dump information is very long. We only copy it the first time
>>>>> it is
>>>
>>> A correction is needed here. Regardless of whether the dump
>>> information
>>> is large or small, the dumpit function will be called repeatedly
>>> when
>>> dumpit returns non-zero. The loop stops when dumpit returns 0.
>>>
>>>>> called, and subsequent calls cannot copy it again. WDYT?
>>>>
>>>> Sorry, I'm not sure to understand. Here, I did a local copy of
>>>> 'id_bitmap' just to keep a certain consistency if the bitmap is
>>>> changed
>>>> during the RCU read section below: not to have this bitmap being
>>>> changed
>>>> during the for loop here below. Before, we had this protection
>>>> because
>>>> pernet->lock was held.
>>>
>>> It is precisely because we need to maintain this consistency that
>>> we
>>> need to copy the bitmap only once. If we copy the bitmap when
>>> dumpit is
>>> called a second time, the bitmap obtained at this time is a new
>>> bitmap,
>>> which destroys this consistency, right?
>>
>> OK, but then I have a few questions:
>>
>> - Was the code before my patch here prevented such consistency
>> issues?
>> Or said differently: is there a regression introduced by this patch?
>>
>> - Is it really an issue that can lead to a crash or reading freed
>> info?
>>
>> - Where would you store the copy of the bitmap? In cb-args?
>>
>> - If we store this copy somewhere, could you not have situations
>> where
>> the bitmap would no longer be in sync with the addresses that are
>> stored
>> in 'pernet->local_addr_list', and then displaying wrong/freed info?
>> It
>> looks like more would be needed to cope with that. And maybe that's
>> not
>> worth it?
>
> Your doubts are very reasonable. It seems that I have not considered it
> carefully enough. So we do need to define a local bitmap and copy it
> every time. It's fine to me and it's OK to implement BPF path manager
> based on it.
>

Matthieu and Geliang -

I think the only way to guarantee strict consistency would be to acquire 
the lock at the beginning of the dump and make a complete copy of both the 
bitmap and the address list at that moment. Even with all the work to 
achieve this "strictly consistent" snapshot, the userspace caller doesn't 
have any guarantee that the dumped data is accurate at the moment the 
netlink response completes.


The good news is that I don't think this strict consistency is needed for 
the dump function. If the list is being modified concurrently, it's not a 
big problem to miss newly-added entries or show recently-deleted ones.


Since bitmap_copy() is non-atomic, my suggestion is to not copy the 
bitmap. Instead use test_bit() (which is atomic) directly on 
pernet->id_bitmap without locking.

Then, make sure that inconsistencies between the bitmap and the 
local_addr_list are handled cleanly. The two cases are:

1. Bitmap has a 0 even though there's a new entry in local_addr_list. In 
this case it gets skipped. No problem here.

2. Bitmap has a 1 even though there's no entry in local_addr_list (ignore 
it!), or there's an entry that is in the process of getting freed. For the 
latter, RCU will ensure there's no risk of an invalid dereference. If we 
want to detect a deletion-in-progress, we would have to add an atomic flag 
to 'struct mptcp_pm_addr_entry' that is set before the deletion code calls 
list_del_rcu(). Even if the address is in this state, I would argue that 
the just-barely-stale data is fine to show.


Sound reasonable? Do you see a reason that bitmap/addr_list 
inconsistencies would cause issues?

Thanks

- Mat


>>
>>>> Are you suggesting here to keep a copy in the cb, not a local
>>>> one, to
>>>> do
>>>> the copy only once? Are you sure it is worth it (and safe)?
>>>
>>> Because dumpit will be called repeatedly, we need to ensure that
>>> the
>>> same bitmap is accessed each time, so we cannot use a local one,
>>> but
>>> need to keep a copy in the cb just like what we do in
>>> mptcp_userspace_pm_dump_addr.
>>>
>>>
>>> In addition, when doing bitmap_copy, we need to hold pernet->lock:
>>>
>>> bitmap = (struct mptcp_id_bitmap *)cb->ctx;
>>>
>>> if (!id) {
>>>   spin_lock_bh(&pernet->lock);
>>>   bitmap_copy(id_bitmap, pernet->id_bitmap, MPTCP_PM_MAX_ADDR_ID +
>>> 1);
>>>   spin_unlock_bh(&pernet->lock);
>>> }
>>
>> Ah yes, maybe, I need to check: I thought the modification of the
>> bitmap
>> was done atomically, and it was fine to read without the lock. But
>> maybe
>> not because it is stored in multiple bytes.



>>
>>> Also, we can put this bitmap copy code into a separate patch, which
>>> is
>>> applied before this one. In this patch we only need to replace
>>> spin_lock_bh with rcu_read_lock.
>>
>> OK so we are talking about separate fix that is not directly linked
>> to
>> my change, apart from the fact I modified code around, right?
>>
>> Cheers,
>> Matt
>
>
>
--0-1471392236-1730417087=:35686--
