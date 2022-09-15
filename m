Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033033FC7
	for <mptcp@lists.linux.dev>; Thu, 15 Sep 2022 10:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9344BC433D7;
	Thu, 15 Sep 2022 10:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1663237216;
	bh=Fy7zGKizMAtafW7WGQvD+WirHAwSowXg6atgykgL4Xo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VjH5UptfxSLqE9BGC4W4WXWbF7gXwJg6/N0XHqrsqEdU1vRlO6Fl7kN83KQwarGq5
	 hEkCFimzSvwglI0O4ZC7c0CzqZ34mDSDk6Hx8EMnkooTzQ503MJruF57kDl7/jCNUb
	 hXKdeWAByUVqxCwjL64Te9dR/Yt397beUtbXahQL0LVmXXvHBS2S438IL1XIewHbBV
	 PsyMt1BaKUhY/IscO7hnh2NjGG40JgdAQ1vgHI2raq3ziymnR78aKmYVgDHYPu7Ap7
	 yxd8wuyPc49EKxpJlol9sPOItJFk3RBu7PGzqSP4SzUbwDm8R0nUWnhslAL2e2mskg
	 upUrxYDfbPxKw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 75FFBC73FE5;
	Thu, 15 Sep 2022 10:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] mptcp: allow privileged operations from user ns
 & cleanup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <166323721647.17439.5951142665130976319.git-patchwork-notify@kernel.org>
Date: Thu, 15 Sep 2022 10:20:16 +0000
References: <20220906205545.1623193-1-matthieu.baerts@tessares.net>
In-Reply-To: <20220906205545.1623193-1-matthieu.baerts@tessares.net>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 mathew.j.martineau@linux.intel.com, pabeni@redhat.com, shuah@kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 mptcp@lists.linux.dev, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (master)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  6 Sep 2022 22:55:38 +0200 you wrote:
> This series allows privileged Netlink operations from user namespaces. When a
> non-root user configures MPTCP endpoints, the memory allocation is now accounted
> to this user. See patches 4 and 5.
> 
> Apart from that, there are some cleanup:
> 
>  - Patch 1 adds a macro to improve code readability
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] mptcp: add mptcp_for_each_subflow_safe helper
    https://git.kernel.org/netdev/net-next/c/5efbf6f7f076
  - [net-next,2/5] selftests: mptcp: move prefix tests of addr_nr_ns2 together
    https://git.kernel.org/netdev/net-next/c/a1c3bdd9c5df
  - [net-next,3/5] mptcp: add do_check_data_fin to replace copied
    https://git.kernel.org/netdev/net-next/c/0522b424c4c2
  - [net-next,4/5] mptcp: allow privileged operations from user namespaces
    https://git.kernel.org/netdev/net-next/c/d15697185404
  - [net-next,5/5] mptcp: account memory allocation in mptcp_nl_cmd_add_addr() to user
    https://git.kernel.org/netdev/net-next/c/3eb9a6b6503c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


