Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50697CF11
	for <mptcp@lists.linux.dev>; Thu, 29 Feb 2024 12:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709209211; cv=none; b=J7cvJVZEbvO19YlBn3Lc1ylKQgYFPs19Bw/EaPu4XpRUxlx6TO415Oo3AHt2YwG3WEW3kb2hMgl+u6weofF7xWb0ldTRABMbhQSFVEKlM0fUoujeXk1W7lPCTTbRuzpXnZfipYiNpxAwLbk58ULdoiLDqhBgeKOx1W+cyJaqfIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709209211; c=relaxed/simple;
	bh=nL5DO0pFibRwUlHwj7qgZgtSB0JJxvYoK8BNzciXLio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r8mHHB6q2pDYAjevk1HWtDVradoQnxlDFqLCpP5/WlHvg7dWd2/tVpz5ZML+A1TUDFLFz+rVmOqCr/VJO8zDNagEvU0gIfJ6fb4qkwio9+ATwgAFUwF8STj4Iia7jvJ5w7F90DE8nxog5AU312KoEci7l52cb2ZDeIgpEgCcc5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0kSgak+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0kSgak+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D61ABC433F1;
	Thu, 29 Feb 2024 12:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709209211;
	bh=nL5DO0pFibRwUlHwj7qgZgtSB0JJxvYoK8BNzciXLio=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=l0kSgak++KWKufgxaUwy3GKztHJaOjyHtz96k9zkBSSF9UX3EIwvyWpWzL96Visk9
	 YINsJWqKgSAkw2+TYum4FOIYeykbL1Tu6vDq244QdagrUok59HdYnLLMTOW0Ihek8S
	 cPS3XoUE19gTdmXr7cz+kfS++pZourQ8Rl1+aMLNpIovrCbyYiUuZ0tpHMdcDY5mT4
	 838JaahsunHXuMaJThNSLpcp2WK8cZ0UpOdYpQ/4Q3ZVVSGUhSw2SpKl2NFBui1cQL
	 o2/HnJrsOOolVR442rcyHEB8Rm3hmMhIzs1FZE6qNye8nklRMsNWBtp6ViPysnYbIh
	 w8JfZuEejpTZA==
Message-ID: <4edaeb85-e94e-4dc4-9e23-f4efb716093f@kernel.org>
Date: Thu, 29 Feb 2024 13:20:09 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v7 5/8] selftests: mptcp: sockopt: unify
 ipv4/ipv6 as v4/v6
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
References: <cover.1709200070.git.tanggeliang@kylinos.cn>
 <80749c1dfc741ca14090559c5a2364b253c03a5a.1709200070.git.tanggeliang@kylinos.cn>
 <e8ffd789-f03d-4b99-b0aa-619cc7cce14d@kernel.org> <ZeBzzVL+fwawzVB6@t480>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <ZeBzzVL+fwawzVB6@t480>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 29/02/2024 13:08, Geliang Tang wrote:
> Hi Matt,
> 
> On Thu, Feb 29, 2024 at 12:31:21PM +0100, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 29/02/2024 10:51, Geliang Tang wrote:
>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>
>>> ipv4/ipv6 and v4/v6 are mixed in the output of mptcp_sockopt.sh, this patch
>>> unifies them as v4/v6.
>>>
>>> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
>>> ---
>>>  tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
>>> index 6ed4aa32222f..ae59136b5bb4 100755
>>> --- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
>>> +++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
>>> @@ -130,10 +130,10 @@ do_transfer()
>>>  	local local_addr ip
>>>  	if mptcp_lib_is_v6 "${connect_addr}"; then
>>>  		local_addr="::"
>>> -		ip=ipv6
>>> +		ip=v6
>>>  	else
>>>  		local_addr="0.0.0.0"
>>> -		ip=ipv4
>>> +		ip=v4
>>
>> Mmh, this will change the test name (used in "mptcp_lib_result_*") and
>> this will break the tracking using the test name [1] while the test is
>> still doing the same thing.
>>
>> Maybe this patch is not worth it then, fine to see 'ipv6'. Or only
> 
> Do you mean drop this patch? I agree, let's drop it.

Yes, I prefer not to modify the test name printed in the TAP format at
the end. We can modify what is displayed before.

So OK to drop it, easier.

>> display a different string in what is printed per test, what you were
>> doing in patch 5/9 from the v6, but I don't know where this patch is:
>> did you accidentally drop it?
> 
> 5/9 from the v6 is merged into "v7 7/8".

Ah OK, I'm not there yet.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
