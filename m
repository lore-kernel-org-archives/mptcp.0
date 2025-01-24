Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4571D5174
	for <mptcp@lists.linux.dev>; Fri, 24 Jan 2025 01:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737682946; cv=none; b=WHs33be9H9R14MmXAcCvuYQBHi2Mx2gQJB8JZOwWBO8VANFtkvpu0p5gWPRjZ53n+xQO5Pdip/6cXQPqiIOzVnsQWPJPkndcYFvDAWCaw+e9suZKXVR662OsDnrwtLTrhu2I3G51kFOUhoqQreEaTPaE3SHQmgWUbB3wF9XfFF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737682946; c=relaxed/simple;
	bh=FO8L3Yr/xLAcV3Mwy4nX9zY18dPAyIdhlmghfnVz12g=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=j7drvm3rjMCVd3J61et3qKWe/Fm4PK5Z2p66KsKIWFWAQ5tGtFIpB/WyCEMyzmq0bkIKoqrR/OymNByL5nI5yXkBaZi+NKanEMYODQOZbTS0QWauMFzsqEu180Aob/45N2mKoJNwFUp+NLotNRilmVV6NRl0IUwwgsex3ZzoMNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHHjMR0D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHHjMR0D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7DE6C4CEDF;
	Fri, 24 Jan 2025 01:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737682945;
	bh=FO8L3Yr/xLAcV3Mwy4nX9zY18dPAyIdhlmghfnVz12g=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=ZHHjMR0DhZp95AFo815dDi+M9d8moYZaHYqS1p0tbxvHfNFEf1PDNemm1Un0CmJ0G
	 jSJIKu/OYCsW4vT3mmnUoSLk1iHchjn6G3CfMZD/nn8r87JGVNA7CzE7wuuMll/+jW
	 zgaQKw6ORRXQdOwjNPuuzMZ4QtN5FTSoqaeJSAhiDmFMEKIAgCPc6Iibj5tU9/Pet/
	 GPifi2KxRsWgM0aGKpBvRTfaE43k8wRaatyJG2hYd4Y7tGCELH74YEplE9DebCBW24
	 2zCiJRwOA9swukWP8EiAQChtAuyOAokSHeZnG0KzGSmv1eF0cDEXpCe0Vxdj9YYvWz
	 XlVhqFLC3rOiw==
Date: Thu, 23 Jan 2025 17:42:25 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net v2 0/2] mptcp: blackhole: sysctl SYN retrans
 + fix conditions
In-Reply-To: <20250122-mpc-no-blackhole-v2-0-13e6670d512f@kernel.org>
Message-ID: <190862d3-a876-fc82-9ca3-6bdfbe462c3c@kernel.org>
References: <20250122-mpc-no-blackhole-v2-0-13e6670d512f@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 22 Jan 2025, Matthieu Baerts (NGI0) wrote:

> Recently, I found a network having weird behaviours with MPTCP packets:
>
> - The first connection to a server had a successful 3WHS, then MPTCP
>  options got stripped off.
>
> - The next one had the first SYN (with or without MPTCP) and 5
>  retransmissions dropped, before being apparently intercepted and
>  proxied to the end server.
>
> - (The next ones were sometimes intercepted, sometimes not, or dropped
>   at the beginning. I'm trying to find out which kind of "optimiser" is
>   causing this.)
>
> The result of this was a blackhole being "wrongly" detected, and no ways
> to force connections with quite a few SYN drops to finally use MPTCP at
> the end.
>
> In this series, we have:
>
> - A small fix for the doc. (applied)
>
> - A new sysctl to change the number of SYN retransmitted with MPTCP
>  options before falling back to TCP. The modification looks simple
>  enough to still be sent to netdev before the closure I think. (applied)
>
> - A fix to only turn on the blackhole protection only when the first SYN
>  retransmitted without MPTCP option is accepted, instead of any after.
>  The blackhole feature was supposed to do that from the beginning, but
>  a check was wrongly placed. I think we should consider this as a fix,
>  even if there are also risks of not detecting a blackhole if the first
>  SYN retransmitted without MPTCP is dropped by accident. But that seems
>  more unlikely for an "MPTCP firewall blackhole", and I guess not all
>  future MPTCP connections will behave exactly like that. It sounds then
>  safer to reduce the possibilities of enabling the blackhole protection
>  by accident, and apply this patch.
>
> - A small cleanup to exit early.
>
> Please note that patches 1 and 2 have already been applied in our tree.
> So this version only has patches 3 and 4. Patch 3 is a fix, maybe not
> patch 4, but it might be easier to squash patch 3 and 4 and send it as a
> fix to -net.
>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Changes in v2:
> - Previous patches 1 & 2 have been applied.
> - Patch 1 (ex 3) has not been modified.
> - Patch 2 has been added, it can be squashed to the previous one.
> - Link to v1: https://lore.kernel.org/r/20250114-mpc-no-blackhole-v1-0-994bd2a357fb@kernel.org
>

Hi Matthieu -

Both patches in this series look good to me:

Reviewed-by: Mat Martineau <martineau@kernel.org>

I'd suggest either queuing patch 2 for -next, or dropping it. The 
optimizer probably makes it a no-op in terms of performance anyway, and 
now looking at the size of the patch (even though it's mostly due to 
re-indenting and moving a couple hunks of code around) it does seem like a 
moderate amount of churn.

- Mat

> ---
> Matthieu Baerts (NGI0) (2):
>      mptcp: blackhole only if 1st SYN retrans w/o MPC is accepted
>      mptcp: blackhole: avoid checking the state twice
>
> net/mptcp/ctrl.c | 30 +++++++++++++++++-------------
> 1 file changed, 17 insertions(+), 13 deletions(-)
> ---
> base-commit: a9a670c7f9f94ac66e6a79ecb81e4e7a6e20f001
> change-id: 20250114-mpc-no-blackhole-526a61ea0334
>
> Best regards,
> -- 
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
>
>
