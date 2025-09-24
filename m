Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D253D2D8363
	for <mptcp@lists.linux.dev>; Wed, 24 Sep 2025 09:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758706577; cv=none; b=jecBfKJ0BesRiu8XMrbJRmnMhw28jFvjzW+iCLOnRKqsN7x9o/6xBvBxfmcg0Fh1NiJ7Spz2nkESTfpbX1wCNoSQpW5Fxg7gzgMH/hmlYciAPM9VZh5zDntXmMuLe4EH4ZTJ/IqWqASpKyedyEa5BSLESD1PvMIqOeVnrpLAeaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758706577; c=relaxed/simple;
	bh=k3BvKpMJlNVsbMPPs8t79C30RldvpSrdQRtiM+fek2o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=aRfaAg4tby3+ZWMP/UP7qcp9cWiLaYk744icscNtThDDTH1niZavP79/NFa28+LfIT8BqZNZ541w2cnQFjKX8KtM86MBYPguKXyz3EBXBRKp126t1Kv+JvOEmsojirVM43f7ANeIDuHt/lQrGVHYTejZMsCBrfF5Kwx8O8ThwMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJ84omrh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJ84omrh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CAC6C116B1;
	Wed, 24 Sep 2025 09:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758706575;
	bh=k3BvKpMJlNVsbMPPs8t79C30RldvpSrdQRtiM+fek2o=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=AJ84omrhFmWXWND7gRIqHk8zR+yGEZHd7aBWbkTHT15Iu/WHcfg/2j3Kl12RYeLTj
	 Opx1t8UBl518ELRiXfgsrZ+4ih0/jt053NbA7Jruu+F4/YJYYIOW5O2FQ8D1kEmlyS
	 mcTp52r5L9ox0oHX8HgxHFHkGBPxEsM9Uvt33mP4r8J8PYY6Hc2duxVZgwcwND3wu+
	 yINbbZ06dFHJ/EF8jAo+5Tkhjo6N/DZMM39l76/twzgtAx3T+EdWqC7x0ugL6Fefs7
	 RqjHUWU9//HMA/4kQDtaG8hYRFNtd16J2/LqZfPVkn61PzVVqbmUXbfjxqUJFcVyaz
	 dYiasBotLDsYw==
Message-ID: <d0dd3ed9-aded-413f-a589-dbf434c3d36f@kernel.org>
Date: Wed, 24 Sep 2025 10:36:12 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2 5/6] mptcp: pm: in-kernel: add 'address'
 endpoints
Content-Language: en-GB, fr-BE
From: Matthieu Baerts <matttbe@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Geliang Tang <geliang@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
References: <20250923-pm-kern-endp-add_addr-new-v2-0-ee5369dad569@kernel.org>
 <20250923-pm-kern-endp-add_addr-new-v2-5-ee5369dad569@kernel.org>
 <6e25ab4b-5a05-2abf-18f3-2ff08cff34e1@kernel.org>
 <e71d57f6-7464-4d7b-af62-aea16818d0d7@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <e71d57f6-7464-4d7b-af62-aea16818d0d7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 24/09/2025 10:33, Matthieu Baerts wrote:
