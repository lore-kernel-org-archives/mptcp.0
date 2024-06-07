Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB4218059
	for <mptcp@lists.linux.dev>; Fri,  7 Jun 2024 16:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717779564; cv=none; b=kZN8YoP6Ayo9O0gwuaH0Tona74suK1LTDtG2ShxDNg19RaOZhtbBb+Q9zyZrJRuNi4YtDCrSTmkLqrhvu3AG/cxGurHLuGwZ1YLSF18Kg5SqvO41SMisxgojk8kiwVzEdMw8HgvDW7FS2ICuXmn9YHJYLji/08jMvzqXB1SUymw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717779564; c=relaxed/simple;
	bh=Z6NrPs5AcsTyGZAuqGdh7LWwawxmY22g/bfOZyN9hqc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hs55NlPUpGS5XZ5A5mDZs+TmnYz3g3+t2nspQsstfeLuTpCF6oCGcOJ9ukS8x4R0lmAQNhHSE65UXny4bYv8CH3MkCU7hnWVnOOFQQRkbqX6hlfmT7JS3/811byPgCc44Ow33N7XY6Kly3w7hS1eRkHhGg3LO18uE5S6sVooVB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tAa9KSQF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tAa9KSQF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C6EC2BBFC;
	Fri,  7 Jun 2024 16:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717779563;
	bh=Z6NrPs5AcsTyGZAuqGdh7LWwawxmY22g/bfOZyN9hqc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=tAa9KSQFY5TPtlPswdjqLnprGNB6t7LnZkW6mu653W/c8TqZl5zfezHN4ldjUNfJt
	 xeTwadnZoWOUPwUyJa6D9yYcjIIJwLiM0cGAfcNO5F0qUoYcIX3qZeQO4fgwx9ye29
	 2+0qLwCy4uwI7ZNNRXK79zDgmwedQnRrBp847bXxYeBarFNvNhh7Qs+sxIo+CFwueL
	 rwqTDRHJHc470wuh4PQDGgA7gSX0kLqbyd4B7qAsQZiUZqir5FSPUvhtIQ0sHx08ss
	 YmqF3NBfHKxGWfwLPAgl2y2xmoiDxocQ7RpXJ2P1HOrZepqiYje+Sl+1AKTb7Zyh3s
	 yhZNklBx31bmw==
Date: Fri, 7 Jun 2024 09:59:23 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
cc: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-iproute 3/4] mptcp: warn if 'signal' and 'subflow'
 flags are set
In-Reply-To: <ed821f74-95fd-49f2-ae3c-91e2e7bfa395@kernel.org>
Message-ID: <8feb5653-02fa-8023-a1f9-5ac2cdb3c99b@kernel.org>
References: <20240605-mptcp-user-feedback-v1-0-d2dc3b399643@kernel.org> <20240605-mptcp-user-feedback-v1-3-d2dc3b399643@kernel.org> <72cb6b39-7de9-b339-12fa-e7a7546e8a60@kernel.org> <ed821f74-95fd-49f2-ae3c-91e2e7bfa395@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-2093919877-1717779563=:88167"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-2093919877-1717779563=:88167
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 7 Jun 2024, Matthieu Baerts wrote:

> Hi Mat,
>
> On 06/06/2024 21:14, Mat Martineau wrote:
>> On Wed, 5 Jun 2024, Matthieu Baerts (NGI0) wrote:
>>
>>> Setting both the 'signal' and 'subflow' flags is very likely a mistake
>>> from the user, and would bring unexpected behaviours as mentioned in
>>> some bug reports on the MPTCP project.
>>>
>>> It is then important to guide the users by printing a warning on stderr.
>>> Users can ignore this message if they have an atypical environment where
>>> the initiator of a connection might accept the creation of additional
>>> subflows from the other peer.
>>>
>>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>> ---
>>> ip/ipmptcp.c | 9 +++++++++
>>> 1 file changed, 9 insertions(+)
>>>
>>> diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
>>> index 9847f95b..0f09cf75 100644
>>> --- a/ip/ipmptcp.c
>>> +++ b/ip/ipmptcp.c
>>> @@ -179,6 +179,15 @@ static int mptcp_parse_opt(int argc, char **argv,
>>> struct nlmsghdr *n, int cmd)
>>>     if (adding && port && !(flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
>>>         invarg("flags must have signal when using port", "port");
>>>
>>> +    if (adding && (flags & MPTCP_PM_ADDR_FLAG_SIGNAL) &&
>>> +                  (flags & MPTCP_PM_ADDR_FLAG_SUBFLOW))
>>> +        fprintf(stderr,
>>> +            "Warning: Setting both the 'signal' and 'subflow' flags
>>> is usually a mistake:\n"
>>> +            "         'signal' is used to announce additional
>>> addresses, typically for the\n"
>>> +            "         server side, while 'subflow' is used to create
>>> new paths, typically\n"
>>> +            "         for the client side. It is not typical to both
>>> initiate, and accept\n"
>>> +            "         new connections with the same peer. Continuing
>>> as requested.\n");
>>> +
>>
>> Hi Matthieu -
>
> Thank you for the review!
>
>> For this patch and the next one, I think it would be better to update
>> the man page with information about typical usage rather than printing
>> this error message. Seems like the ip tool doesn't have other
>> informational run-time messages like this (especially ones this long),
>> and there's no '-q' flag to silence them for non-typical cases.
> That was my first intension, but I think only adding such info in the
> man page will not prevent frustrations, and bug reports. I mean: that
> supposes people are (fully and carefully) reading the man pages, and not
> just 'ip mptcp help' :)

Hi Matthieu -

Ok, maybe info could be added at runtime (like you suggest below) and also 
in the man page?

>
> I thought it was OK to let people ignoring this message, because the
> action will still be done. But what about adding a new option
> 'nowarning' option then?
>
>  ip mptcp endpoint add (...) [ nowarning ]
>
> If people know what they are doing, they can add this not to have the
> warning, while not fully ignoring what is printing to stderr.
>

My main concern is to have a way to silence it, so "nowarning" fine with 
me. Then it would be up to the iproute maintainers :)

> If not, I'm not sure people will notice what they are doing is very
> likely wrong.

It is definely helpful information for new users to get them on the right 
track faster, and also avoid extra support load.


- Mat
--0-2093919877-1717779563=:88167--
