Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4120336B
	for <mptcp@lists.linux.dev>; Mon, 24 Oct 2022 10:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6F9DC43141;
	Mon, 24 Oct 2022 10:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666607419;
	bh=ai6z823b0G/TUEUZOfcO6d/2MYgy4Oz76tJ+jahceNo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=U6QnNRxUv/gnxf0rhER25b3BlRDMXyktN6KYtfHj/MuQ6a/AbldifZHg1wSX6zn4l
	 75isqEwmu9BO6dfLSM1WomzM5pIMkaabNVmfRQaA/4GpPiZmw5K4u5rl/VhAX4UQVv
	 tjpd7FkldjI3WqMRIwVfpMT02qO0rqNb6Wf62cz2P/whuVCq6ETpOEda2dA5Miwhw9
	 YXgJ6VaqC/sYkRMUpd5QXedZEzQwmvVK2A5Uze5AYRox0KtMbV0vKKJIoXjAdtVGPU
	 3PXH6ygF/AHIWYxK52OT4GM8Z2ibDXOxeZtv0wj+eYFxBvOzO3pTdF/0seWLbm344q
	 5uascItrZgigA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CAA77E4D005;
	Mon, 24 Oct 2022 10:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] udp: avoid false sharing on receive
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <166660741981.18313.518994743736905929.git-patchwork-notify@kernel.org>
Date: Mon, 24 Oct 2022 10:30:19 +0000
References: <cover.1666287924.git.pabeni@redhat.com>
In-Reply-To: <cover.1666287924.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, mptcp@lists.linux.dev, dsahern@kernel.org,
 mathew.j.martineau@linux.intel.com, matthieu.baerts@tessares.net,
 kuniyu@amazon.com

Hello:

This series was applied to netdev/net-next.git (master)
by David S. Miller <davem@davemloft.net>:

On Thu, 20 Oct 2022 19:48:50 +0200 you wrote:
> Under high UDP load, the BH processing and the user-space receiver can
> run on different cores.
> 
> The UDP implementation does a lot of effort to avoid false sharing in
> the receive path, but recent changes to the struct sock layout moved
> the sk_forward_alloc and the sk_rcvbuf fields on the same cacheline:
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: introduce and use custom sockopt socket flag
    https://git.kernel.org/netdev/net-next/c/a5ef058dc4d9
  - [net-next,v2,2/2] udp: track the forward memory release threshold in an hot cacheline
    https://git.kernel.org/netdev/net-next/c/8a3854c7b8e4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


