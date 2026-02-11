Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4913542C4;
	Wed, 11 Feb 2026 04:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770783622; cv=none; b=TQDtwGAatjVt3sSDzDEE5hLy9SI+98s+K6ainf24OO2VtQtqb8UCotTQCkoALQ4fwkwHHwjr5cyDq6YCbRJSN+LabgtM+rtWeIi4BmcwVuE0e3s6uIkk5hktIb0exLqZclHP5U875F/Ayvj4JRqR+3nnb7OOq9dP4TMxg0hvYAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770783622; c=relaxed/simple;
	bh=bcBJbIaVso+qoUKl1aFEuonLhMxX32lj4+8r80o2hJw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZUegiw4H78/OVyoj64LF0+DTOkn4FqOYEVmqS3mIep/2sBTj4sgz1Bf4i+OMGPdxz+cf+F/ypV4UgntjSaWk+yWYb78Vzbx/aGgNGGJuI5RMLxpTfZy2jyb8osbjeCbU8Z1KK78D2H1GQXRwVip5PCbdgGtRSlxIgWcutt1nDd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLHS0clw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLHS0clw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A96C4CEF7;
	Wed, 11 Feb 2026 04:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770783622;
	bh=bcBJbIaVso+qoUKl1aFEuonLhMxX32lj4+8r80o2hJw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RLHS0clwmdvW/VrMJIiQsPoLzoPfQJb9+8mQ62orNKp0s3rQgrBAdXo5HawIawHIe
	 533TjOGU0Ikhts34SAqTl4fofRXtdnQ/YgX1w4jV4mPEK7KZMsSUtDdCaAIRq/PSMJ
	 6ho71uSC3GzLJ8hWjOZ5PEei6v8OPZNf0ZuHnsMJ7jG1mtz1GaWJKgQicgqzc6egGv
	 P/UTTpXb/Eex87m8KCokx8PVF+y5qTg42tfY8Et1oaPNyIfkNGFNnuFUMMU2GFemrE
	 xAAVjuov3SjW7GPMyfoHXTCuY0zovCvkvlmy2/tUsfDN2MNnyv4V0EE2fcgDoE2LLh
	 XnOUUkZ8GqEMg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 852B1380AA50;
	Wed, 11 Feb 2026 04:20:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] mptcp: allow overridden write_space to be
 invoked
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177078361707.4190841.15535734479122320218.git-patchwork-notify@kernel.org>
Date: Wed, 11 Feb 2026 04:20:17 +0000
References: 
 <20260206-net-next-mptcp-write_space-override-v2-1-e0b12be818c6@kernel.org>
In-Reply-To: 
 <20260206-net-next-mptcp-write_space-override-v2-1-e0b12be818c6@kernel.org>
To: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 yangang@kylinos.cn

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 06 Feb 2026 14:09:24 +0100 you wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Future extensions with psock will override their own sk->sk_write_space
> callback. This patch ensures that the overridden sk_write_space can be
> invoked by MPTCP.
> 
> INDIRECT_CALL is used to keep the default path optimised.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] mptcp: allow overridden write_space to be invoked
    https://git.kernel.org/netdev/net-next/c/e5e2e4300228

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


