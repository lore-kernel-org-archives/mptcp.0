Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E438362D
	for <mptcp@lists.linux.dev>; Fri, 17 Mar 2023 04:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF32DC433D2;
	Fri, 17 Mar 2023 04:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1679026817;
	bh=L5Aa2P6KyX+9n5Ovj/1x5PvpJjrFrMKcg47rBO5Kej4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Om+X9BipnVQqWCF0v1qKiqpieJ/pdB/D/fgnxwmPICMgwiqYFHUfay90r2jMqv2b7
	 bcN3iwNBVkS7XEY+ARUgzuUuZeA68NhNbCHWiA3iy4kymWnyAAm8g57LRdk0pNYAMb
	 oteUJp0y5kBO9JlpZ1wNJUADawz7ghjB5hiowjoLLGa/sNj+3YvGaA9vlosWaCkRs+
	 vYU0EExIgY+hCoVaPDZH4eSCbEfremo8yQqU+iPeM+LveLw3U/mNqPdrTbjVBYYuVe
	 D7cNJIsNin5kEdk7+viGwvP/BJV5+jK4r0RT8VOT0E4BNoxsp5OWNwzQC2jTiUYiHs
	 6SRg6Bya6hJ8g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 87DA9E21EE8;
	Fri, 17 Mar 2023 04:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] hsr: ratelimit only when errors are printed
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <167902681755.31268.12287293857205816634.git-patchwork-notify@kernel.org>
Date: Fri, 17 Mar 2023 04:20:17 +0000
References: <20230315-net-20230315-hsr_framereg-ratelimit-v1-1-61d2ef176d11@tessares.net>
In-Reply-To: <20230315-net-20230315-hsr_framereg-ratelimit-v1-1-61d2ef176d11@tessares.net>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, koverskeid@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 15 Mar 2023 21:25:17 +0100 you wrote:
> Recently, when automatically merging -net and net-next in MPTCP devel
> tree, our CI reported [1] a conflict in hsr, the same as the one
> reported by Stephen in netdev [2].
> 
> When looking at the conflict, I noticed it is in fact the v1 [3] that
> has been applied in -net and the v2 [4] in net-next. Maybe the v1 was
> applied by accident.
> 
> [...]

Here is the summary with links:
  - [net] hsr: ratelimit only when errors are printed
    https://git.kernel.org/netdev/net/c/1b0120e4db0b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


