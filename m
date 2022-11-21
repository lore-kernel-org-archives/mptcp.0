Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3339D3D79
	for <mptcp@lists.linux.dev>; Mon, 21 Nov 2022 13:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3D32C4347C;
	Mon, 21 Nov 2022 13:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1669036216;
	bh=14nDf19iPFoNhtOw7/BsxLX6P7i/fmVxRsZ0ksPhWiY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dz+K6O8ay7/iDjiujdNUVTc/8Nem08JO9wUIgI3Mi2ofBErCOtkKRPvBAH9CHnA4/
	 bdpjGl74ZkZJVyW/YPVMiJAsdgFQSnlN2WRAYK2DttboFe0KIqsCq34hM/hAGTpgNc
	 CAqWQgr0aGolzocV6QPGE1DZ23NbS93YxPb+0oHh5wL4odiUpSV3WA3m+hKHisD1Y4
	 6gkP3BM+PftQc2/P7UIkpWz4jevEvfn+ui5e7OS8QGFGdhSH2axENwr2URTQ8GaDW+
	 itQqtpc5YGtkJSr3bDIVUi0WI8fWbSyB8ARcYm7uyl1BrPo5a6sczdi2qCiHQiYYXM
	 oB2/hNrr0C3xA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B7959E29F40;
	Mon, 21 Nov 2022 13:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] mptcp: More specific netlink command errors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <166903621674.4573.13888635392662727952.git-patchwork-notify@kernel.org>
Date: Mon, 21 Nov 2022 13:10:16 +0000
References: <20221118184608.187932-1-mathew.j.martineau@linux.intel.com>
In-Reply-To: <20221118184608.187932-1-mathew.j.martineau@linux.intel.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, matthieu.baerts@tessares.net,
 mptcp@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (master)
by David S. Miller <davem@davemloft.net>:

On Fri, 18 Nov 2022 10:46:06 -0800 you wrote:
> This series makes the error reporting for the MPTCP_PM_CMD_ADD_ADDR netlink
> command more specific, since there are multiple reasons the command could
> fail.
> 
> Note that patch 2 adds a GENL_SET_ERR_MSG_FMT() macro to genetlink.h,
> which is outside the MPTCP subsystem.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] mptcp: deduplicate error paths on endpoint creation
    https://git.kernel.org/netdev/net-next/c/976d302fb616
  - [net-next,2/2] mptcp: more detailed error reporting on endpoint creation
    https://git.kernel.org/netdev/net-next/c/a3400e8746b6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


