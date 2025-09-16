Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16544296BB3
	for <mptcp@lists.linux.dev>; Tue, 16 Sep 2025 09:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758016297; cv=none; b=rwel0SNOfMVFG4uF9aWHDQGiNms6VVIu6RCjMgJvurv/9aJXCo7/4Uvumyh/b2dhd6G23tD1UCTQxqUqSWVRPrPdCu6SczLAp7l2WClpfFfgj1cxpOzmBUHasEvH3W2bmc0/vUihvhoEfmsQxGnXcc7Wku4YuvrVCtTFrN0uB8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758016297; c=relaxed/simple;
	bh=+7MWnrRX57iTDBt5FRkb1g1OXbi8rM5Edl3sA7OS7Wc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MqIMitKywJExsBfAs5AySVHrfr3ZUgcxGIQo0Es51xir0m6w93BwGbmR5lKVnTNoSKHYyPxoEpeFGrW5QFOiyteyLDF3CXwQeCa/zHaRbHMqDD2okEV4yw1L35kiXmGOO31cz4S0ZNK4bXz6O6OH8tqN7HL/eNJ7Tp4pzuyKM1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MR2+Vzs4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MR2+Vzs4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17717C4CEEB;
	Tue, 16 Sep 2025 09:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758016296;
	bh=+7MWnrRX57iTDBt5FRkb1g1OXbi8rM5Edl3sA7OS7Wc=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=MR2+Vzs4YyH9oCWe6qig40R7w4trajV0bAQgc5lJ/4hUjNpjt6aUdjcuRqgTdViYP
	 L2dgBIPFoTtGSYLNaHpCDZ3YjcYaEK2ldTjF1mK2idCEh4+yL6by9E5t3Vc4sJdO8a
	 /P7n0IHOvVqHrc/yMXb4l8mtSpVL69DrFTKz4SvXkIup1ZDJi9ASDD0pUUX/DklDnP
	 6XG4vaITQ5UW3c7YUCuJVkBYaeU3EFfnNAA1zAhaipgwjehChSUcKIPBGBzmOf1Oku
	 emQ1wb439+xW203NaMIpiAAB25BOtXUcSrqCm+62wk1wwz5Re7mpMPIWUxZd45AfLz
	 8SuP4BMRGQ9rQ==
Message-ID: <c693ce5f-bd26-4b12-b837-78bcd8fec8d3@kernel.org>
Date: Tue, 16 Sep 2025 11:51:32 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net 1/2] mptcp: pm: in-kernel: usable client side
 with C-flag
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, MPTCP Upstream <mptcp@lists.linux.dev>
References: <20250915-pm-c-flag-client-default-v1-0-6bb241e4d991@kernel.org>
 <20250915-pm-c-flag-client-default-v1-1-6bb241e4d991@kernel.org>
 <7a28297cc4739cba02ee0ea1ba265e8d1b080b68.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <7a28297cc4739cba02ee0ea1ba265e8d1b080b68.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 16/09/2025 11:18, Geliang Tang wrote:
