Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C322C82
	for <mptcp@lists.linux.dev>; Thu, 28 Oct 2021 15:40:08 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id 7E92A610F8;
	Thu, 28 Oct 2021 15:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1635435608;
	bh=Tapv7ybfn6Q4YZF8/5VxwTZG869/SCOKMkK7j+av4Mk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FTp++T2G9/L6fhOyYsQR2Y3cdevQ4j/HtdqJrenCEhVMGYOHL2ht/s4dPdUjDUDeb
	 fo4mQeAjC4R8vBUzF1X1ki6KVLB/9/tN7BlLxZsz/RzrnR3RhHS2qK1ghg6M0WFeIZ
	 Hq1aehFykx7NAmxxQpSQ3QVvTlFaHPfTCQwFJjTvxItPrGgenVk7djXKm8D+oh8cf3
	 aI8KCpJX3J57CynHbyfendLxgYgm73uRxftrgNR54y+gTUJyDwWOxoxQibtayVvg+S
	 AMBthM5HLEsOMTyG+nmrWsxfWJn5cSfMTJRNy8kyN5LTz0aZehbOoWPZuX4+ufkTi4
	 2gOBGNEL/1+vQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 764D960972;
	Thu, 28 Oct 2021 15:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] mptcp: fix corrupt receiver key in MPC + data + checksum
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <163543560847.29178.15602372618455610510.git-patchwork-notify@kernel.org>
Date: Thu, 28 Oct 2021 15:40:08 +0000
References: <20211027203855.264600-1-mathew.j.martineau@linux.intel.com>
In-Reply-To: <20211027203855.264600-1-mathew.j.martineau@linux.intel.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: netdev@vger.kernel.org, dcaratti@redhat.com, davem@davemloft.net,
 kuba@kernel.org, matthieu.baerts@tessares.net, pabeni@redhat.com,
 mptcp@lists.linux.dev, psonparo@redhat.com

Hello:

This patch was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 27 Oct 2021 13:38:55 -0700 you wrote:
> From: Davide Caratti <dcaratti@redhat.com>
> 
> using packetdrill it's possible to observe that the receiver key contains
> random values when clients transmit MP_CAPABLE with data and checksum (as
> specified in RFC8684 §3.1). Fix the layout of mptcp_out_options, to avoid
> using the skb extension copy when writing the MP_CAPABLE sub-option.
> 
> [...]

Here is the summary with links:
  - [net] mptcp: fix corrupt receiver key in MPC + data + checksum
    https://git.kernel.org/netdev/net/c/f7cc8890f30d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


