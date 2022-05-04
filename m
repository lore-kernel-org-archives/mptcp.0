Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEF43D69
	for <mptcp@lists.linux.dev>; Wed,  4 May 2022 00:00:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7CDB4C385AF;
	Wed,  4 May 2022 00:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1651622414;
	bh=AEPZGaKxlkDjER1E+b1adKn4LnX6iBH/AUN4vvDVWo4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FotHpcZjNzskR/dvOroP/r5MhKNIvU/tr7UvMpdHNhCiWZX/mH3QZAlOGJ7iaH9j1
	 bvIVebYV3FUG+mmY9sGc5j7Fa0x837HboM8Ag0AdC6P8XMlnozuDGnt37K68ZSS7oJ
	 aSeZFYSEXiB5zY6oYJSaHIYbdS69HkxS5P11MuY0nbs+Nb7ds4FCZK98KOSm7tFzJx
	 U6gIvCFmqVz7bPE3h/q+mEo3bjxCB+nBUbevLXq2TodrURqFgHfV6AfXVwLz+3YQiW
	 2mKD3FwzN21aaIumdGrVM1OCJBlcM6qAtdcGjinSL9Loez6/bWe+ZJwom+23SjnnSR
	 LNqfLUU+qfAZg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 67658F03847;
	Wed,  4 May 2022 00:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/7] mptcp: Userspace path manager prerequisites
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <165162241442.8175.16119737634939318468.git-patchwork-notify@kernel.org>
Date: Wed, 04 May 2022 00:00:14 +0000
References: <20220502205237.129297-1-mathew.j.martineau@linux.intel.com>
In-Reply-To: <20220502205237.129297-1-mathew.j.martineau@linux.intel.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, matthieu.baerts@tessares.net, mptcp@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  2 May 2022 13:52:30 -0700 you wrote:
> This series builds upon the path manager mode selection changes merged
> in 4994d4fa99ba ("Merge branch 'mptcp-path-manager-mode-selection'") to
> further modify the path manager code in preparation for adding the new
> netlink commands to announce/remove advertised addresses and
> create/destroy subflows of an MPTCP connection. The third and final
> patch series for the userspace path manager will implement those
> commands as discussed in
> https://lore.kernel.org/netdev/23ff3b49-2563-1874-fa35-3af55d3088e7@linux.intel.com/#r
> 
> [...]

Here is the summary with links:
  - [net-next,1/7] mptcp: bypass in-kernel PM restrictions for non-kernel PMs
    https://git.kernel.org/netdev/net-next/c/4d25247d3ae4
  - [net-next,2/7] selftests: mptcp: ADD_ADDR echo test with missing userspace daemon
    https://git.kernel.org/netdev/net-next/c/b3b71bf91521
  - [net-next,3/7] mptcp: store remote id from MP_JOIN SYN/ACK in local ctx
    https://git.kernel.org/netdev/net-next/c/8a348392209f
  - [net-next,4/7] mptcp: reflect remote port (not 0) in ANNOUNCED events
    https://git.kernel.org/netdev/net-next/c/d1ace2d9abf3
  - [net-next,5/7] mptcp: establish subflows from either end of connection
    https://git.kernel.org/netdev/net-next/c/70c708e82606
  - [net-next,6/7] mptcp: expose server_side attribute in MPTCP netlink events
    https://git.kernel.org/netdev/net-next/c/41b3c69bf941
  - [net-next,7/7] mptcp: allow ADD_ADDR reissuance by userspace PMs
    https://git.kernel.org/netdev/net-next/c/304ab97f4c7c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


