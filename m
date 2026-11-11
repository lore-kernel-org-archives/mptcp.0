Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794355807;
	b=Q+AeY4GeXMMM4Svut9Q63Sn+jINQZDQeFMnGtQ5HrwfbLInYAu4pgS6VmNq/0wD5FB5s
	 N3X8OiF3engEvxTEf+LlvVhIC74+xqJhx7oweraoU+/Ftj8Lq/TuzFiFAZo6wamQ/HGhN
	 gtRk9kALszXL2GgQgz4FRHn6/obPcN5+h+Lz51cLbI0r71oOUwFSzv1iA1qrU3dzme5N+
	 CCgmpBrOYh63nCvYx7+3YnjyLtG1oJYsEyR339g6Z2f+BMepQ27psa80ikppuLfo7AOTv
	 rJxMhKcK+n3b64C8iV+na3ROrczIngBVgBwX1RNWPPTVDnpyKzQlfhgTT329KXVkWxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794355807;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=Er+Sn5xQ3HzulEJBU+ZC5ylI0mayZtrYKjaFWpuVGU4=;
	b=VqrdFxp5siq9vYXa7gEwhIX4cROg5Lc+R2AniEnLO2a2ToJDUkuhQaj8ME3Zd1NnoXbL
	 MbLT08JRHjM5ebHyM1yc7kQcMQ/g1dJeOSEWitxjZupnYd1+zDPfwciIRQLHAJaK4icp0
	 +Cvgzk1ED5YpDrA/y2LIL+pziHpN1uMdA7NGYGKmTrBIiB+x7gGZs3GjsNP1z9HBCg15m
	 U7L10wjlxdOBAD/wa4jg2feugoqxu+eGHsAZep0mYJLXAfQov//B47EbMTyRx9MoYkcFZ
	 E/B7ny4tXL5E9VEtnitUsVguubnN9vRzKAdGxXUiRkZAzjp7r7caWGHl8kaI9Jok8Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="iJ/vkKTO";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE90C606A320;
	Wed, 11 Nov 2026 00:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iJ/vkKTO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7104F1F0089F;
	Wed, 11 Nov 2026 00:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794355806;
	bh=Er+Sn5xQ3HzulEJBU+ZC5ylI0mayZtrYKjaFWpuVGU4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=iJ/vkKTONajkwwEgVoQEKy9nOMlpUdFmUB/NFcue8Vn4V2gmPH1mBp26GDNWkbls7
	 hN3NdODUH5dEwvsEaf0qhppiY5/XA+V22s2keR51RnoOsCcqdRmF2gqPoIu78BaHsd
	 BFLC2SDLiDhG86j4rRROZb384D2ZUaKTYdlPF73Sq9zkl8jXr6iutta7VLQ6p3nrUG
	 LAxpO4v9u5Iekf5fmQNRfpO01V2I9WELL4w7fnzO3bH82EyhLUJ+O17ILxtUX0gdzE
	 HN4eK+VLKCCA+rE0AFB38eXlFO07sgzGTI0VXfIm59HwchIj7D0GuKbi3ZLqocqrPy
	 78AKwOofn9MAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5E11339E8A4C;
	Wed, 11 Nov 2026 00:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-net v2] mptcp: limits: fix JSON support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179435580518.128546.9097595420555036368.git-patchwork-notify@kernel.org>
Date: Wed, 11 Nov 2026 00:10:05 +0000
References: <20261109-mptcp-limits-json-v2-1-ad8d20051515@kernel.org>
In-Reply-To: <20261109-mptcp-limits-json-v2-1-ad8d20051515@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: stephen@networkplumber.org, dsahern@kernel.org, netdev@vger.kernel.org,
 mptcp@lists.linux.dev

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Mon, 09 Nov 2026 12:47:26 +0100 you wrote:
> print_mptcp_limit() was trying to open a JSON sub-object and closing it,
> but no JSON object was actually created before.
> 
> Because of that, JSON support was not working with the MPTCP limits:
> 
>   $ ip -j -p mptcp limits show
>   add_addr_accepted 0 subflows 2
> 
> [...]

Here is the summary with links:
  - [iproute2-net,v2] mptcp: limits: fix JSON support
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=5525b4722604

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


