Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD7C36AB72;
	Thu,  9 Apr 2026 02:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775703080; cv=none; b=uI8YESr4SAxyILyVfyvEf2thpQfFhoV4wYZ3c51r5hjqusN94IWRIjAwQ+HlYX4UOQjcLnlTJg0wvSh7FpLW1q5BIg4McYw0SQeA3k0vrBMZ6P4TlZJUyTGD1yVR/R55JCc9v+kpV18vD3FElQN46bXa9D7teQ9XKB6KEqvxhMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775703080; c=relaxed/simple;
	bh=wbCGBxW6+xI7PiD/dR1FaCJ1RlFgboiu5pqce21cjD8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e8b4pONAeQTLZaG+pPybvRBhityKNXaz2rYunHE0xp9XoewBtHhjTqfQEtxMDI3T0FqG/VlNwjR0FBBYIbFS1gs2STai5AT1Omlv/Ibjv0HiHhD0l0MQ8m7hmTLXACxIJUTmTzscivyvcGlQuJ0j+31gd5LcXArNsrdWxI1eK0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0TuSndD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0TuSndD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9916C2BCAF;
	Thu,  9 Apr 2026 02:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775703079;
	bh=wbCGBxW6+xI7PiD/dR1FaCJ1RlFgboiu5pqce21cjD8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=X0TuSndD4T5Idq+82MrJECXyLQYd3jWV0wpVEOYhLoKlVdKP+u0JP/a2lVF04xYt5
	 USBYam7SxRTMyNyZCq8x8AoMxTGTsYpdQRqkxSJ0YuBOnnPIlp4szUWPHLDMbxyJWV
	 az049MGnPJJ59U6e4P2IwB3cxEElngyvTjwkil79cjP07+K8eP1HF0mCXnuhGleaud
	 wPGUwzB/a+LHYy4TxxQNfYH08HZ8wz4G1qdqtUCDwNuhpxuEL8ITKf6T83wGQNu8Ed
	 ZRTHWv6MkI37+6HcnTiYPpnxCZwm/Z/jYc8xIgwc0Bf5xWjOJwgAfvHnkVaZHKGnlT
	 1HFiWUVZTXvvg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FCD03930793;
	Thu,  9 Apr 2026 02:50:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] mptcp: fix slab-use-after-free in
 __inet_lookup_established
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177570305588.968772.5566969004383057398.git-patchwork-notify@kernel.org>
Date: Thu, 09 Apr 2026 02:50:55 +0000
References: <20260406031512.189159-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260406031512.189159-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: mptcp@lists.linux.dev, stable@vger.kernel.org, matttbe@kernel.org,
 martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  6 Apr 2026 11:15:10 +0800 you wrote:
> The ehash table lookups are lockless and rely on
> SLAB_TYPESAFE_BY_RCU to guarantee socket memory stability
> during RCU read-side critical sections. Both tcp_prot and
> tcpv6_prot have their slab caches created with this flag
> via proto_register().
> 
> However, MPTCP's mptcp_subflow_init() copies tcpv6_prot into
> tcpv6_prot_override during inet_init() (fs_initcall, level 5),
> before inet6_init() (module_init/device_initcall, level 6) has
> called proto_register(&tcpv6_prot). At that point,
> tcpv6_prot.slab is still NULL, so tcpv6_prot_override.slab
> remains NULL permanently.
> 
> [...]

Here is the summary with links:
  - [net,v2] mptcp: fix slab-use-after-free in __inet_lookup_established
    https://git.kernel.org/netdev/net/c/9b55b253907e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