> Hi Mat,
> 
> Thank you for your reply!
> 
> On 24/09/2025 00:35, Mat Martineau wrote:
>> On Tue, 23 Sep 2025, Matthieu Baerts (NGI0) wrote:
>>
>>> Currently, upon the reception of an ADD_ADDR (and when the fullmesh flag
>>> is not used), the in-kernel PM will create new subflows using the local
>>> address the routing configuration will pick.
>>>
>>> It would be easier to pick local addresses from a selected list of
>>> endpoints, and use it only once, than relying on routing rules.
>>>
>>> Use case: both the client (C) and the server (S) have two addresses (a
>>> and b). The client establishes the connection between C(a) and S(a).
>>> Once established, the server announces its additional address S(b). Once
>>> received, the client connects to it using its second address C(b).
>>> Compared to a situation without the 'address' endpoint for C(b), the
>>> client didn't use this address C(b) to establish a subflow to the
>>> server's primary address S(a). So at the end, we have:
>>>
>>>   C        S
>>>  C(a) --- S(a)
>>>  C(b) --- S(b)
>>>
>>> In case of a 3rd address on each side (C(c) and S(c)), upon the
>>> reception of an ADD_ADDR with S(c), the client should not pick C(b)
>>> because it has already been used. C(c) should then be used.
>>>
>>> Note that this situation is currently possible if C doesn't add any
>>> endpoint, but configure the routing in order to pick C(b) for the route
>>> to S(b), and pick C(c) for the route to S(c). That doesn't sound very
>>> practical because it means knowing in advance the IP addresses that
>>> will be used and announced by the server.
>>>
>>> In the code, the new endpoint type is added. Similar to the other
>>> subflow types, an MPTCP_INFO counter is added. While at it, hole are now
>>> commented in struct mptcp_info, to remember next time that these holes
>>> can no longer be used.
>>>
>>
>> I definitely agree that this is a very worthwhile use case. As we
>> discussed in the v1 thread, the API in-kernel PM is leading to some
>> complexity when mixing endpoint types but this step seems manageable. I
>> don't think we should continue adding endpoint types after this.
> 
> Agreed!
>> Before sending to net-next I would really like to hear from either Paolo
>> or Geliang to see if they concur on this one additional in-kernel PM
>> endpoint!
> 
> Sure!
> 
>>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/503
>>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>> ---
>>> v2:
>>> - rename var and function names to state 1 address will be filled (Mat)
>>> ---
>>> include/uapi/linux/mptcp.h |  6 +++-
>>> net/mptcp/pm_kernel.c      | 82 ++++++++++++++++++++++++++++++++++++++
>>> ++++++++
>>> net/mptcp/protocol.h       |  1 +
>>> net/mptcp/sockopt.c        |  2 ++
>>> 4 files changed, 90 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
>>> index
>>> 5ec996977b3fa2351222e6d01b814770b34348e9..65dc069e9063325ad2e1ffb1da21cc4a4b6efd32 100644
>>> --- a/include/uapi/linux/mptcp.h
>>> +++ b/include/uapi/linux/mptcp.h
>>> @@ -39,6 +39,7 @@
>>> #define MPTCP_PM_ADDR_FLAG_BACKUP        _BITUL(2)
>>> #define MPTCP_PM_ADDR_FLAG_FULLMESH        _BITUL(3)
>>> #define MPTCP_PM_ADDR_FLAG_IMPLICIT        _BITUL(4)
>>> +#define MPTCP_PM_ADDR_FLAG_ADDRESS        _BITUL(5)
>>
>> I do think we can come up with a better word - "address" applies equally
>> to all types of endpoints and doesn't describe the feature.
>>
>> So, let's brainstorm some options here. To start with, I want to give
>> "no" votes to "single" (too much like "signal") and "address".
>>
>> Some ideas -
>>
>> * singleton: seems different enough from "signal" :)
>>
>> * parallel: the subflows are like lines that never cross
>>
>> * laminar: like the idea of https://en.wikipedia.org/wiki/Laminar_flow,
>> the different subflows don't mix with each other on an interface (unlike
>> the "turbulent" way traffic is mixed by fullmesh). Naming collides with
>> some academic TCP work however.
>>
>> * sspi: just because we already used this for "single subflow per
>> interface" in mptcpd.
> Note about sspi: with the new type introduced here, we can still have
> more than one subflow per interface if you have different families:
> v4/v6. We might need a new "global" option in the future (not a type) to
> ensure that, see:
> 
>   https://github.com/multipath-tcp/mptcp_net-next/issues/542
> 
>> Anything there sound good, or helpful in inspiring better ideas?
> 
> Funny, your words are mostly describing the "end result" -- using one
> endpoint once -- while I was more trying to find a word describing the
> "action" -- this endpoint is used when an ADD_ADDR is received. That's
> maybe because I had my mind in the code and tests at that time :)
> 
> I *think* it might be easier to describe the "action", and document the
> "end result" that can be achieved with that. That would also be closer
> to the current "signal" and "subflow" we have, and maybe people will use
> this new type for a different "end result". WDYT?
> 
> Having said that, I'm still struggling to find a good word!
> 
> Maybe we should use multiple words? 'add_addr_accept' so it is linked to
> the 'add_addr_accepted' limit?
> 
> Or 'laminar', but mostly because the word is "complex" and might push
> people to read the doc :)

Or 'sspe': "single subflow per endpoint"? But still, I think it might be
easier to focus on the "action". But I'm still open to the "end result"
if we cannot find a good word for the "action".

> 
>> I don't see any issues with the functionality of the code.
> 
> Thank you the review!
> 
> Cheers,
> Matt

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

