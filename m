Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E9E2868B3
	for <mptcp@lists.linux.dev>; Fri,  5 Sep 2025 09:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757065928; cv=none; b=cC1meprnlzEVAJ31x4uXzbZGzo+rLFTQGxyHUjtNYBwBDMkBbdZhXz+UPbMGhDxjC3Vp99o0n0o+f6Qzo+TaX3f57jRmRz+JA0JrRaaG5SpzbXkYdyCOkI5j2xFTgog86BVnhEgW4JQ3WNSA/CxS/hsbfgOk2d2iz9aq2GhBnMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757065928; c=relaxed/simple;
	bh=pOkJTqgurHN5NPWGf8REdYeDvSdgnz2RA4oq+D13dMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Q47G4xm0tOYGS6VRPcrig+uUbxz03wgw8eOBW8EWE5m5yxU9iMFpFHPraC1mf4bB5//AfwUSMODrnN013sCV9X4kF69kS8VSXnx/0YoTbtQCML1g4xSCzHYV6oZ6Q89hgtGWBDCIDHSRqIZT85MfkK4c80Yfs/P+qUep3Z9PDwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hf8ae2H8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hf8ae2H8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F0DC4CEF1;
	Fri,  5 Sep 2025 09:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757065928;
	bh=pOkJTqgurHN5NPWGf8REdYeDvSdgnz2RA4oq+D13dMU=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Hf8ae2H8yiFPifzXOcwuXCF27y/kX4I/mqetAnsHE532L66GpCl2M7M2eroMxlNMd
	 vDZae9MlIWb2yVv9YwaLprWtOnWPu1lDUIx2klHodndMxfRqyKYOEO0TuO5KRX23kO
	 8lOvIFpt5e2eOpr/ZPaSdzm+pvTVTqyuhimHh89KVAFqmXc5CrAqHDF7SkiQT53amO
	 0m5GEcO8rkxliybHwIgubPCubyud46Rc1cFCtnnRe2znyNgrBxOHOfCR1jpI9j6ghg
	 1kWyLlLClSzs7YeF1PrB0pyNW0q23NZJ6jggLknEplNhiQXYX75FyFuUrfksmQlCr+
	 C2jezvaFKm5zg==
Message-ID: <5fad60c8-d218-4087-a7bf-a65cee6b86aa@kernel.org>
Date: Fri, 5 Sep 2025 11:52:05 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2 2/3] selftests: mptcp: join: tolerate more
 ADD_ADDR
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, MPTCP Linux <mptcp@lists.linux.dev>
References: <20250904-sft-mptcp-join-add_addr-no-retrans-v2-0-a019e6678628@kernel.org>
 <20250904-sft-mptcp-join-add_addr-no-retrans-v2-2-a019e6678628@kernel.org>
 <cde1771d-2383-42cb-97e3-92d53e42b381@kernel.org>
 <21ee1ae6c2d86739387e3e9709fbd630d5e5bdc5.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <21ee1ae6c2d86739387e3e9709fbd630d5e5bdc5.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 05/09/2025 10:16, Geliang Tang wrote:
