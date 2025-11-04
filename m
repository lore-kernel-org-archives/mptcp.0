Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCBA2F0C7B
	for <mptcp@lists.linux.dev>; Tue,  4 Nov 2025 12:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762258249; cv=none; b=omNtjtrTglsrkSKc8DjIkltH/JvCY5y0iLDn2Xb9jCycoOJQk6LMk58XT8Li+xRyglEJdbSrApENtvrcz24F3ABvihA9P2HZovNopP9H8w74Ur/e1lL2nOnoADVSAsFJLeD1413l8ZqbkFU02Bj6bhDKn0pGu5NOEJmKgQLKvH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762258249; c=relaxed/simple;
	bh=uVBgffLvZf2JUbpEcqVOi/DBn3Qry+CQdknqSumwKxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=iSTU2Vbj2w5uvDNe4bKfkuCHGbhdppbspDlwt2GCpIUR+2cuubot32uRH5uZMEUt3asqRBYNLUMBk/61UkAOzGuODN/4JZmCktof441RZwBfcb8GXaf5BSJCcpiM+mtO02zPiQjyRjp9fTXi94x6DE2ZDc2a1eGoqxoZ94CpkCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9OEKbBF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9OEKbBF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95238C19422;
	Tue,  4 Nov 2025 12:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762258249;
	bh=uVBgffLvZf2JUbpEcqVOi/DBn3Qry+CQdknqSumwKxc=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=L9OEKbBFz9cD+N7uZENwCQjnw8NXjDUQ/PL9SsgXUimyBg7KzXckkQSrt3k6y1IIr
	 CMAQXCJORpGqFoy9WNeNJW2GActx7+kz0+rjtIjlGIkKaMEirsf07FL9Sd/gzdMsTK
	 XDmU8UNBdfx4kqvYZCW4oCY4QTFtc9KT1YKNccZSdaahvU0LriDYW/hmnmFiOUj/24
	 b9S+Xqjbm8yApFFsHglifN6Jka3OKF5aRRghGBulyLHYCy3wUaF6bUPYqTgnEchnBt
	 OTWpcfv9B6Vo/7jEZaYayEiUYKXOsI2V9Lq8BH01p0AerswbADgjBEav2bFJZNAgf7
	 HBzd8x8fCoUdw==
Message-ID: <b8762565-35cb-482a-8988-e15fbbb01093@kernel.org>
Date: Tue, 4 Nov 2025 13:10:46 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v2 0/6] selftests: mptcp: join: fix flaky tests
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>
References: <20251102-slft-join-inst-v2-0-b4f3ba15a7c4@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Linux <mptcp@lists.linux.dev>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20251102-slft-join-inst-v2-0-b4f3ba15a7c4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 02/11/2025 12:30, Matthieu Baerts (NGI0) wrote:
> When looking at the recent CI results on NIPA and MPTCP CIs, a few MPTCP
> Join tests are marked as unstable. Here are some fixes for that.
> 
> - Patch 1: a small fix for mptcp_connect.sh, printing a note as
>   initially intended. For >=v5.13.
> 
> - Patch 2: avoid unexpected reset when closing subflows. For >= 5.13.
> 
> - Patches 3-4: longer transfer when not waiting for the end. For >=5.18.
> 
> - Patch 5: drop noisy plain RST packets when looking for MP_FASTCLOSE.
>   For >= 5.18.
> 
> - Patch 6: read all received data when expecting a reset. For >= v6.1.
> 
> When reviewing patches 2-6, please double check that I'm not hiding real
> issues by tweaking the tests suite.

(More eyes are welcome, especially on patch 5/6!)

Thank you for the review! Now in our tree:

New patches for t/upstream-net and t/upstream:
- a9a49f5a022a: selftests: mptcp: connect: fix fallback note due to OoO
- 818251a0fc51: selftests: mptcp: join: rm: set backup flag
- f0864a03b80b: selftests: mptcp: join: endpoints: longer transfer
- a68bf9260dab: selftests: mptcp: join: userspace: longer transfer
- 69569761c0f6: selftests: mptcp: join: fastclose: drop plain RST
- e99b7db5862e: selftests: mptcp: connect: trunc: read all recv data
- Results: 3cf18f92ab22..09c25f9f5ca3 (export-net)
- Results: b35f4b01c8d3..625ded86ead5 (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/c8f9b6716c62042010e0e231a789467236c55625/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/31b5d615cdeb4fd6ea58fcd577b48543dd3b0617/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

