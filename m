Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B692347A2
	for <mptcp@lists.linux.dev>; Thu,  7 Mar 2024 16:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709829197; cv=none; b=esauxnZX206/JYE1MafRf6rwYvru7jO+NwEnn0v8hJ2ps60C8V7mASOgmnM2WTLFqlwaaLY3rpNzZkkzMjgYDNt/ICSTQrfstW0ZZ0TozHZKgcIlD0BaMBw5nwnlFkZgqeynz9mezPxADKaPOc/LsLZtm6iQPnMxW5YNlztnDyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709829197; c=relaxed/simple;
	bh=Qh8uVi1PS1gSYl91718l7Q/Y11fdQpmrAzJLdgnZUPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aYlcEG4ny9Nycunh4+Vidi73Z1ZWmzyN517CBBmWvwgYq1Zp74cisxAiJ7pOh3FXX8Mi/OQxphbJm8beRJwTCA2/4zFCIkHKyFiuVsfcqlWOQBSGKGHVHRFdBSaWLnutOzJQpKXLqlAHX4aYztyiIHeZOdPcbRukrvEbBsQ2pn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NyLKOnlg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NyLKOnlg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF25BC43390;
	Thu,  7 Mar 2024 16:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709829196;
	bh=Qh8uVi1PS1gSYl91718l7Q/Y11fdQpmrAzJLdgnZUPE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NyLKOnlgSWcew9DtmosFtfde87qlD8/Mn4pUR/bOi+lfqNMUXdr0e3iWD4tfIYLuB
	 wQ6smFYmqMQo7Vn6NZVET9VsmeZ52vL05B9UEf3GCBQbM5qhBuW1uPXCR4v7vLCt2I
	 vndRTU4m81lZM1RjIsz9oCVpyRbT0P4WRx99msP4CNAKj3FK4vjCpy5jnPPdEVlUZ6
	 c8+htPl7mG20NcUGKI/YwWqyzl9bAAfSTrrva3oNBJIl+BddGxFxv3ztyQPX+gPzDE
	 /eEKPh3ji4BJd16azUM+CNE7NXyxT6KXbKPa+5/LUepBUvbfXF6YctSYRMpOormy7X
	 Ri9UFlKMWacvw==
Message-ID: <07323939-df11-4a2c-950e-de1412bb32b6@kernel.org>
Date: Thu, 7 Mar 2024 17:33:13 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net v2] mptcp: don't account accept() of non-MPC
 client as fallback to TCP
Content-Language: en-GB, fr-BE
To: Davide Caratti <dcaratti@redhat.com>
Cc: Mat Martineau <martineau@kernel.org>, Christoph Paasch
 <cpaasch@apple.com>, mptcp@lists.linux.dev
References: <be9176dac04b292242d6afc2eefc0c931d21b0cd.1709651670.git.dcaratti@redhat.com>
 <62dd5009-fd83-4cd6-b7b1-8afff28a575c@kernel.org>
 <ZenfkXU_zYb0AcR8@dcaratti.users.ipa.redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <ZenfkXU_zYb0AcR8@dcaratti.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Davide,

On 07/03/2024 16:38, Davide Caratti wrote:
> Hi Matthieu!
> 
> On Thu, Mar 07, 2024 at 11:05:10AM +0100, Matthieu Baerts wrote:
>> Hi Davide,
>>
>> On 05/03/2024 16:19, Davide Caratti wrote:
>>> currently, inbound TCP connections increment MPTcpExtMPCapableFallbackACK
>>
>> Maybe clearer with 'inbound "plain" TCP connections'?
> 
> maybe it's better to say "non-MPC": see below

Yes, good point.

>>> when the server accepts them. As Christoph reported, this is "surprising"
>>> because the counter becomes greater than MPTcpExtMPCapableSYNRX when many
>>> non-MPC TCP connections are accepted.
>>
>> (detail: maybe add an empty line here, and start the sentence above with
>> a capital letter :) )
> 
> right, I always forget the capital letter.
> 
>>
>>> Change the semantic of MPTcpExtMPCapableFallbackACK to increment when the
>>> subflow context of an inbound MPC connection attempt is dropped.
>>
>> Detail: I don't know if 'change the semantic' would be OK for a patch
>> for -net. Maybe more:
>>
>>   MPTcpExtMPCapableFallbackACK counter's name suggests it should only be
>>   incremented when a connection was seen using MPTCP options, then a
>>   fallback to TCP has been done. Let's do that by incrementing it when
>>   the subflow context of an inbound MPC connection attempt is dropped.
>>
>>> v2: fix reporter name
> 
> this was meant for net-next, but I can find a suitable Fixes tag.

I think it is good to consider this as a fix for -net.

> 
> [...]
>  
>>> index 1626dd20c68f..6e3fe38f057d 100644
>>> --- a/net/mptcp/subflow.c
>>> +++ b/net/mptcp/subflow.c
>>> @@ -905,6 +905,8 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
>>>  	return child;
>>>  
>>>  fallback:
>>> +	if (child)
>>
>> Why do you need to check that? It is not supposed to be NULL if you are
>> here, no?
> 
> Ouch, this is wrong and unintentional. The correct test is
> if (fallback)
> 	SUBFLOW_REQ_INC_STATS(blah);
> 
> and I mixed variable names while cleaning up pr_debug()s. Non-MPC connection
> attempts (pure TCP, but also MPTCP with pathological MP_CAPABLE
> sub-options) have fallback equal to false here. Will fix this in v3.

Maybe it also means it would be good to add a check in the selftests (in
mptcp_connect.sh?) to make sure it is doing the right thing (and there
is no regressions later) :)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