> Hi Matt,
> 
> Thanks for this new version, and thanks for the explanation in v1.
> 
> On Thu, 2025-09-04 at 16:54 +0200, Matthieu Baerts wrote:
>> On 04/09/2025 13:38, Matthieu Baerts (NGI0) wrote:
>>> ADD_ADDR can be retransmitted, and with, the parent commit, these
>>> retransmissions can be sent quicker: from 2 minutes to less than
>>> one
>>> second.
>>>
>>> To avoid false positives where retransmitted ADD_ADDR causes higher
>>> counters than expected, it is required to be more tolerant. Errors
>>> are
>>> now only reported when fewer ADD_ADDRs have been sent/received,
>>> except
>>> if no ADD_ADDR are expected.
>>>
>>> Before the parent commit, the tolerance was present for each tests
>>> where
>>> the ADD_ADDR could be retransmitted in a reasonable time (1 sec).
>>> Now
>>> that all tests can have retransmitted ADD_ADDR, it is normal to
>>> apply
>>> the same tolerance for all tests.
>>>
>>> An alternative could be to disable the ADD_ADDR retransmissions by
>>> default, but that's changing the default kernel behaviour. Plus,
>>> ADD_ADDR retransmissions can be required for some tests. To avoid
>>> adding
>>> exceptions to many tests, it seems better to increase the
>>> tolerance.
>>>
>>> Later, we could add a new MIB counter to identify the ADD_ADDR
>>> retransmissions, and remove the tolerance when this counter is
>>> available.
>>>
>>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>> ---
>>>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 19 +++++++------
>>> ------
>>>  1 file changed, 7 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>>> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>>> index
>>> 2f046167a0b6cc6fb5531a033d8d95c9ea399cf9..be49712f91155a1f14f6cc217
>>> 76764d65a897c27 100755
>>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>>> @@ -358,6 +358,7 @@ reset_with_add_addr_timeout()
>>>  		tables="${ip6tables}"
>>>  	fi
>>>  
>>> +	# set a maximum, to avoid too long timeout with
>>> exponential backoff
>>>  	ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
>>>  
>>>  	if ! ip netns exec $ns2 $tables -A OUTPUT -p tcp \
>>> @@ -1669,7 +1670,6 @@ chk_add_nr()
>>>  	local tx=""
>>>  	local rx=""
>>>  	local count
>>> -	local timeout
>>>  
>>>  	if [[ $ns_invert = "invert" ]]; then
>>>  		ns_tx=$ns2
>>> @@ -1678,15 +1678,13 @@ chk_add_nr()
>>>  		rx=" server"
>>>  	fi
>>>  
>>> -	timeout=$(ip netns exec ${ns_tx} sysctl -n
>>> net.mptcp.add_addr_timeout)
>>> -
>>>  	print_check "add addr rx${rx}"
>>>  	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtAddAddr")
>>>  	if [ -z "$count" ]; then
>>>  		print_skip
>>> -	# if the test configured a short timeout tolerate greater
>>> then expected
>>> -	# add addrs options, due to retransmissions
>>> -	elif [ "$count" != "$add_nr" ] && { [ "$timeout" -gt 1 ]
>>> || [ "$count" -lt "$add_nr" ]; }; then
>>> +	# Tolerate more ADD_ADDR then expected (if any), due to
>>> retransmissions
>>> +	elif [ "$count" -lt "$add_nr" ] ||
>>> +	     { [ "$count" != "$add_nr" ] && [ "$add_nr" != 0 ]; };
>>> then
>>
>> Arf, it should be:
>>
>>   "$add_nr" == 0
> 
> It should indeed be "$add_nr" == 0.
> 
> nit:
> 
> Is it possible to keep the same order as before when checking
> "$timeout", just replace [ "$timeout" -gt 1 ] with [ "$add_nr" == 0 ]?
> 
> That is:
> 
> elif [ "$count" != "$add_nr" ] && { [ "$add_nr" == 0 ] || [ "$count" -
> lt "$add_nr" ]; }; then
> 
> Although they are actually the same, I usually try to keep it
> consistent with the original code.

Good point, even if I found the check "-lt || (-gt && = 0)" maybe more
logical, with the v2, we are closer to the original code, I can do this
modification.

> 
>>>  		fail_test "got $count ADD_ADDR[s] expected
>>> $add_nr"
>>>  	else
>>>  		print_ok
>>> @@ -1774,18 +1772,15 @@ chk_add_tx_nr()
>>>  {
>>>  	local add_tx_nr=$1
>>>  	local echo_tx_nr=$2
>>> -	local timeout
>>>  	local count
>>>  
>>> -	timeout=$(ip netns exec $ns1 sysctl -n
>>> net.mptcp.add_addr_timeout)
>>> -
>>>  	print_check "add addr tx"
>>>  	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtAddAddrTx")
>>>  	if [ -z "$count" ]; then
>>>  		print_skip
>>> -	# if the test configured a short timeout tolerate greater
>>> then expected
>>> -	# add addrs options, due to retransmissions
>>> -	elif [ "$count" != "$add_tx_nr" ] && { [ "$timeout" -gt 1
>>> ] || [ "$count" -lt "$add_tx_nr" ]; }; then
>>> +	# Tolerate more ADD_ADDR then expected (if any), due to
>>> retransmissions
>>> +	elif [ "$count" -lt "$add_tx_nr" ] ||
>>> +	     { [ "$count" != "$add_tx_nr" ] && [ "$add_tx_nr" != 0
>>> ]; }; then
>>
>> Same here:
>>
>>   "$add_tx_nr" == 0
>>
>> If there is nothing else, I can fix that when applying the patches.
> 
> No need to send a v3, please fix it when applying it.
> 
> Reviewed-by: Geliang Tang <geliang@kernel.org>

Thanks!

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

