Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BAFEA4
	for <mptcp@lists.linux.dev>; Sat,  9 Jul 2022 11:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8126C3411E;
	Sat,  9 Jul 2022 11:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1657366813;
	bh=H7C7bHDxgx7Hf4TRIhu1MC4de+z6YL1GgTy9ZRp1CUE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S60M474H6ncKScSP2go6Z58mtLeb6XqSbCsYLlCv44YiocVWR+vJJETLZQCrnxPOS
	 0Q3LcpqlM9WSfpixbdCdJCJzlBlJTdKbXUdEDZp8UxU+n7Kcf+6fWFxboAIlXqgpZk
	 e0sW9vGCOaGUc4jMVb8cN/7wqVgc4vZcLd9qgkPyg1iPSe2IuPJ/GwxkHoXMWPhaVh
	 d2YzA2tLElIQfKJF/bgZxp84rkw4q6euLE3UDrBbXpr/cz8DBZrsBFlD5C9RSGJtvE
	 tZxGIjsrYI9Hhtb/ASyuSsc5S8qQPgqLEcQFRI7SsryYp6DMMbGDHQI1x8C30TyS76
	 nVnHy/SmzTKcA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9E3E2E45BD8;
	Sat,  9 Jul 2022 11:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/6] mptcp: Self test improvements and a header tweak
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <165736681364.32617.7153064094364641646.git-patchwork-notify@kernel.org>
Date: Sat, 09 Jul 2022 11:40:13 +0000
References: <20220708171413.327112-1-mathew.j.martineau@linux.intel.com>
In-Reply-To: <20220708171413.327112-1-mathew.j.martineau@linux.intel.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, matthieu.baerts@tessares.net,
 geliang.tang@suse.com, mptcp@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (master)
by David S. Miller <davem@davemloft.net>:

On Fri,  8 Jul 2022 10:14:07 -0700 you wrote:
> Patch 1 moves a definition to a header so it can be used in a struct
> declaration.
> 
> Patch 2 adjusts a time threshold for a selftest that runs much slower on
> debug kernels (and even more on slow CI infrastructure), to reduce
> spurious failures.
> 
> [...]

Here is the summary with links:
  - [net-next,1/6] mptcp: move MPTCPOPT_HMAC_LEN to net/mptcp.h
    https://git.kernel.org/netdev/net-next/c/f7657ff4a709
  - [net-next,2/6] selftests: mptcp: tweak simult_flows for debug kernels
    https://git.kernel.org/netdev/net-next/c/d0d9c8f2df60
  - [net-next,3/6] selftests: mptcp: userspace pm address tests
    https://git.kernel.org/netdev/net-next/c/97040cf9806e
  - [net-next,4/6] selftests: mptcp: userspace pm subflow tests
    https://git.kernel.org/netdev/net-next/c/5e986ec46874
  - [net-next,5/6] selftests: mptcp: avoid Terminated messages in userspace_pm
    https://git.kernel.org/netdev/net-next/c/507719cd7c0f
  - [net-next,6/6] selftests: mptcp: update pm_nl_ctl usage header
    https://git.kernel.org/netdev/net-next/c/65ebc6676d17

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


