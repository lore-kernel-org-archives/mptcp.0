Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA30247D93C
	for <mptcp@lists.linux.dev>; Wed,  5 Aug 2026 16:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948218; cv=none; b=Pg8cc+jYoPiWKCP1sUyA5AX+LXxBM9oq8GGsYJOy1SeVMwvuss5fkFodD1t1h5f735oeCO8GZNMMJ5xQiJnj6rHdGuHvh4EtoYlWfkQN6F4aKiJDeLryRHpcJve5g3WgA96/JIhWGk/00BVJQIiPXIWH2EYyol//U/gc1sPidf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948218; c=relaxed/simple;
	bh=m+DaYMTzRvYL1ZbMsRCuthE2sPGFkPySK7Vb4Myiq7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FEiwhkqLUBmKNHrup9cczwPjIaHAAKrDAwbfdAUNy/99/FYqAm4upWoWFplPU4SmdIXAR5jfxh2WXjLo+SNMJtNK4/fo03ou1PBiAIkHKTYlfmQ/YDYEj99iCWKeQvPedxH7c6gKbSdgF9JPIywGlEOy/QWURrdmXhFDlyDgFlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5XWbCcl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5XWbCcl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C1871F00A3A
	for <mptcp@lists.linux.dev>; Wed,  5 Aug 2026 16:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785948217;
	bh=QShTgui7c8EIeqUFSSvHCLazN79sqJhph1q6frDc8Fg=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=K5XWbCcluVbHAAex8fJYch12lMU1xei6fluFvJW+7FTuBZjDBh5BnGKpy96bjLFqK
	 2omo2KeYqkcsrE5xAtUlGYlXQ0D8OXRcdR43j+s5YiT2LNm1cQ5919RPQWMLOaBZYj
	 zC5PHCoxy1t+g3bAAHkFvacBDPDCSjTNQ0H69RhtlgFSwGtFUTz9t8fiSl0p/qoFxo
	 0/Cnl+Dof/jVN5CyvIV9+NQqmzpceoy+kbg1hINB+Vv3PVwEzb2V/GhHcTE7fi8NbR
	 aHtrarj78STxV3j0vgKqlTByWVJDG+119vZ5wV8G6BkM33qsincInQA1OUcfP9+OKK
	 /7Grp3FuAmk1A==
Message-ID: <cb57842a-8b2a-451b-8eb4-9fbf4f5412d1@kernel.org>
Date: Wed, 5 Aug 2026 18:43:36 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net 3/6] mptcp: pm: userspace: no ID0 exception for
 RM_ADDR
Content-Language: fr
To: MPTCP Linux <mptcp@lists.linux.dev>
References: <20260727-mptcp-pm-userspace-id0-case-v1-0-9877f02a9bae@kernel.org>
 <20260727-mptcp-pm-userspace-id0-case-v1-3-9877f02a9bae@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260727-mptcp-pm-userspace-id0-case-v1-3-9877f02a9bae@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Replying to Sashiko's review:

>> After the first patch of this series, the initial ID0 address is present
>> in the local addr list when the connection has been created.
> 
> Does adding the initial ID 0 address to the local address list cause
> secondary subflow creation to fail for incoming joins on unannounced
> addresses?
> 
> When a secondary subflow is initiated using a new address with ID 0,
> mptcp_userspace_pm_append_new_local_addr() loops over the list.
> 
> The new entry will match the ID 0 of the initial address (id_match = true)
> but its IP differs (addr_match = false).
> 
> This causes the loop to break, bypassing allocation and ID assignment,
> and returns -EINVAL.

Same comment as on patch 1/6.

> Does destroying the initial subflow (ID 0) via userspace PM cause an
> underflow of msk->pm.local_addr_used?
> 
> If the initial ID 0 connection address is added without incrementing
> the local_addr_used counter, later calling MPTCP_PM_CMD_SUBFLOW_DESTROY
> on ID 0 will unconditionally decrement it in
> mptcp_userspace_pm_delete_local_addr().
> 
> Could this wrap the 8-bit counter to 255 and corrupt the statistics
> exported to userspace?

Same comment as on patch 1/6.
>> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
>> index 4c96433590e36..9c7fab6a59bf4 100644
>> --- a/net/mptcp/pm_userspace.c
>> +++ b/net/mptcp/pm_userspace.c
> 
> [ ... ]
> 
>> @@ -315,11 +284,6 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
>>  
>>  	sk = (struct sock *)msk;
>>  
>> -	if (id_val == 0) {
>> -		err = mptcp_userspace_pm_remove_id_zero_address(msk);
>> -		goto out;
>> -	}
>> -
>>  	lock_sock(sk);
>>  
>>  	spin_lock_bh(&msk->pm.lock);
> 
> This is a pre-existing issue, but does decrementing sk_omem_alloc eagerly
> while freeing memory via RCU allow a local user in a user namespace to
> bypass socket memory limits?
> 
> Later in mptcp_pm_nl_remove_doit():
> 
> 	kfree_rcu_mightsleep(match);
> 	/* Adjust sk_omem_alloc like sock_kfree_s() does, to match
> 	 * with allocation of this memory by sock_kmemdup()
> 	 */
> 	atomic_sub(sizeof(*match), &sk->sk_omem_alloc);
> 
> If a user with CAP_NET_ADMIN repeatedly announces and removes addresses in
> a tight loop via MPTCP_PM_CMD_ANNOUNCE and MPTCP_PM_CMD_REMOVE, the
> sk_omem_alloc counter is decremented immediately, but the actual freeing
> is deferred to RCU grace periods.
> 
> Could this potentially lead to memory exhaustion (OOM) on the host?

Mmh, I don't think we need to handle this case with CAP_NET_ADMIN, plus
the netlink communication will not allow too many loops I suppose.

(+ pre-existing issue: for a follow-up patch anyway)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

