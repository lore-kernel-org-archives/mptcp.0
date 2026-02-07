Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1C51A317D;
	Sat,  7 Feb 2026 04:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770439816; cv=none; b=YBlc4DwrcrwKXsx4Juqm9FRTXFUNBLtBDG/LTPP1iOFOz8ZVcHTy/oQTMSvfBDbH5vBwXsCVKY2AGvQwZ6mzKVQer2sAEldXHyETNGGIacLWAYMVKZfEqPx0I1ZDqRQjlRnSPqBpGYqFI9f0zt0di6zpqUUFSPjbSVfiog3cKLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770439816; c=relaxed/simple;
	bh=RbjnpCRBz/joWNnZAwlbdcxzZ4XP5m+7Tl7jS5Zn9cg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Yg6B7i8FHTIcJt+7O+GvbTvE1CG1vgZoyvXXfPK1WwuqwjYCGKY2twAq6CISu2XIprT+dVumTpZqePo+RA1zShbOxnz8wImlvVCUJVshFzuvXyXqLOjEiEZSrr3AUFRaqLOVSgOKbC6giRVPqyAPzEY7V+XQNbkq2M41Fk3uhSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQEbYzxk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQEbYzxk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1749CC116D0;
	Sat,  7 Feb 2026 04:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770439816;
	bh=RbjnpCRBz/joWNnZAwlbdcxzZ4XP5m+7Tl7jS5Zn9cg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hQEbYzxkrVaIAJnuJSoFbgo+cqnWwHVKoogIxWTCURpTStQFVSK0122SWF/+w3Y0g
	 66zUmNpXi8u74hQBPR6aZTFKPf5NWyC7YYcwRtvYIy9urbYoXXIz1rabqMN36evZeD
	 bqMjAAa0aXnpXuUDPEdXVTEbFn/+l0uBmW3EG3YoBmnSd1xKOIwKbpjAiEwN4GXc+3
	 1urBDdKm6cZfklvbOOXZDp8ZK6nevzoP4i6a/Xhr4FOHSz2BHOlaks1uF/4J0xhs6E
	 u01JOckYlQBmgicZupP6KzltKkvxQz1V+9WVv1o5393cRxR2ZoAtH7UGu2KKnxj8fR
	 sKit8CgYH6Utg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4822A3809A1A;
	Sat,  7 Feb 2026 04:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/4] mptcp: misc fixes for v6.19-rc8
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177043981283.1190979.6764422355928072204.git-patchwork-notify@kernel.org>
Date: Sat, 07 Feb 2026 04:50:12 +0000
References: 
 <20260205-net-mptcp-misc-fixes-6-19-rc8-v2-0-c2720ce75c34@kernel.org>
In-Reply-To: 
 <20260205-net-mptcp-misc-fixes-6-19-rc8-v2-0-c2720ce75c34@kernel.org>
To: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,
 syzbot+f56f7d56e2c6e11a01b6@syzkaller.appspotmail.com, rdunlap@infradead.org,
 donald.hunter@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 05 Feb 2026 18:34:20 +0100 you wrote:
> Here are various unrelated fixes:
> 
> - Patch 1: when removing an MPTCP in-kernel PM endpoint, always mark the
>   corresponding ID as "available". Syzbot found a corner case where it
>   is not marked as such. A fix for up to v5.10.
> 
> - Patch 2: Linked to the previous patch, the variable name was confusing
>   and was probably partly responsible for the issue fixed by patch 1. No
>   "Fixes" tag: no need to backport that for the moment, but better to
>   avoid confusion now.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/4] mptcp: pm: in-kernel: always set ID as avail when rm endp
    https://git.kernel.org/netdev/net/c/d191101dee25
  - [net,v2,2/4] mptcp: pm: in-kernel: clarify mptcp_pm_remove_anno_addr()
    https://git.kernel.org/netdev/net/c/364a7084df9f
  - [net,v2,3/4] mptcp: fix kdoc warnings
    https://git.kernel.org/netdev/net/c/136f1e168f49
  - [net,v2,4/4] selftests: mptcp: connect: fix maybe-uninitialize warn
    https://git.kernel.org/netdev/net/c/53e553369167

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


