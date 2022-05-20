Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDC115AA
	for <mptcp@lists.linux.dev>; Fri, 20 May 2022 03:10:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 096CDC34100;
	Fri, 20 May 2022 03:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1653016212;
	bh=ZzbDwSGbSnuYA+KFiZEaZo3aeo9+qFntGh19X3UYdjI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aFnxFzlPSQxinqeqJyxTDMdTK3fPf70ZEKr5cFzlulI63TbTc/dazuqYF1oNb/f2U
	 nNusFbXI1wohutl7+tCWvm+jtV0SlcMLCQRM0I4Z5DzD4Nx1r+dBIOs5swAr91T8DK
	 XEFvp1a/E/e3iLXVG/dB3gKxEzuIZdrokjyOGs6ySI9Ykq1Zw2gKeKPgUqGVAzISoC
	 2/DR6qgYCbANd+znXqDeGZayqXtu463T+MPwrziSoBmB0og3qgY21wPz+N6af7f8X7
	 rMbPo7qOONT/m8nTh7R4ohTeS8czoy+jqqwGdfC2eNy3ZQ/rc7602lG+ISJ9uSMCAr
	 RZOoxTCuUFpKA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DF842F0389D;
	Fri, 20 May 2022 03:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] mptcp: Miscellaneous fixes and a new test case
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <165301621191.9219.12868236037552729726.git-patchwork-notify@kernel.org>
Date: Fri, 20 May 2022 03:10:11 +0000
References: <20220518220446.209750-1-mathew.j.martineau@linux.intel.com>
In-Reply-To: <20220518220446.209750-1-mathew.j.martineau@linux.intel.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, matthieu.baerts@tessares.net,
 mptcp@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 May 2022 15:04:42 -0700 you wrote:
> Patches 1 and 3 remove helpers that were iterating over the subflow
> connection list without proper locking. Iteration was not needed in
> either case.
> 
> Patch 2 fixes handling of MP_FAIL timeout, checking for orphaned
> subflows instead of using the MPTCP socket data lock and connection
> state.
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] mptcp: stop using the mptcp_has_another_subflow() helper
    https://git.kernel.org/netdev/net-next/c/7b16871f9932
  - [net-next,2/4] mptcp: Check for orphaned subflow before handling MP_FAIL timer
    https://git.kernel.org/netdev/net-next/c/d42f9e4e2384
  - [net-next,3/4] mptcp: Do not traverse the subflow connection list without lock
    https://git.kernel.org/netdev/net-next/c/d9fb797046c5
  - [net-next,4/4] selftests: mptcp: add MP_FAIL reset testcase
    https://git.kernel.org/netdev/net-next/c/2ba18161d407

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


