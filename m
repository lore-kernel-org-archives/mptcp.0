Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5A825FA13
	for <mptcp@lists.linux.dev>; Tue, 20 May 2025 10:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747735931; cv=none; b=b8bpl5HzSw6fi3MJhzOC9LuMRAZh7eplHfenkFR9WCtJPRLiAvI6yJyoqKRGCr3VgLm2lGVw7XsVRdvC0YSeIEHixR9xd5fq92y7YoIWt8uG22UiYpyOHQceSD88eZn+MXxv9FkHNzieVcbWvOgATyq0GyFRvtPGVYn4rIVwIc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747735931; c=relaxed/simple;
	bh=1136phdiHLUhABGYj958h8Mmn9pZeG7m7Gkl+lxxzyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WNUuwV2Yrci/cKkeEadtchzvtCxAJ9ZtYCsvjmQ/SmZZJCwuwyCl5HjyxEQexXO/VT8+BJ5otZKUwzR3tfh3jfpwkQ8v3MK7Y/iREJ6tKCBDoy6KA1EkHlxhU5BxYacx4rnAVj9AkHS/5W7DDGDGefwW7OnL5rsO9i++yF3OnE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5HreepZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5HreepZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A3EC4CEE9;
	Tue, 20 May 2025 10:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747735930;
	bh=1136phdiHLUhABGYj958h8Mmn9pZeG7m7Gkl+lxxzyc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=J5HreepZTNaeewGXw7m5x5HgZxeJ2K5Wv+Z8NYdXZ6QVxMbzCehigOyHI2yvhQtDb
	 TmFuGOq+hMyZbMNCOiWyMj7lf3EMy6oRED/jdsst+nta3Xw26O/ZQsJX0NopcVdGGS
	 9oyfaCDCytxBkAqMPNWA/n4TCiGig4eeJqn248fwKOjmMKDSHBf7C/vxXCnxoM6Tz8
	 IqpilAQPku1yNIxofEJvqSpQCW9GDznOS8dYBj4pVD5L32BpRSr4bqXlZ41LRgZQFd
	 Wktjz5h5UeVpbIZcJb0RJsakNQjfKMx/gwV0Q8PUaSvl59jm1GurFzXC6B1JyaErbB
	 8pJ0pXiT7dlRw==
Message-ID: <2f90340b-e414-4a3b-99de-03637c14ea3b@kernel.org>
Date: Tue, 20 May 2025 12:12:07 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: MPTCP support for git (on Linux)
To: Muhammad Nuzaihan <zaihan@unrealasia.net>
Cc: mptcp@lists.linux.dev
References: <CACNYkD4fBm6FDDUNbBY7Uc3MkONF7A7UDNajkTP4Xc4nfvWXZw@mail.gmail.com>
 <305297b3-0911-402c-ab73-11de793881e7@kernel.org>
 <NVRIWS.HAQBNXTEKXJO2@unrealasia.net>
From: Matthieu Baerts <matttbe@kernel.org>
Content-Language: en-GB, fr-BE
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <NVRIWS.HAQBNXTEKXJO2@unrealasia.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19/05/2025 19:42, Muhammad Nuzaihan wrote:
> Hi Matt!
> 
> Great to hear from you.
> 
> On Mon, May 19 2025 at 06:47:10 PM +0200, Matthieu Baerts
> <matttbe@kernel.org> wrote:
>> Hi Muhammad
>>
>> On 19/05/2025 13:02, Muhammad Nuzaihan wrote:
>>>  Hi,
>>>
>>>  I don't know matt's email address so i am reaching out here.
>>>
>>>  I have currently added support for the git protocol (not git over ssh
>>>  or git over http) and you can find the patch here:
>>>
>>>  
>>> https://lore.kernel.org/git/4A7FWS.KARM6LOQBQ5S3@unrealasia.net/T/
>>> #m43718b0ad86f1f70b425a913dde63a09ff56b758
>>
>> Thank you for suggesting this and telling us about that here.
>>
>> I think it might help to reduce the size of the patch to get this
>> feature accepted. You can eventually do that by modifying how socket()
>> is called to use IPPROTO_MPTCP instead of IPPROTO_TCP or 0. In other
>> words, no need to modify the arguments passed to getaddrinfo(): it
>> supports MPTCP only since recently, and not particularly needed, just to
>> change one parameter.
> 
> I feel my code is a bit huge as well. I did this over last weekend to
> look at
> the git and made that quick patch. the git developers weren't too
> helpful and

I see. On the other hand, I can understand that with the amount of
contributions they get, they don't try to go too far when they receive
patches that are not generated and formatted as requested (using
`format-patch` and `send-email` for example -- I know their
SubmittingPatches is very long...)

> it's just that everyone seems pessimistic about mptcp.

Not everyone ;)

