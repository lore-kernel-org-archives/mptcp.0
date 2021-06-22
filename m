Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7AB70
	for <mptcp@lists.linux.dev>; Tue, 22 Jun 2021 17:20:07 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id BA83F61166;
	Tue, 22 Jun 2021 17:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1624382406;
	bh=G8SwRdrNfFWAtgty2CMe5CPAiGxUcoeW2R3uDoGRQFo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sFUjJgiKDkZ1ENMSvN4UWV1oMti282bIyKy+Og5DW0Q6QJjLdlZBL626JWmmkcF6F
	 LoutYpRuKm0tJ6h2bQW00Ld/4h3dmpnoHuV6rdPANUfYjaCrGOQSy2jJrpzIupM7P0
	 IoW7hROjwdlK/O/LGlkM87Sr3+ZWh52dhxx1nHXle4w/DkF+Z44dI2BZmmvTRUdFeC
	 U1KupcMzXi4iZBpshfa1iPir+iRLTGFV7gthyIjz0cpGQ01ALRDzVHvTBQe5loKaCN
	 VGArKyAQx2CyHlyYuqU+XgMhntnP1FnNV3HVBpDY70BqBMFRTta1K0PdjZZ7wAh94X
	 J2CFvZLsN5RXg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id AC4B760BE1;
	Tue, 22 Jun 2021 17:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/6] mptcp: A few optimizations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <162438240670.16834.12302924838036649608.git-patchwork-notify@kernel.org>
Date: Tue, 22 Jun 2021 17:20:06 +0000
References: <20210621225438.10777-1-mathew.j.martineau@linux.intel.com>
In-Reply-To: <20210621225438.10777-1-mathew.j.martineau@linux.intel.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 matthieu.baerts@tessares.net, mptcp@lists.linux.dev, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (refs/heads/master):

On Mon, 21 Jun 2021 15:54:32 -0700 you wrote:
> Here is a set of patches that we've accumulated and tested in the MPTCP
> tree.
> 
> 
> Patch 1 removes the MPTCP-level tx skb cache that added complexity but
> did not provide a meaningful benefit.
> 
> [...]

Here is the summary with links:
  - [net-next,1/6] mptcp: drop tx skb cache
    https://git.kernel.org/netdev/net-next/c/8ce568ed06ce
  - [net-next,2/6] mptcp: use fast lock for subflows when possible
    https://git.kernel.org/netdev/net-next/c/75e908c33615
  - [net-next,3/6] mptcp: don't clear MPTCP_DATA_READY in sk_wait_event()
    https://git.kernel.org/netdev/net-next/c/3c90e377a1e8
  - [net-next,4/6] mptcp: drop redundant test in move_skbs_to_msk()
    https://git.kernel.org/netdev/net-next/c/8cfc47fc2eb0
  - [net-next,5/6] mptcp: add MIB counter for invalid mapping
    https://git.kernel.org/netdev/net-next/c/06285da96a1c
  - [net-next,6/6] selftests: mptcp: display proper reason to abort tests
    https://git.kernel.org/netdev/net-next/c/a4debc4772f4

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


