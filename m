Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD12F495E5
	for <mptcp@lists.linux.dev>; Fri, 21 Jun 2024 12:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718972058; cv=none; b=i5b2pbTPMHqKRbs4E4DPik0LOlWqOi6VifdViifOaO24wmDEGGL0cYwy15cqR/MxlBC2Mar/BsOlGcjcHar4QV0wkk6OdAuH8yWyN5u7+VLO3JlnNcTjaIaM6i3MdvjDowXemLZyPH4h2us+QisYbZDyh8571gqOza2l6P0c7E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718972058; c=relaxed/simple;
	bh=8sSAQfgGztOIQNcyOQkwmKGX2BiHQ53VInEYNGH8BvY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=BjCCd7soYSMi+mYLg4ZB+vQbq6xzzTcK6o0yWySbRDFKbWZlc0P+v4tfCdFbD+Dj2crJgMM2qaK+wKSvjVcO6TQlsPCYeeJA74G/w3DfIW395PxiXDAlEYUuGo6PF4H8DNxrU8cHZUjmP/qYIeDeCH3xRyTjtLW1pdoPjNy2huM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZ/x9Jz8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZ/x9Jz8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B60C2BBFC;
	Fri, 21 Jun 2024 12:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718972058;
	bh=8sSAQfgGztOIQNcyOQkwmKGX2BiHQ53VInEYNGH8BvY=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=IZ/x9Jz83aZmZvloBUkbrQ8bpe6O4EDgMmbx8D33TKAiO/RX5YRk914oprXXLaIgL
	 0o/OT5LA2bE94qrYbmaNkNon2CZwvvpmoYyrQCRhyDvqCq/zFO+YthJPWbt7zjYxhv
	 ASL8kogq+Z1zlLdJ7lDvVnMbS+X93+Euq7iYu+46suuMIdTbnHr1+GtAmUEgXduENA
	 tiKwlgWppy//Ul9+YnukCSQoeNzAkk+yczwra9krmZ+XFe7kILm/ni3nrMoQsyS0Dz
	 A8VBBIQO0tp6HrfmVwOb7tV/giAtKAgbCwG1o32Gcg03edjnialLBSTIWYMnIz03kK
	 a4ofCxp1A8Q+A==
Message-ID: <f6030817-9395-4389-8423-8ec4d837742e@kernel.org>
Date: Fri, 21 Jun 2024 14:14:14 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-iproute 3/4] mptcp: warn if 'signal' and 'subflow'
 flags are set
From: Matthieu Baerts <matttbe@kernel.org>
To: Mat Martineau <martineau@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
References: <20240605-mptcp-user-feedback-v1-0-d2dc3b399643@kernel.org>
 <20240605-mptcp-user-feedback-v1-3-d2dc3b399643@kernel.org>
 <72cb6b39-7de9-b339-12fa-e7a7546e8a60@kernel.org>
 <ed821f74-95fd-49f2-ae3c-91e2e7bfa395@kernel.org>
 <8feb5653-02fa-8023-a1f9-5ac2cdb3c99b@kernel.org>
 <25ec91a5-cdeb-4cd8-9466-d0b9580ce6d0@kernel.org>
