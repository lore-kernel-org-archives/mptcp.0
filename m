Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE55173
	for <mptcp@lists.linux.dev>; Thu, 10 Jun 2021 23:50:05 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id AF22E6136D;
	Thu, 10 Jun 2021 23:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1623369004;
	bh=M5Nz2vtUtdEGenomEodqoNwmIRw3fW7KINR3BmvekwE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NbHoMpm2CKGbmS7XpAjIO34PhvCy8A8TL+jeHwJtfbcEqW5Wq23AfgV8vNiKW7CWd
	 hBY6l++8MhGYeuTH8ezKbz3Tk2c3OMhZlrMRmz5+dWS+gnQmSK33hkwBdrEEXy3yUQ
	 97v7aL3FVXN9ZxzuToKeblGPArjPMa5YPjjac1mP6Dkl1V975w+76v71FEejur9N/n
	 Vm+529b89SHCuBoaYAEIaRBsI3lrTq4eupGXp/+229FWNH9eu0IEAMWYgCvEQYyQxg
	 KlVmED11W3xkGgpzfKSUoDcKXLrrIxy1No/6pw2ukBcnYBKK+tW9U+RHO9tORZk0J8
	 l+u5bWGtb0a8g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A1E8160A49;
	Thu, 10 Jun 2021 23:50:04 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5] mptcp: More v5.13 fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <162336900465.18265.8641665537042878923.git-patchwork-notify@kernel.org>
Date: Thu, 10 Jun 2021 23:50:04 +0000
References: <20210610225944.351224-1-mathew.j.martineau@linux.intel.com>
In-Reply-To: <20210610225944.351224-1-mathew.j.martineau@linux.intel.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 matthieu.baerts@tessares.net, mptcp@lists.linux.dev

Hello:

This series was applied to netdev/net.git (refs/heads/master):

On Thu, 10 Jun 2021 15:59:39 -0700 you wrote:
> Here's another batch of MPTCP fixes for v5.13.
> 
> Patch 1 cleans up memory accounting between the MPTCP-level socket and
> the subflows to more reliably transfer forward allocated memory under
> pressure.
> 
> Patch 2 wakes up socket readers more reliably.
> 
> [...]

Here is the summary with links:
  - [net,1/5] mptcp: try harder to borrow memory from subflow under pressure
    https://git.kernel.org/netdev/net/c/72f961320d5d
  - [net,2/5] mptcp: wake-up readers only for in sequence data
    https://git.kernel.org/netdev/net/c/99d1055ce246
  - [net,3/5] mptcp: do not warn on bad input from the network
    https://git.kernel.org/netdev/net/c/61e710227e97
  - [net,4/5] selftests: mptcp: enable syncookie only in absence of reorders
    https://git.kernel.org/netdev/net/c/2395da0e1793
  - [net,5/5] mptcp: fix soft lookup in subflow_error_report()
    https://git.kernel.org/netdev/net/c/499ada507336

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


