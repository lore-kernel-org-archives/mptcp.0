Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794005417;
	b=aEUTparQtTz8mjMOzI6iYi2xLAY8lctHXugswv51nGdOpm0629o8OLUPdpyPsyuLe0Oo
	 +9+Mp6hVWz/GJKHYEdwQUxmSFa0dj0e2s8tbK9yxV/6yzu6P2cyJ/X62Sa+Bw8C33/igG
	 a/17HCMOurRFzqHexc5E/Yo9lW+gzcHq0yOKiM/lYX2NveI9HTv3cvlrkn+NAnpM20KSW
	 uji6HJPNHMKIzPX6JA17rP6TXnPgKs/nEBgiL98KiiAwJ4DFN7ezBtC/aH3fQWxYEsYz6
	 g/DC/yYGBQXcsk3zRa6zIUsT8EVbR4gtwD5BfP/wiavZvyaFRXEIub9TiCB7vEo/Pxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794005417;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=3giCpB1XcB69Iln8AtM/TTiv8S3XH9oxLUpr5QNMg4g=;
	b=S7dS0o8yHmXIBaaxeo7/qJGFedJTSbqU/tNaA8l5TTcRsB5wd3cDp4ppnHhV/S5+RmPw
	 BMsTR7ZkeaP5+DrUnTj86HHlRfmYDrOeZNreg0FWC6w5AQX9+xnPr3PJg7IxdbyaolxUh
	 vuq8LZMTCm5lLTkiQpUogI4G2pmeqE653Y1mq9IaBFCwuD0MwiZpmyEAxcehvpRftogBh
	 fi9t7TFnbk2V98fF32nfHJDk669wSVKRDS7/gYcIq+jyPlowDROYpxsQ/M3fbEcvP6t/e
	 mP6bTpGF7clo3K+O2BDmd9f5/fKzajcGkooz8uT5/GSLiNt2CFXE/fY2EKCwAc/ev8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z8yDa9fu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B36F606D810;
	Fri,  6 Nov 2026 22:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z8yDa9fu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A471E1F008A1;
	Fri,  6 Nov 2026 22:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794005416;
	bh=3giCpB1XcB69Iln8AtM/TTiv8S3XH9oxLUpr5QNMg4g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Z8yDa9fulsDXFDCmWmOIgg4F1fcWqL0lcxG93SBkW7kLacfaWyKtO0o79p7wTTYlA
	 cTAIS/qz8F+0I5iQ8KBL4wFb4ceFW07xC9nqjLmUSsKqsUf88zcfPYVU0iWc2bz+rG
	 qzxTFRTtDAzH7/RLCTNdbg2D/IRhxn6s70N876QMb8Y2lpmrTl9l5bX/q2gephR09N
	 mwEfmXxydO6FCIw0uZ8f/UiP7YWHdLLdwhH0n1u6/5BdaeC4WP0KLCfgCQ1CqzXXAV
	 /9SSdkiw3wCd/K9wkuDDRbWsqQabntseOaTUWGSncWjnd3HqkDJ43LoTKXeYlJ1Gtw
	 VQpRT83Ylbi9A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B1A33A55EC2;
	Fri,  6 Nov 2026 22:50:16 +0000 (UTC)
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
Subject: Re: [PATCH] selftests: mptcp: pm_nl_ctl: print sizeof() with %zu
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179400541516.914342.11201062556187243075.git-patchwork-notify@kernel.org>
Date: Fri, 06 Nov 2026 22:50:15 +0000
References: <20261103155506.534973-1-sashal@kernel.org>
In-Reply-To: <20261103155506.534973-1-sashal@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: matttbe@kernel.org, martineau@kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, geliang@kernel.org,
 horms@kernel.org, shuah@kernel.org, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  3 Nov 2026 10:55:06 -0500 you wrote:
> On 32-bit architectures size_t is an unsigned int, and printing
> sizeof(struct nlmsgerr) with %ld warns:
> 
>   pm_nl_ctl.c:73:71: warning: format '%ld' expects argument of type 'long int', but argument 5 has type 'unsigned int' [-Wformat=]
> 
> Use %zu.
> 
> [...]

Here is the summary with links:
  - selftests: mptcp: pm_nl_ctl: print sizeof() with %zu
    https://git.kernel.org/netdev/net-next/c/1146fbb8024b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


