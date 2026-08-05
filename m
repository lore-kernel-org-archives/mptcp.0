Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B063F23A6
	for <mptcp@lists.linux.dev>; Wed,  5 Aug 2026 16:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948210; cv=none; b=i6aDu3vg4KAaIFjTAcv6s7pzJUVzxXrF5vsEC8cvey2yKl8x/ZUOqOFlu93Iq0Y4ZTU+ZVnANlnN6bc1ftkTjFUqm7RADqg2pJSfPDSrayaRaTAcdK9NGBW2ABBKsanc+vM7/XWQrZ6g4E743rQDlJwDASqo3rwAi6OIwUZkR/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948210; c=relaxed/simple;
	bh=svXov/+/qacZXuCaADwR0fARBj86nQMY51zilcm/8c0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=e1tz5aZtLr0ClkliU05Qi5HQIJoziGVuCpLMGlQ9Cc9/3zi1Ivdr/JfHdTSupLvcEanTYaw1IezGGx7FU0RQYAnr5fksWPW5sbn174aWBJBGzZXkpsrH+lUjGkldkJQeIWSqjFeXhAaFw92n+JsD32ggRN0ZtIKJnRCHD4I4X+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0a1a1Dw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0a1a1Dw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36221F000E9
	for <mptcp@lists.linux.dev>; Wed,  5 Aug 2026 16:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785948209;
	bh=tji+GcZCXBNfxnDnTeLhiBD3OHZ6C0En0VGACUwku6Q=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=M0a1a1DwhniKJ8E3n81dueh2w8TNyAe26tgs92Aztghuk5NdTUe1u2qYJAcM/Pcoj
	 +olMxcqFNy54uaQUzj374e3yADKMO29W+zpcfHCSvlNntiQVkJycqTcKl22EQ/UN1a
	 nC1/8bAGC0EzUL9OopSsFXCViNZAK/VsmhfK0o+5joBnQ5jIVgRJOObx+DPCZLRNub
	 ZQkXWvDErTUDqvAfWhemOFfFX6e48w3LjH/usmV/nce4+QPSyfDj5eLXP3HbwZgoC9
	 jxnOomyd/ie8lZxN3Ge6WojeqoYATPuutr/rOtz0d4jHmZyKUYQBUvvPbMJU1SVHFd
	 UaGhMprNHPzEA==
Message-ID: <68abb788-0804-4afe-8c0d-b4b6d566c365@kernel.org>
Date: Wed, 5 Aug 2026 18:43:27 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net 1/6] mptcp: pm: userspace: properly handle the
 ID0 case
Content-Language: fr
To: MPTCP Linux <mptcp@lists.linux.dev>
References: <20260727-mptcp-pm-userspace-id0-case-v1-0-9877f02a9bae@kernel.org>
 <20260727-mptcp-pm-userspace-id0-case-v1-1-9877f02a9bae@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260727-mptcp-pm-userspace-id0-case-v1-1-9877f02a9bae@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Replying to Sashiko's review:
>> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
>> index 73094bdbdbf27..6e6eeda91ade0 100644
>> --- a/net/mptcp/pm_userspace.c
>> +++ b/net/mptcp/pm_userspace.c
>> @@ -55,7 +55,10 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
>>  
>>  	spin_lock_bh(&msk->pm.lock);
>>  	mptcp_for_each_userspace_pm_addr(msk, e) {
>> -		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true);
>> +		/* allow matching ID0 when no port is specified */
>> +		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr,
>> +						   e->addr.id != 0 ||
>> +						   entry->addr.port != 0);
>>  		if (addr_match && entry->addr.id == 0 && needs_id)
>>  			entry->addr.id = e->addr.id;
>>  		id_match = (e->addr.id == entry->addr.id);
>>  		if (addr_match || id_match)
>>  			break;
> 
> With ID 0 now always present in userspace_pm_local_addr_list, does this
> id_match check prematurely break the loop for new unassigned addresses?
> 
> If an unconfigured address is evaluated (e.g. from an incoming MP_JOIN
> request), entry->addr.id defaults to 0. Since the pre-added initial address
> (ID 0) is now in the list, e->addr.id == entry->addr.id (0 == 0) will be
> true, falsely detecting an ID collision and preventing the new address from
> being inserted.

I guess it meant "if the IP address is not the same". If it is, now the
right ID0 will be returned instead of a new one. If the address is
different, then yes, id_match should always be false when needs_id is
set. I will adapt that in a v2. (The bug was also present before when
the ID0 was in the list.)

>> @@ -692,6 +695,24 @@ int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
>>  	return ret;
>>  }
>>  
>> +/* Add the initial local address (ID0) to the local list: easier that way */
>> +void mptcp_pm_userspace_created(struct mptcp_sock *msk, const struct sock *ssk)
>> +{
>> +	struct mptcp_pm_addr_entry *entry;
>> +
>> +	entry = sock_kmalloc((struct sock *)msk, sizeof(*entry), GFP_ATOMIC);
>> +	/* Fine not to handle the ID0 case in memory pressure */
>> +	if (!entry)
>> +		return;
>> +
>> +	memset(entry, 0, sizeof(*entry));
>> +	mptcp_local_address((struct sock_common *)ssk, &entry->addr);
>> +
>> +	spin_lock_bh(&msk->pm.lock);
>> +	list_add_tail_rcu(&entry->list, &msk->pm.userspace_pm_local_addr_list);
> 
> Does this code forget to increment msk->pm.local_addr_used?

No, on purpose.

> When this address is added here, the counter is not incremented. Later, if
> userspace creates a subflow using ID 0 and destroys it, or if subflow creation
> fails, mptcp_userspace_pm_delete_local_addr() will unconditionally decrement
> msk->pm.local_addr_used. This could cause the counter to underflow to 255
> and permanently remove the ID 0 address from the list.

Indeed, an exception is needed there. Will add that in v2.

> 
>> +	spin_unlock_bh(&msk->pm.lock);
>> +}

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
