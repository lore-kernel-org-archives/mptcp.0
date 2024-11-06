Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EC320513B
	for <mptcp@lists.linux.dev>; Wed,  6 Nov 2024 16:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730908990; cv=none; b=YBld3KWH3UEhXdLWsTqNPsXsH18ZnAvjgRG0rOB+X20wwdiI6J4LNVhbd4N1Gkh+pV8paGn4bhtptdnDxAFkMcWAeBS1/X9/AT9lGMxiykXWrJ4CzW370KomGA7m60oIdHtGYPJdKQAFqlbYrFA38vdoBdIyZxdZb9n3JPpQMMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730908990; c=relaxed/simple;
	bh=0thG9b1mk9TFnM+u/nC+IDJC5mqvj5/rqejw1pVItuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kDlAf+Qc6eccwVjkLhrmUop/K42rVfyOYgzG2rbwp4ef27qfrHj3bdj8tcdk4pQcnL9rhTsEehyUJFiKQioEWN9tl5c/kCkOZxSx30UWKOJWADjtQ9gnhtAr3J2dsV6yxqxxOoc13E/tT/5TJYf6yTmWdmwHF56bpwiN4xTN0HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+tKp5tM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+tKp5tM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34725C4CECC;
	Wed,  6 Nov 2024 16:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730908988;
	bh=0thG9b1mk9TFnM+u/nC+IDJC5mqvj5/rqejw1pVItuM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=E+tKp5tMX8jSu1NLF1NXdbxrpWS6BzPLFUujYVHgv/dTGEhDA+kAK1Am4EMwG6t++
	 Rp4fdYxfs3BsmV5Q631/xjPDjNvXTivg06xop3Fe44rTe5jUstpc9xN4xUZ3iLkIu0
	 PLJtamFjNEkll2FN41o0PYebVuqGPRcOtIRQzsfmzJmB1R/dFONioB3x+r5NhkZbWO
	 rn2d3ustT8Ndn8fwMsL0M80eWX9b9E/UGHmSE8SrQt3ADiCvhlQfFljSnKE4kPa2mX
	 1QWtqChakRIGBzeYGd02RbuthVSbTrc4vlz3BVUuR8qzbZhMCl9H2DxnmJIhQt0E3b
	 Ja42PkNGXxuZA==
Message-ID: <6b7ec8d9-146a-4485-af7f-899b6fd1633f@kernel.org>
Date: Wed, 6 Nov 2024 17:03:05 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v2 2/3] mptcp: pm: lockless list traversal
Content-Language: en-GB
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
References: <20241025-mptcp-pm-lookup_addr_rcu-v2-0-1478f6c4b205@kernel.org>
 <20241025-mptcp-pm-lookup_addr_rcu-v2-2-1478f6c4b205@kernel.org>
 <48c030b9f5156dddec50e8727062b8350a53f8a0.camel@kernel.org>
 <b303b3d0-1c0a-4c0a-8031-77023a2de005@kernel.org>
 <bb346392a148c223c9aed723ba5f45c8d9a2f34c.camel@kernel.org>
 <cb3c0685-a3ce-4009-b5a4-7e4fb9d4716e@kernel.org>
 <7f5c3d67bad2a3e8773930128b0c3ddbccd0fd98.camel@kernel.org>
 <64ed2e39-b3ac-bfc5-1f22-7f5fda69fbce@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <64ed2e39-b3ac-bfc5-1f22-7f5fda69fbce@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 01/11/2024 00:24, Mat Martineau wrote:
