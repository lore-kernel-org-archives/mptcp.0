Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A4C2AD0D
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 10:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758279309; cv=none; b=s0watHfwMOhIvRVLOSeAKBpVLJwEWpGQ9HjJk5pZNHxzlKoG/s0k6qro1PDZBqRSz+AfSaJ10YC3tNN0H4VpoRvpBIHrmgOtx8DsFbSygvScU94hwlffFF02xRT+6OtjUr8K8JWbzKdXnbLUEe3cXOrpDmhbK55dV4oqnoTzAhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758279309; c=relaxed/simple;
	bh=M2N2PL9QqM43HPGtvwl1dXrob8w6j79oOI1Mql5Y1DA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lfV/yJ8kpzQsnkZc6/ZmkzLpOoF8cMFCoRAfnhnjrbnKyT9RjWPqr1uBsAXLgI1pUZUzlsWGe9OLk0MBD4JbdPp0T8Kt9m1FN1fc9r0PMxKvhKBfOZpTmmCfthhiFQ87rH9TDQgovomX7Zb+vs6k2ys8KngaybBqSC2IEK/iDqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ku/oV7xq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ku/oV7xq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7262BC4CEF0;
	Fri, 19 Sep 2025 10:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758279309;
	bh=M2N2PL9QqM43HPGtvwl1dXrob8w6j79oOI1Mql5Y1DA=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Ku/oV7xq15BZnsAWnICpBR4sAoG1nZkcU22NGnO/gIBYHryFmxC+nWnh0QFTaW3fd
	 fwgXPKm+/52UUUTrms3FqMbSZy0aofdf2HmbGvx1AhvXuaydb13plTklv39NigwfQY
	 3m8VnFjnSiIT5qeI3ZiZhjjkH3UUQWz98ipun3Q36QeTpRKONQ++AKvZDLS81Xf2uN
	 bKKnTA+o4vcjdS6aYMR+7uXjThwVKzEY74qwVdHFA+w4wd98ndosgT4hK/Wio2zdWC
	 opLb1mxdC/TZm1NnksjndRwmYAUzZtdS0V2Ahum5ZZvuDXoiilpBf73pbXK9XIg/KI
	 IP2/fS9eAgRaQ==
Message-ID: <a860e33b-bf29-4f65-991d-2e203e3da3d6@kernel.org>
Date: Fri, 19 Sep 2025 12:55:06 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2 00/10] mptcp: pm: a few cleanups
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, MPTCP Upstream <mptcp@lists.linux.dev>
References: <20250919-pm-kern-endp-add_addr-v2-0-1f8f04f01914@kernel.org>
 <0e2481ae141ae8a13ae3d2c34f94e37e8e6fd1a7.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <0e2481ae141ae8a13ae3d2c34f94e37e8e6fd1a7.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 19/09/2025 12:20, Geliang Tang wrote:
> Hi Matt,
> 
> Thanks for this v2.
> 
> On Fri, 2025-09-19 at 11:08 +0200, Matthieu Baerts (NGI0) wrote:
>> I'm currently looking at adding ADD-ADDR endpoint type, see [1].
>>
>> When working on this, I decided to do something we should have done
>> from
>> a long time: renaming some variables with confusing names, and split
>> some functions.
>>
>> Flushing this now, just to ease the reviews: this should be pure
>> refactoring, no functional changes intended in all these commits.
>>
>> Based-on:
>> <20250916-pm-c-flag-client-default-v2-0-3be2c5bc4d6a@kernel.org>
>> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/503
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> Apart from a small comment in patch 1, the whole patch set looks good
> to me.
> 
> Reviewed-by: Geliang Tang <geliang@kernel.org>

Thank you for the review!

Now in our tree:

New patches for t/upstream:
- 740dfcb5f7a5: mptcp: pm: in-kernel: refactor fill_local_addresses_vec
- 84e1cff472a8: mptcp: pm: in-kernel: refactor fill_remote_addresses_vec
- 03ab82dc7dee: mptcp: pm: rename 'subflows' to 'extra_subflows'
- b28ca23293e0: mptcp: pm: in-kernel: rename 'subflows_max' to
'limit_extra_subflows'
- 6e7aa1ce549c: mptcp: pm: in-kernel: rename 'add_addr_signal_max' to
'endp_signal_max'
- 6cf4bdae1069: mptcp: pm: in-kernel: rename 'add_addr_accept_max' to
'limit_add_addr_accepted'
- ff082e4b5a79: mptcp: pm: in-kernel: rename 'local_addr_max' to
'endp_subflow_max'
- 105e63c8190b: mptcp: pm: in-kernel: rename 'local_addr_list' to
'endp_list'
- 3390557d8f17: mptcp: pm: in-kernel: rename 'addrs' to 'endpoints'
- Results: 169aef388767..77807b94c731 (export)

Tests are now in progress:

- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/a82d2c941090fff63470cf56d935589c1dc63ecf/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

