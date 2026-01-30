Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE71A2FDC5C
	for <mptcp@lists.linux.dev>; Fri, 30 Jan 2026 18:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769799299; cv=none; b=FejzA2OUMKTvL0xlbhr52Hj8hQlOzZx64XW/7YU0Y/oXaPs5sM1IOJuFv9MdV/Vl8jWbosrC7JIitq6S+TX9utwMvIUBtX7Q9EHUzcoGZkHyK2/J/f31Ho/G3wTx78tFyxVeM+kIXHS35OucyT11jQVBAov0JXsdklWrNEcO3Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769799299; c=relaxed/simple;
	bh=UxR7izAyr3UmU2VgzUGKn+o6BW2+62GB45d7QfXMQAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kHoeNUvIJgcH+HsWr8VIIDhCC6hfG5+ie3Q3scuDLXYv8iB+uzMbvDx0xA1cnAuAAFSlAVHbpbIlGOtWL1Z00JycTk3mKb7Y9d6Ct8YaTY9ZgbK8oMzrKB3kb/lYX3exFRDkOhUGxZGp+JRHhzWopRFFC7hUN6F+PYKosA11YN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qJUqfQcF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJUqfQcF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 505F9C4CEF7;
	Fri, 30 Jan 2026 18:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769799299;
	bh=UxR7izAyr3UmU2VgzUGKn+o6BW2+62GB45d7QfXMQAo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qJUqfQcF6WVCuL6axG98zcsxq7P5tM6tqMB4vCC5TZgCkbmaf72pS128NXl52C3hN
	 uuDnYIu/j2M4T9OvrRXAA55M701YyOmz88GZk5CePoZYlNQFnSULDqDzpe7CfYsa8m
	 0OeEzHVuGpgIS5Dc6ldHf8kZxRMAFrIjZo6Wzo5JHl2FrIwSLAPlj56ViUUJpOrWrr
	 LqbgdtWnWFRTBjA6Iflut15+7Fw4LuQONpF+LmDWghdcSTQfVEOtJk2+5dme+6YS9a
	 GpHv+CrB4hgPztX2Z6mQvcfVrZ4hkokWAVTllTwuEUz9v2OUjGq3ekKCJFpJGoBd7k
	 OoEWNv2XGhmtw==
Message-ID: <97558e02-8fac-4970-8597-bc4ffe4f178f@kernel.org>
Date: Fri, 30 Jan 2026 19:54:56 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next] selftests: mptcp: diag: sort all #include
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Gang Yan <yangang@kylinos.cn>
References: <20260130-mptcp-sft-sort-includes-v1-1-ab022fad9741@kernel.org>
 <20260130115218-0bdb243f-819d-46aa-a7cb-fd43fefccb8d@linutronix.de>
 <e13a0b73a01583e614e2b7e116075a24d9178472.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <e13a0b73a01583e614e2b7e116075a24d9178472.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang, Thomas,

On 30/01/2026 14:50, Geliang Tang wrote:
> On Fri, 2026-01-30 at 11:53 +0100, Thomas Weißschuh wrote:
>> On Fri, Jan 30, 2026 at 11:41:43AM +0100, Matthieu Baerts (NGI0)
>> wrote:
>>> This file is the only one from this directory not to have all these
>>> header inclusions sorted by type and alphabetical order.
>>>
>>> Adapt them, to ease the reading, prevent conflicts during potential
>>> future backport modifying these lines, and also to avoid having
>>> UAPI
>>> header inclusions before libc ones, see [1].
>>>
>>> Link:
>>> https://lore.kernel.org/20260120-uapi-sockaddr-v2-1-63c319111cf6@linutronix.de
>>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>
>> Thanks!
>>
>> Reviewed-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> 
> Looks good to me too!
> 
>     Reviewed-by: Geliang Tang <geliang@kernel.org>

Thank you for the reviews!

Now in our tree:

New patches for t/upstream:
- 463bdbb2c21d: selftests: mptcp: diag: sort all #include
- Results: 847c469e539c..1f27d14ad280 (export)

Tests are now in progress:

- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/d713fc185b84b7e4f02beff96022692bce694318/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

