Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3410066B37
	for <mptcp@lists.linux.dev>; Tue, 30 Jan 2024 12:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706616859; cv=none; b=lEbKpVZBTDhsPR5t8AOwe5KYxySBisvCtRSeAS/CqwMNKtqtl1ff1Onu5dwBDXAcWViOTeugdsHaF3n8ozcVaq69vQ5PijamBtT9zPoE9evpZR7PKJ1hbJgdN2cndk42smY43n3WpJBV71x/UAhRo7z3Jh2S44DDLY4f7HuksqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706616859; c=relaxed/simple;
	bh=n+EXzIZ+osPCNOX9L0ivb1ArdlPhnoepULaw4aB6n/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TKw+PRzj9ZntI2LzSKBL+4IBXem1qDqbgYpv/JGDJClck7oNOLWNVsV7fKgPu46rlIMM4t/wYJPmeJOL/qE2PsQ7MeIr5TSnHQkzfN09Vcql+RXd1w8zhGHUXAEPNzA7DkRpaKuwsCqakVk8hAuphR09qwXeeStmOa3ehfg9O4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9ibl57A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9ibl57A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AED1C433F1;
	Tue, 30 Jan 2024 12:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706616858;
	bh=n+EXzIZ+osPCNOX9L0ivb1ArdlPhnoepULaw4aB6n/U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X9ibl57AeQc1FuwQTGdjKsVb0ReOx7rTHE3xtiFGaPlNSKpvuYoLOBZoXdnqCzvVy
	 8swh8FAuzJkv+CItXjSkamJ+gVZKhy1eDVgTj23xcjBdcxaV9T+ZBGwFEe594/xLlB
	 rGHlx8n+uYxq5yVbG2ilfs+LAKQ2lVnDkPJh+2NGlgcMufkFgCXeSG2/1rGV5uSPKB
	 ZbVwrKlv3XXPvqhYqV3Bv9QoU/aM8mGjQo7DdLCo0BQQ5ZwZ2Vv7clmnrkraL5E+nq
	 fPXYQtgGJftN4NpFH64l0nBEAF/zU0GE+/C9BVMwB9sE6eq5fsdWkuRHQxR+X8gFpl
	 Hf8PzW0J02yKA==
Message-ID: <a5e69211-1fba-429c-8acd-dcd8053f23c1@kernel.org>
Date: Tue, 30 Jan 2024 13:14:16 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next 0/7] selftests: mptcp: improve results in slow
 CI envs
Content-Language: en-GB, fr-BE
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, Geliang Tang <geliang.tang@linux.dev>
References: <20240118-selftests-mptcp-simult-slack-qemu-no-kvm-v1-0-f3a4db41c3be@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20240118-selftests-mptcp-simult-slack-qemu-no-kvm-v1-0-f3a4db41c3be@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Paolo,

On 18/01/2024 19:27, Matthieu Baerts (NGI0) wrote:
> The initial goal of this series is to improve the results when slow test
> environments, e.g. when using QEmu without KVM.
> 
> I looked at the results from LKFT [1] and noticed that some mptcp_join
> subtests were skipped because it was not possible to add IPTables rules.
> It looks like some KConfig were missing. The 3 first patches should fix
> that.
> 
> I also noticed that mptcp_join selftest stopped after a timeout of 20
> minutes. We keep adding tests there, it is normal to increase this
> timeout at some points, especially because we forced many subtests to
> have a longer connections, to have enough time for some actions to
> happen. Patch 4 fixes that.
> 
> Patch 5 decreases the BW in simult flows, hopefully reducing the load on
> the CPU, and improving the stability.
> 
> Patch 6 is needed because our CI run MPTCP Connect twice: the second
> time with '-m mmap'. When parsing the results, the tests from the two
> runs have the same title, hence the same "fingerprint". Instead of
> having a post-processing step modifying the results for this specific
> case, it is now possible to set a prefix.
> 
> When looking at the results of mptcp_join, I also realised that the
> 'userspace' tests were blocking after having displayed the results.
> That's because they wait for the end of the transfer, while they don't
> need to: tests are the end are ignored because this is done in the
> background (but that's fine, other tests check that). Patch 7 improves
> the situation there.

Thank you for the reviews!

Now in our tree (fix for -net) with the modification demanded by Geliang
on patch 3/7:

New patches for t/upstream-net and t/upstream:
- a773245de129: selftests: mptcp: add missing kconfig for NF Filter
- 616af1a08349: selftests: mptcp: add missing kconfig for NF Filter in v6
- 2d4ccf16a1ac: selftests: mptcp: add missing kconfig for NF Mangle
- ac8595b0b31c: selftests: mptcp: increase timeout to 30 min
- ba7e09d80ffe: selftests: mptcp: decrease BW in simult flows
- e8a61a14a58f: selftests: mptcp: allow changing subtests prefix
- eb5f4f5f0a80: selftests: mptcp: join: stop transfer when check is done
- Results: 6d56aa24e733..b4671e59d316 (export-net)
- Results: cdd4fe00f4c5..81c0f68b0316 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20240130T121223
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20240130T121223

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
