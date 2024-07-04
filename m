Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEDC2F23
	for <mptcp@lists.linux.dev>; Thu,  4 Jul 2024 20:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720123332; cv=none; b=eTG4GSky7Vy9K0QTB5jKznCOiBj9VuFgyn0oSEE1ChmwFC7jg4PtN26ALZhwPp5vbBX2u+hSMgbtuKvO837M3G4GRAdQI7fBZ+iIz7lhdKLVvwfY0NYcqM8MwE6HIE2MCqwPy84tARE8wxBc4eIUfiaYNJyo94beuL25N81vDaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720123332; c=relaxed/simple;
	bh=hVpm13DdojCPzk6lB2Oe4tgKuSsh7Lk99uHUm/nO6xQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=kLEAHWhsoSxIdPUt5nSk4dhTwONKO/EPuNQZCW1cQYfy5VePu6T7irjKq/it5Z+CMguvEsNq9IXKL2h9zxj4dCfYFz3G689lx+mwH/+GrdASanax0y1/OyefSz1lkcAW5FhvdLh+6anFB11ocUs28vJ7kMYakr0JjUJkC3b/CR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MaGf43ac; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MaGf43ac"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D0EDC3277B;
	Thu,  4 Jul 2024 20:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720123331;
	bh=hVpm13DdojCPzk6lB2Oe4tgKuSsh7Lk99uHUm/nO6xQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=MaGf43acpNgv+M9tCS5rY0+11xH/HrimMw/oIyRuNe0p9UoS2KeuuLbtM/hrltQBi
	 4w9KhAdiqrGgxshzyQKHcbwB0jI5hIw+gozj/44Ju9EjCN1haSfgGvWT4z1zCziX+M
	 sCJcunJBI7DJXiDInhvgUrt+WfbcI4KKRYIT8K51C6v345f4ymkFj6awELSln9RRgJ
	 BFxnEYeFUeiPABDhCOGIpw6m5aZQoP1bHpFzTZvGQkGi41SMm/qPx86Rg/QDxe78Kg
	 dZJsY/4gkhrT0KSoFqsKfUuhpkPJFvn2xN5FaSc+b7wz1Pt3tLV9IS3x70aOs499k5
	 T83/MuV2O+XXA==
Date: Thu, 4 Jul 2024 22:02:07 +0200 (GMT+02:00)
From: Matthieu Baerts <matttbe@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Message-ID: <f3293bfa-fb51-478e-bdb8-1841c9d3714e@kernel.org>
In-Reply-To: <fcbd0bd9b0c108a810b22bcd4c55c7e212bd3ecc.camel@redhat.com>
References: <20240621-mptcp-pm-avail-v1-0-b692d5eb89b5@kernel.org> <39995512b9a2240114fc1a1cd65bbaba2ca996c8.camel@redhat.com> <1eb24454-8e21-448e-9cbf-a36f0de6f474@kernel.org> <fcbd0bd9b0c108a810b22bcd4c55c7e212bd3ecc.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 0/4] mptcp: fix endpoints with 'signal' and
 'subflow' flags
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <f3293bfa-fb51-478e-bdb8-1841c9d3714e@kernel.org>

4 Jul 2024 19:32:47 Paolo Abeni <pabeni@redhat.com>:

