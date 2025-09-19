Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C70816DEB1
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 08:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758270315; cv=none; b=KatnwG1UhEnQkrsVjd9g4LNA5nHAoV9CuefgzNmKCEAUNE3UsBE73ZTc0cUT+KDlRoCk3sRztYrtKlpXrOBtvl9QwZ1uCLEOMhJ6TBM+EbUwahqhHMbWJN+17XI/zCUOPFT3+glwDzhEe0OqySGz/+SxBw1jMyQU2CjXNIOEOXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758270315; c=relaxed/simple;
	bh=2Rv6+COt8+XQ3HXqLGJWsZEH5p4jsx3rWB4yVimUNAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Jq34AN8SIYnBpRHQqMbuNTHFP4o8g9pZFIgLboZdu2lcFl3iBy/lXZ8T04hoVZ7QQyi0jgV7U4Qf7g/7GH2rqPpFWdHdNmZ0/LJZ4OF+zfDJZKgD0/lQAh/gI7unyIQhLY5JC7I+/l0kfFumRcH5Y2Qw9JE/Iu0DLaivK+KCdV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrurHjeR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrurHjeR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23511C4CEF0;
	Fri, 19 Sep 2025 08:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758270314;
	bh=2Rv6+COt8+XQ3HXqLGJWsZEH5p4jsx3rWB4yVimUNAg=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=HrurHjeRk9XunzLXvwyUptuMdLkB1qmOxQgUBfkkiovG41K60CL5uhH3QBPH/3oVs
	 77dAAtvbhYllH/jsyi87FxrBKKbAWrp8xbNxZfN02xC03oasF79UAfHME+bVmqGqXh
	 BWpePBqLHnZvHQ0gT9oO5zTmuMEk/2pgn7A9WMa668PM3otYgDW8595MJQB45QWUy3
	 /lAgpFhQz/0aXAr/8CAJKMBJ0UBLGq8uYRC08K4+1sVO53KjgFa9JIoEjuWSyVFsDa
	 bnE0C9o03mTQIgGVDNscnV+g6wsiQ4vpt4oWmSIHOo5uoH95ublYMsUBXQGnhgibPj
	 hQU2ZCIz0OzMw==
Message-ID: <98655217-febd-4744-9333-df441f6649a3@kernel.org>
Date: Fri, 19 Sep 2025 10:25:12 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 02/10] mptcp: pm: in-kernel: refactor
 fill_local_addresses_vec
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, MPTCP Upstream <mptcp@lists.linux.dev>
References: <20250918-pm-kern-endp-add_addr-v1-0-e12e58770a11@kernel.org>
 <20250918-pm-kern-endp-add_addr-v1-2-e12e58770a11@kernel.org>
 <0c764cfdff33d8d903d78b90bd59a8406552dee2.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <0c764cfdff33d8d903d78b90bd59a8406552dee2.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 19/09/2025 08:51, Geliang Tang wrote:
> Hi Matt,
> 
> On Thu, 2025-09-18 at 19:42 +0200, Matthieu Baerts (NGI0) wrote:
>> Before this modification, this function was quite long with many
>> levels
>> of indentations.
>>
>> Each case can be split in a dedicated function: fullmesh, C flag,
>> any.
> 
> If "C flag" function is squash into patch 1, how about splitting this
> patch into two, one for 'fullmesh' and one for 'any'.

I would prefer not to. I don't think it is really needed to split that
in multiple patches.

(...)

>> +/* Fill all the local addresses into the array addrs[],
>> + * and return the array size.
>> + */
>> +static unsigned int
>> +fill_local_addresses_vec(struct mptcp_sock *msk, struct
>> mptcp_addr_info *remote,
>> +			 struct mptcp_pm_local *locals)
> 
> How about keeping this unchanged:
> 
> static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
> 					     struct mptcp_addr_info
> *remote,
> 					     struct mptcp_pm_local
> *locals)
> 
> This can make the patch smaller.

I did these modifications because that's the style I used in the new
functions, plus I think it is better to avoid big indentations.