But you picked big projects with a lot of users :)
Typically with these projects, it is harder to introduce new features,
maintainers don't want stuff that can break existing features, and are
very cautious about changes that can affect the maintenance. That's why
it is important to isolate stuff, propose "ready" stuff (not WIP or half
tested, or if the feature is big, it should be well introduced before),
and follow the contribution rules.

> The first concern from the git mailing list was the 2022 CVE about the
> crash
> because of backpressure in mptcp and i do not find the comment about it
> reasonable
> as the bug was a long time ago and RedHat/Debian would have backported
> the patch.

Yes, this bug was from a long time ago, and a regression between
versions, not really relevant to point this out.

> First it was chromium and i hope git project maintainers could look at
> it differently.

Chromium devs based their discussions on a document from 2013...

https://chromium-review.googlesource.com/c/chromium/src/+/6355767

It might be good to ask them again if they think the modification can be
accepted at some points, or if something needs to be improved first.

(Note that I already talked to people from Mozilla, and they were OK to
support MPTCP on Linux if someone is OK to work on it)

> It's not the first time as i had to faced something similar to this as
> previously
> was with IPv6 decades ago.
> 
> Anyway,
> 
> So i'll just revert the part of code that i made a check for
> getaddrinfo() then.
>>
>> Also, if MPTCP is opt-in, then no need to check for the kernel version,
>> the errors, etc. simply abort.
>>
>> In other words, the modifications could look like this:
>>
>>       sockfd = socket(ai->ai_family, ai->ai_socktype,
>>   #ifdef IPPROTO_MPTCP
>>                       needs_mptcp() ? IPPROTO_MPTCP :
>>   #endif
>>                       ai->ai_protocol);
>>
>> (+ the needs_mptcp() helper or just checking for the 'mptcp' var)
> 
> ah! my old mistake, i always forget about using ternary operators.
>>
>>
>> On the client side, it looks strange to me to look at an env var. Is it
>> common in Git? Can you not use a new entry in the Git config instead?
>> (If we have to set an env var before each Git commands, maybe even
>> easier to use 'mptcpize run git (...)'.)
> 
> I wanted to add an option in git config (can be global ~/.gitconfig or
> per-project),

Yes, I think we should have that, e.g. to enable it for some specific
servers where we know in advance they support MPTCP.

> but it was taking too long so i left it with env var (i think it's an
> unknown fact git can
> be configured with env vars and i was surprised after reading the code)
> 
> To be honest, i think a clear way is to add the option in .gitconfig is
> the way forward and i will add that in after i figure that out.

I guess both ways can be supported (later).

> 
> It was a quick hack which i added persisted the environment variable in
> my shell.
>>
>>
>> On the server side, it might be interesting to first suggest using MPTCP
>> by default if available. If not, a fallback to TCP can be done, e.g.
>>
>>   #ifdef IPPROTO_MPTCP
>>     sockfd = socket(ai->ai_family, ai->ai_socktype, IPPROTO_MPTCP);
>>     if (sockfd < 0)
>>   #endif
>>        sockfd = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
>>
>> To justify this, you can refer to:
>>
>>
>> https://www.mptcp.dev/faq.html#why--when-should-mptcp-be-enabled-by-
>> default
> 
> I see. Just got to know about the defaults. Thank you!

(But I can also understand if they prefer to introduce MPTCP support
first, then change the default behaviour later on.)

>>
>> (in short: an MPTCP socket will be returned after a call to accept()
>> only if a client requested to use MPTCP ; if not, a TCP socket will be
>> returned like before. So the client can decide to use MPTCP or not, and
>> no impact on the previous traffic on the server side.)
>>
> Ah, alright, i'll do that one.
>>
>> If you want me to review the new versions, you can fork the Git repo on
>> GitHub [1], do your modifications in a dedicated branch, then create a
>> pull request to merge this branch with master **on the same repo** (not
>> on the upstream repo). From there, you can ping me.
> 
> I'll start continue the work this weekend if you are okay with it since
> i would
> have more free time then.
> 
> I've already forked the main git repo: https://github.com/muhammadn/git

Don't hesitate to create a PR to the master branch on the **same** repo
(+ enable "GitHub Actions") to get some feedback from the CI before
submitting anything to Git maintainers.

>> [1] https://github.com/git/git
>>
>>>  Reason being was that i was handling large (public) git codebase over
>>>  unstable links and i think it's also a good idea for me to add for the
>>>  support for the most basic git protocol for read access of large
>>>  public git codebases.
>>
>> That's a good use-case. I didn't think about it because I often use Git
>> over SSH (or HTTPS), but I understand it can be helpful for you!
>>
>>
>>>  The implementation i did is for both client side and server side of
>>>  the git protocol.
>>
>> I think it might be better to split the two implementations in different
>> commits, no?
> 
> Agreed.
Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

