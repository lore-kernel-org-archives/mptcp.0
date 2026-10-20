Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792487411;
	b=O2wFj6KU9gAJ4U9AnfO8N/ug8p8qrj48zzCg9XGNcAb3pqNP56hyIptJ4h6uHhAunLKS
	 QtBSHvgEZW1db8QFj8X4ilIJiNZsCeQXohmJXyM2voxHdsAZP72niwJvb/zrqTs9SNISU
	 fIqmx+6/rnztoDkQCtR6gcNxYQ4B4hPIHNlrw6W3Sg7kFHVoUkXEI5cNiOBikf9GnLyO1
	 8RRpXURbdFs360BY0S3t0ZQHSBJBdfbub3q06GTVIn0f89LJd1p/UM3OTPzlIGOBlSwTq
	 WrohQMh8yhkuzgY27x6Nbjay6C1PUanBhxks0xIjUpzron7bRN9eGnnCJWhYuseLMyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792487411;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=XAtDlmIS6gGYPAr5WtgcIqKrQ7x0x9dsNKC7eWyXpnE=;
	b=nFceq1CW1k0K+mbQTMobrO7KTnBzRFB1xuTYep1Lfp/EYtCy0yDopo+hhQTbwy4FhVNu
	 vuRzZci0AW+IWiTyEB5MgXN1sfdwjZmJZG1hqYLXbdY2UE/FQrEMeG3P0nEhBSjnWAqHs
	 qNnXAjV+DwQiEABfgrTe7KSjsIb6ciS4DdX+EBo5o1TqgrPKWK9o1RIUEN+YoWWVvIoMh
	 NC8Lwj21l/RsRjfotBDgUUSYF+UdNueIRPCe7Edt0Mur0o6j6Yy86OIFJsWUSH8KbEmx9
	 ICHLYlH7iiHJvQGY09NvZb9JlJAEb+JartzZxHh5R6jl+vAYVBdbmi3nf7ttECqDCEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gxVSY+dv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD961606A330;
	Tue, 20 Oct 2026 09:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gxVSY+dv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F97D1F000CC;
	Tue, 20 Oct 2026 09:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792487410;
	bh=XAtDlmIS6gGYPAr5WtgcIqKrQ7x0x9dsNKC7eWyXpnE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gxVSY+dvbsGFa42pCg/MMnt+cH7yS7EP7z/NdlaND5lL9LNZBJTObos1PWXweHTRB
	 xDi9chg0/nzfB0DbFYxkTN97mUOsZ/1FFn0TzphZ6ZRTx6xuDWoAaZIRWGqXB7uQpX
	 3kctvonUX0gyD3xLJY3jtVMUyYbjNZIXyK3EJ0Tm7UZ/BB7IWSMG0Yx64WgYWEPNLY
	 q63FvnVcDhEuOnJtUTxM4acq+uSvH0lFZVFws/jJ2cpn5rBOgnaOZEc+lk/KBQzJnb
	 oA3KPXRNQGLKFaDlSzSSdL/QSOpAvk/kugEUuXfBxEV9w0eDZrS9MtUdiKT7WHPRhy
	 eBT5scmr8grww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 774723808209;
	Tue, 20 Oct 2026 09:10:10 +0000 (UTC)
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
Subject: Re: [PATCH net-next 0/4] mptcp: misc improvements for v7.4
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179248740902.3599760.12752617471968534331.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 09:10:09 +0000
References: 
 <20261013-net-next-mptcp-misc-feat-7-4-part2-v1-0-1181e5d2fda4@kernel.org>
In-Reply-To: 
 <20261013-net-next-mptcp-misc-feat-7-4-part2-v1-0-1181e5d2fda4@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 cpaasch@openai.com, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, liuhangbin@kylinos.cn, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 13 Oct 2026 19:56:37 +0200 you wrote:
> Here are some unrelated improvements for MPTCP and its selftests:
> 
> - Patches 1-2: avoid printing (pr_debug) uninitialised data. These are
>   non-urgent fixes that can be backported to silence errors or if it
>   helps with other backports.
> 
> - Patches 3-4: convert IPTables to NFTables in MPTCP selftests.
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] mptcp: options: mpc: avoid printing uninit data
    https://git.kernel.org/netdev/net-next/c/a234ee8eb9a2
  - [net-next,2/4] mptcp: options: dss: avoid printing uninit csum
    https://git.kernel.org/netdev/net-next/c/00e2690c9dad
  - [net-next,3/4] selftests: mptcp: convert iptables to nftables for mptcp_sockopt.sh
    https://git.kernel.org/netdev/net-next/c/d7add5f410ba
  - [net-next,4/4] selftests: mptcp: convert iptables to nftables for mptcp_join.sh
    https://git.kernel.org/netdev/net-next/c/be3b69f3cedf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


