Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B4770
	for <mptcp@lists.linux.dev>; Fri, 26 Mar 2021 22:10:17 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id 07F4C61A2B;
	Fri, 26 Mar 2021 22:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1616796617;
	bh=gWJKmTMRA716KbO7g9u07UDcjg14ZIrEtd4DRFF4eoA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=R3Dd7qiSUq2nbDz56atTswiqIkJZ6ZUaeQeT0PNDqDGyWFm0L+EjDEYXNjbt/JyaR
	 y6HeQOTWnahfsMtwJ5e5KbDtJPSmnNVJW2DjAPTi47U0SEfUQfoK/r1DA4rFGzst+f
	 h8epH2L0n17uaSmABz7GyT6gN558j0Z9ZcKzwn8lFZpYNgotav8t7T5o6W6aTh4Cc6
	 5iOU0QzHGTE+OX2Fyr/+ZBG+uOsH9DgNrBY3i2kdAYTXbzBEOfrdBEXHgqnt8PMzrk
	 bw50/RhUR+iyDTCNYkjKFdXDk5WP9xNNpFpQSt8l8qHfgP+qEvXH541mhAwQN3p2Qn
	 rxzOK2ei3AAjw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C081A6096E;
	Fri, 26 Mar 2021 22:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/13] MPTCP: Cleanup and address advertisement fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <161679661678.26244.6014812864130596120.git-patchwork-notify@kernel.org>
Date: Fri, 26 Mar 2021 22:10:16 +0000
References: <20210326182307.136256-1-mathew.j.martineau@linux.intel.com>
In-Reply-To: <20210326182307.136256-1-mathew.j.martineau@linux.intel.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 matthieu.baerts@tessares.net, mptcp@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (refs/heads/master):

On Fri, 26 Mar 2021 11:23:07 -0700 you wrote:
> This patch series contains cleanup and fixes we have been testing in the
> MPTCP tree. MPTCP uses TCP option headers to advertise additional
> address information after an initial connection is established. The main
> fixes here deal with making those advertisements more reliable and
> improving the way subflows are created after an advertisement is
> received.
> 
> [...]

Here is the summary with links:
  - [net-next,01/13] mptcp: clean-up the rtx path
    https://git.kernel.org/netdev/net-next/c/2d6f5a2b5720
  - [net-next,02/13] mptcp: drop argument port from mptcp_pm_announce_addr
    https://git.kernel.org/netdev/net-next/c/f7efc7771eac
  - [net-next,03/13] mptcp: skip connecting the connected address
    https://git.kernel.org/netdev/net-next/c/d84ad04941c3
  - [net-next,04/13] mptcp: drop unused subflow in mptcp_pm_subflow_established
    https://git.kernel.org/netdev/net-next/c/62535200be17
  - [net-next,05/13] mptcp: move to next addr when timeout
    https://git.kernel.org/netdev/net-next/c/348d5c1dec60
  - [net-next,06/13] selftests: mptcp: add cfg_do_w for cfg_remove
    https://git.kernel.org/netdev/net-next/c/2e580a63b5c2
  - [net-next,07/13] selftests: mptcp: timeout testcases for multi addresses
    https://git.kernel.org/netdev/net-next/c/8da6229b9524
  - [net-next,08/13] mptcp: export lookup_anno_list_by_saddr
    https://git.kernel.org/netdev/net-next/c/d88c476f4a7d
  - [net-next,09/13] mptcp: move to next addr when subflow creation fail
    https://git.kernel.org/netdev/net-next/c/557963c383e8
  - [net-next,10/13] mptcp: drop useless addr_signal clear
    https://git.kernel.org/netdev/net-next/c/b65d95adb802
  - [net-next,11/13] mptcp: send ack for rm_addr
    https://git.kernel.org/netdev/net-next/c/8dd5efb1f91b
  - [net-next,12/13] mptcp: rename mptcp_pm_nl_add_addr_send_ack
    https://git.kernel.org/netdev/net-next/c/b46a02381093
  - [net-next,13/13] selftests: mptcp: signal addresses testcases
    https://git.kernel.org/netdev/net-next/c/ef360019db40

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


