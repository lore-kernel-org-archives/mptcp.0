Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793294669;
	b=vceiash4wEW9J5KAz12r5sAZdot/rj72gMmpyZN5DxsGHMu3q5ZGJjjFJ88BhYfaBB7o
	 x92tOovlJj00irP6mCtzNb5JonkqXqLoEDm7qTxLR/vBV+OtAXK8qe9/O9jT3YLuRMdxm
	 aO6ttKawvLNL574qKCiofP0oohMWitPOwxgpX1gXQBRxfrE/n3XZTU88b+vUBiEoMK3fI
	 9S+CSoed7Ozj6GJnC1JSlL9+QT1+pC32PC60oM7eMGk8/y91G5p67HMInGJSN740VJE/v
	 Zlhb7csJeF5abA+U9wk1x00AoVX7lFpdjRmlIVeo3iNjMadHb3no5uEFi890F+agV+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793294669;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=f3BdBNh1o3iZmtSjlSRESQeyO7zMNUxkDS2xwUHCGWQ=;
	b=rFiTC/BBi446K9FqdsVBezu41NV3C0u2WiKb5Y+m1+vjUNadr3qLXHi5HKwKeTDKe4tJ
	 2Dg4Y5cr4rF7Qn6sQ/ryvBOfU+0Yq3Tl2I+ziq710wuLsvl/AjzTKigOcwZ4VjVPys1rV
	 NT+lnWIOTo5eh2dJEWFa8Efg0z1rs9PN8yoExNRY8VCHWJBSXU9AvwZiKrT0IKKKN+GXe
	 1QroByv/rBCWRVj0SgvjtxqxvHXs/afNsmjTEartnXbiXHZfru45X8JAGPoxhEc07Enpu
	 E86usUmAaeosQiU1v/fSrKzoXwAtxk5/xLoLfG7jBa+F55UuwUlMW5667dKUMsMoHtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bd2LDDSH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A65C606A31A;
	Thu, 29 Oct 2026 17:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bd2LDDSH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51DF31F01816;
	Thu, 29 Oct 2026 17:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793294668;
	bh=f3BdBNh1o3iZmtSjlSRESQeyO7zMNUxkDS2xwUHCGWQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=bd2LDDSHr6Y/G0+CwJwadqfz54SDMq6uCYWqUFexGhACZgxfqF5JpvH/IM6Gp4msf
	 Oyzi7gy6P8E0/8s0BaTptsViiP/4WGpe63QvhOPSFHkvuTspVVZ81bYQ0pb7vIBT2c
	 8CW0N+sRRDpli9x6hGh43fIqfn1HEiRROsI/6tfzZgyK12eW0HQG63z1BZqRnq9xzB
	 sPb2+2YiHaSi54G5GGT0r1kT8GJtI6zYWjsnGYOwPp226QRdCXY0Dy5f7ppIkYZo/X
	 Df0EUcjFzgay5B4YWdDhmGTkinANd6w1MwlPau0XQiy6TFOkWY0aFz4So4Dp9fcCYF
	 1V5EjIW/58+Ew==
Message-ID: <48a15033-3e8f-4043-aa2b-eb7440bf3742@kernel.org>
Date: Thu, 29 Oct 2026 18:24:25 +0100
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH iproute2-net] mptcp: limits: fix JSON support
Content-Language: fr
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
 mptcp@lists.linux.dev
References: <20261029-mptcp-limits-json-v1-1-7ac73cdab054@kernel.org>
 <20261029100741.3cd38216@phoenix.local>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20261029100741.3cd38216@phoenix.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Stephen,

Thank you for the review!

On 29/10/2026 18:07, Stephen Hemminger wrote:
> On Thu, 29 Oct 2026 14:17:42 +0100
> "Matthieu Baerts (NGI0)" <matttbe@kernel.org> wrote:
> 
>> print_mptcp_limit() was trying to open a JSON sub-object and closing it,
>> but no JSON object was actually created before.
>>
>> Because of that, JSON support was working with the MPTCP limits:
>>
>>   $ ip -j mptcp limits show
>>   add_addr_accepted 0 subflows 2
>>
>> Create a plain object before calling print_mptcp_limit: an array is not
>> needed here because all limits have a different name.
>>
>> After this modification, we now have:
>>
>>   $ ip -j mptcp limits show | jq
>>   {
>>     "add_addr_accepted": 0,
>>     "subflows": 2
>>   }
>>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
> 
> Should be the regular json_obj variants, not the _plain ones
> here.

