Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4546A2253EB
	for <mptcp@lists.linux.dev>; Mon, 30 Mar 2026 09:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774864255; cv=none; b=FqTK9hbo1bF4JIMCxvpSTcW91nLJF+5bAdiQGRa/LjeBxbPei78GTZJJy1zcp7MQmeD10KkvjF+MmxNUUlge/x2SMTAzpXk2jl8kMvcXXBTgagI2FSFAkfuYp7OUSwZZZDIydW1vr5UeWI3ubkbvIbWnh14gice5i7qYirFFA00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774864255; c=relaxed/simple;
	bh=Ab8tdkv6TFBe+ZBzSrrHUImKbY9vTxWj/ATWHkjeRRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=twelT9UE+Y+XlwfxzUCOeIujv+upMC8c+lHMsLPtxseqEqP9hIa92SvjGr3fQKlbXKgYRtGA6eHTlkjayYjgATEPDWpwvH/Ah4/KmApoQvq9VoHzSN6hh7lilEUuX2iTdHwHMjJ2RwqtYPaTALFKhz3O5Zwe1hXJTRmX/wVtfoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=geCGW48+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="geCGW48+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F100C4CEF7;
	Mon, 30 Mar 2026 09:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774864254;
	bh=Ab8tdkv6TFBe+ZBzSrrHUImKbY9vTxWj/ATWHkjeRRA=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=geCGW48+If+pi6ykcgZs+LZEhE9g1Iw3w/zc2aL5SxqH0XjNPHREe/wbAu2cFVhUk
	 hcvtkiHHNWU8h8FHSt0/W3DWvB6BbhY8w5NEMrQm7if0FNAqfinZjuc+Lb84kxgtUO
	 dsSjHNwq1S1msGNPX9EAk6GIkfrXwbEF+tcrifgbdI2BnpGRr0u2w4xrS88sA2Osjy
	 hxdiT2qQKrF6yPELckWdAdDcqpFoNU+2Ry70EwlbUt0U6JjjRh/oVhrZLp6j35+7FT
	 y1plaZOhduqygdQdqwRitEt3EcmLXLgb3IW4Vbo3XhE2Mu070ao6+YFdvM0KWmbxrP
	 CUye+5VQgJzmw==
Message-ID: <8eb9b926-9402-41e7-9574-f2886f67d14e@kernel.org>
Date: Mon, 30 Mar 2026 11:50:51 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next] mptcp: preserve MSG_EOR semantics in sendmsg
 path
To: gang.yan@linux.dev, mptcp@lists.linux.dev
References: <20260309025431.125943-1-gang.yan@linux.dev>
 <c572547f-449b-43e9-bd76-e0ffe2ebf735@kernel.org>
 <be87d58dcca25715b3f992acd152a6778de44dec@linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Content-Language: fr
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <be87d58dcca25715b3f992acd152a6778de44dec@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Gang,

On 30/03/2026 10:19, gang.yan@linux.dev wrote:
> March 27, 2026 at 12:42 AM, "Matthieu Baerts" <matttbe@kernel.org mailto:matttbe@kernel.org?to=%22Matthieu%20Baerts%22%20%3Cmatttbe%40kernel.org%3E > wrote:
> 
> 
>>
>> Hi Gang,
>>
>> Thank you for the new version.
>>
>> On 09/03/2026 03:54, Gang Yan wrote:
>>
>>>
>>> From: Gang Yan <yangang@kylinos.cn>
>>>  
>>>  Extend MPTCP's sendmsg handling to recognize and honor the MSG_EOR flag,
>>>  which marks the end of a record for application-level message boundaries.
>>>  
>>>  Data fragments tagged with MSG_EOR are explicitly marked in the
>>>  mptcp_data_frag structure and skb context to prevent unintended
>>>  coalescing with subsequent data chunks. This ensures the intent of
>>>  applications using MSG_EOR is preserved across MPTCP subflows,
>>>  maintaining consistent message segmentation behavior.
>>>  
>>>  Signed-off-by: Gang Yan <yangang@kylinos.cn>
>>>  ---
>>>  
>>>  Notes:
>>>  - This patch incorporates feedback and suggestions from Paolo Abeni
>>>  and Geliang Tang, including memory alignment optimizations for the
>>>  mptcp_data_frag struct (shrinking overhead to u8 and using bitfield
>>>  for eor to avoid size increase) and compile-time checks with BUILD_BUG_ON.
>>>
>> Please mention why you shrank "overhead" to a u8 (not to increase the
>> struct size), and why it is OK to do so (u16 not needed because ...) +
>> explaining the BUILD_BUG_ON().
> 
> The ‘u8’ is one of Paolo's suggestions[1]. I think 'u16' is not needed because:
>  - 'offset = ALIGN(orig_offset, sizeof(long));'
>  - 'dfrag->offset = offset - origin_offset + sizeof(struct mptcp_data_frag);',
> the max value of offset is 7, and sizeof(struct mptcp_data_frag)) is
> usually 40, so the overhead is 47, far less than 255.

Thank you for the explanation. Can you then mention in the commit
message that it is fine to reduce overhead to a 'u8', and add the above
explanation, please?

If 'offset' max value is 7, it could also be reduced from a u16 to a u8
then, no?

> Another suggestion from Paolo[1] is a build time check on the max 'overhead'
> value. So I use 'ALIGN(1, sizeof(long)) + sizeof(struct mptcp_data_frag)' to
> represent the max_val of 'overhead'.

It might be good to add a comment here too, at least to explain that
"ALIGN(1, sizeof(long))" represents 'offset' maximum size.

> But Paolo also mention it's probably too conservative. WDYT?

Maybe, but it doesn't hurt I suppose. As long as this check is clearly
linked to different fields from the mptcp_data_frag structure → having a
comment explaining that.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

