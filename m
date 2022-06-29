Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAE47A
	for <mptcp@lists.linux.dev>; Wed, 29 Jun 2022 04:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A9DDC341C8;
	Wed, 29 Jun 2022 04:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1656475215;
	bh=FGbd2l+VwCTrhQBwqDGWQH2b1/i1EnTUU4/sq2wyOic=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MTYoHsumdISbLymskDtSGQqi6kekxO2dYzxWHw/kopjRqo8kWPhclr0SuSiQhLvEF
	 +EoM7r2hLA/Ct7lsqd997eMcUlLA2ypt7f5+ze3IQJ12EzvaTz3CeLkLbdR4eqJ5Cl
	 zGhYzMlMXVReT+ZIRX1vPCCCAn3K/RRPcHd8b4nNbwa3WFew/Hl64CIkBss2HTCsda
	 KCU0Z0y6DXFWQr30TJhokfYXUM5sowEzY+sJhaPe7Ixm9OmzgJKFgJ17g7VYBJwutY
	 O747VHZad9wBCua3LSV/5y9amBhxbKx+ZslHcqDOA37wwfBEzDroqJXGTmHuJTsnjf
	 LLgsqEMl5yOQA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7CE40E49BB8;
	Wed, 29 Jun 2022 04:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/9] mptcp: Fixes for 5.19
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <165647521550.15342.17491165529630810403.git-patchwork-notify@kernel.org>
Date: Wed, 29 Jun 2022 04:00:15 +0000
References: <20220628010243.166605-1-mathew.j.martineau@linux.intel.com>
In-Reply-To: <20220628010243.166605-1-mathew.j.martineau@linux.intel.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, fw@strlen.de, geliang.tang@suse.com,
 matthieu.baerts@tessares.net, mptcp@lists.linux.dev

Hello:

This series was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 Jun 2022 18:02:34 -0700 you wrote:
> Several categories of fixes from the mptcp tree:
> 
> Patches 1-3 are fixes related to MP_FAIL and FASTCLOSE, to make sure
> MIBs are accurate, and to handle MP_FAIL transmission and responses at
> the correct times. sk_timer conflicts are also resolved.
> 
> Patches 4 and 6 handle two separate race conditions, one at socket
> shutdown and one with unaccepted subflows.
> 
> [...]

Here is the summary with links:
  - [net,1/9] mptcp: fix error mibs accounting
    https://git.kernel.org/netdev/net/c/0c1f78a49af7
  - [net,2/9] mptcp: introduce MAPPING_BAD_CSUM
    https://git.kernel.org/netdev/net/c/31bf11de146c
  - [net,3/9] mptcp: invoke MP_FAIL response when needed
    https://git.kernel.org/netdev/net/c/76a13b315709
  - [net,4/9] mptcp: fix shutdown vs fallback race
    https://git.kernel.org/netdev/net/c/d51991e2e314
  - [net,5/9] mptcp: consistent map handling on failure
    https://git.kernel.org/netdev/net/c/f745a3ebdfb9
  - [net,6/9] mptcp: fix race on unaccepted mptcp sockets
    https://git.kernel.org/netdev/net/c/6aeed9045071
  - [net,7/9] selftests: mptcp: more stable diag tests
    https://git.kernel.org/netdev/net/c/42fb6cddec3b
  - [net,8/9] mptcp: fix conflict with <netinet/in.h>
    https://git.kernel.org/netdev/net/c/06e445f740c1
  - [net,9/9] selftests: mptcp: Initialize variables to quiet gcc 12 warnings
    https://git.kernel.org/netdev/net/c/fd37c2ecb21f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