> On Thu, 2024-07-04 at 18:43 +0200, Matthieu Baerts wrote:
>> Hi Paolo,
>>
>> On 04/07/2024 17:47, Paolo Abeni wrote:
>>> Hi,
>>>
>>> On Fri, 2024-06-21 at 13:39 +0200, Matthieu Baerts (NGI0) wrote:
>>>> When looking at improving the user experience around the MPTCP endpoin=
ts
>>>> setup, I noticed that setting an endpoint with both the 'signal' and t=
he
>>>> 'subflow' flags -- as it has been done in the past by users according =
to
>>>> bug reports we got -- were resulting on only announcing the endpoint,
>>>> but not using it to create subflows: the 'subflow' flag was then
>>>> ignored.
>>>>
>>>> My initial thought was to modify IPRoute2 to warn the user when the tw=
o
>>>> flags were set, but it doesn't sound normal to ignore one of them. I
>>>> then looked at modifying the kernel not to allow having the two flags
>>>> set, but when discussing about that with Mat, we thought it was maybe
>>>> not ideal to do that, as there might be use-cases, we might break some
>>>> configs, and it was working before apparently. So instead, I fixed the
>>>> support by splitting the previously shared 'available IDs' bitmap.
>>>>
>>>> While at it, I added a new selftest (patch 4) to validate this case --
>>>> including a modification of the chk_add_nr helper to inverse the sides
>>>> were the counters are checked (patch 3) -- and allowed ADD_ADDR echo
>>>> just after the MP_JOIN 3WHS.
>>>>
>>>> The selftests modification don't have a Fixes tag, because backporting
>>>> will not be easy: on some versions, the backport will not generate
>>>> conflicts, but the test will fail because some helpers are not
>>>> available. That's OK, many CIs will use the selftests from the last
>>>> stable version to validate previous stable releases.
>>>
>>> I'm sorry for the large latency.
>>
>> No problem, thank you for your reply!
>>
>>> I think the above is more a new feature than a fix, I would avoid
>>> including fixes tag, to prevent stable backports.
>>
>> My main goal here is to reduce frustration from users who are (certainly
>> "badly") setting both the 'signal' and 'subflow' flags on new endpoints.
>> In the different doc we have, we mention what does 'signal' and
>> 'subflow', but nothing about using them together. For us, it seems
>> obvious not to set the two flags together. But if you are new to MPTCP,
>> I can understand that "signalling doesn't seem to hurt", and both
>> 'subflow' and 'signal' flags are used.
>>
>> (Note that in the mptcp.org implementation, the fullmesh PM was sending
>> ADD_ADDR and establishing new subflows, just because "it doesn't hurt to
>> announce all addresses" :) )
>>
>> Currently, if we use the two flags together, the 'subflow' flag is
>> ignored. I added the Fixes tag in patch 2, because it sounds like a bug
>> not to create subflows when the 'subflow' flag is set. And also because
>> it was working before the mentioned 'Fixes' commit which has
>> accidentally removed this support.
>
> Ah, my bad! I underlooked the commit message and missed this part.
>
>>> I am a bit doubtful about having endpoint with both subflow | signal,
>>> do we want encourage such bogus setup? What if the endpoint specify a
>>> port, too?=C2=A0
>>>
>>> AFAICS it can not work, as the port-based signal endpoint will create a
>>> listener on <IP>:<port> and later on the 'subflow' flag will try to
>>> bind on the same <IP>:<port>, failing, while creating the outgoing
>>> connection.
>>
>> What about returning an error when a port is given with the 'subflow' fl=
ag?
>>
>> Currently, we do:
>>
>> =C2=A0 if (addr.addr.port && !(addr.flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>
>> We could add "(... || addr.flags & MPTCP_PM_ADDR_FLAG_SUBLFOW)".
>
> IMHO if we deny SIGNAL | SUBFLOW for a subset of the possible
> configuration, than is better to be consistent and deny them for all
> the conf.

I thought about denying them all, but I wonder if there are no use cases cu=
rrently using that. I didn't want to break them. Do you think it would be O=
K?

For the moment, using signal + subflow + port doesn't work. But more import=
antly, it cannot work. This looks similar to signal + fullmesh that is curr=
ently denied. So maybe OK to deny only a subset?

>>> What about just documenting the existing behavior?
>>
>> I don't think we should document that "setting both the 'signal' and
>> 'subflow' flags is allowed, but in fact the 'subflow' flag is ignored in
>>> =3D 5.17 versions", no? :)
>
> Yup, I missed the regression part of it.
>
> If possible, I would be happy to reduce complexity by preventing signal
> and subflow flags together.

Do you think it would be OK to backport that? How to know if this configura=
tion is not already used for valid use cases?

>> I initially looked at adding a warning in IPRoute2, but then I failed to
>> explain when setting these two flags can be justified. (And the new
>> warning would take time to arrive in Linux distro currently ignoring the
>> 'subflow' flag in this case.)
>
> Well, distro problems are distro problems, I'm sure we can ignore the
> distro lifecycle problems here. Should be addressed by a completely
> different set of persons ;)

That's our problem if people report issues to us :-P

> Indeed the ip-mptcp man page could help some significant rewording,
> what about starting from there?

Yes I started to do that, I will look at the v2 :)

https://lore.kernel.org/mptcp/20240605-mptcp-user-feedback-v1-0-d2dc3b39964=
3@kernel.org/T/

> PORT description implicitly refers to 'signal' endpoint without
> mentioning such fact. Also it has effect for subflow endpoint, not
> mentioned there

Good idea to mention that. I will look at adding that in the v2.

Cheers,
Matt
