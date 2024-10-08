Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F011DF24D
	for <mptcp@lists.linux.dev>; Tue,  8 Oct 2024 15:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728400100; cv=none; b=pzJGXJB7dnv84DzA5MlJcJc3bysejrLxnOzU722hYbnytw1myLLKIhMaIVeAMe5WwFkWE8adFXF50tESdGSnjP1QeaEMyfrBl7ToN3ZC+xHwGR12ZKuo9+vqo2F/skogybji/bvav6HejvBL02Yl1x/MNfOuU8/BkzrLLX2jku0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728400100; c=relaxed/simple;
	bh=g21n8typ2v33pncWAK1z7JtKlJtD5jGX5/oGcH68MRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J7roR2L4Hoj7w8dEe5nVAnsUxAySU4xhgdeo6n/XD0Ri0ShT/KBZA7mF0YffmUR2y5Vr0JipXyghKugM8cBm2GTENPscaqZ2rR5Lw8CLRhHSwRgqIj60CUpfQNLmjGAtu0dh5oUqnoqFnWnmaj4/Xjg1xn/6F4vdrOGI8eC0c3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZjXD+gA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZjXD+gA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB14C4CEC7;
	Tue,  8 Oct 2024 15:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728400099;
	bh=g21n8typ2v33pncWAK1z7JtKlJtD5jGX5/oGcH68MRE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fZjXD+gAPpAbjIyJaVXTV/ilgrymV0p1V47tSNjUUIuoZAXiB2+cO7qK/OZs1YcyQ
	 MJhql7OKvUKK1u6vHhkvDIEENujofUQ+9VqKblqL3y4Wf5nvEStYOaZLhUjP8Y+ZXE
	 MHnDY0gox1vfb1qoqoPQAxBQNBdTzgpVY3tJFCZeLO2nBvdBYi2093ybXCOL9MUSan
	 20I7sd6rwm4PhWG/NYG7Al3e7BLXo+1YhIPzhZYzZsoRTbmhL0u35oUUiYjF95Xm1h
	 C2wWk5xahxu/q2XXJE5XQWtAi36G1H4Ost+AmZNsGpcZg11tXgj4Lbb8kAATnZqS47
	 hVb1IrAH7TkYA==
Message-ID: <25b5a7a1-7de6-4a53-9c99-67d6a880763c@kernel.org>
Date: Tue, 8 Oct 2024 17:08:16 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v2 2/2] selftests: mptcp: join: add test-case
 for MPC attempt towards signl ep
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>
Cc: MPTCP Linux <mptcp@lists.linux.dev>
References: <20241007-mpc-hs-port-v2-0-0c9e7827bd0f@kernel.org>
 <20241007-mpc-hs-port-v2-2-0c9e7827bd0f@kernel.org>
 <dcf6cbb3-7521-4969-88d9-7f98c1afe292@redhat.com>
 <2cf1db4f-bb8c-4674-b31e-1bd6217301a7@kernel.org>
 <250cb7c2-5819-45e6-a171-9f3a50049411@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <250cb7c2-5819-45e6-a171-9f3a50049411@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 08/10/2024 16:20, Paolo Abeni wrote:
> On 10/8/24 11:42, Matthieu Baerts wrote:
>>> @@ -2963,6 +3008,25 @@ add_addr_ports_tests()
>>>>            chk_join_nr 2 2 2
>>>>            chk_add_nr 2 2 2
>>>>        fi
>>>> +
>>>> +    if reset "port-based signal endpoint must not accept mpc"; then
>>>> +        local port ret count
>>>> +        port=$(get_port)
>>>> +
>>>> +        cond_start_capture ${ns1}
>>>> +
>>>> +        pm_nl_add_endpoint ${ns1} 10.0.2.1 flags signal port ${port}
>>>> +        mptcp_lib_wait_local_port_listen ${ns1} ${port}
>>>> +
>>>> +        timeout 1 ip netns exec ${ns2} \
>>>> +            ./mptcp_connect -t ${timeout_poll} -p $port -s MPTCP
>>>> 10.0.2.1 >/dev/null 2>&1
>>>> +        ret=$?
>>>> +
>>>> +        cond_stop_capture
>>>> +        cat "$capout"
>>>
>>> Perhaps worthy to move cat "$capout" into cond_stop_capture()
>>
>> I should have mentioned that in the changelog: I wanted to, but then it
>> would change the behaviour for the other cases in do_transfer() where
>> 'cat "$capout"' is used in 3 different places. 
> 
> Why would that change the behavior? AFAICS the 'cat "$capout" statement
> happend onece per do_transfer() invocation, just before 'return'. Moving
> it into cond_stop_capture would just reduce code duplication.

Yes, but the info about the capture will be printed earlier. Will
tcpdump still have time to flush all the last info into this file,
before the 'cat'? I guess that's not a big deal to do that, and if there
are conflicts when doing backports, we can also drop the patch from the
backports.

Also, talking about backports, should we add the same 'Fixes' tag as for
the previous patch, and add this in the commit message?

  The 'Fixes' tag here below is the same as the one from the previous
  commit: this patch here is not fixing anything wrong in the selftests,
  but it validates the previous fix for an issue introduced by this
  commit ID.


Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

