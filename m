Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7097215A9
	for <mptcp@lists.linux.dev>; Thu, 22 Dec 2022 02:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E343EC433F2;
	Thu, 22 Dec 2022 02:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1671675017;
	bh=eCEg3Qw2EO+D/FDoDFYwgmonbMtJaZzu40BAhaaB4+g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AsbszxtUIfKxCN78ZZN79x1rok1zP8SfDgXHG9c7nD0kOkDxK6TptKFRKSqmcgtoB
	 AqBvZME/Ix/8nNVYNkHzacX2AY/AM0vh2C+xwYeAFfTDfxlzUP/HP5l+64cmFHuihV
	 Tdvqv3Efz+bD2x3QxtwcMVBVLPNLovs9lKUQKWZ4SWZ8VA9aUWr+7Q/bkWCvehPhbo
	 1yvj+5p5uVpWpKoF9qQtf3DGG5LDLpiT6La9qLQhpkVva4bix2Erk/4OIN1e4rr9RJ
	 P+we0i8mglW4RaKT8Vm8EekaEotg3P+9xgsOs2LbIQ44iRKv11t+pQi/dhv0pguJQ0
	 mDecBGhdJR+rQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C7DF3C74000;
	Thu, 22 Dec 2022 02:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] mptcp: Locking fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <167167501681.18442.13030546934783703967.git-patchwork-notify@kernel.org>
Date: Thu, 22 Dec 2022 02:10:16 +0000
References: <20221220195215.238353-1-mathew.j.martineau@linux.intel.com>
In-Reply-To: <20221220195215.238353-1-mathew.j.martineau@linux.intel.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, imagedong@tencent.com,
 mptcp@lists.linux.dev

Hello:

This series was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Dec 2022 11:52:13 -0800 you wrote:
> Two separate locking fixes for the networking tree:
> 
> Patch 1 addresses a MPTCP fastopen error-path deadlock that was found
> with syzkaller.
> 
> Patch 2 works around a lockdep false-positive between MPTCP listening and
> non-listening sockets at socket destruct time.
> 
> [...]

Here is the summary with links:
  - [net,1/2] mptcp: fix deadlock in fastopen error path
    https://git.kernel.org/netdev/net/c/7d803344fdc3
  - [net,2/2] mptcp: fix lockdep false positive
    https://git.kernel.org/netdev/net/c/fec3adfd754c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


