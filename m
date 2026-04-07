Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F1934D4EA;
	Tue,  7 Apr 2026 02:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775528445; cv=none; b=WvxmqBdTAJvJt2+6gpzAwKuvz1UuBF2I33A/FQITfBVwTaQB2PrX+H4WJhrix9+ScW7qDa53mbi5Jo5dglpUJYeRfQn6ASGBBnCIsP6sZjkT4c261Fg0koLnvVzT6vNVCxpHLtr/1k/kq7BXoKbvZ9sLelB0KBgcXq38v1GYxMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775528445; c=relaxed/simple;
	bh=alNwXDLkA8tDaP+3/itxFIwRAifX5uOLvOtmvlBVT6w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YBiH1FmKjclttYRNLj/apG0CyTeqjbTj1PmbXWEVYBC0lZWO2W2hyvh40gQBfqc9V2JQQZNveKdnXf9POmKzXUx4GSnuBKPjJiiYo4B6ZvBlD+Chz6UMzTuoQgBAPcmc7PO4gWVHgyw2qJMATz89UHlXwtjY6kCatWbMa1x2p8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cq6tYqz+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cq6tYqz+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77314C4CEF7;
	Tue,  7 Apr 2026 02:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775528444;
	bh=alNwXDLkA8tDaP+3/itxFIwRAifX5uOLvOtmvlBVT6w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Cq6tYqz+4BWZkTNLy0FdmHvBUqZi3+1Tu1fFU27exvjLopxNJ7lgX/3S2F/TSi7HU
	 LWhzw730wHBmm9Pqp/T4HYFMtcT45blfiQN2LycLQsLuSx4Vn+HQ2xyCz1ynEU/OyX
	 gMjvXKX7K8apJW4iVhFBQgWZCRjAEiETwcVb/URAZwlOviAFwnv4OIRuxo3QbVI2dI
	 3ZJ0S+h/nGyYHVLLSv4dkOYt2sM12OztYK9v9e9aQpNz3KeSxnenmCtPzmqiWTYqVe
	 O4reme+p4rpzJ3LdXu4LQJitRS4EU/J8mFdj7K4Vz1sbdEM33l9xp+lCsBQdD9v7T9
	 VMCcxATt3QH5g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C473809A28;
	Tue,  7 Apr 2026 02:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] mptcp: support MSG_EOR and small cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177552842280.3346653.6456875572655445146.git-patchwork-notify@kernel.org>
Date: Tue, 07 Apr 2026 02:20:22 +0000
References: 
 <20260403-net-next-mptcp-msg_eor-misc-v1-0-b0b33bea3fed@kernel.org>
In-Reply-To: 
 <20260403-net-next-mptcp-msg_eor-misc-v1-0-b0b33bea3fed@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 yangang@kylinos.cn, ncardwell@google.com, kuniyu@google.com,
 dsahern@kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 03 Apr 2026 13:29:26 +0200 you wrote:
> This series contains various unrelated patches:
> 
> - Patches 1 & 2: support MSG_EOR instead of ignoring it.
> 
> - Patch 3: avoid duplicated code in TCP and MPTCP by using a new helper.
> 
> - Patch 4: remove duplicated condition.
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] mptcp: reduce 'overhead' from u16 to u8
    https://git.kernel.org/netdev/net-next/c/00d46be3c319
  - [net-next,2/5] mptcp: preserve MSG_EOR semantics in sendmsg path
    https://git.kernel.org/netdev/net-next/c/7fb2f5f96499
  - [net-next,3/5] tcp: add recv_should_stop helper
    https://git.kernel.org/netdev/net-next/c/eb477fdd6803
  - [net-next,4/5] mptcp: pm: in-kernel: remove mptcp_pm_has_addr_attr_id
    (no matching commit)
  - [net-next,5/5] selftests: mptcp: join: recreate signal endp with same ID
    https://git.kernel.org/netdev/net-next/c/c4a5cb2f00f9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


