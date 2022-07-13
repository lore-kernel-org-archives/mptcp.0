Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A9715AC
	for <mptcp@lists.linux.dev>; Wed, 13 Jul 2022 01:50:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7FA82C341C8;
	Wed, 13 Jul 2022 01:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1657677014;
	bh=PAeyteoc6+Q3wZM/hVytFrgAhkXNk42o/FtksMHXMB8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Xgmd/BVl2iAES0yxeUa1iE6IcXe1X0MIaMO9dhUE1//lHXUy8j6NoPZJsvofCEcwR
	 qa2siKp+N6KQyzqHsTN89OCzqch3jJFxCgLZQOu3ocO/MBomKknhn/I2Z07odL3k98
	 Vz42bN3km0exv7SW+jXf1Tum2ZJRE0bpM+zrIab+0x2LZmNyr0gMV4f6x5PUE7bF0W
	 PyaRAfhcUC/BA4XUuMnuZzm9GgvdRlARy80mrrRakJiawySLApwhxlQYsMLUWqSvLC
	 QMLO4mWjPThgtrykoG1m93ZzvoxBEZTSCHnceEVbTZh50Kdi5SszdAT13XvK8/Lw5n
	 yzRN7AMntG4/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5BC55E45227;
	Wed, 13 Jul 2022 01:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] mptcp: Support changes to initial subflow
 priority
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <165767701437.24919.7455842118209348251.git-patchwork-notify@kernel.org>
Date: Wed, 13 Jul 2022 01:50:14 +0000
References: <20220711191633.80826-1-mathew.j.martineau@linux.intel.com>
In-Reply-To: <20220711191633.80826-1-mathew.j.martineau@linux.intel.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, matthieu.baerts@tessares.net,
 mptcp@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 11 Jul 2022 12:16:28 -0700 you wrote:
> This series updates the in-kernel MPTCP path manager to allow changes to
> subflow priority for the first subflow created for each MPTCP connection
> (the one created with the MP_CAPABLE handshake).
> 
> Patches 1 and 2 do some refactoring to simplify the new functionality.
> 
> Patch 3 introduces the new feature to change the initial subflow
> priority and send the MP_PRIO header on that subflow.
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] mptcp: introduce and use mptcp_pm_send_ack()
    https://git.kernel.org/netdev/net-next/c/f5360e9b314c
  - [net-next,2/5] mptcp: address lookup improvements
    https://git.kernel.org/netdev/net-next/c/bedee0b56113
  - [net-next,3/5] mptcp: allow the in kernel PM to set MPC subflow priority
    https://git.kernel.org/netdev/net-next/c/c157bbe776b7
  - [net-next,4/5] mptcp: more accurate MPC endpoint tracking
    https://git.kernel.org/netdev/net-next/c/3ad14f54bd74
  - [net-next,5/5] selftests: mptcp: add MPC backup tests
    https://git.kernel.org/netdev/net-next/c/914f6a59b10f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


