Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8003D99E
	for <mptcp@lists.linux.dev>; Tue, 13 Feb 2024 12:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707826003; cv=none; b=Vf3Veehdy6y70jdp/yzYux3esEKGPYXqSjCd9e2//RvVGtxeoRYE0ibBTMVqG3GcD98zHOsGsY6xRS3VkdAcQLpTqfW7rZKiMlhU52WqGGbN8kH9pmeNPBS4C6rHZ9UQyOcCO4ehFRFuHZIUsfmjSb+E+sOrvsdl/uwY5XPq7Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707826003; c=relaxed/simple;
	bh=5dCSaRbfdbufMuWs6Vhnd8Hp2vJBYLTeggg5kj/9SUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DArpig1+T3JpDgQaQup3pK5AJSxiLCFrydp8zgoIZVm4YtJzGiEb7eveL2PiRB8GFdkODqGhlsXh46fEd7rdgAHuT/apwWsAKOdoTpXYePaoAnygSMQfOT1veAgufBL2foMKdVyE9CzN5I3R3UhNmZeDSoYNjPsMbiHdoe37zXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwhT16GR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwhT16GR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38285C433C7;
	Tue, 13 Feb 2024 12:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707826002;
	bh=5dCSaRbfdbufMuWs6Vhnd8Hp2vJBYLTeggg5kj/9SUk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nwhT16GRUgk2qQJRQU/emxsMylUcvkV0Z4ll0dsDDwkhJsce648bZE+ezPr+6L9wL
	 nk8rW5UFZGl1LWT1hL0wk7vUuVwLbf6eZxek7csC+UlaIQejMFncAwTOBgr1eTJ8KL
	 CSq5jmAGn2kqDnf4+pAPMi+KM2cyHkB6WHahh1Zps4vnAMUIOypX7KO2Lo31q+BzOw
	 ConX6PCsM4jNGtoowRtFp5ZdOWBwsC5HIGAY1asYfOg5iehAlzu11TgDyKgEtOCTiz
	 sxiVr39i5qJfY2yxkfz+Yjav3PQtpWvECSQ4whuY5fn3Go02oKPP+N/eFJcdWAerJO
	 6crKCap3zNBSw==
Message-ID: <3668c451-c2e8-4654-8ab2-42c7eabc099e@kernel.org>
Date: Tue, 13 Feb 2024 13:06:40 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net 1/5] selftests: mptcp: simult flows: fix some
 subtest names
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
References: <20240209-selftests-mptcp-uniq-title-v1-0-e4fb3a3b5f66@kernel.org>
 <20240209-selftests-mptcp-uniq-title-v1-1-e4fb3a3b5f66@kernel.org>
 <ZctT4/w/nH6+4Ocz@t480>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <ZctT4/w/nH6+4Ocz@t480>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

Thank you for the review!

On 13/02/2024 12:34, Geliang Tang wrote:
> Hi Matt,
> 
> On Fri, Feb 09, 2024 at 06:28:39PM +0100, Matthieu Baerts (NGI0) wrote:
>> The selftest was correctly recording all the results, but the 'reverse
>> direction' part was missing in the name when needed.
>>
>> It is important to have a unique (sub)test name in TAP, because some CI
>> environments drop tests with duplicated name.
>>
>> Fixes: 675d99338e7a ("selftests: mptcp: simult flows: format subtests results in TAP")
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>>  tools/testing/selftests/net/mptcp/simult_flows.sh | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
>> index 619be0e1acf5..f377ef01970b 100755
>> --- a/tools/testing/selftests/net/mptcp/simult_flows.sh
>> +++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
>> @@ -250,7 +250,8 @@ run_test()
>>  		[ $bail -eq 0 ] || exit $ret
>>  	fi
>>  
>> -	printf "%-60s" "$msg - reverse direction"
>> +	msg="${msg} - reverse direction"
> 
> How about using '+=' operator to append a string like:
> 
> 	msg+=" - reverse direction"
> 
> The same in patch 3 and patch 4:
> 
> 	msg+=" after flush"
> 
> WDYT?

I usually prefer not to do that, because that's Bash specific, and it
doesn't work with 'sh'.

Here, we explicitly use '/bin/bash', so nothing is blocking me, just an
habit when often switching between "bash" and "sh" :)
I can do the modification if you prefer.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
