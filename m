Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10403C2E2
	for <mptcp@lists.linux.dev>; Mon, 17 Apr 2023 07:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A5B1CC4339C;
	Mon, 17 Apr 2023 07:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681716619;
	bh=leNX+acNVy8tTVTexUmA8hPJABXi1tT50Vr4vkpw6pM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tR7sdBYa9NbzRjRv6hIqQGaM3dJjhqJQeRCYuvk6s7fWqZW3T5TpC4KI7EBkkL2Qx
	 LI2w1L2Apy0+H/nNsvPGxRKLYMPaPVRqWAZcwIBmnIRf5jGQRPCRfgCUAoROUbqzdM
	 nkdJPtSwlmnr7JJUyKeisGXSNLozIeoXmOn4OcytarVGdPc1hHMokysbTc/IKI60Ma
	 MEhUpkOCJOFMnbP9tZbN4hfrEFPp9R5bBcPd3wnuv+058lislHdSytrSgZBnEsxttk
	 y3FAMzFPXiya7T3dzUC74si5Xy5ZwhSQnJPWAakw3znG2C4lOFyjo/1k/WUvc6BTWw
	 zMAaRsZ17EzAA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 868D2E3309E;
	Mon, 17 Apr 2023 07:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] mptcp: various small cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168171661954.7386.4716677833792034478.git-patchwork-notify@kernel.org>
Date: Mon, 17 Apr 2023 07:30:19 +0000
References: <20230414-upstream-net-next-20230414-mptcp-small-cleanups-v1-0-5aa4a2e05cf2@tessares.net>
In-Reply-To: <20230414-upstream-net-next-20230414-mptcp-small-cleanups-v1-0-5aa4a2e05cf2@tessares.net>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 geliang.tang@suse.com, abaci@linux.alibaba.com, martineau@kernel.org,
 jiapeng.chong@linux.alibaba.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 14 Apr 2023 17:47:05 +0200 you wrote:
> Patch 1 makes a function static because it is only used in one file.
> 
> Patch 2 adds info about the git trees we use to help occasional devs.
> 
> Patch 3 removes an unused variable.
> 
> Patch 4 removes duplicated entries from the help menu of a tool used in
> MPTCP selftests.
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] mptcp: make userspace_pm_append_new_local_addr static
    https://git.kernel.org/netdev/net-next/c/aa5887dca2d2
  - [net-next,2/5] MAINTAINERS: add git trees for MPTCP
    https://git.kernel.org/netdev/net-next/c/c3d713409b53
  - [net-next,3/5] mptcp: remove unused 'remaining' variable
    https://git.kernel.org/netdev/net-next/c/ce395d0e3ad5
  - [net-next,4/5] selftests: mptcp: remove duplicated entries in usage
    https://git.kernel.org/netdev/net-next/c/0a85264e48b6
  - [net-next,5/5] selftests: mptcp: join: fix ShellCheck warnings
    https://git.kernel.org/netdev/net-next/c/0fcd72df8847

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


