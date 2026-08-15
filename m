Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF73E1A6817
	for <mptcp@lists.linux.dev>; Sat, 15 Aug 2026 17:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786815239; cv=none; b=tiGOuOfiL8/C+7bSDjRxvJdeOCqPplgGZOz1GAl4gy/OnDd+hTHYj+k5FhnGVLtQpZK5LBS1+psOaLeAuh/i9rfF8E7UgMkVL59452avJWnPLYdR88TMus7BXvJ/pwhm86x0VCWzX9I1MSuOK1ni9HO1Yfg8NRzwEMelLMlo4TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786815239; c=relaxed/simple;
	bh=qCIXgN/sz4+5BNl4tGyt7J9AkeQLtyZQKIVYgecELg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fmSVJSxoUVmfxbF6CSUV7c3B/KqBz2kb4PEDJItm1ViT//bVytouBb8p9R3XtGzPHcIkONaXU/sU+lFw5eQs9527xa03Ap3gwKknKEjIhf1mdc402CiIKh2pIxCuRKY9Ml9QcX9kCFAU+Dq8zd7amz+gQbX3/nwbP1hOiH6KX7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jdjll0oD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jdjll0oD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B541F000E9;
	Sat, 15 Aug 2026 17:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786815238;
	bh=V+bIDFmk2Z4lg/IqhDPJxUuA2HyU0n9snpV86UU2hIk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Jdjll0oDdyaGlC7OC2vlMOfNVi328iYf7XZphrFXmBgw9FGoUtLbN/Tamps93uDTs
	 G58uoR0IRMztV9SGasZyRZzSgpgs3Od7Ups1at4pXQbedrWDiQwTILWGBlEokZcj14
	 5dG8FsjBA0lF5oIpycC4smzgd84WkjoYP3m2uZU0GnT00eTEfJF1OIzYe8lRJP0BFj
	 /Zdo5hJiiAC5yr7U5mbAQHu3kOryCaKSpXyA94CL2A79sGOYpPytkFnz8YrSHTmwOU
	 ZgDT9zDf5WQXhEVk0bV0NO9IxCQexPYyWhLakJGKfuOrl6aBdjQZTaiGKmnagbGAC3
	 JG2+uZcKXPAnA==
Message-ID: <29304df9-a7e7-4585-aecb-b3ae701ee5bb@kernel.org>
Date: Sat, 15 Aug 2026 19:33:56 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v2] mptcp: options: handle MPC data + csum reqd
 + no csum
Content-Language: fr
To: Mat Martineau <martineau@kernel.org>
Cc: MPTCP Linux <mptcp@lists.linux.dev>
References: <20260805-mptcp-opt-mpc-csumreqd-no-csum-v2-1-dbb52e01a36d@kernel.org>
 <20f3ef05-aebd-84b0-55a6-8ed35c79d07b@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20f3ef05-aebd-84b0-55a6-8ed35c79d07b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat,

On 14/08/2026 03:48, Mat Martineau wrote:
> On Wed, 5 Aug 2026, Matthieu Baerts (NGI0) wrote:
> 
>> Before this modification, a remote peer could send an MP_CAPABLE with
>> data, with the checksum flag set, but without adding the actual 2 bytes
>> of checksum. As a result, uninitialised bytes could be used for the
>> 'csum' field.
>>
>> That was not a critical issue, because this 'csum' field is only used to
>> compare with the expected one, if previously negotiated in the 3WHS.
>> Worst case, the checksum is likely wrong, a fallback is done without a
>> reject if the negotiation was done earlier. That's OK.
>>
>> Yet, better to take the expected path with this case: only look at the
>> checksum flag for MP_CAPABLEs not carrying a data-len.
>>
>> Such packet can be seen as a 3rd or 4th ACK. The RFC8684 mentions [1]
>> that the 3rd packet should have the checksum flag set. When an MPC + ACK
>> contains data, the checksum flag is redundant with the checksum field.
>> It is not clear what should be done for the 4th ACK, nor if the flag has
>> to be set if the checksum field is set.
>>
>> Therefore, it seems fine to only look at the presence of the checksum
>> field, not to break the interaction with stacks that were not setting
>> both.

(...)

> Yes, this looks like a good tradeoff between not breaking interaction
> with other stacks while avoiding an invalid checksum.

Thank you for the review!

New patches for t/upstream-net and t/upstream:
- aa590201e5a8: mptcp: options: handle MPC data + csum reqd + no csum
- Results: 79d7297194ac..52bf6f574345 (export-net)
- Results: 199ed983c1f7..55a0274d38e1 (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/f77d0f8990780a8dc74e236f213b46a0d9b72391/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/84c282b44c231fa96cdec0e7f0fd99be9af9d82f/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

