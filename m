Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE4E547059;
	Wed, 30 Sep 2026 02:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790734809; cv=none; b=bECsmmSA18RKzNlQV5E9oevByho37qfqbwxySNgqi8SGrG8la/XAVqaAFDwa69o0LyCrwGhr2LuTFYHkmEpHT/FGoGZ37hUA/SPLo9Y0Dc1qb01i9XWYCHsWjb1AsmC83epHv3/efzcRmOqTS1Wqqc+AVl74UHTv40D7b9oM7QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790734809; c=relaxed/simple;
	bh=8uGBMMioS5lDejFVuty7woie6iD1aexXTSEa2wGECLo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W5QwjEmx9V9yzQTf1VSKLxgu3YT3U9MYre2tWN0IGnjOnW9EYw/6gIIBFYALEKb0xIkltw/kh45hGUyb546XukmneKc8n0vS3WghxDdrP0xuZYAx6CyJUrl97ww8x5bRevPE3lz4UtSF14uoCih0u6ep1NK6hYjtSCHGEk8LjLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+VUn2Hw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+VUn2Hw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 802451F000FF;
	Wed, 30 Sep 2026 02:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790734807;
	bh=Qk06ge0yUWOjB14r7PQI/pwqnAiKGPmdvuKcq6Teydo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=S+VUn2HwyKN7he3LoPBTa9mONGR3J9gz3IpTey2yt8H0fKXdX2cF5ogh8q+8Tx+ug
	 JpKwO/4UFWl/MeoqcbjnjO0OF4ZocJeWmcXQ/4JSmImIkr7eAITDKWU+Xp0Vceqwqa
	 jQmq2gn/f3AjyODChBKI+zRco6DH9DGfSNyJIO9o73rT22jdA9D6vGuxn/CKL9jjzl
	 LcDmd+LpyG1y8tGCyhdSjW1WskdXH8iBWNpOyptHGK3vjPrYvaPCC1yMZwFCZx+0LS
	 d2cz26fItwi3RpD3AVO0/X4iu+W+gcPydyCpsNiXTMShWBzYVEIfs1Ncn+/aL40ACS
	 WnpXY3LvBiBzw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 774843924FEA;
	Wed, 30 Sep 2026 02:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] mptcp: misc improvements for v7.4
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179073480628.1213686.7153370643683858452.git-patchwork-notify@kernel.org>
Date: Wed, 30 Sep 2026 02:20:06 +0000
References: 
 <20260926-net-next-mptcp-misc-feat-7-4-v1-0-67af4ab37406@kernel.org>
In-Reply-To: 
 <20260926-net-next-mptcp-misc-feat-7-4-v1-0-67af4ab37406@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 quanyeyang@proton.me, liuhangbin@kylinos.cn, shuah@kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 26 Sep 2026 17:30:33 +0200 you wrote:
> Here are some unrelated improvements for MPTCP and its selftests:
> 
> - Patch 1: reduce struct mptcp_subflow_context size: no need to store
>   the truncated HMAC for the whole connection.
> 
> - Patches 2-3: shrink struct mptcp_options_received used to parse
>   incoming MPTCP options, from 136 to 72 bytes on x86_64.
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] mptcp: remove thmac from subflow ctx
    https://git.kernel.org/netdev/net-next/c/0cb6910130a3
  - [net-next,2/5] mptcp: split FASTCLOSE key from rcvr_key
    https://git.kernel.org/netdev/net-next/c/9f778b567817
  - [net-next,3/5] mptcp: shrink struct mptcp_options_received
    https://git.kernel.org/netdev/net-next/c/d16d54dac08f
  - [net-next,4/5] selftests: mptcp: convert iptables to nftables for mptcp_sockopt.sh
    (no matching commit)
  - [net-next,5/5] selftests: mptcp: convert iptables to nftables for mptcp_join.sh
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


