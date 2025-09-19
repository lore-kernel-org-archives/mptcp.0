Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C90244668
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 10:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758279061; cv=none; b=oDK+zx+501H52aCMtz6xph8TdTC63dZNDEGoXhC4Yb7t4aOumMT9Q/yLKQaECvJPZRGVTo8omgA67Y/PFsS0RhZxZXSv7/aG+c7mQULi1pL4xKPcSsDYkFpwkFwSdexFVc1dUZOMSoc+mCTxOQ9qMPAMf3jLWcSlcTOFOflWbac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758279061; c=relaxed/simple;
	bh=UkDKYT/rN6MF3Amo2nQX6udtneTlGF8vmELWNPBMCeY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=t0LJBbz1LthFRPrrfKrSciykzDfKURwtdYVEIVmyi9A1ugUIff+Opr5Sp8Z1aIVrFtPo4Mhc6DNulDE+/ED7k2S6Guw562HJz4+6Jtwl5b09pTxjXx+PiuPLhy8SYgFv4hSoGkLEtdKlhTg0UtifJsljzcV0cgdXV10iVbC27WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfwx1B7/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfwx1B7/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B26C4CEF0;
	Fri, 19 Sep 2025 10:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758279060;
	bh=UkDKYT/rN6MF3Amo2nQX6udtneTlGF8vmELWNPBMCeY=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=nfwx1B7/eXaKttvf7ieKTbSIGqyYHNcEdt5hSsrzSCoK3xWr/6P0bacxyD8rFmtZ3
	 pj4ouq/MaMVRuMEk8bG1D5LV7nZFb1ZYxWyNzcS8YlA1BJHN/tMiQvtRLFI1hVf7F3
	 ehrSwbv3RYXDGI6FohoiYUVDmD95Sptp9cE7Be/HaeMSlKS59gK5srs1iiNy30MCw3
	 fFpN4ArEwHwxMDzci5fYqsKKTQFvZCKZmOMxYrdls/FXG3wuv/H/swiI9+WMOe2T1a
	 XAJ/Y3XZIia5TQaGTduErxbPlBHsHhb9nSG78ssehWKs7sMqaN1icfN8rMRmWjwQF3
	 0vvc0glaXlj/A==
Message-ID: <56ec31af-4468-4445-aa19-01f407100def@kernel.org>
Date: Fri, 19 Sep 2025 12:50:58 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v2 0/2] mptcp: pm: in-kernel: usable client side
 with C-flag
Content-Language: en-GB, fr-BE
From: Matthieu Baerts <matttbe@kernel.org>
To: Geliang Tang <geliang@kernel.org>, MPTCP Upstream <mptcp@lists.linux.dev>
References: <20250916-pm-c-flag-client-default-v2-0-3be2c5bc4d6a@kernel.org>
 <5307c126de5a6029a1bba744bcde32446f2ff2a6.camel@kernel.org>
 <1993725f-b6d6-4ec6-8fa8-3d64368040be@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <1993725f-b6d6-4ec6-8fa8-3d64368040be@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/09/2025 12:47, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 19/09/2025 12:15, Geliang Tang wrote:
>> Hi Matt,
>>
>> On Tue, 2025-09-16 at 13:01 +0200, Matthieu Baerts (NGI0) wrote:
>>> When servers set the C-flag in their MP_CAPABLE to tell clients not
>>> to
>>> create subflows to the initial address and port, clients will likely
>>> not
>>> use their other endpoints. That's because the in-kernel path-manager
>>> uses the 'subflow' endpoints to create subflows only to the initial
>>> address and port.
>>>
>>> The first patch fixes that, and the second one validates it.
>>>
>>> More details:
>>> https://github.com/multipath-tcp/mptcp_net-next/issues/536
>>>
>>> Please see the comment in the first patch, and don't hesitate to
>>> reply :)
>>>
>>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>
>> Thanks for this v2.
>>
>> LGTM!
>>
>> Reviewed-by: Geliang Tang <geliang@kernel.org>
> 
> Thank you for the review!
> 
> Now in our tree. I decided to add them in the section for net-next: we
> are close to the merge window, and linked to the comment from patch 1,
> it is certainly safer to delay the backport to stable a bit.
> 
> New patches for t/upstream:
> - 0b324b1e22a0: mptcp: pm: in-kernel: usable client side with C-flag
> - b366bcbbad02: "squashed" patch 1/10 in "mptcp: pm: in-kernel: usable
> client side with C-flag"
> - c3ca688abf65: selftests: mptcp: join: validate C-flag + def limit
> - Results: fe9c68017366..8a1a30937c29 (export)

I forgot the last bit:

- Results: fe9c68017366..169aef388767 (export)

Tests are now in progress:

- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/df63a09d28d2808cbe27f96a1937ad904035d2d6/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

