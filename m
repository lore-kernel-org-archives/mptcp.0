Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE59EA4
	for <mptcp@lists.linux.dev>; Tue, 24 Jan 2023 05:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0323AC4339C;
	Tue, 24 Jan 2023 05:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1674539418;
	bh=rFplY8wVoaP6NnJmu31njf396jT+MmzMtEyKOa68tNs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KGdgs0PxCxSEab94NKps09IhXLGdXIf0smvm8PSAVWnQCVgzgoxUKnf6vmtn3UVJO
	 67criK49EJGrchfiS/LqOn7UAOObzcbQXr9uUUWId2zgl1dtaoED+trcRwC/SPsMES
	 L53Mr5dnnSPmQML2XoUlwIAHsxacQ0lIM1SqznSvBYnV5u+GS6k+xyNJCWXe0lRVZg
	 8vIsIGpL4i19Q10GaX2TgckiE6xjgw8uwpfwW1Xk7Jx2a6mNxvZAjLOgkEMA1o9QOn
	 SgNKS7MUk1Y0GrTjBZApAvxuOBfngxTlj+IXcqyYkNlGEB/l/5a+2I6ydalobocHj6
	 ooZeazPU6IYag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D819EF83ECD;
	Tue, 24 Jan 2023 05:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: Update MPTCP maintainer list and CREDITS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <167453941788.4419.9662628324991224049.git-patchwork-notify@kernel.org>
Date: Tue, 24 Jan 2023 05:50:17 +0000
References: <20230120231121.36121-1-mathew.j.martineau@linux.intel.com>
In-Reply-To: <20230120231121.36121-1-mathew.j.martineau@linux.intel.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, matthieu.baerts@tessares.net,
 mptcp@lists.linux.dev

Hello:

This patch was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 20 Jan 2023 15:11:21 -0800 you wrote:
> My responsibilities at Intel have changed, so I'm handing off exclusive
> MPTCP subsystem maintainer duties to Matthieu. It has been a privilege
> to see MPTCP through its initial upstreaming and first few years in the
> upstream kernel!
> 
> Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> 
> [...]

Here is the summary with links:
  - [net] MAINTAINERS: Update MPTCP maintainer list and CREDITS
    https://git.kernel.org/netdev/net/c/bce4affe30b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


