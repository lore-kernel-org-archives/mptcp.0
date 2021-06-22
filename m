Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4589570
	for <mptcp@lists.linux.dev>; Tue, 22 Jun 2021 17:40:05 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id D00CC61360;
	Tue, 22 Jun 2021 17:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1624383604;
	bh=3CAbsHPkm5mRQltUWm0qW52MIoB7fgk5tQAfiOVuDuc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p2KdFrcQJ944iRHGLHx0pGShd3aoAziACpUGYcxnQFv9Rmo7R1AZJw/6sXOkU/Y5O
	 Q7WyPqnz3ovSL5jewFWdAQd9/fOmlgYwZHIUDvvtNi+MTpkmNx2jkZ+wyDKi0LRjUI
	 3YrWU/lOYsICwV2cBoznMjEk0xL5WzUxY1XRIFMIE5ZKAvYJZBONhWI9WmG78rHxh4
	 RD+5l03EdP5NJ059jkk1eCwJ+l0cLIruPbX12OdNJ0LmvNqgSpYQqNWasuQbqEHO+c
	 FjgqRuX7JacvfbkeocPlDNDAsha3NVQU7SbwnyQo0Ctu3qbgvRt1KiLdGp59VHC8ID
	 wLaeVsstp2POg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C628D60A6C;
	Tue, 22 Jun 2021 17:40:04 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] mptcp: Fixes for v5.13
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <162438360480.26881.14977711670165986087.git-patchwork-notify@kernel.org>
Date: Tue, 22 Jun 2021 17:40:04 +0000
References: <20210622003309.71224-1-mathew.j.martineau@linux.intel.com>
In-Reply-To: <20210622003309.71224-1-mathew.j.martineau@linux.intel.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 matthieu.baerts@tessares.net, mptcp@lists.linux.dev, pabeni@redhat.com,
 fw@strlen.de, dcaratti@redhat.com

Hello:

This series was applied to netdev/net.git (refs/heads/master):

On Mon, 21 Jun 2021 17:33:07 -0700 you wrote:
> Here are two MPTCP fixes from Paolo.
> 
> Patch 1 fixes some possible connect-time race conditions with
> MPTCP-level connection state changes.
> 
> Patch 2 deletes a duplicate function declaration.
> 
> [...]

Here is the summary with links:
  - [net,1/2] mptcp: avoid race on msk state changes
    https://git.kernel.org/netdev/net/c/490274b47468
  - [net,2/2] mptcp: drop duplicate mptcp_setsockopt() declaration
    https://git.kernel.org/netdev/net/c/597dbae77ee5

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