Content-Language: en-GB
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <25ec91a5-cdeb-4cd8-9466-d0b9580ce6d0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 10/06/2024 13:00, Matthieu Baerts wrote:
> Hi Mat,
> 
> Thank you for your reply!
> 
> On 07/06/2024 18:59, Mat Martineau wrote:
>> On Fri, 7 Jun 2024, Matthieu Baerts wrote:
>>
>>> Hi Mat,
>>>
>>> On 06/06/2024 21:14, Mat Martineau wrote:
>>>> On Wed, 5 Jun 2024, Matthieu Baerts (NGI0) wrote:
>>>>
>>>>> Setting both the 'signal' and 'subflow' flags is very likely a mistake
>>>>> from the user, and would bring unexpected behaviours as mentioned in
>>>>> some bug reports on the MPTCP project.
>>>>>
>>>>> It is then important to guide the users by printing a warning on
>>>>> stderr.
>>>>> Users can ignore this message if they have an atypical environment
>>>>> where
>>>>> the initiator of a connection might accept the creation of additional
>>>>> subflows from the other peer.
>>>>>
>>>>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>>>> ---
>>>>> ip/ipmptcp.c | 9 +++++++++
>>>>> 1 file changed, 9 insertions(+)
>>>>>
>>>>> diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
>>>>> index 9847f95b..0f09cf75 100644
>>>>> --- a/ip/ipmptcp.c
>>>>> +++ b/ip/ipmptcp.c
>>>>> @@ -179,6 +179,15 @@ static int mptcp_parse_opt(int argc, char **argv,
>>>>> struct nlmsghdr *n, int cmd)
>>>>>     if (adding && port && !(flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
>>>>>         invarg("flags must have signal when using port", "port");
>>>>>
>>>>> +    if (adding && (flags & MPTCP_PM_ADDR_FLAG_SIGNAL) &&
>>>>> +                  (flags & MPTCP_PM_ADDR_FLAG_SUBFLOW))
>>>>> +        fprintf(stderr,
>>>>> +            "Warning: Setting both the 'signal' and 'subflow' flags
>>>>> is usually a mistake:\n"
>>>>> +            "         'signal' is used to announce additional
>>>>> addresses, typically for the\n"
>>>>> +            "         server side, while 'subflow' is used to create
>>>>> new paths, typically\n"
>>>>> +            "         for the client side. It is not typical to both
>>>>> initiate, and accept\n"
>>>>> +            "         new connections with the same peer. Continuing
>>>>> as requested.\n");
>>>>> +
>>>>
>>>> Hi Matthieu -
>>>
>>> Thank you for the review!
>>>
>>>> For this patch and the next one, I think it would be better to update
>>>> the man page with information about typical usage rather than printing
>>>> this error message. Seems like the ip tool doesn't have other
>>>> informational run-time messages like this (especially ones this long),
>>>> and there's no '-q' flag to silence them for non-typical cases.
>>> That was my first intension, but I think only adding such info in the
>>> man page will not prevent frustrations, and bug reports. I mean: that
>>> supposes people are (fully and carefully) reading the man pages, and not
>>> just 'ip mptcp help' :)
>>
>> Hi Matthieu -
>>
>> Ok, maybe info could be added at runtime (like you suggest below) and
>> also in the man page?
> 
> Yes, we can add info on both sides.
> 
>>> I thought it was OK to let people ignoring this message, because the
>>> action will still be done. But what about adding a new option
>>> 'nowarning' option then?
>>>
>>>  ip mptcp endpoint add (...) [ nowarning ]
>>>
>>> If people know what they are doing, they can add this not to have the
>>> warning, while not fully ignoring what is printing to stderr.
>>>
>>
>> My main concern is to have a way to silence it, so "nowarning" fine with
>> me. Then it would be up to the iproute maintainers :)
> 
> I looked at the code of the in-kernel PM (but I may have missed cases):
> it looks like when both 'signal' and 'subflow' are set, the 'subflow'
> flag is somehow ignored. So does it make sense to allow them together?
> 
> For the 'patch 4/4', I don't see what would be the use case, except if
> only 'backup' is set. We can update that.
> 
> Maybe we should (also) modify the kernel, not to allow cases that don't
> make sense?
> 
> I added a topic -- with more details -- for the next meeting [1].
> 
> [1] https://annuel2.framapad.org/p/mptcp_upstreaming_20240612

After the discussion we had, and the series I just sent [1], do you
think we still need the last two patches adding warnings? Is it enough
with the man update?

There is still the case where people might not set any flags, but it
looks like an issue on their side, a bit like adding an IP without the
netmask, and having issues because of that.

All these patches still apply on the latest 'main' branch from the
iproute2 repo.

[1]
https://lore.kernel.org/r/20240621-mptcp-pm-avail-v1-0-b692d5eb89b5@kernel.org

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

