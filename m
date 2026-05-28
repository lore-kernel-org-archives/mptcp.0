Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AC42C11F1;
	Thu, 28 May 2026 23:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780012212; cv=none; b=IGvTlUNJM8QiRM5PabGduz9W5cTFnU1GU9WYziBdFPidBWj0lw1vOFYieS1B4AgjTqsD/AzIbaYBY4NbcAp3j2s8ZjB8O9MC0MERRZY/1/0uYnQA2Q2tALMXt0c1PbDdpvII2IOBmwP6cPdCwflmeRS5ITXoJdz1jxkJigzqSQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780012212; c=relaxed/simple;
	bh=3FV31BSp+eZqefLczGdAKfSOo39mSALwfTNRoZu5iVk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Kz0y2YMbuYf7E6pAKl5Mrga5FjzFYYEv099iH2mYIqtDg6voXmGAJbyqFwQ5h1VrmHjJ06ZXOuQznPv2rtxIJFBKcn3s1xGJlxqHFU96DF/r3PgC79w0RrNwgL7jkEYMLOeIvyMFlinfnChAXxMzd9kSbkhX5TGmmrVocxJ0Hhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCZDp3/T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCZDp3/T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0541F000E9;
	Thu, 28 May 2026 23:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780012211;
	bh=sY1IZ5Apy/pfqZgdmnIxpk47YIf5ZV18RMEp+0ZQZYc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BCZDp3/TphHAvs8dLhWXG+AO85OFHAXgX0ezSuOgwD/hzlzCKNM1Mz6EYR5o4DTA4
	 hhvXdo5HTEJ8+LWO0USULD0yToQzM+oSrtKiExKDzFANsSzj6geH2SPlYRUJk9jZ+B
	 IiMgd1EiGX2n9FJfH6Ovg2be+A/JXCwhWrBi1JVaSVAbaVeww2f5h3kBS/EEVhBmHo
	 h9IOeAhjmHM9Avr3J8Hmhp7NMY8Uc+9h7Cc67Lv9MZCtWYkjU9i1K/D4HyrsT/8aA1
	 XAcf1jmrp6I3uOvGU5bLHhyCZUAFEGEOXEuNpGlHqpcqjQnr2bDHAF5PqcdLJmIqGf
	 CD0ck79EObpvQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93E733811979;
	Thu, 28 May 2026 23:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] selftests: mptcp: reduce bufferbloat and cleanup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178001221513.1560944.5184668372188033491.git-patchwork-notify@kernel.org>
Date: Thu, 28 May 2026 23:50:15 +0000
References: 
 <20260527-net-mptcp-sft-bufferbloat-exit-v1-0-9afc4e742090@kernel.org>
In-Reply-To: 
 <20260527-net-mptcp-sft-bufferbloat-exit-v1-0-9afc4e742090@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 shuah@kernel.org, fw@strlen.de, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 27 May 2026 22:11:33 +1000 you wrote:
> Bufferbloat is baaaad, even in our selftests: let's kill it (or at least
> reduce it). By doing that, the tests (seem to) have a more stable
> transfer, and are then less unstable. That's what patches 1-2 are doing,
> and they can be backported up to 5.10.
> 
> Patch 3 is not related: a small fix in the selftests to remove temp
> files that were not deleted in some conditions, since v5.13.
> 
> [...]

Here is the summary with links:
  - [net,1/3] selftests: mptcp: simult_flows: disable GSO
    https://git.kernel.org/netdev/net-next/c/0f1fd73c2204
  - [net,2/3] selftests: mptcp: simult_flows: adapt limits
    https://git.kernel.org/netdev/net-next/c/b7c746a8eeea
  - [net,3/3] selftests: mptcp: sockopt: set EXIT trap earlier
    https://git.kernel.org/netdev/net-next/c/c8da80af2838

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


