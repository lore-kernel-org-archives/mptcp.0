Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63254321C
	for <mptcp@lists.linux.dev>; Fri, 18 Feb 2022 05:00:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0FA34C340EC;
	Fri, 18 Feb 2022 05:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1645160412;
	bh=9vUcLVrANR8ishPt8UPgLw7rEGTVZ41km58g231t7VE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LreknXjvZdfdx/mRa3UzWvZ4G719i/wJGgoXDtNnoWUAPMuPRJ+LnM4HGL0scSqV+
	 m2MLvZdhLSiVDaqhs2OhMmKz2G3jN3rwhlUUbPeDz8GPUINpg/kNt+S0CiEYh7BppV
	 KTDicqYMi1s95hjFlSCSsoITSGQzV8dZqFvU/aYZMG+K/pBGXexij2BPEXTkJKjkxC
	 2tr7R7czsOevPxIFp5D/AIL8T4mi5Rt/KStnmrBLQMS/f1RJSkGi5Tcii+fUafdokj
	 Mcn1eZm8rNKYX2Bg03JkTMSDEVPYNjECbxcdG4sAMMnyWYFQF7KhLJWzTAz3gjHjou
	 fLLBSZaACxELQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EBD22E7BB0B;
	Fri, 18 Feb 2022 05:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/7] mptcp: Selftest fine-tuning and cleanup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <164516041196.28752.1745455465667562472.git-patchwork-notify@kernel.org>
Date: Fri, 18 Feb 2022 05:00:11 +0000
References: <20220218030311.367536-1-mathew.j.martineau@linux.intel.com>
In-Reply-To: <20220218030311.367536-1-mathew.j.martineau@linux.intel.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 matthieu.baerts@tessares.net, mptcp@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Feb 2022 19:03:04 -0800 you wrote:
> Patch 1 adjusts the mptcp selftest timeout to account for slow machines
> running debug builds.
> 
> Patch 2 simplifies one test function.
> 
> Patches 3-6 do some cleanup, like deleting unused variables and avoiding
> extra work when only printing usage information.
> 
> [...]

Here is the summary with links:
  - [net-next,1/7] selftests: mptcp: increase timeout to 20 minutes
    https://git.kernel.org/netdev/net-next/c/d17b968b9876
  - [net-next,2/7] selftests: mptcp: simplify pm_nl_change_endpoint
    https://git.kernel.org/netdev/net-next/c/bccefb762439
  - [net-next,3/7] selftests: mptcp: join: exit after usage()
    https://git.kernel.org/netdev/net-next/c/22514d52962b
  - [net-next,4/7] selftests: mptcp: join: remove unused vars
    https://git.kernel.org/netdev/net-next/c/0a40e273be04
  - [net-next,5/7] selftests: mptcp: join: create tmp files only if needed
    https://git.kernel.org/netdev/net-next/c/93827ad58f62
  - [net-next,6/7] selftests: mptcp: join: check for tools only if needed
    https://git.kernel.org/netdev/net-next/c/87154755d90e
  - [net-next,7/7] selftests: mptcp: add csum mib check for mptcp_connect
    https://git.kernel.org/netdev/net-next/c/24720d7452df

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


