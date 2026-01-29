Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C51D290D81;
	Thu, 29 Jan 2026 05:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769663423; cv=none; b=Ii0j7WKAGWQbyq2YI9PDPnxbYmnJyAMOCpinRYP5F71kYF/wm4j23nprJhZIgRpJVHioKYC08Hr9zexTXwr9ioyFQUj8gWCcMTBLL18o7bNmfLRlSig+Xbg7s65lbiKxevlEFDS2Numb5AN4TX67S4qhOBPrf0AtVSsjh+/gmWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769663423; c=relaxed/simple;
	bh=7z2IQ7btc5Et00y2/fhUHitAb0l+Sdb5VtOcz51uMKA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iWh8Qz1GLeaZInAmdFixCMIY4jIZajIPzvaTGaH84CqS5NNOQAKokX2XaMJ/WxgfRKZwLwNswBmtdcJHKFvD6R4Hiqtt4Sr8WOFW2I7eeodKZE2mIRbRad3YqBiF0hLJFgED9t5E+gW9QPfisgYm8t3qMbS0+ToZK3O6TI75DE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qXzdGaYV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXzdGaYV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5407C116D0;
	Thu, 29 Jan 2026 05:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769663422;
	bh=7z2IQ7btc5Et00y2/fhUHitAb0l+Sdb5VtOcz51uMKA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qXzdGaYVGCUmaZuiBfoPf7kAeA+v0/ECquDYoyQxqqkDyIK/alYxe375Qreodq8vo
	 anjE08MOz0dAnbepU5fgbbL++vNOlA9U7Os5BwvDWoVfUSVZPo2OPlIiQ6sE6Osp96
	 hHcnmH1/nyEL9VbL2ompLIQcXysbaYyr6HE9egNZDW6/v/LIR2c8NEdXXxQAOSUAdy
	 wOyDS/ILSD99m9xbylCDpPGiKABtHWYc2ZCvsbQZuyELJV/g0N0fRdyNxVqwPVKhLD
	 FO6sbNjzNPicPRKv2voZnX0YRusCXzmbUthrukGXkRVJS1cAS3tbHxxhsQMEkphgYd
	 psqnLYDN785iw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 11A4E380AA69;
	Thu, 29 Jan 2026 05:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5] mptcp: avoid dup NL events and propagate error
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176966341585.2355196.1619926866071814475.git-patchwork-notify@kernel.org>
Date: Thu, 29 Jan 2026 05:10:15 +0000
References: <20260127-net-mptcp-dup-nl-events-v1-0-7f71e1bc4feb@kernel.org>
In-Reply-To: <20260127-net-mptcp-dup-nl-events-v1-0-7f71e1bc4feb@kernel.org>
To: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 shuah@kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 stable@vger.kernel.org, marco.angaroni@italtel.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 27 Jan 2026 20:27:22 +0100 you wrote:
> Here are two fixes affecting the MPTCP Netlink events with their tests:
> 
> - Patches 1 & 2: a subflow closed NL event was visible multiple times in
>   some specific conditions. A fix for v5.12.
> 
> - Patches 3 & 4: subflow closed NL events never contained the error
>   code, even when expected. A fix for v5.11.
> 
> [...]

Here is the summary with links:
  - [net,1/5] mptcp: avoid dup SUB_CLOSED events after disconnect
    https://git.kernel.org/netdev/net/c/280d654324e3
  - [net,2/5] selftests: mptcp: check no dup close events after error
    https://git.kernel.org/netdev/net/c/8467458dfa61
  - [net,3/5] mptcp: only reset subflow errors when propagated
    https://git.kernel.org/netdev/net/c/dccf46179ddd
  - [net,4/5] selftests: mptcp: check subflow errors in close events
    https://git.kernel.org/netdev/net/c/2ef9e3a3845d
  - [net,5/5] selftests: mptcp: join: fix local endp not being tracked
    https://git.kernel.org/netdev/net/c/c5d5ecf21fdd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


