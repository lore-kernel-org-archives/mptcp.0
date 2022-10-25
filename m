Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2F664C
	for <mptcp@lists.linux.dev>; Tue, 25 Oct 2022 04:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9D24C4347C;
	Tue, 25 Oct 2022 04:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666672217;
	bh=9w80c7HRCKaqTveA7+VfjhRsZHN8+nlyyYEayDG2jcA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=X33to5mFvO1LmvuEwNtRcb6R8+vMNFRwSxRe4QFab5UKnLKMdC/s3lTKd0s4UGJk+
	 RxW58uHI+csGVtwsQWZalj9p97PaZ2l4CugsBgONUd9h4n4hNXdSTPWp8Lf0CrBHbC
	 d4GGPSM9jjXh0K69H5GP9bBX3Gj4/YilegwVY8uqfF7/opjwqHhqxOoRni9pZPIvKY
	 bHMV30eTLqvYzmJGCrgrfQUsXVIUvWkrpjpUALm4UIJssclP4K1FCAYMc9Y85G+GKS
	 5t3TdJtvXJPOxZe90TtqeIlj19Qu/EUl1ilGuEtCiraHKh6sN5QIeTH9FklwUnMuRO
	 EQV3mWyWxTesw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BCCA6E270DD;
	Tue, 25 Oct 2022 04:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] mptcp: Fixes for 6.1
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <166667221776.14254.9036188124871368024.git-patchwork-notify@kernel.org>
Date: Tue, 25 Oct 2022 04:30:17 +0000
References: <20221021225856.88119-1-mathew.j.martineau@linux.intel.com>
In-Reply-To: <20221021225856.88119-1-mathew.j.martineau@linux.intel.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dmytro@shytyi.net,
 benjamin.hesmans@tessares.net, matthieu.baerts@tessares.net,
 mptcp@lists.linux.dev

Hello:

This series was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 21 Oct 2022 15:58:53 -0700 you wrote:
> Patch 1 fixes an issue with assigning subflow IDs in cases where an
> incoming MP_JOIN is processed before accept() completes on the MPTCP
> socket.
> 
> Patches 2 and 3 fix a deadlock issue with fastopen code (new for 6.1) at
> connection time.
> 
> [...]

Here is the summary with links:
  - [net,1/3] mptcp: set msk local address earlier
    https://git.kernel.org/netdev/net/c/e72e4032637f
  - [net,2/3] mptcp: factor out mptcp_connect()
    https://git.kernel.org/netdev/net/c/54f1944ed6d2
  - [net,3/3] mptcp: fix abba deadlock on fastopen
    https://git.kernel.org/netdev/net/c/fa9e57468aa1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