> On Tue, 29 Oct 2024, Geliang Tang wrote:
> 
>> Hi Matt,
>>
>> On Mon, 2024-10-28 at 12:48 +0100, Matthieu Baerts wrote:
>>> Hi Geliang,
>>>
>>> On 28/10/2024 03:08, Geliang Tang wrote:
>>>> Hi Matt,
>>>>
>>>> On Fri, 2024-10-25 at 17:26 +0200, Matthieu Baerts wrote:
>>>>> Hi Geliang,
>>>>>
>>>>> Thank you for the review!
>>>>>
>>>>> On 25/10/2024 16:25, Geliang Tang wrote:
>>>>>> On Fri, 2024-10-25 at 11:32 +0200, Matthieu Baerts (NGI0)
>>>>>> wrote:
>>>>>>> In a few places -- to get an endpoint, dump all of them, and
>>>>>>> change
>>>>>>> their flags -- the list is iterated while holding the pernet-
>>>>>>>> lock,
>>>>>>> but
>>>>>>> only to read the content of the list. In these cases, we can
>>>>>>> replace
>>>>>>> the
>>>>>>> spin locks, by RCU read ones, and use the _rcu variants to
>>>>>>> iterate
>>>>>>> over
>>>>>>> the entries list in a lockless way.
>>>>>>>
>>>>>>> To make it clear, the lookup helpers using the _rcu variant
>>>>>>> are
>>>>>>> renamed
>>>>>>> with a _rcu suffix. The previous __lookup_addr() helper can
>>>>>>> then
>>>>>>> be
>>>>>>> removed, but __lookup_addr_by_id() is still needed.
>>>>>>>
>>>>>>> While at it, the IDs bitmap is copied before iterating the
>>>>>>> list
>>>>>>> to
>>>>>>> dump
>>>>>>> the different addresses, to avoid any consistencies.
>>>>>>>
>>>>>>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>>>>>> ---
>>>>>>> Notes:
>>>>>>>  - This is not a fix, a small improvement for -next.
>>>>>>> ---
>>>>>>>  net/mptcp/pm_netlink.c | 36 +++++++++++++++++++-------------
>>>>>>> ----
>>>>>>>  1 file changed, 19 insertions(+), 17 deletions(-)
>>>>>>>
>>>>>>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>>>>>>> index
>>>>>>> a93b9b7776b48781a883673fe5fd521a978487ff..f38e1ccd34e95cd88b1
>>>>>>> 79a8
>>>>>>> b50e
>>>>>>> 6965731542871 100644
>>>>>>> --- a/net/mptcp/pm_netlink.c
>>>>>>> +++ b/net/mptcp/pm_netlink.c
>>>>>
>>>>> (...)
>>>>>
>>>>>>> @@ -1872,16 +1872,18 @@ int mptcp_pm_nl_dump_addr(struct
>>>>>>> sk_buff
>>>>>>> *msg,
>>>>>>>   struct net *net = sock_net(msg->sk);
>>>>>>>   struct mptcp_pm_addr_entry *entry;
>>>>>>>   struct pm_nl_pernet *pernet;
>>>>>>> + unsigned long id_bitmap[4];
>>>>>>>   int id = cb->args[0];
>>>>>>>   void *hdr;
>>>>>>>   int i;
>>>>>>>
>>>>>>   pernet = pm_nl_get_pernet(net);
>>>>>>> + bitmap_copy(id_bitmap, pernet->id_bitmap,
>>>>>>> MPTCP_PM_MAX_ADDR_ID + 1);
>>>>>>
>>>>>> I think the id bitmap should only be copied when id is 0:
>>>>>>
>>>>>> if (!id)
>>>>>>   bitmap_copy(id_bitmap, pernet->id_bitmap,
>>>>>> MPTCP_PM_MAX_ADDR_ID +
>>>>>> 1);
>>>>>>
>>>>>> Since this mptcp_pm_nl_dump_addr() may be called repeatedly
>>>>>> when
>>>>>> the
>>>>>> dump information is very long. We only copy it the first time
>>>>>> it is
>>>>
>>>> A correction is needed here. Regardless of whether the dump
>>>> information
>>>> is large or small, the dumpit function will be called repeatedly
>>>> when
>>>> dumpit returns non-zero. The loop stops when dumpit returns 0.
>>>>
>>>>>> called, and subsequent calls cannot copy it again. WDYT?
>>>>>
>>>>> Sorry, I'm not sure to understand. Here, I did a local copy of
>>>>> 'id_bitmap' just to keep a certain consistency if the bitmap is
>>>>> changed
>>>>> during the RCU read section below: not to have this bitmap being
>>>>> changed
>>>>> during the for loop here below. Before, we had this protection
>>>>> because
>>>>> pernet->lock was held.
>>>>
>>>> It is precisely because we need to maintain this consistency that
>>>> we
>>>> need to copy the bitmap only once. If we copy the bitmap when
>>>> dumpit is
>>>> called a second time, the bitmap obtained at this time is a new
>>>> bitmap,
>>>> which destroys this consistency, right?
>>>
>>> OK, but then I have a few questions:
>>>
>>> - Was the code before my patch here prevented such consistency
>>> issues?
>>> Or said differently: is there a regression introduced by this patch?
>>>
>>> - Is it really an issue that can lead to a crash or reading freed
>>> info?
>>>
>>> - Where would you store the copy of the bitmap? In cb-args?
>>>
>>> - If we store this copy somewhere, could you not have situations
>>> where
>>> the bitmap would no longer be in sync with the addresses that are
>>> stored
>>> in 'pernet->local_addr_list', and then displaying wrong/freed info?
>>> It
>>> looks like more would be needed to cope with that. And maybe that's
>>> not
>>> worth it?
>>
>> Your doubts are very reasonable. It seems that I have not considered it
>> carefully enough. So we do need to define a local bitmap and copy it
>> every time. It's fine to me and it's OK to implement BPF path manager
>> based on it.
>>
> 
> Matthieu and Geliang -
> 
> I think the only way to guarantee strict consistency would be to acquire
> the lock at the beginning of the dump and make a complete copy of both
> the bitmap and the address list at that moment. Even with all the work
> to achieve this "strictly consistent" snapshot, the userspace caller
> doesn't have any guarantee that the dumped data is accurate at the
> moment the netlink response completes.
> 
> 
> The good news is that I don't think this strict consistency is needed
> for the dump function. If the list is being modified concurrently, it's
> not a big problem to miss newly-added entries or show recently-deleted
> ones.
> 
> 
> Since bitmap_copy() is non-atomic, my suggestion is to not copy the
> bitmap. Instead use test_bit() (which is atomic) directly on pernet-
>>id_bitmap without locking.
> 
> Then, make sure that inconsistencies between the bitmap and the
> local_addr_list are handled cleanly. The two cases are:
> 
> 1. Bitmap has a 0 even though there's a new entry in local_addr_list. In
> this case it gets skipped. No problem here.
> 
> 2. Bitmap has a 1 even though there's no entry in local_addr_list
> (ignore it!), or there's an entry that is in the process of getting
> freed. For the latter, RCU will ensure there's no risk of an invalid
> dereference. If we want to detect a deletion-in-progress, we would have
> to add an atomic flag to 'struct mptcp_pm_addr_entry' that is set before
> the deletion code calls list_del_rcu(). Even if the address is in this
> state, I would argue that the just-barely-stale data is fine to show.

Thank you for your review!

> Sound reasonable? Do you see a reason that bitmap/addr_list
> inconsistencies would cause issues?
Yes, that's sounds reasonable, as long as we don't try to access freed
resources, I don't think we need to worry about inconsistencies if there
are ongoing changes while the userspace is requesting the list.

When I did the copy of the bitmap, it was mainly "as a matter of
principle", but if it is not needed, that's even simpler.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

