Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B847156C4B
	for <mptcp@lists.linux.dev>; Fri,  9 Aug 2024 11:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723203546; cv=none; b=XETq8iGNglDT/zcN1mCyiNbWmJwT47S3lE3ehNRCGjfWZyLR1Dy5KpSBZQHIRHjHXomj4uSC8W9tnxDypAN4Y9+r6Vhciz52+GOLQyI/HU8mQiQDDtuuPttqGrbi05lmKvxi3NjjYYNL/WYuR4MWLIJ0+/L/DApT7/LupDoBZVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723203546; c=relaxed/simple;
	bh=qvDNtIpqu1PYJL+QpDKuEO1F22Wdd4oIC9k35O0SGcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DKQM3ouPe5H3EUmkvWcfUcPvfyMKjodTOeZR2Y1E1DOjuwuI8S7txX3JNibkGXzgZFzeW5nd1S3XRJ8OQHZ/3WZhgDqX6FvtgF1tJl5QN+nTqHwCyvwphQVNJp2vCUHTjmwsPslslwB7+0PUwc2rvZBfhFuo61kYfbwquiKlk6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJbjK6yr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJbjK6yr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CBBDC32782;
	Fri,  9 Aug 2024 11:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723203546;
	bh=qvDNtIpqu1PYJL+QpDKuEO1F22Wdd4oIC9k35O0SGcA=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=NJbjK6yr+eRu5LvPXXy7tza8pGMrpAWrjRqqdkk/qw8rw054yeto1UAShS91Fi7EG
	 y5YzMvaS0RUjNU4U3u+04x3LsTEttBiROJLkgSY4aGNmxw+CAiDmT7HYyve/1qVbqP
	 /2dInIo36I0jQyvJqVMSjVzNA04HLT6yc29Iu9TA9EvWJlFgrNxu8xSTgLxybdwGp+
	 dDIQFWYBCXceLTPyCTumJ4qXYxi3SKJjQ3VNCuLSL6Lo27TvsXyFhjlDSDrRHCrlei
	 IVrE8o+5hCJ3g4p4GFhl61MeWfP4a5vmP/1+mnOmrDU2uiPIJMF1LvZXrZBZ4B/g4G
	 ip8LtzGeiVt0w==
Message-ID: <0c131a5e-10df-44c9-ad46-96b4821f3a1e@kernel.org>
Date: Fri, 9 Aug 2024 13:39:03 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v3 4/8] selftests: mptcp: join: one line for
 join check
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
References: <20240806-mptcp-join-tx-mib-v3-0-c3b54d2099e9@kernel.org>
 <20240806-mptcp-join-tx-mib-v3-4-c3b54d2099e9@kernel.org>
 <ffcd94a0d7154a93d6405c0402b0d01a015603b9.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <ffcd94a0d7154a93d6405c0402b0d01a015603b9.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 09/08/2024 04:10, Geliang Tang wrote:
> On Tue, 2024-08-06 at 13:18 +0200, Matthieu Baerts (NGI0) wrote:
>> Most tests are checking if the expected number of SYN/SYN+ACK/ACK
>> JOINs
>> have been received, each of them on one line.
>>
>> More Join related tests are going to be checked soon, no need to add
>> 5
>> new lines per test in case of success, just one is enough. In case of
>> issue, the errors will still be reported like before.
>>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 45
>> ++++++++++++++++---------
>>  1 file changed, 30 insertions(+), 15 deletions(-)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> index 0401ba1aaf1b..b10bcb1ac970 100755
>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> @@ -202,6 +202,22 @@ print_skip()
>>  	mptcp_lib_pr_skip "${@}"
>>  }
>>  
>> +# $1: check name; $2: rc
>> +print_results()
>> +{
>> +	local check="${1}"
>> +	local rc=${2}
>> +
>> +	print_check "${check}"
>> +	if [ ${rc} = ${KSFT_PASS} ]; then
>> +		print_ok
>> +	elif [ ${rc} = ${KSFT_SKIP} ]; then
>> +		print_skip
>> +	else
>> +		fail_test
> 
> To align error messages, it's better to pass an empty string to
> fail_test to make sure an "EOL" is printed out:
> 
> 		fail_test ""
> 
> 001 no JOIN
>       syn rx                 [FAIL] got 0 JOIN[s] syn rx expected 1
>       synack rx              [FAIL] got 0 JOIN[s] synack rx expected 1
>       ack rx                 [FAIL] got 0 JOIN[s] ack rx expected 1
>       join Rx                syn tx                              [FAIL]
> got 0 JOIN[s] syn tx expected 1
>       join Tx                002 single subflow, limited by client
>       join Rx                             [ OK ]
>       join Tx                             [ OK ]
> 
> ->
> 
> 001 no JOIN
>       syn rx                 [FAIL] got 0 JOIN[s] syn rx 
>       synack rx              [FAIL] got 0 JOIN[s] synack rx expected 1
>       ack rx                 [FAIL] got 0 JOIN[s] ack rx expected 1
>       join Rx                [FAIL]
>       syn tx                 [FAIL] got 0 JOIN[s] syn tx expected 1
>       join Tx                [FAIL]
> 002 single subflow, limited by client
> 
> WDYT?

Good point. We can also print "see above" instead of nothing.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

