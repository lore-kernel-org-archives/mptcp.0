Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DCA1487C1
	for <mptcp@lists.linux.dev>; Fri,  5 Jul 2024 15:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720193343; cv=none; b=PDXhI7A5J8NkO2DzSdKcMOFEvVeVRAOLAVW1t2FOFvxNhDAZx2A+jvRVQMVMX1zXLeCm6PZZn4OAXd4Sn+877lYGp0xAW1hRzYfjsyOGOfuu3UZMwMk4YlUJAS1oGRmiJWr+L6W6mh1brwqGvXJujSaVbPbtCOD6DtOq0G2OBA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720193343; c=relaxed/simple;
	bh=wXETw2PeW/00cnL+das1qwbdwfrH5mKxazl+oG+1yoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UhpiFqrInoKzjOHAVgn33RHDx2cm6iLzPXyuC6edID3ONJ39Rf94PItH+B5pF6k+pfNquh2iACZFNSFugUAu47XgEUUh8Yg8mrzHmvk+DIl4n7PsHcnjK9yHO0Icr/q3XLq3WqjDwJ2OM/o5sDHB+LU9/xMWCBqYyl3EQrzoE5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFlawOw3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFlawOw3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80327C116B1;
	Fri,  5 Jul 2024 15:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720193343;
	bh=wXETw2PeW/00cnL+das1qwbdwfrH5mKxazl+oG+1yoI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lFlawOw3FNHFw/IKagwF4/y22kEzYQFw0quezwiFMgSHf8u5xqj2rhEAYGu9tY2GB
	 iHJM8PhQZurLB9F4gA4kgx+WBXgb5yvz297sVbHFr2+/k5d5Qu6KAzV7Hf5MZTZMam
	 zTbl32gq9U9UsdmTl0tj0rjJKB3yzfuM4IWo+Xze7WhPvIjr6hbuGtMOKcaMeMxcKm
	 fdCQj/brvkdtIGjasWN+fOqM6XuHJOPXOjIWNrrvKo3it3O/nA4KmSMBePxtMWfGLt
	 ax5YgV6/eRU1xhDSDqVnXi826IahVejj1DYAf1vQMRzS3TodyIqp7qziSkcycLv2l8
	 6oJClytHD2U3A==
Message-ID: <57efbe56-3ef8-4e3b-b425-8405aa3374bd@kernel.org>
Date: Fri, 5 Jul 2024 17:29:00 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 0/4] mptcp: fix endpoints with 'signal' and
 'subflow' flags
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
References: <20240621-mptcp-pm-avail-v1-0-b692d5eb89b5@kernel.org>
 <39995512b9a2240114fc1a1cd65bbaba2ca996c8.camel@redhat.com>
 <1eb24454-8e21-448e-9cbf-a36f0de6f474@kernel.org>
 <fcbd0bd9b0c108a810b22bcd4c55c7e212bd3ecc.camel@redhat.com>
 <f3293bfa-fb51-478e-bdb8-1841c9d3714e@kernel.org>
 <257091ee7be591bcb9aafa0ab4caa4dbca11e4e1.camel@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <257091ee7be591bcb9aafa0ab4caa4dbca11e4e1.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Paolo,

On 05/07/2024 10:20, Paolo Abeni wrote:
> On Thu, 2024-07-04 at 22:02 +0200, Matthieu Baerts wrote:
>>>> I don't think we should document that "setting both the 'signal' and
>>>> 'subflow' flags is allowed, but in fact the 'subflow' flag is ignored in
>>>>> = 5.17 versions", no? :)
>>>
>>> Yup, I missed the regression part of it.
>>>
>>> If possible, I would be happy to reduce complexity by preventing signal
>>> and subflow flags together.
>>
>> Do you think it would be OK to backport that? How to know if this 
>> configuration is not already used for valid use cases?
> 
> I guess that what worry me most is the addition of another large field
> to the msk "just" to track (again) endpoints.
> 
> Thinking again about it, perhaps we don't need it. Something alike the
> following should be sufficient to replace patch 2/4 here:
> 
> ---
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index ea9e5817b9e9..24e18cd43f48 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -513,8 +513,8 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
>  
>  static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
>  {
> +	struct mptcp_pm_addr_entry *local, *signal_and_subflow = NULL;
>  	struct sock *sk = (struct sock *)msk;
> -	struct mptcp_pm_addr_entry *local;
>  	unsigned int add_addr_signal_max;
>  	unsigned int local_addr_max;
>  	struct pm_nl_pernet *pernet;
> @@ -568,14 +568,27 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
>  		if (msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_SIGNAL))
>  			return;
>  
> -		if (local) {
> -			if (mptcp_pm_alloc_anno_list(msk, &local->addr)) {
> -				__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
> -				msk->pm.add_addr_signaled++;
> -				mptcp_pm_announce_addr(msk, &local->addr, false);
> -				mptcp_pm_nl_addr_send_ack(msk);
> -			}
> -		}
> +		if (!local)
> +			continue;
> +
> +		/* If the allocation fails we are on memory pressure, it looks
> +		 * not worthy try any forther later action, that will likely fail
> +		 * And if local has both the SIGNAL and SUBFLOW flags, and the
> +		 * by bad luck the later subflow creation is successfully, the
> +		 * msk will end-up not signaling this address; not even
> +		 * re-attempting to do it.

If the subflow creation is successful, the new address will be somehow
advertised to the other peer. Should we not try to create the subflow
anyway? That would reduce the diff as well.

> +		 * Likely worthy incrementing a new MIB here

I think there are many other places where we don't have such MIB
counters for not being able to allocate memory. Do you think we would
need one here?

> +		 */
> +		if (!mptcp_pm_alloc_anno_list(msk, &local->addr))
> +			return;
> +
> +		__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
> +		msk->pm.add_addr_signaled++;
> +		mptcp_pm_announce_addr(msk, &local->addr, false);
> +		mptcp_pm_nl_addr_send_ack(msk);
> +		if (local->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)
> +			signal_and_subflow = local;
> +		break;
>  	}
>  
>  	/* check if should create a new subflow */
> @@ -585,9 +598,14 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
>  		bool fullmesh;
>  		int i, nr;
>  
> -		local = select_local_address(pernet, msk);
> -		if (!local)
> -			break;
> +		if (signal_and_subflow) {
> +			local = signal_and_subflow;
> +			signal_and_subflow = NULL;
> +		} else {
> +			local = select_local_address(pernet, msk);
> +			if (!local)
> +				break;
> +		}
>  
>  		fullmesh = !!(local->flags & MPTCP_PM_ADDR_FLAG_FULLMESH);
> ---
> that is, when we use a signal endpoint, if that has the subflow flag,
> use additionally to create the subflows, without doing an additional
> search.
> 
> WDYT?

Smart! Indeed, we can do that because we always mark the IDs as being
used for one or the other from the same place!

I will update the v2 with your version!

> Thanks!
> 
> Paolo
> 
> p.s. Jakubs report the upstream mptcp_connect() st are flacky:
> 
> https://netdev.bots.linux.dev/contest.html?executor=vmksft-mptcp-dbg&test=mptcp-connect-sh

I noticed that this morning too, but I didn't have a chance to look at
the logs. Now I just did, and I think they are all linked to:

  https://github.com/multipath-tcp/mptcp_net-next/issues/499

> can you see that in our CI?

No:

  https://ci-results.mptcp.dev/flakes.html?branch=export
  https://ci-results.mptcp.dev/flakes.html?branch=export-net


I only saw these issues on the Netdev CI, in debug mode, when the same
IP is used for both the client and the server. I just updated this #499
issue with the two new occurrences.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

