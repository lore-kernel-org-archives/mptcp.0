Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795287609;
	b=XfMJjOBSAuTPzHqpSys7TvUUOm2ikUWGqzXDeEzW3AuTIYvEXNgndS8I7FzL1uxEqTx1
	 zEUWYMJBRYiI1bf87a9RaSg35Aw7iIQkvBPCdRVN7jAJO9A5VnSOtfBd6vxuvrCia7nse
	 Hxpa+D2XKp/jPZRKG2EX5umsfuZ4Wv9dBZyvkJfUIx8lp6vVpHjyBGLxBc3t9OzRFwXIZ
	 CHQLDVMEaJd6N60IENfc3bJY6gHs7X+EC8Kux0CNPhTbiZqqKEgZ1yNZb3/yggxZD7VPw
	 3Tvx1fYvPcOf8A202OARU6oDPxK5gDH1wdQplLtu3GzfatNcX5vNJqNmd6jA2iSZntA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795287609;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=WNCoDopreBHkVaGAaMj4COO/opISMiwUHX4fY3SrY84=;
	b=IojVA6iNMIme+Cx+LPcotuEBNzgF/sps4vdUOeunRS4In5/wfVZc2QfL5PJ3Casy9EBU
	 anCgit+g71QTjL8B57Rmd30G3b5V/CNbVgxSFAHz6W8KBNYpawUC2VhPJfoF1bJekQ741
	 4RsS9j8lYREZB92ZeXqAX0DBrZi0peYnpdkoOMf7Y+7eDDoBIzj5qVj37chmpeB8xLZxE
	 6B7wBxyQV8l2+YnZxDxhto2wBuviQ/ULlg+adXwOdelQ5vgjZs6482xPYODVDJyMRMF36
	 H+kpRwHpJo0Q062shlx0gTzC6w3CzYJHxIWP2ATdJTZ0LFUXisURgsRdqPUYpGGC2ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F9F5i6w7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B189606A32A;
	Sat, 21 Nov 2026 19:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F9F5i6w7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFA411F000C6;
	Sat, 21 Nov 2026 19:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795287608;
	bh=WNCoDopreBHkVaGAaMj4COO/opISMiwUHX4fY3SrY84=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=F9F5i6w752bttkQ1E4VKRbwFIbxV2y10JuRqwyKPhuOqomTAswbdfuKExncd7ku9C
	 8OrOBZ1IS1fPNlsHGuv5gR1ioIkwniOUllQCvTXTPC1JIjeK+KR6YyE3zRjtcPz9px
	 A2cu3IATYdobXQSpI8s5vDKJURSLTQS2ndjlfptYdU6j/YeC9hNRypySmR1WmxLTm2
	 u160IQdOXEXNBcdYM4x6i+q8Yzh9ZhCrdEkohiU/vCik19hA0UTra58ShIcs4wMfWk
	 P2dO1HB5QJrmNTtFL1JT9TQ3vLKrpIjqvYeVxcbAlFPkwQRbnpIJgxkISIS4JgqFgl
	 MoxPxJvZia+Bg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B4411391B058;
	Sat, 21 Nov 2026 19:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next 0/7] tcp: Prevent tcp_collapse() from bloating
 queue.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179528760727.1134970.10053232781756812207.git-patchwork-notify@kernel.org>
Date: Sat, 21 Nov 2026 19:00:07 +0000
References: <20261119071649.374106-1-kuniyu@google.com>
In-Reply-To: <20261119071649.374106-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: edumazet@kernel.org, ncardwell@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, matttbe@kernel.org, martineau@kernel.org,
 horms@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org,
 mptcp@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Nov 2026 07:15:52 +0000 you wrote:
> This is a follow-up for commit 031c403d13e5 ("tcp: do not let
> tcp_collapse() drive sk_forward_alloc negative").
> 
> The core algorithm in tcp_collapse() is so simple and has not
> been changed since commit 1da177e4c3f4 ("Linux-2.6.12-rc2");
> finding a collapsible skb and repacking it into up-to-SKB_MAX_ORDER()
> skb.
> 
> [...]

Here is the summary with links:
  - [v3,net-next,1/7] tcp: Refactor the first loop in tcp_collapse().
    https://git.kernel.org/netdev/net-next/c/4243888962b8
  - [v3,net-next,2/7] tcp: Don't collapse high density skb.
    https://git.kernel.org/netdev/net-next/c/0a3f65cdf433
  - [v3,net-next,3/7] tcp: Stop collapsing if not bloated.
    https://git.kernel.org/netdev/net-next/c/aff9a5a36670
  - [v3,net-next,4/7] tcp: Skip collapsing if collapsed skb is less-dense.
    https://git.kernel.org/netdev/net-next/c/c4fef895b429
  - [v3,net-next,5/7] tcp: Allocate all new skb before collapsing.
    https://git.kernel.org/netdev/net-next/c/94b6d61f13d2
  - [v3,net-next,6/7] tcp: Batch memory accounting in tcp_collapse().
    https://git.kernel.org/netdev/net-next/c/05e936e48791
  - [v3,net-next,7/7] selftest: packetdrill: Add test for tcp_collapse().
    https://git.kernel.org/netdev/net-next/c/7042d186bf6c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


