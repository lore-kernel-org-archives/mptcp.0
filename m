Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E802110
	for <mptcp@lists.linux.dev>; Wed,  4 May 2022 10:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 114BDC385A5;
	Wed,  4 May 2022 10:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1651659022;
	bh=zDvw76BxQI3MQbdAGzNZ8trs1vRWg1EEZl+UBffaKTg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=prRUfWbzYc3g1O9u6Z1C+XqdVjqXLXRm2Tz34wxaz0fJnv/eZT7qVQrcwaIni95tF
	 vlAaHMD1s3BSLyXXpx0mfG7QTdaGop6l632WT/CWfwkv+zXj+VTk2d7cDKmTBJTn89
	 x94XIQiMiikO2irjY/lGxGTdwToYf/wBIFJ16OZ+5B8RrYH+svLUFcK7elOOmBzCXC
	 eXjsMislyOAzqhB1UOsjW2IqIKOh1OGDLEijs0VPRCtH6dfd/VRljywdrs0pqNa7ew
	 5NnnHzWf+OmZuG1Ryl53f76CRezylteA10vRz7ukJVqwOVvFh/PsOC+O4qot9/k5Fe
	 +ScSNEf6daL2g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F01FBE5D087;
	Wed,  4 May 2022 10:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/13] mptcp: Userspace path manager API
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <165165902197.16679.16863364849131368840.git-patchwork-notify@kernel.org>
Date: Wed, 04 May 2022 10:10:21 +0000
References: <20220504023901.277012-1-mathew.j.martineau@linux.intel.com>
In-Reply-To: <20220504023901.277012-1-mathew.j.martineau@linux.intel.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, matthieu.baerts@tessares.net,
 mptcp@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (master)
by David S. Miller <davem@davemloft.net>:

On Tue,  3 May 2022 19:38:48 -0700 you wrote:
> Userspace path managers (PMs) make use of generic netlink MPTCP events
> and commands to control addition and removal of MPTCP subflows on an
> existing MPTCP connection. The path manager events have already been
> upstream for a while, and this patch series adds four netlink commands
> for userspace:
> 
> * MPTCP_PM_CMD_ANNOUNCE: advertise an address that's available for
> additional subflow connections.
> 
> [...]

Here is the summary with links:
  - [net-next,01/13] mptcp: handle local addrs announced by userspace PMs
    https://git.kernel.org/netdev/net-next/c/4638de5aefe5
  - [net-next,02/13] mptcp: read attributes of addr entries managed by userspace PMs
    https://git.kernel.org/netdev/net-next/c/8b20137012d9
  - [net-next,03/13] mptcp: netlink: split mptcp_pm_parse_addr into two functions
    https://git.kernel.org/netdev/net-next/c/982f17ba1a25
  - [net-next,04/13] mptcp: netlink: Add MPTCP_PM_CMD_ANNOUNCE
    https://git.kernel.org/netdev/net-next/c/9ab4807c84a4
  - [net-next,05/13] selftests: mptcp: support MPTCP_PM_CMD_ANNOUNCE
    https://git.kernel.org/netdev/net-next/c/9a0b36509df0
  - [net-next,06/13] mptcp: netlink: Add MPTCP_PM_CMD_REMOVE
    https://git.kernel.org/netdev/net-next/c/d9a4594edabf
  - [net-next,07/13] selftests: mptcp: support MPTCP_PM_CMD_REMOVE
    https://git.kernel.org/netdev/net-next/c/ecd2a77d672f
  - [net-next,08/13] mptcp: netlink: allow userspace-driven subflow establishment
    https://git.kernel.org/netdev/net-next/c/702c2f646d42
  - [net-next,09/13] selftests: mptcp: support MPTCP_PM_CMD_SUBFLOW_CREATE
    https://git.kernel.org/netdev/net-next/c/cf8d0a6dfd64
  - [net-next,10/13] selftests: mptcp: support MPTCP_PM_CMD_SUBFLOW_DESTROY
    https://git.kernel.org/netdev/net-next/c/57cc361b8d38
  - [net-next,11/13] selftests: mptcp: capture netlink events
    https://git.kernel.org/netdev/net-next/c/b3e5fd653d39
  - [net-next,12/13] selftests: mptcp: create listeners to receive MPJs
    https://git.kernel.org/netdev/net-next/c/bdde081d728a
  - [net-next,13/13] selftests: mptcp: functional tests for the userspace PM type
    https://git.kernel.org/netdev/net-next/c/259a834fadda

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


