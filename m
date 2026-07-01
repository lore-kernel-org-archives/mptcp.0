Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633BB285CAA;
	Wed,  1 Jul 2026 20:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782936023; cv=none; b=aDMX6vFUNMZKJAkK4gNIjMx9Zg2YStG+JYPTDmPIYyaggauqrQJI774pQjQ8Zf8J1uZ81Lz/Xpw2delNIgdthsKl/jRGG15MINdEcz1tgDhynSLQbC9VT4vFpDNcne457kubIVFZAhk32BsdY2tyGxXkjNdRPfAuZa28eDb0Xnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782936023; c=relaxed/simple;
	bh=sJlEmg8jZzcAZQT9bQAjrCat9CPTgNMYOUnV71SRmbo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bMb5HSI3epa204QG/V6XFMrO+1WcLPDv+nHNc+UJ1R1K7CjMYDRlWmB1Ugb1pZb+x9yjrQ/LLqc/8YlTO/c0X+ao+j0R+gaO9sI/77mRENnvFVx4EMh4FGZrVOV0x2NCyHd7PVXcB+wCpzhCNm9aY45YKozyWfTIGLHVqejtzCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAF0m6/3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAF0m6/3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A05F1F000E9;
	Wed,  1 Jul 2026 20:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782936022;
	bh=yUmt3XHQRZ9e3D1awSmKKIjHkc7rhguywA8PgjruBa8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HAF0m6/3kc0Ux3FNOZbguL6keFkagrUCZfOyM1sUN1E8nIuOJSryBz5iecwHWuTiz
	 j1rFJXwObum/SoReNP/O//aPDjwi65Sk6mblWdFTb6Y015cOQpGwaZnAFkEx0TJgCF
	 KnpbXgZKZ0Lu0uj5u8+x0FHA6j1F3Y8aMY3VYS2KiPAHPxgE+1Iawy+VIEwUjSrETF
	 /Y+BeKShHiDgLH6H5jnBz33stgP1RYz4SQrbkXX6lWpzSW6cjugc8a2iMkp1QHo2Ap
	 1YeTvOAPRwCyzEpsmMu2DMrKsF90DcN2o/jPXGPXHRAMpUGZdqCwfj2C1WwmzjOsBH
	 xZi/l9drsjOUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A52383BA30;
	Wed,  1 Jul 2026 20:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Mask socket type flags in
 mptcpify
 prog
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178293600526.1273239.14079856727062053732.git-patchwork-notify@kernel.org>
Date: Wed, 01 Jul 2026 20:00:05 +0000
References: <20260630095723.564392-1-layus.on@gmail.com>
In-Reply-To: <20260630095723.564392-1-layus.on@gmail.com>
To: Guillaume Maudoux <layus.on@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, matttbe@kernel.org,
 martineau@kernel.org, geliang@kernel.org, shuah@kernel.org,
 bpf@vger.kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 30 Jun 2026 11:57:23 +0200 you wrote:
> The mptcpify BPF prog upgrades eligible TCP sockets to MPTCP, but only
> when the socket type is exactly SOCK_STREAM. Its update_socket_protocol()
> hook runs on the raw type from userspace, before the socket core masks
> it with SOCK_TYPE_MASK, so the type may still carry SOCK_CLOEXEC or
> SOCK_NONBLOCK in its upper bits and the equality check fails.
> 
> As a result, a socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, 0) -- what
> common libraries do by default -- is silently left as plain TCP. This
> was hit in practice with curl. Since mptcpify.c is referenced as example
> code for enabling MPTCP transparently, the same mistake is likely to be
> copied into real deployments where it fails the same way and is hard to
> diagnose.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] selftests/bpf: Mask socket type flags in mptcpify prog
    https://git.kernel.org/bpf/bpf-next/c/b4b8b334f6b5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


