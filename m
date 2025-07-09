Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B2C237713
	for <mptcp@lists.linux.dev>; Wed,  9 Jul 2025 10:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057554; cv=none; b=PPEtkJ/OOvEEPgggnJp0NIOu8akVqqzxmt49Fk96YmqCEBBeRyJ8ZHcQ3oZdRmD/TpfPtx4pYxsJAVWn7UfQ4m4DOycKDGH5L7tvbSlTzGIH2rODPCtkZ3oW6Rxzw9trM3AgKmiVoJ6f39k04hy308g/CaPmPpZAgqwZ+LhV06g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057554; c=relaxed/simple;
	bh=mm3+pbcYIL6fIvWPoK8pCjk1LwGsCzkH2M2IP65r6Dg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=icKSbRIAoHfQBIBRuGqrb1cnGi1szVauloW5RtMmV4n/pllRzsmwToCwMfuaqaNNGPkqBj1qlplw/pm8wWaRfKO/1IygExVoppcLNkOmdolILybSEc/XgQbQxz7ZPPuNESsyg7jPfwF7T402ixKYy1aNwhY8wc4InYiCs4z3sbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FuS6mG2J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FuS6mG2J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A3AC4CEEF;
	Wed,  9 Jul 2025 10:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752057553;
	bh=mm3+pbcYIL6fIvWPoK8pCjk1LwGsCzkH2M2IP65r6Dg=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=FuS6mG2JpjXdcMiRUfJ2xxhQRJU9XUWgAXl2IbwOwVqKCxwJE9WjgAxqU25iHGOAp
	 8XUYblixD6Ib7CMlDMflg3oKcjNkkd0taBGXZmhGjM1hNJg9IMjiIGgCUhAJad4a2q
	 bH4D0+0s+QFo2g7hiaD5cTIPjuMFzqtyXMVItL7drSJsyevd8UZSHf1IFmgiINPhTR
	 u05LrUlnT8WEwuxCV2VHYo4V+qavPF9P0zLPl5PbV8YUbOu56PgeKMt2x3QeJrPdIF
	 lrxTu4rorAROk9p+TS1H30Qb8ezxx+mu+nf2qC+43DzMBqsgDGwOD/dkR1xOeTTjvQ
	 tmXifQ1RjgKHw==
Message-ID: <b5ec832f-2fe8-4dec-af09-db0affc3e5a6@kernel.org>
Date: Wed, 9 Jul 2025 12:39:10 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v2 3/5] mptcp: fix status reset on disconnect()
Content-Language: en-GB, fr-BE
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1751699999.git.pabeni@redhat.com>
 <a5a1798e9f474cf8f8c518ce1b47aebf4b7d5528.1751700000.git.pabeni@redhat.com>
 <a165fd13-3f27-41de-8a51-77ca6838cd72@kernel.org>
 <31fe0442-ab45-438c-abe6-25a9d4f08927@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <31fe0442-ab45-438c-abe6-25a9d4f08927@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

Thank you for your reply!

On 09/07/2025 11:27, Paolo Abeni wrote:
> 
> 
> On 7/8/25 5:43 PM, Matthieu Baerts wrote:
>> Hi Paolo,
>>
>> On 05/07/2025 09:24, Paolo Abeni wrote:
>>> disconnect() can still race with subflow fallback leaving the msk in
>>> inconsistent status. To avoid such race, disconnect() must be blocking,
>>> error out if the argument prevent such wait: the socket will linger
>>> in SS_DISCONNECT state forever.
>>
>> Good idea!
>>
>> Just to be sure, this is not really a behaviour change compared to TCP,
>> right?
> 
> Actually it is, as the TCP disconnect never blocks. On the flip side the
> race actually exists and I haven't find another way to plug it.
> 
> An alternative I thought about was to create a new first subflow on
> disconnect and let the old one 'detach' from the mptcp socket, but that
> was problematic as the 'detached' ssk would have a NULL subflow->conn
> and currently we assume that to be ~always != NULL

Indeed, it doesn't sound safer :)

>> No risks of breaking some cases? (io_uring, etc.?)
> 
> Do io_uring work with mptcp?

I don't know, I never tried. But I don't see why it wouldn't. (Of
course, not when used with zero copy, etc.)

> The disconnect failure when blocking is not
> possible should really never be a problem from a functional PoV:
> disconnect() can fail per documentation and the application should
> handle that case.

But it could set "O_NONBLOCK" and do the close later, no? Or is this
correctly handled?

> Blocking could cause some additional latency or slowdown in that code
> path. I think it should be not problematic, but I have no real idea and
> tend to be too optimistic WRT this kind of issues.
> 
> I suggest not sending this to stable (with a note in the commit message).

Maybe safer indeed.

>> In which cases is this MSG_DONTWAIT flag set with disconnect()?
> 
> Typo in the patch, should be O_NONBLOCK. The socket layer, the vfs layer
>  and iouring could set that.

So typically what we do in the packetdrill tests. But maybe we don't
check the returned value?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

