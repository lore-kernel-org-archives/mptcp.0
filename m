Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFD436C9C2;
	Wed, 12 Aug 2026 01:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786498887; cv=none; b=g66QY8hT53Ism47IDtPc2Co+CYf+SWYx5g303rgqWyDgPwQ3GZaj2e7q/DsBJ/c3qpU3QVMGdptSs31Jq7P4IjxREO6PZQGHFxlMS4YRiQ7j6P421h7R+D7HFRMyGAlD+7tFCFTCgNgr5Vc6upDqdwboCYKsciOTNFG0T9cUOpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786498887; c=relaxed/simple;
	bh=dZeE+jyBKiUzaxYFgm2s0HuLbu6gB9T8dW3v0Z6rzbA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hMWAUu8q307rx71Wbo0Yj6ApQ9t2qyxHeQypVu7/0mtsRUJNQcHMMieZmUW8WEJ5ZpwP79vvWylpF+9rxeGdblp4ZFYJ2+bdTmyazA0axHfcAQwc3pv4CeY4EwX7zDB2jYD/7PCp7QqTqs1MTZCkTZ6KlP09pF7mSydS4MbSqHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9b3T+oZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9b3T+oZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 141A01F000E9;
	Wed, 12 Aug 2026 01:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786498886;
	bh=DMNa9VbXFgT+88cJzFRA4WPgYfBh4UlIJlaRgPKrJ5Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=N9b3T+oZPqSBCzRSJY7B+7WutMc2TKHsk9fhmBlJ1YZHtffUqcoqxAtSxKdbU1jy7
	 d5v9sdgD0ayy9AaHiQ9HE9sFzvGEw0lD6L3lckCuLYw34hdkzxLQeHjr1WbhobB1fa
	 2W9kCh0iotUuRFIt1fyRhhQ9+tR+N96dJzhuBgJ0tLDLd4b9hZpZYNyxerHHBNOBb4
	 Ffg691PAtU9Zz1E05tqPiNWOdl44zWIKfkRPLHR2e9OHrxnB25Snb5kT36Swd1dVC+
	 R1YcVQJGbj3Ob6xq/G4KpUkDmNYMWPSq7w+N2Rj6jTmEmC+E71ZdbnYKp5WdJRV/9r
	 ZMp85ENN1VMGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A053809A3C;
	Wed, 12 Aug 2026 01:40:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/7] mptcp: out-of-order queue pruning
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178649884163.1230679.9378736754022898187.git-patchwork-notify@kernel.org>
Date: Wed, 12 Aug 2026 01:40:41 +0000
References: 
 <20260807-net-next-mptcp-oooq-pruning-v3-0-dbc1eb853cc3@kernel.org>
In-Reply-To: 
 <20260807-net-next-mptcp-oooq-pruning-v3-0-dbc1eb853cc3@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 yangang@kylinos.cn

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 07 Aug 2026 15:49:00 +0200 you wrote:
> Under memory pressure, a pruning of the MPTCP-level OoO queue might be
> required as last resort, to avoid too long recoveries, or even stalls.
> Geliang and Gang managed to reproduce this behaviour, and Paolo
> improved the situation thanks to the following patches:
> 
> - Patches 1-3: improve the MPTCP-level retransmission schema to make
>   recoveries from memory pressure/after MPTCP-level drop significantly
>   faster.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/7] mptcp: move the retrans loop to a separate helper
    https://git.kernel.org/netdev/net-next/c/789e6a844b51
  - [net-next,v3,2/7] mptcp: move the stale logic out of retrans scheduler
    https://git.kernel.org/netdev/net-next/c/6cafe51e0f98
  - [net-next,v3,3/7] mptcp: let the retrans scheduler do its job
    https://git.kernel.org/netdev/net-next/c/96d846e3e2a7
  - [net-next,v3,4/7] mptcp: explicitly drop over memory limits
    https://git.kernel.org/netdev/net-next/c/e0e4d56b0505
  - [net-next,v3,5/7] mptcp: enforce hard limit on backlog flushing
    https://git.kernel.org/netdev/net-next/c/b1224c4b40f6
  - [net-next,v3,6/7] mptcp: avoid code duplication in __mptcp_move_skb()
    https://git.kernel.org/netdev/net-next/c/996643574cc8
  - [net-next,v3,7/7] mptcp: implemented OoO queue pruning
    https://git.kernel.org/netdev/net-next/c/e468d371180d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


