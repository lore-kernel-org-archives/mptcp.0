Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1247407A
	for <mptcp@lists.linux.dev>; Thu, 18 Jul 2024 11:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721301304; cv=none; b=rAZb0QUT9w8KwPED6JKgjIbqEdHh6fsXmupG8Sd1XyYoh8GGTAMEBkJejhYOvBgSmgMonnPvvTQWKPdAclNXGxDYaBvQfY5rhCauIRj624+sI7B+zGdcAKIYin8M1JqttVW+QaiIXwzG7SzvXAoBCVMkuA4y4fyR3RFGOCEKk7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721301304; c=relaxed/simple;
	bh=i5XKo5p32UKIEQpFNLxmQvVY2zp59UeccXSl/1IQ6Ic=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TWKjfXMz31TOKbGdOoayiQvtMJLoeH5mx5wWcj6TTyidpzSADLjYIQmuZtIQQW2YynSJamqBwrgqITZYduMaXd4/AZ6FSXm0/ugsZrQLYybpkDtHH35sGj+242DJTQqZGzlZ/07zHgGBb17G9Necmmd6D/udBVezB48VhWm841o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2N9m7RG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2N9m7RG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50ECC116B1;
	Thu, 18 Jul 2024 11:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721301303;
	bh=i5XKo5p32UKIEQpFNLxmQvVY2zp59UeccXSl/1IQ6Ic=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=n2N9m7RGV7zrMlVlTEKtaFgx5r/M5WdHUX2/pmQxBMXKZ9K4XTB+HRgutbi5I/nw6
	 8AMollmm1bqawUbfPJjsRyy/xfbTrSXtefMxX3/qQJ+kgzJQSVEK3Cn2vtzZQd1TcO
	 fh7EgK+5VPBz1nrjZfKLIQ9ANRJ7QvHognSIWXUPh0ip1NLBQH2/YKpHrucHo/KK3i
	 VJoBG6GcyszubY4A0cw+JWVW+OZhkc7KWGQTtqXAwb3uJJ+PhwJnLpZVCEOCidBFe5
	 yuKJzjNPEkjq9C8+ZC2GHyZ/6Shd4wBAd5ONX5Uv2VMKRcRcFRH7Z2Yg/I9qOfxCC5
	 a/CER4eDHvVag==
Message-ID: <3302c193-7820-401b-b55b-e1aca11b3585@kernel.org>
Date: Thu, 18 Jul 2024 13:15:00 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v2 7/9] selftests: mptcp: join: check backup
 support in signal endp
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
References: <20240716-mptcp-backup-mpj-v2-0-4d50247405fb@kernel.org>
 <20240716-mptcp-backup-mpj-v2-7-4d50247405fb@kernel.org>
 <59cdfb0ae86ea0f2e45c2fecbe0a0ceb7848a1f6.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <59cdfb0ae86ea0f2e45c2fecbe0a0ceb7848a1f6.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 17/07/2024 06:39, Geliang Tang wrote:
> On Tue, 2024-07-16 at 22:53 +0200, Matthieu Baerts (NGI0) wrote:
>> Before the previous commit, 'signal' endpoints with the 'backup' flag
>> were ignored when sending the MP_JOIN.
>>
>> The MPTCP Join selftest has then been modified to validate this case:
>> the "single address, backup" test, is now validating the MP_JOIN with
>> a
>> backup flag as it is what we expect it to do with such name. The
>> previous version has been kept, but renamed to "single address,
>> switch
>> to backup" to avoid confusions.
>>
>> The "single address with port, backup" test is also now validating
>> the
>> MPJ with a backup flag, which makes more sense than checking the
>> switch
>> to backup with an MP_PRIO.
>>
>> The "mpc backup both sides" test is now validating that the backup
>> flag
>> is also set in MP_JOIN from and to the addresses used in the initial
>> subflow, using the special ID 0.
>>
>> The 'Fixes' tag here below is the same as the one from the previous
>> commit: this patch here is not fixing anything wrong in the
>> selftests,
>> but it validates the previous fix for an issue introduced by this
>> commit
>> ID.
>>
>> Fixes: 4596a2c1b7f5 ("mptcp: allow creating non-backup subflows")
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> Notes:
>>  - v2:
>>    - Also validating MPJ to/from ID0 with backup
>> ---
>>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 34
>> ++++++++++++++++++++-----
>>  1 file changed, 28 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> index 175127a9c00c..ffcf558b4610 100755
>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> @@ -2639,6 +2639,19 @@ backup_tests()
>>  
>>  	# single address, backup
>>  	if reset "single address, backup" &&
>> +	   continue_if mptcp_lib_kallsyms_has
>> "subflow_rebuild_header$"; then
>> +		pm_nl_set_limits $ns1 0 1
>> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal,backup
>> +		pm_nl_set_limits $ns2 1 1
>> +		sflags=nobackup speed=slow \
>> +			run_tests $ns1 $ns2 10.0.1.1
>> +		chk_join_nr 1 1 1
>> +		chk_add_nr 1 1
>> +		chk_prio_nr 1 0 0 1
>> +	fi
>> +
>> +	# single address, switch to backup
>> +	if reset "single address, switch to backup" &&
>>  	   continue_if mptcp_lib_kallsyms_has
>> "subflow_rebuild_header$"; then
>>  		pm_nl_set_limits $ns1 0 1
>>  		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
>> @@ -2654,13 +2667,13 @@ backup_tests()
> 
> '''
>>  	if reset "single address with port, backup" &&
>>  	   continue_if mptcp_lib_kallsyms_has
>> "subflow_rebuild_header$"; then
>>  		pm_nl_set_limits $ns1 0 1
>> -		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port
>> 10100
>> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal,backup
>> port 10100
>>  		pm_nl_set_limits $ns2 1 1
>> -		sflags=backup speed=slow \
>> +		sflags=nobackup speed=slow \
>>  			run_tests $ns1 $ns2 10.0.1.1
>>  		chk_join_nr 1 1 1
>>  		chk_add_nr 1 1
>> -		chk_prio_nr 1 1 0 0
>> +		chk_prio_nr 1 0 0 1
>>  	fi
> '''
> 
> How about keep this block unchanged. "nobackup" is already tested in
> the above newly added test "single address, backup"? They are almost
> the same now.

The switch from 'nobackup' to 'backup' during the connection is also
tested just before, in "single address, switch to backup".

I think it makes more sense to validate the cases where the endpoints
are set with the backup flag before establishing connections: that
sounds like the most common use-cases. I guess people don't play with
the 'endpoint change (no)backup' option that often, no?

Supporting the switch of the backup flag for existing connections seems
like a nice to have feature to me, but not the main one related to the
backup case. So I think we should reflect that in our test suite. (And
still, we validate the switch here, but now we also check that the flag
is correctly set in the most common cases).

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

