Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870E91F95A
	for <mptcp@lists.linux.dev>; Fri, 17 Jan 2025 14:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737124116; cv=none; b=AI1qqD9aeyg/L/Xf0MYJuVGcixtpYziF2X4zjTcEPaBBE86RCySNmcHfggubrTDeBw9IpvvPRgxOlfcF+cy35pFmSOYUrNheqttQZpxYrvJNCTNrG8zFAXgTXZuJc7whkM81ttFpZ+rus252yBqJY2q3Of3WHqNdjh2XlgUdJRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737124116; c=relaxed/simple;
	bh=VuRy55BQ2rsBDV5Q/i4coammfe/tD6ojISGY4vjPNvQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=agSJsjD/rjHDgjhS8m3ZXKS18PSzrT//pIECt2xRsueoph6B7a30mmYPxNrUByZMXIGxai7LCPysgy0tYCBAhsKbJ1MrZdX48HrBrho+g5GuJyu7oJssaVHqEOJo30FuAsSgaXVHm6xq5VJErf3pFE+2yCW4mjiHY46rU4hLUz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imuwL+eJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imuwL+eJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643F4C4CEDD;
	Fri, 17 Jan 2025 14:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737124116;
	bh=VuRy55BQ2rsBDV5Q/i4coammfe/tD6ojISGY4vjPNvQ=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=imuwL+eJQKbr/19YsK7LXVlrj3B3Odfuq5jahERo3mvQj+fkpEt/RhT0G6BH/ybmw
	 dP8TuJ8+pa5mK8b4YTWGKTMQkxfKV49UiT+9fmGU1iOqEMTB8hMdFwsMP0xRK9yRLl
	 MZrnge97AgtDN10HitAY/Vp40vzV60368bZS/m7vS4x7vEG0T5XXMe6oNq0FdUwVNV
	 5qCMMbLLXxmjdW19HwswJ3GGT3dsuIwSSvQ2TfG1eqFV6pOzTxbyLYCUc9JeI4E1jY
	 FRdxJTgWN7/1RDx4heUIDeL65jV5iQ3meKopJvt3K7HjLXhxVFmRJiRxlmos+Wk5EI
	 MW3ii4BRap3bQ==
Message-ID: <efebc4b2-b9ef-451e-afc2-68b21dd40d62@kernel.org>
Date: Fri, 17 Jan 2025 15:28:24 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net] mptcp: consolidate suboption status.
Content-Language: en-GB
From: Matthieu Baerts <matttbe@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <7c8a258328ed6d235a100e3fa13c2da355119951.1736974476.git.pabeni@redhat.com>
 <c0576dc7-79f5-46c7-a59d-f70c6acf355f@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <c0576dc7-79f5-46c7-a59d-f70c6acf355f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 16/01/2025 21:25, Matthieu Baerts wrote:
> Hi Paolo,
> 
> On 15/01/2025 22:12, Paolo Abeni wrote:
>> MPTCP maintains the received sub-options status is the bitmask carrying
>> the received suboptions and in several bitfields carrying per suboption
>> additional info.
>>
>> Zeroing the bitmask before parsing is not enough to ensure a consistent
>> status, and the MPTCP code has to additionally clear some bitfiled
>> depending on the actually parsed suboption.
>>
>> The above schema is fragile, and syzbot menaged to trigger a path where
>> a relevant bitfield is not cleared/initialized:
> 
> (...)
> 
>> The current schema is too fragile; address the issue grouping all the
>> state-related data together and clearing the whole group instead of
>> just the bitmask. This also cleans-up the code a bit, as there is no
>> need anymore to individually clear "random" bitfield in a couple of
>> places.
> 
> Good catch, and now cleaner!
> 
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Now in our tree (fixes for -net) (without 2 spelling mistakes spotted by
checkpatch.pl --codespell):

New patches for t/upstream-net and t/upstream:
- 818bca988793: mptcp: consolidate suboption status
- Results: 05dbdeb0df9f..1b76b0bd2522 (export-net)
- Results: 23e469da2e50..2a6dfa001e66 (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/6522a18009fb2dd2de6badbd6f3a75094ef56c5e/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/8e6fd4818b81ecebcca1a3eb44a2927845471434/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

