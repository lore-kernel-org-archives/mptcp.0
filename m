Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F4B29CA
	for <mptcp@lists.linux.dev>; Wed, 15 Dec 2021 04:40:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 790FEC34604;
	Wed, 15 Dec 2021 04:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1639543209;
	bh=myTZUyFP8jwijp/WSM8lu6gT089/W/+zVypCxbikl7I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RrLq4c84BXFViHkAxASRH5/wgVw0ifO4sAIhRqqg8iso6DehCxc6SL+GuNUsaiF3j
	 PA6iqi1pzI9gN3oA752BLhaD0gjiNtkc4B4FzZzEOKdpDV5uFn+3jG1oxVfHCA8kG3
	 rTx4Obg07gvcgFjD7NdJEbGAe3vyI5hxmSW2ml3ptUNWiS8g1vxNN3RoniVaA4NejI
	 5e9yvX6d+IZIT4piHOIRbEcgHGa6jbOoEUDmxUOjZNaf09hqHu/GBzpfC5T0u05GbQ
	 fZOf0ytPeuVSyhEvAVckMy8M3yCZlgouwtaW/Xt92pXwNJ175VuXdltc+iZP5Ot7wP
	 dp2MoGHzcblow==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4BF2E60A53;
	Wed, 15 Dec 2021 04:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4] mptcp: Fixes for ULP, a deadlock, and netlink docs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <163954320930.357.8040539166907410920.git-patchwork-notify@kernel.org>
Date: Wed, 15 Dec 2021 04:40:09 +0000
References: <20211214231604.211016-1-mathew.j.martineau@linux.intel.com>
In-Reply-To: <20211214231604.211016-1-mathew.j.martineau@linux.intel.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 matthieu.baerts@tessares.net, mptcp@lists.linux.dev

Hello:

This series was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 Dec 2021 15:16:00 -0800 you wrote:
> Two of the MPTCP fixes in this set are related to the TCP_ULP socket
> option with MPTCP sockets operating in "fallback" mode (the connection
> has reverted to regular TCP). The other issues are an observed deadlock
> and missing parameter documentation in the MPTCP netlink API.
> 
> 
> Patch 1 marks TCP_ULP as unsupported earlier in MPTCP setsockopt code,
> so the fallback code path in the MPTCP layer does not pass the TCP_ULP
> option down to the subflow TCP socket.
> 
> [...]

Here is the summary with links:
  - [net,1/4] mptcp: remove tcp ulp setsockopt support
    https://git.kernel.org/netdev/net/c/404cd9a22150
  - [net,2/4] mptcp: clear 'kern' flag from fallback sockets
    https://git.kernel.org/netdev/net/c/d6692b3b97bd
  - [net,3/4] mptcp: fix deadlock in __mptcp_push_pending()
    https://git.kernel.org/netdev/net/c/3d79e3756ca9
  - [net,4/4] mptcp: add missing documented NL params
    https://git.kernel.org/netdev/net/c/6813b1928758

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


