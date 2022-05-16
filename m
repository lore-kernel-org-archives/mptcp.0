Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEE61376
	for <mptcp@lists.linux.dev>; Mon, 16 May 2022 20:20:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D384C36AE5;
	Mon, 16 May 2022 20:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1652732414;
	bh=GYxBwmC+LyRB6j5u61I3rBasmd4cPrmPfM8w0Cw/ZYE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JmeF2WSFuGIkc7dv0nfn41l5IlNNDabfCxml3RJAjYjYlMzkyR0LkXb6fa9PxMhLU
	 On7A3ayGcnWYptO7po4XiZycG8H3yKFHwRhkNB3KcODC3YVdLDHKX+gPWnC7Qs8yDk
	 BKxzQIOMooAotnmj/vaCBhMp5HMgYC67QiXIzaCjIfYejDLBO8rPNo85zQD42vWh2S
	 D/WKSdwaTBAA7OuDTnBM+RO2n+u57mY8QHlunrHIJPZnFodci5X2lC/uoWl0VpbpqI
	 hPU9o2jpGtMTl48aVOT+3kfJS+mVP9HSLuaDAu4qpMO88a9I6O0dYjfgfORcxBFWh/
	 YHH20SFFKOHLg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 351DFF0393C;
	Mon, 16 May 2022 20:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] mptcp: Updates for net-next
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <165273241421.3924.625171959579879205.git-patchwork-notify@kernel.org>
Date: Mon, 16 May 2022 20:20:14 +0000
References: <20220514002115.725976-1-mathew.j.martineau@linux.intel.com>
In-Reply-To: <20220514002115.725976-1-mathew.j.martineau@linux.intel.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, matthieu.baerts@tessares.net,
 mptcp@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 13 May 2022 17:21:12 -0700 you wrote:
> Three independent fixes/features from the MPTCP tree:
> 
> Patch 1 is a selftest workaround for older iproute2 packages.
> 
> Patch 2 removes superfluous locks that were added with recent MP_FAIL
> patches.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] selftests: mptcp: fix a mp_fail test warning
    https://git.kernel.org/netdev/net-next/c/c43ce39870b3
  - [net-next,2/3] Revert "mptcp: add data lock for sk timers"
    https://git.kernel.org/netdev/net-next/c/0ea5374255a9
  - [net-next,3/3] mptcp: sockopt: add TCP_DEFER_ACCEPT support
    https://git.kernel.org/netdev/net-next/c/ea1e301d04b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