> Hi Matt,
> 
> Thanks for this set. I have some comments below.
> 
> On Mon, 2025-09-15 at 20:11 +0200, Matthieu Baerts (NGI0) wrote:
>> When servers set the C-flag in their MP_CAPABLE to tell clients not
>> to
>> create subflows to the initial address and port, clients will likely
>> not
>> use their other endpoints. That's because the in-kernel path-manager
>> uses the 'subflow' endpoints to create subflows only to the initial
>> address and port.
>>
>> If the limits have not been modified to accept ADD_ADDR, the client
>> doesn't try to establish new subflows. If the limits accept ADD_ADDR,
>> the routing routes will be used to select the source IP.
>>
>> The C-flag is typically set when the server is operating behind a
>> legacy
>> Layer 4 load balancer, or using anycast IP address. Clients having
>> their
>> different 'subflow' endpoints setup, don't end up creating multiple
>> subflows as expected, and causing some deployment issues.
>>
>> A special case is then added here: when servers set the C-flag in the
>> MPC and directly sends an ADD_ADDR, this single ADD_ADDR is accepted.
>> The 'subflows' endpoints will then be used with this new remote IP
>> and
>> port. This exception is only allowed when the ADD_ADDR is sent
>> immediately after the 3WHS, and makes the client switching to the
>> 'fully
>> established' mode. After that, 'select_local_address()' will not be
>> able
>> to find any subflows, because 'id_avail_bitmap' will be filled in
>> mptcp_pm_create_subflow_or_signal_addr(), when switching to 'fully
>> established' mode.
>>
>> Fixes: df377be38725 ("mptcp: add deny_join_id0 in
>> mptcp_options_received")
>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/536
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> Notes:
>> - I tried to find a simple solution that can hopefully be backported
>> to
>>   cover the 'CDN' use-case.
>> - I tried to find a solution respecting the 'accepted add addr'
>> limit,
>>   but I don't see how to... That's why here I limit the exception a
>>   maximum: when this limit is 0 (default case), only the first
>> ADD_ADDR,
>>   etc. Feel free to share what you think about that.
>> - I have some additional code doing some cleanup, and I started to
>> look
>>   at #503, which is a bit linked to that.
>> ---
>>  net/mptcp/pm.c        |  7 +++++--
>>  net/mptcp/pm_kernel.c | 39 +++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 44 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
>> index
>> 02dfb379417e2843301f121039ec0d370b040ef7..fda8d1880224dedbbfb20954f93
>> a04da435346df 100644
>> --- a/net/mptcp/pm.c
>> +++ b/net/mptcp/pm.c
>> @@ -637,9 +637,12 @@ void mptcp_pm_add_addr_received(const struct
>> sock *ssk,
>>  		} else {
>>  			__MPTCP_INC_STATS(sock_net((struct sock
>> *)msk), MPTCP_MIB_ADDADDRDROP);
>>  		}
>> -	/* id0 should not have a different address */
>> +	/* id0 should not have a different address ; special case
>> for C-flag */
>>  	} else if ((addr->id == 0 &&
>> !mptcp_pm_is_init_remote_addr(msk, addr)) ||
>> -		   (addr->id > 0 && !READ_ONCE(pm->accept_addr))) {
>> +		   (addr->id > 0 && !READ_ONCE(pm->accept_addr) &&
>> +		    (!READ_ONCE(msk->pm.remote_deny_join_id0) ||
>> +		     msk->pm.local_addr_used != 0 ||
>> +		     mptcp_pm_get_add_addr_accept_max(msk) != 0))) {
> 
> I think we can define an mptcp_pm_deny_join_id0(struct mptcp_sock *msk)
> helper, then use !mptcp_pm_deny_join_id0(msk) here, and use
> mptcp_pm_deny_join_id0(msk) in fill_local_addresses_vec().
> 
> For example:
> 
> static inline bool mptcp_pm_deny_join_id0(struct mptcp_sock *msk)
> {
>        return (READ_ONCE(msk->pm.remote_deny_join_id0) &&
>                msk->pm.local_addr_used == 0 &&
>                mptcp_pm_get_add_addr_accept_max(msk) == 0);
> }

I initially didn't want to add such helper which means modifying more
files: this will cause more troubles for the backports just for that.
But now thinking about that again, I guess we will have issues with the
backports anyway, because the code has been moved around in pm_kernel.c.
So I suppose it is fine to introduce more conflicts, and we can add a
new helper.

> 
>>  		mptcp_pm_announce_addr(msk, addr, true);
>>  		mptcp_pm_add_addr_send_ack(msk);
>>  	} else if (mptcp_pm_schedule_work(msk,
>> MPTCP_PM_ADD_ADDR_RECEIVED)) {
>> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
>> index
>> f30df8e884a0b3de9fb092e5774cafe08f6350ce..408801e20ed6e874b80ccbf38af
>> 76abc13615a3a 100644
>> --- a/net/mptcp/pm_kernel.c
>> +++ b/net/mptcp/pm_kernel.c
>> @@ -389,10 +389,15 @@ static unsigned int
>> fill_local_addresses_vec(struct mptcp_sock *msk,
>>  	struct mptcp_addr_info mpc_addr;
>>  	struct pm_nl_pernet *pernet;
>>  	unsigned int subflows_max;
>> +	bool deny_join_id0;
>>  	int i = 0;
>>  
>>  	pernet = pm_nl_get_pernet_from_msk(msk);
>>  	subflows_max = mptcp_pm_get_subflows_max(msk);
>> +	deny_join_id0 = remote->id && READ_ONCE(msk-
>>> pm.remote_deny_join_id0) &&
>> +			!READ_ONCE(msk->pm.accept_addr) &&
>> +			msk->pm.local_addr_used == 0 &&
>> +			mptcp_pm_get_add_addr_accept_max(msk) == 0;
> 
> I think it's unnecessary to check msk->pm.accept_addr again here, as it
> has already been verified in mptcp_pm_add_addr_received, which should
> be sufficient:
> 
> deny_join_id0 = remote->id && mptcp_pm_deny_join_id0(msk);

Mmh, we can be in a situation where remote_deny_join_id0 is true, but
accept_addr is true as well, and in this case, we don't want the exception.

But I suppose that mptcp_pm_get_add_addr_accept_max(msk) == 0 implies
accept_addr being false. So I guess we can drop this condition.
> 
>>  
>>  	mptcp_local_address((struct sock_common *)msk, &mpc_addr);
>>  
>> @@ -409,6 +414,9 @@ static unsigned int
>> fill_local_addresses_vec(struct mptcp_sock *msk,
>>  			locals[i].flags = entry->flags;
>>  			locals[i].ifindex = entry->ifindex;
>>  
>> +			if (deny_join_id0)
>> +				__clear_bit(locals[i].addr.id, msk-
>>> pm.id_avail_bitmap);
>> +
>>  			/* Special case for ID0: set the correct ID
>> */
>>  			if (mptcp_addresses_equal(&locals[i].addr,
>> &mpc_addr, locals[i].addr.port))
>>  				locals[i].addr.id = 0;
>> @@ -419,6 +427,37 @@ static unsigned int
>> fill_local_addresses_vec(struct mptcp_sock *msk,
>>  	}
>>  	rcu_read_unlock();
>>  
>> +	/* Special case: peer sets the C flag, accept one ADD_ADDR
>> if default
>> +	 * limits are used -- accepting no ADD_ADDR -- and use
>> subflow endpoints
>> +	 */
>> +	if (!i && deny_join_id0) {
>> +		unsigned int local_addr_max =
>> mptcp_pm_get_local_addr_max(msk);
> 
> How about moving this line to after
> 
> 	subflows_max = mptcp_pm_get_subflows_max(msk);?
> 
> They are similar and can be grouped together.

Simply to restrict the scope to the block where it is used:
local_addr_max is only used here.
> 
>> +
>> +		while (msk->pm.local_addr_used < local_addr_max &&
>> +		       msk->pm.subflows < subflows_max) {
>> +			struct mptcp_pm_local *local = &locals[i];
>> +
>> +			if (!select_local_address(pernet, msk,
>> local))
>> +				break;
>> +
>> +			__clear_bit(local->addr.id, msk-
>>> pm.id_avail_bitmap);
>> +
>> +			if (!mptcp_pm_addr_families_match(sk,
>> &local->addr,
>> +							  remote))
>> +				continue;
>> +
>> +			if (mptcp_addresses_equal(&local->addr,
>> &mpc_addr,
>> +						  local->addr.port))
>> +				continue;
>> +
>> +			msk->pm.local_addr_used++;
>> +			msk->pm.subflows++;
>> +			i++;
>> +		}
>> +
>> +		return i;
> 
> Here, we can avoid using a return statement to allow the subsequent
> array empty check to proceed.

No, we cannot: if we are in the exception (deny_join_id0), it is
possible we are not allowed to create additional subflows using the
'subflow' endpoints, see the conditions in the 'while()'. In this case,
we don't want to create a new subflow below, because the idea is to use
the 'subflow' endpoints if we can.

Or we need to check these conditions before, but that's a lot of
conditions, and it seems safer to return here, no,

> 
>> +	}
>> +
>>  	/* If the array is empty, fill in the single
>>  	 * 'IPADDRANY' local address
>>  	 */

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

