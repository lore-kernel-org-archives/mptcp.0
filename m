Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A58626
	for <mptcp@lists.linux.dev>; Thu, 13 Apr 2023 17:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF8C8C433D2;
	Thu, 13 Apr 2023 17:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681405818;
	bh=TTMPY+VYyqCQUJ6Kf3OMi0XvWsEMpitS3xIlaYntt/o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rNALsve5zDHrmp3o0aYNfmHMpYblt/hhzFFUmRj+5rvF9o6cdFXAq2IVoqHfBTqDd
	 AvXiIvPSABYQr1o47YBnhfI062hxDaVpltx+azxLFd2CMwLPggXGX3P4PN8UCtbW5c
	 vgSn0luMIByakBX8BAvgCB+Uqgw47gKiwMUynVVFny0RDJPFasFEnDJzQr89cZvOh4
	 gsJbT5JtR13DiX3Gt+FdyXHEpTtHXXqPZvjIQcaTJU/mlTya6SdfpPukNItplp2Cfs
	 oQu+mrd3iGpizzS+OOfAMsEUhds4wRDe6UDCoBW/gm9YHZdppH8cpbHPHavki6RUH+
	 agQD6/C5gfniA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BF7B1E21ED9;
	Thu, 13 Apr 2023 17:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4] mptcp: more fixes for 6.3
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168140581877.3344.4926518348735216178.git-patchwork-notify@kernel.org>
Date: Thu, 13 Apr 2023 17:10:18 +0000
References: <20230411-upstream-net-20230411-mptcp-fixes-v1-0-ca540f3ef986@tessares.net>
In-Reply-To: <20230411-upstream-net-20230411-mptcp-fixes-v1-0-ca540f3ef986@tessares.net>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dcaratti@redhat.com, dmytro@shytyi.net,
 shuah@kernel.org, martineau@kernel.org, geliang.tang@suse.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org, cpaasch@apple.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 11 Apr 2023 22:42:08 +0200 you wrote:
> Patch 1 avoids scheduling the MPTCP worker on a closed socket on some
> edge cases. It fixes issues that can be visible from v5.11.
> 
> Patch 2 makes sure the MPTCP worker doesn't try to manipulate
> disconnected sockets. This is also a fix for an issue that can be
> visible from v5.11.
> 
> [...]

Here is the summary with links:
  - [net,1/4] mptcp: use mptcp_schedule_work instead of open-coding it
    https://git.kernel.org/netdev/net/c/a5cb752b1257
  - [net,2/4] mptcp: stricter state check in mptcp_worker
    https://git.kernel.org/netdev/net/c/d6a044373343
  - [net,3/4] mptcp: fix NULL pointer dereference on fastopen early fallback
    https://git.kernel.org/netdev/net/c/c0ff6f6da66a
  - [net,4/4] selftests: mptcp: userspace pm: uniform verify events
    https://git.kernel.org/netdev/net/c/711ae788cbbb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


