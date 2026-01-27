Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE8178F2E;
	Tue, 27 Jan 2026 04:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769486413; cv=none; b=k5JeMuXO9bwB0e+Vb4Fq6d2XlBXTWwYA+14WtdGcvHyBKL2u9+DyryjI4v9YWjvN1zhdRuoR1UodC5sOeQIa2nvOpXX6vb884+qRtJuHsw6/dQDcOMd6VVIuuqLQ16lA5grVnVkl1ValbNn2zDMHFhuuE/kFN1IPGICeB7TEGjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769486413; c=relaxed/simple;
	bh=bdQkF2C+ds3TmH+f9x4b4QUGAprGzihWboTmF1fauOY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F0x7zpVJ99aYIVCzVdrawcLftPBCl/cIP/gChh6odVkN6gihTVPV72Dh7sYukPdudBWLlCaqlCIHezY+rSE3nh1rrYJwOONVGPl66gznFiu3Ricp5jMlgXrZt5SWHNiW0QkMQWF0fIa6u+p54DthjLe9nnal0F6P7yrJ6vnRTDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqmCJ7s/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqmCJ7s/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1792C116C6;
	Tue, 27 Jan 2026 04:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769486413;
	bh=bdQkF2C+ds3TmH+f9x4b4QUGAprGzihWboTmF1fauOY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YqmCJ7s/4atxRyam1jQKDsgnnOyION1oRwr0cN9yTy/82txPoyyXdbvJd0EQFKWM1
	 riwEacMV/JfCL0+Isr5xrPOY9qBCAowIJfmaCMFdQcy/pzdZd5lRwE4lLM3nIRoTKe
	 4v8OlPqEjtWL7RfVnKznoQusH8yrO5sDCQT56WbIgFs8aakY5Uesv0n2bzcu5cBIZv
	 2+SP4YwnyjLrkGxGH0OJRnqflxHBuGoynmUJxYdp67HAfxTYmYa/sGDvj/F1nS8Gqv
	 J3rNsPCwwzxzRu//tUIlcvkjXfMY2YdboRtsIFM7BQoDRFgpYepb1DXI9EHxJg401C
	 T6WmreIpWNgwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 11B09380A961;
	Tue, 27 Jan 2026 04:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] mptcp: fix race in mptcp_pm_nl_flush_addrs_doit()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176948640786.677485.2957866694713613177.git-patchwork-notify@kernel.org>
Date: Tue, 27 Jan 2026 04:00:07 +0000
References: 
 <20260124-net-mptcp-race_nl_flush_addrs-v3-1-b2dc1b613e9d@kernel.org>
In-Reply-To: 
 <20260124-net-mptcp-race_nl_flush_addrs-v3-1-b2dc1b613e9d@kernel.org>
To: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 syzbot+5498a510ff9de39d37da@syzkaller.appspotmail.com, eulgyukim@snu.ac.kr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 24 Jan 2026 11:59:18 +0100 you wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> syzbot and Eulgyu Kim reported crashes in mptcp_pm_nl_get_local_id()
> and/or mptcp_pm_nl_is_backup()
> 
> Root cause is list_splice_init() in mptcp_pm_nl_flush_addrs_doit()
> which is not RCU ready.
> 
> [...]

Here is the summary with links:
  - [net,v3] mptcp: fix race in mptcp_pm_nl_flush_addrs_doit()
    https://git.kernel.org/netdev/net/c/e2a9eeb69f7d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


