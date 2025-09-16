Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FDC315D2C
	for <mptcp@lists.linux.dev>; Tue, 16 Sep 2025 10:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758018234; cv=none; b=pvTl4BOyhpKiaCuhSLFD8DfCxLFaQgpJBEurJP2OOeksyq/FwmTZxUBlkTIqxeb40R1VJmfNny0lVy1YsmYNcxwzR901VkIgMfFTy9A0pgD3VsTwbDhlyaJ8cvKL9CHlEmxyqxTGj4PS/6Z/Mm9ScS8QrO13CmlySR64+VTsLDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758018234; c=relaxed/simple;
	bh=ugSD2ROKnN3TTPl5ttfJvjWM3H+/4gPZPC1SgX1h+AY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BDy6dMmDZuIargeQruA3Bizjbnkvnz6FjcUEY+lDepzdcWAGLLTHEyA0j7K+CHFtG2cMKaPXef6A7K8mqU2muUyzAWTFcwVUXfkihNCpggBCNfj3qRVvLNT6L3FmVNaA0xGt3FbNrdTfMPWYlCcKqugh26Nmkp0YRruyY34JmRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ucPScytq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ucPScytq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977D7C4CEEB;
	Tue, 16 Sep 2025 10:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758018234;
	bh=ugSD2ROKnN3TTPl5ttfJvjWM3H+/4gPZPC1SgX1h+AY=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=ucPScytq97nKLDcdBzlvp7HLjh4zFBBSeW8xsSv+CCCoJbP6XUF09LqnRL+P2wETX
	 49dqasj6YTkBC6tNRAgv4G7Dvdc3p8TUKnlWMEDLlTwrjTJuk9Z2NIIMwFO23QOO6Q
	 bj7Ysz8ewPl7QLxITEl9tQb2wBAZLspDdhMarvBZutwwn6xNDzwQc2TtIpbupHRlU+
	 PEluEtr/rRgCn2/UXT56fnUfDMWwFkNEhMxqQ5Naw42EJx0jF1hRfdRNuNMSEJhdFk
	 cBEQK08cWHHDiWeRXZNLypXoJqO84Q0YRv5dYY97kxJ1LXd7rVXqdOhpb7iMTlCvMb
	 6o8PN7hRCzsLg==
Message-ID: <291f8169-15e8-426a-a57d-838caf9d2342@kernel.org>
Date: Tue, 16 Sep 2025 12:23:51 +0200
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
 <9c116c2f5b969325a3c9f4c04b6e23ad849f7671.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <9c116c2f5b969325a3c9f4c04b6e23ad849f7671.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 16/09/2025 12:16, Geliang Tang wrote:
> Hi Matt,
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

(...)

>> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
>> index
>> f30df8e884a0b3de9fb092e5774cafe08f6350ce..408801e20ed6e874b80ccbf38af
>> 76abc13615a3a 100644
>> --- a/net/mptcp/pm_kernel.c
>> +++ b/net/mptcp/pm_kernel.c

(...)
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
> 
> Here we need to consider the case of v4mapped addresses, same as in the
> section below "/* If the array is empty */".

I'm not sure to understand: here, we pick a local, then
mptcp_pm_addr_families_match() takes care of the v4mapped addresses.

Here under, we define a local, and we want to take one for the same
address family. We still need the check just in case we receive a v6
address via the ADD_ADDR, and v6 is not supported.

So I don't need to change anything here. Or did I miss something?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

