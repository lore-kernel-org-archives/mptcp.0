Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DD52BDC33
	for <mptcp@lists.linux.dev>; Mon, 24 Nov 2025 18:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764008975; cv=none; b=utcdJDZQ4NJsgcKoUoyzmWTEiGOvSi8ANP7utZsRVR5VQ8v7Q0eL0MnA+oO23coIF8noayHsuLDkBy1dFHpSXbuCYUiVldsoFynsRG501JrvbULX3O9Pk23cDt1LcQ41aJRv7HxnJyiSYppBnBlFy1IczE4pGvolbk2SUPtM1jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764008975; c=relaxed/simple;
	bh=9Dgz2H8UQtxUWu/fQrz6DtAfFkwiWnrZAVyAFQPzucQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=oh2Ojeg8g0FbDdgNDYxel+RHdlguBxzt8PI6GzjFEUeRojsnFprK4F2CmQl4Mzvk8bUXAj/f64zKMutMMwzzOnVDwt/lLsOfSGHOFoxwDLE2tM0T2Cbbd07qAHpVt22kUXiDp//OHocUxt1TU904DTEgSR1xAcxmJqJeJfALeSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCC6EvgM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCC6EvgM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A22B4C4CEF1;
	Mon, 24 Nov 2025 18:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764008975;
	bh=9Dgz2H8UQtxUWu/fQrz6DtAfFkwiWnrZAVyAFQPzucQ=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=MCC6EvgMEx/dRiKtlNfTm10ZOSXx/J0bjS8EgXH9diEfEz+81K+pve5yNf0YbFhMW
	 BLTd41PnetkhtlNZcpPLiXSzwTBdSzK38zFCmr3uEF77kp06fxwy7g6cDMw/H8hmfq
	 id4gHJNcTAu7Z73gO+sRCtabIIaJ77eqWN5YWo0Q+Uua9f0ixn+I45IypaxR0IvNGH
	 Yj6i11o2HUbm5VOhVEeJgZo7/tGEyY3hdeGwcNaXjLb47aqt6czXIOLHZUlXFdnm3C
	 JD3c1BjwxHNJ6qZlR1mO0WcIf1fg7UU8cWjaSB6DgRUo1mhtrOSyJ8Bqe6KefKgl+E
	 Hq6Gww9vATTaA==
Message-ID: <25ce82ee-2080-49c6-8559-11c7ead9d8e5@kernel.org>
Date: Mon, 24 Nov 2025 19:29:32 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net] mptcp: schedule rtx timer only after pushing
 data
Content-Language: en-GB, fr-BE
From: Matthieu Baerts <matttbe@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: dcaratti@redhat.com
References: <9f5e5b6c05fa0e6d303126c6a68a19305d166d36.1763715034.git.pabeni@redhat.com>
 <5eaf4403-e8c5-49cc-ab09-bbe71a0e6182@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <5eaf4403-e8c5-49cc-ab09-bbe71a0e6182@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 24/11/2025 19:24, Matthieu Baerts wrote:
> Hi Paolo,
> 
> On 21/11/2025 09:52, Paolo Abeni wrote:
>> The MPTCP protocol usually schedule the retransmission timer only
>> when there is some chances for such retransmissions to happen.
>>
>> With a notable exception: __mptcp_push_pending() currently schedule
>> such timer unconditionally, potentially leading to unnecessary rtx
>> timer expiration.
>>
>> The issue is present since the blamed commit below but become easily
>> reproducible after commit 27b0e701d387 ("mptcp: drop bogus optimization in
>> __mptcp_check_push()")
> 
> Thank you for the fix!
> 
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> Note that the blamed commit states we always need to rearm the timer even
>> with no data pending, to catch link failures. That sounds weird/possibly
>> tied to broken zero window probes?!? Hopefully mp_join self test should
>> catch that
> 
> Thank you for the note! I suggest waiting one more week before sending it.

Applied!

New patches for t/upstream-net and t/upstream:
- 246fb174f79b: mptcp: schedule rtx timer only after pushing data
- Results: c85e07c93b0a..bbb6d3ccd581 (export-net)
- Results: d68a54341cb3..23a6a5017274 (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/5cfb92e8243a99a2edc03b68e8ef3568672b7546/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/25182e7cd25a7e550ad2d9f7ecbb7e24cecd7f7f/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

