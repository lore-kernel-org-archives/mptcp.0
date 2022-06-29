Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD9E62A
	for <mptcp@lists.linux.dev>; Wed, 29 Jun 2022 05:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E33EC341CA;
	Wed, 29 Jun 2022 05:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1656480013;
	bh=wVaA/zaGrgkeDZVTa1fVbkBtdiqSj69Zp6MvjMQn6+g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c6mTJFvA9MsqU9eOMb/sRIeBu/O0UGiwWKV+YjsOiAo+123DvyBiPYtCRAAd6PVo1
	 zvOerCGLy+q6mlW2PqNvw3Ocd+1ymArOaYOJZbWnh+3E26D1AL32DgIOqR9XlK2V5O
	 WqTw2ebp/NuZghwiBxlsZqla1VyNB910H29Mkod06fqWjPMPy8P0jgW+AqBXWOGw3Q
	 f1vS1C5J2s4//Dad30ec0iGADomGCMq0d6vs/SSVUylUKHPzLwFB8/1L4IjPfUgv0a
	 4/SSPbVQ7YggTRdiahntf1D9KjsRIJK1WfOrnivmi6rGxMaZMhi7bBPXZDVh1fDU2U
	 5ieRjgzbt8XvQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7CB1FE49BBA;
	Wed, 29 Jun 2022 05:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: mptcp: fix some spelling mistake in mptcp
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <165648001350.19091.5869614487710926226.git-patchwork-notify@kernel.org>
Date: Wed, 29 Jun 2022 05:20:13 +0000
References: <20220627121626.1595732-1-imagedong@tencent.com>
In-Reply-To: <20220627121626.1595732-1-imagedong@tencent.com>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: kuba@kernel.org, mathew.j.martineau@linux.intel.com,
 matthieu.baerts@tessares.net, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, imagedong@tencent.com

Hello:

This patch was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 Jun 2022 20:16:25 +0800 you wrote:
> From: Menglong Dong <imagedong@tencent.com>
> 
> codespell finds some spelling mistake in mptcp:
> 
> net/mptcp/subflow.c:1624: interaces ==> interfaces
> net/mptcp/pm_netlink.c:1130: regarless ==> regardless
> 
> [...]

Here is the summary with links:
  - [net-next] net: mptcp: fix some spelling mistake in mptcp
    https://git.kernel.org/netdev/net-next/c/d640516a65d8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


