Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5569720A5F7;
	Tue, 12 Nov 2024 03:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731381021; cv=none; b=Ls7W/yFPvHRbmVz1/8p7auOUqsPUwGy1bNPE6AQH3UWjv62sWFa0mc32GDoohkDiRDlWk9PA87jy76UhBxTC+CB23eJ5wgdRBAOElzblqPyi8eIAxTfgbnvApIkXfhLPwsvBoa/Rl3mxhXFPSmgXgP4JPgm2LaqeGq5jtVFrjO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731381021; c=relaxed/simple;
	bh=mH57cbZjyVa6xNhl/CiiNE30nia+w8i2VuPME3G5B7s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ncjXk4QiOQmXMZTP9uu96vDbpnX3bDyAPxm03jnlxy3Cf6vcOceX0InWDE58OUWNTzjUo+zh53cdNxSN6mkro2AMoc3hy665ikVrwcGAbEsLDlOHItbHpDO+KG47ZZrjKxC/rF8DToicxmMPKsWru8Bp1aknG4AnaXF/S00HVHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CsbeBux+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CsbeBux+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD4CC4CED0;
	Tue, 12 Nov 2024 03:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731381018;
	bh=mH57cbZjyVa6xNhl/CiiNE30nia+w8i2VuPME3G5B7s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CsbeBux+mHJnV6HMWnBLEOzUTiDIeeiT+C7nqSVS26l0GUAipb8+V4hpj3kOgO6/v
	 /f88OyrtbgJnXzCDcoT4Yfyvx+NQSHVFfVwcCd21gKF5bbssJsxXmcVyxInvyDjXwS
	 L0Nusfk/3FfLrJ74aXHdyR6DHA2SYm3qHL1aQLO8lVhMRsumFIT9YjkX3PZ8bHFEaZ
	 KzVm7WdHxsr2K3kYShcChhUPMv4Xlbm9jljZr+GVBtmWA9rQKECkfD/UsuC3ZodxWi
	 AYVZtBHxlQpooHgdRMSlA+E5iZFDXL2hWhdS5UJ/DYMRM1OzgyLcO9BTGPJoBGByDn
	 4Acfn7A38JnUg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 344333809A80;
	Tue, 12 Nov 2024 03:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] mptcp: fix a couple of races
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173138102902.64810.12435191606260669917.git-patchwork-notify@kernel.org>
Date: Tue, 12 Nov 2024 03:10:29 +0000
References: <cover.1731060874.git.pabeni@redhat.com>
In-Reply-To: <cover.1731060874.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, matttbe@kernel.org, martineau@kernel.org,
 geliang@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, mptcp@lists.linux.dev

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  8 Nov 2024 11:58:15 +0100 you wrote:
> The first patch addresses a division by zero issue reported by Eric,
> the second one solves a similar issue found by code inspection while
> investigating the former.
> 
> Paolo Abeni (2):
>   mptcp: error out earlier on disconnect
>   mptcp: cope racing subflow creation in mptcp_rcv_space_adjust
> 
> [...]

Here is the summary with links:
  - [net,1/2] mptcp: error out earlier on disconnect
    https://git.kernel.org/netdev/net/c/581302298524
  - [net,2/2] mptcp: cope racing subflow creation in mptcp_rcv_space_adjust
    https://git.kernel.org/netdev/net/c/ce7356ae3594

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


