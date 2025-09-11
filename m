Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30ED721B9C1;
	Thu, 11 Sep 2025 01:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757555406; cv=none; b=vETTHu3wQOv/NSlevqGKOtf7yy4miOTxuesAf52bBNFtixS/d04zCMHAtzSACUyF5T3EEMAQB5hU7/GsSuRrjELvXmL38mA5tDl2gdMVFROKJfG18R9ex6UNrg0j2uc5xtoEAc8JW3mPkvarA6ud90AKqLuVv3bXZU38upl3wTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757555406; c=relaxed/simple;
	bh=uNU3F6KFlVxLn0b1y49PoJkVNixnlW6N+zuZ41Y7WAw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Uj1o8sW4rTtsM0oTOphAUzxpaNKygA/5nG9WKAYAaLOia92OCUDru7qZeEw6eb+WSlkIIJj9XecZ14tREwjNaHz7Qkc8u4UP6ZDGZHz0i7uBOLcssOV2ZapAwjnO6dvZNMp2GAm/9+KCam71uB19EkdsHxBh4vCUyoitJV1nUlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ey/nnSsI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ey/nnSsI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A922FC4CEEB;
	Thu, 11 Sep 2025 01:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757555405;
	bh=uNU3F6KFlVxLn0b1y49PoJkVNixnlW6N+zuZ41Y7WAw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ey/nnSsIA4YMlDBtdKC0oysSpDQ+KOcgBiGwZPdfOLJ8MOGhmzA8xy7lJdt548XgO
	 mzOI25E1YSKmJksiqYeehabTywUpc2BqoYlHt+rL1gTLXLs8mIOxT9ZjB0SyzJWPaQ
	 Yt8eCQXWYNzBreD9Xcfwmxv+kG3FNXoyCSbw4sm4NXyHEybwtGQyPgKzzYthQmkmFb
	 PXbCBq7jLwG4gxF9JDaudYg992AxxoygW1677dz84wbjBC17Zbv25SIFkocelusBs0
	 nSQ6g2a+8/0MQn8yDqCwCN63K692O3T0Pi1TsBpRHAY1oQkwvqUjJbgHKsyX5MlNur
	 bEbilF+Y3D5QA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE0D383BF69;
	Thu, 11 Sep 2025 01:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] doc: mptcp: fix Netlink specs link
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175755540824.1625707.41414592055811812.git-patchwork-notify@kernel.org>
Date: Thu, 11 Sep 2025 01:50:08 +0000
References: <20250909-net-next-mptcp-pm-link-v1-1-0f1c4b8439c6@kernel.org>
In-Reply-To: <20250909-net-next-mptcp-pm-link-v1-1-0f1c4b8439c6@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 corbet@lwn.net, donald.hunter@gmail.com, mchehab+huawei@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, kory.maincent@bootlin.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 09 Sep 2025 19:46:09 +0200 you wrote:
> The Netlink specs RST files are no longer generated inside the source
> tree.
> 
> In other words, the path to mptcp_pm.rst has changed, and needs to be
> updated to the new location.
> 
> Fixes: 1ce4da3dd99e ("docs: use parser_yaml extension to handle Netlink specs")
> Reported-by: Kory Maincent <kory.maincent@bootlin.com>
> Closes: https://lore.kernel.org/20250828185037.07873d04@kmaincent-XPS-13-7390
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] doc: mptcp: fix Netlink specs link
    https://git.kernel.org/netdev/net-next/c/1f24a2409745

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


