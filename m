Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361E141754;
	Tue, 12 May 2026 01:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778548846; cv=none; b=ij2SxlvGTJUJx2dRUcBLDd1XrSTMWLPVNvkrGRf16SQLDbceq7God/vdZTxi8hj3KOeQ2qrQxkvlC03bodWJdAa+3iEyduLOozvwUmlPq54DpjvwEnxRsI8LibSigkbbPJuRiuU/dF+SYTijPtERhmfyPCgtK7T4VrLNiQHDv0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778548846; c=relaxed/simple;
	bh=rmhmgjf9pNbch508V7x5oA7WF+QOIlAxgYvbMVZNPDQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Wx2k0fLuD8nNv2QRQWY8e8DPBW2KjRs5owfa7cQrZB0exlXHOEaEytjXDcPajhKWeps5XhZ480aSHxbcOgII0IGxBaGaDJBroG8a2Ll3Yp9b4+7x3/jHWBDle1Ng05F3ZJt0XtkemnAkolacLdYj/g2pqxvfHRoMf/p2FImRWVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZ1uxS59; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZ1uxS59"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3429C2BCB0;
	Tue, 12 May 2026 01:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778548845;
	bh=rmhmgjf9pNbch508V7x5oA7WF+QOIlAxgYvbMVZNPDQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lZ1uxS59S2WcIzQvvsc+Zao5NxRjWGQV8LatMZ7CYTnf7vIGiKcV3pYkh01xATBgj
	 ixfxDLJzj7L/22CIgp21SVqd+qmXZu/AJF3ySI2F5Fy+8o/2Hy7evsgSSuPWKXNON8
	 tKVXufDSle97m+x0pIdL6C8y2JRgFoK5kPm4iRcYaF0ApJFyoPBaxsVAVcTV9Pnxa6
	 lh0hVqwKKpBsHHjuN13KOeCUIEZMqdhNNpSzdK05ZML7RSS875KrecA/p0kw0IlRst
	 TZwZRn/dXCAOG/zOv3FCeXIfqCnfbqU1O/zWLBuWRBCg6RRwjPg4SlmBf356sJe8cG
	 XGB5Hb9CvHWTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CF1339308E4;
	Tue, 12 May 2026 01:19:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/8] mptcp: pm: in-kernel: increase limits
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177854879234.2528168.4119644465151651447.git-patchwork-notify@kernel.org>
Date: Tue, 12 May 2026 01:19:52 +0000
References: 
 <20260508-net-next-mptcp-pm-inc-limits-v1-0-c84e3fdf9b6a@kernel.org>
In-Reply-To: 
 <20260508-net-next-mptcp-pm-inc-limits-v1-0-c84e3fdf9b6a@kernel.org>
To: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 shuah@kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 08 May 2026 17:40:45 +0200 you wrote:
> Allow switching from 8 to 64 for the maximum number of subflows and
> accepted ADD_ADDR, and from 8 to 255 for the number of MPTCP endpoints.
> 
> The previous limit of 8 subflows makes sense in most cases. Using more
> subflows will very likely *not* improve the situation, and could even
> decrease the performances. But there are no technical limitations nor
> performance impact to raise this limit, so let's do it: this will allow
> people with very specific use-cases, and researchers to easily create
> more subflows, and measure the performance impact by themselves.
> 
> [...]

Here is the summary with links:
  - [net-next,1/8] mptcp: pm: in-kernel: explicitly limit batches to array size
    https://git.kernel.org/netdev/net-next/c/9031e5e31d5d
  - [net-next,2/8] mptcp: pm: in-kernel: increase all limits to 64
    https://git.kernel.org/netdev/net-next/c/c8646664fbf1
  - [net-next,3/8] mptcp: pm: kernel: allow flushing more than 8 endpoints
    https://git.kernel.org/netdev/net-next/c/607f16ab462b
  - [net-next,4/8] mptcp: pm: in-kernel: increase endpoints limit
    https://git.kernel.org/netdev/net-next/c/e845e6397d78
  - [net-next,5/8] selftests: mptcp: join: allow changing ifaces nr per test
    https://git.kernel.org/netdev/net-next/c/e1515a1a494b
  - [net-next,6/8] selftests: mptcp: join: validate 8x8 subflows
    https://git.kernel.org/netdev/net-next/c/1697837a67fa
  - [net-next,7/8] selftests: mptcp: pm: validate new limits
    https://git.kernel.org/netdev/net-next/c/c9b581e619d2
  - [net-next,8/8] selftests: mptcp: pm: use simpler send/recv forms
    https://git.kernel.org/netdev/net-next/c/ed5372634c5b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