I don't think we really need to make this patch smaller, it is just a
"pure" refactoring.

> 
>> +{
>> +	bool c_flag_case = remote->id &&
>> mptcp_pm_add_addr_c_flag_case(msk);
>> +	int i;
>> +
>> +	/* If there is at least one MPTCP endpoint with a fullmesh
>> flag */
>> +	i = fill_local_addresses_vec_fullmesh(msk, remote, locals,
>> c_flag_case);
>> +	if (i)
>> +		return i;
>> +
>>  	/* Special case: peer sets the C flag, accept one ADD_ADDR
>> if default
>>  	 * limits are used -- accepting no ADD_ADDR -- and use
>> subflow endpoints
>>  	 */
>> -	if (!i && c_flag_case) {
>> -		unsigned int local_addr_max =
>> mptcp_pm_get_local_addr_max(msk);
>> +	if (c_flag_case)
>> +		return fill_local_addresses_vec_c_flag(msk, remote,
>> locals);
>>  
>> -		while (msk->pm.local_addr_used < local_addr_max &&
>> -		       msk->pm.subflows < subflows_max) {
>> -			struct mptcp_pm_local *local = &locals[i];
>> -
>> -			if (!select_local_address(pernet, msk,
>> local))
>> -				break;
>> -
>> -			__clear_bit(local->addr.id, msk-
>>> pm.id_avail_bitmap);
>> -
>> -			if (!mptcp_pm_addr_families_match(sk,
>> &local->addr,
>> -							  remote))
>> -				continue;
>> -
>> -			if (mptcp_addresses_equal(&local->addr,
>> &mpc_addr,
>> -						  local->addr.port))
>> -				continue;
>> -
>> -			msk->pm.local_addr_used++;
>> -			msk->pm.subflows++;
>> -			i++;
>> -		}
>> -
>> -		return i;
>> -	}
>> -
>> -	/* If the array is empty, fill in the single
>> -	 * 'IPADDRANY' local address
>> -	 */
>> -	if (!i) {
>> -		memset(&locals[i], 0, sizeof(locals[i]));
>> -		locals[i].addr.family =
>> -#if IS_ENABLED(CONFIG_MPTCP_IPV6)
>> -			       remote->family == AF_INET6 &&
>> -			       ipv6_addr_v4mapped(&remote->addr6) ?
>> AF_INET :
>> -#endif
>> -			       remote->family;
>> -
>> -		if (!mptcp_pm_addr_families_match(sk,
>> &locals[i].addr, remote))
>> -			return 0;
>> -
>> -		msk->pm.subflows++;
>> -		i++;
>> -	}
>> -
>> -	return i;
>> +	/* No special case: fill in the single 'IPADDRANY' local
>> address */
>> +	return fill_local_address_any(msk, remote, &locals[0]);
>>  }
>>  
>>  static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>> index
>> dd0662defd41c84474e44c559c571e3594b85d9e..0d6dae37c9daf4ec8990b9a8703
>> 6aa393add585c 100644
>> --- a/net/mptcp/protocol.h
>> +++ b/net/mptcp/protocol.h
>> @@ -1200,7 +1200,8 @@ static inline bool
>> mptcp_pm_add_addr_c_flag_case(struct mptcp_sock *msk)
>>  {
>>  	return READ_ONCE(msk->pm.remote_deny_join_id0) &&
>>  	       msk->pm.local_addr_used == 0 &&
>> -	       mptcp_pm_get_add_addr_accept_max(msk) == 0;
>> +	       mptcp_pm_get_add_addr_accept_max(msk) == 0 &&
>> +	       msk->pm.subflows < mptcp_pm_get_subflows_max(msk);
> 
> This needs to be squash to patch 1 too.

It is currently not needed, see this message in the commit message:

> To remove one level of indentation, msk->pm.subflows >= subflows_max is
> now checked upfront.
But I guess it doesn't hurt to move it there, just to be on the safe
side, and avoid this note.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

