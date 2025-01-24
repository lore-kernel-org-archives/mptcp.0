Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6096823A0
	for <mptcp@lists.linux.dev>; Fri, 24 Jan 2025 09:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737712026; cv=none; b=fFa96xVCvTHkvizcv2OlLcrFurkdiKPw/Q/Ssp7UKCmj8LJV4kS/8eAnPXjNUu8dIZGyRyC77oW6rclBUQyUqovu61SxKypCLwW20ukwX3nWwrZOHRPRS4oLqX5Ua2/b+y4AUYdVnGgc+xVrpKDXQqPi9AWlsKTAkT2RgpLzXRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737712026; c=relaxed/simple;
	bh=6yg2ZXbMSK3/I5yQyvi18WfuK6dI/HR/0jmw70RyTkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RKRKtFrmGj9xje22a/0g5QIbAfzBSYTWn3YJs3hhaRhbD6pwaAYYKj+W7KmJIMecNkBTOzzdjoMjufKrPPIcZeMm93aenLrl7SChuRB3ti9vUDEMD4WH2H04qYt1y/cd/C4fOQ/C88ZnBOt9cNGqf5/0WKVwsPWRtqP6NRpmQCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rLyfqkx2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rLyfqkx2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C2ECC4CED2;
	Fri, 24 Jan 2025 09:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737712025;
	bh=6yg2ZXbMSK3/I5yQyvi18WfuK6dI/HR/0jmw70RyTkw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rLyfqkx2gjY6sRgr0yXYoxCVMgCe4ZVhKSs0cey9EWr7ddJ+QpyvfNkIbWF5/DFUk
	 tQixxdtHh+OxQzk1s3jUI9JkbFEUwKzhqKOL9GdV5DGtO10EFPMAYuoLG4Xthgv6PK
	 vbAcnkMb54FHOVMwdyu3wc1rQ8UBiyw7jZaXJbe7+w35Yn+AIcfxPGHpJq1ur8z1gP
	 SsB6thI1BNr5W4URSi/E/8z5+QRYnVkX/duyjGWJQmxHCVac2kcn60mYiyg4Q6YdZF
	 imwWb/7fYNZtHq4xq7uS012070Pb4to6Xu6aj+XoIwcL1a8dmiX+Qsrn8eXOsAKNpz
	 QHlfkD61iwIIw==
Message-ID: <71c42edc-c826-4e65-8b40-652739fdbc5f@kernel.org>
Date: Fri, 24 Jan 2025 10:47:03 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v2 0/2] mptcp: blackhole: sysctl SYN retrans +
 fix conditions
Content-Language: en-GB
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
References: <20250122-mpc-no-blackhole-v2-0-13e6670d512f@kernel.org>
 <190862d3-a876-fc82-9ca3-6bdfbe462c3c@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <190862d3-a876-fc82-9ca3-6bdfbe462c3c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 24/01/2025 02:42, Mat Martineau wrote:
> On Wed, 22 Jan 2025, Matthieu Baerts (NGI0) wrote:
> 
>> Recently, I found a network having weird behaviours with MPTCP packets:
>>
>> - The first connection to a server had a successful 3WHS, then MPTCP
>>  options got stripped off.
>>
>> - The next one had the first SYN (with or without MPTCP) and 5
>>  retransmissions dropped, before being apparently intercepted and
>>  proxied to the end server.
>>
>> - (The next ones were sometimes intercepted, sometimes not, or dropped
>>   at the beginning. I'm trying to find out which kind of "optimiser" is
>>   causing this.)
>>
>> The result of this was a blackhole being "wrongly" detected, and no ways
>> to force connections with quite a few SYN drops to finally use MPTCP at
>> the end.
>>
>> In this series, we have:
>>
>> - A small fix for the doc. (applied)
>>
>> - A new sysctl to change the number of SYN retransmitted with MPTCP
>>  options before falling back to TCP. The modification looks simple
>>  enough to still be sent to netdev before the closure I think. (applied)
>>
>> - A fix to only turn on the blackhole protection only when the first SYN
>>  retransmitted without MPTCP option is accepted, instead of any after.
>>  The blackhole feature was supposed to do that from the beginning, but
>>  a check was wrongly placed. I think we should consider this as a fix,
>>  even if there are also risks of not detecting a blackhole if the first
>>  SYN retransmitted without MPTCP is dropped by accident. But that seems
>>  more unlikely for an "MPTCP firewall blackhole", and I guess not all
>>  future MPTCP connections will behave exactly like that. It sounds then
>>  safer to reduce the possibilities of enabling the blackhole protection
>>  by accident, and apply this patch.
>>
>> - A small cleanup to exit early.
>>
>> Please note that patches 1 and 2 have already been applied in our tree.
>> So this version only has patches 3 and 4. Patch 3 is a fix, maybe not
>> patch 4, but it might be easier to squash patch 3 and 4 and send it as a
>> fix to -net.
>>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> Changes in v2:
>> - Previous patches 1 & 2 have been applied.
>> - Patch 1 (ex 3) has not been modified.
>> - Patch 2 has been added, it can be squashed to the previous one.
>> - Link to v1: https://lore.kernel.org/r/20250114-mpc-no-blackhole-
>> v1-0-994bd2a357fb@kernel.org
>>
> 
> Hi Matthieu -
> 
> Both patches in this series look good to me:
> 
> Reviewed-by: Mat Martineau <martineau@kernel.org>

Thank you for the review!

> I'd suggest either queuing patch 2 for -next, or dropping it. The
> optimizer probably makes it a no-op in terms of performance anyway, and
> now looking at the size of the patch (even though it's mostly due to re-
> indenting and moving a couple hunks of code around) it does seem like a
> moderate amount of churn.

I just applied the two patches. Even if the optimizer might do a good
job, the new 'likely()' and the probably more logical way the conditions
are checked might help at least for the code readability (and not to
have to rely on the optimizer).

New patches for t/upstream-net and t/upstream:
- fa00cb6c4848: mptcp: blackhole only if 1st SYN retrans w/o MPC is accepted
- Results: 5be385713aa4..f6c96ef8878b (export-net)
- Results: 3b679399ffaf..f912778a1fd3 (export)

New patches for t/upstream:
- bf133309e373: mptcp: blackhole: avoid checking the state twice
- Results: f912778a1fd3..e80a31769cf4 (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/99817b2f2308bb041aab3ef0137999e203dacc0a/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/d591e451861a0d3ae05f9a9501ba687cf786f183/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

