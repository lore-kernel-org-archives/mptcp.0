Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34DCB67E;
	Tue, 18 Aug 2026 00:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787013670; cv=none; b=PR2LMKxFhYWpOZEFhsxyXGLe/UwCxLgFw+SKKrobGAYjf8QwgRKvCMHJd/MNv5cqt0Ve9AkXavOXq5AjC1XiBtN/0UewPx7rvzI9FxmazHvPnMdrZL1pKuECqHx0FTj4WZhBxGzdjCz8O8Dau4KWmhl0E1Gbj8U+P8/d2ou2TQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787013670; c=relaxed/simple;
	bh=9fMYnDDsYiJgWRR33BMJ8/GbO1x9Fix/42kWTLHAjCg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IwnLnlNl0Z5vmVz8vxDaGMYzTdWBXrH7/DZXMzRSHQeqOnPXlweeI8muvxlUZVksohc0/AZMPUKd6D+cYx/Lyd2Yfbdcx05zhxR0G24FwEcY1PWK78OS8KklpsOpxfJ3oz9ma9Q9139g8IpaWWiT2NCDpjq0pdFR/8U/pAdINKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOAuMA0F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOAuMA0F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B4291F000E9;
	Tue, 18 Aug 2026 00:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787013669;
	bh=1X5VG67df49Jj49wCdf/D8+ExtHuAzWPZSjmw/48vZs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=oOAuMA0FOlWmWIvP8GTVCRBRjoIP1Pbvydm1tRD++U+Fp2AMnzwcoeAbwvfuNYIPU
	 8muw0C4k9wCgtPWwKnkQ03t1R1JDL2dFvhKPSKhmKb1hnrD+TgOocvp5EbYv8ek4bg
	 dDcAEAiTt4PZsmnx1dcW8b+JdZOHQVFeNbSYpWJ6v9iBBsv9l7QQ+PFUEhAzZvSyXc
	 IolFKFg/U9G5iH4vU88og3pXNtzHhMB+P+yQuGBPVS3RdauQo/2qzEWpyqhKZyWUnC
	 A4Jf2nFkmtoTy6Trklo+105rcqYXAisJhSpBttZg4pHREAc8lWC7GMgYP9oKpevS6q
	 WNY2QxJU1SSRA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939F43926278;
	Tue, 18 Aug 2026 00:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/11] mptcp: misc. features for v7.3
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178701362114.1806156.7611412383996379895.git-patchwork-notify@kernel.org>
Date: Tue, 18 Aug 2026 00:40:21 +0000
References: 
 <20260812-net-next-mptcp-misc-feat-7-3-v1-0-1905a818f6cb@kernel.org>
In-Reply-To: 
 <20260812-net-next-mptcp-misc-feat-7-3-v1-0-1905a818f6cb@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 cuitao@kylinos.cn, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
 kalpan.jani@mpiricsoftware.com, shardul.b@mpiricsoftware.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, yijiangshan@kylinos.cn

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Aug 2026 16:55:35 +0200 you wrote:
> This series contains a few independent new features, and small fixes for
> net-next:
> 
> - Patch 1: Add WARN_ON_ONCE guards around extra_subflows to catch issues
>   with this counter, similar to what is done with other PM counters.
> 
> - Patches 2-3: Follow-up patches to remove data_ack field from struct
>   mptcp_ext -- now unused after recent fixes -- and makes a userspace PM
>   helper static.
> 
> [...]

Here is the summary with links:
  - [net-next,01/11] mptcp: pm: add WARN_ON_ONCE guards on extra_subflows underflow
    https://git.kernel.org/netdev/net-next/c/e99c1ca89071
  - [net-next,02/11] mptcp: remove unused data_ack from struct mptcp_ext
    https://git.kernel.org/netdev/net-next/c/91424c4513dd
  - [net-next,03/11] mptcp: pm: userspace: make remove_addr_entry static
    https://git.kernel.org/netdev/net-next/c/bb961fdd1700
  - [net-next,04/11] mptcp: honour configured min/max RTO in retransmit paths
    https://git.kernel.org/netdev/net-next/c/ea4eb2adb0d3
  - [net-next,05/11] mptcp: add per-event MIB counters for MPTCP_RST_EMPTCP resets
    https://git.kernel.org/netdev/net-next/c/3420c0fd7e5d
  - [net-next,06/11] selftests: mptcp: check per-event MPTCP_RST_EMPTCP counters
    https://git.kernel.org/netdev/net-next/c/1aa38a1581c4
  - [net-next,07/11] selftests: mptcp: connect: test name in pcap file
    https://git.kernel.org/netdev/net-next/c/158765a0e50d
  - [net-next,08/11] selftests: mptcp: simult_flow: test name in pcap file
    https://git.kernel.org/netdev/net-next/c/a574bd9b6101
  - [net-next,09/11] selftests: mptcp: pcap: drop most of the payload
    https://git.kernel.org/netdev/net-next/c/1d206e8e4371
  - [net-next,10/11] selftests: mptcp: fix const qualifier warnings in strchr usage
    https://git.kernel.org/netdev/net-next/c/f4a1b63ed520
  - [net-next,11/11] selftests: mptcp: diag: fix stack buffer overflow in get_subflow_info()
    https://git.kernel.org/netdev/net-next/c/6e5635a714c8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


