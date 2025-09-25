Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBC9C8CE
	for <mptcp@lists.linux.dev>; Thu, 25 Sep 2025 05:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758779337; cv=none; b=Q1ghTZvtZpB3KGB9rUYz2kYA5ZzDLAFh153qVFulBi5C6isM9cKqp93FwGDzeirtonNXU67crGLSbd2FkzGWQEKLV7Hm+s3Ofd3WxvlFHrT8xLj6vivjElsDtiaC8D6lZe/68f7jW2qPgCylPwlQWrU1usIJ+3DhSHy1oU5XOV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758779337; c=relaxed/simple;
	bh=XMtu3u7iVRc+3fAquSgyZQGWsQ0bcaBLVaXsKITo/wk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ruh0kBMeW6Yrwp/TO5aTOiOQOwNur42FwGl5twN75ra5I53JLtfI0H6JjqwNgC17hUbP/ZezLS7vSQEh1P9E1roSvpOzGrpUQ5j++q7NcIzEbdfl+05ljw0iAkBv4EwBwWWCgPNYadpBTRk6751W5ORiLQZyxkzNgoU2ckClcHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2vRMtkL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2vRMtkL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F019CC4CEF0;
	Thu, 25 Sep 2025 05:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758779336;
	bh=XMtu3u7iVRc+3fAquSgyZQGWsQ0bcaBLVaXsKITo/wk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=k2vRMtkLqMYjMAvhIvZiyuULz/M3XtVg5W93ppPKklfPWeuxBMWa+mBMnpQDVrLi9
	 67TR+AgseBfSzh5X9giFmfbrCWoself6PZiyPObRB339hC7vtPSZhItmQANoLbJSkZ
	 xavmlRQqxI2nQQ1/w4Zw9yHofpcozgJnPXAFdkWw3wnwYilm8e0ad+ikroU0mrb76J
	 E2rQ9tCoNSxy4e1oKijFKAqTERrRjXZmzxTiB4nVbC/QAbwjHpXuW/UlK7c4oES+fE
	 YpaRvQOr4qFkLmi9w3YT0jXKOIOuO6nU1RIiyuyqeq0OL6rJwcHxr6H6PnUncvBt6n
	 gZsIs/1I8LHyA==
Date: Thu, 25 Sep 2025 06:48:48 +0100 (GMT+01:00)
From: Matthieu Baerts <matttbe@kernel.org>
To: Mat Martineau <martineau@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Geliang Tang <geliang@kernel.org>,
	MPTCP Upstream <mptcp@lists.linux.dev>
Message-ID: <96cfd646-e8fb-45f3-a808-06e2687f433c@kernel.org>
In-Reply-To: <8efa4ddb-037e-3348-0fc0-5bc118dcccbb@kernel.org>
References: <20250923-pm-kern-endp-add_addr-new-v2-0-ee5369dad569@kernel.org> <20250923-pm-kern-endp-add_addr-new-v2-5-ee5369dad569@kernel.org> <6e25ab4b-5a05-2abf-18f3-2ff08cff34e1@kernel.org> <e71d57f6-7464-4d7b-af62-aea16818d0d7@kernel.org> <d0dd3ed9-aded-413f-a589-dbf434c3d36f@kernel.org> <8efa4ddb-037e-3348-0fc0-5bc118dcccbb@kernel.org>
Subject: Re: [PATCH mptcp-next v2 5/6] mptcp: pm: in-kernel: add 'address'
 endpoints
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <96cfd646-e8fb-45f3-a808-06e2687f433c@kernel.org>

24 Sept 2025 23:51:04 Mat Martineau <martineau@kernel.org>:

