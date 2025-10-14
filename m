Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723DB9475
	for <mptcp@lists.linux.dev>; Tue, 14 Oct 2025 10:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760437603; cv=none; b=lwG3/S5Xrnjoqy9QQluFX+Uvs40zTfJqA9fdrZvVVk9N5hQpG7rGFGzQFR/fKjM0RMgZTWc9uUtuWa6jYd/024Y/JK2d9DpDSK1tlNA2pIza94gkRcXy0iY4lA3A6LW0figkKCn5UeMzxgbZfUomvMXX0sbRaL5Gxz9jXs/hVYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760437603; c=relaxed/simple;
	bh=gcSpytPNZlTn/VZ4GJTldNykugF1ze9OTqXWneoj9dw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oBCqnw+U0uNl8YNiaRVWPSjcbwP7mIlaPxIcdpCUc6EfnQ3brHtJMqK+fQz9+lIyTtgCDgJjT9Dv51QA2tNWHhkIHcIJCkaF74fmqXLnkI9/Qcy70wBE0TcH9mAhcSukBIZIpZSdX5+z6buNj4gl3wZvVM1y124o5TzR+HC0rWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0dGq/W2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0dGq/W2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F668C4CEE7;
	Tue, 14 Oct 2025 10:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760437602;
	bh=gcSpytPNZlTn/VZ4GJTldNykugF1ze9OTqXWneoj9dw=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=o0dGq/W29+p+9mNG1H1AIPTbFhZyFegc/S9e5fR60MaXRJVyg4Did7JGs5xk0Fe3R
	 khFicy5SkAhhoT4RjSBB6KbsEgHVBWiJxOB+FNoLRzJMDtXVgkMRu/M2GU8R0FuHUR
	 tLNLLKjt8GRXz3IoSwW2z5pkaeHwiR81OFkeD1n4/kqGwvnCVy28jgFsLoZ3046cPe
	 RrEWjJ6SDMCrB87FfKhacXPNRNt+DFTHH13sRpSq7O4PWizZY6BiVd7cAE1IfoWBpe
	 RSZb7gElsJBOytBEijjxWMzh1ZV3v7vUq8EJtYOZHarTfDBMouAOe9uW6GBL2pXV09
	 lxYJpI66XwC7g==
Message-ID: <fabd4101-53c9-4c0d-b4dc-7d51ba89ffdf@kernel.org>
Date: Tue, 14 Oct 2025 12:26:40 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net 7/7] mptcp: pm: in kernel: only use fullmesh
 endp if any
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, MPTCP Upstream <mptcp@lists.linux.dev>
References: <20251008-c-flag-add-addr-delay-v1-0-c624eb3bf10d@kernel.org>
 <20251008-c-flag-add-addr-delay-v1-7-c624eb3bf10d@kernel.org>
 <8d1cf5304a2060799a2e3e54ed33a1f572f60e17.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <8d1cf5304a2060799a2e3e54ed33a1f572f60e17.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 14/10/2025 12:10, Geliang Tang wrote:
> Hi Matt,
> 
> On Wed, 2025-10-08 at 16:00 +0200, Matthieu Baerts (NGI0) wrote:
>> Our documentation is saying that the in-kernel PM is only using
>> fullmesh
>> endpoints to establish subflows to announced addresses when at least
>> one
>> endpoint has a fullmesh flag. But this was not totally correct: only
>> fullmesh endpoints were used if at least one endpoint *from the same
>> address family as the received ADD_ADDR* has the fullmesh flag.
>>
>> This is confusing, and it seems clearer not to have differences
>> depending on the address family.
>>
>> So, now, when at least one MPTCP endpoint has a fullmesh flag, the
>> local
>> addresses are picked from all fullmesh endpoints, which might be 0 if
>> there are no endpoints for the correct address family.
>>
>> One selftest needs to be adapted for this behaviour change.
>>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> This patch LGTM!
> 
> Reviewed-by: Geliang Tang <geliang@kernel.org>
> 
> Except for patch 1, I have added my reviewed-by tags to all other
> patches. Please give me some more time to review patch 1. If you're
> willing, please apply patches 2-7 first.

Thank you for your reviews.

I will wait for the review of patch 1: that's the most "urgent" one
(fixing a small behavioural issue), the other ones can wait.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

