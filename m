Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40B77A
	for <mptcp@lists.linux.dev>; Wed,  9 Mar 2022 06:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6ED7CC340EE;
	Wed,  9 Mar 2022 06:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1646806812;
	bh=aMW4XIMm99ssnG5V041tYeOhRA0k7daziqHyTWlFWaw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VpsaXNYJZqLMzSP8U6naHAAeS2sGTGq/W2zWpqFGUKGOXpAqN009FJ0NtgJW/CXst
	 Mv05tm6eiraQN1ERt/OVC4LmR18A1gFZi6D5NzTxp8cYqLTJxj1z7KLOVhyHNE47Gd
	 /bXpIz03AqDTOVbZCKi4zOoiI3z2qWNzHw+m2PQZvJsFGKs0ZbCGUWNCscVEphpuWL
	 7CaixAqwOaMws2NInmB4MF+L0qlc6qSfWUGgMC346zLgAAxNlIUCBvGny2x6gG8Fj0
	 oSwGuBhneCkLfUHlS1CppLmMSaTBBtx9DTtU+r6N0aT2KR0o5IO33kJ9InuWjL1mlg
	 jHG0+xIJ7sAeA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 55DD9E73C2D;
	Wed,  9 Mar 2022 06:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/9] mptcp: Advertisement reliability improvement and
 misc. updates
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <164680681234.10719.13295993064951217682.git-patchwork-notify@kernel.org>
Date: Wed, 09 Mar 2022 06:20:12 +0000
References: <20220307204439.65164-1-mathew.j.martineau@linux.intel.com>
In-Reply-To: <20220307204439.65164-1-mathew.j.martineau@linux.intel.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 matthieu.baerts@tessares.net, mptcp@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  7 Mar 2022 12:44:30 -0800 you wrote:
> Patch 1 adds a helpful debug tracepoint for outgoing MPTCP packets.
> 
> Patch 2 is a small "magic number" refactor.
> 
> Patches 3 & 4 refactor parts of the mptcp_join.sh selftest. No change in
> test coverage.
> 
> [...]

Here is the summary with links:
  - [net-next,1/9] mptcp: add tracepoint in mptcp_sendmsg_frag
    https://git.kernel.org/netdev/net-next/c/0eb4e7ee1655
  - [net-next,2/9] mptcp: use MPTCP_SUBFLOW_NODATA
    https://git.kernel.org/netdev/net-next/c/ea56dcb43c20
  - [net-next,3/9] selftests: mptcp: join: allow running -cCi
    https://git.kernel.org/netdev/net-next/c/826d7bdca833
  - [net-next,4/9] selftests: mptcp: Rename wait function
    https://git.kernel.org/netdev/net-next/c/f98c2bca7b2b
  - [net-next,5/9] mptcp: more careful RM_ADDR generation
    https://git.kernel.org/netdev/net-next/c/6fa0174a7c86
  - [net-next,6/9] mptcp: introduce implicit endpoints
    https://git.kernel.org/netdev/net-next/c/d045b9eb95a9
  - [net-next,7/9] mptcp: strict local address ID selection
    https://git.kernel.org/netdev/net-next/c/4cf86ae84c71
  - [net-next,8/9] selftests: mptcp: add implicit endpoint test case
    https://git.kernel.org/netdev/net-next/c/69c6ce7b6eca
  - [net-next,9/9] mptcp: add fullmesh flag check for adding address
    https://git.kernel.org/netdev/net-next/c/0dc626e5e853

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


