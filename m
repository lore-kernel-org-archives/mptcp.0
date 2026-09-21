Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62933B6359;
	Mon, 21 Sep 2026 23:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790033490; cv=none; b=DKKii8SCedEaHG8bLADWrpKnqVopVZqF47iRTi+LX31nKoc0nwTY/G5r8+GERtrqJS+13jf9nXbryDeib522sKT1uaB9b0qtYJFGKm/XHCmYfbmbfm/hEksKyE0SoY1Vxb+4jT1YtA6rkgTauDnpPrkgKZiHUiC2cFYPxeittm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790033490; c=relaxed/simple;
	bh=jFWJs3o9gZvbvPG0tJ12IO4GhLZ66z7emH9ticsiX8A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GGsav9Gti1K8i1GKZ9X+VOvmBA7Uas0OGtRgh6W2HxS6CGz1fsN4LCa9n1eBszmrgCPxaYkxhmduM9PKMINVnE03A65X0pp/wQliFREPGVlHAVzFjJaA+KK6Rlc6+4Q9UuyGkiXBI6GXsuqrsik439QLk4XUJupYZ9SzyNcpacc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VEpQ5ehl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEpQ5ehl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD9041F00898;
	Mon, 21 Sep 2026 23:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790033481;
	bh=PddItbrHNSgzGmSvPmGIv5dBVltf7+y5i4SEHcN+Suk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VEpQ5ehlr+JX3Sg5tkWR3zeG5YV/7XufVjBmbBf2JeKuiwE3gVl3naR0ovE2Ohnxb
	 DNY/NHwkEEjW+C41/HbpwHakGJsSBXAiDjknyjdLBzR+rBRe3jlK3TAdu++s0/4oLd
	 Hj8CXGz9wH6avVOT6fFO0ek14ocRko4ZluahsHvNRG/KKgo+I4guYPdZxpjC0nYw2U
	 fI4lcKTjNUX6Uv1jz1wMcE7+tsWq6O7zdzIKbET9KbYDhMnOusmCxMkmXwM3IaVQ/w
	 TaQtTHHTuKmmxvDSLHfBjqQKCo3vi7Q3skKXDY4uXQsggXEacHwgm1lR+zEu6srKxx
	 ogKtvUhDzyXQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5694A3927048;
	Mon, 21 Sep 2026 23:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] tls: drop duplicate check_app_limited in
 tls_push_sg
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179003341289.3287147.11471733627452812189.git-patchwork-notify@kernel.org>
Date: Mon, 21 Sep 2026 23:30:12 +0000
References: 
 <5bc803abb4e27054eaffc8b26db7812e6347b0dd.1789634247.git.tanggeliang@kylinos.cn>
In-Reply-To: 
 <5bc803abb4e27054eaffc8b26db7812e6347b0dd.1789634247.git.tanggeliang@kylinos.cn>
To: Geliang Tang <geliang@kernel.org>
Cc: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, matttbe@kernel.org, martineau@kernel.org,
 jiayuan.chen@linux.dev, tanggeliang@kylinos.cn, netdev@vger.kernel.org,
 mptcp@lists.linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Sep 2026 16:42:06 +0800 you wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Before commit c5c37af6ecad9 ("tcp: Convert do_tcp_sendpages() to use
> MSG_SPLICE_PAGES"), do_tcp_sendpages() did not call
> tcp_rate_check_app_limited() internally, so callers needed an explicit
> tcp_rate_check_app_limited() to cover it. That commit replaced
> do_tcp_sendpages() with direct tcp_sendmsg_locked() calls, which perform
> the check on every path that queues data. The outer call became redundant
> but was left in place.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] tls: drop duplicate check_app_limited in tls_push_sg
    https://git.kernel.org/netdev/net-next/c/cd7e4b1e4796

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


