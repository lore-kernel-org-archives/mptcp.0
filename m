Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6772A8FE
	for <mptcp@lists.linux.dev>; Thu, 18 Jul 2024 15:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721315483; cv=none; b=VDRO1XPS9NsxVyYK/M3cSMOJ51kR8kMFKGbmOZ/3/XHYwCbF2mfDDHjk6WqMLAMRe6oFhewzRQES7QYFRIaw+c3fl0uDq+EHoAfWd7rGRQwqueJtPKYLa7gz7Q7iuz7J8D7Wkm4xuNUP7y2SiKFoFNN2EGGsrqPdAgEK0OAo1jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721315483; c=relaxed/simple;
	bh=xHgteYpqHFFS5+8H9z22n+Dwz+2rD6CAfAFjhK6c3VQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z6bJpun5M/OGTFcoPO9wKhguaXNxMs2+iNiY5Yvb6AQdy9rYLGvv+v2ZF+STi/Nd2Q7ppBttl6hUEdzo1z8HcK/nFYZYjuINxXLJWIysPsH6CiWoY8pTO1/AV7c66Uy4V17n5n8V7gI9GSZ2qHizZXpBCcyzIce40/MIXZ7Wg/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tTDRAGFZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tTDRAGFZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E61C4AF09;
	Thu, 18 Jul 2024 15:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721315482;
	bh=xHgteYpqHFFS5+8H9z22n+Dwz+2rD6CAfAFjhK6c3VQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tTDRAGFZIDpeoIez9dvMZ8DuyuKp8BgPi4Xrp0JzAOtOrqH5MXAYin7k4r6I+FeeY
	 SwXBKcL4yxwT6VpZtbzSh8HEAYjkWRK7T35FFZrvNTIk3p30NQmS7w8p0AnoMfNn2t
	 ZQ68idsMxUHMeorw7woyh4e9xdt5YvzKaRQekV8nAZP52sfu3zwUVdUdXO1qFK0HkB
	 24+L0p+7YHKnQMHaqK0FrlvW9Duhbc5e8gCSKDUMswveN7540mF5BqV2zPLzxFlBpo
	 gdboL13smXRSwsx4UjERnVWQ/SufQPq7sBJKFxT/JomRGA2cqqxZZ0EgUsC8XUt9af
	 zjMYzqgR/imdQ==
Message-ID: <994db3ae-2359-40f9-bd2f-f2e247027391@kernel.org>
Date: Thu, 18 Jul 2024 17:11:19 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v2 6/9] mptcp: pm: fix backup support in signal
 endpoints
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
References: <20240716-mptcp-backup-mpj-v2-0-4d50247405fb@kernel.org>
 <20240716-mptcp-backup-mpj-v2-6-4d50247405fb@kernel.org>
 <Zpc0qmOTE4ykQ1lr@T480>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <Zpc0qmOTE4ykQ1lr@T480>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

Thank you for the review!

On 17/07/2024 05:04, Geliang Tang wrote:
> Hi Matt,
> 
> On Tue, Jul 16, 2024 at 10:53:18PM +0200, Matthieu Baerts (NGI0) wrote:
>> There was a support for signal endpoints, but only when the endpoint's
>> flag was changed during a connection. If an endpoint with the signal and
>> backup was already present, the MP_JOIN reply was not containing the
>> backup flag as expected.
>>
>> That's confusing to have this inconsistent behaviour. On the other hand,
>> the infrastructure to set the backup flag in the SYN + ACK + MP_JOIN was
>> already there, it was just never set before. Now when requesting the
>> local ID from the path-manager, the backup status is also requested.
>>
>> There is a special case for the ID0: the PM has to return this ID0 if
>> the local address of the initial subflow is being used, and not the ID
>> of the related endpoint. Still, it is required to look at the different
>> endpoints to find if one has been defined for this address with the
>> backup flag.
>>
>> Note that when the userspace PM is used, the backup flag can be set if
>> the local address was already used before with a backup flag, e.g. if
>> the address was announced with the 'backup' flag, or a subflow was
>> created with the 'backup' flag.

(...)

>> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
>> index 55406720c607..359738b8826e 100644
>> --- a/net/mptcp/pm.c
>> +++ b/net/mptcp/pm.c
>> @@ -405,7 +405,8 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
>>  	return ret;
>>  }
>>  
>> -int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
>> +int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc,
>> +			  bool *backup)
>>  {
>>  	struct mptcp_addr_info skc_local;
>>  	struct mptcp_addr_info msk_local;
>> @@ -418,12 +419,18 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
>>  	 */
>>  	mptcp_local_address((struct sock_common *)msk, &msk_local);
>>  	mptcp_local_address((struct sock_common *)skc, &skc_local);
>> -	if (mptcp_addresses_equal(&msk_local, &skc_local, false))
>> +	if (mptcp_addresses_equal(&msk_local, &skc_local, false)) {
>> +		if (mptcp_pm_is_userspace(msk))
>> +			*backup = mptcp_userspace_pm_is_backup(msk, &skc_local);
>> +		else
>> +			*backup = mptcp_pm_nl_is_backup(msk, &skc_local);
>> +
>>  		return 0;
>> +	}
>>  
>>  	if (mptcp_pm_is_userspace(msk))
>> -		return mptcp_userspace_pm_get_local_id(msk, &skc_local);
>> -	return mptcp_pm_nl_get_local_id(msk, &skc_local);
>> +		return mptcp_userspace_pm_get_local_id(msk, &skc_local, backup);
>> +	return mptcp_pm_nl_get_local_id(msk, &skc_local, backup);
>>  }
> 
> I think that instead of mixing "backup" into get_local_id() interface, it is much
> better to add a new interface is_backup() for PM in pm.c:
> 
> bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc)
> {
>        struct mptcp_addr_info skc_local;
> 
>        mptcp_local_address((struct sock_common *)skc, &skc_local);
> 
>        if (mptcp_pm_is_userspace(msk))
>                return mptcp_userspace_pm_is_backup(msk, &skc_local);
>        return mptcp_pm_nl_is_backup(msk, &skc_local);
> }
> 
> No need to test whether the two addresses msk_local and skc_local are the same
> in mptcp_pm_is_backup(), just invoke mptcp_pm_nl_is_backup() or
> mptcp_userspace_pm_is_backup() with skc_local.
I initially wanted to avoid iterating the entry list twice in some
cases, but this special case for the ID0 increases the complexity of the
code. I can indeed switch to a new dedicated helper, thanks!

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

