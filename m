Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77F325291E;
	Tue,  8 Apr 2025 23:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744154647; cv=none; b=ad4EjgeGfLAY5Oj1USVE9RE6eyqK7MJq3QCDgHCAnk0VlHsZ2EdRl/8fL6uRcq/0Uq+M87nF77+BiYjZYc5ld0kHMuu2gISQrNU0Z7Sro770ROfwtDL4PkqT09QG+5xEB+no4qjw/4WvRuhueYVdhb2CBsxzJAfGGJyxc6nMP4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744154647; c=relaxed/simple;
	bh=U9/4pX8gjaVefgBjkJMyyJo+1elvwruooJ7f0S6DECU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kJlx65CKCarrTtd0Udt+lsPK+LrLez+Lu29bjQ/jaOEglSLLYSHWNJn9IBCKXOJS9U4d3mRQXjEFwgo0Il4Pb4kiHxp5k2URJFc3EX0Khi/h5qBNvqFJcpFMsqAW6kvN0h82PCkJD4vDcWWpWGsIwpEBxoK/iwqVjarfFxdXx/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+kaFXg2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+kaFXg2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA15C4CEE5;
	Tue,  8 Apr 2025 23:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744154646;
	bh=U9/4pX8gjaVefgBjkJMyyJo+1elvwruooJ7f0S6DECU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=I+kaFXg2zedpmDg6A/e085iRbxoT84isQv/DiEfTWSeZaqdhCCSxthTiOZMq4hOJD
	 tM8Nyl/5XQ/q32nsgpw3DAn2lysOscHu/6u7KygV13Itl0DUXIp8UqssOyu8pwKvDX
	 zN/ntxawR642mex45T8JwC/YvMHAKnreeL+w6EGQBDpX7L/Q6296FDsMOk0wnRXdKW
	 1ud7craxXJBZuGLKL/cRKR3HK2n1/TLM8v1oAF4MEVgSQhKTD/t3xtD0i73w+f5+0i
	 HVtt7Z9wrf6uqtVA5I+vwls15cL6jRtb/XNYKgxEXOWaMG+BBdcU2kbYNUKcr8WkI8
	 HYC/NLpHfDR0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB34B38111D4;
	Tue,  8 Apr 2025 23:24:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] mptcp: only inc MPJoinAckHMacFailure for HMAC
 failures
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174415468377.2216423.2812266376332216363.git-patchwork-notify@kernel.org>
Date: Tue, 08 Apr 2025 23:24:43 +0000
References: <20250407-net-mptcp-hmac-failure-mib-v1-0-3c9ecd0a3a50@kernel.org>
In-Reply-To: <20250407-net-mptcp-hmac-failure-mib-v1-0-3c9ecd0a3a50@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 07 Apr 2025 20:26:31 +0200 you wrote:
> Recently, during a debugging session using local MPTCP connections, I
> noticed MPJoinAckHMacFailure was strangely not zero on the server side.
> 
> The first patch fixes this issue -- present since v5.9 -- and the second
> one validates it in the selftests.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net,1/2] mptcp: only inc MPJoinAckHMacFailure for HMAC failures
    https://git.kernel.org/netdev/net/c/21c02e8272bc
  - [net,2/2] selftests: mptcp: validate MPJoin HMacFailure counters
    https://git.kernel.org/netdev/net/c/6767698cf9c1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


