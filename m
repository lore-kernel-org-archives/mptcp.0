Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8DA168
	for <mptcp@lists.linux.dev>; Thu,  1 Jul 2021 20:20:06 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id 6096961413;
	Thu,  1 Jul 2021 20:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1625170806;
	bh=TUVhklT/xjt4zdDKvKO+m5xDknT/3YR3U7sTw0WVLCk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=b9+yHFyWNShIqPvuhfP15H0F1GyQFdm5xxc+lZKX+9RteB84z9+BQF2IEJlbm6OPr
	 eNFPvthjO4+wthUjY3E+2HiPeap+kMvNd5FtcjVDhCNbi31BlsLL+4UX98p1Umg5oh
	 rFQSrKXkb+pX0qfi/0O8Srbtyu7Te75IKhSv/HI/U1pg/z1t0Cc4ISLVXn/7jI6b2t
	 gpf5x0g/2fVU5xPNs9II3NY5hnW141E5aOCvs2UMPifTAx9SG9AeHcbk8hmqXNHpa9
	 PvkHq2e7fUqNNFOE/X/qtxgdQgD7tWoV/oS8Shs0b/vJpH5lxvb0305Ej6YGpJex2p
	 FtriZEpAlkNQQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4C113609F7;
	Thu,  1 Jul 2021 20:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next, v5, 00/11] ptp: support virtual clocks and timestamping
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <162517080630.9938.6469533434370383699.git-patchwork-notify@kernel.org>
Date: Thu, 01 Jul 2021 20:20:06 +0000
References: <20210630081202.4423-1-yangbo.lu@nxp.com>
In-Reply-To: <20210630081202.4423-1-yangbo.lu@nxp.com>
To: Y.b. Lu <yangbo.lu@nxp.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, mptcp@lists.linux.dev,
 richardcochran@gmail.com, davem@davemloft.net, kuba@kernel.org,
 mathew.j.martineau@linux.intel.com, matthieu.baerts@tessares.net,
 shuah@kernel.org, mkubecek@suse.cz, f.fainelli@gmail.com, andrew@lunn.ch,
 rui.sousa@nxp.com, sebastien.laveze@nxp.com

Hello:

This series was applied to netdev/net.git (refs/heads/master):

On Wed, 30 Jun 2021 16:11:51 +0800 you wrote:
> Current PTP driver exposes one PTP device to user which binds network
> interface/interfaces to provide timestamping. Actually we have a way
> utilizing timecounter/cyclecounter to virtualize any number of PTP
> clocks based on a same free running physical clock for using.
> The purpose of having multiple PTP virtual clocks is for user space
> to directly/easily use them for multiple domains synchronization.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,01/11] ptp: add ptp virtual clock driver framework
    https://git.kernel.org/netdev/net/c/5d43f951b1ac
  - [net-next,v5,02/11] ptp: support ptp physical/virtual clocks conversion
    https://git.kernel.org/netdev/net/c/73f37068d540
  - [net-next,v5,03/11] ptp: track available ptp vclocks information
    https://git.kernel.org/netdev/net/c/44c494c8e30e
  - [net-next,v5,04/11] ptp: add kernel API ptp_get_vclocks_index()
    https://git.kernel.org/netdev/net/c/acb288e8047b
  - [net-next,v5,05/11] ethtool: add a new command for getting PHC virtual clocks
    https://git.kernel.org/netdev/net/c/c156174a6707
  - [net-next,v5,06/11] ptp: add kernel API ptp_convert_timestamp()
    https://git.kernel.org/netdev/net/c/895487a3a10f
  - [net-next,v5,07/11] mptcp: setsockopt: convert to mptcp_setsockopt_sol_socket_timestamping()
    https://git.kernel.org/netdev/net/c/6c9a0a0f2333
  - [net-next,v5,08/11] net: sock: extend SO_TIMESTAMPING for PHC binding
    https://git.kernel.org/netdev/net/c/d463126e23f1
  - [net-next,v5,09/11] net: socket: support hardware timestamp conversion to PHC bound
    https://git.kernel.org/netdev/net/c/d7c088265588
  - [net-next,v5,10/11] selftests/net: timestamping: support binding PHC
    https://git.kernel.org/netdev/net/c/2214d7032479
  - [net-next,v5,11/11] MAINTAINERS: add entry for PTP virtual clock driver
    https://git.kernel.org/netdev/net/c/5ce15f278333

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


