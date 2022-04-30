Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C2A7B
	for <mptcp@lists.linux.dev>; Sat, 30 Apr 2022 01:00:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2951AC385A7;
	Sat, 30 Apr 2022 01:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1651280414;
	bh=J2nru83vtgNQDoLLwvNxfDEnsmdnLShK5o+F1MnNj28=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TaDMUn8sqACDvcyHHJOd+12hzPlvsDkDKT9IB9Q9AXy1yQgDDXGXCiSyWjKfpnCT9
	 7flY+4DQ7z9afcGd+QWp/k7UNCyjLNwFnkR6pNeiF1KXV/5ghhSfvtpT6Ma+HvGEL0
	 qyerBaVsShbUScZIGxbRTexU9TqTDtCdgjl8CCCiOoPJa5+YDydEBN0VjHbI5ZdXVr
	 37D+EdIVq/nwF5P+5QlMQqwpzCLkcbghSFW8RdyLI+fConwt4UVxBKztf8UxK68uRp
	 7WFZ6F8TjrUiGsDqA9pMzQsNiN5A27ctxBmNYkaH62X5EreSXdJbQnGoTs5ygb4+pb
	 dow1xuBBzxBkA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 14712F0383D;
	Sat, 30 Apr 2022 01:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/6] mptcp: Path manager mode selection
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <165128041408.25380.16524289491061070613.git-patchwork-notify@kernel.org>
Date: Sat, 30 Apr 2022 01:00:14 +0000
References: <20220427225002.231996-1-mathew.j.martineau@linux.intel.com>
In-Reply-To: <20220427225002.231996-1-mathew.j.martineau@linux.intel.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, matthieu.baerts@tessares.net, mptcp@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 27 Apr 2022 15:49:56 -0700 you wrote:
> MPTCP already has an in-kernel path manager (PM) to add and remove TCP
> subflows associated with a given MPTCP connection. This in-kernel PM has
> been designed to handle typical server-side use cases, but is not very
> flexible or configurable for client devices that may have more
> complicated policies to implement.
> 
> This patch series from the MPTCP tree is the first step toward adding a
> generic-netlink-based API for MPTCP path management, which a privileged
> userspace daemon will be able to use to control subflow
> establishment. These patches add a per-namespace sysctl to select the
> default PM type (in-kernel or userspace) for new MPTCP sockets. New
> self-tests confirm expected behavior when userspace PM is selected but
> there is no daemon available to handle existing MPTCP PM events.
> 
> [...]

Here is the summary with links:
  - [net-next,1/6] mptcp: Remove redundant assignments in path manager init
    https://git.kernel.org/netdev/net-next/c/9273b9d57995
  - [net-next,2/6] mptcp: Add a member to mptcp_pm_data to track kernel vs userspace mode
    https://git.kernel.org/netdev/net-next/c/d85a8fde71e2
  - [net-next,3/6] mptcp: Bypass kernel PM when userspace PM is enabled
    https://git.kernel.org/netdev/net-next/c/14b06811bec6
  - [net-next,4/6] mptcp: Make kernel path manager check for userspace-managed sockets
    https://git.kernel.org/netdev/net-next/c/6961326e38fe
  - [net-next,5/6] mptcp: Add a per-namespace sysctl to set the default path manager type
    https://git.kernel.org/netdev/net-next/c/6bb63ccc25d4
  - [net-next,6/6] selftests: mptcp: Add tests for userspace PM type
    https://git.kernel.org/netdev/net-next/c/5ac1d2d63451

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


