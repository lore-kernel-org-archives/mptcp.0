Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172C92FB1
	for <mptcp@lists.linux.dev>; Tue, 22 Jun 2021 21:50:04 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id 91EC46128E;
	Tue, 22 Jun 2021 21:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1624398604;
	bh=g9LgKtkRSXDgXchVN7V856NOP9+IzTEh/b+J+dTgwyA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q6dftXDbnB0Ed0kNVtsnZagRYeQgydJ8aSYzHT08REjpSFb+Kl0wAulJhkN2gXrOk
	 2EkOggeWHER4+AtkvDEqBX25g0pCeEmFoFyOKFAtopjFQA8V49wElP0JH8KFL4A9jN
	 aX0MlYNYN9vk6+pAu/MFaFoQ6N7DL9buPr4c/nben0MnF92IplLurpqnChXviYZ+Li
	 YZg/s1mrj4wX1F95RVW0C9hnAnSkrneSqVJqKGCGjhsjuJcKDudtTi1itTAEyvTIl/
	 +ZcL/cShYa/PzDF7euXfY9gMEYBIaM91jqxmefa3CagCn0Sa+chJfcdzjHo+Daz7H6
	 Ues2VQDDGMRag==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 858F860A53;
	Tue, 22 Jun 2021 21:50:04 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/6] mptcp: Connection-time 'C' flag and two fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <162439860454.27406.8084748160154709431.git-patchwork-notify@kernel.org>
Date: Tue, 22 Jun 2021 21:50:04 +0000
References: <20210622192523.90117-1-mathew.j.martineau@linux.intel.com>
In-Reply-To: <20210622192523.90117-1-mathew.j.martineau@linux.intel.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 matthieu.baerts@tessares.net, mptcp@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (refs/heads/master):

On Tue, 22 Jun 2021 12:25:17 -0700 you wrote:
> Here are six more patches from the MPTCP tree.
> 
> Most of them add support for the 'C' flag in the MPTCP connection-time
> option headers. This flag affects how the initial address and port are
> treated by each peer. Normally one peer may send MP_JOIN requests to the
> remote address and port that were used when initiating the MPTCP
> connection. The 'C' bit indicates that MP_JOINs should only be sent to
> remote addresses that have been advertised with ADD_ADDR.
> 
> [...]

Here is the summary with links:
  - [net-next,1/6] mptcp: add sysctl allow_join_initial_addr_port
    https://git.kernel.org/netdev/net-next/c/d2f77960e5b0
  - [net-next,2/6] mptcp: add allow_join_id0 in mptcp_out_options
    https://git.kernel.org/netdev/net-next/c/bab6b88e0560
  - [net-next,3/6] mptcp: add deny_join_id0 in mptcp_options_received
    https://git.kernel.org/netdev/net-next/c/df377be38725
  - [net-next,4/6] selftests: mptcp: add deny_join_id0 testcases
    https://git.kernel.org/netdev/net-next/c/0cddb4a6f4e3
  - [net-next,5/6] selftests: mptcp: turn rp_filter off on each NIC
    https://git.kernel.org/netdev/net-next/c/d8e336f77e3b
  - [net-next,6/6] mptcp: refine mptcp_cleanup_rbuf
    https://git.kernel.org/netdev/net-next/c/fde56eea01f9

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


