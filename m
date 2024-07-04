Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91FA1AE859
	for <mptcp@lists.linux.dev>; Thu,  4 Jul 2024 16:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720111405; cv=none; b=TqzqZxF6Xx9d+ee6ooVKNaq4L57MqngB+J5f+3kken6XiLLt291KWcIltuUTcTXa0bc8jLFm1wc1kDFmKkslVXJ3rcbGbpbgTQ9I28IZEWCg4PKT0iUMDigJznuSSRbqEGFrRsrpcy8Fw2th3RXitl9FOO9T8CWG67Rg3mP2rmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720111405; c=relaxed/simple;
	bh=DsY+/BjP6dSsZz17eyN2b9zP5ydgZwT31lpUgIjdzLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=R64Bck67ZmhPo12rKoBYX7uAGbV324o7lkjNEYdldbCB6IwC8DIgOYBD4BrHjcMDGo4mAjmOclXpvQl+6D+XfihrABmzUwRfwV1N6s9zwZBmVhQ1LfHfPnp3F8mknJT+sCQkWNNcOC/C89EuaNNeTAsE8fZCVernk/eBFy5t4vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ff8yG3jr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ff8yG3jr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F24C3277B;
	Thu,  4 Jul 2024 16:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720111405;
	bh=DsY+/BjP6dSsZz17eyN2b9zP5ydgZwT31lpUgIjdzLs=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Ff8yG3jrjjdpfyQuPaTrua7403l9kp9cdWowaQrQ/2zjrpGYNdr2V/mNX3VOOIxhu
	 lvqwdzj30+B+mtxuVOdkxh+w3OjhxcsJ0yIP5aYbMFpG5sl0feKndmjLf6VkgBuJLV
	 G9Y0flbSEkg4DaGJHOYGWxQF6Hvfa837Bo2Ar65nd1i76YStf9EdcR3WP5BnpznmE6
	 k2O7KTImd695hXEo6drlH7dIon0bGX5eEOW0PHcsSiLegVKNPlfY0zaiEIax6XXTp5
	 E4P82wxY9zqoQ87bqi/jvvUXgsiFvEOS8ZBOr/D7ktWRR+qkgw2ozVDtopTr9q4wlI
	 02bmhv1zK3Xyg==
Message-ID: <1eb24454-8e21-448e-9cbf-a36f0de6f474@kernel.org>
Date: Thu, 4 Jul 2024 18:43:22 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 0/4] mptcp: fix endpoints with 'signal' and
 'subflow' flags
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <20240621-mptcp-pm-avail-v1-0-b692d5eb89b5@kernel.org>
 <39995512b9a2240114fc1a1cd65bbaba2ca996c8.camel@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <39995512b9a2240114fc1a1cd65bbaba2ca996c8.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Paolo,

On 04/07/2024 17:47, Paolo Abeni wrote:
> Hi,
> 
> On Fri, 2024-06-21 at 13:39 +0200, Matthieu Baerts (NGI0) wrote:
>> When looking at improving the user experience around the MPTCP endpoints
>> setup, I noticed that setting an endpoint with both the 'signal' and the
>> 'subflow' flags -- as it has been done in the past by users according to
>> bug reports we got -- were resulting on only announcing the endpoint,
>> but not using it to create subflows: the 'subflow' flag was then
>> ignored.
>>
>> My initial thought was to modify IPRoute2 to warn the user when the two
>> flags were set, but it doesn't sound normal to ignore one of them. I
>> then looked at modifying the kernel not to allow having the two flags
>> set, but when discussing about that with Mat, we thought it was maybe
>> not ideal to do that, as there might be use-cases, we might break some
>> configs, and it was working before apparently. So instead, I fixed the
>> support by splitting the previously shared 'available IDs' bitmap.
>>
>> While at it, I added a new selftest (patch 4) to validate this case --
>> including a modification of the chk_add_nr helper to inverse the sides
>> were the counters are checked (patch 3) -- and allowed ADD_ADDR echo
>> just after the MP_JOIN 3WHS.
>>
>> The selftests modification don't have a Fixes tag, because backporting
>> will not be easy: on some versions, the backport will not generate
>> conflicts, but the test will fail because some helpers are not
>> available. That's OK, many CIs will use the selftests from the last
>> stable version to validate previous stable releases.
> 
> I'm sorry for the large latency.

No problem, thank you for your reply!

> I think the above is more a new feature than a fix, I would avoid
> including fixes tag, to prevent stable backports.

My main goal here is to reduce frustration from users who are (certainly
"badly") setting both the 'signal' and 'subflow' flags on new endpoints.
In the different doc we have, we mention what does 'signal' and
'subflow', but nothing about using them together. For us, it seems
obvious not to set the two flags together. But if you are new to MPTCP,
I can understand that "signalling doesn't seem to hurt", and both
'subflow' and 'signal' flags are used.

(Note that in the mptcp.org implementation, the fullmesh PM was sending
ADD_ADDR and establishing new subflows, just because "it doesn't hurt to
announce all addresses" :) )

Currently, if we use the two flags together, the 'subflow' flag is
ignored. I added the Fixes tag in patch 2, because it sounds like a bug
not to create subflows when the 'subflow' flag is set. And also because
it was working before the mentioned 'Fixes' commit which has
accidentally removed this support.

I understand this can be seen as a feature, but I'm not sure how to
better fix that to avoid this frustration from users when the 'subflow'
flag is ignored. Or we change the kernel not to accept setting the two
flags together?

> I am a bit doubtful about having endpoint with both subflow | signal,
> do we want encourage such bogus setup? What if the endpoint specify a
> port, too? 
> 
> AFAICS it can not work, as the port-based signal endpoint will create a
> listener on <IP>:<port> and later on the 'subflow' flag will try to
> bind on the same <IP>:<port>, failing, while creating the outgoing
> connection.

What about returning an error when a port is given with the 'subflow' flag?

Currently, we do:

  if (addr.addr.port && !(addr.flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
      return -EINVAL;

We could add "(... || addr.flags & MPTCP_PM_ADDR_FLAG_SUBLFOW)".

> What about just documenting the existing behavior?

I don't think we should document that "setting both the 'signal' and
'subflow' flags is allowed, but in fact the 'subflow' flag is ignored in
>= 5.17 versions", no? :)

I initially looked at adding a warning in IPRoute2, but then I failed to
explain when setting these two flags can be justified. (And the new
warning would take time to arrive in Linux distro currently ignoring the
'subflow' flag in this case.)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