> On Wed, 24 Sep 2025, Matthieu Baerts wrote:
>
>> On 24/09/2025 10:33, Matthieu Baerts wrote:
>>> Hi Mat,
>>>
>>> Thank you for your reply!
>>>
>>> On 24/09/2025 00:35, Mat Martineau wrote:
>>>> On Tue, 23 Sep 2025, Matthieu Baerts (NGI0) wrote:
>>>>
>>>>> Currently, upon the reception of an ADD_ADDR (and when the fullmesh f=
lag
>>>>> is not used), the in-kernel PM will create new subflows using the loc=
al
>>>>> address the routing configuration will pick.
>>>>>
>>>>> It would be easier to pick local addresses from a selected list of
>>>>> endpoints, and use it only once, than relying on routing rules.
>>>>>
>>>>> Use case: both the client (C) and the server (S) have two addresses (=
a
>>>>> and b). The client establishes the connection between C(a) and S(a).
>>>>> Once established, the server announces its additional address S(b). O=
nce
>>>>> received, the client connects to it using its second address C(b).
>>>>> Compared to a situation without the 'address' endpoint for C(b), the
>>>>> client didn't use this address C(b) to establish a subflow to the
>>>>> server's primary address S(a). So at the end, we have:
>>>>>
>>>>> =C2=A0 C=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 S
>>>>> =C2=A0C(a) --- S(a)
>>>>> =C2=A0C(b) --- S(b)
>>>>>
>>>>> In case of a 3rd address on each side (C(c) and S(c)), upon the
>>>>> reception of an ADD_ADDR with S(c), the client should not pick C(b)
>>>>> because it has already been used. C(c) should then be used.
>>>>>
>>>>> Note that this situation is currently possible if C doesn't add any
>>>>> endpoint, but configure the routing in order to pick C(b) for the rou=
te
>>>>> to S(b), and pick C(c) for the route to S(c). That doesn't sound very
>>>>> practical because it means knowing in advance the IP addresses that
>>>>> will be used and announced by the server.
>>>>>
>>>>> In the code, the new endpoint type is added. Similar to the other
>>>>> subflow types, an MPTCP_INFO counter is added. While at it, hole are =
now
>>>>> commented in struct mptcp_info, to remember next time that these hole=
s
>>>>> can no longer be used.
>>>>>
>>>>
>>>> I definitely agree that this is a very worthwhile use case. As we
>>>> discussed in the v1 thread, the API in-kernel PM is leading to some
>>>> complexity when mixing endpoint types but this step seems manageable. =
I
>>>> don't think we should continue adding endpoint types after this.
>>>
>>> Agreed!
>>>> Before sending to net-next I would really like to hear from either Pao=
lo
>>>> or Geliang to see if they concur on this one additional in-kernel PM
>>>> endpoint!
>>>
>>> Sure!
>>>
>>>>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/503
>>>>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>>>> ---
>>>>> v2:
>>>>> - rename var and function names to state 1 address will be filled (Ma=
t)
>>>>> ---
>>>>> include/uapi/linux/mptcp.h |=C2=A0 6 +++-
>>>>> net/mptcp/pm_kernel.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 82 ++++++++++++=
++++++++++++++++++++++++++
>>>>> ++++++++
>>>>> net/mptcp/protocol.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
>>>>> net/mptcp/sockopt.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 2 ++
>>>>> 4 files changed, 90 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
>>>>> index
>>>>> 5ec996977b3fa2351222e6d01b814770b34348e9..65dc069e9063325ad2e1ffb1da2=
1cc4a4b6efd32 100644
>>>>> --- a/include/uapi/linux/mptcp.h
>>>>> +++ b/include/uapi/linux/mptcp.h
>>>>> @@ -39,6 +39,7 @@
>>>>> #define MPTCP_PM_ADDR_FLAG_BACKUP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 _BITUL(2)
>>>>> #define MPTCP_PM_ADDR_FLAG_FULLMESH=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 _BITUL(3)
>>>>> #define MPTCP_PM_ADDR_FLAG_IMPLICIT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 _BITUL(4)
>>>>> +#define MPTCP_PM_ADDR_FLAG_ADDRESS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 _BITUL(5)
>>>>
>>>> I do think we can come up with a better word - "address" applies equal=
ly
>>>> to all types of endpoints and doesn't describe the feature.
>>>>
>>>> So, let's brainstorm some options here. To start with, I want to give
>>>> "no" votes to "single" (too much like "signal") and "address".
>>>>
>>>> Some ideas -
>>>>
>>>> * singleton: seems different enough from "signal" :)
>>>>
>>>> * parallel: the subflows are like lines that never cross
>>>>
>>>> * laminar: like the idea of https://en.wikipedia.org/wiki/Laminar_flow=
,
>>>> the different subflows don't mix with each other on an interface (unli=
ke
>>>> the "turbulent" way traffic is mixed by fullmesh). Naming collides wit=
h
>>>> some academic TCP work however.
>>>>
>>>> * sspi: just because we already used this for "single subflow per
>>>> interface" in mptcpd.
>>> Note about sspi: with the new type introduced here, we can still have
>>> more than one subflow per interface if you have different families:
>>> v4/v6. We might need a new "global" option in the future (not a type) t=
o
>>> ensure that, see:
>>>
>>> =C2=A0 https://github.com/multipath-tcp/mptcp_net-next/issues/542
>>>
>>>> Anything there sound good, or helpful in inspiring better ideas?
>>>
>>> Funny, your words are mostly describing the "end result" -- using one
>>> endpoint once -- while I was more trying to find a word describing the
>>> "action" -- this endpoint is used when an ADD_ADDR is received. That's
>>> maybe because I had my mind in the code and tests at that time :)
>>>
>>> I *think* it might be easier to describe the "action", and document the
>>> "end result" that can be achieved with that. That would also be closer
>>> to the current "signal" and "subflow" we have, and maybe people will us=
e
>>> this new type for a different "end result". WDYT?
>>>
>>> Having said that, I'm still struggling to find a good word!
>>>
>>> Maybe we should use multiple words? 'add_addr_accept' so it is linked t=
o
>>> the 'add_addr_accepted' limit?
>>>
>>> Or 'laminar', but mostly because the word is "complex" and might push
>>> people to read the doc :)
>>
>> Or 'sspe': "single subflow per endpoint"? But still, I think it might be
>> easier to focus on the "action". But I'm still open to the "end result"
>> if we cannot find a good word for the "action".
>>
>
> The action vs. result framing is helpful, thanks. While the details of th=
e implementation are clear to you (the author) and us (maintainers), nearly=
 all *users* of the feature never look at kernel code or protocol details a=
nd will be approaching it thinking of the "end result" they want to achieve=
. So that's where my thought process has been with this naming exercise.
>
> 'sspe' or 'laminar' are tied for my top choice at this point.
>
> I tried to come up with multi-word ideas yesterday (since "fullmesh" is a=
 compound word too!) and nothing seemed quite right. "oneconn"/"oneconnect"=
/"oneflow" is the closest I got.

Thank you for having thought about that!

I'm then going to use "laminar", and first explain it should be used in
combination with "subflow", then the behaviour when only this flag is set.

Cheers,
Matt
