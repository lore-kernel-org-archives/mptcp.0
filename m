Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E835717CB
	for <mptcp@lists.linux.dev>; Thu, 20 Apr 2023 01:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E2A7C4339B;
	Thu, 20 Apr 2023 01:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681953619;
	bh=cUhuCvPhroNyQnQ2OJdCz6xKlSKs6UytLRLgLLlH2MA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ejoz/bo4tzp2q6HsLJ/3nZjxPYk6JeTG+CRDmouX24R1hw2k1xfyu4Fithv2q3Nb8
	 CNZ6Sp4db76biMX7G+cWApxYzoTHtmD1uJ6FvdCqEEMoh6lloMPlCyXVQu3TFNniwk
	 dhn0xETCUaecaX69hHs7/Wpu7BIDZoqgG+6CCHy3MKtkhswLQwjY2hWUyRTBkNiqln
	 3JAaXpD46zCv5xotmIRC+E41Vkfhx38qiTUl4FWiso2ILsFjXe8/UsOjv0LZPRR5qW
	 psHqsMZW7LF5Qr39qFiLyqzog0MgXbL0Mi42DJOo12dhMloeYFyYRuWeyY7dQf7FP7
	 3GrEBWtAopn6Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6009BC395EA;
	Thu, 20 Apr 2023 01:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] MAINTAINERS: Resume MPTCP co-maintainer role
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168195361938.31134.13530843113629049903.git-patchwork-notify@kernel.org>
Date: Thu, 20 Apr 2023 01:20:19 +0000
References: <20230418231318.115331-1-martineau@kernel.org>
In-Reply-To: <20230418231318.115331-1-martineau@kernel.org>
To: Mat Martineau <martineau@kernel.org>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, matthieu.baerts@tessares.net,
 mptcp@lists.linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Apr 2023 16:13:18 -0700 you wrote:
> I'm returning to the MPTCP maintainer role I held for most of the
> subsytem's history. This time I'm using my kernel.org email address.
> 
> Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Link: https://lore.kernel.org/mptcp/af85e467-8d0a-4eba-b5f8-e2f2c5d24984@tessares.net/
> Signed-off-by: Mat Martineau <martineau@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] MAINTAINERS: Resume MPTCP co-maintainer role
    https://git.kernel.org/netdev/net/c/52b37ae8aa67

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


