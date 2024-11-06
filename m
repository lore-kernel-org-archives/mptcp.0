Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D95518B48B
	for <mptcp@lists.linux.dev>; Wed,  6 Nov 2024 16:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730910183; cv=none; b=CDX3SvK8f8RcigP8Sh4w2HczkfSyQ2NFZglwQEZGtUWBLfzTeyBRx0cJyLizoo6qc4lIOM09gReEBJMhQ6MegK7Wh2WxV501dlbsNfayinZ07CrkE2d8q+L5mQdRua3Gabo5p5O1/ceDO4/jhLo2WR4AUWwv0yVaEfnZoL5yksg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730910183; c=relaxed/simple;
	bh=safYba+OwF7Ko8srXVTVKOdHRuphn0F5dikZK+sncT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=Vhi8tMgMOjq3lZycCUyncsGnnTnIYUFkJTUgnGV828gT5vfFp4AAOfW54fX/OZ9hWETRZgzQByxEex+usSIFZBv05jcYedw2y9uTpWqqFDRUmJS1K2qAFutIn0p6TEdQdr3lR4XAGznVvplyPMKzkJktwvjUkIkInjJn/e4432A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahxvCluF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahxvCluF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB6CC4CEC6;
	Wed,  6 Nov 2024 16:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730910183;
	bh=safYba+OwF7Ko8srXVTVKOdHRuphn0F5dikZK+sncT4=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=ahxvCluF/RAhbasvTG7nS9DMl8tHPxWCXRSusLhNjzv2Apn/iyxbURQKZUwlvFD3f
	 wVUyzjlw/2MrMaIA14VQP/B4cDF0j4LGMB4Ya2S0tuBBq6JT4eTQgTuVrGFAS2BdmY
	 e6s9+pYCjVohzCsIpGgge36ViAmtXkMmk3weMfLWrkayCBCRLn5SLwrRVzgn4aR0w4
	 ISRWKgQb63uGTtMk0vko5P7gBJbWjPBCIPFh4sJeaf3s917cA0ptHIKOVmrzqjvX6w
	 5S5FYo5ELNJIr9nSPIq3AmX+ZJnNcUyaeTQzPUayN9Jn4Yv0vUIIxxuc2obk6maCJ/
	 xuOpiZKPbSBbQ==
Message-ID: <d1479a97-c94c-4aa0-ad81-f109538535b8@kernel.org>
Date: Wed, 6 Nov 2024 17:23:00 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v2 2/3] mptcp: pm: lockless list traversal
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>
References: <20241025-mptcp-pm-lookup_addr_rcu-v2-0-1478f6c4b205@kernel.org>
 <20241025-mptcp-pm-lookup_addr_rcu-v2-2-1478f6c4b205@kernel.org>
 <053267b3-a22e-4c3d-833b-55edda46ba25@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
Cc: mptcp@lists.linux.dev
In-Reply-To: <053267b3-a22e-4c3d-833b-55edda46ba25@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

Thank you for the review!

On 05/11/2024 19:21, Paolo Abeni wrote:
> On 10/25/24 11:32, Matthieu Baerts (NGI0) wrote:
>> @@ -2060,17 +2062,17 @@ int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
>>  	if (addr.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
>>  		bkup = 1;
>>  
>> -	spin_lock_bh(&pernet->lock);
>> -	entry = lookup_by_id ? __lookup_addr_by_id(pernet, addr.addr.id) :
>> -			       __lookup_addr(pernet, &addr.addr);
>> +	rcu_read_lock();
>> +	entry = lookup_by_id ? __lookup_addr_by_id_rcu(pernet, addr.addr.id) :
>> +			       __lookup_addr_rcu(pernet, &addr.addr);
>>  	if (!entry) {
>> -		spin_unlock_bh(&pernet->lock);
>> +		rcu_read_unlock();
>>  		GENL_SET_ERR_MSG(info, "address not found");
>>  		return -EINVAL;
>>  	}
>>  	if ((addr.flags & MPTCP_PM_ADDR_FLAG_FULLMESH) &&
>>  	    (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
>> -		spin_unlock_bh(&pernet->lock);
>> +		rcu_read_unlock();
>>  		GENL_SET_ERR_MSG(info, "invalid addr flags");
>>  		return -EINVAL;
>>  	}
>> @@ -2078,7 +2080,7 @@ int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
>>  	changed = (addr.flags ^ entry->flags) & mask;
>>  	entry->flags = (entry->flags & ~mask) | (addr.flags & mask);
>>  	addr = *entry;
>> -	spin_unlock_bh(&pernet->lock);
>> +	rcu_read_unlock();
>>  
>>  	mptcp_nl_set_flags(net, &addr.addr, bkup, changed);
>>  	return 0;
>>
> 
> I think we must retain the lock in this function, otherwise we could
> end-up with an unexpected flag combination.
> 
> i.e. set_flag(MPTCP_PM_ADDR_FLAG_FULLMESH) and
> set_flag(MPTCP_PM_ADDR_FLAG_SIGNAL) run concurrently on CPU1 and CPU2.
> entry->flags could end-up having a single bit set instead of both, if
> both CPUs read the entry before the other would store the new value.

Good point, I didn't think about this case where two commands would be
done in parallel from the userspace. But can we get this case? By
default, are the commands not serialised? (linked to parallel_ops member
in struct genl_family?)

In this case, is it OK to switch to rcu_read_lock? Or is it maybe not
worth it?

> I don't think _ONCE() annotations will be enough to avoid such thing
> without a lock.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

