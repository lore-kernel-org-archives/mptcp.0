Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67402564
	for <mptcp@lists.linux.dev>; Mon,  9 Jan 2023 07:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F260C433D2;
	Mon,  9 Jan 2023 07:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1673250616;
	bh=4EV8j06jNAysTNwT7QnsTd7fUSkfhFkqY3kz0qBGcjg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AuNNG35vj00B4eAeLbQZ1HyrRcKvjJkTxkLlRlVr6MZ4onxUWQc9kebK9KK4qvAlY
	 92F89A2BFibiP+DJc9NQASa7+15gmLVP+AkfCHFhNaFnYXWZrCFfC/I3PZkvdXqjTX
	 wGZDICKvnhodnY6NFMBVOdhCGnhg3qwgNcOQ7z7e6DFdj+cNVn4ixd8j8I5vqidtr1
	 3etywQs95oeJHtf4w5MbD0vxfhjO2MltxJtADHvMK4uG3ofdBJp96qxsaMX3XGkhTI
	 tXfk/N41UyhjAVatLeYmfagBnpTYaLuKJ6gQ9WIcHt0757usOGKmwO7DKVAZT9/XX3
	 MWeTRDM6iOKjA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5D3DDE21EE6;
	Mon,  9 Jan 2023 07:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/9] mptcp: Protocol in-use tracking and code cleanup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <167325061637.1839.14365861753264546033.git-patchwork-notify@kernel.org>
Date: Mon, 09 Jan 2023 07:50:16 +0000
References: <20230106185725.299977-1-mathew.j.martineau@linux.intel.com>
In-Reply-To: <20230106185725.299977-1-mathew.j.martineau@linux.intel.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, matthieu.baerts@tessares.net,
 mptcp@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (master)
by David S. Miller <davem@davemloft.net>:

On Fri,  6 Jan 2023 10:57:16 -0800 you wrote:
> Here's a collection of commits from the MPTCP tree:
> 
> Patches 1-4 and 6 contain miscellaneous code cleanup for more consistent
> use of helper functions, existing local variables, and better naming.
> 
> Patches 5, 7, and 9 add sock_prot_inuse tracking for MPTCP and an
> associated self test.
> 
> [...]

Here is the summary with links:
  - [net-next,1/9] mptcp: use msk_owned_by_me helper
    https://git.kernel.org/netdev/net-next/c/109cdeb8dfa3
  - [net-next,2/9] mptcp: use net instead of sock_net
    https://git.kernel.org/netdev/net-next/c/a963853fd465
  - [net-next,3/9] mptcp: use local variable ssk in write_options
    https://git.kernel.org/netdev/net-next/c/3c976f4c9923
  - [net-next,4/9] mptcp: introduce 'sk' to replace 'sock->sk' in mptcp_listen()
    https://git.kernel.org/netdev/net-next/c/cfdcfeed6449
  - [net-next,5/9] mptcp: init sk->sk_prot in build_msk()
    https://git.kernel.org/netdev/net-next/c/ade4d754620f
  - [net-next,6/9] mptcp: rename 'sk' to 'ssk' in mptcp_token_new_connect()
    https://git.kernel.org/netdev/net-next/c/294de9090938
  - [net-next,7/9] mptcp: add statistics for mptcp socket in use
    https://git.kernel.org/netdev/net-next/c/c558246ee73e
  - [net-next,8/9] selftest: mptcp: exit from copyfd_io_poll() when receive SIGUSR1
    https://git.kernel.org/netdev/net-next/c/4a753ca5013d
  - [net-next,9/9] selftest: mptcp: add test for mptcp socket in use
    https://git.kernel.org/netdev/net-next/c/e04a30f78809

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


