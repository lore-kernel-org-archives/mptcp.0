Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD042C86
	for <mptcp@lists.linux.dev>; Mon,  1 Nov 2021 13:30:09 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id 815DA61077;
	Mon,  1 Nov 2021 13:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1635773408;
	bh=u6qsewV29FajH+7TPyp3k0O+qeUww4RvWgV1CYd7V1o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MoDRGePspJvXqVLXctLMTTLADOFsRf5buVrx+qiXAigKtD3uysHF5ZnmEiigmEF+Z
	 gYdrG7zqyCEg/R75vdrOhKddrRoc+oPYTHLdVO8f/x91s0ALBPbCaxT3mqeExNFRbB
	 Yu06WiGCsGRebie4hiVZBBrzK1m0Xy5ITxF7ZhbzbnRquhtJDzmgBDAMPqB3QxIets
	 NSBfy+tobIgYEM+LKZ1BZ5YTxW2aSTLJWrEygxWgQp9fx7D1mlAeBCZip+XdG1FBKL
	 N0tYT38e0IhKmo09RLmxRlG71GYZWsvZOpNjvrjEvvjW3P3qVdnRl33EmZOQGR3ey+
	 XZi3Gc1R2pUtA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7797D60BD0;
	Mon,  1 Nov 2021 13:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] mptcp: Some selftest improvements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <163577340848.3113.12246193029907596147.git-patchwork-notify@kernel.org>
Date: Mon, 01 Nov 2021 13:30:08 +0000
References: <20211029235559.246858-1-mathew.j.martineau@linux.intel.com>
In-Reply-To: <20211029235559.246858-1-mathew.j.martineau@linux.intel.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 matthieu.baerts@tessares.net, pabeni@redhat.com, mptcp@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (master)
by David S. Miller <davem@davemloft.net>:

On Fri, 29 Oct 2021 16:55:57 -0700 you wrote:
> Here are a couple of selftest changes for MPTCP.
> 
> Patch 1 fixes a mistake where the wrong protocol (TCP vs MPTCP) could be
> requested on the listening socket in some link failure tests.
> 
> Patch 2 refactors the simulataneous flow tests to improve timing
> accuracy and give more consistent results.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] selftests: mptcp: fix proto type in link_failure tests
    https://git.kernel.org/netdev/net-next/c/7c909a98042c
  - [net-next,2/2] selftests: mptcp: more stable simult_flows tests
    https://git.kernel.org/netdev/net-next/c/b6ab64b074f2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


