Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D4D33C6
	for <mptcp@lists.linux.dev>; Wed,  6 Jul 2022 12:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99126C341CA;
	Wed,  6 Jul 2022 12:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1657108820;
	bh=DPJoaqosU+UXtuc1NFSZO1IP+Lo7h5IyPFbdkKfhEV4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PnuFP6fE700NyWvJxQVhWs7Nt7b3LyXvj1pNVyYgTPa21geMyf7sEQOMpy6/38+Jc
	 U+cIXjMsKU4NGJ27j0w4zdp4jmK2GZDWoc75y85mIUJXanYt78Xn5+4RZGW/qdN9MQ
	 S8KfOg4kFkcI87Q061v3CGnl+5ijR7sc4PqQFdGLayf2b8cdq7+lPOuv46M5uSZYGM
	 uI0CbJKYTPQLJv6W6jGL+smGwUMfonKk1q4mi35RyvoP0FndZFDuAaNQKgUu6YlWW4
	 57sRQ56yISRR9l5L8gG9Xj7dLcclwpax+EusCogkSXYfay1LssVwIzeJP/v7PYoftB
	 cDgnpmuURc4Kg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 85412E45BDC;
	Wed,  6 Jul 2022 12:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/7] mptcp: Path manager fixes for 5.19
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <165710882054.23384.2979823140272634407.git-patchwork-notify@kernel.org>
Date: Wed, 06 Jul 2022 12:00:20 +0000
References: <20220705213217.146898-1-mathew.j.martineau@linux.intel.com>
In-Reply-To: <20220705213217.146898-1-mathew.j.martineau@linux.intel.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, fw@strlen.de, geliang.tang@suse.com,
 matthieu.baerts@tessares.net, mptcp@lists.linux.dev

Hello:

This series was applied to netdev/net.git (master)
by David S. Miller <davem@davemloft.net>:

On Tue,  5 Jul 2022 14:32:10 -0700 you wrote:
> The MPTCP userspace path manager is new in 5.19, and these patches fix
> some issues in that new code.
> 
> Patches 1-3 fix path manager locking issues.
> 
> Patches 4 and 5 allow userspace path managers to change priority of
> established subflows using the existing MPTCP_PM_CMD_SET_FLAGS generic
> netlink command. Includes corresponding self test update.
> 
> [...]

Here is the summary with links:
  - [net,1/7] mptcp: fix locking in mptcp_nl_cmd_sf_destroy()
    https://git.kernel.org/netdev/net/c/5ccecaec5c1e
  - [net,2/7] mptcp: Avoid acquiring PM lock for subflow priority changes
    https://git.kernel.org/netdev/net/c/c21b50d5912b
  - [net,3/7] mptcp: Acquire the subflow socket lock before modifying MP_PRIO flags
    https://git.kernel.org/netdev/net/c/a657430260e5
  - [net,4/7] mptcp: netlink: issue MP_PRIO signals from userspace PMs
    https://git.kernel.org/netdev/net/c/892f396c8e68
  - [net,5/7] selftests: mptcp: userspace PM support for MP_PRIO signals
    https://git.kernel.org/netdev/net/c/ca188a25d43f
  - [net,6/7] mptcp: fix local endpoint accounting
    https://git.kernel.org/netdev/net/c/843b5e75efff
  - [net,7/7] mptcp: update MIB_RMSUBFLOW in cmd_sf_destroy
    https://git.kernel.org/netdev/net/c/d2d21f175f1f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


