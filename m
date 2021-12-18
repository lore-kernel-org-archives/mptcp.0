Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37FE168
	for <mptcp@lists.linux.dev>; Sat, 18 Dec 2021 03:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9BE05C36AEE;
	Sat, 18 Dec 2021 03:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1639798216;
	bh=8taeHz+BUzRdPSTxa4o5QO06jqTiQam5266/EQuRb0o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A6k8ngg+fDGxnEKKrhEOqnTUQhkZa9HmffiAs35oiyafYv2GxDxbF8xZpbLztGfqM
	 HRrhCszo7ZX6fCCVKpCyL2GpKKtY+j7pFqYF9Z1SwYAOG9Q78eWvUptj9TCUi1X6Ee
	 W/AeHccopzocNS4fbMxmd9+yLFTr5iGyRNSrs+xsnE358hEpxQ4laA7SIfOynvtP5I
	 G0OPRjTqQhG865vIAsECKn0TB2CRZX8kbJVV/sHgD3HbJ8Nqfnci4mKztCYbqFJgYN
	 51fxo/SkgpkcogCJfXcg5BvfCk3Ilgr5d+UNsnBYRKpMGsyJzzKmh+Dfzm+cLTB3ZI
	 Oo3TYMRl35p3g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 8AE4E60A54;
	Sat, 18 Dec 2021 03:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] mptcp: Miscellaneous changes for 5.17
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <163979821656.17814.14058123416680753927.git-patchwork-notify@kernel.org>
Date: Sat, 18 Dec 2021 03:30:16 +0000
References: <20211217233702.299461-1-mathew.j.martineau@linux.intel.com>
In-Reply-To: <20211217233702.299461-1-mathew.j.martineau@linux.intel.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 matthieu.baerts@tessares.net, mptcp@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 17 Dec 2021 15:36:59 -0800 you wrote:
> These are three unrelated patches that we've been testing in the MPTCP
> tree.
> 
> 
> Patch 1 modifies the packet scheduler that picks which TCP subflow is
> used for each chunk of outgoing data. The updated scheduler improves
> throughput on multiple-subflow connections.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] mptcp: enforce HoL-blocking estimation
    https://git.kernel.org/netdev/net-next/c/3ce0852c86b9
  - [net-next,2/3] selftests: mptcp: try to set mptcp ulp mode in different sk states
    https://git.kernel.org/netdev/net-next/c/f730b65c9d85
  - [net-next,3/3] mptcp: clean up harmless false expressions
    https://git.kernel.org/netdev/net-next/c/59060a47ca50

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


