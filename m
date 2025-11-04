Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297B8239E60
	for <mptcp@lists.linux.dev>; Tue,  4 Nov 2025 06:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762239445; cv=none; b=Ooi6cxBucc1s1TQly1//6vu1Xx2p/Ie9xO//wl8Hg7/muLpGsswOrHc9ccNTVeaRzy/02HsWVLhQoqx8VidXJ820ZAcBUTCoaCSjop1NvNVsb0+aWsu5E8JgB/AHXA0wXccdL2NHpLfsAai1Niumphcy6A93FLkZ3Svsl00osgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762239445; c=relaxed/simple;
	bh=zEtK+zM2nNstT+Wc+wvmBOpBupD0nqT7rS1zWOoCN78=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=XB2RqDO2b1xBL3A5ihAEW4zzzvauYJPPrBBUixGzEu6qGA14T+w5ebB0MkzaGUm9ucloGupVZUHQkTQ0LL5B7uQaX1W325cmc0630HkE62J7PjHZXYHqsI6PAcrAkiIIF/s2Nxt/VeoWi++owsr0UrU+E9yN7tnXeCWzzuN/YrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6P98MVQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6P98MVQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A6FEC4CEF7;
	Tue,  4 Nov 2025 06:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762239444;
	bh=zEtK+zM2nNstT+Wc+wvmBOpBupD0nqT7rS1zWOoCN78=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=c6P98MVQ1Pj3p/yuDHF6mUnG4w/lMw1gJymKIGOy70Pg06vkmGQukMD+o8k20xruV
	 zcgQbVwn0EeCAHonznKOnqwigbMGxQSSj/ZVcZ52Vja0qOb1EgRVaURfXexAmZVnRC
	 8m9o7xL6ch5Rm+JQw/GYnqtG3IpqMuW8GHuvVpRnl5HwLbwD8NQc2resIzCSmEvleB
	 Z7g1f33bJeUVbV/RsDkMbZh6sIqTkg1xoI+C2icgoDMD2wqdr3jbvAuP7lCJhh8bI6
	 OaZf+h4irPWZPmvaGkZbDZ9M4D0/VNW9vaqrVUibYzzwIzX8v8jv0Zol4St9kdbac1
	 X5YbFERVbVJ+A==
Date: Tue, 4 Nov 2025 07:57:20 +0100 (GMT+01:00)
From: Matthieu Baerts <matttbe@kernel.org>
To: Geliang Tang <geliang@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
Message-ID: <21daa38d-d335-4d62-b247-472629ee54dc@kernel.org>
In-Reply-To: <1d91f6b378b430088d81c2a5a1d33c678fc81cac.camel@kernel.org>
References: <20251102-slft-join-inst-v2-0-b4f3ba15a7c4@kernel.org> <20251102-slft-join-inst-v2-2-b4f3ba15a7c4@kernel.org> <1d91f6b378b430088d81c2a5a1d33c678fc81cac.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v2 2/6] selftests: mptcp: join: rm: set backup
 flag
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <21daa38d-d335-4d62-b247-472629ee54dc@kernel.org>

Hi Geliang,

Thank you for the review.

4 Nov 2025 07:06:34 Geliang Tang <geliang@kernel.org>:

> Hi Matt,
>
> Thanks for this fix. It works indeed.
>
> On Sun, 2025-11-02 at 12:30 +0100, Matthieu Baerts (NGI0) wrote:
>> Some of these 'remove' tests rarely fail because a subflow has been
>
> In my testing, only the "flush addresses" test case fails
> intermittently. I'm wondering which other test cases have failed in
> your environment?

I took the unstable ones from the Netdev and MPTCP CIs:

https://netdev.bots.linux.dev/contest.html?pass=0&executor=vmksft-mptcp-dbg&ld-cases=1

https://ci-results.mptcp.dev/flakes.html

> I'm thinking we shouldn't add the "backup" flag to every test in
> remove_tests, but only to the specific ones that are actually failing.
>
> Similarly for patches 3 and 4, we don't need to add "test_linkfail=128"
> to every test. We should only apply it to the specific ones that are
> actually failing.

If my analysis is correct, it means the simple fixes I did (backup and
longer file size) can be applied to multiple tests. Then probably better
to avoid these other tests to fail for the same reasons even if it is very
rare, and very hard to reproduce, no? Each false positive takes a lot of
resources (mainly time) to debug.

Cheers,
Matt
