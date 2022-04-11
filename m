Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8390C138A
	for <mptcp@lists.linux.dev>; Mon, 11 Apr 2022 11:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 34747C385A4;
	Mon, 11 Apr 2022 11:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1649675414;
	bh=90YLOsi47e1MDfjEWlCaOjyLzy1CntUJzLUKCG8ODYg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Aae7WZf30Ie9DAbbQ2GZE6BgvgFRft6ia5dBLKiXPI824tJ0cqbzDcnsz1jJcUzRQ
	 h+prQyyr24C/vLhtTzzc1UXEZTmh143e1+7QvaYJLWX4xJIp5yc24RtbdfIUOdcxJp
	 GLufVlVOoPLhEMXkaDZUeGPZ/hHAZWkqdeTTQifqosrNHaCmJ9S9fbQWiFPUh+wWHk
	 Q75X+JuMZQwoawO60ceDilK6ODEd3mJJ++f64E2Ld0RgodjNy8VxA8LjsdwLdscsvl
	 IMk5MMxbfOJweroXkVvXZNZivv2WXEXmm5Tq/IyKZAUpLJ8tupnN7A3FiiS5h9Ezc6
	 Z13y0wwvXW/+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1D518E85B76;
	Mon, 11 Apr 2022 11:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/8] mptcp: Miscellaneous changes for 5.19
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <164967541411.25321.8414956012124589263.git-patchwork-notify@kernel.org>
Date: Mon, 11 Apr 2022 11:10:14 +0000
References: <20220408194601.305969-1-mathew.j.martineau@linux.intel.com>
In-Reply-To: <20220408194601.305969-1-mathew.j.martineau@linux.intel.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, matthieu.baerts@tessares.net, mptcp@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (master)
by David S. Miller <davem@davemloft.net>:

On Fri,  8 Apr 2022 12:45:53 -0700 you wrote:
> Four separate groups of patches here:
> 
> Patch 1 optimizes flag checking when releasing mptcp socket locks.
> 
> Patches 2 and 3 update the packet scheduler when subflow priorities
> change.
> 
> [...]

Here is the summary with links:
  - [net-next,1/8] mptcp: optimize release_cb for the common case
    https://git.kernel.org/netdev/net-next/c/65a569b03ca8
  - [net-next,2/8] mptcp: reset the packet scheduler on incoming MP_PRIO
    https://git.kernel.org/netdev/net-next/c/43f5b111d1ff
  - [net-next,3/8] mptcp: reset the packet scheduler on PRIO change
    https://git.kernel.org/netdev/net-next/c/0e203c324752
  - [net-next,4/8] mptcp: add pm_nl_pernet helpers
    https://git.kernel.org/netdev/net-next/c/c682bf536cf4
  - [net-next,5/8] mptcp: diag: switch to context structure
    https://git.kernel.org/netdev/net-next/c/6b9ea5c81ea2
  - [net-next,6/8] mptcp: remove locking in mptcp_diag_fill_info
    https://git.kernel.org/netdev/net-next/c/e8887b716142
  - [net-next,7/8] mptcp: listen diag dump support
    https://git.kernel.org/netdev/net-next/c/4fa39b701ce9
  - [net-next,8/8] selftests/mptcp: add diag listen tests
    https://git.kernel.org/netdev/net-next/c/f2ae0fa68e28

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


