Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C5731A8F
	for <mptcp@lists.linux.dev>; Fri,  9 Feb 2024 14:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707488210; cv=none; b=RVDroFDW87Zxyf9LuQ8ABSbM4FW1BDBY9zGovQFoV1OuiRd5i4Ug20c/badGKshl/R5FtePhO/GX3uv9FsmvLmJtzdsm7DECEkN0do3KJe8ZEtvV8Hf9wLw3ARZFrM+WChE03E+44X05Mi8FtrJu8WbimNH+3cMaqtWIzWl3Bb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707488210; c=relaxed/simple;
	bh=LTDH0bRCDVBaHUNicEZ5/mi/wdGodasjoJSv49QtLyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OVmAMxF5sJS4s2SzVwSsWObD72wWfHWL7UA5eE4YhfRxLgTrGFuTve6ILwxAMgswQPmtahG238WGwUYrRh/TjNU5GcbL1jqFKhlaicQTO0iDlzdqGO3QM/6vkt77KgON4uiB8YAsa9sJc88XHHP88Fbs80kniaFfTaoH2V201OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEbgjLs9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEbgjLs9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E77C433F1;
	Fri,  9 Feb 2024 14:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707488210;
	bh=LTDH0bRCDVBaHUNicEZ5/mi/wdGodasjoJSv49QtLyA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nEbgjLs92lXBrQYGlpFrSJyyXXoCG8xgQn1GHOyod0vgZSb3NyudPB7o4Je5qw79t
	 HhpQ/3mG/CtB/fSF3cFADdVdkYqnOWbW2c1hU4WMrp4AUF7R3BBcJCl/ThyIrXAuQY
	 qi7JGRfUh5n+Is8OtOZM0M0c0Fy5V1rpPRv69kKM6SF2Nt6fAZkOBi4Qoh+NhhddoH
	 A6JfzsdutcDdOuKVyBpjXEZuSeL2D2aBavWe6Kc6jh5SlX0l4gsMdxrD166hwJK3Gw
	 uuJcd2Q4NA7cOwTQcFso3wU5qoZRrOTRQ3xCONddWBR3If+ExN4tFHRo1m8Y6oAby3
	 cUxfN0ZS+zSgw==
Message-ID: <aa5316a3-2bee-40c6-87a8-a9eb1fa0e7d8@kernel.org>
Date: Fri, 9 Feb 2024 15:16:46 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net] selftests: mptcp: simult flows: re-adapt BW
Content-Language: en-GB, fr-BE
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
References: <20240208-selftests-mptcp-simult_flows_faster-v1-1-2859ca46e582@kernel.org>
 <196d5d2c-39c2-b2d9-1104-75bd4b7d6af2@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <196d5d2c-39c2-b2d9-1104-75bd4b7d6af2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat,

On 09/02/2024 01:30, Mat Martineau wrote:
> On Thu, 8 Feb 2024, Matthieu Baerts (NGI0) wrote:
> 
>> Recently, the bandwidth in simult flows selftest has been reduced. The
>> idea was to improve the situation in slow environments. It helped in
>> some, but not in all of them. With a longer transfer, it is also
>> possible to get more instabilities along the way.
>>
>> We can increase a bit the rate limit for the unbalanced bandwidth cases,
>> but limit the total of the two links to 20 Mbps, like the balanced
>> bandwidth cases. The same 3:1 ratio is still being used like before, not
>> to change the nature of the test.
>>
>> Fixes: 5e2f3c65af47 ("selftests: mptcp: decrease BW in simult flows")
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> Looks reasonable, thanks Matthieu.
> 
> Reviewed-by: Mat Martineau <martineau@kernel.org>

Thank you for the review!

Now in our tree (fix for -net):

New patches for t/upstream-net and t/upstream:
- 7e6c60f9e796: selftests: mptcp: simult flows: re-adapt BW
- Results: 6075087dd1c3..bef0b46af378 (export-net)
- Results: 081844c2b78a..78a4d8e40bf5 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20240209T140100
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20240209T140100

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