Mmh, can I disagree with AI? :)

> The AI response was:
> 
> On Thu, 29 Oct 2026 14:17:42 +0100, Matthieu Baerts (NGI0) wrote:
>> print_mptcp_limit() was trying to open a JSON sub-object and closing it,
>> but no JSON object was actually created before.
> 
> Right, and that part of the diagnosis is correct -- the open_json_object()
> and close_json_object() calls in print_mptcp_limit() were silent no-ops
> because no writer existed. Thanks for catching it.
> 
>> Create a plain object before calling print_mptcp_limit: an array is not
>> needed here because all limits have a different name.
> 
> This is where I'd push back. An array isn't needed in the sense that there
> is only ever one object, but it is what every other "ip" subcommand emits,
> including the other three JSON sites in this same file:
> 
> 	ip/ipmptcp.c:317	new_json_obj(json)	mptcp_addr_dump()
> 	ip/ipmptcp.c:345	new_json_obj(json)	mptcp_addr_show()
> 	ip/ipmptcp.c:611	new_json_obj(json)	mptcp_monitor()
> 
> So after this patch "ip mptcp" is inconsistent with itself:
> 
> 	$ ip -j mptcp endpoint show
> 	[]
> 	$ ip -j mptcp limits show
> 	{"add_addr_accepted":0,"subflows":2}

Mmh, yes that's "inconsistent", but that's a different output, for a
different purpose:

 - for the first one, we have a list of endpoints: a dictionary with
   the same keys. We need an extra object (an array, but that could have
   been a dict with the ID as key) here to get the different endpoints.

 - for the limits, we have a bunch of key-values. Adding an extra array
   doesn't make sense.

> The _plain variant exists for the standalone utilities that have their own
> output conventions -- dcb, devlink, dpll, nstat, ifstat, lnstat, vdpa. It
> is not used anywhere else under ip/, and I'd rather it stayed that way.
> 
>> +		new_json_obj_plain(json);
>>  		ret = print_mptcp_limit(answer, stdout);
>> +		delete_json_obj_plain();

Each output has its own convention, no?

> Please use the regular pair instead:
> 
> 		new_json_obj(json);
> 		ret = print_mptcp_limit(answer, stdout);
> 		delete_json_obj();
> 
> which gives
> 
> 	$ ip -j mptcp limits show
> 	[{"add_addr_accepted":0,"subflows":2}]
> 	$ ip -j -p mptcp limits show
> 	[
> 	    {
> 	        "add_addr_accepted": 0,
> 	        "subflows": 2
> 	    }
> 	]

Here, we can see the array doesn't make sense. Are there other similar
output in 'ip' adding an extra array just to present one dict?

> No other change is needed: print_mptcp_limit() already calls
> open_json_object(NULL), which is required either way -- under an array it
> creates the element object, under _plain it created the root object. Plain
> text output is unchanged in both versions.
> 
> Worth doing now rather than later: JSON output for the limits never worked,
> so nothing can be depending on the current shape yet. I checked the mptcp
> selftests as the likely consumer and they parse text only --
> pm_netlink.sh:71 does
> 
> 	ip -n "${ns1}" mptcp limits | awk '{ print $2" "$4 }'
> 
> with no -j or --json use anywhere under selftests/net/mptcp/ (the only jq
> there parses nft output in mptcp_sockopt.sh). So the shape is still free to
> change; once it ships in a release it isn't.
> 
> One nit in the commit message while you're respinning:
> 
>> Because of that, JSON support was working with the MPTCP limits:
> 
> Missing a negation -- "was not working". The example output just below makes
> the intent clear, so this alone wouldn't be worth a v2.

Indeed, I can add the missing "not" if a v2 is needed.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

