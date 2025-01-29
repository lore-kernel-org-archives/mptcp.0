Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E054D1DF744
	for <mptcp@lists.linux.dev>; Wed, 29 Jan 2025 17:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738173141; cv=none; b=WLsnMwAvRuAWrenqSasIJ4yqKUm/RQ1i/1mKrXwHtn0pvKRlC9URZdshmIXf9fQLILdNFr0Dby9ZJX1vnbuIpR8mG0iCAod3vEiJ1L4f5unTRs5jOR0E9PxIj/xTz5OUjugAbmxWDaL0mi0T+osCID5K4PpcmgI21ehVjVaPWAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738173141; c=relaxed/simple;
	bh=0RRvuiwoDOgwdgSqqcO9iU00iBNHpVNv/JyY962/16g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NE8oNIU6K6NyS4Aqce+JNeKae3Cppmb7nKNMLY6paj4sMn48v9JrwgKHolInDgEENoj1sIEP5Zmn2si2USDdQJvLtpqvShdSG2HHSm/SPj2/9RnxltEaURGq1n5wzSLqcJBeggcY0TDjb+rMuFbS67suPSH6p1jLVdyUp50Tr4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkkElsaw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkkElsaw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8411C4CED1;
	Wed, 29 Jan 2025 17:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738173140;
	bh=0RRvuiwoDOgwdgSqqcO9iU00iBNHpVNv/JyY962/16g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bkkElsawX0yPbWdXi2Zut5LdlWGT759XlQ2XEMo6heKth6eG6Wgw1lL7/UYb1bCc5
	 nIWcUpcKwOH+OJTxn6gauwQzPS0Ooc8Lj+LjHQpSrWshOwZsvnIiM0zH4F3t3bpxKS
	 9fvi7IHjDEgEiwccPen+a9dU25g45vjHd49HDG+1WpGOAfy0DSKScWpWPnHA82Op7T
	 GBnpXizWsi29Z0YkeGqdcNCYHIRHsajLyPb1jvtCQMB4GPxEVMC4sF/89sgeJZLPQ0
	 eZ8bGFmUqCHpExw+8PSFgmKoAdk2I8DspJIyLeUOKhZaR54sSjxWhop/vWn/FhVGtc
	 zaSkGJ/N/gGSg==
Message-ID: <d0c2e209-f70e-4d41-a8ff-a271757465db@kernel.org>
Date: Wed, 29 Jan 2025 18:52:18 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net] selftests: mptcp: connect: -f: no reconnect
Content-Language: en-GB
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
References: <20250127-selftests-mptcp-fastclose-tests-v1-1-787609c66612@kernel.org>
 <4b0be50f-8469-240b-608e-41604d355e39@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <4b0be50f-8469-240b-608e-41604d355e39@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 29/01/2025 17:44, Mat Martineau wrote:
> On Mon, 27 Jan 2025, Matthieu Baerts (NGI0) wrote:
> 
>> The '-f' parameter is there to force the kernel to emit MPTCP FASTCLOSE
>> by closing the connection with unread bytes in the receive queue.
>>
>> The xdisconnect() helper was used to stop the connection, but it does
>> more than that: it will shut it down, then wait before reconnecting to
>> the same address. This causes the mptcp_join's "fastclose test" to fail
>> all the time.
>>
>> This failure is due to a recent change, with commit 218cc166321f
>> ("selftests: mptcp: avoid spurious errors on disconnect"), but that went
>> unnoticed because the test is currently ignored. The recent modification
>> only shown an existing issue: xdisconnect() doesn't need to be used
>> here, only the shutdown() part is needed.
>>
>> Fixes: 6bf41020b72b ("selftests: mptcp: update and extend fastclose
>> test-cases")
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> Notes:
>> - With the modification, the mptcp_join's "fastclose test" is still a
>>  bit unstable on my side with a debug kernel. I didn't try to fix that.
>>  This is tracked by this (old) issue:
>>  https://github.com/multipath-tcp/mptcp_net-next/issues/324
> 
> Hi Matthieu -
> 
> Looks good, thank you:

Thank you for the review!

Now in our tree (fixes for -net):

New patches for t/upstream-net and t/upstream:
- 9ebcf2ea5cfc: selftests: mptcp: connect: -f: no reconnect
- Results: 062dec17fb88..d2351c5ab4ff (export-net)
- Results: 896f230a519b..96e665850a6e (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/28cc1b7f422a72ee103c7ea46cc33bb65e4d4823/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/ef1b554d4eb2a5413bcca1922d5ae6d609e5d3d0/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

