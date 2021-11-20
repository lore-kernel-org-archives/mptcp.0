Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB242C87
	for <mptcp@lists.linux.dev>; Sat, 20 Nov 2021 14:30:09 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id 367B660EB6;
	Sat, 20 Nov 2021 14:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1637418609;
	bh=M62l5V/1BeqynnU8skdniMlIN8KUQWZNjEHcNLzqIJA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cP/ZW4AOfJd+2FVvgbN4xNM7WFpNUIPJ36FFc8jOHzp1N3wys5fCuKiTLFRBYLRie
	 A+PIRqUOj8Z1b20PLFFxIoepOB2QXnB79DFha/etC8GinDvdgitTb/FbwCLonuBP1L
	 43Uf+XhgWZvL2KBa473JRV/BOLjsxlOF0ClfIksiGJRMM7M67Fbsw050wCO/bUf32q
	 ULF8UTYzVf9xHeSS36CxF2l08ALxoJnXJ1HQ2oJgd0bSBcPwzXtlZLrK3eUmAzPBtT
	 SyNpRiVgK0AcMHKMlgt7i0LLT0udl+bafvprQAYRxI2FhB/WdHFDFwdM1dauRHcFNM
	 p30zTMSIA/DsA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 2A29E609D9;
	Sat, 20 Nov 2021 14:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] mptcp: fix 3rd ack rtx timer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <163741860916.5842.15570006728892792463.git-patchwork-notify@kernel.org>
Date: Sat, 20 Nov 2021 14:30:09 +0000
References: <cover.1637331462.git.pabeni@redhat.com>
In-Reply-To: <cover.1637331462.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, edumazet@google.com

Hello:

This series was applied to netdev/net.git (master)
by David S. Miller <davem@davemloft.net>:

On Fri, 19 Nov 2021 15:27:53 +0100 you wrote:
> Eric noted that the MPTCP code do the wrong thing to schedule
> the MPJ 3rd ack timer. He also provided a patch to address the
> issues (patch 1/2).
> 
> To fix for good the MPJ 3rd ack retransmission timer, we additionally
> need to set it after the current ack is transmitted (patch 2/2)
> 
> [...]

Here is the summary with links:
  - [net,1/2] mptcp: fix delack timer
    https://git.kernel.org/netdev/net/c/ee50e67ba0e1
  - [net,2/2] mptcp: use delegate action to schedule 3rd ack retrans
    https://git.kernel.org/netdev/net/c/bcd97734318d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


