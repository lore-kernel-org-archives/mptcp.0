Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2649E2F80
	for <mptcp@lists.linux.dev>; Thu, 10 Jun 2021 21:50:06 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id CEBE4613E9;
	Thu, 10 Jun 2021 21:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1623361805;
	bh=FIvv5oraFhhY29I3YGqi23pBnmObIPqnLyGlY3VjM5I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dXhBWJh994GIx79SWVhGH9ucLseZ49qPQyoONXy1PAq+lw+M8sMP5bbka+zjVv9SW
	 QYZfD6Gklgt7hFnyJMsb6kJ94eARKiM4/Igz7JcWP63TbEcr14RNOQDGGeg92G0z+/
	 aSLfvhlx+GmE2OCT5UGxFP6LyePMWzipd47LK07vV5ZA+KgAfEeEGF3acfKyBzjXm/
	 BsVWvmcLk2Ckv9nq/j6IU8bIlx77J23o92qxwSenlxXE0mbTf5EGc5fUXpTZ3COftA
	 kb0Ru4J6Dd1utmPCuCWeIvgjWidh2Qe+ZJrMTjzpgozCI/Q8A8JFxVzPiA3dXviUP6
	 SW/iCe6+58olw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C044560A53;
	Thu, 10 Jun 2021 21:50:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/3] Fix out of bounds when parsing TCP options
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <162336180578.29138.2109462655525046867.git-patchwork-notify@kernel.org>
Date: Thu, 10 Jun 2021 21:50:05 +0000
References: <20210610164031.3412479-1-maximmi@nvidia.com>
In-Reply-To: <20210610164031.3412479-1-maximmi@nvidia.com>
To: Maxim Mikityanskiy <maximmi@nvidia.com>
Cc: mathew.j.martineau@linux.intel.com, matthieu.baerts@tessares.net,
 kuba@kernel.org, davem@davemloft.net, pablo@netfilter.org,
 kadlec@netfilter.org, fw@strlen.de, toke@toke.dk, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, kaber@trash.net,
 brouer@redhat.com, pabeni@redhat.com, cpaasch@apple.com,
 peter.krystad@linux.intel.com, 92siuyang@gmail.com, netdev@vger.kernel.org,
 mptcp@lists.linux.dev

Hello:

This series was applied to netdev/net.git (refs/heads/master):

On Thu, 10 Jun 2021 19:40:28 +0300 you wrote:
> This series fixes out-of-bounds access in various places in the kernel
> where parsing of TCP options takes place. Fortunately, many more
> occurrences don't have this bug.
> 
> v2 changes:
> 
> synproxy: Added an early return when length < 0 to avoid calling
> skb_header_pointer with negative length.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/3] netfilter: synproxy: Fix out of bounds when parsing TCP options
    https://git.kernel.org/netdev/net/c/5fc177ab7594
  - [net,v2,2/3] mptcp: Fix out of bounds when parsing TCP options
    https://git.kernel.org/netdev/net/c/07718be26568
  - [net,v2,3/3] sch_cake: Fix out of bounds when parsing TCP options and header
    https://git.kernel.org/netdev/net/c/ba91c49dedbd

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


